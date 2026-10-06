'**********************************************************************************
'                  CSPL Code Header
' Project Name     :	WhizibleSEM v10.0
' Module Name      :	PM_DailyProgress.aspx
' Purpose          :	To display Daily Progress for Agile Methodology
' Description      :	To display Daily Progress for Agile Methodology
' Assumptions      :	None.
' Dependencies     :	
' Author           :	Syamantak Chavan
' Reviewed         :	
' Tested           :	
' Created          :	30 June 2011
' Revisions        :			
'**********************************************************************************
Imports CommonFunctions.General
Imports CommonFunctions.Data
Partial Public Class PM_DailyProgress
    Inherits WebPages.Template.WhizTemplate

#Region " Variable Declaration"
    Protected m_strWindowTitle As String
    Protected m_strFlag As String
    Private m_objMenu As WebPages.Template.StaticMenu
    Private m_strSessionProjectID As String        'For storing the Project ID from Session

    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private strSQL As New System.Text.StringBuilder       'Tos Store the SQL statements
    Private m_PageSize As Long 'PageSize
    Protected m_intPageNumber As Integer
    Private m_intSummaryCount As Long
    Private m_dtFromDate As Date                        'From Date 
    Private m_dtToDate As Date
    Private m_intNoOfDays As Integer
    Private ReleaseID As Integer
    Private StoryOrBug As String
    Private m_strMode As String
