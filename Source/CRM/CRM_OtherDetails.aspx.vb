Public Class CRM_OtherDetails
    Inherits WebPages.Template.WhizTemplate

    Protected m_strAction As String = ""
    Protected m_strMode As String = ""
    Protected m_lngQueryID As Long
    Protected m_lngSubRequestTypeID As Long
    Protected m_TokenKEY As String = ""

    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean


    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid


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
        Call Initialize()
        ''Added by Yogesh J on 28-Jan-2016 to validate Token
        If Not Request.QueryString("PKToken") Is Nothing Then
            m_TokenKEY = Request.QueryString("PKToken")
            ''added by Nilesh g on 1/3/2016 for PKToken generation
            If m_strMode = "TEMPLATE_LIST" Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngSubRequestTypeID, String) + "0" + "0", m_TokenKEY) = False) Then
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Company Master", 0, 0, "Company ID", CType(m_lngSubRequestTypeID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        Else
            ''end of added by Nilesh g on 1/3/2016 for PKToken generation
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(Session("intUserID"), String) + "0" + "0", m_TokenKEY) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Company Master", 0, 0, "Company ID", CType(m_lngQueryID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


            End If
        End If
        ''End of addition by Yogesh J on 28-Jan-2016 to validate Token
    End Sub


    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        ''MyBase.ApplySecurity(False, 2)
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
        ' Created               :Feb 21,2004
        ' Revisions             :
        '=====================================================================
        ' Action of the page
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString
        Else
            m_strMode = ""
        End If

        If Not Request.QueryString("QueryID") Is Nothing Then
            m_lngQueryID = CType(Request.QueryString("QueryID"), Long)
        Else
            m_lngQueryID = 0
        End If

        If Not Request.QueryString("SubRequestTypeID") Is Nothing Then
            m_lngSubRequestTypeID = CType(Request.QueryString("SubRequestTypeID"), Long)
        Else
            m_lngSubRequestTypeID = 0
        End If


        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

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
        ' Created               :Feb 21,2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrCSFunction() As String = {"Close_OnClick()"}
        Dim strMenu As String
        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)
        With Response
            ' menu
            .Write(strMenu)
            .Write("<BR>")
            Select Case UCase(Trim(m_strMode & ""))
                Case "TIMESHEET_DETAIL"
                    'page caption
                    .Write(WebPage.Templates.PageCaption.GetPageCaptions(, " Timesheet Details [Request ID: " & m_lngQueryID & "]"))
                    ' grid
                    PlotTimesheetDetailsGrid()
                Case "TEMPLATE_LIST"
                    'page caption
                    .Write(WebPage.Templates.PageCaption.GetPageCaptions(, " Template List"))
                    ' grid
                    PlotTemplateListGrid()
                Case "PREVIOUS_ISSUES_LIST"
                    'page caption
                    .Write(WebPage.Templates.PageCaption.GetPageCaptions(, " Issues [Request ID: " & m_lngQueryID & "]"))
                    ' grid
                    PlotPreviousIssueListGrid()
                Case Else
                    ' empty
                    .Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Details"))
                    .Write("<div id=divList></div>")
            End Select
            .Write("<BR>")
            .Write(strMenu)
        End With
    End Sub

    Private Sub PlotTimesheetDetailsGrid()
        '=====================================================================
        ' Procedure Name        : PlotTimesheetDetailsGrid()	
        ' Purpose               : To plot the grid for timesheet details for reuest
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 21,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        Dim strPreviousResource As String
        Dim dblResourceTotal As Double
        Dim dblGrandTotal As Double
        Dim intCount As Integer = 0
        With Response
            .Write("<BR>")
            .Write("<div id=DivList Style='Overflow:auto;width=100%;height=300' >")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<tr class=clsTRColumnHeader>" & vbCrLf)
            .Write("<td >Resource</td>" & vbCrLf)
            .Write("<td >Date</td>" & vbCrLf)
            .Write("<td >Description</td>" & vbCrLf)
            .Write("<td align=right>Work(hrs)</td>" & vbCrLf)
            .Write("</tr>" & vbCrLf)

            dblResourceTotal = 0
            dblGrandTotal = 0
            dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Request_TimesheetDetails " & m_lngQueryID, m_blnUseSQL)
            Do While dr.Read
                intCount += 1
                If Trim(strPreviousResource & "") <> "" And UCase(Trim(strPreviousResource & "")) <> UCase(Trim(dr("UserName").ToString & "")) Then
                    .Write(DrawLine("black", 4))
                    ' resource total
                    .Write("<tr class=clsTrSectionHeader>" & vbCrLf)
                    .Write("<td colspan=4 align=right>" & vbCrLf)
                    .Write("Resource Total : " & Server.HtmlEncode(FormatNumber(dblResourceTotal, 2) & ""))
                    .Write("</td>" & vbCrLf)
                    .Write("</tr>" & vbCrLf)
                    ' reset the resouce's total
                    dblResourceTotal = 0
                End If

                If UCase(Trim(strPreviousResource & "")) <> UCase(Trim(dr("UserName").ToString & "")) Then
                    .Write("<tr class=clsTrSectionHeader>" & vbCrLf)
                    .Write("<td colspan=4>" & vbCrLf)
                    .Write("<b>" & Server.HtmlEncode(dr("UserName").ToString & "") & "</b>" & vbCrLf)
                    .Write(" [Is Task Active?: " & Server.HtmlEncode(dr("IsActive").ToString & "") & "]" & vbCrLf)
                    .Write(" [Is Task Complete?: " & Server.HtmlEncode(dr("IsTaskComplete").ToString & "") & "]" & vbCrLf)
                    .Write("</td>" & vbCrLf)
                    .Write("</tr>" & vbCrLf)
                End If

                If intCount Mod 2 = 0 Then
                    .Write("<tr  class=clsTROdd>" & vbCrLf)
                Else
                    .Write("<tr  class=clsTREven>" & vbCrLf)
                End If

                .Write("<td ></td>" & vbCrLf)
                .Write("<td >" & Server.HtmlEncode(CommonFunctions.Dates.CGetDate(CType(dr("EntryDate"), Date)) & "") & "</td>" & vbCrLf)
                .Write("<td >" & Server.HtmlEncode(dr("Description").ToString & "") & "</td>" & vbCrLf)
                .Write("<td align=right>" & Server.HtmlEncode(FormatNumber(dr("Duration"), 2) & "") & "</td>" & vbCrLf)
                .Write("</tr>" & vbCrLf)

                strPreviousResource = dr("UserName").ToString

                ' totals
                dblResourceTotal = dblResourceTotal + CType(CommonFunctions.Data.CheckIsDBNull(dr("Duration"), "0"), Double)
                dblGrandTotal = dblGrandTotal + CType(CommonFunctions.Data.CheckIsDBNull(dr("Duration"), "0"), Double)

                .Flush()
            Loop

            ' no data
            If intCount = 0 Then
                .Write("<tr class=clsTreven>" & vbCrLf)
                .Write("<td colspan=4 align=center>" & vbCrLf)
                .Write("There are no items to show in this view" & vbCrLf)
                .Write("</td>" & vbCrLf)
                .Write("</tr>" & vbCrLf)
            Else
                .Write(DrawLine("black", 4))
                ' last resource total
                .Write("<tr class=clsTrSectionHeader>")
                .Write("<td colspan=4 align=right>" & vbCrLf)
                .Write("Resource Total : " & Server.HtmlEncode(FormatNumber(dblResourceTotal, 2) & ""))
                .Write("</td>" & vbCrLf)
                .Write("</tr>" & vbCrLf)
                .Write(DrawLine("black", 4))
                ' grand total
                .Write("<tr class=clsTrSectionHeader>" & vbCrLf)
                .Write("<td colspan=4 align=right>" & vbCrLf)
                .Write("Grand Total	: " & Server.HtmlEncode(FormatNumber(dblGrandTotal, 2) & ""))
                .Write("</td>" & vbCrLf)
                .Write("</tr>" & vbCrLf)
                .Write(DrawLine("black", 4))
            End If
            .Write("</table>" & vbCrLf)
            .Write("</div>")
        End With
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub

    Private Sub PlotTemplateListGrid()
        '=====================================================================
        ' Procedure Name        : PlotTemplateListGrid()	
        ' Purpose               : To plot the grid for template list for reuest
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 21,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim arrActualCols() As String = {"OriginalFileName"}
        Dim arrUserFriendlyCols() As String = {"Template"}
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15

        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:05/10/15

        strSQL = "usp_CRM_Get_Templates  " & m_lngSubRequestTypeID
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .NoOfDataColumns = 1
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .returnHTML = False
            .SQL = strSQL
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            .UseSQL = m_blnUseSQL
            .DIVHeight = 300
            .DIVID = "divList"
            .DIVStyle = "overflow:auto"
            .DrawGrid()
        End With
        m_objGrid = Nothing
    End Sub

    Private Sub PlotPreviousIssueListGrid()
        '=====================================================================
        ' Procedure Name        : PlotPreviousIssueListGrid()	
        ' Purpose               : To plot the grid for issue list for reuest
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 21,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:05/10/15
        Dim arrUserFriendlyCols() As String = {"Issue ID", "Summary", "Type", "Reported By", "Reported Date", "Responsible Person", "Due Date", "Status"}
        Dim arrActualCols() As String = {"IssueID", "Summary", "Type", "ReportedBy", "ReportedDate", "AssignTo", "DueDate", "Status"}

        strSQL = "usp_CRM_Get_Request_IssueDetails  " & m_lngQueryID
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .NoOfDataColumns = 8
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .returnHTML = False
            .SQL = strSQL
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .UseSQL = m_blnUseSQL
            .DIVHeight = 300
            .DIVID = "divList"
            .DIVStyle = "overflow:auto;width:100%;"
            .DrawGrid()

        End With
        m_objGrid = Nothing
    End Sub

    Private Function DrawLine(ByVal Color As String, ByVal ColSpan As Integer) As String
        '=====================================================================
        ' Procedure Name        : DrawLine()	
        ' Purpose               : To draw a line
        ' Description           : same as above
        ' Parameters Passed     : Color, Colspan
        ' Returns               : String
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 11,2003
        ' Revisions             :
        '=====================================================================
        Dim sb As New System.Text.StringBuilder("")
        sb.Append("<tr><td bgColor=" + Color + " width='100%' align='left' colspan='" + ColSpan.ToString + "'></td></tr>" + vbCrLf)
        DrawLine = sb.ToString
        sb = Nothing
    End Function

