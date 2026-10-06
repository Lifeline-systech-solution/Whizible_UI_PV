Public Partial Class PM_Prioritization
    Inherits WebPages.Template.WhizTemplate

#Region " Variable Declaration"
    Protected m_strWindowTitle As String
    Protected m_strFlag As String
    Private m_objMenu As WebPages.Template.StaticMenu
    Protected m_strSessionProjectID As String        'For storing the Project ID from Session
    Dim sbHTML As New System.Text.StringBuilder

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

        Dim isList As String
        Dim isStory As String
        Dim isBug As String
        Dim isFeature As String
        If Not Request.QueryString("isList") Is Nothing Then
            isList = CType(Request.QueryString("isList"), String).ToUpper()
        Else
            isList = "0"
        End If
        If Not Request.QueryString("isStory") Is Nothing Then
            isStory = CType(Request.QueryString("isStory"), String).ToUpper()
        Else
            isStory = "0"
        End If
        If Not Request.QueryString("isBug") Is Nothing Then
            isBug = CType(Request.QueryString("isBug"), String).ToUpper()
        Else
            isBug = "0"
        End If
        'Commented By Syamantak Chavan on 23-August-2011 to remove Feature Combo
        'If Not Request.QueryString("isFeature") Is Nothing Then
        '    isFeature = CType(Request.QueryString("isFeature"), String).ToUpper()
        'Else
        '    isFeature = "0"
        'End If
        'End Commented By Syamantak Chavan on 23-August-2011 to remove Feature Combo

        Dim arrDailyActivityEntryIDs() As String
        Dim drCompanyInformation As IDataReader
        Dim drProjectsOnHold As IDataReader
        Dim drResourceLevelTaskCompletion As IDataReader
        Dim strSQL As String
        Dim objDynamicLink As WebPages.UI.cDynamicLink
        m_strSessionProjectID = CType(Session("intProjectID"), String)

        DrawMenu(True)

        '<input type="checkbox" name="vehicle" value="Bike" />
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:480px'>")
        CommonFunctions.General.WriteHTML("<Script Language=Javascript> intMaxEntry = (0 - 0); </Script>")

        CommonFunctions.General.WriteHTML("<table CellSpacing='0' width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'><td align='left'>Prioritize/Plan Your Backlog</td></tr><tr><td align='center'>")
        ''***********
        sbHTML.Append("<TABLE id='tblSearch'  cellspacing=0 cellpadding=0 Width='250px'  class=clsTable><TR class=clsTREven valign=left>")
        sbHTML.Append("<td Width='30%' NoWrap title='UserStory' >")
        If isStory = 1 Then
            sbHTML.Append("<input type=""checkbox"" id=""chkStory"" name=""chkStory"" value="""" onclick=""GetPrioritizeList()"" checked/>")
        Else
            sbHTML.Append("<input type=""checkbox"" id=""chkStory"" name=""chkStory"" value="""" onclick=""GetPrioritizeList()""/>")

        End If
        sbHTML.Append("<IMG src=""../../Images/Scrum/UserStory.gif"">")
        sbHTML.Append("</td>")
        sbHTML.Append("<td Width='30%' NoWrap title='Bug' >")
        ''Commented by NitinC on 05 April 2012 For WhizibleSEM 11.0
        If isBug = 1 Then
            sbHTML.Append("<input type=""checkbox"" id=""chkBug"" name=""chkBug"" value="""" onclick=""GetPrioritizeList()"" checked style=""display:none""/>")
        Else

            sbHTML.Append("<input type=""checkbox"" id=""chkBug"" name=""chkBug"" value="""" onclick=""GetPrioritizeList()"" style=""display:none""/>")
        End If
        'sbHTML.Append("<IMG src=""../../Images/Scrum/Bug.gif"">")
        ''End of Commented by NitinC on 05 April 2012 For WhizibleSEM 11.0
        sbHTML.Append("</td>")
        'Commented By Syamantak Chavan on 23-August-2011 to remove Feature Combo
        'sbHTML.Append("<td Width='30%' NoWrap title='Feature' >")
        'If isFeature = 1 Then
        '    sbHTML.Append("<input type=""checkbox"" id=""chkFeature"" name=""chkFeature"" value="""" onclick=""GetPrioritizeList()"" checked/>")
        'Else
        '    sbHTML.Append("<input type=""checkbox"" id=""chkFeature"" name=""chkFeature"" value="""" onclick=""GetPrioritizeList()"" />")
        'End If
        'sbHTML.Append("<IMG src=""../../Images/Scrum/Feature.gif"">")
        'sbHTML.Append("</td>")
        'End Commented By Syamantak Chavan on 23-August-2011 to remove Feature Combo
        sbHTML.Append("<td align=center Width='10%'>")
        'DELETED BY AMIT MAHADIK 0N 25 JULY 2011
        'objDynamicLink = New WebPages.UI.cDynamicLink
        'objDynamicLink.LinkName = "Show"
        'objDynamicLink.Tooltip = "Show"
        'objDynamicLink.FunctionName = "Show_OnClick()"
        'objDynamicLink.ReturnHTML = True
        'sbHTML.Append(" |<B>" + objDynamicLink.GetDynamicLink() + "</B>| ")
        'objDynamicLink = Nothing
        'END DELETED BY AMIT MAHADIK 0N 25 JULY 2011
        sbHTML.Append("</td></tr>")
        sbHTML.Append("</Table><br>")
        CommonFunctions.General.WriteHTML(sbHTML.ToString())
        ''***********
        CommonFunctions.General.WriteHTML("</td></tr></table><br><br>")
        PlotList()
        CommonFunctions.General.WriteHTML("</DIV>")
        DrawPageHeaderFooter()
        DrawMenu(False)

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
        ' Author                : Amit Mahadik
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
        ' Author                : Amit Mahadik
        ' Created               :
        ' Revisions             :
        '=====================================================================

        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)
    End Sub

    Private Sub PlotList()
        '=====================================================================
        ' Procedure Name        : PlotList()	
        ' Purpose               : Plots the List of items to Prioritize from three tables
        '                                   1)[tbl_PM_ScrumUserStory]
        '                                   2)[tbl_PM_ScrumIssue]
        '                                   3)[tbl_PM_ScrumFeature]
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amit Mahadik
        ' Created               : 
        ' Revisions             :
        '=====================================================================



        CommonFunction.General.WriteHTML("<div id='divList' style='Overflow:auto;width:100%;'>")
        Dim isList As String
        Dim isStory As String
        Dim isBug As String
        Dim isFeature As String
        If Not Request.QueryString("isList") Is Nothing Then
            isList = CType(Request.QueryString("isList"), String).ToUpper()
        Else
            isList = "0"
        End If
        If Not Request.QueryString("isStory") Is Nothing Then
            isStory = CType(Request.QueryString("isStory"), String).ToUpper()
        Else
            isStory = "0"
        End If
        If Not Request.QueryString("isBug") Is Nothing Then
            isBug = CType(Request.QueryString("isBug"), String).ToUpper()
        Else
            isBug = "0"
        End If
        'Commented By Syamantak Chavan on 23-August-2011 to remove Feature Combo
        'If Not Request.QueryString("isFeature") Is Nothing Then
        '    isFeature = CType(Request.QueryString("isFeature"), String).ToUpper()
        'Else
        '    isFeature = "0"
        'End If
        'End Commented By Syamantak Chavan on 23-August-2011 to remove Feature Combo
        Dim drPrioritization As IDataReader
        Dim strScrumPrioritizeID As String
        'Commented By Syamantak Chavan on 23-August-2011 to remove Feature Combo
        'Dim strSQLQuery As String = "Exec usp_sel_Prioritize_Ins_tbl_PM_ScrumPrioritize " + isList + "," + isStory + "," + isBug + "," + isFeature + "," + m_strSessionProjectID
        Dim strSQLQuery As String = "Exec usp_sel_Prioritize_Ins_tbl_PM_ScrumPrioritize " + isList + "," + isStory + "," + isBug + "," + m_strSessionProjectID
        ''List  :  usp_sel_Prioritize_Ins_tbl_PM_ScrumPrioritize 1,0,0,0,90
        ''insert:  usp_sel_Prioritize_Ins_tbl_PM_ScrumPrioritize 0,0,0,0,90
        ''Parameters:
        ''@isList BIT,
        ''@isStory BIT,
        ''@isBug BIT,
        ''@isFeature BIT,
        ''@ProjectID INT


        drPrioritization = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'CommonFunction.General.WriteHTML("<table id='tblList' CELLSPACING='0' class='clsTable' width='99.9%'><tr class='clsTRColumnHeader' style=""font-weight:bold;""><td align='Left' title='ID' width='50'></td><td>")
        CommonFunction.General.WriteHTML("<table id='tblList' CELLSPACING='0' class='clsTable' width='99.9%' border=1><tr><td>")
        CommonFunction.General.WriteHTML("<table width='100%' CellSpacing=""0"" CellPadding=""0"" ><tr class='clsTRColumnHeader' style=""font-weight:bold;"">")
        CommonFunction.General.WriteHTML("<td align='Left' title='ID' width='50'>ID</td>")
        CommonFunction.General.WriteHTML("<td align='Left' title='Type' width='50'>Type</td>")
        CommonFunction.General.WriteHTML("<td align='Left' title='Name' width='250'>Name</td>")
        CommonFunction.General.WriteHTML("<td align='Left' title='ID' width='50'>Entity ID</td>")
        CommonFunction.General.WriteHTML("<td align='Left' title='State' width='100'>State</td>")
        CommonFunction.General.WriteHTML("<td align='Left' title='Effort' width='50'>Effort</td>")
        CommonFunction.General.WriteHTML("<td align='center' title='Business Value' width='100'>Business Value</td>")
        CommonFunction.General.WriteHTML("</tr></table></td></tr>")

        While drPrioritization.Read
            strScrumPrioritizeID = drPrioritization("ScrumPrioritizeID").ToString()
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHid", "txtHid" + strScrumPrioritizeID, , , , strScrumPrioritizeID, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
            'CommonFunction.General.WriteHTML("<td width='50'><a href=""#""  title='Edit Efforts' onclick='javascript:EditRow(" + strScrumPrioritizeID + ")' style=""text-decoration:none;vertical-align:bottom;"">Edit Efforts</a></td>")
            CommonFunction.General.WriteHTML("<td onmouseup=""CancelDrag();"" class=""SpecimenLoc"" onmousedown=""BeginDrag(this.id);"" id=" + strScrumPrioritizeID + " onmouseover=""setTarget(this.id);this.style.cursor='move';"" style="""" onmouseout=""this.style.cursor='default';"" target=""true"" SpecimenId=" + strScrumPrioritizeID + "><table width='100%' CellSpacing=""0"" CellPadding=""0"" ><tr class='clsTREven'>")
            CommonFunction.General.WriteHTML("<td align='Left' title='ID' width='50'>" + strScrumPrioritizeID + "</td>")
            'If drPrioritization("Type").ToString.ToUpper = "FEATURE" Then
            '    CommonFunction.General.WriteHTML("<td align='Left' title='Type' width='50'><IMG src=""../../Images/Scrum/Feature.gif""></td>")
            '    m_strFlag = "FEATURE"
            'Else
            If drPrioritization("Type").ToString.ToUpper = "ISSUE" Then
                CommonFunction.General.WriteHTML("<td align='Left' title='Type' width='50'><IMG src=""../../Images/Scrum/Bug.gif""></td>")
                m_strFlag = "ISSUE"
            ElseIf drPrioritization("Type").ToString.ToUpper = "STORY" Then
                CommonFunction.General.WriteHTML("<td align='Left' title='Type' width='50'><IMG src=""../../Images/Scrum/UserStory.gif""></td>")
                m_strFlag = "STORY"
            End If
            CommonFunction.General.WriteHTML("<td align='Left' title='Name' width='250'>" + drPrioritization("Name").ToString() + "</td>")
            CommonFunction.General.WriteHTML("<td align='Left' title='ID' width='50'>" + drPrioritization("EntityID").ToString() + "</td>")
            CommonFunction.General.WriteHTML("<td align='Left' title='State' width='100'>" + drPrioritization("State").ToString() + "</td>")
            CommonFunction.General.WriteHTML("<td align='Left' title='Effort' width='50'" + drPrioritization("ScrumPrioritizeID").ToString() + ">" + drPrioritization("Effort").ToString() + "</td>")
            CommonFunction.General.WriteHTML("<td align='center' title='Business Value' width='100'>" + drPrioritization("BusinessValue").ToString() + "</td>")
            CommonFunction.General.WriteHTML("</tr></table></td></tr>")
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
        ' Author                : Amit Mahadik
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu

        'Added by NitinC on 14 July 2011 For WhizibleSEM v10.0 (Agile Methodology)
        arrMenuCaptionsList.Add("Plan Your Backlog")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("TOOLTIP_MENU_HELP"))
        arrClientSideFunctionList.Add("ShowFloatingmenu('Efforts',event)")
        'strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        'End Addition
        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("TOOLTIP_MENU_HELP"))
        arrClientSideFunctionList.Add("Help_OnClick('Prioritization')")
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
        ' Author                : Amit Mahadik
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
