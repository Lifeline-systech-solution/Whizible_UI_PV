#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class SR_MilestoneSlippageReminder
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Page Name 	        : SR_MilestoneSlippageReminder.aspx
    ' Purpose				: Displaying Milestones having Slippage and Sending
    '                          Reminders to the current PM of those Projects
    ' Description			:	
    ' Assumptions			:	
    ' Dependencies			:	
    ' Author                : Noble K
    ' Created               : 01st Mar, 2006
    ' Revisions				:	
    '=====================================================================

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

#Region "Member Variables"
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.

    Private m_strPageHeader As String = "Milestone Slippage Reminders"
    Private m_strProjectID As String
    Private m_strProjectName As String
    Private m_strLoggedUserID As String

    Private MAIL_SUBJECT As String
    Private MAIL_BODY As String
    Private Const TAG_ID As String = "3580"
    Private Const MILESTONE_SLIPPAGE_MSGID As String = "458"

    Private m_strMailBody As New System.Text.StringBuilder
#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
#End Region

#Region "Functions & Procedures"
    Private Sub Initializations()
        '====================================================================
        ' Procedure Name        : Initializations
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Do the Page Level initializations
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Noble K
        ' Created               : 01st Mar, 2006
        ' Revisions             :
        '=====================================================================
        Dim strProjectNameQuery, strEmailMessage As String
        Dim drProjectName, drEmailMessage As IDataReader

        'Getting the logged in userid
        m_strLoggedUserID = Session("intUserID").ToString

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "") <> "" Then
            m_strProjectID = Request.QueryString("ProjectID")
            ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
            ''strProjectNameQuery = "SELECT ProjectName FROM tbl_PM_Project WHERE ProjectID = " & m_strProjectID
            strProjectNameQuery = "usp_sel_tbl_PM_Project_Name " & m_strProjectID
            drProjectName = CommonFunctions.Data.GetDataReader(strProjectNameQuery, MyBase.UseSQL)
            Do While drProjectName.Read
                m_strProjectName = drProjectName("ProjectName").ToString
            Loop
            CommonFunctions.Data.DisposeDataReader(drProjectName)
        Else
            m_strProjectID = ""
        End If

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "SendReminder" Then
            'Getting the Email Message
            ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
            ''strEmailMessage = "SELECT * FROM tbl_PM_EmailMessages WHERE MsgID = " & MILESTONE_SLIPPAGE_MSGID
            strEmailMessage = "usp_sel_tbl_PM_EmailMessages_MsgID " & MILESTONE_SLIPPAGE_MSGID
            drEmailMessage = CommonFunctions.Data.GetDataReader(strEmailMessage, MyBase.UseSQL)
            Do While drEmailMessage.Read
                MAIL_SUBJECT = drEmailMessage("Subject").ToString
                MAIL_BODY = drEmailMessage("Body").ToString
            Loop
            CommonFunctions.Data.DisposeDataReader(drEmailMessage)

            SendReminderMail()
        End If
    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Noble K
        ' Created               : 01st Mar, 2006
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Noble K
        ' Created               : 01st Mar, 2006
        ' Revisions             :
        '=====================================================================

        Dim arrMenu() As String = {"?"}

        Dim arrMenuToolTip() As String = {"Help"}

        Dim arrClientSideFunction() As String = {"Help_OnClick(" & TAG_ID & ")"}

        Dim strGrid As String

        'cerate the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)

    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Noble K
        ' Created               : 01st Mar, 2006
        ' Revisions             :
        '=====================================================================

        Response.Write(PageCaption.GetPageCaptions(m_objGlobal, m_strPageHeader, , , True))
        Response.Write("<BR>")

    End Sub

    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Noble K
        ' Created               : 01st Mar, 2006
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(m_strPageHeader)
        End If
        objHeader = Nothing

    End Sub

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Noble K
        ' Created               : 01st Mar, 2006
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing
        m_strMailBody = Nothing
    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Noble K
        ' Created               : 01st Mar, 2006
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here

        'This will initialize all the global objects.

        GetGlobalObject()

        'Doing all the initializations
        Initializations()

        DrawPage()

        DisposeObjects()
    End Sub

    Private Sub DrawPage()
        '====================================================================
        ' Procedure Name        : DrawPage
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure draws the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Noble K
        ' Created               : 01st Mar, 2006
        ' Revisions             :
        '=====================================================================
        'This will strore the constructed menu string in a string variable. 
        DrawMenu()

        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'Display the page caption.
        DrawPageCaption()
        'Display the Header if exist. 
        DrawHeader()
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE class='clsTable' width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TR class='clsTREven' width='100%'>")
        CommonFunctions.General.WriteHTML("<TD width='100%'>")
        CommonFunctions.General.WriteHTML("<I>Note: Mails will be send to all the Active PMs as on Date for the Selected Project And the Logged in User.</I>")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")

        Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")

        'Drawing the Grid displaying the slippages
        DrawGrid()

        HttpContext.Current.Response.Write("</DIV>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
    End Sub

    Private Sub DrawGrid()
        '====================================================================
        ' Procedure Name        : DrawGrid
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure draws the Grid
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Noble K
        ' Created               : 01st Mar, 2006
        ' Revisions             :
        '=====================================================================
        Dim strSPForGrid As String = "usp_Sel_Milestone_Slippage_report"
        Dim strPrevProjectID As String = ""
        Dim strProjectID As String = ""
        Dim blnFirstRecord As Boolean
        Dim intRecordCount As Integer = 0

        Dim drSPForGrid As IDataReader

        'Added on 07th Mar, 2006 for Role Level access of Projects
        Dim intRoleLevel As Integer
        Dim m_strProjectFilters As String = ""
        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        m_strProjectFilters = ""
        'If middle level then apply filter for Projects
        If intRoleLevel = 2 Then
            'Apply Role Access Filter for Project List
            m_strProjectFilters = ""
            Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            If strFilter <> "" Then
                m_strProjectFilters += strFilter
            End If
            m_strProjectFilters = m_strProjectFilters.Replace("'", "")
            strSPForGrid = strSPForGrid & " NULL, '" & m_strProjectFilters & "'"
        End If
        'End of Addition By Noble K on 07th Mar, 2006

        drSPForGrid = CommonFunctions.Data.GetDataReader(strSPForGrid, MyBase.UseSQL)

        Do While drSPForGrid.Read
            strProjectID = drSPForGrid("ProjectID").ToString
            intRecordCount = intRecordCount + 1
            If intRecordCount > 1 Then
                If strProjectID <> strPrevProjectID Then
                    CommonFunctions.General.WriteHTML("</TABLE>")
                    CommonFunctions.General.WriteHTML("</DIV>")
                End If
            End If
            Dim objProjectSectionHeader As New WebPage.Templates.SectionTitle
            If strProjectID <> strPrevProjectID Then
                With objProjectSectionHeader
                    .GetSectionTitle("<B>" & drSPForGrid("ProjectName").ToString & "</B>", "divMilestones" & strProjectID, "divMilestones" & strProjectID & "_ShowHide", , "&nbsp;|&nbsp;" & "<a class='Menu' Title='Send Reminder' href='javascript:SendReminder_OnClick(" + strProjectID + ")'>Send Reminder</a>" & "&nbsp;|&nbsp;", , , , "Hide Details", "Show Details")
                    CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")
                    CommonFunctions.General.WriteHTML(.ClientsideScript)
                    CommonFunctions.General.WriteHTML("</SCRIPT>")
                End With
                CommonFunctions.General.WriteHTML("<DIV id='divMilestones" & strProjectID & "' style='Overflow:auto;width:100%'>")
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                CommonFunctions.General.WriteHTML("<TABLE class='clsGridTable' width='99.9%' cellspacing=1; cellpadding=0>")
                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader' width='100%'>")
                CommonFunctions.General.WriteHTML("<TD width='50%' align='left'> Milestone </TD>")
                CommonFunctions.General.WriteHTML("<TD width='20%' align='center'> Planned Completion Date </TD>")
                CommonFunctions.General.WriteHTML("<TD width='20%' align='center'> Actual Completion Date </TD>")
                CommonFunctions.General.WriteHTML("<TD width='10%' align='center'> Slippage (Days) </TD>")
                CommonFunctions.General.WriteHTML("</TR>")
                CommonFunctions.General.WriteHTML("<TR class='clsTREven' width='100%'>")
                CommonFunctions.General.WriteHTML("<TD width='50%'>" & drSPForGrid("Milestone").ToString & "</TD>")
                CommonFunctions.General.WriteHTML("<TD width='20%'align='center'>" & CommonFunctions.Dates.GetDate(CType(drSPForGrid("PlannedCompletionDate"), Date)) & "</TD>")
                CommonFunctions.General.WriteHTML("<TD width='20%'align='center'>" & CommonFunctions.Dates.GetDate(CType(drSPForGrid("ActualEndDate"), Date)) & "</TD>")
                CommonFunctions.General.WriteHTML("<TD width='10%' align='right'>" & drSPForGrid("Slippage").ToString & "</TD>")
                CommonFunctions.General.WriteHTML("</TR>")
            Else
                CommonFunctions.General.WriteHTML("<TR class='clsTREven' width='100%'>")
                CommonFunctions.General.WriteHTML("<TD width='50%'>" & drSPForGrid("Milestone").ToString & "</TD>")
                CommonFunctions.General.WriteHTML("<TD width='20%'align='center'>" & CommonFunctions.Dates.GetDate(CType(drSPForGrid("PlannedCompletionDate"), Date)) & "</TD>")
                CommonFunctions.General.WriteHTML("<TD width='20%'align='center'>" & CommonFunctions.Dates.GetDate(CType(drSPForGrid("ActualEndDate"), Date)) & "</TD>")
                CommonFunctions.General.WriteHTML("<TD width='10%' align='right'>" & drSPForGrid("Slippage").ToString & "</TD>")
                CommonFunctions.General.WriteHTML("</TR>")
            End If
            strPrevProjectID = strProjectID
            objProjectSectionHeader = Nothing
        Loop
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.General.WriteHTML("</DIV>")

        CommonFunctions.Data.DisposeDataReader(drSPForGrid)
    End Sub

    Private Sub SendReminderMail()
        '====================================================================
        ' Procedure Name        : SendReminderMail
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure Sends the mail
        ' Description           : Same as above
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Noble K
        ' Created               : 02nd Mar, 2006
        ' Revisions             :
        '=====================================================================
        Dim strSubject As String = ""
        Dim strToList As String = ""
        Dim strCCList As String = ""
        Dim strToNamesList As String = ""
        Dim strFromName As String = ""

        Dim strToListSP As String
        Dim strCCListSP As String

        Dim drToListSP As IDataReader

        'strSubject = Replace(MAIL_SUBJECT, "<PROJECT_NAME>", m_strProjectName)
        strSubject = Replace(MAIL_SUBJECT, "<PROJECT_NAME>", m_strProjectName)

        'Getting the List of all active PMs
        strToListSP = "usp_Sel_Project_PM_EmailIDs " & m_strProjectID
        drToListSP = CommonFunctions.Data.GetDataReader(strToListSP, MyBase.UseSQL)
        Do While drToListSP.Read
            strToList = strToList & drToListSP("EmailID").ToString & ";"
            strToNamesList = strToNamesList & drToListSP("EmployeeName").ToString & ","
        Loop

        CommonFunctions.Data.DisposeDataReader(drToListSP)

        'Getting the userid of the logged in user and assigning to the CCList
        strCCListSP = "usp_Sel_Project_PM_EmailIDs NULL, " & m_strLoggedUserID
        drToListSP = CommonFunctions.Data.GetDataReader(strCCListSP, MyBase.UseSQL)
        Do While drToListSP.Read
            strCCList = drToListSP("EmailID").ToString
            strFromName = drToListSP("EmployeeName").ToString
        Loop
        CommonFunctions.Data.DisposeDataReader(drToListSP)

        'This part is just for testing an should be removed
        If strToList.Length <= 1 Then
            strToList = strCCList
        Else
            strToList = strToList & strCCList
        End If

        If strToNamesList.Length <= 1 Then
            strToNamesList = strFromName
        Else
            strToNamesList = strToNamesList & strFromName
        End If

        'Make the Body of the mail
        ConstructMailBody(strToNamesList, strFromName)

        'strCCList contains the emailid of logged in user.
        CommonFunction.Emails.SendEmail(strToList, strCCList, strSubject, m_strMailBody.ToString)
    End Sub

    Private Sub ConstructMailBody(ByVal strTo As String, ByVal strFrom As String)
        '====================================================================
        ' Procedure Name        : ConstructMailBody
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure constructs the Body of the mail
        ' Description           : Same as above
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Noble K
        ' Created               : 02nd Mar, 2006
        ' Revisions             :
        '=====================================================================
        'Make the Body of the mail
        Dim strSPForBody As String = "usp_Sel_Milestone_Slippage_report " & m_strProjectID
        Dim drSPForBody As IDataReader

        Dim strBodyTabularData As New System.Text.StringBuilder

        drSPForBody = CommonFunctions.Data.GetDataReader(strSPForBody, MyBase.UseSQL)

        With strBodyTabularData
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            .Append("<TABLE class='clsGridTable' width ='99.9%' border='0' cellspacing=1; cellpadding=0 style='FONT-SIZE: x-small;FONT-FAMILY: Verdana'>" & vbCrLf)
            .Append("<TR class='clsTRColumnHeader' width = '100%'>" & vbCrLf)
            .Append("<TD width='50%' align='left'> Milestone </TD>" & vbCrLf)
            .Append("<TD width='20%' align='center'> Planned Completion Date </TD>" & vbCrLf)
            .Append("<TD width='20%' align='center'> Actual Completion Date </TD>" & vbCrLf)
            .Append("<TD width='10%' align='center'> Slippage (Days) </TD>" & vbCrLf)
            .Append("</TR>")
            Do While drSPForBody.Read
                .Append("<TR class='clsTREven' width='100%'>")
                .Append("<TD width='50%' align='left'>" & drSPForBody("Milestone").ToString & "</TD>" & vbCrLf)
                .Append("<TD width='20%'align='center'>" & CommonFunctions.Dates.GetDate(CType(drSPForBody("PlannedCompletionDate"), Date)) & "</TD>" & vbCrLf)
                .Append("<TD width='20%'align='center'>" & CommonFunctions.Dates.GetDate(CType(drSPForBody("ActualEndDate"), Date)) & "</TD>" & vbCrLf)
                .Append("<TD width='10%' align='right'>" & drSPForBody("Slippage").ToString & "</TD>" & vbCrLf)
                .Append("</TR>")
            Loop
            .Append("</TABLE> " & vbCrLf)
        End With

        CommonFunctions.Data.DisposeDataReader(drSPForBody)

        With m_strMailBody
            .Append("<HTML>" & vbCrLf)
            .Append("<HEAD>" & vbCrLf)
            .Append("<STYLE>" & vbCrLf)
            .Append("Table.clsGridTable" & vbCrLf)
            .Append("{" & vbCrLf)
            .Append("FONT-SIZE: 10pt;" & vbCrLf)
            .Append("FONT-FAMILY: Verdana, Arial;" & vbCrLf)
            .Append("BACKGROUND-COLOR: #AEAEAE;" & vbCrLf)
            .Append("border :1;" & vbCrLf)
            .Append("}" & vbCrLf)
            .Append("TR.clsTREven " & vbCrLf)
            .Append("{" & vbCrLf)
            .Append("padding-right: 2pt;" & vbCrLf)
            .Append("padding-left: 2pt;" & vbCrLf)
            .Append("font-size: 8pt;" & vbCrLf)
            .Append("padding-bottom: 2pt;" & vbCrLf)
            .Append("margin: 2pt;" & vbCrLf)
            .Append("color: #000000;" & vbCrLf)
            .Append("padding-top: 2pt;" & vbCrLf)
            .Append("background-repeat: repeat;" & vbCrLf)
            .Append("font-family: Verdana, Arial;" & vbCrLf)
            .Append("height: 18px;" & vbCrLf)
            .Append("background-color: white;" & vbCrLf)
            .Append("}" & vbCrLf)
            .Append("TR.clsTRColumnHeader" & vbCrLf)
            .Append("{" & vbCrLf)
            .Append("PADDING-RIGHT: 2pt;" & vbCrLf)
            .Append("PADDING-LEFT: 2pt;" & vbCrLf)
            .Append("FONT-SIZE: 8pt;" & vbCrLf)
            .Append("BACKGROUND-IMAGE: none;" & vbCrLf)
            .Append("PADDING-BOTTOM: 2pt;" & vbCrLf)
            .Append("MARGIN: 2pt;" & vbCrLf)
            .Append("COLOR: #000000;" & vbCrLf)
            .Append("PADDING-TOP: 2pt;" & vbCrLf)
            .Append("BACKGROUND-REPEAT: repeat;" & vbCrLf)
            .Append("FONT-FAMILY: Verdana, Arial;" & vbCrLf)
            .Append("BACKGROUND-COLOR: #BED5F5" & vbCrLf)
            .Append("}" & vbCrLf)
            .Append("</STYLE>" & vbCrLf)
            .Append("</HEAD>" & vbCrLf)
            .Append("<BODY style='FONT-SIZE: x-small;FONT-FAMILY: Verdana'>" & vbCrLf)
            .Append(Replace(Replace(Replace(MAIL_BODY, "<NAME>", strTo), "<SENDER>", strFrom), "<TABULAR_DATA>", strBodyTabularData.ToString) & vbCrLf)
            .Append("</BODY>" & vbCrLf)
            .Append("</HTML>" & vbCrLf)
        End With
    End Sub

#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

End Class
