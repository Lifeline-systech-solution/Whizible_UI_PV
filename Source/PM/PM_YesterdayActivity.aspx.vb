Imports CommonFunctions.General
Imports CommonFunctions.Data
Partial Public Class PM_YesterdayActivity
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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
#Region "Veriable Declaration"
    Dim objMenu As New WebPages.Template.StaticMenu
    Private WithEvents m_objAdvGrid As New WebPage.Templates.AdvancedGrid
    Public dtmSelectedDate As String
    Public dtmFromDate As String, dtmFromDate1 As String
    Public dtmToDate As String, dtmToDate1 As String

    Protected m_UseEditableDateControl As Boolean = CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")
    Protected strInputdateFormat As String = CommonFunction.Application.InputeDateFormat
    Private m_strSessionProjectID As String        'For storing the Project ID from Session


    Protected IsHolidayOrLeave As Boolean() = {False, False, False, False, False, False, False}
    Protected intWorkingDays As Integer

    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private strSQL As New System.Text.StringBuilder       'Tos Store the SQL statements
    Private m_PageSize As Long 'PageSize
    Protected m_intPageNumber As Integer
    Private m_intActivityCount As Long
    Private m_objMenu As WebPages.Template.StaticMenu
#End Region

    Public Sub PageInit()
        '====================================================================
        ' Function Name       : PageInit
        ' Parameters Passed     : None
        ' Returns               : Boolean
        ' Parameters Affected   : None
        ' Purpose               : To Generate the daily activity view
        ' Description           : 
        ' Assumptions           : 
        ' Dependencies          :
        ' Author                : 
        ' Created               : VivekP
        ' Created Date          : 29 Apr 2005
        ' Revisions             :
        '=====================================================================


        Dim intCnt As Integer, intWidth As Integer
        Dim strWeekDayName As String, strSQLQuery As String, strGRID As String
        Dim dtCounterDate As Date
        Dim arrstrUserFriendlyList As New ArrayList, arrstrRowLinkField As New ArrayList
        Dim arrColGroupNames As New ArrayList, arrColGroupExpanded As New ArrayList
        Dim arrstrIgnoreHTML As New ArrayList, arrColGroup As New ArrayList
        Dim arrstrGroupOnColumn As New ArrayList, arrstrTDStyle As New ArrayList
        Dim arrstrActualList As New ArrayList, arrstrSummaryFunctionsList As New ArrayList
        Dim strGroupByField, strGroupByFieldValue As String
        Dim strGroup As String, strIsExpanded As String, strPageCaption As String
        Dim drTimesheetStatus As IDataReader, drActualHrs As IDataReader
        Dim arrGroupSummaryFunctions As New ArrayList
        Dim dblActualHrs As Double, dblExpectedHrs As Double, dblTotalHrs As Double
        Dim arrIgnoreHTMLEncode As New ArrayList
        Dim strMessage As String
        Dim m_intNoOfDays As Integer
        Dim m_intDayCounter As Integer

        'Dim arrMenu() As String = {"?"}
        'Dim arrClientSideFunctions() As String = {"Help_OnClick('PM_SCRUMACTIVITYVIEW')"}
        'Dim arrMenuToolTip() As String = {" Help"}
        DrawMenu(True)
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True) + vbCrLf)


        Dim StartingDayOfWeek As String
        Dim dr As IDataReader
        Dim status As Integer = 0

        Dim strCountQuery As String


        Dim drHolidayLeave As IDataReader
        'Dim FDate As String
        'Dim TDate As String

        'If Request.QueryString("FromDate") <> "" Then
        '    FDate = CType(Request.QueryString("FromDate").ToString, Date).ToString("dd/MM/yyyy")
        'End If
        'If Request.QueryString("ToDate") <> "" Then
        '    TDate = CType(Request.QueryString("ToDate").ToString, Date).ToString("dd/MM/yyyy")
        'End If

        m_strSessionProjectID = CType(Session("intProjectID"), String)

        'Response.Write(objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True))
        'Response.Write("<BR>")


        Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><TR class=clsTRPageCaption><TD align=Left><b>Scrum Activity View</b></td></tr></table>")


        Response.Write("<table CellSpacing='0' width='99.9%'><tr class='clsTREven' width='100%'><td width='100%'>")


        If Request.QueryString("FromDate") <> "" Then
            Response.Write("<center>     From Date " + CommonFunction.HTMLControls.DrawDateControl("FromDate", "FromDate", , , Request.QueryString("FromDate").ToString, , "frmScrumActivityView", , , , , True, , True, True) + "      ")
        Else
            Response.Write("<center>     From Date " + CommonFunction.HTMLControls.DrawDateControl("FromDate", "FromDate", , , , , "frmScrumActivityView", , , , , True, , True, True) + "      ")
        End If
        If Request.QueryString("ToDate") <> "" Then
            Response.Write("To Date " + CommonFunction.HTMLControls.DrawDateControl("ToDate", "ToDate", , , Request.QueryString("ToDate").ToString, , "frmScrumActivityView", , , , , True, , True, True) + "&nbsp;<A HREF=""Javascript:ShowActivityView()"" Title=""Click to view Completed & Added requirements"" >Show</A></center>")
        Else
            Response.Write("To Date " + CommonFunction.HTMLControls.DrawDateControl("ToDate", "ToDate", , , , , "frmScrumActivityView", , , , , True, , True, True) + "&nbsp;<A HREF=""Javascript:ShowActivityView()"" Title=""Click to view Completed & Added requirements"" >Show</A></center>")
        End If

        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        Else
            m_intPageNumber = 1
        End If

        Response.Write("</td></tr></table>")
        Response.Write("<BR>")
        Response.Write("<BR><BR>")
        'Response.Write("<DIV id=DivList style='overflow:auto;Height:450'><table CellSpacing='0' width='99.9%'><tr class='clsTREven' width='99.9%'><td width='100%' align=middle>There is no items in this view.</td></tr></table></div>")
        If Request.QueryString("Mode") <> "" Then
            Response.Write("<DIV id=DivList style='overflow:auto;Height:500px'>")
            Response.Write("<table CellSpacing='0' width='90.9%'><tr class='clsTREven' width='99.9%'><td align=center width='60%'>")
            'Added By Syamantak Chavan On 29 sept 2011 for Whizible Sem 10.0
            Response.Write("<DIV id=DivList3 style='overflow:auto;Height:30px'><table CellSpacing='0' width='360'><tr class='clsTREven' width='99.9%'><td width='100%' align=left><b>Completed</b></td></tr>")
            Response.Write("</table></div>")
            'End Added By Syamantak Chavan On 29 sept 2011 for Whizible Sem 10.0
            Response.Write("<DIV id=DivList1 style='overflow:auto;Height:350px'><table CellSpacing='0' width='370'><tr class='clsTREven' width='99.9%'><td width='100%' align=LEFT>")
            AssignActivityCount("Complete", Request.QueryString("FromDate").ToString, Request.QueryString("ToDate").ToString, "C_Count")
            CompletedDrawPaging()
            PlotGrid("Complete", Request.QueryString("FromDate").ToString, Request.QueryString("ToDate").ToString)
            Response.Write("</td></tr></table></div></td>")
            m_objGrid = New WebPages.Template.GenericGrid
            Response.Write("<td align=right width='45.9%'>")
            'Added By Syamantak Chavan On 29 sept 2011 for Whizible Sem 10.0
            Response.Write("<DIV id=DivList3 style='overflow:auto;Height:30px'><table CellSpacing='0' width='360' ><tr class='clsTREven' width='99.9%'><td width='100%' align=left><b>Added Requirements</b></td></tr>")
            Response.Write("</table></div>")
            'End Added By Syamantak Chavan On 29 sept 2011 for Whizible Sem 10.0
            Response.Write("<DIV id=DivList2 style='overflow:auto;Height:350px'><table CellSpacing='0' width='360'><tr class='clsTREven' width='99.9%'><td width='100%' align=LEFT>")
            AssignActivityCount("Req", Request.QueryString("FromDate").ToString, Request.QueryString("ToDate").ToString, "R_Count")
            AddedRequirementDrawPaging()
            PlotGrid("Req", Request.QueryString("FromDate").ToString, Request.QueryString("ToDate").ToString)
            Response.Write("</td></tr></table></div></td></tr>")
            Response.Write("</div>")
        Else

            Response.Write("<DIV id=DivList style='overflow:auto;Height:400px'><table CellSpacing='0' width='99.9%'><tr class='clsTREven' width='99.9%'><td width='100%' align=middle>There is no items in this view.</td></tr></table></div>")
        End If
        'Response.Write(objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True))


        CommonFunction.Data.DisposeDataReader(dr)
        DrawMenu(False)
    End Sub
    Private Sub AssignActivityCount(ByVal Flag As String, ByVal FromDate As String, ByVal ToDate As String, ByVal CountFlag As String)
        Dim drDailyActivity As IDataReader
        drDailyActivity = CommonFunctions.Data.GetDataReader("Exec Usp_Sel_YesterdayActivity " + m_strSessionProjectID + ",'" + Flag + "','" + FromDate + "','" + ToDate + "','" + CountFlag + "'", MyBase.UseSQL)
        If drDailyActivity.Read Then
            m_intActivityCount = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Count"), "20")), Long)
        End If
    End Sub
    Private Sub DrawMenu(ByVal blnTop As Boolean)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Syamantak Chavan
        ' Created               : 28 July 2011
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu
        'Added If condition by NitinC on 26 Dec 2011 For WhizibleSEM 11.0 - Agile Module (Issue Fix 57613)
        If CheckIsNothing(Request.QueryString("ShowBack"), "") = "1" Then
            arrMenuCaptionsList.Add("Back")
            arrMenuToolTipsList.Add(MyBase.GetResourceString("BACK"))
            arrClientSideFunctionList.Add("Back_OnClick()")
        End If
        'End of Added If condition by NitinC on 26 Dec 2011 For WhizibleSEM 11.0 - Agile Module (Issue Fix 57613)
        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("TOOLTIP_MENU_HELP"))
        arrClientSideFunctionList.Add("Help_OnClick('YesterdayActivity')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        '-------------------------------------------------------------
        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        If (blnTop = True) Then
            strMenu = "<TABLE class=clsTable name=tblMenuTop id=tblMenuTop cellSpacing=0 cellPadding=0 width='99.9%'> <TR><TD>" & strMenu & "</TD></TR></table>"
        Else
            strMenu = "<TABLE class=clsTable name=tblMenuBottom id=tblMenuBottom cellSpacing=0 cellPadding=0 width='99.9%'> <TR><TD>" & strMenu & "</TD></TR></table>"
        End If

        CommonFunctions.General.WriteHTML(strMenu)

    End Sub
    'Modified By Syamantak Chavan On 30 sept 2011 for Whizible Sem 10.0
    Private Sub CompletedDrawPaging()
        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        Else
            m_intPageNumber = 1
        End If
        'Dim drPageSize As IDataReader
        'drPageSize = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_IB_DefaultSettings " + m_ProjectId.ToString & ",'" + m_LoginType + "'," & m_UserId.ToString, MyBase.UseSQL)

        'If drPageSize.Read Then
        '    m_PageSize = CType((CommonFunctions.Data.CheckIsDBNull(drPageSize("IBRowsPerPage"), "20")), Long)
        'Else 'if not set then default
        m_PageSize = 20 'Set as 20 records per Page
        'End If


        'CommonFunction.Data.DisposeDataReader(drPageSize)

        Dim dblRatio As Double = m_intActivityCount / m_PageSize

        If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        Dim strPaging As String
        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or dblRatio = 0 Then
            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            '''End of Modification by Dhanashri S on 7 Oct 2015
        End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intActivityCount / 20)).ToString + ">"


        strPaging += " of " + Math.Ceiling(dblRatio).ToString
        strPaging += "|<A href='javascript:Page_Onclick(""-1"")' TITLE='Show All Records'><B>All</B> </A>"
        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015

        If strPaging <> "" Then

            Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")


        End If


    End Sub
    Private Sub AddedRequirementDrawPaging()
        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        Else
            m_intPageNumber = 1
        End If
        'Dim drPageSize As IDataReader
        'drPageSize = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_IB_DefaultSettings " + m_ProjectId.ToString & ",'" + m_LoginType + "'," & m_UserId.ToString, MyBase.UseSQL)

        'If drPageSize.Read Then
        '    m_PageSize = CType((CommonFunctions.Data.CheckIsDBNull(drPageSize("IBRowsPerPage"), "20")), Long)
        'Else 'if not set then default
        m_PageSize = 20 'Set as 20 records per Page
        'End If


        'CommonFunction.Data.DisposeDataReader(drPageSize)

        Dim dblRatio As Double = m_intActivityCount / m_PageSize

        If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        Dim strPaging As String
        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage1()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage1()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or dblRatio = 0 Then
            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber1", "txtPageNumber1", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber1", "txtPageNumber1", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            '''End of Modification by Dhanashri S on 7 Oct 2015 
        End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage1()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage1()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intActivityCount / 20)).ToString + ">"


        strPaging += " of " + Math.Ceiling(dblRatio).ToString
        strPaging += "|<A href='javascript:Page_Onclick(""-1"")' TITLE='Show All Records'><B>All</B> </A>"

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages1", "txtNoOfPages1", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015 

        If strPaging <> "" Then

            Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")


        End If


    End Sub
    'End Modified By Syamantak Chavan On 30 sept 2011 for Whizible Sem 10.0
    Private Sub PlotGrid(ByVal Flag As String, ByVal FromDate As String, ByVal ToDate As String)
        Dim drDailyActivity As IDataReader
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList

        Dim arrCheckBox() As String = {"", "", "", "", "", "chkDelete"}
        Dim arrGrouping() As String = {"1"}
        Dim arrWidthArray() As String = {"", "style='width:30%'", "style='width:10%' align=center", "style='width:40%'", "style='width:10%'", "style='width:10%' align=center"}
        Dim arrColRowLinks() As String = {"", "", "", "Edit_OnClick()", ""}

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        strSQL.Remove(0, strSQL.ToString.Length)
        strSQL.Append("Exec Usp_Sel_YesterdayActivity " + m_strSessionProjectID + ",'" + Flag + "','" + FromDate + "','" + ToDate + "',''")


        arrColumnHeadingList.Add("Date")
        arrColumnHeadingList.Add("Type")
        arrColumnHeadingList.Add("ID")
        arrColumnHeadingList.Add("Name")
        arrColumnHeadingList.Add("Project")
        arrColumnHeadingList.Add("By Person")


        arrActualColumnNames.Add("Date")
        arrActualColumnNames.Add("Type")
        arrActualColumnNames.Add("EntityID")
        arrActualColumnNames.Add("Name")
        arrActualColumnNames.Add("Project")
        arrActualColumnNames.Add("ByPerson")

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            '.GroupOnColumn = arrGrouping
            .NoOfDataColumns = 6
            .TDStyleArray = arrWidthArray
            '.CheckBoxIDArray = arrCheckBox
            '.DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .RowLinkArray = arrColRowLinks
            .SQL = strSQL.ToString
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .PrimaryKey = "ID"
            .PageSize = m_PageSize
            .CurrentPage = m_intPageNumber
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()

        End With
        m_objGrid = Nothing
        strSQL.Remove(0, strSQL.ToString.Length)
    End Sub

    Function GetShortDate(ByVal dTDate As Date) As String
        '=====================================================================
        ' Procedure Name        : GetShortDate()	
        ' Purpose               : Returns the day for the date passed to this function
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VivekP
        ' Created               : 25 Apr 2005
        ' Revisions             :
        '=====================================================================
        Dim intDate As Integer
        Dim strMonth As String

        intDate = Day(dTDate)
        strMonth = MonthName(Month(dTDate), True) + " " + CType(intDate, String)

        GetShortDate = strMonth

    End Function
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VivekP
        ' Created               : 25 Apr 2005
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()        
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    '--- added By purvaJ on 6 nov 2008 whiziblesem8.0 for Holiday or leave changes
    Private Sub m_objAdvGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objAdvGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex >= 2 And Args.ColIndex < 9 Then
            If IsHolidayOrLeave(Args.ColIndex - 2) = True Or Args.ColIndex - 2 > intWorkingDays - 1 Then
                Args.TDStyle = "style='color:red;text-align:right;'"
            End If
        End If
    End Sub
    '--- End addition purvaJ

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "TYPE" Then
            Cancel = True
            Dim strHTML As String
            If Args.DataReader("Type").ToString.ToUpper = "RELEASE" Then
                strHTML = "<TD  style='width:30%' title=""Type""> <IMG src=""../../Images/Scrum/Release.gif""> </TD>"
            ElseIf Args.DataReader("Type").ToString.ToUpper = "ISSUE" Then
                strHTML = "<TD  style='width:30%' title=""Type""> <IMG src=""../../Images/Scrum/Bug.gif""> </TD>"
            ElseIf Args.DataReader("Type").ToString.ToUpper = "FEATURE" Then
                strHTML = "<TD  style='width:30%' title=""Type""> <IMG src=""../../Images/Scrum/Feature.gif""> </TD>"
            ElseIf Args.DataReader("Type").ToString.ToUpper = "TASK" Then
                strHTML = "<TD  style='width:30%' title=""Type""> <IMG src=""../../Images/Scrum/Task.gif""> </TD>"
            ElseIf Args.DataReader("Type").ToString.ToUpper = "USER STORY" Then
                strHTML = "<TD  style='width:30%' title=""Type""> <IMG src=""../../Images/Scrum/UserStory.gif""> </TD>"
            End If

            Args.StringToBeInserted = strHTML
            'Args.ApplyHTMLEncode = False
        End If
        If Args.DataField.ToUpper = "NAME" Then
            Cancel = True
            Dim strHTML As String
            strHTML = "<td  vAlign=top style='width:40%' title=""Name""> <A href=""JavaScript:Edit_OnClick('" + Args.DataReader("EntityID").ToString + "','" + Args.DataReader("Type").ToString + "')"">" + Args.DataReader("Name").ToString + "</A></td>"
            Args.StringToBeInserted = strHTML
        End If
    End Sub
End Class