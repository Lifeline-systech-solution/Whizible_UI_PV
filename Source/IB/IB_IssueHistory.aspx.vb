Imports CommonFunctions

Public Class IB_IssueHistory
    Inherits WebPages.Template.WhizTemplate

    Protected CONST_ISSUE_HISTORY As String = "HISTORY"
    Protected CONST_TIMESHEET As String = "TIMESHEET"

    Protected m_strWindowTitle As String
    Protected m_strMode As String
    Protected m_lngIssueID As Long = 0
    Private m_lngProjectID As Long
    Private WithEvents m_objGrid As WebPage.Templates.AdvancedGrid
    'Added by GaneshD on 16 Sep 2009
    Protected m_strSortOrder As String = ""
    Protected m_strSortBy As String = ""
    Protected m_PKToken_IssueId As String = ""
    Protected m_PKToken As String = ""
    ' End of addtion by GaneshD


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
        ''Added By Vidya J On 5-2-2016
        If Not Request.QueryString("PKToken") Is Nothing Then
            m_PKToken = Request.QueryString("PKToken").ToString
        End If
        If Not Request.QueryString("IssueId") Is Nothing Then
            m_PKToken_IssueId = Request.QueryString("IssueId").ToString
        End If
        ''ADDED BY nILESH G ON 11/8/2016 PURPOSE:PKtOKEN
        If (m_PKToken = "" And HttpContext.Current.Session("intUserID") <> 0) Or _
            (CommonFunctions.Security.Token.ValidateToken(CType(m_PKToken_IssueId, String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken) = False) Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        ''END OF ADDED BY nILESH G ON 11/8/2016 PURPOSE:PKtOKEN
        'If (m_PKToken <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_PKToken_IssueId, String) + "0" + "0", m_PKToken) = False) Then
        '        ''   Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Multiple Tasks", 0, 0, "Query ID", "0")
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        ''End Of Added By Vidya J On 5-2-2016

        m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Request.QueryString("IssueId"), String) + CType(Session("intUserID"), String) + "0" + "0")

    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title 
        If Request.QueryString("Mode") = "" Or Request.QueryString("Mode") = CONST_ISSUE_HISTORY Then
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_ISSUE_HISTORY")
        Else
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_TIMESHEET")
        End If
    End Sub
    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.IB_IssueHistory", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 7 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter

        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_ISSUE_HISTORY
        If Request.QueryString("IssueID") <> "" Then
            m_lngIssueID = CType(Request.QueryString("IssueID"), Long)
        End If
        m_lngProjectID = CType(Session("intProjectID"), Long)


        ''commented by nilesh g on 31/12/2015 for Security
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
        ''end of commented by nilesh g on 31/12/2015 for Security

        Select Case m_strMode.Trim.ToUpper

            Case CONST_ISSUE_HISTORY

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add(MyBase.GetResourceString("MENU_REFRESH")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_REFRESH_TOOLTIP")) : arrClientSideFunctions.Add("Refresh_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('IB_HISTORY')")

                'copy all the element to string array
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
                General.WriteHTML("<BR>")

                'initialize the resource file for SDLC_Process page.
                MyBase.InitializeResources("AppResources.IB_IssueHistory", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_ISSUE_HISTTORY") + " : " + m_lngIssueID.ToString)
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_ISSUE_HISTORY") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen to show history
                ' Added by GAneshD on 16 Sep 2009
                m_strSortBy = CommonFunction.General.CheckIsNothing(Request.QueryString("Field"), "")
                m_strSortOrder = CommonFunction.General.CheckIsNothing(Request.QueryString("Order"), "")
                ' End of addition by GaneshD
                General.WriteHTML("<Div id='DivBody' width=100% style='Overflow: auto;' height=90% >")
                Call plotScreenForHistory(m_lngIssueID, m_lngProjectID)
                General.WriteHTML("</Div>")
               

            Case CONST_TIMESHEET

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                'arrMenu.Add(MyBase.GetResourceString("MENU_REFRESH")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_REFRESH_TOOLTIP")) : arrClientSideFunctions.Add("Refresh_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('IB_DA')")

                'copy all the element to string array
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
                General.WriteHTML("<BR>")

                'initialize the resource file for SDLC_Process page.
                MyBase.InitializeResources("AppResources.IB_IssueHistory", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_TIMESHEET") + " : " + m_lngIssueID.ToString)
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_TIMESHEET") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen to show history
                General.WriteHTML("<Div id='DivBody' width=100% style='Overflow: auto;' height=90% >")
                Call plotScreenForTimesheet(m_lngIssueID)
                General.WriteHTML("</Div>")

            Case Else

        End Select

        'draw lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotScreenForHistory
    ' Parameters Passed		:	lngIssueID  - Long
    '                           lngProjectID    - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw the grid for showing Issue history records and Project history records.
    ' Description			:	This procedure will plot two grids one for history records or the given issue id
    '                           and another for the history records for the given project id.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 7 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenForHistory(ByVal lngIssueID As Long, ByVal lngProjectID As Long)
        Dim strSQL As String

        '*********************************************************************************************************
        'plot the grid for Issue History 

        Dim arrColHeader() As String = {MyBase.GetResourceString("COL_MODIFIED_FIELD"), MyBase.GetResourceString("COL_MODIFIED_DATE"), MyBase.GetResourceString("COL_ORIGINAL_VALUE"), MyBase.GetResourceString("COL_MODIFIED_VALUE"), MyBase.GetResourceString("COL_MODIFIED_BY")}
        Dim arrAN() As String = {"FieldName", "DateOfChange", "Value", "Description", "ChangedBy"}

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'create the SP for grid data without sorting 
        strSQL = "usp_Sel_tb_IB_History " + lngIssueID.ToString

        'create Grid object and set the properties
        m_objGrid = New WebPage.Templates.AdvancedGrid
        With m_objGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivGrid1"
            .DIVHeight = 200
            .DIVStyle = "overflow: auto"
            .NoOfDataColumns = 5
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .EmptyValueReplacement = "-"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            ' Added by GaneshD on 16 Sep 2009
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .ClientSideSortFunctionName = "Sort_OnClick"
            ' End of addition by GaneshD

            'plot the grid 
            .DrawGrid()
        End With

        General.WriteHTML("<BR>")
        m_objGrid = Nothing
        '*********************************************************************************************************

        'plot grid for Project history
        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        ' Changed the lable order
        Dim arrColHeader2() As String = {MyBase.GetResourceString("COL_MODIFIED_DATE"), MyBase.GetResourceString("COL_HISTORY")}
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        Dim arrAN2() As String = {"ModifiedDate", "ChangedValue"}

        'create the SP for grid data without sorting 
        strSQL = "usp_Sel_tbl_IB_Project_History " + lngProjectID.ToString

        'create Grid object and set the properties
        m_objGrid = New WebPage.Templates.AdvancedGrid
        With m_objGrid
            .ActualColumnArray = arrAN2
            .UserFriendlyColumnArray = arrColHeader2
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivGrid2"
            .DIVHeight = 200
            .DIVStyle = "overflow: auto"
            .NoOfDataColumns = 2
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .EmptyValueReplacement = "-"
            .HeaderHTML = "<Table class='clsTable' width=99.9% cellpadding=0 cellspacing=0><TR class='clsTREven'><TD><B>" + MyBase.GetResourceString("CAP_PROJECT_HISTORY") + "</B></TD></TR></Table>"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL

            'plot the grid 
            .DrawGrid()
        End With
        m_objGrid = Nothing
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotScreenForTimesheet
    ' Parameters Passed		:	lngIssueID  - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw the screen for showing the records of timesheet entries for the given issue id.
    ' Description			:	This procedure will display the grid for showing the status and timesheet details of
    '                           the issue whose issue id is passed to it.Here total of resources used for that issue and
    '                           grand total of working hours is shown for all records.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 7 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenForTimesheet(ByVal lngIssueID As Long)
        Dim strSQL As String
        Dim strResourceName As String
        Dim strPrevResourceName As String
        Dim dblWorkHrs As Double
        Dim dblTotalWorkHrs As Double
        Dim dblResourcewiseTotal As Double
        Dim blnRecordFound As Boolean
        Dim objDr As IDataReader
        Dim strIsActive As String
        Dim strIsComplete As String
        Dim strDate As String
        Dim strDescription As String

        'plot the screen
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

        'plot the column headers
        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_RESOURCES") + "</TD>")
        General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_DATE") + "</TD>")
        General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_DESCRIPTION") + "</TD>")
        General.WriteHTML("<TD align=right >" + MyBase.GetResourceString("COL_WORKHRS") + "</TD>")
        General.WriteHTML("</TR>")

        'get the timesheet details for the issue from the database
        blnRecordFound = False
        dblResourcewiseTotal = 0.0
        dblTotalworkHrs = 0
        dblWorkHrs = 0.0
        strResourceName = ""
        strPrevResourceName = ""
        strIsActive = ""
        strIsComplete = ""

        strSQL = "usp_Sel_tbl_PM_DailyActivity_For_Issue " + lngIssueID.ToString
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDr.Read
            strResourceName = ""
            strIsActive = MyBase.GetResourceString("NO")
            strIsComplete = MyBase.GetResourceString("NO")
            strDate = ""
            strDescription = ""
            dblWorkHrs = 0.0

            If Not IsDBNull(objDr("UserName")) Then
                strResourceName = objDr("UserName").ToString + ""
            End If
            If Not IsDBNull(objDr("IsActive")) Then
                If CType(objDr("IsActive"), Boolean) = True Then
                    strIsActive = MyBase.GetResourceString("YES")
                Else
                    strIsActive = MyBase.GetResourceString("NO")
                End If
            End If
            If Not IsDBNull(objDr("IsTaskComplete")) Then
                If CType(objDr("IsTaskComplete"), Boolean) = True Then
                    strIsComplete = MyBase.GetResourceString("YES")
                Else
                    strIsComplete = MyBase.GetResourceString("NO")
                End If
            End If
            If Not IsDBNull(objDr("EntryDate")) Then
                strDate = objDr("EntryDate").ToString + ""
            End If
            If Not IsDBNull(objDr("Description")) Then
                strDescription = objDr("Description").ToString + ""
            End If
            If Not IsDBNull(objDr("Duration")) Then
                dblWorkHrs = CType(objDr("Duration"), Double)
            End If

            'if new resource found then group the records for resource name
            If strPrevResourceName.Trim.ToUpper <> strResourceName.Trim.ToUpper Then

                'display the resource total and reset the resourceCount
                'dont display as the first row when prevName is blank
                If strPrevResourceName <> "" Then
                    General.WriteHTML("<TR class='clsTREven'>")
                    General.WriteHTML("<TD align='right' colspan=3 ></TD>")
                    General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("CAP_RESOURCE_TOTAL") + " :&nbsp;&nbsp;&nbsp;</B> " + FormatNumber(dblResourcewiseTotal, 2).ToString + "</TD>")
                    General.WriteHTML("</TR>")
                    dblResourcewiseTotal = 0.0
                End If

                General.WriteHTML("<TR class='clsTREven'>")
                General.WriteHTML("<TD colspan=4 >")
                General.WriteHTML("<B>" + strResourceName.Trim + "</B>")
                General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;")
                General.WriteHTML("[" + MyBase.GetResourceString("CAP_IS_ACTIVE") + " : " + strIsActive.Trim + "] ")
                General.WriteHTML("[" + MyBase.GetResourceString("CAP_IS_COMPLETE") + " : " + strIsComplete.Trim + "] ")
                General.WriteHTML("&nbsp;&nbsp;&nbsp;")
                General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_STARTDATE") + " :</B> " + Dates.GetDate(CType(Data.CheckIsDBNull(objDr("StartDate"), ""), Date)).Trim)
                General.WriteHTML("&nbsp;&nbsp;")
                General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_ENDDATE") + " :</B> " + Dates.GetDate(CType(Data.CheckIsDBNull(objDr("EndDate"), ""), Date)).Trim)
                General.WriteHTML("&nbsp;&nbsp;")
                ''Commented and Added by Usha Pandit on 08.Mar.2019 for Purpose::Project Work field level changes 
                'General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_WORKHRS") + " :</B> " + FormatNumber(CType(Data.CheckIsDBNull(objDr("Work"), "00.00"), Double), 2).ToString)
                General.WriteHTML("<B>" + " Work (H:M)" + " :</B> " + Data.CheckIsDBNull(objDr("Work"), "00:00"))
                ''End of Added by Usha Pandit on 08.Mar.2019 for Purpose::Project Work field level changes 

                General.WriteHTML("</TD>")
                General.WriteHTML("</TR>")

                strPrevResourceName = strResourceName.Trim
            End If

            General.WriteHTML("<TR class='clsTROdd'>")
            General.WriteHTML("<TD align='left'>&nbsp</TD>")
            General.WriteHTML("<TD align='left'>" + CommonFunctions.Dates.CGetDate(CType(strDate, Date)) + "</TD>")
            General.WriteHTML("<TD align='left'>" + strDescription + "</TD>")
            General.WriteHTML("<TD align='right'>" + FormatNumber(dblWorkHrs, 2).ToString + "</TD>")
            General.WriteHTML("</TR>")

            'increament work hours count for grand total and resourcewise total
            dblTotalWorkHrs += dblWorkHrs
            dblResourcewiseTotal += dblWorkHrs

            blnRecordFound = True

        End While
        objDr.Close()
        objDr.Dispose()
        objDr = Nothing

        'if record found then display total of resources and work hours 
        'else display the message 
        If blnRecordFound = True Then
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='right' colspan=3 ></TD>")
            General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("CAP_RESOURCE_TOTAL") + " :&nbsp;&nbsp;&nbsp;</B> " + FormatNumber(dblResourcewiseTotal, 2).ToString + "</TD>")
            General.WriteHTML("</TR>")
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='right' colspan=3 ></TD>")
            General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("CAP_GRAND_TOTAL") + " :&nbsp;&nbsp;&nbsp;</B> " + FormatNumber(dblTotalWorkHrs, 2).ToString + "</TD>")
            General.WriteHTML("</TR>")
        Else
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='middle' colspan=4 >" + MyBase.GetResourceString("MSG_NODATA") + "&nbsp;</TD>")
            General.WriteHTML("</TR>")
        End If

        General.WriteHTML("</Table>")

    End Sub

    'added by SachinR   on 3 Aug 2004
    'Purpose    :   To show time with the dates in the date columns
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "DATEOFCHANGE" Or Args.DataField.ToUpper = "MODIFIEDDATE" Then
            Args.ShowTimeWithDate = True
        End If
    End Sub
    'addition end
End Class
