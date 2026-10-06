#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class DB_WhizibleToday
    Inherits WebPages.Template.WhizTemplate
 

    '=====================================================================
    ' Page Name 	        :	WhizibleSEM 
    ' Purpose				:	To display Whizible Today age in Outlook view of PM and Developer DashBoard.
    ' Description			:	same
    ' Assumptions			:	
    ' Dependencies			:	
    ' Author				:	Padmnabh Anturkar
    ' Created				:	13-Dec-2005
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
    Protected m_intIndex As Double
    Protected strDivID As String
    Protected m_intPageNumberPM As Integer  'Currently Selected page number
    Protected m_intPageNumberDEL As Integer  'Currently Selected page number
    Protected m_intPageNumberIB As Integer  'Currently Selected page number
    Protected m_intPageNumberRV As Integer  'Currently Selected page number
    Private m_PageSize As Long = 5
    Private m_intCount As Long
    Protected strTRClass As String
    'Done By JyotiG
    'Start
    'Issue ID : 3926
    Dim strPMTitle As String
    Dim strIBTitle As String
    Dim strDevTitle As String
    Dim strRevTitle As String

    'Dim strPMVisitTitle As String = "Filter"
    'Dim strIBVisitTitle As String = "Filter"
    'Dim strDELVisitTitle As String = "Filter"
    'Dim strRVVisitTitle As String = "Filter"

    'Dim strPMVisitNo As String
    'Dim strIBVisitNo As String
    'Dim strRVVisitNo As String
    'Dim strDELVisitNo As String
    'End
#End Region

#Region "Member Variables"
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.

    'Added By JyotiG
    'Issue Id : 6197
    'Start
    Protected m_strToken As String
    'End

    'Added By JyotiG
    'Start
    'Purpose : Developer Dashboard Enhance View
    Protected strDashBoard As String
    'End
#End Region

