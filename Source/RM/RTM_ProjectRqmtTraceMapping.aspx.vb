#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class RTM_ProjectRqmtTraceMapping
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

#Region "Member Variables"
    Protected m_intIndex As Double
    Protected strDivID As String
    Protected m_intPageNumberPM As Integer  'Currently Selected page number
    Protected m_intPageNumberDEL As Integer  'Currently Selected page number
    Protected m_intPageNumberTC As Integer  'Currently Selected page number
    Protected m_intPageNumberCR As Integer  'Currently Selected page number
    Protected m_strProjectRequirementID As String
    Protected m_strReqTRPhaseID As String
    Protected m_lngProjectId As Long
    Protected m_strToken As String

    Private m_PageSize As Long = 5
    Private m_intCount As Long
    Protected strTRClass As String
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.

    Private m_blnShowMenu As Boolean
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

        Dim arrMenu() As String = {"Close", "?"}
        Dim arrMenuToolTip() As String = {"Close", "Help"}
        Dim arrClientSideFunction() As String = {"Close_OnClick()", "Help_OnClick('Requirement Traceability Mapping')"}
        Dim strGrid As String

        'create the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True, "Requirement Traceability Mapping")

    End Sub

    Private Sub DrawGridTasks()
        Dim strSQL As String
        Dim arrIDList() As String
        Dim strHTML As String
        Dim strTRClass As String
        Dim strMenu As String
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList

        'Draw menu
        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList


        arrMenu.Add(MyBase.GetResourceString("MENU_ADD")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ADD")) : arrClientSideFunctions.Add("AddTasks_OnClick()")

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

        strSQL = "usp_Sel_RTM_RqmtTraceTaskMapping " + m_strReqTRPhaseID

        'Modified By GaneshG on 30-JUN-07 To Remove TS field from list
        'Dim arrstrUserFriendlyList() As String = {" ", "TS", "Is Task Complete", "Task", "Priority", "Status"}
        Dim arrstrUserFriendlyList() As String = {" ", "Is Task Complete", "Task", "Priority", "Status"}

        'Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%' title='Timesheet Details'", "style='width=5%' align='left'", "style='width=60%' align='left'", "style='width=10%' align='left'"}
        Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=5%' align='left'", "style='width=60%' align='left'", "style='width=10%' align='left'"}

        'Dim arrstrActualList() As String = {"ReqTitle", "TS", "IsTaskComplete", "TaskName", "Priority", "Status"}
        Dim arrstrActualList() As String = {"ReqTitle", "IsTaskComplete", "TaskName", "Priority", "Status"}

        'Dim arrRowLink() As String = {"", "TSPM_DetailsOnclick(TaskID)"}
        Dim arrRowLink() As String = {""}
        Dim arrGroupList() As String = {"ReqTitle"}

        'Dim arrIgnoreHTMLEncode() As String = {"", "1", "", "1", "", "1"}
        Dim arrIgnoreHTMLEncode() As String = {"", "", "1", "", "1"}
        'End Modification By GaneshG 

        'CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><B>Tasks</B>")
        'CommonFunctions.General.WriteHTML(strMenu + "</TD></TR>")
        'CommonFunctions.General.WriteHTML("</TABLE>")

        m_intPageNumberPM = GetPageNumber("PM")
        DrawPaging(Session("intUserID").ToString, m_intPageNumberPM, "PM", strMenu)

        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .TDStyleArray = arrstrTDStyle
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .GroupOnColumn = arrGroupList
            .RowLinkArray = arrRowLink
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .EmptyValueReplacement = "-"
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
    Private Sub DrawGridDeliverables()
        Dim strSQL As String
        Dim arrIDList() As String
        Dim strHTML As String
        Dim strTRClass As String
        Dim strMenu As String
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList

        'Draw menu
        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        arrMenu.Add(MyBase.GetResourceString("MENU_ADD")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ADD")) : arrClientSideFunctions.Add("AddDeliverable_OnClick()")

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


        strSQL = "usp_Sel_RTM_RqmtTraceDeliverableMapping " + m_strReqTRPhaseID

        'Modified By GaneshG on 30-JUN-07 To Remove TS field from list
        'Dim arrstrUserFriendlyList() As String = {"", "TS", "Deliverable", "Priority", "Status"}
        'Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%' title='Timesheet Details'", "style='width=70%' align='left'", "style='width=15%' align='left'", "style='width=5%' align='left'"}
        'Dim arrstrActualList() As String = {"ReqTitle", "TS", "Deliverable", "Priority", "Status"}
        Dim arrstrUserFriendlyList() As String = {"", "Deliverable", "Priority", "Status"}
        Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=70%' align='left'", "style='width=15%' align='left'", "style='width=5%' align='left'"}
        Dim arrstrActualList() As String = {"ReqTitle", "Deliverable", "Priority", "Status"}

        'Dim arrRowLink() As String = {"", "TSDEL_DetailsOnclick(DeliverableID)"}
        Dim arrRowLink() As String = {""}
        Dim arrGroupList() As String = {"ReqTitle"}
        'Dim arrIgnoreHTMLEncode() As String = {"", "1", "1", "1", "1"}
        Dim arrIgnoreHTMLEncode() As String = {"", "1", "1", "1"}
        'End Modification By GaneshG 


        'CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><B>Deliverables</B>")
        'CommonFunctions.General.WriteHTML(strMenu + "</TD></TR>")
        'CommonFunctions.General.WriteHTML("</TABLE>")

        m_intPageNumberDEL = GetPageNumber("DEL")
        DrawPaging(Session("intUserID").ToString, m_intPageNumberDEL, "DEL", strMenu)

        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .TDStyleArray = arrstrTDStyle
            .GroupOnColumn = arrGroupList
            .RowLinkArray = arrRowLink
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .PageSize = 5
            .SQL = strSQL
            .CurrentPage = m_intPageNumberDEL
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .EmptyValueReplacement = "-"
            .DIVHeight = 0
            .DIVID = "Deliverables"
            ' .PrimaryKey = "DeliverableID"
            .UseSQL = MyBase.UseSQL
            .DrawGrid()
        End With
    End Sub

    Private Sub DrawGridTestCases()
        Dim strSQL As String
        Dim strMenu As String
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList

        'Draw menu
        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        arrMenu.Add(MyBase.GetResourceString("MENU_ADD")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ADD")) : arrClientSideFunctions.Add("AddTestCases_OnClick()")
        '  arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP")) : arrClientSideFunctions.Add("Help_OnClick('3714')")

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

        strSQL = "usp_Sel_RTM_RequirementTestCaseMapping " + m_strReqTRPhaseID

        Dim arrstrActualList() As String = {"ReqTitle", "TestSection", "TestCaseCode", "Scenario"}
        Dim arrstrUserFriendlyList() As String = {"", "Test Section", "Test Case Code", "Scenario"}
        Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=70%' align='left'", "style='width=15%' align='left'", "style='width=5%' align='left'"}
        'Dim arrRowLink() As String = {"", "TSTC_DetailsOnclick(ProjectTestCaseID)"}
        Dim arrRowLink() As String = {"", ""}


        Dim arrGroupList() As String = {"ReqTitle"}
        Dim arrIgnoreHTMLEncode() As String = {"", "1", "1", "1"}

        'CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><B>Test Cases</B>")
        'CommonFunctions.General.WriteHTML(strMenu + "</TD></TR>")
        'CommonFunctions.General.WriteHTML("</TABLE>")

        m_intPageNumberTC = GetPageNumber("TC")
        DrawPaging(Session("intUserID").ToString, m_intPageNumberTC, "TC", strMenu)

        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .TDStyleArray = arrstrTDStyle
            .GroupOnColumn = arrGroupList
            .RowLinkArray = arrRowLink
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .PageSize = 5
            .SQL = strSQL
            .CurrentPage = m_intPageNumberTC
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .EmptyValueReplacement = "-"
            .DIVHeight = 0
            .DIVID = "TestCases"
            .UseSQL = MyBase.UseSQL
            .DrawGrid()
        End With
    End Sub
    Private Sub DrawGridChangeRequests()
        Dim strSQL As String
        Dim strMenu As String
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList

        'Draw menu
        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList


        arrMenu.Add(MyBase.GetResourceString("MENU_ADD")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ADD")) : arrClientSideFunctions.Add("AddChangeRequest_OnClick()")
        '  arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP")) : arrClientSideFunctions.Add("Help_OnClick('3714')")

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

        strSQL = "usp_Sel_RTM_RequirementChangeRequestMapping " + m_strReqTRPhaseID

        'Modified By GaneshG on 30-JUN-07 To Remove TS field from list
        'Dim arrstrActualList() As String = {"ReqTitle", "TS", "ChangeRequest", "Priority", "Change Status"}
        'Dim arrstrUserFriendlyList() As String = {"", "TS", "Change Request", "Priority", "Change Status"}
        'Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=2%' title='Timesheet Details'", "style='width=70%' align='left'", "style='width=15%' align='left'", "style='width=5%' align='left'"}
        'Dim arrRowLink() As String = {"", "TSCR_DetailsOnclick(ChangeRequestID)"}
        'Dim arrIgnoreHTMLEncode() As String = {"", "1", "1", "1", "1"}
        Dim arrstrActualList() As String = {"ReqTitle", "ChangeRequest", "Priority", "Change Status"}
        Dim arrstrUserFriendlyList() As String = {"", "Change Request", "Priority", "Change Status"}
        Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=70%' align='left'", "style='width=15%' align='left'", "style='width=5%' align='left'"}
        Dim arrRowLink() As String = {""}
        Dim arrIgnoreHTMLEncode() As String = {"", "1", "1", "1"}
        'End Modification By GaneshG 

        Dim arrGroupList() As String = {"ReqTitle"}

        m_intPageNumberCR = GetPageNumber("CR")
        DrawPaging(CommonFunction.General.BuildQueryString(Session("strUserName").ToString), m_intPageNumberCR, "CR", strMenu)

        'CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><B>Change Requests</B>")
        'CommonFunctions.General.WriteHTML(strMenu + "</TD></TR>")
        'CommonFunctions.General.WriteHTML("</TABLE>")


        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .TDStyleArray = arrstrTDStyle
            .GroupOnColumn = arrGroupList
            .RowLinkArray = arrRowLink
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .PageSize = 5
            .SQL = strSQL
            .CurrentPage = m_intPageNumberCR
            .returnHTML = False
            .DIVHeight = 0
            .DIVID = "ChangeRequests"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .UseSQL = MyBase.UseSQL
            .DrawGrid()
        End With
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
        ' Author                : ChristinaT
        ' Created               : 24th JAn, 2004
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
            Case "TC"
                If Not Request.QueryString("PageNumberTC") Is Nothing Then
                    If Request.QueryString("PageNumberTC") <> "" Or Request.QueryString("PageNumberTC") <> "undefined" Then
                        Return CType(Request.QueryString("PageNumberTC"), Integer)
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
            Case "CR"

                If Not Request.QueryString("PageNumberCR") Is Nothing Then
                    If Request.QueryString("PageNumberCR") <> "" Or Request.QueryString("PageNumberCR") <> "undefined" Then
                        Return CType(Request.QueryString("PageNumberCR"), Integer)
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

    Private Sub DrawPaging(ByVal strInputParameter As String, ByVal m_intPageNumber As Integer, ByVal fromWhere As String, ByVal strMenu As String)
        Dim PagingSQL As String
        Dim strFilters As String



        m_intCount = 0

        'Addition by MonikaI on 21st Aug 2006 For WhizibleSEM SP7
        Select Case fromWhere
            Case "PM"
                PagingSQL = "usp_pagingSQL_RequirementMapping 'PM','" & strInputParameter & "', " & m_strProjectRequirementID & "," & m_lngProjectId.ToString

            Case "TC"

                PagingSQL = "usp_pagingSQL_RequirementMapping 'TC','" & strInputParameter & "', " & m_strProjectRequirementID & "," & m_lngProjectId.ToString

            Case "DEL"

                PagingSQL = "usp_pagingSQL_RequirementMapping 'DEL','" & strInputParameter & "', " & m_strProjectRequirementID & "," & m_lngProjectId.ToString

            Case "CR"

                PagingSQL = "usp_pagingSQL_RequirementMapping 'CR','" & strInputParameter & "', " & m_strProjectRequirementID & "," & m_lngProjectId.ToString


        End Select


        m_intCount = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)
        Dim dblRatio As Double = m_intCount / m_PageSize
        'Draw paging for IssueList
        If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
            m_intPageNumber = 1
        End If
        Dim strPaging As String
        If m_intPageNumber = -1 Or dblRatio = 0 Then

            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + fromWhere, "txtPageNumber" + fromWhere, , 30, 4, , "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event,'" + fromWhere + "')", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + fromWhere, "txtPageNumber" + fromWhere, , 30, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event,'" + fromWhere + "')", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If

        strPaging += " of " + Math.Ceiling(dblRatio).ToString

        Dim str As String
        Dim pageNoPM As Double = GetPageNumber("PM")
        Dim pageNoTC As Double = GetPageNumber("TC")
        Dim pageNoDEL As Double = GetPageNumber("DEL")
        Dim pageNoCR As Double = GetPageNumber("CR")

        Dim strHeader As String

        Select Case fromWhere
            Case "PM"
                str = "-1," + CType(pageNoTC, String) + "," + CType(pageNoDEL, String) + "," + CType(pageNoCR, String)
                strPaging += "|<A href='javascript:PagePM_Onclick(""" + str + """)' TITLE='Show All Records'><B>All</B> </A>"

                strHeader = "Tasks"

            Case "TC"
                str = CType(pageNoPM, String) + ",-1," + CType(pageNoDEL, String) + "," + CType(pageNoCR, String)
                strPaging += "|<A href='javascript:PageTC_Onclick(""" + str + """)' TITLE='Show All Records'><B>All</B> </A>"

                strHeader = "Test Cases"

            Case "DEL"
                str = CType(pageNoPM, String) + "," + CType(pageNoTC, String) + ",-1," + CType(pageNoCR, String)

                strPaging += "|<A href='javascript:PageDEL_Onclick(""" + str + """)' TITLE='Show All Records'><B>All</B> </A>"

                strHeader = "Deliverables"

            Case "CR"
                str = CType(pageNoPM, String) + "," + CType(pageNoTC, String) + "," + CType(pageNoDEL, String) + ",-1"
                strPaging += "|<A href='javascript:PageCR_Onclick(""" + str + """)' TITLE='Show All Records'><B>All</B> </A>"

                strHeader = "Change Requests"

        End Select

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages" + fromWhere, "txtNoOfPages" + fromWhere, , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'Added by PrashantD for hiding Add link if requirement is closed

        If m_blnShowMenu = False Then
            strMenu = ""
        End If

        'End of addition by PrashantD
        If strPaging <> "" Then
            Response.Write("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'> <td align=left > " + strHeader + "</TD><td align=right valign=center > " + strMenu + "</TD></TR><TR class=clsTREven><TD colspan=2 align=right>" + strPaging + "</TD></TR></Table>")

            '      Response.Write("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'> <td align=left> " + strHeader + "</TD><TD align=right top> " + strMenu + "</TD><TD align=right top>" + strPaging + "</TD></TR></Table>")

        End If
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
        CommonFunction.General.PlotPageHeadTag("Requirement Traceability Mapping")
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

        m_strProjectRequirementID = HttpContext.Current.Request.QueryString("ProjectRequirementID") + ""
        m_strReqTRPhaseID = Request.QueryString("ReqTRPhaseID") + ""

        If m_strReqTRPhaseID = "" Then
            m_strReqTRPhaseID = Request.Form("txthidReqTRPhaseID").ToString
        End If
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidReqTRPhaseID", "txthidReqTRPhaseID", , , , m_strReqTRPhaseID, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        If m_strProjectRequirementID = "" Then
            m_strProjectRequirementID = Request.Form("txthidProjectRequirementID").ToString
        End If
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidProjectRequirementID", "txthidProjectRequirementID", , , , m_strProjectRequirementID, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'Added by PrashantD for hiding Add link if requirement is closed
        Dim dr As IDataReader

        'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        'dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_RM_ProjectRequirements A INNER JOIN tbl_RM_ReuirementStatus B ON A.StatusID = B.StatusID AND MappedToClose = 1 WHERE ProjectRequirementID = " + m_strProjectRequirementID, MyBase.UseSQL)
        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_RM_ProjectRequirements " + m_strProjectRequirementID, MyBase.UseSQL)
        'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

        If dr.Read Then
            m_blnShowMenu = False
        Else
            m_blnShowMenu = True
        End If
        CommonFunction.Data.DisposeDataReader(dr)
        'End of addition by PrashantD

        'm_lngProjectId = CType(HttpContext.Current.Session("intProjectId"), Long)
        'Comment BY VarunA on 5-Sep-2007
        'm_lngProjectId = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), 0), Long)
        m_lngProjectId = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "0"), Long)
        'End by VarunA on 5-Sep-2007

        'Added by PrashantD on 7 feb 2007
        If m_lngProjectId = 0 Then
            m_lngProjectId = CType(HttpContext.Current.Request.Form("hidProjectID"), Long)
        End If
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectID id=hidProjectID value=" + m_lngProjectId.ToString + ">")
        'End of addition by PrashantD on 7 feb 2007
        'This will initialize all the global objects.
        GetGlobalObject()
        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        CommonFunctions.General.WriteHTML("<table class=clsTable CellSpacing=0 Border=0 width='100%'>")
        CommonFunctions.General.WriteHTML("<tr class=clsTREven width='100%'>")
        CommonFunctions.General.WriteHTML("<td width='50%'></td>")
        CommonFunctions.General.WriteHTML("<td width='10%'>Legend&nbsp;</td>")
        CommonFunctions.General.WriteHTML("<td width='2%' Title='Not Started'><IMG src='../../Source/DB/Images/Yellow.gif' border=0></td>")
        CommonFunctions.General.WriteHTML("<td width='10%'>Not Started</td>")

        CommonFunctions.General.WriteHTML("<td width='2%' Title='Need Attention'><IMG src='../../Source/DB/Images/Red.gif' border=0></td>")


        CommonFunctions.General.WriteHTML("<td width='10%'>Need Attention</td>")

        CommonFunctions.General.WriteHTML("<td width='2%' Title='In Progress'><IMG src='../../Source/DB/Images/Green.gif' border=0></td>")

        CommonFunctions.General.WriteHTML("<td width='10%'>In Progress</td>")

        CommonFunctions.General.WriteHTML("</TR></TABLE>")

        Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
        Response.Write("<TABLE ID= 'RequirementMappingMain' class= 'clsTable' style = 'Width:100%;HEIGHT:100%;OVERFLOW:auto;TABLE-LAYOUT:fixed' >")


        Dim strSQL As String

        '=============================================================================================
        '   Tasks N Deliverables tables
        '=============================================================================================
        Response.Write("<tr valign ='top' > <td width='50%' height='50%'>")
        Call DrawGridTasks()
        Response.Write("</td>")

        Response.Write("<td width='50%' height='50%'>")
        Call DrawGridDeliverables()
        Response.Write("</td>")
        Response.Write("</tr>")
        '=============================================================================================
        '   Test Cases N Change Requests tables
        '=============================================================================================
        Response.Write("<tr valign ='top' > <td width='50%' height='50%'>")
        Call DrawGridTestCases()
        Response.Write("</td>")
        Response.Write("<td width='50%' height='50%'>")
        Call DrawGridChangeRequests()
        Response.Write("</td>")
        Response.Write("</tr>")


        m_objGrid = Nothing


        Response.Write("</table>")
        HttpContext.Current.Response.Write("</DIV>")

        DisposeObjects()
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Select Case UCase(Trim(Args.DataField & ""))
            'Commented By GaneshG on 30-JUN-07 To Remove TS field from list
            'Case "TS"
            '    Args.ApplySorting = False
            '    Args.ColumnName = "<IMG border=0 src='../../Images/Timesheet.gif'>"
            '    Args.ApplyHTMLEncode = False
            'End Comment By GaneshG 
        Case "REQTITLE"
                Args.ColumnName = ""
                Args.ApplySorting = True
            Case "STATUS"
                Args.ApplySorting = False
                Args.ColumnName = "<IMG border=0 src='../../Source/DB/Images/Black.gif'>"
                Args.ApplyHTMLEncode = False
                Args.TDStyle = " title ='Status' align='center'"
            Case "RESOURCE"
                Args.ApplySorting = False
                Args.ColumnName = "<IMG border=0 src='../../Source/DB/Images/WF_UserStage.gif'>"
                Args.ApplyHTMLEncode = False
                Args.TDStyle = " title ='Resource' align='center'"

        End Select

    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Select Case UCase(Trim(Args.DataField & ""))


            Case "TASKNAME"
                Cancel = True
                Dim strHTML As String
                Dim arrIDList() As String

                arrIDList = Split(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskName"), ""), String), "")
                strHTML = strHTML & ("<TD align=left height='100%' width='10%' Title='" & arrIDList(0) & "'>")
                strHTML = strHTML & arrIDList(0)
                strHTML = strHTML & ("</TD>")
                Args.StringToBeInserted = strHTML
                Args.ApplyHTMLEncode = False
            Case "DELIVERABLE"
                Cancel = True
                Dim strHTML As String
                Dim arrIDList() As String

                arrIDList = Split(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Deliverable"), "|"), String), "|")
                strHTML = strHTML & ("<TD align=left height='100%' width='10%' Title='" & arrIDList(0) & "'>")
                strHTML = strHTML & arrIDList(0)
                strHTML = strHTML & ("</TD>")
                Args.StringToBeInserted = strHTML
                Args.ApplyHTMLEncode = False

                'Commented By GaneshG on 30-JUN-07 To Remove TS field from list
                'Case "TS"
                '    Args.TDStyle = " title='Click To View Timesheet Details' "
                '    If Trim(Args.DataReader("TS").ToString & "") = "" Then
                '        Args.DataFieldValue = " "
                '    End If
                'End Comment By GaneshG 

            Case "STATUS"
                Dim strHTML As String
                If Trim(Args.DataReader("Status").ToString & "") = "In Progress" Then
                    Cancel = True
                    strHTML = strHTML & ("<td  align='center' Title='In Progress' ><IMG src='../../Source/DB/Images/Green.gif' border=0></td>")
                ElseIf Trim(Args.DataReader("Status").ToString & "") = "Need Attention" Then
                    Cancel = True
                    strHTML = strHTML & ("<td  align='center' Title='Need Attention' ><IMG src='../../Source/DB/Images/Red.gif' border=0></td>")
                ElseIf Trim(Args.DataReader("Status").ToString & "") = "Not Started" Then
                    Cancel = True
                    strHTML = strHTML & ("<td align='center' Title='Not Started'> <IMG src='../../Source/DB/Images/Yellow.gif' border=0></td>")
                Else
                    Cancel = True
                    strHTML = strHTML & ("<td ></td>")
                End If
                Args.StringToBeInserted = strHTML
            Case "ISTASKCOMPLETE"
                Dim intTaskcompleteflag As Integer
                intTaskcompleteflag = CInt(Args.DataReader("IsTaskComplete"))
                Cancel = True
                If intTaskcompleteflag = -1 Then
                    Args.StringToBeInserted = "<td align='center'><img src='../../images/star.gif'></td>"
                Else
                    Args.StringToBeInserted = "<td align='center'></td>"
                End If

        End Select

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
        End If
        strReturn += "<TABLE BorderColor='" & strBackColor & "' height='7px' width='90%' border=1 cellspacing=0 cellpadding=0>"
        strReturn += "<TR  bgcolor='" & strBgcolor & "'CLASS='" & strTRClass & "'>"
        If fltPercent > 0 Then
            If fltPercent >= dblMax Then
                strReturn += "<TD height='6px' bgcolor='" & strBarColor & "'></TD>"
            Else
                strReturn += "<TD height='6px' width='" & System.Math.Ceiling(fltPercent).ToString & "%' bgcolor='" & strBarColor & "'></TD>"
                strReturn += "<TD height='6px' width='" & System.Math.Ceiling((dblMax - fltPercent)).ToString & "%'  bgcolor='" & strBgcolor & "'></TD>"
            End If
        ElseIf fltPercent < 0 Then
            Dim fltTemp As Double = (-1) * fltPercent
            If fltTemp >= dblMax Then
                'strReturn += "<TD bgcolor='" & strBarColor & "'></TD>"
                strReturn += "<TD height='6px' bgcolor='" & strBarColor & "'></TD>"
            Else

                strReturn += "<TD height='6px' width='" & System.Math.Ceiling(fltTemp).ToString & "%' bgcolor='" & strBarColor & "'></TD>"
                strReturn += "<TD height='6px' width='" & System.Math.Ceiling((dblMax - fltTemp)).ToString & "%'  bgcolor='" & strBgcolor & "'></TD>"
            End If
        Else

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
        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)

        'MyBase.ApplySecurity()
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        'initialize the resource file for requirement mapping
        MyBase.InitializeResources("AppResources.RM_ProjectRequirementMapping", "AppResources")


    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region





End Class
