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
Partial Public Class PM_Scrum_ViewOtherReports
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

        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
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
            sbHTMLExcel.Append("</div>")
            Response.End()
            sbHTMLExcel = Nothing
        End If
        '----------------------------------------
        DrawMenu(True)
        Response.Write("<DIV id=DivList style='Overflow:auto;width:100%;Height:480px'>")
        
        DrawHTML()

        Response.Write("</div></td>")

      


        DrawPageHeaderFooter()



        DrawMenu(False)


    End Sub
    
    Private Sub DrawHTML()
        Dim strHTML As New StringBuilder

        strHTML.Append("<table cellpadding='5' cellspacing='5'>")
        strHTML.Append("<tr valign='top'><td>")
        strHTML.Append("<a style=""MARGIN-TOP: 0px; MARGIN-BOTTOM: 15px; FONT: bold 16px Arial; COLOR: #103565; text-decoration: underline;"">Planning</a>&nbsp <span>(5)</span>")
        strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'>")
        strHTML.Append("<table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/>")
        strHTML.Append("</td><td nowrap>")
        strHTML.Append("<a href = ""../PM/PM_DailyProgress.aspx?ShowBack=1&From=Employee&MasterTagID=8098&FromWhere=PM"">Daily Progress</a></td></tr></table></td><td>&nbsp;</td>")
        strHTML.Append("</tr></table><table cellpadding='3' cellspacing='1'>")
        strHTML.Append("<tr><td nowrap='nowrap'>")
        strHTML.Append("<table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td><td nowrap>")
        strHTML.Append("<a href = ""../PM/PM_IterationSummary.aspx?ShowBack=1&MasterTagID=8093&FromWhere=PM"">Sprint Summary</a></td></tr></table></td><td>&nbsp;</td>")
        strHTML.Append("</tr></table><table cellpadding='3' cellspacing='1'>")
        strHTML.Append("<tr><td nowrap='nowrap'><table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td>")
        strHTML.Append("<td nowrap><a href = ""../PM/ReleaseBurnDown_CommonList.aspx?MasterTagID=9011&FromWhere=PM"">Release Burn Down</a></td></tr></table></td><td>&nbsp;</td>")
        strHTML.Append("</tr></table><table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'>")
        strHTML.Append("<table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td><td nowrap>")
        strHTML.Append("<a href = ""../PM/IterationBurnDown_CommonList.aspx?MasterTagID=9012&FromWhere=PM"">Sprint Burn Down</a></td></tr></table></td><td>&nbsp;</td>")
        strHTML.Append("</tr></table>")
        'strHTML.Append("<table cellpadding='3' cellspacing='1'>")
        'strHTML.Append("<tr><td nowrap='nowrap'><table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td>")
        'strHTML.Append("<td nowrap><a href = ""http://localhost/TargetProcess2/Project/Reports/Report.aspx?acid=92D411B4525D51EDB5952F07EAB228FC&Report=IterationVelocityChart"">Iteration Velocity</a></td></tr></table></td><td>&nbsp;</td>")
        'strHTML.Append("</tr></table>")
        strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'>")
        strHTML.Append("<table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td>")
        strHTML.Append("<td nowrap><a href = ""../PM/UserStoryProgressReport_CommonList.aspx?MasterTagID=9000&FromWhere=PM"">User Stories Progress</a></td></tr></table></td><td>&nbsp;</td>")
        strHTML.Append("</tr></table>")
        'strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'>")
        'strHTML.Append("<table cellpadding='0' cellspacing='0'><tr><td><img class=""icon"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td>")
        'strHTML.Append("<td nowrap><a href = ""http://localhost/TargetProcess2/Project/Reports/Report.aspx?acid=92D411B4525D51EDB5952F07EAB228FC&Report=StoryStateChanges"">User Stories Dynamics</a></td></tr></table></td><td>&nbsp;</td>")
        'strHTML.Append("</tr></table>")

        ''Commented by NitinC on 27 April 2012 for WhizibleSEM 11.0 [Issue Fix : bacause of pivote table page crashed]
        'strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'><table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td>")
        'strHTML.Append("<td nowrap><a href = ""../PM/UserStoriesCountbyStatesBurnDown_CommonList.aspx?MasterTagID=9008&FromWhere=PM"">User Stories Count by States Burn Down</a></td></tr></table></td><td>&nbsp;</td>")
        'strHTML.Append("</tr></table>")
        ''End of Commented by NitinC on 27 April 2012 for WhizibleSEM 11.0 [Issue Fix : bacause of pivote table page crashed]

        'strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'><table cellpadding='0' cellspacing='0'><tr><td><img class=""icon"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td>")
        'strHTML.Append("<td nowrap><a href = ""http://localhost/TargetProcess2/Project/Reports/Report.aspx?acid=92D411B4525D51EDB5952F07EAB228FC&Report=Impediments"" >Impediments</a></td></tr></table></td><td>&nbsp;</td>")
        'strHTML.Append("</tr></table>")
        'strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'><table cellpadding='0' cellspacing='0'><tr><td><img class=""icon"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;"" /></td>")
        'strHTML.Append("<td nowrap><a href = ""http://localhost/TargetProcess2/Project/Reports/Report.aspx?acid=92D411B4525D51EDB5952F07EAB228FC&Report=CumulativeFlow"">Cumulative Flow</a></td></tr></table></td><td>&nbsp;</td>")
        'strHTML.Append("</tr></table>")
        'strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'><table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td>")
        'strHTML.Append("<td nowrap><a href = ""http://localhost/TargetProcess2/Project/Reports/Report.aspx?acid=92D411B4525D51EDB5952F07EAB228FC&Report=LeadAndCycleTiMe"">Lead and Cycle Time</a></td></tr></table></td><td>&nbsp;</td>")
        'strHTML.Append("</tr></table>")
        strHTML.Append("</td><td><a style=""MARGIN-TOP: 0px; MARGIN-BOTTOM: 15px; FONT: bold 16px Arial; COLOR: #103565; text-decoration: underline;"">Quality Assurance</a>&nbsp <span>(7)</span><table cellpadding='3' cellspacing='1'>")
        strHTML.Append("<tr><td nowrap='nowrap'><table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;"" /></td><td nowrap>")
        strHTML.Append("<a href = ""../PM/BugsbySeverity_CommonList.aspx?MasterTagID=9006&FromWhere=PM"">Bugs by Severity</a></td></tr></table></td><td>&nbsp;</td>")
        strHTML.Append("</tr></table><table cellpadding='3' cellspacing='1'> <tr>")
        strHTML.Append("<td nowrap='nowrap'><table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td><td nowrap>")
        strHTML.Append("<a href = ""../PM/BugProgressReport_CommonList.aspx?MasterTagID=9007&FromWhere=PM"" > Bugs Progress</a></td></tr></table></td><td>&nbsp;</td>")
        strHTML.Append("</tr></table>")
        'strHTML.Append("<table cellpadding='3' cellspacing='1'><tr>")
        'strHTML.Append("<td nowrap='nowrap'><table cellpadding='0' cellspacing='0'><tr><td><img class=""icon"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td><td nowrap>")
        'strHTML.Append("<a href = ""http://localhost/TargetProcess2/Project/Reports/Report.aspx?acid=92D411B4525D51EDB5952F07EAB228FC&Report=BugStateChanges"">Bugs Dynamics</a></td></tr></table></td><td>&nbsp;</td>")
        'strHTML.Append("</tr></table>")

        ''Commented by NitinC on 27 April 2012 for WhizibleSEM 11.0 [Issue Fix : bacause of pivote table page crashed]
        'strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'><table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;"" /></td><td nowrap>")
        'strHTML.Append("<a href = ""../PM/BugCountbyStatusBurnDown_CommonList.aspx?MasterTagID=9005&FromWhere=PM"">Bugs Count by States Burn Down</a></td></tr></table></td><td>&nbsp;</td>")
        'strHTML.Append("</tr></table>")
        ''End of Commented by NitinC on 27 April 2012 for WhizibleSEM 11.0 [Issue Fix : bacause of pivote table page crashed]

        strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'>")
        strHTML.Append("<table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td><td nowrap>")
        strHTML.Append("<a href = ""../PM/TestCasesbyUserStory_CommonList.aspx?MasterTagID=9004&FromWhere=PM"">Test Cases by User Story</a></td></tr></table></td><td>&nbsp;</td>")
        strHTML.Append("</tr></table><table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'>")
        strHTML.Append("<table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td><td nowrap>")
        strHTML.Append("<a href = ""../PM/TestRunsQualityReport_CommonList.aspx?MasterTagID=9002&FromWhere=PM"" > Test Runs by Release/Sprint</a></td></tr></table></td><td>&nbsp;</td></tr></table>")

        ''Test Case Details Report By User Story
        strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'>")
        strHTML.Append("<table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/>")
        strHTML.Append("</td><td nowrap><a href = ""../TCM/TCM_ShowReport.aspx?ReportID=2086&MasterTagID=9023&FromWhere=PM"">Test Case Details Report By User Story</a>")
        strHTML.Append("</td></tr></table></td><td>&nbsp;</td></tr></table>")
        ''Test Set Report By User Story
        strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'>")
        strHTML.Append("<table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/>")
        strHTML.Append("</td><td nowrap><a href = ""../TCM/TCM_ShowReport.aspx?ReportID=2084&MasterTagID=9024&FromWhere=PM"">Test Set Report By User Story</a>")
        strHTML.Append("</td></tr></table></td><td>&nbsp;</td></tr></table>")
        ''Test Session Summary Report By User Story
        strHTML.Append("<table cellpadding='3' cellspacing='1'><tr><td nowrap='nowrap'>")
        strHTML.Append("<table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/>")
        strHTML.Append("</td><td nowrap><a href = ""../TCM/TCM_ShowReport.aspx?ReportID=2083&MasterTagID=9025&FromWhere=PM"">Test Session Summary Report By User Story</a>")
        strHTML.Append("</td></tr></table></td><td>&nbsp;</td></tr></table>")


        strHTML.Append("</td><td><a style=""MARGIN-TOP: 0px; MARGIN-BOTTOM: 15px; FONT: bold 16px Arial; COLOR: #103565; text-decoration: underline;"">Time Tracking</a>&nbsp <span>(1)</span><table cellpadding='3' cellspacing='1'>")
        strHTML.Append("<tr><td nowrap='nowrap'><table cellpadding='0' cellspacing='0'><tr><td><img style=""MARGIN: 0px 5px 0px 0px; POSITION: relative; TOP: 2px"" src=""../../Images/Scrum/report.gif"" style=""border-width:0px;""/></td><td nowrap>")
        strHTML.Append("<a href = ""../PM/TimeByPerson_CommonList.aspx?MasterTagID=9009&FromWhere=PM"">Time By Person</a></td></tr></table></td><td>&nbsp;</td>")
        strHTML.Append("</tr></table></td></tr></table>")
        CommonFunctions.General.WriteHTML(strHTML.ToString)
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

        arrMenuCaptionsList.Add("?")
        'arrMenuCaptionsList.Add("Export To Excel")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("TOOLTIP_MENU_HELP"))
        'arrMenuToolTipsList.Add(MyBase.GetResourceString("EXPORT"))
        arrClientSideFunctionList.Add("Help_OnClick('Iteration_Summary')")
        'arrClientSideFunctionList.Add("Export_OnClick()")
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

End Class