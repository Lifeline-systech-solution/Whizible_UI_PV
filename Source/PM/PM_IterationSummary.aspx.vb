'**********************************************************************************
'                  CSPL Code Header
' Project Name     :	WhizibleSEM v10.0
' Module Name      :	PM_IterationSummary.aspx
' Purpose          :	To display Iteration summary for Agile Methodology
' Description      :	To display Iteration summary for Agile Methodology
' Assumptions      :	None.
' Dependencies     :	
' Author           :	NitinC
' Reviewed         :	
' Tested           :	
' Created          :	09 June 2011
' Revisions        :			
'**********************************************************************************
Imports CommonFunctions.General
Imports CommonFunctions.Data
Partial Public Class PM_IterationSummary
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

        m_strSessionProjectID = CType(Session("intProjectID"), String)

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
        'Code added by Syamantak Chavan On 12 July 2011 for Export to Excel Functionality
        '---------------------------------
        If m_strMode <> "" Then

            Dim sbHTMLExcel As New StringBuilder
            sbHTMLExcel.Append("<div id='PageDiv' style='width:99.99%;height:450px;overflow:auto'>")
            sbHTMLExcel.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
            sbHTMLExcel.Append("<thead class='clsTRColumnHeader'>")
            sbHTMLExcel.Append("<BR>")
            sbHTMLExcel.Append("<th style='text-align:center'>Sprint summary Report </th>")
            sbHTMLExcel.Append("<BR>")
            'sbHTMLExcel.Append("<th style='text-align:center'>For " + Request.QueryString("StoryOrBug").ToString + "</th>")
            sbHTMLExcel.Append("<BR>")
            'sbHTMLExcel.Append("<th style='text-align:center'>From </th>")
            sbHTMLExcel.Append("</thead></table>")
            sbHTMLExcel.Append("<BR>")
            sbHTMLExcel.Append(DisplayGrid("1"))
            sbHTMLExcel.Append("</div>")
            ExporttoExcel(sbHTMLExcel.ToString)
            Response.End()
            sbHTMLExcel = Nothing
        End If
        '----------------------------------------
        'End Code added by Syamantak Chavan On 12 July 2011 for Export to Excel Functionality
        DrawMenu(True)
        Response.Write("<DIV id=DivList style='Overflow:auto;width:100%;Height:480px'><table CellSpacing='0' class='clsTable' width='99.9%'><tr class='clsTREven' width='99.9%'><td width='100%' align=LEFT>")

        CommonFunctions.General.WriteHTML("<Script Language=Javascript> intMaxEntry = (0 - 0); </Script>")

        CommonFunctions.General.WriteHTML("<table CellSpacing='0' width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'><td align='left'><b>Sprint Summary</b></td><td align='right'>")
        CommonFunctions.General.WriteHTML("</td></tr class='clsTRSectionHeader'></table><br><br>")
        AssignIterationSummaryCount()
        DrawPaging()
        PlotGrid()
        Response.Write("</td></tr></table></div></td>")

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

        'Dim drPageSize As IDataReader
        'drPageSize = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_IB_DefaultSettings " + m_ProjectId.ToString & ",'" + m_LoginType + "'," & m_UserId.ToString, MyBase.UseSQL)

        'If drPageSize.Read Then
        '    m_PageSize = CType((CommonFunctions.Data.CheckIsDBNull(drPageSize("IBRowsPerPage"), "20")), Long)
        'Else 'if not set then default
        m_PageSize = 20 'Set as 20 records per Page
        'End If


        'CommonFunction.Data.DisposeDataReader(drPageSize)

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

            Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")


        End If


    End Sub
    Private Sub AssignIterationSummaryCount()
        Dim drIterationSummary As IDataReader
        drIterationSummary = CommonFunctions.Data.GetDataReader("Exec Usp_Sel_IterationSummary " + m_strSessionProjectID.ToString + ",'I_Count'", MyBase.UseSQL)
        If drIterationSummary.Read Then
            m_intSummaryCount = CType((CommonFunctions.Data.CheckIsDBNull(drIterationSummary("Count"), "20")), Long)
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
        ' Author                : NitinC
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
        ' Author                : NitinC
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

        Dim arrCheckBox() As String = {"", "", ""}
        Dim arrGrouping() As String = {"1"}
        Dim arrWidthArray() As String = {"style='width:10%'", "style='width:30%'", "style='width:60%' align=center"}
        Dim arrColRowLinks() As String = {"", "", "", ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL.Remove(0, strSQL.ToString.Length)
        strSQL.Append("Exec Usp_Sel_IterationSummary " + m_strSessionProjectID.ToString)


        arrColumnHeadingList.Add("Type")
        arrColumnHeadingList.Add("Name")
        arrColumnHeadingList.Add("")


        arrActualColumnNames.Add("Type")
        arrActualColumnNames.Add("Name")
        arrActualColumnNames.Add("A_UserStories")


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
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()

        End With
        m_objGrid = Nothing
        strSQL.Remove(0, strSQL.ToString.Length)
    End Sub


    Private Sub PlotList()
        '=====================================================================
        ' Procedure Name        : PlotList()	
        ' Purpose               : Plots the List of Iteration Summary for Agile Methodology.
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



        CommonFunction.General.WriteHTML("<div id='divList' style='Overflow:auto;width:100%;'>")

        Dim drIterationSummary As IDataReader
        Dim A_Efforts As Integer
        Dim C_Efforts As Integer
        Dim P_Efforts As Integer
        Dim strSQLQuery As String = "Exec Usp_Sel_IterationSummary " + m_strSessionProjectID.ToString
        drIterationSummary = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        CommonFunction.General.WriteHTML("<table id='tblList' CELLSPACING='0' class='clsTable' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRColumnHeader'>")
        CommonFunction.General.WriteHTML("<td align='Left' TITLE='Name' width='100'>Type</td>")
        CommonFunction.General.WriteHTML("<td align='Left' TITLE='Name' width='250'>Name</td>")
        CommonFunction.General.WriteHTML("<td align='center' TITLE='Info' width='150'></td><td align='center' TITLE='Status' width='150'></td></tr>")
        While drIterationSummary.Read
            A_Efforts = CType(drIterationSummary("A_Effort").ToString, Integer)
            C_Efforts = CType(drIterationSummary("C_Effort").ToString, Integer)
            If A_Efforts <> 0 Then
                P_Efforts = (C_Efforts * 100) / A_Efforts
            Else
                P_Efforts = 0
            End If

            CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
            If drIterationSummary("Type").ToString.ToUpper = "RELEASE" Then
                CommonFunction.General.WriteHTML("<td width='100' TITLE='RELEASE' ><IMG src=""../../Images/Scrum/Release.gif""></td>")
                m_strFlag = "RELEASE"
            ElseIf drIterationSummary("Type").ToString.ToUpper = "ITERATION" Then
                CommonFunction.General.WriteHTML("<td width='100' TITLE='ITERATION' >  <IMG src=""../../Images/Scrum/Iteration.gif""></td>")
                m_strFlag = "ITERATION"
            End If
            If drIterationSummary("DaysToGo").ToString = "" And drIterationSummary("DaysOver").ToString <> "" Then
                CommonFunction.General.WriteHTML("<td><A href=""JavaScript:Name_OnClick('" + drIterationSummary("EntityID").ToString + "','" + m_strFlag + "')"" >" + drIterationSummary("Name").ToString + "</A></br></br>Finish Date was <b>" + drIterationSummary("FinishDate").ToString + "</b></br></br> <-- <font color='brown'>" + drIterationSummary("DaysOver").ToString.Replace("-", "") + " days Over.</font></td>")
            ElseIf drIterationSummary("DaysToGo").ToString <> "" And drIterationSummary("DaysOver").ToString = "" Then
                CommonFunction.General.WriteHTML("<td><A href=""JavaScript:Name_OnClick('" + drIterationSummary("EntityID").ToString + "','" + m_strFlag + "')"" >" + drIterationSummary("Name").ToString + "</A></br></br>Finish Date is <b>" + drIterationSummary("FinishDate").ToString + "</b></br></br> <-- <font color='brown'>" + drIterationSummary("DaysToGo").ToString + " days to go.</font></td>")
            Else
                CommonFunction.General.WriteHTML("<td><A href=""JavaScript:Name_OnClick('" + drIterationSummary("EntityID").ToString + "','" + m_strFlag + "')"" >" + drIterationSummary("Name").ToString + "</A></td>")
            End If


            CommonFunction.General.WriteHTML("<td   valign='top'><table><tr class='clsTREven'><td></td><td>User Stories</td><td>Bugs</td><td>Features</td><td>Effort</td><td>Test Cases</td></tr><tr class='clsTREven'><td>Assigned</td>")
            CommonFunction.General.WriteHTML("<td>" + drIterationSummary("A_UserStories").ToString + "</td>")
            CommonFunction.General.WriteHTML("<td>" + drIterationSummary("A_Issues").ToString + "</td>")
            CommonFunction.General.WriteHTML("<td>" + drIterationSummary("A_Features").ToString + "</td>")
            CommonFunction.General.WriteHTML("<td>" + drIterationSummary("A_Effort").ToString + " h</td>")
            CommonFunction.General.WriteHTML("<td>" + drIterationSummary("A_TestCases").ToString + "</td><td></td></tr>")
            CommonFunction.General.WriteHTML("<tr class='clsTREven'><td><font color='Green'>Completed</font></td>")
            CommonFunction.General.WriteHTML("<td><font color='Green'>" + drIterationSummary("C_UserStories").ToString + "</font></td>")
            CommonFunction.General.WriteHTML("<td><font color='Green'>" + drIterationSummary("C_Issues").ToString + "</font></td>")
            CommonFunction.General.WriteHTML("<td><font color='Green'>" + drIterationSummary("C_Features").ToString + "</font></td>")
            CommonFunction.General.WriteHTML("<td><font color='Green'>" + drIterationSummary("C_Effort").ToString + " h</font></td>")
            If P_Efforts > 100 Then
                CommonFunction.General.WriteHTML("<td><font color='Green'>" + drIterationSummary("C_TestCases").ToString + "</font></td><td><span id=""pr1""></span><div title='Progress Status' class='rankBar' style='width: 50px'><div class='rankFilledBar' style='width: " + CType(P_Efforts, String) + "%'>&nbsp;</div></div><font color='Red'>Exceeded by " + CType(P_Efforts - 100, String) + "%</font></td></tr></table></td></tr>")
            Else
                CommonFunction.General.WriteHTML("<td><font color='Green'>" + drIterationSummary("C_TestCases").ToString + "</font></td><td><span id=""pr1""></span><div title='Progress Status' class='rankBar' style='width: 50px'><div class='rankFilledBar' style='width: " + CType(P_Efforts, String) + "%'>&nbsp;</div></div></td></tr></table></td></tr>")
            End If

            If drIterationSummary("FinalStatus").ToString.ToUpper = "TRUE" Then
                CommonFunction.General.WriteHTML("<tr class='clsTREven'><td width='100' TITLE='Type' ></td><td  valign='top'><HR></td><td   valign='top'><HR><table><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr class='clsTREven'><td></td><td></td>")
                CommonFunction.General.WriteHTML("<td></td><td></td><td> </td><td></td></tr><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr></table></td></tr>")
            Else
                CommonFunction.General.WriteHTML("<tr class='clsTREven'><td width='100' TITLE='Type' ></td><td  valign='top'></td><td   valign='top'><table><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr class='clsTREven'><td></td><td></td>")
                CommonFunction.General.WriteHTML("<td></td><td></td><td> </td><td></td></tr><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr></table></td></tr>")
            End If
        End While
        CommonFunction.General.WriteHTML("</table></div><br>")

        'CommonFunction.General.WriteHTML("<tr class='clsTREven'><td width='100' TITLE='Type' >Release</td><td  valign='top'>Release(1)</td>")
        'CommonFunction.General.WriteHTML("<td   valign='top'><table><tr class='clsTREven'><td></td><td>User Stories</td><td>Bugs</td><td>Features</td><td>Effort</td><td>Test Cases</td></tr><tr class='clsTREven'><td>Assigned</td>")
        'CommonFunction.General.WriteHTML("<td>0</td><td>1</td><td>0</td><td>0 h</td><td>Passed</td></tr><tr class='clsTREven'><td>Completed</td><td>0</td><td>0</td><td>0</td><td>0 h</td><td>Total 0</td></tr></table>")
        'CommonFunction.General.WriteHTML("</td></tr><tr class='clsTREven'><td width='100' TITLE='Type' ></td><td  valign='top'></td><td   valign='top'><table><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr class='clsTREven'><td></td><td></td>")
        'CommonFunction.General.WriteHTML("<td></td><td></td><td> </td><td></td></tr><tr class='clsTREven'><td></td><td></td><td></td><td></td><td> </td><td></td>")
        'CommonFunction.General.WriteHTML("</tr></table></td></tr><tr class='clsTREven'><td width='100' TITLE='Type' >Release</td><td  valign='top'>Release(1)</td><td   valign='top'><table><tr class='clsTREven'><td></td><td>User Stories</td><td>Bugs</td><td>Features</td><td>Effort</td><td>Test Cases</td></tr>")
        'CommonFunction.General.WriteHTML("<tr class='clsTREven'><td>Assigned</td><td>0</td><td>1</td><td>0</td><td>0 h</td><td>Passed</td></tr><tr class='clsTREven'><td>Completed</td><td>0</td><td>0</td><td>0</td><td>0 h</td><td>Total 0</td></tr></table></td></tr></table></div><br>")

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
            arrMenuCaptionsList.Add("Back")
            arrMenuToolTipsList.Add(MyBase.GetResourceString("BACK"))
            arrClientSideFunctionList.Add("Back_OnClick()")
        End If
        'End of Added If condition by NitinC on 26 Dec 2011 For WhizibleSEM 11.0 - Agile Module (Issue Fix 57613)
        arrMenuCaptionsList.Add("Export To Excel")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("EXPORT"))
        arrClientSideFunctionList.Add("Export_OnClick()")

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
        If Args.DataField.ToUpper = "A_USERSTORIES" Then
            Args.ColumnName = ""
        End If
       
    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        Dim drIterationSummary As IDataReader
        Dim A_Efforts As Integer
        Dim C_Efforts As Integer
        Dim P_Efforts As Integer
        Dim strHTML As String

        A_Efforts = CType(Args.DataReader("A_Effort").ToString, Integer)
        C_Efforts = CType(Args.DataReader("C_Effort").ToString, Integer)
        If A_Efforts <> 0 Then
            P_Efforts = (C_Efforts * 100) / A_Efforts
        Else
            P_Efforts = 0
        End If

        'CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        If Args.DataField.ToUpper = "TYPE" Then
            If Args.DataReader("Type").ToString.ToUpper = "RELEASE" Then
                Cancel = True
                strHTML = "<td width='100' TITLE='RELEASE' ><IMG src=""../../Images/Scrum/Release.gif""></td>"
                Args.StringToBeInserted = strHTML
                m_strFlag = "RELEASE"
            ElseIf Args.DataReader("Type").ToString.ToUpper = "ITERATION" Then
                Cancel = True
                strHTML = "<td width='100' TITLE='ITERATION' >  <IMG src=""../../Images/Scrum/Iteration.gif""></td>"
                Args.StringToBeInserted = strHTML
                m_strFlag = "ITERATION"
            End If
        End If
        If Args.DataField.ToUpper = "NAME" Then
            Cancel = True
            If Args.DataReader("DaysToGo").ToString = "" And Args.DataReader("DaysOver").ToString <> "" Then
                strHTML = "<td><A href=""JavaScript:Name_OnClick('" + Args.DataReader("EntityID").ToString + "','" + m_strFlag + "')"" >" + Args.DataReader("Name").ToString + "</A></br></br>Finish Date was <b>" + Args.DataReader("FinishDate").ToString + "</b></br></br> <-- <font color='brown'>" + Args.DataReader("DaysOver").ToString.Replace("-", "") + " days Over.</font></td>"
            ElseIf Args.DataReader("DaysToGo").ToString <> "" And Args.DataReader("DaysOver").ToString = "" Then
                strHTML = "<td><A href=""JavaScript:Name_OnClick('" + Args.DataReader("EntityID").ToString + "','" + m_strFlag + "')"" >" + Args.DataReader("Name").ToString + "</A></br></br>Finish Date is <b>" + Args.DataReader("FinishDate").ToString + "</b></br></br> <-- <font color='brown'>" + Args.DataReader("DaysToGo").ToString + " days to go.</font></td>"
            Else
                strHTML = "<td><A href=""JavaScript:Name_OnClick('" + Args.DataReader("EntityID").ToString + "','" + m_strFlag + "')"" >" + Args.DataReader("Name").ToString + "</A></td>"
            End If
            Args.StringToBeInserted = strHTML
        End If

        If Args.DataField.ToUpper = "A_USERSTORIES" Then
            Cancel = True
            ''Commented by NitinC on 23 Aug 2011 as it is showing Feature column
            'strHTML += "<td   valign='top'><table><tr class='clsTREven'><td></td><td>User Stories</td><td>Bugs</td><td>Features</td><td>Effort</td><td>Test Cases</td></tr><tr class='clsTREven'><td>Assigned</td>"
            strHTML += "<td   valign='top'><table><tr class='clsTREven'><td></td><td>User Stories</td><td>Bugs</td><td>Effort</td><td>Test Cases</td></tr><tr class='clsTREven'><td>Assigned</td>"
            ''End
            strHTML += "<td>" + Args.DataReader("A_UserStories").ToString + "</td>"
            strHTML += "<td>" + Args.DataReader("A_Issues").ToString + "</td>"
            ''Commented by NitinC on 23 Aug 2011 as it is showing Feature column
            'strHTML += "<td>" + Args.DataReader("A_Features").ToString + "</td>"
            ''End
            strHTML += "<td>" + Args.DataReader("A_Effort").ToString + " h</td>"
            strHTML += "<td>" + Args.DataReader("A_TestCases").ToString + "</td><td></td></tr>"
            strHTML += "<tr class='clsTREven'><td><font color='Green'>Completed</font></td>"
            strHTML += "<td><font color='Green'>" + Args.DataReader("C_UserStories").ToString + "</font></td>"
            strHTML += "<td><font color='Green'>" + Args.DataReader("C_Issues").ToString + "</font></td>"
            ''Commented by NitinC on 23 Aug 2011 as it is showing Feature column
            'strHTML += "<td><font color='Green'>" + Args.DataReader("C_Features").ToString + "</font></td>"
            ''End
            strHTML += "<td><font color='Green'>" + Args.DataReader("C_Effort").ToString + " h</font></td>"
            If P_Efforts > 100 Then
                strHTML += "<td><font color='Green'>" + Args.DataReader("C_TestCases").ToString + "</font></td><td><span id=""pr1""></span><div title='Completed Effort : " + CType(P_Efforts, String) + "%' class='rankBar' style='width: 50px'><div class='rankFilledBar' style='width: " + CType(P_Efforts, String) + "%'>&nbsp;</div></div><font color='Red'>Exceeded by " + CType(P_Efforts - 100, String) + "%</font></td></tr></table></td></tr>"
            Else
                strHTML += "<td><font color='Green'>" + Args.DataReader("C_TestCases").ToString + "</font></td><td><span id=""pr1""></span><div title='Completed Effort : " + CType(P_Efforts, String) + "%' class='rankBar' style='width: 50px'><div class='rankFilledBar' style='width: " + CType(P_Efforts, String) + "%'>&nbsp;</div></div></td></tr></table></td></tr>"
            End If

            'If Args.DataReader("FinalStatus").ToString.ToUpper = "TRUE" Then
            '    strHTML += "<tr class='clsTREven'><td width='100' TITLE='Type' ></td><td  valign='top'><HR></td><td   valign='top'><HR><table><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr class='clsTREven'><td></td><td></td>"
            '    strHTML = "<td></td><td></td><td> </td><td></td></tr><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr></table></td></tr>"
            'Else
            '    strHTML += "<tr class='clsTREven'><td width='100' TITLE='Type' ></td><td  valign='top'></td><td   valign='top'><table><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr class='clsTREven'><td></td><td></td>"
            '    strHTML += "<td></td><td></td><td> </td><td></td></tr><tr class='clsTREven'><td></td><td></td><td></td><td></td><td></td><td></td></tr></table></td></tr>"
            'End If
            Args.StringToBeInserted = strHTML
        End If
        
    End Sub
    'Code added by Syamantak Chavan On 12 July 2011 for Export to Excel Functionality
    Private Function DisplayGrid(ByVal intExport) As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim drIterationSummary As IDataReader
        Dim Type As String
        Dim Name As String
        Dim FinishDate As String


        Dim P_Efforts As String
        Dim DaysOver As String
        Dim DaysToGo As String
        Dim A_UserStories As String
        Dim A_Issues As String
        'Dim A_Features As String
        Dim A_Efforts As String
        Dim A_TestCases As String
        Dim C_UserStories As String
        Dim C_Issues As String
        'Dim C_Features As String
        Dim C_Efforts As String
        Dim C_TestCases As String


        Dim strSQLQuery As String = "Exec Usp_Sel_IterationSummary " + m_strSessionProjectID.ToString
        drIterationSummary = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        sbHtml.Append("<div ID=divTblGrid style='overflow:scroll; width:100%;height:380px'>")
        sbHtml.Append("<Table name='Plan' id='Plan' class='clsGridTable' width=120% cellspacing=1 cellpadding=0>")
        sbHtml.Append("<thead class='clsTRColumnHeader'>" + vbCrLf)
        sbHtml.Append("<th class='FixedTD' align='Left' style='width:20px;'>Type</th>")
        sbHtml.Append("<th class='FixedTD' align='Left' style='width:20px;'>Name</th>")
        sbHtml.Append("<th class='FixedTD' align='Left' style='width:20px;'></th>")
        sbHtml.Append("</thead>")
        While drIterationSummary.Read
            Type = drIterationSummary("Type").ToString
            Name = drIterationSummary("Name").ToString
            FinishDate = drIterationSummary("FinishDate").ToString
            DaysOver = drIterationSummary("DaysOver").ToString
            DaysToGo = drIterationSummary("DaysToGo").ToString
            A_UserStories = drIterationSummary("A_UserStories").ToString
            A_Issues = drIterationSummary("A_Issues").ToString
            'A_Features = drIterationSummary("A_Features").ToString
            A_Efforts = drIterationSummary("A_Effort").ToString
            A_TestCases = drIterationSummary("A_TestCases").ToString
            C_UserStories = drIterationSummary("C_UserStories").ToString
            C_Issues = drIterationSummary("C_Issues").ToString
            'C_Features = drIterationSummary("C_Features").ToString
            C_Efforts = drIterationSummary("C_Effort").ToString
            C_TestCases = drIterationSummary("C_TestCases").ToString
            '-------------------------------------
            
            sbHtml.Append("<tr class='clsTROdd'>")

            sbHtml.Append("<td width='100' TITLE='RELEASE' align='center'>" + Type + "</td>")
            sbHtml.Append("<td><table><tr class='clsTREven'><td>" + Name + "</td></tr></br></br><tr><td> Finish Date was <b>" + FinishDate + "</b></td></tr></br></br>")
            If drIterationSummary("DaysToGo").ToString <> "" Then
                sbHtml.Append("<tr><td> <-- <font color='brown'>" + DaysToGo + " days to go.</font></td></tr></table></td>")
            Else
                sbHtml.Append("<tr><td> <-- <font color='brown'>" + DaysOver + " days Over.</font></td></tr></table></td>")
            End If
            sbHtml.Append("<td   valign='top'>")
            sbHtml.Append("<table><tr class='clsTREven'><td></td>")
            sbHtml.Append("<td>User Stories</td>")
            sbHtml.Append("<td>Bugs</td>")
            'sbHtml.Append("<td>Features</td>")
            sbHtml.Append("<td>Effort</td>")
            sbHtml.Append("<td>Test Cases</td></tr>")
            sbHtml.Append("<tr class='clsTREven'>")
            sbHtml.Append("<td>Assigned</td>")
            sbHtml.Append("<td>" + A_UserStories + "</td>")
            sbHtml.Append("<td>" + A_Issues + "</td>")
            'sbHtml.Append("<td>" + A_Features + "</td>")
            sbHtml.Append("<td>" + A_Efforts + "h</td>")
            sbHtml.Append("<td>" + A_TestCases + "</td>")
            sbHtml.Append("</tr>")
            sbHtml.Append("<tr class='clsTREven'><td><font color='Green'>Completed</font></td>")
            sbHtml.Append("<td><font color='Green'>" + C_UserStories + "</font></td>")
            sbHtml.Append("<td><font color='Green'>" + C_Issues + "</font></td>")
            'sbHtml.Append("<td><font color='Green'>" + C_Features + "</font></td>")
            sbHtml.Append("<td><font color='Green'>" + C_Efforts + "h</font></td>")
            sbHtml.Append("<td><font color='Green'>" + C_TestCases + "</font></td></tr>")
            'sbHtml.Append("<td><span id='pr1'></span>")

            sbHtml.Append("</table></td></tr>")

            'sbHtml.Append("</tr>")
            'sbHtml.Append("</tr>")
            'sbHtml.Append("</td></tr></table></div></td><TABLE class=clsTable name=tblMenuBottom id=tblMenuBottom cellSpacing=0 cellPadding=0 width='99.9%'> <TR><TD><Table class=clsTable cellspacing=0 cellpadding=0 width='100%'><TR class=clsTRMenu><TD align=Right> | <A class='Menu' style='' onmouseover="this.style.backgroundColor='#FFD695'" onmouseout="this.style.backgroundColor=''"  onclick="Javascript:Help_OnClick('Iteration_Summary')" Title="" >?</A> | <A class='Menu' style='' onmouseover="this.style.backgroundColor='#FFD695'" onmouseout="this.style.backgroundColor=''"  onclick="Javascript:Export_OnClick()" Title="" >Export To Excel</A> |</TD></TR></TABLE></TD></TR></table>
            '-------------------------------------
        End While

        If intExport = "1" Then
            DisplayGrid = sbHtml.ToString
        End If
    End Function

    Protected Sub ExporttoExcel(ByVal strCode As String)
        Dim strCode1 As String
        Dim intSearchCount As Integer
        Dim strcodeBuilder As New StringBuilder
        Dim m_strWindowTitle As String
        strCode1 += ("</TR></tABLE></Center>")

        m_strWindowTitle = "Sprint summary"
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
    'End Of Code added by Syamantak Chavan On 12 July 2011 for Export to Excel Functionality
End Class