#End Region

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
        m_strWindowTitle = MyBase.GetResourceString("PAGE_TITLE")
    End Sub

    Public Sub PageInit()
        ''Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
          MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        Dim arrDailyActivityEntryIDs() As String
        Dim drCompanyInformation As IDataReader
        Dim drProjectsOnHold As IDataReader
        Dim drResourceLevelTaskCompletion As IDataReader
        Dim strSQL As String
        Dim strSqlDate As String
        Dim drDate As IDataReader

        m_strSessionProjectID = CType(Session("intProjectID"), String)
        If Not Request.QueryString("ReleaseID") Is Nothing Then
            ReleaseID = CType(Request.QueryString("ReleaseID"), Integer)
        End If
        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        Else
            m_intPageNumber = 1
        End If
        If Request.QueryString("MODE") <> "" Then
            m_strMode = Request.QueryString("MODE")
        Else
            m_strMode = ""
        End If
        If Not Request.QueryString("StoryOrBug") Is Nothing Then
            StoryOrBug = Request.QueryString("StoryOrBug").ToString
            If StoryOrBug = "User Story" Then
                StoryOrBug = "1"
            Else
                StoryOrBug = "2"
            End If
        Else
            StoryOrBug = ""
        End If

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSqlDate = "Select StartDate,EndDate from tbl_PM_ScrumRelease where ReleaseID= " & ReleaseID
        strSqlDate = "usp_sel_tbl_PM_ScrumRelease_StartDate_EndDate " & ReleaseID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        drDate = CommonFunctions.Data.GetDataReader(strSqlDate, MyBase.UseSQL)
        While drDate.Read
            m_dtFromDate = CType(CommonFunctions.Data.CheckIsDBNull(drDate("StartDate"), "0"), Date)
            m_dtToDate = CType(CommonFunctions.Data.CheckIsDBNull(drDate("EndDate"), "0"), Date)
        End While
        CommonFunctions.Data.DisposeDataReader(drDate)
        '---------------------------------
        If m_strMode <> "" Then

            Dim sbHTMLExcel As New StringBuilder
            sbHTMLExcel.Append("<div id='PageDiv' style='width:99.99%;height:450px;overflow:auto'>")
            sbHTMLExcel.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
            sbHTMLExcel.Append("<thead class='clsTRColumnHeader'>")
            sbHTMLExcel.Append("<BR>")
            sbHTMLExcel.Append("<th style='text-align:center'>Daily Progress Report </th>")
            sbHTMLExcel.Append("<BR>")
            sbHTMLExcel.Append("<th style='text-align:center'>For " + Request.QueryString("StoryOrBug").ToString + "</th>")
            sbHTMLExcel.Append("<BR>")
            sbHTMLExcel.Append("<th style='text-align:center'>From:" + m_dtFromDate + " To:" + m_dtToDate + " </th>")
            sbHTMLExcel.Append("</thead></table>")
            sbHTMLExcel.Append("<BR>")
            sbHTMLExcel.Append(DisplayGrid("1"))
            sbHTMLExcel.Append("</div>")
            ExporttoExcel(sbHTMLExcel.ToString)
            Response.End()
            sbHTMLExcel = Nothing
        End If
        '----------------------------------------
        DrawMenu(True)
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        'Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True) + vbCrLf)
        Response.Write("<DIV id=DivList style='Overflow:auto;width:100%;Height:480px'><table CellSpacing='0' class='clsTable' width='99.9%'><tr class='clsTREven' width='99.9%'><td width='100%' align=LEFT>")

        CommonFunctions.General.WriteHTML("<Script Language=Javascript> intMaxEntry = (0 - 0); </Script>")

        CommonFunctions.General.WriteHTML("<table CellSpacing='0' width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'><td align='left'><b>Daily Progress</b></td><td align='right'>")
        CommonFunctions.General.WriteHTML("</td></tr class='clsTRSectionHeader'></table>")
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True) + vbCrLf)
        CommonFunctions.General.WriteHTML("<table><tr>")
        CommonFunctions.General.WriteHTML("<TD>Release")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD align=left >")
        'CommonFunctions.HTMLControls.DrawComboBox("cboRelease", "Select ReleaseID,ReleaseName from tbl_PM_ScrumRelease order by ReleaseName", 120, , "Onchange=javascript:cboRelease_OnChange()", True)

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''CommonFunctions.HTMLControls.DrawComboBox("cboRelease", "Select ReleaseID,ReleaseName from tbl_PM_ScrumRelease Where ProjectID=" + m_strSessionProjectID + " order by ReleaseName", 120, CommonFunctions.General.CheckIsNothing(CType(ReleaseID, String), ""), "Onchange=javascript:cboRelease_OnChange()", True, , , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboRelease", "usp_sel_tbl_PM_ScrumRelease_ReleaseID_ReleaseName " + m_strSessionProjectID, 120, CommonFunctions.General.CheckIsNothing(CType(ReleaseID, String), ""), "Onchange=javascript:cboRelease_OnChange()", True, , , True)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("<TD style='FONT-WEIGHT:bold'>From")
        If ReleaseID <> 0 Then
            CommonFunctions.General.WriteHTML("<TD style='FONT-WEIGHT:bold'>From")
            CommonFunctions.General.WriteHTML(": " + CStr(CommonFunctions.Dates.CGetDate(m_dtFromDate)))
            CommonFunctions.General.WriteHTML("  To  " + CStr(CommonFunctions.Dates.CGetDate(m_dtToDate)))
            CommonFunctions.General.WriteHTML("</TD>")
        End If
        CommonFunctions.General.WriteHTML("<TD>Type")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.HTMLControls.DrawComboBox("cboStoryBug", "select '1','User Story'", 120, StoryOrBug, "Onchange=javascript:cboStoryBug_OnChange()", True, , , True)

        CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("<TD>Show")

        'CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</tr></table>")
        CommonFunctions.General.WriteHTML("<BR>")

        'AssignIterationSummaryCount()
        If Request.QueryString("ReleaseID") <> "" And Request.QueryString("StoryOrBug") <> "" Then
            AssignCount()
            DrawPaging()
        End If

        PlotGrid()
        If Request.QueryString("ReleaseID") <> "" And Request.QueryString("StoryOrBug") <> "" Then
            CommonFunctions.General.WriteHTML("<TABLE id=""tblLegends"" cellSpacing=""2"" cellPadding=""4"">")
            CommonFunctions.General.WriteHTML("<TR>")
            CommonFunctions.General.WriteHTML("<TD style="" WIDTH:5%;"">")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD><b>Legends:</b>")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("<TR>")
            CommonFunctions.General.WriteHTML("<TD style=""BACKGROUND: #B20000; WIDTH:5%;""><SPAN style=""PADDING-RIGHT: 1px; PADDING-LEFT: 1px; BACKGROUND: #ff0000; PADDING-BOTTOM: 1px; PADDING-TOP: 1px; WIDTH:30PX;""></SPAN>")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD><i>Remaining time increased</i>")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("<TR>")
            CommonFunctions.General.WriteHTML("	<TD style=""BACKGROUND: #FFFF00;WIDTH:5%;""><SPAN style=""PADDING-RIGHT: 2px; PADDING-LEFT: 2px; BACKGROUND: #FFFF00; PADDING-BOTTOM: 2px; PADDING-TOP: 2px; WIDTH:30PX;""></SPAN>")
            CommonFunctions.General.WriteHTML("	</TD>")
            CommonFunctions.General.WriteHTML("	<TD><i>Remaining time decreased, but spent effort already exceeds the estimate</i>")
            CommonFunctions.General.WriteHTML("	</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("<TR>")
            CommonFunctions.General.WriteHTML("	<TD style=""BACKGROUND: #90EE90; WIDTH:5%;""><SPAN style=""PADDING-RIGHT: 2px; PADDING-LEFT: 2px; BACKGROUND: #7CFC00; PADDING-BOTTOM: 2px; PADDING-TOP: 2px; WIDTH:30PX;""></SPAN>")
            CommonFunctions.General.WriteHTML("	</TD>")
            CommonFunctions.General.WriteHTML("	<TD><i>Remaining time decreased and spent effort does not exceed the estimate</i>")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("<TR>")
            CommonFunctions.General.WriteHTML("	<TD style=""BACKGROUND: #808080; WIDTH:5%;""><SPAN style=""PADDING-RIGHT: 2px; PADDING-LEFT: 2px; BACKGROUND: #808080; PADDING-BOTTOM: 2px; PADDING-TOP: 2px; WIDTH:30PX;""></SPAN>")
            CommonFunctions.General.WriteHTML("	</TD>")
            CommonFunctions.General.WriteHTML("<TD><i>Assignable is closed</i>")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("</TABLE>")
        End If

        Response.Write("</td></tr></table></div></td>")
        'Response.Write("</td></tr></table></div></td>")

        'CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:480px'>")
        'CommonFunctions.General.WriteHTML("<Script Language=Javascript> intMaxEntry = (0 - 0); </Script>")

        'CommonFunctions.General.WriteHTML("<table CellSpacing='0' width='99.9%' class='clsTable'>")
        'CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'><td align='left'>Iteration Summary</td><td align='right'>")
        'CommonFunctions.General.WriteHTML("</td></tr class='clsTRSectionHeader'></table><br><br>")
        'PlotList()

        'CommonFunctions.General.WriteHTML("</DIV>")
        DrawPageHeaderFooter()
        DrawMenu(False)
    End Sub
    Private Sub DrawPaging()

        m_PageSize = 20 'Set as 20 records per Page
        
        Dim dblRatio As Double = m_intSummaryCount / m_PageSize

        If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        Dim strPaging As String
        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or dblRatio = 0 Then
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Else
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intSummaryCount / 20)).ToString + ">"
        strPaging += " of " + Math.Ceiling(dblRatio).ToString
        strPaging += "|<A href='javascript:Page_Onclick(""-1"")' TITLE='Show All Records'><B>All</B> </A>"
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        If strPaging <> "" Then
            Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=left>" + strPaging + "</TD></TR></Table>")
        End If

    End Sub
    Private Sub AssignCount()
        Dim drDailyProgress As IDataReader
        If Request.QueryString("StoryOrBug").ToString = "User Story" Then
            drDailyProgress = CommonFunctions.Data.GetDataReader("Exec Usp_Sel_DailyProgress " + Request.QueryString("ReleaseID") + ",NULL,NULL,'I_Count'", MyBase.UseSQL)
        ElseIf Request.QueryString("StoryOrBug").ToString = "Bugs" Then
            drDailyProgress = CommonFunctions.Data.GetDataReader("Exec Usp_Sel_DailyProgress " + Request.QueryString("ReleaseID") + ",NULL,NULL,'T_Count'", MyBase.UseSQL)
        End If
        If drDailyProgress.Read Then
            m_intSummaryCount = CType((CommonFunctions.Data.CheckIsDBNull(drDailyProgress("Count"), "20")), Long)
        End If
    End Sub
    

    Private Sub DrawPageHeaderFooter()
        '=====================================================================
        ' Procedure Name        : DrawPageHeaderFooter()	
        ' Purpose               : Plots the Page Header.
        ' Description           : same as above
        ' Parameters Passed     : None 
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Syamantak Chavan
        ' Created               : 
        ' Revisions             :
        '=====================================================================


        Dim strHTML As String = ""
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter

        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_FOOTER


        objHeaderFooter.HeaderFooter = MyBase.GetResourceString("FOOTERNOTE").ToString

        strHTML = objHeaderFooter.DrawHeaderFooter(, True)
        If strHTML <> "" Then
            CommonFunctions.General.WriteHTML(strHTML + "<BR>")
        End If

    End Sub

    Private Sub DrawPageLegend()
        '=====================================================================
        ' Procedure Name        : DrawPageLegend()	
        ' Purpose               : Plots the Page Legend.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Syamantak Chavan
        ' Created               :
        ' Revisions             :
        '=====================================================================

        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)
    End Sub

    Private Sub PlotGrid()
        Dim drDailyActivity As IDataReader
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrIgnoreHTMLEncode As New ArrayList
        Dim arrCheckBox() As String = {"", "", ""}
        Dim arrGrouping() As String = {"1"}
        'Dim arrWidthArray() As String = {"style='width:10%'align=center", "style='width:20%'", "style='width:20%' align=left"}
        Dim arrColRowLinks() As String = {"", "", "", ""}
        Dim strSqlDate As String
        Dim drDate As IDataReader
        Dim dtCounterDate As Date
        Dim intCnt As Integer
        Dim ColumnCnt As Integer
        Dim strWeekDayName As String
        Dim arrstrTDStyle As New ArrayList
        Dim intWidth As Integer

        ReleaseID = Request.QueryString("ReleaseID")
        StoryOrBug = Request.QueryString("StoryOrBug")
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSqlDate = "Select StartDate,EndDate from tbl_PM_ScrumRelease where ReleaseID= " & ReleaseID
        strSqlDate = "usp_sel_tbl_PM_ScrumRelease_StartDate_EndDate " & ReleaseID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        drDate = CommonFunctions.Data.GetDataReader(strSqlDate, MyBase.UseSQL)
        While drDate.Read
            m_dtFromDate = CType(CommonFunctions.Data.CheckIsDBNull(drDate("StartDate"), "0"), Date)
            m_dtToDate = CType(CommonFunctions.Data.CheckIsDBNull(drDate("EndDate"), "0"), Date)
        End While
        CommonFunctions.Data.DisposeDataReader(drDate)
        '--- Get the No of days between the Start Date and End Date
        m_intNoOfDays = CType(DateDiff("d", CDate(m_dtFromDate), CDate(m_dtToDate)) + 1, Integer)
        dtCounterDate = m_dtFromDate

        strSQL.Remove(0, strSQL.ToString.Length)

        strSQL.Append("Exec Usp_Sel_DailyProgress " + ReleaseID.ToString + ",'" + m_dtFromDate.ToString + "','" + m_dtToDate.ToString + "','" + StoryOrBug + "'")

        If Request.QueryString("StoryOrBug") = "User Story" Then
            arrColumnHeadingList.Add("UserStoryID")
            arrstrTDStyle.Add("style='width=0'")
            arrActualColumnNames.Add("UserStoryID")
        ElseIf Request.QueryString("StoryOrBug") = "Bugs" Then
            arrColumnHeadingList.Add("IssueID")
            arrstrTDStyle.Add("style='width=0'")
            arrActualColumnNames.Add("IssueID")
        End If
        arrColumnHeadingList.Add("Type")
        arrColumnHeadingList.Add("Name")
        arrColumnHeadingList.Add("Assigned To")
        arrColumnHeadingList.Add("Effort")
        'arrColumnHeadingList.Add("")

        arrstrTDStyle.Add("style='width=10%' bgcolor='#E6F9FF'")
        arrstrTDStyle.Add("style='width:25px' 'bgcolor='#E6F9FF'")
        arrstrTDStyle.Add("style='width=15%' 'bgcolor='#E6F9FF'")
        arrstrTDStyle.Add("style='width=10%' 'bgcolor='#E6F9FF'")

        arrActualColumnNames.Add("Type")
        arrActualColumnNames.Add("Name")
        arrActualColumnNames.Add("AssignedTo")
        arrActualColumnNames.Add("Effort")
        'arrActualColumnNames.Add("A_UserStories")
        ColumnCnt = m_intNoOfDays + 5
        'intWidth = m_intNoOfDays \ 50

        For intCnt = 1 To m_intNoOfDays
            '-- Set the WeekDays
            'strWeekDayName = vbCrLf + "" + CStr(GetShortDate(dtCounterDate))
            strWeekDayName = GetShortDate(dtCounterDate)
            '----  for Holiday, Leave and weekend changes.

            'blnFlag = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_DA_HolidayORLeaveStatus " + m_intUserID.ToString + ",'" + dtCounterDate + "'", True), "0"), "0"))
            'If blnFlag = True Then
            '    blnFlag = False
            '    arrstrUserFriendlyList.Add("<FONT color='RED'>" + strWeekDayName + "</FONT>")
            'Else
            '    '--- End addition purvaJ
            arrColumnHeadingList.Add(strWeekDayName)
            'End If
            arrActualColumnNames.Add("")
            dtCounterDate = DateAdd("d", 1, dtCounterDate)           
            arrstrTDStyle.Add("")
            'arrstrRowLinkField.Add("")
            'arrstrTDStyle.Add("style='width=" + CStr(intWidth) + "%' align=right")
            'arrstrSummaryFunctionsList.Add("SUM")
            'arrGroupSummaryFunctions.Add("SUM")
            arrIgnoreHTMLEncode.Add("1")
        Next intCnt

        
        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            '.GroupOnColumn = arrGrouping
            .NoOfDataColumns = ColumnCnt
            .TDStyleArray = GetArray(arrstrTDStyle)
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

            'If ReleaseID <> "" And StoryOrBug <> "" Then
            '    .DrawGrid()
            'End If
            If Request.QueryString("ReleaseID") <> "" And Request.QueryString("StoryOrBug") <> "" Then
                .DrawGrid()
            End If

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
        ' Author                : Syamantak Chavan
        ' Created               : June 30, 2011
        ' Revisions             :
        '=====================================================================
        Dim intDate As Integer
        Dim strMonth As String

        intDate = Day(dTDate)
        strMonth = MonthName(Month(dTDate), True) + CType(intDate, String)
        GetShortDate = strMonth

    End Function

    'Private Sub PlotList()

    'End Sub


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
        ' Author                : NitinC
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu
        'Added If condition by NitinC on 26 Dec 2011 For WhizibleSEM 11.0 - Agile Module (Issue Fix 57613)
        If CheckIsNothing(Request.QueryString("ShowBack"), "") = "1" Then
            'If Request.QueryString("Link") = "True" Then
            arrMenuCaptionsList.Add("Back")
            arrMenuToolTipsList.Add(MyBase.GetResourceString("BACK"))
            arrClientSideFunctionList.Add("Back_OnClick()")
            'End If
        End If
        'End of Added If condition by NitinC on 26 Dec 2011 For WhizibleSEM 11.0 - Agile Module (Issue Fix 57613)
        If Request.QueryString("ReleaseID") <> "" And Request.QueryString("StoryOrBug") <> "" Then
            arrMenuCaptionsList.Add("Export To Excel")
            arrMenuToolTipsList.Add(MyBase.GetResourceString("EXPORT"))
            arrClientSideFunctionList.Add("Export_OnClick()")
        End If
        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("TOOLTIP_MENU_HELP"))
        arrClientSideFunctionList.Add("Help_OnClick('Iteration_Summary')")
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
        ' Author                : NitinC
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function


    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Dim TodayDate As String
        Dim strHTML As String
        TodayDate = MonthName(Month(DateTime.Now), True) + CType(Day(DateTime.Now), String)
        If Args.DataField.ToUpper = "USERSTORYID" Then
            Cancel = True
        End If
        If Args.DataField.ToUpper = "ISSUEID" Then
            Cancel = True
        End If
        If Args.DataField.ToUpper = TodayDate.ToUpper Then
            Cancel = True
            strHTML = "<td ><FONT color='RED'><b>Today</b></FONT></td>"
            Args.StringToBeInserted = strHTML
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        Dim DailyProgressData As IDataReader
        Dim strHTML As String

        If Args.DataReader("Type").ToString.ToUpper = "TASK" And Args.DataField.ToUpper = "EFFORT" Then
            Cancel = True
            strHTML = "<td width='10%' align='right' bgcolor='#CFE0E6'  >" + Args.DataReader("Effort").ToString + " h</td>"
            Args.StringToBeInserted = strHTML
        ElseIf Args.DataField.ToUpper = "EFFORT" Then
            Cancel = True
            strHTML = "<td width='10%' align='right' bgcolor='#E6F9FF'  >" + Args.DataReader("Effort").ToString + " h</td>"
            Args.StringToBeInserted = strHTML
        End If
        If Args.DataReader("Type").ToString.ToUpper = "TASK" And Args.ColumnName.ToUpper = "NAME" Then
            Cancel = True
            strHTML = "<td align='right' bgcolor='#CFE0E6'>" + Args.DataReader("Name").ToString + "</td>"
            Args.StringToBeInserted = strHTML
        End If
        If Args.DataReader("Type").ToString.ToUpper = "TASK" And Args.DataField.ToUpper = "ASSIGNEDTO" Then
            Cancel = True
            strHTML = "<td width='10%' align='left' bgcolor='#CFE0E6'  >" + Args.DataReader("AssignedTo").ToString + "</td>"
            Args.StringToBeInserted = strHTML
        ElseIf Args.DataField.ToUpper = "ASSIGNEDTO" Then
            Cancel = True
            strHTML = "<td width='10%' align='left' bgcolor='#E6F9FF'  >" + Args.DataReader("AssignedTo").ToString + "</td>"
            Args.StringToBeInserted = strHTML
        End If
        'CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        If Args.DataField.ToUpper = "USERSTORYID" Then
            Cancel = True
        End If
        If Args.DataField.ToUpper = "ISSUEID" Then
            Cancel = True
        End If
        If Args.DataField.ToUpper = "TYPE" Then
            If Args.DataReader("Type").ToString.ToUpper = "USER STORY" Then
                Cancel = True
                strHTML = "<td width='100'  bgcolor='#E6F9FF' Title='User Story'><IMG src=""../../Images/Scrum/UserStory.gif""></td>"
                Args.StringToBeInserted = strHTML
                m_strFlag = "USERSTORY"

            End If

            If Args.DataReader("Type").ToString.ToUpper = "TASK" Then
                Cancel = True
                strHTML = "<td width='100'  bgcolor='#CFE0E6' Title='Task'>  <IMG src=""../../Images/Scrum/Task.gif""></td>"
                Args.StringToBeInserted = strHTML
                m_strFlag = "TASK"
            End If
        End If


        If Args.DataReader("Type").ToString.ToUpper = "USER STORY" And Args.ColumnName.ToUpper = "NAME" Then
            Cancel = True
            strHTML = "<td width='10%' bgcolor='#E6F9FF'><A href=""JavaScript:Name_OnClick('" + Args.DataReader("UserStoryID").ToString + "','" + m_strFlag + "')"" >" + Args.DataReader("Name").ToString + "</A></br></td>"
            Args.StringToBeInserted = strHTML
        End If
        If Request.QueryString("StoryOrBug") = "Bugs" Then
            If Args.DataField.ToUpper = "TYPE" Then
                If Args.DataReader("Type").ToString.ToUpper = "BUGS" Then
                    Cancel = True
                    strHTML = "<td width='100' Title='Bug' bgcolor='#E6F9FF'><IMG src=""../../Images/Scrum/Bug.gif""></td>"
                    Args.StringToBeInserted = strHTML
                    m_strFlag = "BUGS"

                End If
            End If
            If Args.ColumnName.ToUpper = "NAME" Then
                Cancel = True
                strHTML = "<td align='left' bgcolor='#E6F9FF'>" + Args.DataReader("Name").ToString + "</td>"
                Args.StringToBeInserted = strHTML
            End If
        End If

        If Args.DataField.ToUpper <> "USERSTORYID" And Args.DataField.ToUpper <> "ISSUEID" And Args.DataField.ToUpper <> "TYPE" And Args.DataField.ToUpper <> "NAME" And Args.DataField.ToUpper <> "ASSIGNEDTO" And Args.DataField.ToUpper <> "EFFORT" Then
            Dim arr() As String = Args.DataReader(Args.DataField.ToString).ToString.Split(",")
            If arr(0) = "Green" Then
                Cancel = True
                strHTML = "<td title='Time Spent:" + arr(2) + "h |ETC Time:" + arr(3) + "h' style='width:10%'align=center bgcolor='#90EE90'>" + arr(1) + "</td>"
                Args.StringToBeInserted = strHTML
            ElseIf arr(0) = "Gray" Then
                Cancel = True
                strHTML = "<td title='Time Spent:" + arr(2) + "h |ETC Time:" + arr(3) + "h |Assignable is closed' style='width:10%'align=center bgcolor='#808080'>" + arr(1) + "</td>"
                Args.StringToBeInserted = strHTML
            ElseIf arr(0) = "Yellow" Then
                Cancel = True
                strHTML = "<td title='Time Spent:" + arr(2) + "h |ETC Time:" + arr(3) + "h' style='width:10%'align=center bgcolor='#FFFF00'>" + arr(1) + "</td>"
                Args.StringToBeInserted = strHTML
            ElseIf arr(0) = "Red" Then
                Cancel = True
                strHTML = "<td title='Time Spent:" + arr(2) + "h |ETC Time:" + arr(3) + "h' style='width:10%'align=center bgcolor='#B20000'>" + arr(1) + "</td>"
                Args.StringToBeInserted = strHTML
            ElseIf Args.DataReader("Type").ToString.ToUpper = "TASK" Then
                Cancel = True
                strHTML = "<td style='width:10%'align=center bgcolor='#CFE0E6'> </td>"
                Args.StringToBeInserted = strHTML
            Else
                Cancel = True
                strHTML = "<td style='width:10%'align=center bgcolor='#E6F9FF'> </td>"
                Args.StringToBeInserted = strHTML
            End If
        End If

        'If Args.DataReader("Type").ToString.ToUpper = "BUGS" Then
        '    Cancel = True
        '    strHTML = "<td width='100' TITLE='ITERATION' >  <IMG src=""../../Images/Scrum/Bug.gif""></td>"
        '    Args.StringToBeInserted = strHTML
        '    m_strFlag = "BUGS"
        'End If


        'If Args.DataField.ToUpper = "A_USERSTORIES" Then
        '    Cancel = True
        '    strHTML += "<td   valign='top'><table><tr class='clsTREven'><td></td><td>User Stories</td><td>Bugs</td><td>Features</td><td>Effort</td><td>Test Cases</td></tr><tr class='clsTREven'><td>Assigned</td>"
        '    strHTML += "<td>" + Args.DataReader("A_UserStories").ToString + "</td>"
        '    strHTML += "<td>" + Args.DataReader("A_Issues").ToString + "</td>"
        '    strHTML += "<td>" + Args.DataReader("A_Features").ToString + "</td>"
        '    strHTML += "<td>" + Args.DataReader("A_Effort").ToString + " h</td>"
        '    strHTML += "<td>" + Args.DataReader("A_TestCases").ToString + "</td><td></td></tr>"
        '    strHTML += "<tr class='clsTREven'><td><font color='Green'>Completed</font></td>"
        '    strHTML += "<td><font color='Green'>" + Args.DataReader("C_UserStories").ToString + "</font></td>"
        '    strHTML += "<td><font color='Green'>" + Args.DataReader("C_Issues").ToString + "</font></td>"
        '    strHTML += "<td><font color='Green'>" + Args.DataReader("C_Features").ToString + "</font></td>"
        '    strHTML += "<td><font color='Green'>" + Args.DataReader("C_Effort").ToString + " h</font></td>"
        'If P_Efforts > 100 Then
        '    strHTML += "<td><font color='Green'>" + Args.DataReader("C_TestCases").ToString + "</font></td><td><span id=""pr1""></span><div title='Progress Status' class='rankBar' style='width: 50px'><div class='rankFilledBar' style='width: " + CType(P_Efforts, String) + "%'>&nbsp;</div></div><font color='Red'>Exceeded by " + CType(P_Efforts - 100, String) + "%</font></td></tr></table></td></tr>"
        'Else
        '    strHTML += "<td><font color='Green'>" + Args.DataReader("C_TestCases").ToString + "</font></td><td><span id=""pr1""></span><div title='Progress Status' class='rankBar' style='width: 50px'><div class='rankFilledBar' style='width: " + CType(P_Efforts, String) + "%'>&nbsp;</div></div></td></tr></table></td></tr>"
        'End If

        '    'If Args.DataReader("FinalStatus").ToString.ToUpper = "TRUE" Then
        '    '    strHTML += "<tr class='clsTREven'><td width='100' TITLE='Type' ></td><td  valign='top'><HR></td><td   valign='top'><HR><table><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr class='clsTREven'><td></td><td></td>"
        '    '    strHTML = "<td></td><td></td><td> </td><td></td></tr><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr></table></td></tr>"
        '    'Else
        '    '    strHTML += "<tr class='clsTREven'><td width='100' TITLE='Type' ></td><td  valign='top'></td><td   valign='top'><table><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr class='clsTREven'><td></td><td></td>"
        '    '    strHTML += "<td></td><td></td><td> </td><td></td></tr><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr></table></td></tr>"
        '    'End If
        '    Args.StringToBeInserted = strHTML
        'End If

    End Sub
    Protected Sub ExporttoExcel(ByVal strCode As String)
        Dim strCode1 As String
        Dim intSearchCount As Integer
        Dim strcodeBuilder As New StringBuilder
        Dim m_strWindowTitle As String
        strCode1 += ("</TR></tABLE></Center>")

        m_strWindowTitle = "Daily Progress"
        Dim strsearch As String = "<td class=clsTDColumnSeparator  rowspan=" + intSearchCount.ToString + " width=1pt></td>"
        strcodeBuilder.Append(strCode)
        strcodeBuilder = strcodeBuilder.Replace("<Table", "<TABLE style=""FONT-SIZE: 8pt"" border=1 ")
        strcodeBuilder = strcodeBuilder.Replace("<img src='../../Images/minus.gif' border=0>", "")
        strcodeBuilder = strcodeBuilder.Replace(strsearch, "")

        Dim intStart, intEnd, intLength As Integer
        strCode = strcodeBuilder.ToString
        strcodeBuilder.Remove(0, strcodeBuilder.Length)
        PrintExcelDoc(strCode1 + strCode)
    End Sub
    Protected Sub PrintExcelDoc(ByVal query As String)
        '====================================================================
        ' Procedure Name        : PrintExcelDoc
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To export the report in Excel Format
        ' Description           : To export the report in Excel Format
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 24 Jun 2009
        ' Revisions             :
        '=====================================================================
        Dim strBody As New System.Text.StringBuilder("")


        strBody.Append("<html " & _
          "xmlns:o='urn:schemas-microsoft-com:office:office' " & _
          "xmlns:w='urn:schemas-microsoft-com:office:Excel'" & _
          "xmlns='http://www.w3.org/TR/REC-html40'>" & _
          "<head><title>Time</title>")

        'The setting specifies document's view after it is downloaded as Print instead of the default Web Layout
        strBody.Append("<!--[if gte mso 9]>" & _
         "<xml>" & _
         "<w:ExcelDocument>" & _
         "<w:View>Print</w:View>" & _
         "<w:Zoom>90</w:Zoom>" & _
         "<w:DoNotOptimizeForBrowser/>" & _
         "</w:ExcelDocument>" & _
         "</xml>" & _
         "<![endif]-->")

        strBody.Append("<style>" & _
           "<!-- /* Style Definitions */" & _
           "@page Section1" & _
           "   {size:8.5in 12in; " & _
           "   margin:0.5in 0.5in 0.5in 0.5in ; " & _
           "   mso-header-margin:.5in; " & _
           "   mso-footer-margin:.5in; mso-paper-source:0;size:landscape;}" & _
           " div.Section1" & _
           "   {page:Section1;}" & _
           "-->" & _
          "</style></head>")

        strBody.Append("<body lang=EN-US style='tab-interval:.5in'>" & _
          "<div class=Section1><font face='Verdana' size=10><p>" & query.ToString & "</p></font></div></body></html>")


        strBody = strBody.Replace("–", "-")
        strBody = strBody.Replace("‘", "'")
        strBody = strBody.Replace("’", "'")
        Dim m_filepath As String
        Dim Logfile As String
        m_filepath = Server.MapPath("../../Reports/")
        Logfile = CommonFunctions.FileDirectory.GetUniqueFileName("XLS")
        CommonFunctions.FileDirectory.WriteFileStream(m_filepath, Logfile, strBody.ToString)


        CommonFunctions.General.WriteHTML("<Script language=javascript>")
        CommonFunctions.General.WriteHTML("window.open(""../CRW/CRW_ReportOutput.aspx?filename=" + Logfile + ""","""",""menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,width=500,height=500"");")
        CommonFunctions.General.WriteHTML("window.close();")
        CommonFunctions.General.WriteHTML("</Script>")
    End Sub
    Private Function DisplayGrid(ByVal intExport) As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim StrSQL As String
        Dim dt As DataTable
        Dim StrValue As String        
        Dim strSqlDate As String
        Dim drDate As IDataReader
        Dim dtCounterDate As Date
        Dim intCnt As Integer
        Dim intRowCount As Integer
        Dim intColCount As Integer
        Dim strWeekDayName As String

        ReleaseID = Request.QueryString("ReleaseID")
        StoryOrBug = Request.QueryString("StoryOrBug")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSqlDate = "Select StartDate,EndDate from tbl_PM_ScrumRelease where ReleaseID= " & ReleaseID
        strSqlDate = "usp_sel_tbl_PM_ScrumRelease_StartDate_EndDate " & ReleaseID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        drDate = CommonFunctions.Data.GetDataReader(strSqlDate, MyBase.UseSQL)
        While drDate.Read
            m_dtFromDate = CType(CommonFunctions.Data.CheckIsDBNull(drDate("StartDate"), "0"), Date)
            m_dtToDate = CType(CommonFunctions.Data.CheckIsDBNull(drDate("EndDate"), "0"), Date)
        End While
        CommonFunctions.Data.DisposeDataReader(drDate)
        m_intNoOfDays = CType(DateDiff("d", CDate(m_dtFromDate), CDate(m_dtToDate)) + 1, Integer)
        dtCounterDate = m_dtFromDate

        StrSQL = "Exec Usp_Sel_DailyProgress " & ReleaseID.ToString & ",'" & m_dtFromDate.ToString & "','" & m_dtToDate.ToString & "','" & StoryOrBug & "'"
        dt = CommonFunction.Data.GetDataTable(StrSQL, True)
        sbHtml.Append("<div ID=divTblGrid style='overflow:scroll; width:100%;height:380px'>")    
        sbHtml.Append("<Table name='Plan' id='Plan' class='clsGridTable' width=120% cellspacing=1 cellpadding=0>")
        sbHtml.Append("<thead class='clsTRColumnHeader'>" + vbCrLf)
        sbHtml.Append("<TH class='FixedTD' align='Left' style='width:20px;'>Type</TH>")
        sbHtml.Append("<TH class='FixedTD' align='Left' style='width:20px;'>Name</TH>")
        sbHtml.Append("<TH class='FixedTD' align='Left' style='width:20px;'>Assigned To</TH>")
        sbHtml.Append("<TH class='FixedTD' align='Left' style='width:20px;'>Effort</TH>")

        For intCnt = 1 To m_intNoOfDays
            strWeekDayName = vbCrLf + "" + CStr(GetShortDate(dtCounterDate))
            sbHtml.Append("<TH class='FixedTD' align='Left' style='width:20px;'>" + strWeekDayName + "</TH>")
            dtCounterDate = DateAdd("d", 1, dtCounterDate)
        Next intCnt
        sbHtml.Append("</thead>")

        For intRowCount = 0 To dt.Rows.Count - 1
            sbHtml.Append("<tr class='clsTROdd'>")
            For intColCount = 1 To dt.Columns.Count - 1
                StrValue = dt.Rows(intRowCount)(intColCount)
                If StrValue.Contains(",") Then
                    'StrValue = StrValue.Substring(StrValue.IndexOf(",") + 1)
                    StrValue = StrValue.Split(",")(1)
                    sbHtml.Append("<td  vAlign=top style='width=10%'>" + StrValue + "</td>")
                Else
                    If intColCount > 4 Then
                        'sbHtml.Append("<td  vAlign=top style='width=10%'>" + StrValue + "</td>")
                        sbHtml.Append("<td  vAlign=top style='width=10%'> </td>")
                    Else
                        sbHtml.Append("<td  vAlign=top style='width=10%'>" + StrValue + "</td>")
                    End If
                End If

            Next intColCount
            sbHtml.Append("</tr>")
        Next intRowCount

        If intExport = "1" Then
            DisplayGrid = sbHtml.ToString
        End If
    End Function
End Class

