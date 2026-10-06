Public Partial Class QuickView_Popup
    Inherits WebPages.Template.WhizTemplate
    Protected sbHtml As New System.Text.StringBuilder
    Protected strSQL As String = ""
    Protected drNodeaccess As IDataReader
    Protected blnAdd As Boolean = False
    Protected blnEdit As Boolean = False
    Protected blnDelete As Boolean = False
    Protected blnView As Boolean = False
    Protected m_GlobalObject As New WebPages.Template.WhizGlobal
    Protected Shared m_strTagID As String = ""

    Private WithEvents m_objTodaysTaskGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMyIssuesGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_TotalRecords As Integer

    Protected m_strMode As String
    Protected m_lngUserID As Long
    Protected m_lngProjectID As Long
    Protected strMenu As String

    Protected strQuery As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        GetGlobalObject()
        InitializeVariable()

    End Sub

    Public Sub PageInit()
        If m_strMode = "TodaysTask" Then
            Call DrawTodaysTaskGrid()
        ElseIf m_strMode = "MyIssues" Then
            Call DrawMyIssuesGrid()
        ElseIf m_strMode = "MyProject" Then
            Call DrawMyProjectGrid()
        ElseIf m_strMode = "MyReviews" Then
            Call DrawMyReviewsGrid()
        ElseIf m_strMode = "NeedAttension" Then
            Call DrawNeedAttensionGrid()
        ElseIf m_strMode = "MyApprovals" Then
            Call DrawMyApprovalsGrid()
        End If
        ' DrawPage()
    End Sub
    Public Sub InitializeVariable()
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "")
        m_lngUserID = CType(Session("intUserID"), Long)
        m_lngProjectID = CType(Session("intProjectID"), Long)

    End Sub
    Public Sub DrawTodaysTaskGrid()
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Todays Tasks", , , True))

        Call DrawMenuLink()

        CommonFunctions.General.WriteHTML("<br>")
        Dim arrActualColumns() As String = {"TaskName", "ProjectName", "StartDate", "EndDate", "Duration"}
        Dim arrUserFriendlyColumn() As String = {"Task Name", "Project Name", "Start Date", "End Date", "Duration"}
        Dim arrTDStyle() As String = {"", "", "", "", ""}

        strQuery = "Usp_Sel_TodaysTask " & m_lngUserID & "," & m_lngProjectID

        With m_objTodaysTaskGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "TaskID"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            '.DIVHeight = 690
            .DIVStyle = "overflow:auto;width:99.9%;height:340px;"

            '.NoOfDataColumns = 17
            .NoOfDataColumns = 24
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            m_TotalRecords = .NoOfRows
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        CommonFunctions.General.WriteHTML("<div id=footer style='position:absolute;bottom:0;width:100%;'>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("</div>")
        m_objTodaysTaskGrid = Nothing
    End Sub
    Public Sub DrawMyIssuesGrid()
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Issues", , , True))

        Call DrawMenuLink()

        CommonFunctions.General.WriteHTML("<br>")
        Dim arrActualColumns() As String = {"IssueID", "Summary", "Priority", "Status", "Type", "SubType", "ReportedDate", "LastUpdatedDate"}
        Dim arrUserFriendlyColumn() As String = {"Issue ID", "Summary", "Priority", "Status", "Type", "Sub Type", "Reported Date", "Last Updated Date"}
        Dim arrTDStyle() As String = {"", "", "", "", "", "", "", ""}

        strQuery = "Usp_Sel_tbl_IB_Issues_MyIssues " & m_lngUserID & "," & m_lngProjectID

        With m_objMyIssuesGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "IssueID"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            '.DIVHeight = 690
            .DIVStyle = "overflow:auto;width:99.9%;height:340px;"

            '.NoOfDataColumns = 17
            .NoOfDataColumns = 24
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            m_TotalRecords = .NoOfRows
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        CommonFunctions.General.WriteHTML("<div id=footer style='position:absolute;bottom:0;width:100%;'>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("</div>")
        m_objMyIssuesGrid = Nothing
    End Sub
    Public Sub DrawMyProjectGrid()
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Project", , , True))

        Call DrawMenuLink()

        CommonFunctions.General.WriteHTML("<br>")
        Dim arrActualColumns() As String = {"ProjectCode", "ProjectName", "location", "ExpectedStartDate", "ExpectedEndDate"}
        Dim arrUserFriendlyColumn() As String = {"Project Code", "Project Name", "Organization Unit", "Start Date", "End Date"}
        Dim arrTDStyle() As String = {"", "", "", "", ""}

        strQuery = "Usp_sel_tbl_PM_Project_MyProject  " & m_lngUserID

        With m_objMyIssuesGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "ProjectID"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            '.DIVHeight = 690
            .DIVStyle = "overflow:auto;width:99.9%;height:340px;"

            '.NoOfDataColumns = 17
            .NoOfDataColumns = 24
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            m_TotalRecords = .NoOfRows
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        CommonFunctions.General.WriteHTML("<div id=footer style='position:absolute;bottom:0;width:100%;'>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("</div>")
        m_objMyIssuesGrid = Nothing
    End Sub
    Public Sub DrawMyReviewsGrid()
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Reviews", , , True))

        Call DrawMenuLink()

        CommonFunctions.General.WriteHTML("<br>")
        Dim arrActualColumns() As String = {"ReviewType","ReviewTitle","ProjectPhase","CreatedDate","ReviewedBy","Reviewee","ReviewStatus","ReviewEffort"}
        Dim arrUserFriendlyColumn() As String = {"Review Type", "Review Title", "Project Phase", "Created Date", "Reviewed By", "Reviewee", "Review Status", "Review Effort"}
        Dim arrTDStyle() As String = {"", "", "", "", "", "", "", ""}

        strQuery = "Usp_Sel_tbl_PM_ReviewStatistics_MyReviews " & m_lngUserID & "," & m_lngProjectID

        With m_objMyIssuesGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "ReviewStatisticsID"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            '.DIVHeight = 690
            .DIVStyle = "overflow:auto;width:99.9%;height:340px;"

            '.NoOfDataColumns = 17
            .NoOfDataColumns = 24
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            m_TotalRecords = .NoOfRows
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        CommonFunctions.General.WriteHTML("<div id=footer style='position:absolute;bottom:0;width:100%;'>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("</div>")
        m_objMyIssuesGrid = Nothing
    End Sub
    Public Sub DrawNeedAttensionGrid()
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Need Attension", , , True))

        Call DrawMenuLink()

        CommonFunctions.General.WriteHTML("<br>")
        Dim arrActualColumns() As String = {"TaskName", "ProjectName", "StartDate", "EndDate", "Duration"}
        Dim arrUserFriendlyColumn() As String = {"Task Name", "Project Name", "Start Date", "End Date", "Duration"}
        Dim arrTDStyle() As String = {"", "", "", "", ""}

        strQuery = "Usp_Sel_tbl_PM_ProjectTasks_NeedAttension " & m_lngUserID & "," & m_lngProjectID

        With m_objTodaysTaskGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "TaskID"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            '.DIVHeight = 690
            .DIVStyle = "overflow:auto;width:99.9%;height:340px;"

            '.NoOfDataColumns = 17
            .NoOfDataColumns = 24
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            m_TotalRecords = .NoOfRows
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        CommonFunctions.General.WriteHTML("<div id=footer style='position:absolute;bottom:0;width:100%;'>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("</div>")
        m_objTodaysTaskGrid = Nothing
    End Sub
    Public Sub DrawMyApprovalsGrid()
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Approvals", , , True))
    End Sub
    Public Sub DrawMenuLink()
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String

        Dim m_arrMenu() As String = {"Close"}
        Dim m_arrMenuToolTip() As String = {"Close"}
        Dim m_arrCSFunction() As String = {"window.close()"}

        arrMenu = m_arrMenu
        arrMenuToolTip = m_arrMenuToolTip
        arrCSFunction = m_arrCSFunction

        Dim strLegend As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub
   
   

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_GlobalObject = MyBase.GlobalObject()
    End Sub

End Class