#Region "events"

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strTD As String

        If UCase(Trim(m_strMode & "")) = "TEMPLATE_LIST" Then
            Cancel = True
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                strTD = "<TR class=clsTROdd><TD>" & Args.NoOfRowsPrinted + 1 & "</TD>"
            Else
                strTD = "<TR class=clsTREven><TD>" & Args.NoOfRowsPrinted + 1 & "</TD>"
            End If
            strTD += "<TD>"
            ' Commented and Modified by MonikaI on 14th Jul 2009 
            ' RequestID 21655 Not able to download template attached with sub type if File server is different.
            'strTD += "<A Target= '_newWindow' href='" & CommonFunction.General.funcReturnOriginalFileName("CRM_ADMIN", CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TemplateID"), "0"), Long)) & "' >" & vbCrLf
            strTD += "<A href=""JavaScript:Template_OnClick('" + Args.DataReader("SystemFileName").ToString + "');"">"
            'End of modification by MonikaI on 14th Jul 2009

            strTD += Args.DataReader("OriginalFileName").ToString
            strTD += "</A>"
            strTD += "</TD>"
            Args.StringToBeInserted = strTD
        End If
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Dim strTD As String
        If UCase(Trim(m_strMode & "")) = "TEMPLATE_LIST" Then
            If Args.ColIndex = 0 Then
                strTD = "<TR class=clsTRColumnHeader><TD>Sr.No</TD>"
                Args.StringToBeInserted = strTD
            End If
        End If
    End Sub
#End Region


End Class