#Region "Functions & Procedures"

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           : WAF Advance page template's Auto Generated code.
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
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
        ' Description           : WAF Advance page template's Auto Generated code.
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        Dim arrMenu() As String = {"?"}
        Dim arrMenuToolTip() As String = {"Help"}
        Dim arrClientSideFunction() As String = {"Help_OnClick('PM Dashboard Outlook View - Whizible Today')"}
        Dim strGrid As String

        'cerate the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True, "PMLifeLine Today")


    End Sub

    Private Sub DrawGridTasks()
        Dim strSQL As String
        Dim arrIDList() As String
        Dim strHTML As String
        Dim strTRClass As String

        'Modified By JyotiG
        'Issue ID : 3926
        'Addition by MonikaI on 21st Aug 2006 For WhizibleSEM SP7
        'If Not Session("PM_Filter") Is Nothing Then

        If CType(Session("PM_Filter"), String) <> "" Then
            'strSQL = "usp_DB_WhizibleToday_Tasks " + Session("intUserID").ToString + ",'" + Session("PM_Filter").ToString + "','" + strPMVisitNo + "'"
            strSQL = "usp_DB_WhizibleToday_Tasks " + Session("intUserID").ToString + ",'" + Session("PM_Filter").ToString + "'"
        Else
            'strSQL = "usp_DB_WhizibleToday_Tasks " + Session("intUserID").ToString + ",NULL,'" + strPMVisitNo + "'"
            strSQL = "usp_DB_WhizibleToday_Tasks " + Session("intUserID").ToString
        End If
        'End of addition by MonikaI
        'End (JyotiG)

        'Modified by PrajaktaR on 17th Aug 2006 to remove the Project Name
        'Dim arrstrUserFriendlyList() As String = {"Project Name", "TS", "Resource", "Task Name", "Priority", "Status", "Progress"}

        'By MonikaI on 31st Aug
        'Dim arrstrUserFriendlyList() As String = {" ", "TS", "Resource", "Task", "Priority", "Status", "%"}
        Dim arrstrUserFriendlyList() As String = {" ", "TS", "Resource", "Task", "Priority", "Status"}
        'End by MonikaI

        'Done By JyotiG
        'Start
        'Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%'", "style='width=15%' align='center'", "style='width=35%' align='center'", "style='width=15%' align='center'", "style='width=5%' align='center'", "style='width=20%' align='center' title='Progress'"}

        'Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%' title='Timesheet Details'", "style='width=15%' align='left'", "style='width=35%' align='left'", "style='width=15%' align='left'", "style='width=5%' align='left'", "style='width=20%' align='center' title='Progress'"}
        Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%' title='Timesheet Details'", "style='width=15%' align='left'", "style='width=60%' align='left'", "style='width=15%' align='left'", "style='width=5%' align='left'"}

        'End

        'END OF Modification by PrajaktaR on 17th Aug 2006 to remove the Project Name

        'Dim arrstrActualList() As String = {"Project Name", "TS", "Resource", "Task Name", "Priority", "Status", "Progress"}
        Dim arrstrActualList() As String = {"Project Name", "TS", "Resource", "Task Name", "Priority", "Status"}

        Dim arrRowLink() As String = {"", "TSPM_DetailsOnclick(TaskID)"}
        Dim arrGroupList() As String = {"Project Name"}

        'Dim arrIgnoreHTMLEncode() As String = {"", "1", "", "1", "", "1", "1"}
        Dim arrIgnoreHTMLEncode() As String = {"", "1", "", "1", "", "1"}


        'Commented by PrajaktaR on 17th Aug 2006 for GUI
        'CommonFunctions.General.WriteHTML("<TABLE CLASS = 'clsGridTable' WIDTH='100%' cellSpacing='1' cellPadding='0'> <TR ID = 'Tasks' CLASS='clsTROdd' VALIGN='top'> <TD ID='IDTasks' COLSPAN= 3 align = 'Center'>Tasks</TD>  </TR> ")
        'END OF Commented by PrajaktaR on 17th Aug 2006 for GUI
        m_intPageNumberPM = GetPageNumber("PM")
        DrawPaging(Session("intUserID").ToString, m_intPageNumberPM, "PM")
        With m_objGrid
            .ActualColumnArray = arrstrActualList
            'Added by PrajaktaR on 17th Aug 2006 for GUI
            .TDStyleArray = arrstrTDStyle
            'END Of Addition by PrajaktaR on 17th Aug 2006 for GUI
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .GroupOnColumn = arrGroupList
            .RowLinkArray = arrRowLink
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .PageSize = 5
            .SQL = strSQL
            .CurrentPage = m_intPageNumberPM
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .DIVHeight = 0
            .DIVID = "Tasks"
            .UseSQL = MyBase.UseSQL
            .DrawGrid()
        End With
    End Sub

    Private Sub DrawGridIssues()
        Dim strSQL As String

        'Modified By JyotiG
        'Issue ID : 3926
        'Addition by MonikaI on 21st Aug 2006 For WhizibleSEM SP7
        'If Not Session("IB_Filter") Is Nothing Then
        If CType(Session("IB_Filter"), String) <> "" Then
            'strSQL = "usp_DB_WhizibleToday_Issues " + Session("intUserID").ToString + ",'" + Session("IB_Filter").ToString + "','" + strIBVisitNo + "'"
            strSQL = "usp_DB_WhizibleToday_Issues " + Session("intUserID").ToString + ",'" + Session("IB_Filter").ToString + "'"
        Else
            'strSQL = "usp_DB_WhizibleToday_Issues " + Session("intUserID").ToString + ",NULL,'" + strIBVisitNo + "'"
            strSQL = "usp_DB_WhizibleToday_Issues " + Session("intUserID").ToString
        End If
        'End of addition by MonikaI
        'End (JyotiG)
        Dim arrstrActualList() As String = {"Project Name", "Discussions", "TS", "Issue", "Reported Date", "Responsible Person", "Issue Aging (days)"}
        'Modified by PrajaktaR on 17th Aug 2006 to remove the Project Name
        'Dim arrstrUserFriendlyList() As String = {"Project Name", "Discussions", "TS", "Issue", "Reported Date", "Responsible Person", "Issue Aging (days)", "Last Update"}
        Dim arrstrUserFriendlyList() As String = {"", "Discussions", "TS", "Issue", "Reported Date", "Responsible Person", "Issue Aging (days)"}
        'Done By JyotiG
        'Start
        'Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%'", "style='width=2%' align='center'", "style='width=35%' align='center'", "style='width=15%' align='center'", "style='width=15%' align='center'", "style='width=15%' align='center'"}
        Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%' title='Discussion Thread'", "style='width=2%' align='left' title='Timesheet Details'", "style='width=35%' align='left'", "style='width=15%' align='left'", "style='width=15%' align='left'", "style='width=15%' align='Right'"}
        'End
        'END OF Modification by PrajaktaR on 17th Aug 2006 to remove the Project Name
        'Added By JyotiG
        'Issue Id : 6197
        'Start
        ',CommonFunctions.Security.Token.GetToken(CType(IssueID, String) " + CType(Session("intUserID"), String) + "CType(0, String) + CType(0, String))
        'm_strToken = (CommonFunctions.Security.Token.GetToken(CType(IssueID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String)))
        'Dim arrRowLink() As String = {"", "IB_DiscussionOnclick(IssueID)", "TSIB_DetailsOnclick(IssueID)"}
        Dim arrRowLink() As String = {"", "IB_DiscussionOnclick(IssueID)", "TSIB_DetailsOnclick(IssueID)"}
        'End


        Dim arrGroupList() As String = {"Project Name"}
        Dim arrIgnoreHTMLEncode() As String = {"", "1", "1"}
        'Commented by PrajaktaR on 17th Aug 2006 for GUI
        'CommonFunctions.General.WriteHTML("<TABLE CLASS = 'clsGridTable' WIDTH='100%' cellSpacing='1' cellPadding='0'> <TR ID = 'Issues' CLASS='clsTROdd' VALIGN='top'> <TD ID='IDIssues' COLSPAN= 3 align = 'Center'>Issues</TD>  </TR> ")
        'END OF Commented by PrajaktaR on 17th Aug 2006 for GUI
        m_intPageNumberIB = GetPageNumber("IB")
        DrawPaging(Session("intUserID").ToString, m_intPageNumberIB, "IB")
        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            'Added by PrajaktaR on 17th Aug 2006 for GUI
            .TDStyleArray = arrstrTDStyle
            'END Of Addition by PrajaktaR on 17th Aug 2006 for GUI
            .GroupOnColumn = arrGroupList
            .RowLinkArray = arrRowLink
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .SQL = strSQL
            .DIVHeight = 0
            .PageSize = 5
            .CurrentPage = m_intPageNumberIB
            .returnHTML = False
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .UseSQL = MyBase.UseSQL
            .DrawGrid()
        End With
    End Sub
    Private Sub DrawGridReviews()
        Dim strSQL As String
        'Modfied By JyotiG
        'Issue ID : 3926
        'Addition by MonikaI on 21st Aug 2006 For WhizibleSEM SP7
        'If Not Session("RV_Filter") Is Nothing Then
        If CType(Session("RV_Filter"), String) <> "" Then
            'strSQL = "usp_DB_WhizibleToday_Reviews " + Session("strUserName").ToString + ",'" + Session("RV_Filter").ToString + "','" + strRVVisitNo + "'"
            'strSQL = "usp_DB_WhizibleToday_Reviews " + CommonFunction.General.BuildQueryString(Session("strUserName").ToString) + ",'" + Session("RV_Filter").ToString + "'"
            strSQL = "usp_DB_WhizibleToday_Reviews " + "'" + CommonFunction.General.BuildQueryString(Session("strUserName").ToString) + "'" + ",'" + Session("RV_Filter").ToString + "'"
        Else
            'strSQL = "usp_DB_WhizibleToday_Reviews " + Session("strUserName").ToString + ",NULL,'" + strRVVisitNo + "'"
            strSQL = "usp_DB_WhizibleToday_Reviews " + "'" + CommonFunction.General.BuildQueryString(Session("strUserName").ToString) + "'"
        End If
        'End of addition by MonikaI
        'End (JyotiG)

        Dim arrstrActualList() As String = {"Project Name", "Actions", "TS", "Title", "Reviewer", "Reviewee"}
        'Modified by PrajaktaR on 17th Aug 2006 to remove the Project Name
        'Dim arrstrUserFriendlyList() As String = {"Project Name", "Actions", "TS", "Title", "Reviewer", "Reviewee"}
        Dim arrstrUserFriendlyList() As String = {"", "Actions", "TS", "Title", "Reviewer", "Reviewee"}
        'Done By JyotiG
        'Start
        'Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%'", "style='width=2%' align='center'", "style='width=35%' align='center'", "style='width=15%' align='center'", "style='width=15%' align='center'"}
        Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%' title='Action Points'", "style='width=2%' align='left' title='Timesheet Details'", "style='width=35%' align='left'", "style='width=15%' align='left'", "style='width=15%' align='left'"}
        'End
        'END OF Modification by PrajaktaR on 17th Aug 2006 to remove the Project Name
        Dim arrRowLink() As String = {"", "Action_PointsOnclick(ReviewStatisticsID)", "TSRV_DetailsOnclick(ReviewStatisticsID)"}
        Dim arrGroupList() As String = {"Project Name"}
        Dim arrIgnoreHTMLEncode() As String = {"", "1", "1"}
        'Commented by PrajaktaR on 17th Aug 2006 for GUI
        'CommonFunctions.General.WriteHTML("<TABLE CLASS = 'clsGridTable' WIDTH='100%' cellSpacing='1' cellPadding='0'> <TR ID = 'Reviews' CLASS='clsTROdd' VALIGN='top'> <TD ID='IDReviews' COLSPAN= 3 align = 'Center'>Reviews</TD>  </TR> ")
        'END OF Commented by PrajaktaR on 17th Aug 2006 for GUI
        m_intPageNumberRV = GetPageNumber("RV")
        'Modified By JytoiG
        'Start
        'DrawPaging(Session("strUserName").ToString, m_intPageNumberRV, "RV")
        DrawPaging(CommonFunction.General.BuildQueryString(Session("strUserName").ToString), m_intPageNumberRV, "RV")
        'End
        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            'Added by PrajaktaR on 17th Aug 2006 for GUI
            .TDStyleArray = arrstrTDStyle
            'END Of Addition by PrajaktaR on 17th Aug 2006 for GUI
            .GroupOnColumn = arrGroupList
            .RowLinkArray = arrRowLink
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .PageSize = 5
            .SQL = strSQL
            .CurrentPage = m_intPageNumberRV
            .returnHTML = False
            .DIVHeight = 0
            .DIVID = "Reviews"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .UseSQL = MyBase.UseSQL
            .DrawGrid()
        End With
    End Sub
    'Private Sub DrawGridDeliverables()
    '    Dim strSQL As String
    '    strSQL = "usp_DB_WhizibleToday_Deliverables " + Session("intUserID").ToString
    '    Dim arrIDList() As String
    '    Dim arrstrUserFriendlyList() As String = {"Project Name", "TS", "Deliverable", "Priority", "Start Date", "End Date", "status"}
    '    Dim arrstrActualList() As String = {"Project Name", "TS", "Deliverable", "Priority", "Start Date", "End Date", "status"}
    '    Dim arrRowLink() As String = {"", "TSPM_DetailsOnclick(DeliverableID)"}
    '    Dim arrGroupList() As String = {"Project Name"}
    '    Dim arrIgnoreHTMLEncode() As String = {"", "1", "1", "", "", "", "1"}
    '    CommonFunctions.General.WriteHTML("<TABLE CLASS = 'clsGridTable' WIDTH='100%' cellSpacing='1' cellPadding='0'> <TR ID = 'Deliverables' CLASS='clsTROdd' VALIGN='top'> <TD ID='IDDeliverables' COLSPAN= 3 align = 'Center'>Deliverables</TD>  </TR> ")
    '    m_intPageNumberDEL = GetPageNumber("DEL")
    '    DrawPaging(Session("intUserID").ToString, m_intPageNumberDEL, "DEL")
    '    With m_objGrid
    '        .ActualColumnArray = arrstrActualList
    '        .UserFriendlyColumnArray = arrstrUserFriendlyList
    '        .GroupOnColumn = arrGroupList
    '        .RowLinkArray = arrRowLink
    '        .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
    '        .PageSize = 5
    '        .SQL = strSQL
    '        .PrimaryKey = "DeliverableID"
    '        .CurrentPage = m_intPageNumberDEL
    '        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
    '        .DIVHeight = 0
    '        .DIVID = "Deliverables"
    '        .UseSQL = MyBase.UseSQL
    '        .DrawGrid()
    '    End With
    'End Sub

    Private Sub DrawGridDeliverables()
        Dim strSQL As String
        Dim arrIDList() As String
        Dim strHTML As String
        Dim strTRClass As String
        'Modified By JyotiG
        'Issue ID : 3926
        'Addition by MonikaI on 21st Aug 2006 For WhizibleSEM SP7
        'If Not Session("DEL_Filter") Is Nothing Then
        If CType(Session("DEL_Filter"), String) <> "" Then
            'strSQL = "usp_DB_WhizibleToday_Deliverables " + Session("intUserID").ToString + ",'" + Session("DEL_Filter").ToString + "','" + strDELVisitNo + "'"
            strSQL = "usp_DB_WhizibleToday_Deliverables " + Session("intUserID").ToString + ",'" + Session("DEL_Filter").ToString + "'"
        Else
            'strSQL = "usp_DB_WhizibleToday_Deliverables " + Session("intUserID").ToString + ",NULL,'" + strDELVisitNo + "'"
            strSQL = "usp_DB_WhizibleToday_Deliverables " + Session("intUserID").ToString
        End If
        'End of addition by MonikaI
        'End(JyotiG)
        'Modified by PrajaktaR on 17th Aug 2006 to remove the Project Name
        'Dim arrstrUserFriendlyList() As String = {"Project Name", "TS", "Deliverable", "Priority", "status", "Progress"}

        'Dim arrstrUserFriendlyList() As String = {"", "TS", "Deliverable", "Priority", "status", "%"}
        Dim arrstrUserFriendlyList() As String = {"", "TS", "Deliverable", "Priority", "status"}

        'Added by MonikaI 
        'End of addition
        'Done By JyotiG
        'Start
        'Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%'", "style='width=55%' align='center'", "style='width=15%' align='center'", "style='width=10%' align='center'", "style='width=5%' align='center' title='Progress'"}

        'Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%' title='Timesheet Details'", "style='width=55%' align='left'", "style='width=15%' align='left'", "style='width=10%' align='left'", "style='width=5%' align='center' title='Progress'"}
        Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%' title='Timesheet Details'", "style='width=70%' align='left'", "style='width=15%' align='left'", "style='width=5%' align='left'"}

        'End
        'END OF Modification by PrajaktaR on 17th Aug 2006 to remove the Project Name

        'Dim arrstrActualList() As String = {"Project Name", "TS", "Deliverable", "Priority", "status", "Progress"}
        Dim arrstrActualList() As String = {"Project Name", "TS", "Deliverable", "Priority", "status"}

        Dim arrRowLink() As String = {"", "TSDEL_DetailsOnclick(DeliverableID)"}
        Dim arrGroupList() As String = {"Project Name"}
        Dim arrIgnoreHTMLEncode() As String = {"", "1", "1", "1", "1"}
        'Commented by PrajaktaR on 17th Aug 2006 for GUI
        'CommonFunctions.General.WriteHTML("<TABLE CLASS = 'clsGridTable' WIDTH='100%' cellSpacing='1' cellPadding='0'> <TR ID = 'Deliverables' CLASS='clsTROdd' VALIGN='top'> <TD ID='IDDeliverables' COLSPAN= 3 align = 'Center'>Deliverables</TD>  </TR> ")
        'END OF Commented by PrajaktaR on 17th Aug 2006 for GUI
        m_intPageNumberDEL = GetPageNumber("DEL")
        DrawPaging(Session("intUserID").ToString, m_intPageNumberDEL, "DEL")
        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            'Added by PrajaktaR on 18th Aug 2006 for GUI Changes
            .TDStyleArray = arrstrTDStyle
            'END OF Addition by PrajaktaR on 18th Aug 2006 for GUI Changes
            .GroupOnColumn = arrGroupList
            .RowLinkArray = arrRowLink
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .PageSize = 5
            .SQL = strSQL
            .CurrentPage = m_intPageNumberDEL
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .DIVHeight = 0
            .DIVID = "Deliverables"
            .UseSQL = MyBase.UseSQL
            .PrimaryKey = "DeliverableID"
            .DrawGrid()
        End With
    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           : WAF Advance page template's Auto Generated code.
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        Response.Write(PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        'Response.Write("<BR>")

    End Sub

    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           : WAF Advance page template's Auto Generated code.
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(strReturn)
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
        ' Description           : WAF Advance page template's Auto Generated code.
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing
    End Sub

    Public Sub PlotHead()
        CommonFunction.General.PlotPageHeadTag("PMLifeLine Today")
    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   This procedure construct the page
        ' Description           :   WAF Advance page template's Auto Generated code.
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :   Padmnabh Anturkar
        '                           
        '=====================================================================
        '######### Page Code starts here

        'This will initialize all the global objects.
        GetGlobalObject()
        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'Display the page caption.
        'DrawPageCaption()
        'Display the Header if exist. 
        'DrawHeader()

        'Response.Write("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'><TR class='clsTRPageCaption'>")
        'Response.Write("<TD align=left>Whizible Today</TD>")
        'Response.Write("</TR><TR></TR></TABLE>")
        'Response.Write("<TD align=Right><b>|<a class='Menu' href='javascript:Help_OnClick()'>?</a>|</b></TD></TR></TABLE>")

        CommonFunctions.General.WriteHTML("<table class=clsTable CellSpacing=0 Border=0 width='100%'>")
        'Modified by PrajaktaR on 17th Aug 2006 for GUI Change
        'CommonFunctions.General.WriteHTML("<tr class=clsTREven align='right'height='20' width='100'>")
        CommonFunctions.General.WriteHTML("<tr class=clsTREven width='100%'>")
        'END OF Modification by PrajaktaR on 17th Aug 2006 for GUI Change
        CommonFunctions.General.WriteHTML("<td width='50%'></td>")
        CommonFunctions.General.WriteHTML("<td width='10%'>Legend&nbsp;</td>")
        'CommonFunctions.General.WriteHTML("<td ></td>")
        'CommonFunctions.General.WriteHTML("<td width='1'height ='1'align='right' bgcolor=blue>")
        'Modified by MonikaI. IssueID : 3926
        'CommonFunctions.General.WriteHTML("<td height='100%'width='10'><table align=center height='20'width='30' ><tr><td align=center Title='Not Started' bgcolor=blue></td></tr></table></td>")

        'Modified by PrajaktaR for GUI Change
        'CommonFunctions.General.WriteHTML("<td height='100%'width='10'><table align=center height='20'width='30' ><tr><td align=center Title='Not Started'></td><IMG src='../../images/Green.gif' border=0></tr></table></td>")
        'CommonFunctions.General.WriteHTML("<td width='10%'><table align=center ><tr><td align=center Title='Not Started'></td><IMG src='../../images/Green.gif' border=0></tr></table></td>")
        CommonFunctions.General.WriteHTML("<td width='2%' Title='Not Started'><IMG src='../../Source/DB/Images/Yellow.gif' border=0></td>")
        'END OF Modification by PrajaktaR for GUI Change
        'End by MonikaI

        'Modified by PrajaktaR for GUI Change
        'CommonFunctions.General.WriteHTML("<td width='2' height='2' align='right'>&nbsp;Not Started</td>")
        CommonFunctions.General.WriteHTML("<td width='10%'>Not Started</td>")
        'END OF Modification by PrajaktaR for GUI Change
        'CommonFunctions.General.WriteHTML("<td width='1'height='1' align='right' bgcolor=red>")
        'Modified by MonikaI. IssueID : 3926
        'Modified by PrajaktaR for showing the Image
        'CommonFunctions.General.WriteHTML("<td height='100%'width='10'><table align=center height='20'width='30' ><tr><td align=center Title='Need Attention' bgcolor=red></td></tr></table></td>")
        CommonFunctions.General.WriteHTML("<td width='2%' Title='Need Attention'><IMG src='../../Source/DB/Images/Red.gif' border=0></td>")
        'END OF Modification by PrajaktaR for showing the Image
        'End by MonikaI

        'Modification by PrajaktaR for GUI Change
        'CommonFunctions.General.WriteHTML("<td width='2'height='2' align='right'>Need Attention</td>")
        CommonFunctions.General.WriteHTML("<td width='10%'>Need Attention</td>")
        'END OF Modification by PrajaktaR for GUI Change

        'CommonFunctions.General.WriteHTML("<td width='1'height='1' align='right' bgcolor=black>")
        'Modified by MonikaI. IssueID : 3926
        'CommonFunctions.General.WriteHTML("<td height='100%'width='10'><table align=center height='20'width='30' ><tr><td align=center Title='In Progress' bgcolor=black></td></tr></table></td>")
        'Modified by PrajaktaR for showing the Image
        CommonFunctions.General.WriteHTML("<td width='2%' Title='In Progress'><IMG src='../../Source/DB/Images/Green.gif' border=0></td>")
        'END OF Modification by PrajaktaR for showing the Image
        'End by MonikaI
        'Modification by PrajaktaR for GUI Change
        'CommonFunctions.General.WriteHTML("<td width='2' height='2' align='right'>&nbsp;In Progress</td>")
        CommonFunctions.General.WriteHTML("<td width='10%'>In Progress</td>")
        'END OF Modification by PrajaktaR for GUI Change
        'CommonFunctions.General.WriteHTML("</td>&nbsp;")
        CommonFunctions.General.WriteHTML("</TR></TABLE>")

        Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
        Response.Write("<TABLE ID= 'WhizibleTodayMain' class= 'clsTable' style = 'Width:100%;OverFlow:auto'>")
        'Response.Write("<TABLE ID= 'WhizibleTodayMain' class= 'clsTable' style = 'Width:100%'>")

        'Response.Write("<TR valign ='top' align = 'Right' class = 'clsTREven'><TD COLSPAN=2><B>(Count shown in parenthesis indicates Total rows associated with table)</TD><TR>")

        Dim strSQL As String
        'Dim intProjectCount As Integer
        'Dim drProjectCount As IDataReader
        '=============================================================================================
        '   Tasks table
        '=============================================================================================
        Response.Write("<tr valign ='top' > <td width='50%'>")
        'strSQL = "usp_DB_WhizibleToday_Tasks " + Session("intUserID").ToString

        'Dim objTable As New HTMLTable(strSQL, "Tasks", "Tasks", "TaskID", "<IMG src='../../images/Timesheet.gif' border=0>", "../PM/PM_DailyActivity.aspx?WhatToShow=Entry&ShowClose=1&FromWhere=PMDashboard", "Project Name")
        'Response.Write(objTable.DrawTable())
        'Added by PrajaktaR on 17th Aug 2006 for GUI change
        Response.Write("<TABLE ID= 'TasksANDDeliverable' class= 'clsTable' style = 'Width:100%;OverFlow:auto'>")
        Response.Write("<tr valign ='top' > <td width='100%'>")
        Call DrawGridTasks()
        Response.Write("</td></tr>")
        Response.Write("<tr><td width=100%>&nbsp;</td></tr>")
        Response.Write("<tr valign ='top' > <td width='100%'>")
        Call DrawGridDeliverables()
        Response.Write("</td></tr>")
        Response.Write("</TABLE>")
        'END OF Addition by PrajaktaR on 17th Aug 2006 for GUI change

        'Call DrawGridTasks()

        Response.Write("</td>")

        'Added by PrajaktaR on 17th Aug 2006 for GUI change
        Response.Write("<td width='50%'>")
        Response.Write("<TABLE ID= 'IssuesANDReviews' class= 'clsTable' style = 'Width:100%;OverFlow:auto'>")
        Response.Write("<tr valign ='top' > <td width='100%'>")
        Call DrawGridIssues()
        Response.Write("</td></tr>")
        Response.Write("<tr><td width=100%>&nbsp;</td></tr>")
        Response.Write("<tr valign ='top' > <td width='100%'>")
        Call DrawGridReviews()
        Response.Write("</td></tr>")
        Response.Write("</TABLE>")
        'END OF Addition by PrajaktaR on 17th Aug 2006 for GUI change


        '=============================================================================================
        '   Issues table
        '=============================================================================================
        'Response.Write("<td width='50%'>")
        'strSQL = "usp_DB_WhizibleToday_Issues " + Session("intUserID").ToString

        'objTable.SqlQuery = strSQL
        'objTable.Title = "Issues"
        'objTable.UniqueIDField = "ISSUEID"
        'objTable.DivName = "Issues"
        'objTable.LinkField = "Issue"
        'objTable.LinkUrl = "../IB/IB_IssueEntry.aspx?FromWhere=DB"
        'objTable.GroupBy = "Project Name"
        'Response.Write(objTable.DrawTable())
        'CommonFunctions.General.WriteHTML("<TABLE CLASS = 'clsGridTable' WIDTH='100%' cellSpacing='1' cellPadding='0'> <TR ID = 'Issues' 
        'clsTROdd' VALIGN='top'> <TD ID='IDIssues' COLSPAN= 3 align = 'Center'>Issues</TD> <TD ALIGN='RIGHT' COLSPAN=0><A HREF = 'javascript:ScrollIssues()'> <IMG ID=IReviews SRC='../../Images/down_DB.gif' BORDER='0' ALIGN='right'></A></TD> </TR> ")
        'Call DrawGridIssues()
        'Response.Write("</td></tr>")
        'Response.Write("<tr><td><BR></td></tr>")
        '=============================================================================================
        'Deliverables table
        '=============================================================================================
        'Response.Write("<tr valign ='top'> <td width='50%'>")
        'strSQL = "usp_DB_WhizibleToday_Deliverables " + Session("intUserID").ToString
        'objTable.SqlQuery = strSQL
        'objTable.Title = "Deliverables"
        'objTable.UniqueIDField = "DeliverableId"
        'objTable.DivName = "Deliverables"
        'objTable.LinkField = ""
        'objTable.LinkUrl = ""
        'objTable.GroupBy = "Project Name"
        'Response.Write(objTable.DrawTable())
        'Call DrawGridDeliverables()
        Response.Write("</td>")
        '=============================================================================================
        '   Reviews table
        '=============================================================================================
        'Response.Write("<td width='50%'>")
        'strSQL = "usp_DB_WhizibleToday_Reviews " + Session("strUserName").ToString
        'objTable.SqlQuery = strSQL
        'objTable.Title = "Reviews"
        'objTable.UniqueIDField = "ReviewStatisticsID"
        'objTable.DivName = "Reviews"
        'objTable.LinkField = "Action Points"
        'objTable.GroupBy = "Project Name"
        'Response.Write(objTable.DrawTable())
        'Call DrawGridReviews()
        m_objGrid = Nothing
        Response.Write("</td></tr>")
        Response.Write("</table>")
        Response.Write("</table>")
        HttpContext.Current.Response.Write("</DIV>")
        'Response.Write("<BR>")
        'Display the Menu at the Bottom
        'CommonFunctions.General.WriteHTML("<BR>")
        'CommonFunctions.General.WriteHTML(strMenu)
        'CommonFunctions.General.WriteHTML("<BR>")
        DisposeObjects()
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Select Case UCase(Trim(Args.DataField & ""))
            Case "TS"
                Args.ApplySorting = False
                Args.ColumnName = "<IMG border=0 src='../../Images/Timesheet.gif'>"
                Args.ApplyHTMLEncode = False
            Case "DISCUSSIONS"
                Args.ApplySorting = False
                Args.ColumnName = "<IMG border=0 src='../../Images/Discussions.gif'>"
                Args.ApplyHTMLEncode = False
            Case "ACTIONS"
                Args.ApplySorting = False
                Args.ColumnName = "<IMG border=0 src='../../Images/down.gif'>"
                Args.ApplyHTMLEncode = False
            Case "PROJECT NAME"
                Args.ColumnName = ""
                Args.ApplySorting = True
            Case "STATUS"
                Args.ApplySorting = False
                'Modified by MonikaI. IssueID : 3926
                Args.ColumnName = "<IMG border=0 src='../../Source/DB/Images/Black.gif'>"
                'End of modition
                Args.ApplyHTMLEncode = False
                Args.TDStyle = " title ='Status' align='center'"
            Case "RESOURCE"
                Args.ApplySorting = False
                'Modified by MonikaI. IssueID : 3926
                Args.ColumnName = "<IMG border=0 src='../../Source/DB/Images/WF_UserStage.gif'>"
                'End of modition
                Args.ApplyHTMLEncode = False
                Args.TDStyle = " title ='Resource' align='center'"
            Case "RESPONSIBLE PERSON"
                Args.ApplySorting = False
                'Modified by MonikaI. IssueID : 3926
                Args.ColumnName = "<IMG border=0 src='../../Source/DB/Images/WF_UserStage.gif'>"
                'End of modition
                Args.ApplyHTMLEncode = False
                Args.TDStyle = " title ='Responsible Person' align='center'"
        End Select

    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Select Case UCase(Trim(Args.DataField & ""))
            Case "PROGRESS"
                'Commented by MonikaI on 1st Sep 2006

                '    Cancel = True
                '    Dim str As String
                '    Dim strHTML As String
                '    Dim arrIDList() As String

                '    If Args.NoOfRowsPrinted Mod 2 = 0 Then
                '        strTRClass = "clsTREven"
                '    Else
                '        strTRClass = "clsTROdd"
                '    End If

                '    arrIDList = Split(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Progress"), ""), String), "=")
                '    'Modified by MonikaI. IssueID : 3926
                '    'strHTML = strHTML & ("<TD align=center height='100%'width='10'>")
                '    strHTML = strHTML & ("<TD align=center height='100%'width='20%'>")
                '    'End of modification by MonikaI
                '    strHTML = strHTML & ("<TABLE height='100%' class='clsGridTable' width='99.9%' cellspacing=0 cellpadding=0 border=0>")
                '    strHTML = strHTML & ("<TR align=center height='100%' width='100%' CLASS='" & strTRClass & "'>")
                '    strHTML = strHTML & ("<TD align=center height='100%' width='100%'  Title='" & arrIDList(1) & "'>")
                '    strHTML = strHTML & ("[" & FormatNumber(arrIDList(0).ToString, 2) & "%]")
                '    strHTML = strHTML & ("<BR>")
                '    strHTML = strHTML & (GetBar(CDbl(arrIDList(0)), 100))
                '    strHTML = strHTML & ("</TD>")
                '    strHTML = strHTML & ("</TR>")
                '    strHTML = strHTML & ("</Table>")
                '    strHTML = strHTML & ("</TD>")
                '    Args.StringToBeInserted = strHTML

                'Added by MonikaI on 1st Sep 2006
            Case "TASK NAME"
                Cancel = True
                Dim strHTML As String
                Dim arrIDList() As String

                arrIDList = Split(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Task Name"), "|"), String), "|")

                ''Added by NitinC on 09 June 2011 for WhizibleSEM 10.0 for Agile Methodology

                'strHTML = strHTML & ("<TD align=left height='100%'width='10%' Title='" & arrIDList(1) & "'>")
                'strHTML = strHTML & arrIDList(0)
                'strHTML = strHTML & ("</TD>")
                'Args.StringToBeInserted = strHTML

                If Args.DataReader("IsUserStoryTask").ToString.ToUpper = "TRUE" Then
                    strHTML = strHTML & ("<TD align=left height='100%'width='10%' Title='" & arrIDList(1) & "'><IMG src=""../../Images/Scrum/UserStory.gif""> ")
                    strHTML = strHTML & arrIDList(0)
                    strHTML = strHTML & ("</TD>")
                    Args.StringToBeInserted = strHTML
                Else
                    strHTML = strHTML & ("<TD align=left height='100%'width='10%' Title='" & arrIDList(1) & "'>")
                    strHTML = strHTML & arrIDList(0)
                    strHTML = strHTML & ("</TD>")
                    Args.StringToBeInserted = strHTML
                End If
                ''End - Added by NitinC on 09 June 2011 for WhizibleSEM 10.0 for Agile Methodology

                Args.ApplyHTMLEncode = False
            Case "DELIVERABLE"
                Cancel = True
                Dim strHTML As String
                Dim arrIDList() As String

                arrIDList = Split(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Deliverable"), "|"), String), "|")
                strHTML = strHTML & ("<TD align=left height='100%'width='10%' Title='" & arrIDList(1) & "'>")
                strHTML = strHTML & arrIDList(0)
                strHTML = strHTML & ("</TD>")
                Args.StringToBeInserted = strHTML
                Args.ApplyHTMLEncode = False
                'End of addition by MonikaI
            Case "TS"
                Args.TDStyle = " title='Click To View Timesheet Details' "
                Args.ApplyHTMLEncode = False
                If Trim(Args.DataReader("TS").ToString & "") = "" Then
                    Args.DataFieldValue = " "
                End If
            Case "DISCUSSIONS"
                'Modified by PrajaktaR on 18th Aug 2006 for GUI Changes
                'Args.TDStyle = " title='click to view Discussion' "
                'Added By JyotiG
                'Issue Id : 6197
                'Start
                m_strToken = (CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("IssueId"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String)))
                'Args.TDStyle = " title='Last Update  " + Args.DataReader("Last Update").ToString + "' "
                'End
                'END OF Modification by PrajaktaR on 18th Aug 2006 for GUI Changes
                'Args.ApplyHTMLEncode = True
                If Trim(Args.DataReader("TS").ToString & "") = "" Then
                    Args.DataFieldValue = " "
                    'Added By JyotiG
                    'Issue Id : 6197
                    'Start
                Else
                    Args.StringToBeInserted = "<TD vAlign=top title='Last Update' style='TEXT_DECORATION:None' nowrap;>" _
                    & "<A href=""JavaScript:IB_DiscussionOnclick('" & CType(Args.DataReader("IssueId"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">" & Trim(Args.DataReader("Discussions").ToString & "") & "</A></TD>"
                    Cancel = True
                    'End
                End If

            Case "ACTIONS"
                Args.TDStyle = " title='Click To View Action Points' "
                Args.ApplyHTMLEncode = False
                If Trim(Args.DataReader("Actions").ToString & "") = "" Then
                    Args.DataFieldValue = " "
                End If
            Case "STATUS"
                Dim strHTML As String
                If Trim(Args.DataReader("status").ToString & "") = "In Progress" Then
                    Cancel = True
                    'Modified by MonikaI. IssueID : 3926
                    'Modified by PrajaktaR on 17th Aug 2006 for GUI Change
                    'strHTML = strHTML & ("<td height='100%'width='10'><table align=center height='20'width='30' ><tr><td align=center Title='In Progress' bgcolor=black></td></tr></table></td>")
                    strHTML = strHTML & ("<td height='100%'width='10' align='center'><table align=center height='20'width='30' ><tr><td align=center Title='In Progress' ><IMG src='../../Source/DB/Images/Green.gif' border=0></td></tr></table></td>")
                    'Modified by PrajaktaR on 17th Aug 2006 for GUI Change
                    'End by MonikaI
                ElseIf Trim(Args.DataReader("status").ToString & "") = "Need Attention" Then
                    Cancel = True
                    'Modified by MonikaI. IssueID : 3926
                    'Modified by PrajaktaR on 17th Aug 2006 for GUI Change
                    'strHTML = strHTML & ("<td height='100%'width='10'><table align=center height='20'width='30' ><tr><td align=center Title='Need Attention' bgcolor=red></td></tr></table></td>")
                    strHTML = strHTML & ("<td height='100%'width='10' align='center'><table align=center height='20'width='30' ><tr><td align=center Title='Need Attention' ><IMG src='../../Source/DB/Images/Red.gif' border=0></td></tr></table></td>")
                    'END OF Modified by PrajaktaR on 17th Aug 2006 for GUI Change
                    'End by MonikaI
                ElseIf Trim(Args.DataReader("status").ToString & "") = "Not Started" Then
                    Cancel = True
                    'Modified by MonikaI. IssueID : 3926
                    'Modified by PrajaktaR on 17th Aug 2006 for GUI Change
                    'strHTML = strHTML & ("<td height='100%'width='10'><table align=center height='20'width='30' ><tr><td align=center Title='Not Started' bgcolor=blue></td></tr></table></td>")
                    strHTML = strHTML & ("<td height='100%'width='10' align='center'><table align=center height='20'width='30' ><tr><td align=center Title='Not Started'><IMG src='../../Source/DB/Images/Yellow.gif' border=0></td></tr></table></td>")
                    'END OF Modified by PrajaktaR on 17th Aug 2006 for GUI Change
                    'End by MonikaI
                Else
                    Cancel = True
                    strHTML = strHTML & ("<td height='100%'width='10'><table align=center height='20'width='30' ><tr><td align=center ></td></tr></table></td>")
                End If
                Args.StringToBeInserted = strHTML
        End Select

    End Sub
    Private Function GetPageNumber(ByVal fromwhere As String) As Integer
        '=====================================================================
        ' Procedure Name        : GetPageNumber()	
        ' Purpose               : Get currently selected page number, from Issue List page
        ' Description           : Persist the page number, after going back to list page.
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================

        'if pagenumber found in query string, assign that value
        Select Case fromwhere
            Case "PM"
                If Not Request.QueryString("PageNumberPM") Is Nothing Then
                    If Request.QueryString("PageNumberPM") <> "" Or Request.QueryString("PageNumberPM") <> "undefined" Then
                        Return CType(Request.QueryString("PageNumberPM"), Integer)
                    Else
                        'set default value to 1
                        Return 1
                    End If

                Else
                    'set default value to 1
                    Return 1
                End If
            Case "IB"
                If Not Request.QueryString("PageNumberIB") Is Nothing Then
                    If Request.QueryString("PageNumberIB") <> "" Or Request.QueryString("PageNumberIB") <> "undefined" Then
                        Return CType(Request.QueryString("PageNumberIB"), Integer)
                    Else
                        'set default value to 1
                        Return 1
                    End If


                Else
                    'set default value to 1
                    Return 1
                End If

            Case "DEL"
                If Not Request.QueryString("PageNumberDEL") Is Nothing Then
                    If Request.QueryString("PageNumberDEL") <> "" Or Request.QueryString("PageNumberDEL") <> "undefined" Then
                        Return CType(Request.QueryString("PageNumberDEL"), Integer)
                    Else
                        'set default value to 1
                        Return 1
                    End If

                Else
                    'set default value to 1
                    Return 1
                End If
            Case "RV"

                If Not Request.QueryString("PageNumberRV") Is Nothing Then
                    If Request.QueryString("PageNumberRV") <> "" Or Request.QueryString("PageNumberRV") <> "undefined" Then
                        Return CType(Request.QueryString("PageNumberRV"), Integer)
                    Else
                        'set default value to 1
                        Return 1
                    End If
                Else
                    'set default value to 1
                    Return 1
                End If
        End Select
    End Function 'Get queryString parameter : Pagenumber
    Private Sub DrawPaging(ByVal strInputParameter As String, ByVal m_intPageNumber As Integer, ByVal fromWhere As String)
        Dim PagingSQL As String
        Dim strFilters As String


        m_intCount = 0

        'Addition by MonikaI on 21st Aug 2006 For WhizibleSEM SP7
        Select Case fromWhere
            Case "PM"
                If CType(Session("PM_Filter"), String) <> "" Then
                    'PagingSQL = "usp_pagingSQL_WhizibleToday 'PM','" & strInputParameter & "','" + Session("PM_Filter").ToString + "','" + strPMVisitNo + "'"
                    PagingSQL = "usp_pagingSQL_WhizibleToday 'PM','" & strInputParameter & "','" + Session("PM_Filter").ToString + "'"
                Else
                    'PagingSQL = "usp_pagingSQL_WhizibleToday 'PM','" & strInputParameter & "',NULL,'" + strPMVisitNo + "'"
                    PagingSQL = "usp_pagingSQL_WhizibleToday 'PM','" & strInputParameter & "' "
                End If

            Case "IB"
                If CType(Session("IB_Filter"), String) <> "" Then
                    'PagingSQL = "usp_pagingSQL_WhizibleToday 'IB','" & strInputParameter & "','" + Session("IB_Filter").ToString + "','" + strIBVisitNo + "'"
                    PagingSQL = "usp_pagingSQL_WhizibleToday 'IB','" & strInputParameter & "','" + Session("IB_Filter").ToString + "'"
                Else
                    'PagingSQL = "usp_pagingSQL_WhizibleToday 'IB','" & strInputParameter & "',NULL,'" + strIBVisitNo + "'"
                    PagingSQL = "usp_pagingSQL_WhizibleToday 'IB','" & strInputParameter & "' "
                End If

            Case "DEL"
                If CType(Session("DEL_Filter"), String) <> "" Then
                    'PagingSQL = "usp_pagingSQL_WhizibleToday 'DEL','" & strInputParameter & "','" + Session("DEL_Filter").ToString + "','" + strDELVisitNo + "'"
                    PagingSQL = "usp_pagingSQL_WhizibleToday 'DEL','" & strInputParameter & "','" + Session("DEL_Filter").ToString + "'"
                Else
                    'PagingSQL = "usp_pagingSQL_WhizibleToday 'DEL','" & strInputParameter & "',NULL,'" + strDELVisitNo + "'"
                    PagingSQL = "usp_pagingSQL_WhizibleToday 'DEL','" & strInputParameter & "' "
                End If

            Case "RV"
                If CType(Session("RV_Filter"), String) <> "" Then
                    'PagingSQL = "usp_pagingSQL_WhizibleToday 'RV','" & strInputParameter & "','" + Session("RV_Filter").ToString + "','" + strRVVisitNo + "'"
                    PagingSQL = "usp_pagingSQL_WhizibleToday 'RV','" & strInputParameter & "','" + Session("RV_Filter").ToString + "'"
                Else
                    'PagingSQL = "usp_pagingSQL_WhizibleToday 'RV','" & strInputParameter & "',NULL,'" + strRVVisitNo + "'"
                    PagingSQL = "usp_pagingSQL_WhizibleToday 'RV','" & strInputParameter & "'"
                End If

        End Select
        'End of addition by MonikaI

        m_intCount = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)
        Dim dblRatio As Double = m_intCount / m_PageSize
        'Draw paging for IssueList
        If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
            m_intPageNumber = 1
        End If
        Dim strPaging As String
        If m_intPageNumber = -1 Or dblRatio = 0 Then
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            '    strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + fromWhere, "txtPageNumber" + fromWhere, , 30, 4, , "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event,'" + fromWhere + "')", returnHTML:=True)
            'Else
            '    strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + fromWhere, "txtPageNumber" + fromWhere, , 30, 4, m_intPageNumber.ToString, "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event,'" + fromWhere + "')", returnHTML:=True)
            strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + fromWhere, "txtPageNumber" + fromWhere, , 30, 4, , "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event,'" + fromWhere + "')", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + fromWhere, "txtPageNumber" + fromWhere, , 30, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event,'" + fromWhere + "')", returnHTML:=True, EnableHTMLEncode:=True)

        End If

        strPaging += " of " + Math.Ceiling(dblRatio).ToString
        'strPaging += "|<A href='javascript:Page_Onclick(""-1"")' TITLE='Show All Records'><B>All</B> </A>"
        Dim str As String
        Dim pageNoPM As Double = GetPageNumber("PM")
        Dim pageNoIB As Double = GetPageNumber("IB")
        Dim pageNoDEL As Double = GetPageNumber("DEL")
        Dim pageNoRV As Double = GetPageNumber("RV")
        'Added by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
        Dim strHeader As String
        'END OF Addition by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
        Select Case fromWhere
            Case "PM"
                str = "-1," + CType(pageNoIB, String) + "," + CType(pageNoDEL, String) + "," + CType(pageNoRV, String)
                strPaging += "|<A href='javascript:PagePM_Onclick(""" + str + """)' TITLE='Show All Records'><B>All</B> </A>"
                'Added by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
                strHeader = "Tasks"
                'END Of Addition by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
            Case "IB"
                str = CType(pageNoPM, String) + ",-1," + CType(pageNoDEL, String) + "," + CType(pageNoRV, String)
                strPaging += "|<A href='javascript:PageIB_Onclick(""" + str + """)' TITLE='Show All Records'><B>All</B> </A>"
                'Added by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
                strHeader = "Issues"
                'END OF Addition by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
            Case "DEL"
                str = CType(pageNoPM, String) + "," + CType(pageNoIB, String) + ",-1," + CType(pageNoRV, String)

                strPaging += "|<A href='javascript:PageDEL_Onclick(""" + str + """)' TITLE='Show All Records'><B>All</B> </A>"
                'Added by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
                strHeader = "Deliverables"
                'END OF Addition by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
            Case "RV"
                str = CType(pageNoPM, String) + "," + CType(pageNoIB, String) + "," + CType(pageNoDEL, String) + ",-1"
                strPaging += "|<A href='javascript:PageRV_Onclick(""" + str + """)' TITLE='Show All Records'><B>All</B> </A>"
                'Added by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
                strHeader = "Reviews"
                'END OF Addition by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
        End Select
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages" + fromWhere, "txtNoOfPages" + fromWhere, , , , Math.Ceiling(dblRatio).ToString, returnhtml:=True, displaynone:=True)
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages" + fromWhere, "txtNoOfPages" + fromWhere, , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)

        Dim drFilter As IDataReader
        Dim strSQLFilter As String

        strSQLFilter = "usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "','" + fromWhere + "','" & strDashBoard & "'"
        drFilter = CommonFunctions.Data.GetDataReader(strSQLFilter, True)

        'Added by MonikaI Issue ID : 5910
        If drFilter.Read Then
            'strFilters = "<A Title =""" + strPMTitle + """  href='javascript:Filters_Onclick(""" + fromWhere + """)'><B>*Filters</B></A> |  "
            If fromWhere = "PM" Then
                If strPMTitle = "" Then
                    strFilters = "<A Title ='Blank Filter'  href='javascript:Filters_Onclick(""" + fromWhere + """)'><img border=0 src='../DB/Images/filter.gif' ></A> |  "
                Else
                    strFilters = "<A Title =""" + strPMTitle + """  href='javascript:Filters_Onclick(""" + fromWhere + """)'><img border=0 src='../DB/Images/filter.gif' ></A> |  "
                End If
            End If
            If fromWhere = "DEL" Then
                If strDevTitle = "" Then
                    strFilters = "<A Title ='Blank Filter'  href='javascript:Filters_Onclick(""" + fromWhere + """)'><img border=0 src='../DB/Images/filter.gif' ></A> |  "
                Else
                    strFilters = "<A Title =""" + strDevTitle + """  href='javascript:Filters_Onclick(""" + fromWhere + """)'><img border=0 src='../DB/Images/filter.gif'></A> |  "
                End If
            End If
            If fromWhere = "IB" Then
                If strIBTitle = "" Then
                    strFilters = "<A Title ='Blank Filter'  href='javascript:Filters_Onclick(""" + fromWhere + """)'><img border=0 src='../DB/Images/filter.gif' ></A> |  "
                Else
                    strFilters = "<A Title =""" + strIBTitle + """  href='javascript:Filters_Onclick(""" + fromWhere + """)'><img border=0 src='../DB/Images/filter.gif'></A> |  "
                End If
            End If
            If fromWhere = "RV" Then
                If strRevTitle = "" Then
                    strFilters = "<A Title ='Blank Filter'  href='javascript:Filters_Onclick(""" + fromWhere + """)'><img border=0 src='../DB/Images/filter.gif' ></A> |  "
                Else
                    strFilters = "<A Title =""" + strRevTitle + """  href='javascript:Filters_Onclick(""" + fromWhere + """)'><img border=0 src='../DB/Images/filter.gif'></A> |  "
                End If
            End If
            'End BY MonikaI

        Else
            'strFilters = "<A Title ='Filter' href='javascript:Filters_Onclick(""" + fromWhere + """)'><B>Filters</B></A> |  "
            strFilters = "<A Title ='Filter'  href='javascript:Filters_Onclick(""" + fromWhere + """)'><img border=0 src='../DB/Images/filter.gif'></A> |  "
            'If fromWhere = "PM" Then
            '    strFilters = "<A Title =""" + strPMVisitTitle + """  href='javascript:Filters_Onclick(""" + fromWhere + """,""" + strPMVisitNo + """)'><img border=0 src='../DB/Images/filter.gif' ></A> |  "
            'End If
            'If fromWhere = "DEL" Then
            '    strFilters = "<A Title =""" + strDELVisitTitle + """  href='javascript:Filters_Onclick(""" + fromWhere + """,""" + strDELVisitNo + """)'><img border=0 src='../DB/Images/filter.gif'></A> |  "
            'End If
            'If fromWhere = "IB" Then
            '    strFilters = "<A Title =""" + strIBVisitTitle + """  href='javascript:Filters_Onclick(""" + fromWhere + """,""" + strIBVisitNo + """)'><img border=0 src='../DB/Images/filter.gif'></A> |  "
            'End If
            'If fromWhere = "RV" Then
            '    strFilters = "<A Title =""" + strRVVisitTitle + """  href='javascript:Filters_Onclick(""" + fromWhere + """,""" + strRVVisitNo + """)'><img border=0 src='../DB/Images/filter.gif'></A> |  "
            'End If


        End If

        CommonFunctions.Data.DisposeDataReader(drFilter)
        If strPaging <> "" Then
            'Modified by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
            'Response.Write("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
            Response.Write("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=left> " + strHeader + "</td> <td align=Right> " + strFilters + strPaging + "</TD></TR></Table>")
            'Response.Write("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><TR class='clsTRMenu' style=""background: url(../../images/cssImages/Corner.gif) no-repeat left top><td align=left""> " + strHeader + "</td> <td align=right>" + strPaging + "</TD></TR></Table>")

            'Modified by PrajaktaR on 17th Aug 2006 for Removing the Header and showing on Paging row.
        End If
    End Sub
    Private Function GetBar(ByVal fltPercent As Double, ByVal dblMax As Double) As String

        Dim strReturn As String = ""
        Dim strBarColor As String = ""
        Dim strBgcolor As String = "#ffffff" 'white
        Dim strBackColor As String = "#000000" 'black
        If fltPercent < 0 Then
            strBarColor = "#ff0000" 'red
        Else
            strBarColor = "#00ff00" 'green
            ' strBarColor = "brown"
        End If
        'Modified by MonikaI. IssueID : 3926
        'strReturn += "<TABLE height='20%' width='75%' border=1 cellspacing=0 cellpadding=0>"
        strReturn += "<TABLE BorderColor='" & strBackColor & "' height='7px' width='90%' border=1 cellspacing=0 cellpadding=0>"
        strReturn += "<TR  bgcolor='" & strBgcolor & "'CLASS='" & strTRClass & "'>"
        If fltPercent > 0 Then
            If fltPercent >= dblMax Then
                'strReturn += "<TD bgcolor='" & strBarColor & "'></TD>"
                strReturn += "<TD height='6px' bgcolor='" & strBarColor & "'></TD>"
            Else
                'strReturn += "<TD width='" & System.Math.Ceiling(fltPercent).ToString & "%' bgcolor='" & strBarColor & "'></TD>"
                'strReturn += "<TD width='" & System.Math.Ceiling((dblMax - fltPercent)).ToString & "%'></TD>"
                strReturn += "<TD height='6px' width='" & System.Math.Ceiling(fltPercent).ToString & "%' bgcolor='" & strBarColor & "'></TD>"
                strReturn += "<TD height='6px' width='" & System.Math.Ceiling((dblMax - fltPercent)).ToString & "%'  bgcolor='" & strBgcolor & "'></TD>"
            End If
        ElseIf fltPercent < 0 Then
            Dim fltTemp As Double = (-1) * fltPercent
            If fltTemp >= dblMax Then
                'strReturn += "<TD bgcolor='" & strBarColor & "'></TD>"
                strReturn += "<TD height='6px' bgcolor='" & strBarColor & "'></TD>"
            Else
                'strReturn += "<TD width='" & System.Math.Ceiling(fltTemp).ToString & "%' bgcolor='" & strBarColor & "'></TD>"
                'strReturn += "<TD width='" & System.Math.Ceiling((dblMax - fltTemp)).ToString & "%'></TD>"
                strReturn += "<TD height='6px' width='" & System.Math.Ceiling(fltTemp).ToString & "%' bgcolor='" & strBarColor & "'></TD>"
                strReturn += "<TD height='6px' width='" & System.Math.Ceiling((dblMax - fltTemp)).ToString & "%'  bgcolor='" & strBgcolor & "'></TD>"
            End If
        Else
            'strReturn += "<TD bgcolor='" & strBgcolor & "'></TD>"
            strReturn += "<TD height='6px' bgcolor='" & strBgcolor & "'></TD>"
        End If
        strReturn += "</TR>"
        strReturn += "</TABLE>"
        'End by MonikaI
        Return strReturn
    End Function

#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        'MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

    'Addition by MonikaI on 21st Aug 2006 For WhizibleSEM SP7
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        Dim strPMParameter As String = ""
        Dim strIBParameter As String = ""
        Dim strDELParameter As String = ""
        Dim strRVParameter As String = ""
        Dim drProjectCount As IDataReader
        Dim drProjectInfo As IDataReader
        Dim strSQLFilter As String
        Dim strInsertSQL As String
        Dim strsql As String
        Dim strProject As String
        Dim strResource As String

        'Added By JyotiG
        'Date : 16-Oc-2006
        'Purpose : Developer Dashboard Enhance View
        'Start
        strDashBoard = CommonFunctions.General.CheckIsNothing(Request.QueryString("DashBoard"), "")
        'End

        If Request.QueryString("Mode") = "Filter" Then
            If Request.QueryString("FromWhere") = "PM" And Session("PM_Filter") Is Nothing Then
                HttpContext.Current.Session.Add("PM_Filter", "")
            End If
            If Request.QueryString("FromWhere") = "IB" And Session("IB_Filter") Is Nothing Then
                HttpContext.Current.Session.Add("IB_Filter", "")
            End If
            If Request.QueryString("FromWhere") = "DEL" And Session("DEL_Filter") Is Nothing Then
                HttpContext.Current.Session.Add("DEL_Filter", "")
            End If
            If Request.QueryString("FromWhere") = "RV" And Session("RV_Filter") Is Nothing Then
                HttpContext.Current.Session.Add("RV_Filter", "")
            End If
        End If
        If CType(Request.QueryString("VisitNo"), String) = "1" Then
            strSQLFilter = "usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "','PM','" & strDashBoard & "'"
            drProjectCount = CommonFunctions.Data.GetDataReader(strSQLFilter, True)
            If Not drProjectCount.Read Then
                strInsertSQL = "exec usp_ins_del_WhizibleToday_Filters '" & CType(Session("intUserID"), String) & "','" + Session("LoginType").ToString + "','PM','cboResource','" & CType(Session("intUserID"), String) & "','Insert' ,'" & strDashBoard & "'"
                CommonFunctions.Data.InsertOrUpdateData(strInsertSQL, True)
            End If
            CommonFunctions.Data.DisposeDataReader(drProjectCount)

            strSQLFilter = "usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "','RV','" & strDashBoard & "'"
            drProjectCount = CommonFunctions.Data.GetDataReader(strSQLFilter, True)
            If Not drProjectCount.Read Then
                strInsertSQL = "exec usp_ins_del_WhizibleToday_Filters '" & CType(Session("intUserID"), String) & "','" + Session("LoginType").ToString + "','RV','cboResource','" & CType(Session("intUserID"), String) & "','Insert','" & strDashBoard & "'"
                CommonFunctions.Data.InsertOrUpdateData(strInsertSQL, True)
            End If
            CommonFunctions.Data.DisposeDataReader(drProjectCount)

            strSQLFilter = "usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "','IB','" & strDashBoard & "'"
            drProjectCount = CommonFunctions.Data.GetDataReader(strSQLFilter, True)
            If Not drProjectCount.Read Then
                strInsertSQL = "exec usp_ins_del_WhizibleToday_Filters '" & CType(Session("intUserID"), String) & "','" + Session("LoginType").ToString + "','IB','cboResource','" & CType(Session("intUserID"), String) & "','Insert','" & strDashBoard & "'"
                CommonFunctions.Data.InsertOrUpdateData(strInsertSQL, True)
            End If
            CommonFunctions.Data.DisposeDataReader(drProjectCount)

            strSQLFilter = "usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "','DEL','" & strDashBoard & "'"
            drProjectCount = CommonFunctions.Data.GetDataReader(strSQLFilter, True)
            If Not drProjectCount.Read Then
                strInsertSQL = "exec usp_ins_del_WhizibleToday_Filters '" & CType(Session("intUserID"), String) & "','" + Session("LoginType").ToString + "','DEL','cboResource','" & CType(Session("intUserID"), String) & "','Insert','" & strDashBoard & "'"
                CommonFunctions.Data.InsertOrUpdateData(strInsertSQL, True)
            End If
            CommonFunctions.Data.DisposeDataReader(drProjectCount)
        End If

        'If Request.QueryString("FromWhere") <> "" Then
        '    strSQLFilter = "usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "'," + Request.QueryString("FromWhere")
        'Else
        '    strSQLFilter = "usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "'"
        'End If

        'drProjectCount = CommonFunctions.Data.GetDataReader(strSQLFilter, True)
        'While drProjectCount.Read
        '    If CType(drProjectCount("Entity"), String) = "PM" Then
        '        If CType(drProjectCount("Field"), String) = "cboProject" And CType(drProjectCount("Value"), String) <> "" Then
        '            strPMParameter = " AND A.ProjectID = " + CType(drProjectCount("Value"), String)
        '            ''Done By JyotiG
        '            strPMTitle = CType(drProjectCount("Value"), String)
        '        End If
        '        If CType(drProjectCount("Field"), String) = "cboResource" And (CType(drProjectCount("Value"), String) <> "" And CType(drProjectCount("Value"), String) <> "undefined") Then
        '            strPMParameter = strPMParameter + " AND A.EmployeeID = " + CType(drProjectCount("Value"), String)
        '            ''Done By JyotiG
        '            If strPMTitle <> "" Then
        '                strPMTitle = strPMTitle + "," + CType(drProjectCount("Value"), String)
        '            Else
        '                strPMTitle = "NULL," + CType(drProjectCount("Value"), String)
        '            End If
        '        End If
        '    End If

        '    If CType(drProjectCount("Entity"), String) = "IB" Then
        '        If CType(drProjectCount("Field"), String) = "cboProject" And CType(drProjectCount("Value"), String) <> "" Then
        '            strIBParameter = " AND B.ProjectID = " + CType(drProjectCount("Value"), String)
        '            ''Done By JyotiG
        '            strIBTitle = CType(drProjectCount("Value"), String)
        '        End If
        '        If CType(drProjectCount("Field"), String) = "cboResource" And (CType(drProjectCount("Value"), String) <> "" And CType(drProjectCount("Value"), String) <> "undefined") Then
        '            strIBParameter = strIBParameter + " AND B.AssignTo = " + CType(drProjectCount("Value"), String)
        '            ''Done By JyotiG
        '            If strIBTitle <> "" Then
        '                strIBTitle = strIBTitle + "," + CType(drProjectCount("Value"), String)
        '            Else
        '                strIBTitle = "NULL," + CType(drProjectCount("Value"), String)
        '            End If
        '        End If
        '    End If

        '    If CType(drProjectCount("Entity"), String) = "DEL" Then
        '        If CType(drProjectCount("Field"), String) = "cboProject" And CType(drProjectCount("Value"), String) <> "" Then
        '            strDELParameter = " AND tbl_PM_OtherSchedules.ProjectID = " + CType(drProjectCount("Value"), String)
        '            'Done By JyotiG
        '            strDevTitle = CType(drProjectCount("Value"), String)
        '        End If
        '        If CType(drProjectCount("Field"), String) = "cboResource" And (CType(drProjectCount("Value"), String) <> "" And CType(drProjectCount("Value"), String) <> "undefined") Then
        '            strDELParameter = strDELParameter + " AND tbl_PM_OtherSchedules.ResponsiblePerson = " + CType(drProjectCount("Value"), String)
        '            ''Done By JyotiG
        '            If strDevTitle <> "" Then
        '                strDevTitle = strDevTitle + "," + CType(drProjectCount("Value"), String)
        '            Else
        '                strDevTitle = "NULL," + CType(drProjectCount("Value"), String)
        '            End If
        '        End If
        '    End If

        '    If CType(drProjectCount("Entity"), String) = "RV" Then
        '        If CType(drProjectCount("Field"), String) = "cboProject" And CType(drProjectCount("Value"), String) <> "" Then
        '            strRVParameter = " AND R.ProjectID = " + CType(drProjectCount("Value"), String)
        '            'Done By JyotiG
        '            strRevTitle = CType(drProjectCount("Value"), String)
        '        End If
        '        If CType(drProjectCount("Field"), String) = "cboResource" And (CType(drProjectCount("Value"), String) <> "" And CType(drProjectCount("Value"), String) <> "undefined") Then
        '            strRVParameter = strRVParameter + " AND RA.AuthorID = " + CType(drProjectCount("Value"), String)
        '            ''Done By JyotiG
        '            If strRevTitle <> "" Then
        '                strRevTitle = strRevTitle + "," + CType(drProjectCount("Value"), String)
        '            Else
        '                strRevTitle = "NULL," + CType(drProjectCount("Value"), String)
        '            End If
        '        End If
        '    End If
        'End While
        'Code Added By JyotiG
        'Issue ID : 3926
        'Start
        '1)
        strProject = ""
        strResource = ""
        strSQLFilter = "usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "','PM','" & strDashBoard & "'"
        drProjectCount = CommonFunctions.Data.GetDataReader(strSQLFilter, True)
        While drProjectCount.Read
            If CType(drProjectCount("Entity"), String) = "PM" Then
                If CType(drProjectCount("Field"), String) = "cboProject" And CType(drProjectCount("Value"), String) <> "" Then
                    strPMParameter = strPMParameter + " AND A.ProjectID = " + CType(drProjectCount("Value"), String)
                    strProject = CType(drProjectCount("Value"), String)
                End If

                If CType(drProjectCount("Field"), String) = "cboResource" And (CType(drProjectCount("Value"), String) <> "" And CType(drProjectCount("Value"), String) <> "undefined") Then
                    strPMParameter = strPMParameter + " AND A.EmployeeID = " + CType(drProjectCount("Value"), String)
                    strResource = CType(drProjectCount("Value"), String)
                ElseIf strDashBoard = "DEV" And CType(drProjectCount("Field"), String) <> "cboProject" Then
                    strPMParameter = strPMParameter + " AND A.EmployeeID = " + Session("intUserID").ToString
                End If
            End If
        End While
        'Added by JyotiG
        'Date : 17-Oct-2006
        'Purpose : Developer Dashboard Enhanced View
        'Start
        If strDashBoard = "DEV" And strPMParameter = "" Then
            strPMParameter = strPMParameter + " AND A.EmployeeID = " + Session("intUserID").ToString
        End If
        'End
        If strPMParameter <> "" Then
            If strProject <> "" And strResource <> "" Then
                'Commented and Modified By JyotiG
                'Start_JG_7389_13-Nov-2006
                'strsql = "usp_Sel_ProjectEmployee " + strProject + "," + strResource + ",'PM'"
                strsql = "usp_Sel_ProjectEmployee " + strProject + "," + strResource + ",'PM'," + strDashBoard
                'End_JG_7389_13-Nov-2006
            Else
                If strProject = "" And strResource <> "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee NULL," + strResource + ",'PM'"
                    strsql = "usp_Sel_ProjectEmployee NULL," + strResource + ",'PM'," + strDashBoard
                    'End_JG_7389_13-Nov-2006
                End If
                If strResource = "" And strProject <> "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee " + strProject + ",NULL,'PM'"
                    If strDashBoard = "DEV" Then
                        strsql = "usp_Sel_ProjectEmployee " + strProject + "," + Session("intUserID").ToString + ",'PM'," + strDashBoard
                    Else
                        strsql = "usp_Sel_ProjectEmployee " + strProject + ",NULL,'PM'," + strDashBoard
                    End If
                    'End_JG_7389_13-Nov-2006
                End If
                'Added By JyotiG
                'Date : 17-Oct-2006
                'Purpose : Developer Dashboard Enhanced View
                'Start
                If strResource = "" And strProject = "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee  NULL," + Session("intUserID").ToString + ",'PM'"
                    strsql = "usp_Sel_ProjectEmployee  NULL," + Session("intUserID").ToString + ",'PM'," + strDashBoard
                    'End_JG_7389_13-Nov-2006
                End If
                'End
            End If

            ''Done By JyotiG
            ''Start
            drProjectInfo = CommonFunctions.Data.GetDataReader(strsql, True)
            If drProjectInfo.Read Then
                strPMTitle = CType(drProjectInfo("Result"), String)
            End If

            CommonFunctions.Data.DisposeDataReader(drProjectInfo)

        End If
        ''End        
        CommonFunctions.Data.DisposeDataReader(drProjectCount)
        '2)
        strProject = ""
        strResource = ""
        strSQLFilter = "usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "','IB','" & strDashBoard & "'"
        drProjectCount = CommonFunctions.Data.GetDataReader(strSQLFilter, True)
        While drProjectCount.Read
            If CType(drProjectCount("Entity"), String) = "IB" Then
                If CType(drProjectCount("Field"), String) = "cboProject" And CType(drProjectCount("Value"), String) <> "" Then
                    strIBParameter = strIBParameter + " AND B.ProjectID = " + CType(drProjectCount("Value"), String)
                    strProject = CType(drProjectCount("Value"), String)
                End If
                If CType(drProjectCount("Field"), String) = "cboResource" And (CType(drProjectCount("Value"), String) <> "" And CType(drProjectCount("Value"), String) <> "undefined") Then
                    strIBParameter = strIBParameter + " AND B.AssignTo = " + CType(drProjectCount("Value"), String)
                    strResource = CType(drProjectCount("Value"), String)
                ElseIf strDashBoard = "DEV" And CType(drProjectCount("Field"), String) <> "cboProject" Then
                    strIBParameter = strIBParameter + " AND B.AssignTo = " + Session("intUserID").ToString
                End If
            End If
        End While
        'Added by JyotiG
        'Date : 17-Oct-2006
        'Purpose : Developer Dashboard Enhanced View
        'Start
        If strDashBoard = "DEV" And strIBParameter = "" Then
            strIBParameter = strIBParameter + " AND B.AssignTo = " + Session("intUserID").ToString
        End If
        'End
        If strIBParameter <> "" Then
            If strProject <> "" And strResource <> "" Then
                'Commented and Modified By JyotiG
                'Start_JG_7389_13-Nov-2006
                'strsql = "usp_Sel_ProjectEmployee " + strProject + "," + strResource + ",'IB'"
                strsql = "usp_Sel_ProjectEmployee " + strProject + "," + strResource + ",'IB'," + strDashBoard
                'End_JG_7389_13-Nov-2006
            Else
                If strProject = "" And strResource <> "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee NULL," + strResource + ",'IB'"
                    strsql = "usp_Sel_ProjectEmployee NULL," + strResource + ",'IB'," + strDashBoard
                    'End_JG_7389_13-Nov-2006
                End If
                If strResource = "" And strProject <> "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee " + strProject + ",NULL,'IB'"
                    If strDashBoard = "DEV" Then
                        strsql = "usp_Sel_ProjectEmployee " + strProject + "," + Session("intUserID").ToString + ",'IB'," + strDashBoard
                    Else
                        strsql = "usp_Sel_ProjectEmployee " + strProject + ",NULL,'IB'," + strDashBoard
                    End If
                    'End_JG_7389_13-Nov-2006
                End If
                'Added By JyotiG
                'Date : 17-Oct-2006
                'Purpose : Developer Dashboard Enhanced View
                'Start
                If strResource = "" And strProject = "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee  NULL," + Session("intUserID").ToString + ",'IB'"
                    strsql = "usp_Sel_ProjectEmployee  NULL," + Session("intUserID").ToString + ",'IB'," + strDashBoard
                    'End_JG_7389_13-Nov-2006
                End If
                'End
            End If

            ''Done By JyotiG
            ''Start
            drProjectInfo = CommonFunctions.Data.GetDataReader(strsql, True)
            If drProjectInfo.Read Then
                strIBTitle = CType(drProjectInfo("Result"), String)
            End If
            CommonFunctions.Data.DisposeDataReader(drProjectInfo)
        End If
        ''End        
        CommonFunctions.Data.DisposeDataReader(drProjectCount)

        '3)
        strProject = ""
        strResource = ""
        strSQLFilter = "usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "','DEL','" & strDashBoard & "'"
        drProjectCount = CommonFunctions.Data.GetDataReader(strSQLFilter, True)
        While drProjectCount.Read
            If CType(drProjectCount("Entity"), String) = "DEL" Then
                If CType(drProjectCount("Field"), String) = "cboProject" And CType(drProjectCount("Value"), String) <> "" Then
                    strDELParameter = strDELParameter + " AND tbl_PM_OtherSchedules.ProjectID = " + CType(drProjectCount("Value"), String)
                    strProject = CType(drProjectCount("Value"), String)
                End If
                If CType(drProjectCount("Field"), String) = "cboResource" And (CType(drProjectCount("Value"), String) <> "" And CType(drProjectCount("Value"), String) <> "undefined") Then
                    strDELParameter = strDELParameter + " AND ( tbl_PM_OtherSchedules.ResponsiblePerson = " + CType(drProjectCount("Value"), String)
                    strDELParameter = strDELParameter + " OR RequestedBy = (SELECT UserName FROM tbl_PM_Employee WHERE EMPLOYEEID = " + CType(drProjectCount("Value"), String) + "))"
                    strResource = CType(drProjectCount("Value"), String)
                ElseIf strDashBoard = "DEV" And CType(drProjectCount("Field"), String) <> "cboProject" Then
                    strDELParameter = strDELParameter + " AND ( tbl_PM_OtherSchedules.ResponsiblePerson = " + Session("intUserID").ToString
                    strDELParameter = strDELParameter + " OR RequestedBy = (SELECT UserName FROM tbl_PM_Employee WHERE EMPLOYEEID = " + Session("intUserID").ToString + "))"
                End If
            End If
        End While
        'Added by JyotiG
        'Date : 17-Oct-2006
        'Purpose : Developer Dashboard Enhanced View
        'Start
        If strDashBoard = "DEV" And strDELParameter = "" Then
            strDELParameter = strDELParameter + " AND ( tbl_PM_OtherSchedules.ResponsiblePerson = " + Session("intUserID").ToString
            strDELParameter = strDELParameter + " OR RequestedBy = (SELECT UserName FROM tbl_PM_Employee WHERE EMPLOYEEID = " + Session("intUserID").ToString + "))"
        End If
        'End
        If strDELParameter <> "" Then
            If strProject <> "" And strResource <> "" Then
                'Commented and Modified By JyotiG
                'Start_JG_7389_13-Nov-2006
                'strsql = "usp_Sel_ProjectEmployee " + strProject + "," + strResource + ",'DEL'"
                strsql = "usp_Sel_ProjectEmployee " + strProject + "," + strResource + ",'DEL'," + strDashBoard
                'End_JG_7389_13-Nov-2006
            Else
                If strProject = "" And strResource <> "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee NULL," + strResource + ",'DEL'"
                    strsql = "usp_Sel_ProjectEmployee NULL," + strResource + ",'DEL'," + strDashBoard
                    'End_JG_7389_13-Nov-2006
                End If
                If strResource = "" And strProject <> "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee " + strProject + ",NULL,'DEL'"
                    If strDashBoard = "DEV" Then
                        strsql = "usp_Sel_ProjectEmployee " + strProject + "," + Session("intUserID").ToString + ",'DEL'," + strDashBoard
                    Else
                        strsql = "usp_Sel_ProjectEmployee " + strProject + ",NULL,'DEL'," + strDashBoard
                    End If
                    'End_JG_7389_13-Nov-2006
                End If
                'Added By JyotiG
                'Date : 17-Oct-2006
                'Purpose : Developer Dashboard Enhanced View
                'Start
                If strResource = "" And strProject = "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee  NULL," + Session("intUserID").ToString + ",'DEL'"
                    strsql = "usp_Sel_ProjectEmployee  NULL," + Session("intUserID").ToString + ",'DEL'," + strDashBoard
                    'End_JG_7389_13-Nov-2006
                End If
                'End
            End If

            ''Done By JyotiG
            ''Start
            drProjectInfo = CommonFunctions.Data.GetDataReader(strsql, True)
            If drProjectInfo.Read Then
                strDevTitle = CType(drProjectInfo("Result"), String)
            End If
            CommonFunctions.Data.DisposeDataReader(drProjectInfo)
        End If
        ''End        
        CommonFunctions.Data.DisposeDataReader(drProjectCount)
        '4)
        strProject = ""
        strResource = ""
        strSQLFilter = "usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "','RV','" & strDashBoard & "'"
        drProjectCount = CommonFunctions.Data.GetDataReader(strSQLFilter, True)
        While drProjectCount.Read
            If CType(drProjectCount("Entity"), String) = "RV" Then
                If CType(drProjectCount("Field"), String) = "cboProject" And CType(drProjectCount("Value"), String) <> "" Then
                    strRVParameter = strRVParameter + " AND R.ProjectID = " + CType(drProjectCount("Value"), String)
                    strProject = CType(drProjectCount("Value"), String)
                End If
                If CType(drProjectCount("Field"), String) = "cboResource" And (CType(drProjectCount("Value"), String) <> "" And CType(drProjectCount("Value"), String) <> "undefined") Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7305_14-Nov-2006
                    'strRVParameter = strRVParameter + " AND RA.AuthorID = " + CType(drProjectCount("Value"), String)
                    Dim drEmp As IDataReader
                    Dim strEmpName As String
                    drEmp = CommonFunctions.Data.GetDataReader("Select UserName from tbl_PM_Employee where EmployeeId =" & CType(drProjectCount("Value"), String), True)
                    If drEmp.Read Then
                        strEmpName = CStr(CommonFunction.Data.CheckIsDBNull(drEmp.Item("UserName"), ""))
                    End If
                    If strEmpName <> "" Then
                        strRVParameter = strRVParameter + " AND ( RA.AuthorID = " + CType(drProjectCount("Value"), String)
                        'Added by SonalD on 17th March 2009 for IssueID 29264
                        'Purpose: to handle single quote in login person's name..Here single is quote is rplaced by 4 single quotes
                        'as strRVParameter will be passed to sp as a string and in that query is built dynamically
                        strEmpName = Replace(strEmpName, "'", "''''")
                        'End of addition by sonalD on 17th March 2009

                        strRVParameter = strRVParameter + " OR R.ReviewedBy like ''%" + CommonFunction.General.BuildQueryString(strEmpName) + "%'')"
                    Else
                        strRVParameter = strRVParameter + " AND RA.AuthorID = " + CType(drProjectCount("Value"), String)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drEmp)
                    'End_JG_7305_14-Nov-2006
                    strResource = CType(drProjectCount("Value"), String)
                ElseIf strDashBoard = "DEV" And CType(drProjectCount("Field"), String) <> "cboProject" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7305_14-Nov-2006
                    'strRVParameter = strRVParameter + " AND RA.AuthorID = " + Session("intUserID").ToString
                    strRVParameter = strRVParameter + " AND (RA.AuthorID = " + Session("intUserID").ToString
                    strRVParameter = strRVParameter + " OR R.ReviewedBy like ''%" + CommonFunction.General.BuildQueryString(Session("strUserName").ToString) + "%'')"
                    'End_JG_7305_14-Nov-2006
                End If
            End If
        End While
        'Added by JyotiG
        'Date : 17-Oct-2006
        'Purpose : Developer Dashboard Enhanced View
        'Start
        If strDashBoard = "DEV" And strRVParameter = "" Then
            'Commented and Modified By JyotiG
            'Start_JG_7305_14-Nov-2006
            'strRVParameter = strRVParameter + " AND RA.AuthorID = " + Session("intUserID").ToString
            strRVParameter = strRVParameter + " AND ( RA.AuthorID = " + Session("intUserID").ToString
            strRVParameter = strRVParameter + " OR R.ReviewedBy like ''%" + CommonFunction.General.BuildQueryString(Session("strUserName").ToString) + "%'')"
            'End_JG_7305_14-Nov-2006
        End If
        'End
        If strRVParameter <> "" Then
            If strProject <> "" And strResource <> "" Then
                'Commented and Modified By JyotiG
                'Start_JG_7389_13-Nov-2006
                'strsql = "usp_Sel_ProjectEmployee " + strProject + "," + strResource + ",'RV'"
                strsql = "usp_Sel_ProjectEmployee " + strProject + "," + strResource + ",'RV'," + strDashBoard
                'End_JG_7389_13-Nov-2006
            Else
                If strProject = "" And strResource <> "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee NULL," + strResource + ",'RV'"
                    strsql = "usp_Sel_ProjectEmployee NULL," + strResource + ",'RV'," + strDashBoard
                    'End_JG_7389_13-Nov-2006
                End If
                If strResource = "" And strProject <> "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee " + strProject + ",NULL,'RV'"
                    If strDashBoard = "DEV" Then
                        strsql = "usp_Sel_ProjectEmployee " + strProject + "," + Session("intUserID").ToString + ",'RV'," + strDashBoard
                    Else
                        strsql = "usp_Sel_ProjectEmployee " + strProject + ",NULL,'RV'," + strDashBoard
                    End If
                    'End_JG_7389_13-Nov-2006
                End If
                'Added By JyotiG
                'Date : 17-Oct-2006
                'Purpose : Developer Dashboard Enhanced View
                'Start
                If strResource = "" And strProject = "" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_7389_13-Nov-2006
                    'strsql = "usp_Sel_ProjectEmployee  NULL," + Session("intUserID").ToString + ",'RV'"
                    strsql = "usp_Sel_ProjectEmployee  NULL," + Session("intUserID").ToString + ",'RV'," + strDashBoard
                    'End_JG_7389_13-Nov-2006
                End If
                'End
            End If

            ''Done By JyotiG
            ''Start
            drProjectInfo = CommonFunctions.Data.GetDataReader(strsql, True)
            If drProjectInfo.Read Then
                strRevTitle = CType(drProjectInfo("Result"), String)
            End If
            CommonFunctions.Data.DisposeDataReader(drProjectInfo)
        End If
        ''End        
        CommonFunctions.Data.DisposeDataReader(drProjectCount)

        If Request.QueryString("FromWhere") <> "" Then
            If Request.QueryString("FromWhere") = "PM" Then
                If strPMParameter = "" Then
                    Session("PM_Filter") = ""
                Else
                    Session("PM_Filter") = strPMParameter
                End If
            End If


            If Request.QueryString("FromWhere") = "IB" Then
                If strIBParameter = "" Then
                    Session("IB_Filter") = ""
                Else
                    Session("IB_Filter") = strIBParameter
                End If
            End If

            If Request.QueryString("FromWhere") = "DEL" Then
                If strDELParameter = "" Then
                    Session("DEL_Filter") = ""
                Else
                    Session("DEL_Filter") = strDELParameter
                End If
            End If

            If Request.QueryString("FromWhere") = "RV" Then
                If strRVParameter = "" Then
                    Session("RV_Filter") = ""
                Else
                    Session("RV_Filter") = strRVParameter
                End If
            End If
        Else
            If strPMParameter = "" Then
                Session("PM_Filter") = ""
            Else
                Session("PM_Filter") = strPMParameter
            End If
            If strIBParameter = "" Then
                Session("IB_Filter") = ""
            Else
                Session("IB_Filter") = strIBParameter
            End If
            If strDELParameter = "" Then
                Session("DEL_Filter") = ""
            Else
                Session("DEL_Filter") = strDELParameter
            End If
            If strRVParameter = "" Then
                Session("RV_Filter") = ""
            Else
                Session("RV_Filter") = strRVParameter
            End If
        End If

        CommonFunctions.Data.DisposeDataReader(drProjectCount)

    End Sub
    'End of addition by MonikaI

    Private Sub m_objGrid_DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_AfterPrint

    End Sub
End Class
