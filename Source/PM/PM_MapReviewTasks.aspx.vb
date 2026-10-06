Public Class PM_MapReviewTasks
    Inherits WebPage.Templates.WhizTemplate

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
    '=====================================================================
    ' Page Name             : PM_MapReviewTasks
    ' Purpose               : Mapping Review tasks to Mpp tasks.
    ' Description           : 
    ' Parameters Passed     : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : AbhijeetD
    ' Created               : Feb 24th, 2004
    ' Revisions             : 
    '=====================================================================
    Private Const PROJECT_SPECIFIC_TASKS As String = "M"

    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private m_strPageType As String = ""
    Private m_strclsTRColHeader As String = "'clsTRColumnHeader'"
    Private m_strClsTREven As String = "'clsTREven'"
    Private m_strClsTROdd As String = "'clsTROdd'"
    Private m_blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

    Private m_strReviewStatisticsID As String
    Private m_strAction As String
    Private m_strEmployeeID As String
    Private m_strEmployeeType As String
    Private m_strReviewee As String = ""
    Private m_strRevieweeID As String = ""
    Private m_strTaskID As String = ""
    Private m_strTaskName As String = ""
    Private m_strReviewerID As String = ""
    Private m_strReviewer As String = ""
    Private m_strPrevTaskID As String
    Private m_strUserName As String


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Retrieve parameters from query string
        m_strReviewStatisticsID = Request.QueryString("ReviewStatisticsID")
        m_strPageType = Request.QueryString("PageType")
        m_strEmployeeID = Request.QueryString("EmployeeID")
        m_strEmployeeType = Request.QueryString("EmployeeType")
        m_strAction = Request.QueryString("Action")

        'Retrieve parameters from session 
        m_strUserName = Session("strUserName").ToString

        'Store the ReviewStatisticID, EmployeeType, EmployeeID inside a hidden control
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("hdReviewStatisticsID", "hdReviewStatisticsID", , , , m_strReviewStatisticsID, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("hdEmployeeType", "hdEmployeeType", , , , m_strEmployeeType, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("hdEmployeeID", "hdEmployeeID", , , , m_strEmployeeID, , , , , , True, EnableHTMLEncode:=True)

        'Render a hidden control for action: used for identifying the action to be taken after postback
        CommonFunction.HTMLControls.DrawTextBox("hdAction", "hdAction", , , , , , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        ''Added  By Shamkant s 31/12/2015
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        'Ended By Shamkant s 31/12/2015
    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit
        ' Purpose               : Entry to the page
        ' Description           : Called from within the <Form> Tag
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 25th Feb 2004
        ' Revisions             :
        '=====================================================================
        If MyBase.Page.IsPostBack Then
            Select Case m_strAction.ToUpper
                Case "SAVE"
                    'Update the information set by user if action is Save
                    UpdateData()
            End Select
        End If
        If Not m_strReviewStatisticsID = "" Then
            'Plot the page
            DrawPage()
        End If
    End Sub

    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Renders the UI
        ' Description           : This function generates the html for the page
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 24th Feb 2004
        ' Revisions             :
        '=====================================================================

        Dim strMenu As String

        Select Case CommonFunction.General.CheckIsNothing(m_strPageType).ToUpper
            Case "TASKDETAILS"
                '-- TOP Menu
                strMenu = DrawMenu("TASKDETAILS")
                Response.Write(strMenu + "<br>")

                '-- Draw Page Caption
                CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_TASK_DETAILS"), , , True))
                Response.Write("<BR>")

                Response.Write("<DIV ID='divList' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
                DrawTaskDetails()
                Response.Write("</DIV>")

                '-- BOTTOM Menu
                Response.Write("<br>" + strMenu)

            Case Else

                '-- TOP Menu
                strMenu = DrawMenu("")
                Response.Write(strMenu + "<br>")

                '-- Draw Page Caption
                CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), , , True))
                Response.Write("<BR>")

                Response.Write("<DIV ID='divList' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
                DrawUIForMapping()
                Response.Write("</DIV>")

                '-- BOTTOM Menu
                Response.Write("<br>" + strMenu)

        End Select

    End Sub

    Private Function DrawMenu(ByVal strPageType As String) As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : strPageType - Identifies whether the page type is TaskDetails
        '                                       The menu returned depends upon this parameter
        ' Returns               : String (Menu)
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 24th Feb, 2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Select Case strPageType.ToUpper
            Case "TASKDETAILS"
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                'Modified By VidyaJ - IssueID - 492 - SP4
                Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick('1036_MappMpp')"}
                Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
                MyBase.InitializeResources("AppResources.PM_MapReviewTasks", "AppResources")
                Return (strMenu)
            Case Else
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                'Modified By VidyaJ - IssueID - 492 - SP4
                Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick('1036_MappMpp')"}
                Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
                MyBase.InitializeResources("AppResources.PM_MapReviewTasks", "AppResources")
                Return (strMenu)
        End Select

        MyBase.InitializeResources("AppResources.PM_MapReviewTasks", "AppResources")
    End Function

    Private Sub DrawUIForMapping()
        '=====================================================================
        ' Procedure Name        : DrawUIForMapping
        ' Purpose               : Render the UI required for mapping the Review Tasks to MPP Tasks
        ' Description           : Deals with default type of this page
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 24th Feb 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim drReader As IDataReader
        Dim blnFirst As Boolean = True
        Dim intReviewerIDCounter As Integer
        Dim strRowClass As String

        'Added by MrugajaB on 2nd Feb 2006 for multiple reviewees feature
        'Purpose:For getting list of reviewees of current review
        Dim strReviewerList As String
        strReviewerList = ","
        'End Addition

        'Render Headers
        CommonFunction.General.WriteHTML("<TABLE class='clsTable' width='99.9%' cellspacing=0 cellpadding=0>")
        CommonFunction.General.WriteHTML("<col width=20%><col width=80%>")
        CommonFunction.General.WriteHTML("<tr class=" + m_strclsTRColHeader + ">")
        CommonFunction.General.WriteHTML("<td align='center'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("RESOURCE"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='center'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("TASK"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")

        '--------------------------------------------------------------------------------------------------
        'Start rendering Reviewee information
        '--------------------------------------------------------------------------------------------------

        'Modified By MrugajaB on 2nd Feb 2006 for Multiple reviewees feature 
        'Purpose:The functionality was built for single reviewee feature, now it's changed for multiple reviewees feature

        'Retrieve Reviewee information from database
        'GetRevieweeInformation()

        ''Render Reviewee information
        ''Integrated by PrajaktaR for WSEMSP4 IssueID 449
        ''If condition added by MrugajaB on 25th July, 2005
        ''Purpose: If Reviewee is not selected (This will happen only in case of offline review), 
        ''combobox will not be shown for reviewee
        'If m_strReviewee <> "" Then

        '    CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        '    CommonFunction.General.WriteHTML("<td colspan='10'>")
        '    CommonFunction.General.WriteHTML("<b>" + MyBase.GetResourceString("REVIEWEE") + "</b>")
        '    CommonFunction.General.WriteHTML("</td>")
        '    CommonFunction.General.WriteHTML("</tr>	")
        '    CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        '    CommonFunction.General.WriteHTML("<td align='left' noWrap valign='top'>")
        '    CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp;" + Server.HtmlEncode(m_strReviewee))
        '    CommonFunction.HTMLControls.DrawTextBox("txtRevieweeID", "txtRevieweeID", , , , m_strRevieweeID, , , , , , True)
        '    CommonFunction.HTMLControls.DrawTextBox("txtPrevTaskID_Reviewee" + m_strRevieweeID, "txtPrevTaskID_Reviewee" + m_strRevieweeID, , , , m_strTaskID, , , , , , True)
        '    CommonFunction.General.WriteHTML("</td>")
        '    CommonFunction.General.WriteHTML("<td align='left' valign='top'>")

        '    'Sp to populate the combo
        '    strSQL = "usp_Sel_tbl_PM_ProjectTasks_MapReviewTasks " + m_strReviewStatisticsID + ", " + m_strRevieweeID
        '    CommonFunction.HTMLControls.DrawComboBox("cboTaskID_Reviewee" + m_strRevieweeID, strSQL, 400, m_strTaskID)
        '    CommonFunction.General.WriteHTML("<a Href='javascript:ResourceName_OnClick(" + m_strRevieweeID + ", ""Reviewee"")'><image BORDER='0' src='..\..\images\dblclick.gif' alt='" + MyBase.GetResourceString("SELECT_TASK") + "'></a>")
        '    CommonFunction.General.WriteHTML("</td>")
        '    CommonFunction.General.WriteHTML("</tr>")

        'End If
        'End of addition by MrugajaB
        'END Of Integration by PrajaktaR for WSEMSP4 IssueID 449

        'Plot Reviewer list
        strSQL = "usp_Sel_tbl_PM_ReviewStatistics_Authors " + m_strReviewStatisticsID
        drReader = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)

        'Commented And Added By Usha Pandit On 08.07.2020 For checking Reviewee data is present or not
        'CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        'CommonFunction.General.WriteHTML("<td colspan='10'>")
        'CommonFunction.General.WriteHTML("<b>" + MyBase.GetResourceString("REVIEWEE") + "</b>")
        'CommonFunction.General.WriteHTML("</td>")
        'CommonFunction.General.WriteHTML("</tr>")

        If drReader.Read Then
            CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
            CommonFunction.General.WriteHTML("<td colspan='10'>")
            CommonFunction.General.WriteHTML("<b>" + MyBase.GetResourceString("REVIEWEE") + "</b>")
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")
        Else
        End If
        CommonFunction.Data.DisposeDataReader(drReader)
        drReader = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)
        'End Of Added By Usha Pandit On 08.07.2020 For checking Reviewee data is present or not

        ' Display the list of reviewers and their MPP Tasks.
        While drReader.Read
            If intReviewerIDCounter Mod 2 = 0 Then
                strRowClass = m_strClsTREven
            Else
                strRowClass = m_strClsTROdd
            End If
            blnFirst = False

            m_strRevieweeID = CommonFunction.Data.CheckIsDBNull(drReader("AuthorID")).ToString
            m_strReviewee = CommonFunction.Data.CheckIsDBNull(drReader("AuthorName")).ToString
            m_strTaskID = ""
            m_strTaskName = ""
            If CommonFunction.Data.CheckIsDBNull(drReader("WhichTask")).ToString = PROJECT_SPECIFIC_TASKS Then
                m_strTaskID = CommonFunction.Data.CheckIsDBNull(drReader("TaskID")).ToString
                m_strTaskName = CommonFunction.Data.CheckIsDBNull(drReader("TaskName")).ToString
            End If


            CommonFunction.General.WriteHTML("<tr class=" + strRowClass + ">")
            CommonFunction.General.WriteHTML("<td align='left' noWrap valign='top'>")
            CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp;" + Server.HtmlEncode(m_strReviewee))
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtRevieweeID" + intReviewerIDCounter.ToString, "txtRevieweeID" + intReviewerIDCounter.ToString, , , , m_strRevieweeID, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtPrevTaskID_Review" + intReviewerIDCounter.ToString, "txtPrevTaskID_Review" + intReviewerIDCounter.ToString, , , , m_strTaskID, , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("<td align='left' valign='top'>")
            'Sp to populate the combo
            If Not m_strRevieweeID = "" Then
                strSQL = "usp_Sel_tbl_PM_ProjectTasks_MapReviewTasks " + m_strReviewStatisticsID + ", " + m_strRevieweeID
            Else
                strSQL = "usp_Sel_tbl_PM_ProjectTasks_MapReviewTasks " + m_strReviewStatisticsID + ", -1"
            End If
            CommonFunction.HTMLControls.DrawComboBox("cboTaskID_Reviewee" + m_strRevieweeID, strSQL, 400, m_strTaskID)
            CommonFunction.General.WriteHTML("<a Href='javascript:ResourceName_OnClick(" + m_strRevieweeID + ", ""Reviewee"")'><image BORDER='0' src='..\..\images\dblclick.gif' alt='" + MyBase.GetResourceString("SELECT_TASK") + "'></a>")
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")

            'Increment the ReviewerID count
            intReviewerIDCounter += 1


            'Added by MrugajaB on 2nd Feb 2006 for multiple reviewees feature
            'Purpose:For getting list of reviewees of current review
            strReviewerList = strReviewerList + m_strRevieweeID + ","
            'End Addition
            'End If
        End While
        CommonFunction.Data.DisposeDataReader(drReader)
        If blnFirst = True Then
            'Commented By Usha Pandit On 08.07.2020 For not showing no records message for Reviewee when Reviewers data is there
            'MyBase.InitializeResources("Resources.StandardMessages", "Resources")
            'CommonFunction.General.WriteHTML("<tr class=" + m_strClsTROdd + ">")
            'CommonFunction.General.WriteHTML("<td align='center' colspan='10'>")
            'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NO_RECORDS"))
            'CommonFunction.General.WriteHTML("</td>")
            'CommonFunction.General.WriteHTML("</tr>")
            'End Of Commented By Usha Pandit On 08.07.2020 For not showing no records message for Reviewee when Reviewers data is there
        End If

        'Store the ReviewerID count in a hidden control
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("hdRevieweeIDCount", "hdRevieweeIDCount", , , , intReviewerIDCounter.ToString, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        intReviewerIDCounter = 0
        'End modification by MrugajaB
        '--------------------------------------------------------------------------------------------------
        'End rendering Reviewee information
        '--------------------------------------------------------------------------------------------------

        '--------------------------------------------------------------------------------------------------
        'Start rendering Reviewer information
        '--------------------------------------------------------------------------------------------------

        'Plot Reviewer list
        strSQL = "usp_Sel_tbl_PM_ReviewStatistics_Reviewers " + m_strReviewStatisticsID
        drReader = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)

        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td colspan='10'>")
        CommonFunction.General.WriteHTML("<b>" + MyBase.GetResourceString("REVIEWERS") + "</b>")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")

        ' Display the list of reviewers and their MPP Tasks.
        While drReader.Read
            If intReviewerIDCounter Mod 2 = 0 Then
                strRowClass = m_strClsTREven
            Else
                strRowClass = m_strClsTROdd
            End If
            blnFirst = False

            m_strReviewerID = CommonFunction.Data.CheckIsDBNull(drReader("ReviewerID")).ToString
            m_strReviewer = CommonFunction.Data.CheckIsDBNull(drReader("Reviewer")).ToString
            m_strTaskID = ""
            m_strTaskName = ""
            If CommonFunction.Data.CheckIsDBNull(drReader("WhichTask")).ToString = PROJECT_SPECIFIC_TASKS Then
                m_strTaskID = CommonFunction.Data.CheckIsDBNull(drReader("TaskID")).ToString
                m_strTaskName = CommonFunction.Data.CheckIsDBNull(drReader("TaskName")).ToString
            End If

            'Modified by MrugajaB on 2nd Feb 2006 for multiple reviewees feature
            'Purpose:For getting list of reviewees of current review
            'If Not m_strRevieweeID = m_strReviewerID Then
            If InStr(strReviewerList, "," & m_strReviewerID & ",") = 0 Then
                'End Modification
                CommonFunction.General.WriteHTML("<tr class=" + strRowClass + ">")
                CommonFunction.General.WriteHTML("<td align='left' noWrap valign='top'>")
                CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp;" + Server.HtmlEncode(m_strReviewer))
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                CommonFunction.HTMLControls.DrawTextBox("txtReviewerID" + intReviewerIDCounter.ToString, "txtReviewerID" + intReviewerIDCounter.ToString, , , , m_strReviewerID, , , , , , True, EnableHTMLEncode:=True)
                CommonFunction.HTMLControls.DrawTextBox("txtPrevTaskID_Reviewee" + intReviewerIDCounter.ToString, "txtPrevTaskID_Reviewee" + intReviewerIDCounter.ToString, , , , m_strTaskID, , , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                CommonFunction.General.WriteHTML("</td>")
                CommonFunction.General.WriteHTML("<td align='left' valign='top'>")
                'Sp to populate the combo
                If Not m_strReviewerID = "" Then
                    strSQL = "usp_Sel_tbl_PM_ProjectTasks_MapReviewTasks " + m_strReviewStatisticsID + ", " + m_strReviewerID
                Else
                    strSQL = "usp_Sel_tbl_PM_ProjectTasks_MapReviewTasks " + m_strReviewStatisticsID + ", -1"
                End If
                CommonFunction.HTMLControls.DrawComboBox("cboTaskID_Reviewer" + m_strReviewerID, strSQL, 400, m_strTaskID)
                CommonFunction.General.WriteHTML("<a Href='javascript:ResourceName_OnClick(" + m_strReviewerID + ", ""Reviewer"")'><image BORDER='0' src='..\..\images\dblclick.gif' alt='" + MyBase.GetResourceString("SELECT_TASK") + "'></a>")
                CommonFunction.General.WriteHTML("</td>")
                CommonFunction.General.WriteHTML("</tr>")
            Else
                CommonFunction.General.WriteHTML("<tr class=" + strRowClass + ">")
                CommonFunction.General.WriteHTML("<td align='left' noWrap valign='top'>")
                CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp;" + Server.HtmlEncode(m_strReviewer) + "")
                CommonFunction.General.WriteHTML("</td>")
                CommonFunction.General.WriteHTML("<td align='left' valign='top'>")
                CommonFunction.General.WriteHTML(MyBase.GetResourceString("RESOURCE_MESSAGE"))
                CommonFunction.General.WriteHTML("</td>")
                CommonFunction.General.WriteHTML("</tr>")
            End If

            'Increment the ReviewerID count
            intReviewerIDCounter += 1
        End While
        CommonFunction.Data.DisposeDataReader(drReader)
        If blnFirst = True Then
            MyBase.InitializeResources("Resources.StandardMessages", "Resources")
            CommonFunction.General.WriteHTML("<tr class=" + m_strClsTROdd + ">")
            CommonFunction.General.WriteHTML("<td align='center' colspan='10'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NO_RECORDS"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")
        End If

        'Store the ReviewerID count in a hidden control
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("hdReviewerIDCount", "hdReviewerIDCount", , , , intReviewerIDCounter.ToString, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        '--------------------------------------------------------------------------------------------------
        'Start rendering Reviewer information
        '--------------------------------------------------------------------------------------------------

        CommonFunction.General.WriteHTML("</TABLE>")
    End Sub

    Private Sub DrawTaskDetails()
        '=====================================================================
        ' Procedure Name        : DrawTaskDetails
        ' Purpose               : Render the UI for showing Task details
        ' Description           : Deals with Task Details page type.
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 25th Feb 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim objGrid As New WebPages.Template.GenericGrid
        Dim arrstrActualList() As String = {"TaskName", "StartDate", "EndDate", "Work"}

        ''Commented and Added By Usha Pandit on 29-March-2019 Purpose::Whizible 2 Work field change
        ''Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("TASK"), MyBase.GetResourceString("START_DATE"), MyBase.GetResourceString("END_DATE"), MyBase.GetResourceString("WORK") + MyBase.GetResourceString("(HRS)")}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("TASK"), MyBase.GetResourceString("START_DATE"), MyBase.GetResourceString("END_DATE"), "Work (H:M)"}
        ''End of Added By Usha Pandit on 29-March-2019 Purpose::Whizible 2 Work field change

        Dim arrstrRowLink() As String = {"Task_OnClick(TaskID)", "", "", ""}
        Dim arrstrTDStyle() As String = {" align=left ", " noWrap align=left ", " noWrap align=left", " noWrap align=right "}
        Dim strGRID As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = "EXEC usp_Sel_tbl_PM_ProjectTasks_MapReviewTasks " + m_strReviewStatisticsID + ", " + m_strEmployeeID

        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .RowLinkArray = arrstrRowLink
            .TDStyleArray = arrstrTDStyle
            .PrimaryKey = "TaskID"
            .ColumnHeaderAlignment = "center"
            .SQL = strSQL
            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strGRID = .DrawGrid()
        End With
        Response.Write(strGRID)
        objGrid = Nothing
    End Sub

    Private Sub GetRevieweeInformation()
        '=====================================================================
        ' Procedure Name        : GetRevieweeInformation
        ' Purpose               : Reads the reviewee information from database
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AbhijeetD
        ' Created               : 24th Feb 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim drReader As IDataReader

        strSQL = "usp_Sel_tbl_PM_ReviewStatistics_ReviewPlanning " + m_strReviewStatisticsID
        drReader = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)
        If drReader.Read Then
            m_strReviewee = CommonFunction.Data.CheckIsDBNull(drReader("Reviewee")).ToString
            m_strRevieweeID = CommonFunction.Data.CheckIsDBNull(drReader("RevieweeID")).ToString
            If CommonFunction.Data.CheckIsDBNull(drReader("WhichTask")).ToString = PROJECT_SPECIFIC_TASKS Then
                m_strTaskID = CommonFunction.Data.CheckIsDBNull(drReader("TaskID")).ToString
                m_strTaskName = CommonFunction.Data.CheckIsDBNull(drReader("TaskName")).ToString
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drReader)
    End Sub

    Public Sub PlotPageHeader()
        '=====================================================================
        ' Procedure Name        : PlotPageHeader
        ' Purpose               : Plot Page Header
        ' Description           : Renders the standard page header. Called from above the <body> tag
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 24th Feb 2004
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.PM_MapReviewTasks", "AppResources")
        CommonFunction.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION"))
    End Sub

    Private Sub UpdateData()
        '=====================================================================
        ' Procedure Name        : UpdateData
        ' Purpose               : Updates the data to the database
        ' Description           : Retrieves the Reviewee and Reviewer info from the form and updates to the database
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 25th Feb 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQLQuery As String
        Dim intReviewerIDCount As Integer
        Dim intCtr As Integer

        ' STEP 1 : MAP REVIEWEE TASK.
        '----------------------------
        'Code commented and modified by MrugajaB on 2nd Feb 2006
        'Purpose:Task updation for multiple reviewees istead of single reviewee

        'm_strRevieweeID = Trim(Request.Form("txtRevieweeID"))
        'm_strPrevTaskID = Trim(Request.Form("txtPrevTaskID_Reviewee" + m_strRevieweeID))
        'm_strTaskID = Trim(Request.Form("cboTaskID_Reviewee" + m_strRevieweeID))

        '' If there is a a change in the settings update the task table.
        'If m_strPrevTaskID <> m_strTaskID Then

        '    strSQLQuery = "Exec usp_Upd_tbl_PM_ProjectTasks_MapReviewTasks " + m_strReviewStatisticsID + ", " + m_strRevieweeID

        '    ' Reviewer/Reviewee.
        '    strSQLQuery = strSQLQuery + ", 'Reviewee'"

        '    ' Pass the new Task ID.
        '    If m_strTaskID = "" Then
        '        strSQLQuery = strSQLQuery + ", NULL"
        '    Else
        '        strSQLQuery = strSQLQuery + ", " + m_strTaskID
        '    End If

        '    ' Created By (for audit trail).
        '    strSQLQuery = strSQLQuery + ", '" + m_strUserName + "'"

        '    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, m_blnUseSQL)
        'End If

        intReviewerIDCount = CType(Trim(Request.Form("hdRevieweeIDCount")), Integer)
        For intCtr = 0 To intReviewerIDCount - 1

            m_strRevieweeID = Request.Form("txtRevieweeID" + intCtr.ToString)
            m_strPrevTaskID = Request.Form("txtPrevTaskID_Reviewee" + intCtr.ToString)
            m_strTaskID = Request.Form("cboTaskID_Reviewee" + m_strRevieweeID)

            ' If there is a a change in the settings update the task table.
            If m_strPrevTaskID <> m_strTaskID Then

                If Not m_strRevieweeID = "" Then
                    strSQLQuery = "Exec usp_Upd_tbl_PM_ProjectTasks_MapReviewTasks " + m_strReviewStatisticsID + ", " + m_strRevieweeID

                    ' Reviewer/Reviewee.
                    strSQLQuery = strSQLQuery + ", 'Reviewee'"

                    ' Pass the new Task ID.
                    If m_strTaskID = "" Then
                        strSQLQuery = strSQLQuery + ", NULL"
                    Else
                        strSQLQuery = strSQLQuery + ", " + m_strTaskID
                    End If

                    ' Created By (for audit trail).
                    strSQLQuery = strSQLQuery + ", '" & m_strUserName + "'"

                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, m_blnUseSQL)
                End If
            End If
        Next
        'End Modification

        ' STEP 2 : MAP REVIEWER TASKS.
        '-----------------------------
        intReviewerIDCount = CType(Trim(Request.Form("hdReviewerIDCount")), Integer)
        For intCtr = 0 To intReviewerIDCount - 1

            m_strReviewerID = Request.Form("txtReviewerID" + intCtr.ToString)
            m_strPrevTaskID = Request.Form("txtPrevTaskID_Reviewer" + intCtr.ToString)
            m_strTaskID = Request.Form("cboTaskID_Reviewer" + m_strReviewerID)

            ' If there is a a change in the settings update the task table.
            If m_strPrevTaskID <> m_strTaskID Then

                If Not m_strReviewerID = "" Then
                    strSQLQuery = "Exec usp_Upd_tbl_PM_ProjectTasks_MapReviewTasks " + m_strReviewStatisticsID + ", " + m_strReviewerID

                    ' Reviewer/Reviewee.
                    strSQLQuery = strSQLQuery + ", 'Reviewer'"

                    ' Pass the new Task ID.
                    If m_strTaskID = "" Then
                        strSQLQuery = strSQLQuery + ", NULL"
                    Else
                        strSQLQuery = strSQLQuery + ", " + m_strTaskID
                    End If

                    ' Created By (for audit trail).
                    strSQLQuery = strSQLQuery + ", '" & m_strUserName + "'"

                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, m_blnUseSQL)
                End If
            End If
        Next
    End Sub
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception
        ex.Source = "Map Review Tasks->InvalidInput" & UserInput & Cause
        Throw ex
    End Sub
End Class
