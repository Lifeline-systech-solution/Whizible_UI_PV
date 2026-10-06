Option Strict Off
Imports System.Text
Imports Whizible
Partial Public Class MyHome_TabUI
    Inherits WebPages.Template.WhizTemplate
    Protected m_intUserID As Integer = 0
    Protected m_strLoginType As String = "E"
    Private m_strModuleShortName As String = ""
    Protected m_PageNumber As Long = 1
    Protected m_intPageSize As Integer = 10
    Protected m_intDetailViewPageSize As Integer = 20
    Protected m_ShortName As String = ""
    Private m_strSearchText As String = ""
    Protected m_strMode As String = ""
    Protected intCurrentpageNumber As Integer = 0
    Protected dsWorkbox As DataSet
    Protected intmenugroupId As Integer = 0
    Protected intPageSize As Integer = 7
    Protected intItemCount As Integer = 0
    Protected strPKToken As String = ""
    Protected strSummary As String = ""
    Protected WithEvents m_GenerateTree As New CommonFunctions.GenerateTree
    Protected m_intNoOfDisplayDetailsViewColumn As Integer = 4
    Protected m_strTagID As String = "0"
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected m_intTabPanelNumber As Integer = 0
    Protected m_intTotalNoOfRows As Integer = 0
    Protected m_intCurrentPageNumber As Integer = 1
    Protected WithEvents m_objDetailsGrid As WebPages.Template.GenericGrid
    Protected m_strSearchColumn As String = "Title"
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Dim strPageNAme As String = ""
    Dim strProjectID As String = ""
    Dim strEntityID As String = ""
    Dim strColumnValue As String = ""
    Dim m_intGroupPanelID As Integer = 0
    Dim m_strUniqueID As String = ""
    Dim m_strComment As String = ""

    Protected Enum MenuGridIds
        MY_WORK_BOX = 17
        TIMESHEET = 19
        SHOW_TASK = 23
        MY_REQUEST = 20
        HELP_DESK = 24
        KNOWLEDGE = 25
        PEOPLE_I_KNOW = 22
    End Enum
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        Session.Remove("MenuGroupID")
    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : To Initialize the Page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim intcontrolItemID As Integer
        Dim m_strFrom As String = ""
        Dim intShowAll As Integer = 0
        InitVariables()


        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("IsXMLHTTP"), 0) = 1 Then
            If Not HttpContext.Current.Request.Params("PageNumber") Is Nothing Then
                m_intCurrentPageNumber = CType(HttpContext.Current.Request.Params("PageNumber"), Integer)
            End If

            m_strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Mode"), "")
            intShowAll = CInt(CommonFunction.General.CheckIsNothing(Request("ShowAll"), "0"))
            m_strFrom = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("From"), "")
            If m_strFrom = "OpenIssuePage" Then
                Session("IssueProject") = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("ProjectID"), "")
                Response.Clear()
                Response.Write("Session##" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("URL"), "") + "##" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("PKToken"), ""))
                Response.End()
            ElseIf m_strFrom = "OpenWBSPage" Then
                UpdateSession()
            ElseIf m_strFrom = "ShowTasks" Then
                ShowTasks(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Period"), "1"), 1, intShowAll)
            ElseIf m_strFrom = "OpenTimesheet" Then
                Session("TSIDs") = "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TimesheetID"), "") + ","
                Response.Clear()
                Response.Write("Session##" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("URL"), "") + "##" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("PKToken"), ""))
                Response.End()
            Else

                Select Case intmenugroupId
                    Case MenuGridIds.MY_WORK_BOX
                        Response.Clear()
                        Call PlotMyWorkbox(1, intShowAll)
                    Case MenuGridIds.TIMESHEET
                        Call PlotMyTimesheet(1)
                    Case MenuGridIds.MY_REQUEST
                        Call PlotMyRequests(1, intShowAll)
                    Case MenuGridIds.PEOPLE_I_KNOW
                        Call PlotPeopleIknow(1, intShowAll)
                    Case MenuGridIds.SHOW_TASK
                        Call ShowTasks(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Period"), "1"), 1, intShowAll)
                    Case MenuGridIds.HELP_DESK
                        Call PlotHelpDeskRequests(1, intShowAll)
                    Case MenuGridIds.KNOWLEDGE
                        PlotKMDetails(1, intShowAll)
                End Select
            End If
        Else
            m_strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Mode"), "")
            If m_strMode = "CloseTab" Then
                CommonFunction.Data.InsertOrUpdateData("usp_Ins_Upd_tbl_UI_ControlMenuGroup_User " + m_intUserID.ToString + "," + intmenugroupId.ToString + ",0,0,5,1", True)
            End If
            Draw_Page()
            DrawHiddenControls()
        End If


    End Sub
    Private Sub InitVariables()
        '=====================================================================
        ' Procedure Name        : InitVariables()
        ' Purpose               : To Initialize the Variables
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : July 26, 2008
        ' Revisions             :
        '=====================================================================
        'Dim drCurrentYear As IDataReader
        Dim strSQL As String = ""
        Dim intTabCount As Integer = 0
        Dim strvalue As String = ""

        Call GetGlobalObject()
        m_strLoginType = CommonFunction.General.CheckIsNothing(Session("LoginType").ToString, "E")
        m_intUserID = CommonFunction.General.CheckIsNothing(Session("intUserID").ToString, "E")
        m_strModuleShortName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShortName"))
        If m_strModuleShortName = "" Then
            m_strModuleShortName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strShortName"))
        Else
            HttpContext.Current.Session("strShortName") = m_strModuleShortName
        End If
        If Not IsNothing(HttpContext.Current.Request.Form("txtPageNumber")) = True Then
            m_PageNumber = HttpContext.Current.Request.Form("txtPageNumber").ToString()
        Else
            m_PageNumber = 1
        End If
        m_ShortName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShortName"), "")
        If m_ShortName = "" Then
            m_ShortName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtShortName"), "")
        End If

        m_strSearchText = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("SearchText"), "").ToString
        intmenugroupId = CommonFunction.General.CheckIsNothing(Request("MenuGroupID"), "0")
        m_strTagID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Params("TagID"), "0")

        m_strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Params("UniqueID"), "")
        m_strComment = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Params("Comment"), "")

    End Sub
    
    Protected Sub Draw_Page()
        '=====================================================================
        ' Procedure Name        : Draw_Page()
        ' Purpose               : To generate the UI
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : July 26, 2008
        ' Revisions             :
        '=====================================================================

        Dim sbHtml As New System.Text.StringBuilder
        Dim strSQL As String
        Dim drAccessibleMenuTabs As IDataReader
        Dim intCnt As Integer = 0
        Dim IsApplicable As Boolean = True
        Dim intTRCount As Integer = 0
        Dim intOrderNumber As Integer = 0
        Dim blnIsShowTaskPanelExists As Boolean = False
        Dim strvalue As String = ""
        Dim strMenuGroupID As String = ""
        strSQL = " Usp_Sel_tbl_UI_ControlMenuGroup_User " & m_intUserID.ToString

        If m_strModuleShortName <> "" Then
            strSQL += ",'TabUI'"
        Else
            strSQL += ",NULL"
        End If

        strSQL += ",'" & m_strLoginType & "'"
        drAccessibleMenuTabs = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        sbHtml.Append("<TABLE valign='top' id='tblSearch'  cellspacing='0' cellpadding='0' Width='100%'  class='clsTable'>")
        sbHtml.Append("<TR class='clsTRMenu'>")
        sbHtml.Append("<TD align='Right'><A href='JavaScript:Configure_Section()' style='TEXT-DECORATION:none'>Configure Sections</A>") '<img src= '../../Images/DetailView/78.gif' border='0' alt='Configure Sections'>
        sbHtml.Append("</TD></TR></Table>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)

        sbHtml.Length = 0

        sbHtml.Append("<div ID='PageDiv' height='100%' style='overflow:auto;width:99.9%;'>")
        sbHtml.Append("<table CELLPADDING='0' CELLSPACING='0' BORDER='0' Width='100%' height='95%' class='clsTable' style='padding:5px 5px 0px 0px;'>") ''
        sbHtml.Append("<TR id='TR_0'>")
        Dim intOrderCount As Integer = 0
        Dim sbShowTask As New StringBuilder()
        While (drAccessibleMenuTabs.Read())
            intOrderNumber = CInt(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drAccessibleMenuTabs("OrderNumber"), "0"), "0"))
            IsApplicable = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drAccessibleMenuTabs("IsApplicable"), "0"), "0"))
            strMenuGroupID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drAccessibleMenuTabs("MenuGroupID"), "0"), "0").ToString
            strvalue = CommonFunction.General.CheckIsNothing(Request.Form("txtCurrentPage_" + strMenuGroupID.ToString), "0")
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''CommonFunction.HTMLControls.DrawTextBox("txtCurrentPage_" + strMenuGroupID.ToString, "txtCurrentPage_" + strMenuGroupID.ToString, , 200, , strvalue, , , , , , True)
            CommonFunction.HTMLControls.DrawTextBox("txtCurrentPage_" + strMenuGroupID.ToString, "txtCurrentPage_" + strMenuGroupID.ToString, , 200, , strvalue, , , , , , True, EnableHTMLEncode:=True)
            If intCnt Mod 2 = 0 And intCnt <> 0 And intOrderNumber <> 3 Then
                If intOrderCount <> 4 And intOrderCount <> 3 Then
                    intTRCount = intTRCount + 1
                    sbHtml.Append("<td id='TDTRSpace_" + intCnt.ToString + "' WIDTH='1%' align='center'>&nbsp;</td>")
                    sbHtml.Append("</TR><TR id='TR_" + intTRCount.ToString + "'>")
                Else
                    If blnIsShowTaskPanelExists = False Then
                        intTRCount = intTRCount + 1
                        sbHtml.Append("<td id='TDTRSpace_" + intCnt.ToString + "' WIDTH='1%' align='center'>&nbsp;</td>")
                        sbHtml.Append("</TR><TR id='TR_" + intTRCount.ToString + "'>")
                    End If
                End If
            End If
            If intOrderNumber = 3 Then
                blnIsShowTaskPanelExists = True
                intTRCount = intTRCount + 1
                sbShowTask.Append("<td id='TDSpace_233' WIDTH='1%' align='center'>&nbsp;</td>")
                sbShowTask.Append("</TR><TR id='TR_233'>")
                If (IsApplicable = True Or IsApplicable = "1") Then
                    sbShowTask.Append("<td id='TDSpace_233' WIDTH='1%' align='center'>&nbsp;</td>")
                    sbShowTask.Append("<TD id='TD_233' align='left' colspan=3 valign='top ' WIDTH='49%' height='240px'>")
                    sbShowTask.Append(PlotControlMenuTab(drAccessibleMenuTabs("MenuGroup"), drAccessibleMenuTabs("MaxControlLimit"), drAccessibleMenuTabs("MenuGroupID"), drAccessibleMenuTabs("ShowMarqueeSection"), intCnt, 430))
                    sbShowTask.Append("</TD>")
                    sbShowTask.Append("<td id='TDSpace_233' WIDTH='1%' align='center'>&nbsp;</td>")
                End If
                intTRCount = intTRCount + 1
                sbShowTask.Append("</TR><TR id='TR_" + intTRCount.ToString + "'>")
            End If
            If intOrderCount = 3 Then
                sbHtml.Append(sbShowTask.ToString())
                sbShowTask.Length = 0
            End If
            If (IsApplicable = True Or IsApplicable = "1") And intOrderNumber <> 3 Then
                sbHtml.Append("<td id='TDSpace_" + intCnt.ToString + "' WIDTH='1%' align='center'>&nbsp;</td>")
                sbHtml.Append("<TD id='TD_" + intCnt.ToString + "' align='left' valign='top' WIDTH='49%' height='240px'>")
                sbHtml.Append(PlotControlMenuTab(drAccessibleMenuTabs("MenuGroup"), drAccessibleMenuTabs("MaxControlLimit"), drAccessibleMenuTabs("MenuGroupID"), drAccessibleMenuTabs("ShowMarqueeSection"), intCnt, 430))
                sbHtml.Append("</TD>")
                intCnt = intCnt + 1
            End If
            intOrderCount += 1
        End While
        sbHtml.Append("</TR></table>")

        sbHtml.Append("</TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("</TABLE>")
        sbHtml.Append("</Div>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)

        sbHtml = Nothing
        CommonFunction.Data.DisposeDataReader(drAccessibleMenuTabs)
    End Sub
    Private Function PlotControlMenuTab(ByVal strGroupName As String, ByVal MaxControlLimit As Integer, ByVal intGroupID As Integer, ByVal blnShowMarqueeSection As Boolean, Optional ByVal intPanel As Integer = 1, Optional ByVal intTableWidth As Integer = 400) As String

        Dim sbHtml As New System.Text.StringBuilder
        Dim strSQL As String
        Dim strTagID As String = ""
        m_intTabPanelNumber = intPanel
        Select Case intGroupID
            Case MenuGridIds.PEOPLE_I_KNOW
                dsWorkbox = CommonFunction.Data.GetDataSet("usp_sel_PeopleIKnow_MyHome " + m_intUserID.ToString + ",'" + m_strLoginType + "'", "MyWorkBox")
           
            Case MenuGridIds.KNOWLEDGE
                dsWorkbox = CommonFunction.Data.GetDataSet("usp_sel_KM_TopThree_Articles " + m_intUserID.ToString + ",'" + m_strLoginType + "'", "MyWorkBox")
              
        End Select
       
        sbHtml.Append("<table id='HeaderTable' width='100%'  CELLPADDING='0' CELLSPACING='0' BORDER='0' Class='clsRoundedTableHeader' style='padding:0px 0px 0px 0px;'>")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td align=left WIDTH='14' class='clsTopLeftCorner_Home'>  </td>") '--class='clsTDTopLeftCorner'
        sbHtml.Append("<td  rowspan='2' valign='middle' style=""border-top:1px solid gray;""> ")
        If intGroupID = MenuGridIds.SHOW_TASK Then
            sbHtml.Append("<table WIDTH='100%'  Class='clsRoundedTableHeader' ><tr><td align='Left'><b>My Tasks</b>&nbsp;<img src='../../Images/Home/1.jpg' onclick='javascript:ShowTasks(1)'  style='cursor:pointer;' border=0>-<img src='../../Images/Home/7.jpg'  onclick='javascript:ShowTasks(2)'  style='cursor:pointer;' border=0>-<img src='../../Images/Home/14.jpg'  onclick='javascript:ShowTasks(3)'  style='cursor:pointer;' border=0>-<img src='../../Images/Home/31.jpg'  onclick='javascript:ShowTasks(4)' style='cursor:pointer;' border=0>")
            sbHtml.Append("<td id='TD_Period' align='left'>")
            sbHtml.Append(WeekdayName(Weekday(Today), True, vbSunday) + " ")
            sbHtml.Append(CommonFunction.Dates.CGetDate(Today) + "-")
            sbHtml.Append(WeekdayName(Weekday(Today), True, vbSunday) + " ")
            sbHtml.Append(CommonFunction.Dates.CGetDate(Today))
            sbHtml.Append("</td>")
        Else
            sbHtml.Append("<table WIDTH='100%'  Class='clsRoundedTableHeader' ><tr><td align='Left' ><b>" & strGroupName & "</b>")
            If intGroupID = MenuGridIds.MY_WORK_BOX Or intGroupID = MenuGridIds.MY_REQUEST Or _
                    intGroupID = MenuGridIds.HELP_DESK Or intGroupID = MenuGridIds.TIMESHEET Then
                sbHtml.Append("<span id='TotalRowsForMyWorkbox_" + intGroupID.ToString + "'>&nbsp;</span>")
            Else
                If dsWorkbox.Tables.Count > 0 Then
                    intItemCount = dsWorkbox.Tables(0).Rows.Count
                End If
                sbHtml.Append("<span id='TotalRowsForMyWorkbox_" + intGroupID.ToString + "'> (" + intItemCount.ToString + ")</span>")
                'sbHtml.Append(" (" + intItemCount.ToString + ")")
            End If
            sbHtml.Append("</td>")
        End If

        'If intGroupID <> MenuGridIds.PEOPLE_I_KNOW And intGroupID <> MenuGridIds.KNOWLEDGE _
        '            And intGroupID <> MenuGridIds.TIMESHEET And intGroupID <> MenuGridIds.SHOW_TASK Then
        '    sbHtml.Append("<td id='td_filter_" + intGroupID.ToString + "' align='center' valign='middle' style='display:none;'>")
        '    If intGroupID <> MenuGridIds.MY_WORK_BOX And intGroupID <> MenuGridIds.MY_REQUEST _
        '                And intGroupID <> MenuGridIds.HELP_DESK Then
        '        sbHtml.Append("Title : <input type='text' valign='middle' id='txtSearch_" + intGroupID.ToString + "'  width='80px' onkeypress='txtSearch_onkeypress(" & intGroupID.ToString & ",event)'>")
        '    End If
        '    sbHtml.Append("</td>")
        'End If

        sbHtml.Append("<td align=right id='tdAction_" + intGroupID.ToString + "' name='tdAction_" + intGroupID.ToString + "' align='right' style='cursor:pointer;' title='Actions' >")


        If intGroupID = MenuGridIds.MY_WORK_BOX Or intGroupID = MenuGridIds.MY_REQUEST _
                Or intGroupID = MenuGridIds.HELP_DESK Then
            sbHtml.Append("")
        Else
            sbHtml.Append("<img id='imgExpand_" + intGroupID.ToString + "' alt='Maximize' style='cursor:pointer;' align='middle' src='../../Images/Home/maximize.gif' border=0 onclick='javascript:ExpandSection_Onclick(" & intGroupID.ToString & "," + intPanel.ToString + ")'>&nbsp;")
        End If
        sbHtml.Append("<img id='imgCollpse_" + intGroupID.ToString + "' alt='Restore' style='cursor:pointer;display:none;' align='middle' src='../../Images/Home/restore.gif' border=0 onclick='javascript:CollapseSection_Onclick(" & intGroupID.ToString & "," + intPanel.ToString + ")'>")
        sbHtml.Append("<img id='closeTab_" + intGroupID.ToString + "' alt='Close' style='cursor:pointer;' align='middle' src='../../Images/Home/close.gif' border=0 onclick='javascript:CloseSection(" & intGroupID.ToString & "," + intPanel.ToString + ")'></TD>")
        sbHtml.Append("</tr></table>")
        sbHtml.Append("</td>")
        sbHtml.Append("<td WIDTH='14' class='clsTopRightCorner_Home' >")
        sbHtml.Append("</td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td style=""border-left:1px solid gray;"">&nbsp;&nbsp;</td>")
        sbHtml.Append("<td style=""border-right:1px solid gray;"">&nbsp;&nbsp;</td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")
        Select Case intGroupID
            Case MenuGridIds.MY_WORK_BOX
                sbHtml.Append(PlotMyWorkbox())
                Return sbHtml.ToString
            Case MenuGridIds.TIMESHEET
                sbHtml.Append(PlotMyTimesheet())
                Return sbHtml.ToString
            Case MenuGridIds.MY_REQUEST
                sbHtml.Append(PlotMyRequests())
                Return sbHtml.ToString
            Case MenuGridIds.PEOPLE_I_KNOW
                sbHtml.Append(PlotPeopleIknow())
                Return sbHtml.ToString
            Case MenuGridIds.SHOW_TASK
                sbHtml.Append(ShowTasks(1, 0))
                Return sbHtml.ToString
            Case MenuGridIds.HELP_DESK
                sbHtml.Append(PlotHelpDeskRequests())
                Return sbHtml.ToString
            Case MenuGridIds.KNOWLEDGE
                sbHtml.Append(PlotKMDetails())
                Return sbHtml.ToString
        End Select

    End Function

    Private Sub DrawHiddenControls()
        '=====================================================================
        ' Procedure Name        : DrawHiddenControls()
        ' Purpose               : To Draw Hidden Contrls
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : July 26, 2008
        ' Revisions             :
        '=====================================================================
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtShortName", "txtShortName", , , , m_ShortName, , , , , , True, , True, EnableHTMLEncode:=True))

    End Sub

    Public Function PlotKMDetails(Optional ByVal intFromAjax As Integer = 0, Optional ByVal intShowall As Integer = 0) As String
        Dim intBlankRowsCount As Integer = 0
        Dim intRowsCounter As Integer = 0
        Dim strHTML As New System.Text.StringBuilder
        Dim strSearchText As String = ""
        Call GetTagAccessRights(6)
        intPageSize = 4

        If intShowall = 0 Then
            strHTML.Append("<table id='tblGroup25'  height='75%' CELLPADDING=""0"" CELLSPACING=""0"" Class='clsRoundedTableMenu' width='100%'>") ' height='110px'
        Else
            strHTML.Append("<table id='tblGroup25'  height='75%' CELLPADDING=""0"" CELLSPACING=""0"" Class='clsRoundedTableMenu' width='100%'>") ' height='110px'
            m_strSearchColumn = "Title"
            strSearchText = CommonFunction.General.CheckIsNothing(Request("SearchText"), "")
            If strSearchText = "" Then
                strSearchText = "NULL"
            End If
            dsWorkbox = CommonFunction.Data.GetDataSet("usp_sel_KM_TopThree_Articles " + m_intUserID.ToString + ",'" + m_strLoginType + "',N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "',1", "MyWorkBox")
            If dsWorkbox.Tables.Count > 0 Then
                m_intTotalNoOfRows = dsWorkbox.Tables(0).Rows.Count
            End If
            strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'><TD colspan=3 align=Left valign=top WIDTH=""100%"">")
            strHTML.Append(WritePaging(MenuGridIds.KNOWLEDGE))
            strHTML.Append("</TD>")
            strHTML.Append("</TR>")
            dsWorkbox = CommonFunction.Data.GetDataSet("usp_sel_KM_TopThree_Articles " + m_intUserID.ToString + ",'" + m_strLoginType + "',N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "',1," + m_intCurrentPageNumber.ToString, "MyWorkBox")
        End If
       
       
        If m_strLoginType = "E" And m_objAccessRights.IsModuleAccessible = True Then
            strHTML.Append("<TR class='clsTRBlank' style='font-size:10px;'>")
            strHTML.Append("<TD  align=Left valign=top WIDTH=""100%""><img align=middle src='../../Images/Home/knowledge.png' border=0>&nbsp;&nbsp;<a href=""javascript:OpenPage_Onclick('../km/km_Home.aspx?SelectList=1&Fromwhere=KM',0,0,0,0)"" >Go to Knowledge</a>")
            strHTML.Append("</TD></TR>")
            intRowsCounter += 1
        End If
        If dsWorkbox.Tables.Count > 0 Then
            For Each objDr As DataRow In dsWorkbox.Tables(0).Rows
                If (intRowsCounter + m_intDetailViewPageSize) >= (m_intDetailViewPageSize * m_intCurrentPageNumber) Then
                    strHTML.Append("<TR  class='clsTRBlank' style='font-size:10px;'>")
                    strHTML.Append("<TD align=Left valign=top WIDTH=""100%"">")
                    strHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("ProcedureTitle"), ""), ""))
                    strHTML.Append("<BR>Author :")
                    strHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("EmployeeName"), ""), ""))
                    strHTML.Append("<BR>")
                    strHTML.Append("</TD></TR>")
                End If
                intRowsCounter += 1
            Next
        End If

        For intBlankRowsCount = 0 To intPageSize - intRowsCounter
            strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
            strHTML.Append("<TD width=100% align=left align=Left valign=top >&nbsp;<BR><BR>")
            strHTML.Append("</TD></TR>")
        Next
        strHTML.Append("</TABLE>")
        If intFromAjax = 0 Then
            Return strHTML.ToString
        Else
            Response.Clear()
            strHTML.Append("#=##=#")
            strHTML.Append(m_intTotalNoOfRows.ToString())
            Response.Write(strHTML.ToString)
            Response.End()
            strHTML = Nothing
        End If


    End Function

    Public Function PlotPeopleIknow(Optional ByVal intFromAjax As Integer = 0, Optional ByVal intShowall As Integer = 0) As String
        Dim strHTML As New System.Text.StringBuilder
        Dim strTOEmail As String = ""
        Dim strCCEmailID As String = ""
        Dim strRegards As String = ""
        Dim strHi As String = ""
        Dim strDisplayName As String = ""
        Dim strBody As String = ""
        Dim strSubject As String = ""
        Dim intBlankRowsCount As Integer = 0
        Dim strSearchText As String = ""
        Dim intRowsCounter As Integer = 0
        Dim intCurrentIndex As Integer
        intPageSize = 6
        If intShowall = 0 Then
            strHTML.Append("<table valign='top' id='tblGroup22' height='75%'   CELLPADDING=""0"" CELLSPACING=""0"" Class='clsRoundedTableMenu' width='100%'>") 'height='110px'
        Else
            strHTML.Append("<table valign='top' id='tblGroup22' CELLPADDING=""0"" CELLSPACING=""0"" Class='clsRoundedTableMenu' width='100%'>")
            m_strSearchColumn = "Employee"
            strSearchText = CommonFunction.General.CheckIsNothing(Request("SearchText"), "")
            If strSearchText = "" Then
                strSearchText = "NULL"
            End If
            dsWorkbox = CommonFunction.Data.GetDataSet("usp_sel_PeopleIKnow_MyHome " + m_intUserID.ToString + ",'" + m_strLoginType + "',N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "',1", "MyWorkBox")
            If dsWorkbox.Tables.Count > 0 Then
                m_intTotalNoOfRows = dsWorkbox.Tables(0).Rows.Count
            End If
            strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'><TD colspan=3 align=Left valign=top WIDTH=""100%"">")
            strHTML.Append(WritePaging(MenuGridIds.PEOPLE_I_KNOW))
            strHTML.Append("</TD>")
            strHTML.Append("</TR>")
            dsWorkbox = CommonFunction.Data.GetDataSet("usp_sel_PeopleIKnow_MyHome " + m_intUserID.ToString + ",'" + m_strLoginType + "',N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "',1," + m_intCurrentPageNumber.ToString, "MyWorkBox")

        End If

        strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'><TD colspan=3 align=Left valign=top WIDTH=""100%"">")
        strHTML.Append("<img align=middle src='../../Images/Home/people-bday.png' border=0>")
        strHTML.Append("<FONT color='#FF6600'> This tab displays the birthdays in the this month.</FONT>")
        strHTML.Append("</TD>")
        strHTML.Append("</TR>")


        strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
        strHTML.Append("<TD align=Left valign=top width='33%' ><b>Employee</b>")
        strHTML.Append("</TD>")
        strHTML.Append("<TD align=Left valign=top width='33%' ><b>Send Greetings</b>")
        strHTML.Append("</TD>")
        strHTML.Append("<TD align=Left valign=top width='33%'><b>Birthdate</b>")
        strHTML.Append("</TD></TR>")
        intPageSize = 6
        If dsWorkbox.Tables.Count > 0 Then
            For Each objDr As DataRow In dsWorkbox.Tables(0).Rows
                If (intRowsCounter + m_intDetailViewPageSize) >= (m_intDetailViewPageSize * m_intCurrentPageNumber) Then
                    strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
                    strHTML.Append("<TD align=Left valign=top width='40%' >")
                    strHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("EmployeeName"), ""), "").ToString())
                    strHTML.Append("</TD>")
                    strHTML.Append("<TD align=Left valign=top width='30%' >")
                    strTOEmail = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("EmailID"), ""), "").ToString
                    strRegards = CommonFunctions.General.CheckIsNothing(Session("strUserName"), "").ToString
                    strHi = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("EmployeeName"), ""), "").ToString
                    strBody = "Wish you Happy Birthday!!!"
                    strSubject = "Wish you Happy Birthday!!!"
                    strDisplayName = "Send Greetings"
                    If strTOEmail <> "" Then
                        strHTML.Append(CommonFunction.General.OpenOutlookWhenClickOnEmail(strTOEmail, strCCEmailID, , strSubject, strHi, strBody, strRegards, True, strDisplayName))
                    Else
                        strHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("EmployeeName"), ""), ""))
                    End If
                    strHTML.Append("</TD>")
                    strHTML.Append("<TD width='30%' valign=top  title='" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("BirthDate"), ""), "") + "' align=Left>")
                    strHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("BirthDate"), ""), ""))
                    strHTML.Append("</TD></TR>")
                End If
                intRowsCounter += 1
            Next
        End If

        For intBlankRowsCount = 0 To intPageSize - intRowsCounter
            strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
            strHTML.Append("<TD width=100% align=left align=Left colspan=3 valign=top >&nbsp;")
            strHTML.Append("</TD></TR>")
        Next
        strHTML.Append("</TABLE>")
        If intFromAjax = 0 Then
            Return strHTML.ToString
        Else
            Response.Clear()
            strHTML.Append("#=##=#")
            strHTML.Append(m_intTotalNoOfRows.ToString())
            Response.Write(strHTML.ToString)
            Response.End()
            strHTML = Nothing
        End If
    End Function
    Public Function PlotHelpDeskRequests(Optional ByVal intFromAjax As Integer = 0, Optional ByVal intShowall As Integer = 0) As String
        Dim strHTML As New System.Text.StringBuilder
        Dim intCurrentIndex As Integer
        intCurrentpageNumber = CommonFunction.General.CheckIsNothing(Request.Form("txtCurrentPage_24"), "0")
        Dim strSearchText As String = ""
        Dim strSQL As String = ""
        Dim strTagID As String = "0"
        Dim strTotalROws As String = "0"
        Dim intBlankRowsCount As Integer = 0
        Dim intRowsCounter As Integer = 0

        intPageSize = 7

        If intShowall = 0 Then
            dsWorkbox = CommonFunction.Data.GetDataSet("usp_sel_HelpDesk_MyHome " + m_intUserID.ToString + ",'" + m_strLoginType + "'", "MyWorkBox")
            strHTML.Append("<table id='tblGroup24' height='75%'  CELLPADDING=""0"" CELLSPACING=""0"" Class='clsRoundedTableMenu' width='100%'>") 'height='110px'
            strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'><TD  align=Left valign=top WIDTH=""100%"">")
            strHTML.Append("<img align=middle src='../../Images/Home/helpdesk.png' border=0>")
            strHTML.Append("<FONT color='#FF6600'> Tab displays helpdesk requests are assigned to you.")
            If dsWorkbox.Tables.Count > 0 Then
                If dsWorkbox.Tables(0).Rows.Count > 0 Then
                    strHTML.Append("Please take necessary action.")
                End If
                strHTML.Append("</FONT>")
                strHTML.Append("</TD>")
                strHTML.Append("</TR>")


                For Each objDr As DataRow In dsWorkbox.Tables(0).Rows
                    strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
                    strSummary = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Summary"), ""), "")
                    strTagID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("TagID"), "0"), "0")
                    strTotalROws = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("TotalRows"), "0"), "0")
                    strHTML.Append("<TD width=70% align=left title=""" + strSummary + """ align=Left   valign=top >")
                    strHTML.Append(CommonFunction.General.BuildQueryString(strSummary))
                    strHTML.Append("</TD>")
                    If strTotalROws <> "0" Then
                        strHTML.Append("<TD width=30% align=right  style='cursor:pointer;' onclick='javascript:ExpandSection_Onclick(24," + m_intTabPanelNumber.ToString + "," + strTagID + ")' style='font-size:10px;' onmouseover='javascript:ChangeMouseOverStyle(this)' onmouseout='javascript:ChangeMouseOutStyle(this)'>")
                        strHTML.Append(" [ <u>")
                        strHTML.Append(strTotalROws)
                        strHTML.Append("</u> ]")
                    Else
                        strHTML.Append("<TD width=30% align=right  style='font-size:10px;' onmouseover='javascript:ChangeMouseOverStyle(this)' onmouseout='javascript:ChangeMouseOutStyle(this)'>")
                        strHTML.Append(" [ ")
                        strHTML.Append(strTotalROws)
                        strHTML.Append(" ]")
                    End If
                    strHTML.Append("<input type='hidden' valign='middle' name='TotalRowsForWorkBox_24_" + strTagID + "' id='TotalRowsForWorkBox_24_" + strTagID + "' value='" + strTotalROws + "' width='80px' >")
                    strHTML.Append("</TD></TR>")
                    intRowsCounter += 1
                Next
            End If
            For intBlankRowsCount = 0 To intPageSize - intRowsCounter
                strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
                strHTML.Append("<TD width=100% align=left align=Left colspan='2'  valign=top >&nbsp;")
                strHTML.Append("</TD></TR>")
            Next
            strHTML.Append("</TABLE>")
        Else
            strSearchText = CommonFunction.General.CheckIsNothing(Request("SearchText"), "")
            If strSearchText = "" Then
                strSearchText = "NULL"
            End If
            strSQL = "usp_sel_HelpDesk_MyHome_ShowAll_Count " + m_intUserID.ToString + ",N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "'," + m_strTagID
            m_intTotalNoOfRows = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0"), Integer)
            strHTML.Append("<input type='hidden' valign='middle' name='TotalRowsForWorkBox_24_" + strTagID + "' id='TotalRowsForWorkBox_24_" + strTagID + "' value='" + m_intTotalNoOfRows.ToString + "' width='80px' >")

            strSQL = "usp_sel_HelpDesk_MyHome_ShowAll " + m_intUserID.ToString + ",N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "'," + m_strTagID

            strHTML.Append(GetDetails_ShowAll(strSQL, MenuGridIds.HELP_DESK))
        End If

        If intFromAjax = 0 Then
            Return strHTML.ToString
        Else
            Response.Clear()
            Response.Write(strHTML.ToString)
            Response.End()
            strHTML = Nothing
        End If


    End Function

    Public Function PlotMyWorkbox(Optional ByVal intFromAjax As Integer = 0, Optional ByVal intShowall As Integer = 0) As String
        Dim intCurrentIndex As Integer
        Dim strHTML As New System.Text.StringBuilder
        Dim strSearchIn As String = ""
        Dim strSearchText As String = ""
        Dim strSQL As String = ""
        Dim strEntityType As String = ""
        Dim intRowCounter As Integer = 0
        Dim strTagID As String = "0"
        Dim strTotalROws As String = "0"
        Dim intBlankRowsCount As Integer = 0
        Dim isEnteredInDelayedSection As Boolean = False
        m_intPageSize = 10
        If intShowall = 0 Then
            dsWorkbox = CommonFunction.Data.GetDataSet("usp_sel_MyWorkBox_MyHome " + m_intUserID.ToString + ",'" + m_strLoginType + "'", "MyWorkBox")
            strHTML.Append("<table id='tblGroup17' height='75%'   CELLPADDING=""0"" CELLSPACING=""0"" Class='clsRoundedTableMenu' width='100%'>") 'height='110px'
            strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'><TD colspan=4 align=Left valign=top WIDTH=""100%"">")
            strHTML.Append("<img align=middle src='../../Images/Home/my-work-book.png' border=0>")
            strHTML.Append("<FONT color='#FF6600'> Tab displays your total pending approvals and delayed activities.")
            If dsWorkbox.Tables.Count > 0 Then
                If dsWorkbox.Tables(0).Rows.Count > 0 Then
                    strHTML.Append(" Please take necessary action.")
                End If
                strHTML.Append("</FONT>")
                strHTML.Append("</TD>")
                strHTML.Append("</TR>")
                strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
                For Each objDr As DataRow In dsWorkbox.Tables(0).Rows
                    strEntityType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("EntityTYpe"), ""), "")
                    strSummary = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Summary"), ""), "")
                    strTagID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("TagID"), "0"), "0")
                    strTotalROws = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("TotalRows"), "0"), "0")
                    If intRowCounter = 0 And strEntityType = "P" Then
                        strHTML.Append("<TD width=100% align=left title=""Total pending approvals"" align=Left colspan='4'  valign=top ><font color='#FF6600'>Total</font> <font color ='green'><b>Pending</b></font> <font color='#FF6600'>approvals..</font></TD>")
                        strHTML.Append("</TR>")
                        strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;' >")
                    End If

                    If intRowCounter <> 0 And intRowCounter Mod 2 = 0 Then
                        strHTML.Append("</TR>")
                        strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;' >")
                    End If
                    If isEnteredInDelayedSection = False And strEntityType = "D" Then
                        If intRowCounter Mod 2 <> 0 Then
                            strHTML.Append("<TD width=50% align=left title=""Pending Approvals"" align=Left colspan='2'  valign=top >&nbsp;</TD>")
                        End If
                        strHTML.Append("</TR>")
                        strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;' >")
                        strHTML.Append("<TD width=100% align=left title=""Total delayed activities"" align=Left colspan='4'  valign=top ><font color='#FF6600'>Total</font> <font color ='red'><b>Delayed</b></font> <font color='#FF6600'>activities..</font></TD>")
                        strHTML.Append("</TR>")
                        strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;' >")
                        intRowCounter += 1
                        isEnteredInDelayedSection = True
                    End If
                    strHTML.Append("<TD width=45% align=left title=""" + strSummary + """ align=Left   valign=top >")
                    strHTML.Append(CommonFunction.General.BuildQueryString(strSummary))
                    strHTML.Append("</TD>")
                    If strTotalROws <> "0" Then
                        strHTML.Append("<TD width=5% align=right  style='cursor:pointer;' onclick='javascript:ExpandSection_Onclick(17," + m_intTabPanelNumber.ToString + "," + strTagID + ")' style='font-size:10px;' onmouseover='javascript:ChangeMouseOverStyle(this)' onmouseout='javascript:ChangeMouseOutStyle(this)'>")
                        strHTML.Append(" [ <u>")
                        strHTML.Append(strTotalROws)
                        strHTML.Append("</u> ]")
                    Else
                        strHTML.Append("<TD width=5% align=right  style='font-size:10px;' onmouseover='javascript:ChangeMouseOverStyle(this)' onmouseout='javascript:ChangeMouseOutStyle(this)'>")
                        strHTML.Append(" [ ")
                        strHTML.Append(strTotalROws)
                        strHTML.Append(" ]")
                    End If

                    strHTML.Append("<input type='hidden' valign='middle' name='TotalRowsForWorkBox_17_" + strTagID + "' id='TotalRowsForWorkBox_17_" + strTagID + "' value='" + strTotalROws + "' width='80px' >")
                    strHTML.Append("</TD>")
                    intRowCounter += 1
                Next
                If intRowCounter Mod 2 <> 0 Then
                    strHTML.Append("<TD width=50% align=left title=""Pending Approvals"" align=Left colspan='2'  valign=top >&nbsp;</TD>")
                End If
                strHTML.Append("</TR>")

            End If

            For intBlankRowsCount = 1 To intPageSize - intRowCounter
                strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
                strHTML.Append("<TD width=100% align=left align=Left colspan='4'  valign=top >&nbsp;")
                strHTML.Append("</TD></TR>")
            Next
            strHTML.Append("</TABLE>")
        Else
            strSearchText = CommonFunction.General.CheckIsNothing(Request("SearchText"), "")
            If strSearchText = "" Then
                strSearchText = "NULL"
            End If
            strSQL = "usp_sel_MyWorkBox_MyHome_ShowAll_Count " + m_intUserID.ToString + ",N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "'," + m_strTagID
            m_intTotalNoOfRows = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0"), Integer)
            strSQL = "usp_sel_MyWorkBox_MyHome_ShowAll " + m_intUserID.ToString + ",N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "'," + m_strTagID

            strHTML.Append(GetDetails_ShowAll(strSQL, 17))
        End If
        If intFromAjax = 0 Then
            Return strHTML.ToString
        Else
            Response.Clear()
            strHTML.Append("#=##=#")
            strHTML.Append(m_intTotalNoOfRows.ToString())
            Response.Write(strHTML.ToString)
            Response.End()
            strHTML = Nothing
        End If
    End Function
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub
    Private Sub GetTagAccessRights(ByVal TagID As Long)
        m_objGlobal.TagID = TagID
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess(True)
    End Sub
    Public Function PlotMyTimesheet(Optional ByVal intFromAjax As Integer = 0) As String
        Dim strHTML As New System.Text.StringBuilder
        Dim intRowCounter As Integer = 0
        Dim intBlankRowsCount As Integer = 0
        Dim intTotalCount As Integer = 0
        GetTagAccessRights(3986)
        '3986
        intTotalCount = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_Timesheet_MyHome " + m_intUserID.ToString + ",'" + m_strLoginType + "'", MyBase.UseSQL), "0"), Integer)

        strHTML.Append("<table id='tblGroup19' height='75%' CELLPADDING=""0"" CELLSPACING=""0"" Class='clsRoundedTableMenu' width='100%'>") 'height='110px'
        strHTML.Append("<TR class='clsTRBlank' style='font-size:10px;'><TD  align=Left valign=top WIDTH=""100%"">")
        strHTML.Append("<img align=middle src='../../Images/Home/timesheet.png' border=0>")
        strHTML.Append("<FONT color='#FF6600'> You have " + intTotalCount.ToString + " pending tasks.")
        If intTotalCount > 0 Then
            strHTML.Append("Please fill Daily activity against it.")
        End If
        strHTML.Append("</FONT>")
        strHTML.Append("</TD></TR>")
        If m_strLoginType = "E" And m_objAccessRights.IsModuleAccessible = True Then
            strHTML.Append("<TR class='clsTRBlank' style='font-size:10px;'><TD  align=Left valign=top WIDTH=""100%"">")
            strHTML.Append("<a href=""javascript:OpenPage_Onclick('../AdvancedTimesheet/Advanced_Timesheet.aspx?FromWhere=DA',0,0,0,0)"" >Timesheet Entry</a>")
            strHTML.Append("</TD></TR>")
            intRowCounter += 1
        End If


        For intBlankRowsCount = 0 To intPageSize - intRowCounter
            strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
            strHTML.Append("<TD width=100% align=left align=Left valign=top >&nbsp;")
            strHTML.Append("</TD></TR>")
        Next

        strHTML.Append("</TABLE>")
        If intFromAjax = 0 Then
            Return strHTML.ToString
        Else
            Response.Clear()
            Response.Write(strHTML.ToString)
            Response.End()
            strHTML = Nothing
        End If

    End Function
    Public Function PlotMyRequests(Optional ByVal intFromAjax As Integer = 0, Optional ByVal intShowall As Integer = 0) As String
        Dim strHTML As New System.Text.StringBuilder
        Dim intCurrentIndex As Integer
        intCurrentpageNumber = CommonFunction.General.CheckIsNothing(Request.Form("txtCurrentPage_20"), "0")
        Dim strSearchIn As String = ""
        Dim strSearchText As String = ""
        Dim strTotalROws As String = "0"
        Dim strTagID As String = "0"
        Dim intBlankRowsCount As Integer = 0
        Dim intRowsCounter As Integer = 0
        GetTagAccessRights(405)
        intPageSize = 7
        If intShowall = 0 Then
            dsWorkbox = CommonFunction.Data.GetDataSet("usp_sel_MyRequests_MyHome " + m_intUserID.ToString + ",NULL,NULL,'" + m_strLoginType + "'", "MyWorkBox")
            strHTML.Append("<table id='tblGroup20' height='75%'  CELLPADDING=""0"" CELLSPACING=""0"" Class='clsRoundedTableMenu' width='100%'>") ' height='110px'
            strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'><TD  align=Left valign=top WIDTH=""100%"">")
            strHTML.Append("<img align=middle src='../../Images/Home/my-requests.png' border=0>")
            strHTML.Append("<FONT color='#FF6600'> This tab displays the status of your submitted requests. </FONT>")
            strHTML.Append("</TD>")
            strHTML.Append("</TR>")
            If dsWorkbox.Tables.Count > 0 Then
                For Each objDr As DataRow In dsWorkbox.Tables(0).Rows

                    strSummary = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Summary"), ""), "")
                    strTagID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("TagID"), "0"), "0")
                    strTotalROws = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("TotalRows"), "0"), "0")
                    strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
                    strHTML.Append("<TD width=70% align=left title=""" + strSummary + """ align=Left   valign=top >")
                    strHTML.Append(CommonFunction.General.BuildQueryString(strSummary))
                    strHTML.Append("</TD>")

                    If strTotalROws <> "0" Then
                        strHTML.Append("<TD width=30% align=right  style='cursor:pointer;' onclick='javascript:ExpandSection_Onclick(20," + m_intTabPanelNumber.ToString + "," + strTagID + ")' style='font-size:10px;' onmouseover='javascript:ChangeMouseOverStyle(this)' onmouseout='javascript:ChangeMouseOutStyle(this)'>")
                        strHTML.Append(" [ <u>")
                        strHTML.Append(strTotalROws)
                        strHTML.Append("</u> ]")
                    Else
                        strHTML.Append("<TD width=30% align=right  style='font-size:10px;' onmouseover='javascript:ChangeMouseOverStyle(this)' onmouseout='javascript:ChangeMouseOutStyle(this)'>")
                        strHTML.Append(" [ ")
                        strHTML.Append(strTotalROws)
                        strHTML.Append(" ]")
                    End If

                    strHTML.Append("<input type='hidden' valign='middle' name='TotalRowsForWorkBox_20_" + strTagID + "' id='TotalRowsForWorkBox_20_" + strTagID + "' value='" + strTotalROws + "' width='80px' >")
                    strHTML.Append("</TD>")
                    strHTML.Append("</TD></TR>")

                    intRowsCounter += 1
                Next
            End If
            
            If m_objAccessRights.IsModuleAccessible = True Then
                intRowsCounter += 1
                strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
                strHTML.Append("<TD align=center valign=top ><a href=""javascript:OpenPage_Onclick('../CRM/CRM_RequestList.aspx?Mode=SR',0,0,0,0)"" >Add Help Request</a></TD")
                strHTML.Append("></TR>")
            End If


            For intBlankRowsCount = 0 To intPageSize - intRowsCounter
                strHTML.Append("<TR class='clsTRControlMenu' style='font-size:10px;'>")
                strHTML.Append("<TD width=100% align=left align=Left colspan='2'  valign=top >&nbsp;")
                strHTML.Append("</TD></TR>")
            Next

            strHTML.Append("</TABLE>")

        Else

            strSearchText = CommonFunction.General.CheckIsNothing(Request("SearchText"), "")
            If strSearchText = "" Then
                strSearchText = "NULL"
            End If
            Dim strSQL As String = "usp_sel_MyRequests_MyHome_ShowAll_Count " + m_intUserID.ToString + ",N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "','" + m_strLoginType + "'," + m_strTagID
            m_intTotalNoOfRows = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0"), Integer)
            strSQL = "usp_sel_MyRequests_MyHome_ShowAll " + m_intUserID.ToString + ",N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "','" + m_strLoginType + "'," + m_strTagID
            strHTML.Append(GetDetails_ShowAll(strSQL, 20))

        End If


        If intFromAjax = 0 Then
            Return strHTML.ToString
        Else
            Response.Clear()
            Response.Write(strHTML.ToString)
            Response.End()
            strHTML = Nothing
        End If

    End Function

    Protected Sub UpdateSession()
        Dim strProjectID As String = ""
        Dim strProjectName As String = ""
        Dim strMainPage As String = ""
        Dim strHashtableKey As String = ""
        Dim strPath As String = System.AppDomain.CurrentDomain.BaseDirectory
        Dim strFromWhere As String = "PM"


        strPath = strPath.Replace("/", "\")
        strProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Params("ProjectID"), "")

        If strProjectID <> CommonFunction.General.CheckIsNothing(Session("intProjectID"), "") And strProjectID <> "" Then

            Session("intProjectID") = strProjectID
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            ''strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select ProjectName from tbl_PM_Project where ProjectID=" + strProjectID.ToString(), True), ""), "")
            strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_ProjectName_tbl_PM_Project " + strProjectID.ToString(), True), ""), "")
            ''end of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            Session("strProjectName") = strProjectName
            Session("intPostID") = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_EmployeeRoleOnProject " + CType(m_intUserID.ToString, String) + "," + strProjectID + "," + CType(m_strLoginType, String), True), "0"), String)
            strHashtableKey = "PM-" & Session("intProjectID") & "-" & CType(m_intUserID.ToString, String) & "-" & CType(Context.Session("intPostID"), String) & "-" & CType(m_strLoginType, String)

            If CommonEngines.HashTables.GetHashTableObject.IsUserTreeKeyExists(strHashtableKey) = False Then
                CommonEngines.HashTables.CreateHashTables.AddUserTreeKey(strHashtableKey)
                Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long))
            Else
                If CommonFunctions.FileDirectory.IsFileExists(strPath + "Reports\" & strHashtableKey & ".html") = False Then
                    Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long))
                End If
            End If

            If strMainPage = "" Then strMainPage = "../../Reports/" & strHashtableKey & ".html"

        End If

        Response.Clear()
        Response.Write("Session##" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("URL"), "") + "##" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("PKToken"), "") + "##"+strMainPage)
        Response.End()

    End Sub

    Protected Function ShowTasks(ByVal intPeriod As Integer, ByVal intFromAjax As Integer, Optional ByVal intShowall As Integer = 0) As String
        Dim objDatesDr As IDataReader
        Dim strHTML As New System.Text.StringBuilder
        Dim sbHTML As New System.Text.StringBuilder
        Dim intCurrentIndex As Integer = 0
        Dim StartDate As Date
        Dim EndDate As Date
        Dim intCnt As Integer = 0
        Dim strWeekDayName As String = ""
        Dim tempdate As Date
        Dim isNonWorkingDay As Boolean '
        Dim strSearchText As String = ""
        Dim intRowsCounter As Integer = 0
        Dim intBlankRowsCount As Integer = 0
        Dim intCountRecords As Integer = 0
        If intFromAjax = 1 Then
            strSearchText = CommonFunction.General.CheckIsNothing(Request("SearchText"), "")
            If strSearchText = "" Then
                strSearchText = "NULL"
            End If
        End If
        intPageSize = 7
        objDatesDr = CommonFunction.Data.GetDataReader("usp_sel_ActivitiesEndingOnDate_MyHome " + m_intUserID.ToString + "," + intPeriod.ToString + ",0,NULL,'" + m_strLoginType + "'", True)
        While objDatesDr.Read
            StartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDatesDr("StartDate"), ""), "")
            EndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDatesDr("EndDate"), ""), "")
        End While
        CommonFunction.Data.DisposeDataReader(objDatesDr)

        If intShowall = 0 Then
            dsWorkbox = CommonFunction.Data.GetDataSet("usp_sel_ActivitiesEndingOnDate_MyHome " + m_intUserID.ToString + "," + intPeriod.ToString + ",1,NULL,'" + m_strLoginType + "'", "MyWorkBox")
            strHTML.Append("<table id='tblGroup23' height='75%'  CELLPADDING=""1"" CELLSPACING=""1"" Class='clsGridTable' width='99.99%' style='border: 1px solid gray;overflow:auto;'>") ' height='110px'
        Else

            m_intTotalNoOfRows = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_ActivitiesEndingOnDate_MyHome_Count " + m_intUserID.ToString + "," + intPeriod.ToString + ",N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "','" + m_strLoginType + "'", MyBase.UseSQL), "0"), "0"), Integer)
            dsWorkbox = CommonFunction.Data.GetDataSet("usp_sel_ActivitiesEndingOnDate_MyHome " + m_intUserID.ToString + "," + intPeriod.ToString + ",1,N'" + CommonFunction.General.BuildQueryString(strSearchText.ToString) + "','" + m_strLoginType + "',1," + m_intCurrentPageNumber.ToString, "MyWorkBox")
            m_strSearchColumn = "Task"
            strHTML.Append("<table id='tblGroup23' CELLPADDING=""0"" CELLSPACING=""0"" Class='clsTable' width='100%' style='border: 1px solid gray;overflow:auto;'>")
            strHTML.Append("<TR class='clsTRBlank' style='font-size:10px;border-bottom:1px solid gray;' >")
            strHTML.Append("<TD align=center valign=middle width='100%'>")
            strHTML.Append(WritePaging(MenuGridIds.SHOW_TASK))
            strHTML.Append("</TD></TR>")
            strHTML.Append("<TR class='clsTRBlank' style='font-size:10px;border-bottom:1px solid gray;' >")
            strHTML.Append("<TD align=center valign=middle width='100%'>")
            strHTML.Append("<table CELLPADDING=""1"" CELLSPACING=""1"" Class='clsGridTable' width='100%' style='border: 1px solid gray;overflow:auto;'>")
        End If
        If intPeriod = 1 Then
            strHTML.Append("<TR class='clsTRBlank' style='font-size:10px;border-bottom:1px solid gray;' >")
            strHTML.Append("<TD align=Left valign=top><b>Task</b></TD>")
            tempdate = StartDate
            If DateDiff("d", tempdate, EndDate) >= 0 Then
                strWeekDayName = WeekdayName(Weekday(tempdate), True, vbSunday).Substring(0, WeekdayName(Weekday(tempdate), True, vbSunday).Length - 1) + vbCrLf + Day(tempdate).ToString
                If strWeekDayName.IndexOf("Sa") >= 0 Or strWeekDayName.IndexOf("Su") >= 0 Then
                    strHTML.Append("<TD align=center valign=top><b><FONT color='RED'>" + strWeekDayName + "</FONT></b>")
                Else
                    strHTML.Append("<TD align=center valign=top><b>" + strWeekDayName + "</b>")
                End If
            End If
            strHTML.Append("</TD></TR>")
            If dsWorkbox.Tables.Count > 0 Then
                For Each objDr As DataRow In dsWorkbox.Tables(0).Rows
                    If (intRowsCounter + m_intDetailViewPageSize) >= (m_intDetailViewPageSize * m_intCurrentPageNumber) Then
                        strHTML.Append("<TR class='clsTRBlank' style='font-size:10px;' onmouseover='javascript:ChangeMouseOverStyle(this)' onmouseout='javascript:ChangeMouseOutStyle(this)'>")
                        strSummary = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("TaskName"), ""), "")
                        strHTML.Append("<TD width='20%' title='" + strSummary + "' align=Left  valign=top>")
                        strHTML.Append(IIf(strSummary.Length > 40, strSummary.Substring(0, Math.Min(40, strSummary.Length)) + "...", strSummary).ToString)
                        strHTML.Append("</TD>")
                        intCnt = 1
                        tempdate = StartDate
                        If DateDiff("d", tempdate, EndDate) >= 0 Then
                            If intCnt = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Diff"), "0"), "0") + 1 Then
                                strHTML.Append("<TD width='80%' align=center valign=top><img src='../../Images/Home/diamond.gif'>")
                            Else
                                strHTML.Append("<TD width='80%' align=left valign=top>&nbsp;")
                            End If
                            strHTML.Append("</TD>")
                        End If
                        strHTML.Append("</TR>")
                    End If
                    intRowsCounter += 1
                Next
            End If

        End If
        If intPeriod = 2 Or intPeriod = 3 Or intPeriod = 4 Then
            strHTML.Append("<TR  class='clsTRBlank' style='font-size:10px;border-bottom:1px solid gray;' >")
            strHTML.Append("<TD align=Left valign=top><b>Task</b></TD>")
            tempdate = StartDate
            While DateDiff("d", tempdate, EndDate) >= 0
                strWeekDayName = WeekdayName(Weekday(tempdate), True, vbSunday).Substring(0, WeekdayName(Weekday(tempdate), True, vbSunday).Length - 1) + vbCrLf + Day(tempdate).ToString '+ "[" + CStr(GetShortDate(tempdate)) + "]"
                isNonWorkingDay = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_DA_HolidayORLeaveStatus " + m_intUserID.ToString + ",'" + tempdate.ToString + "'", True), "false"), "false")
                If isNonWorkingDay = True Or isNonWorkingDay = "1" Then
                    strHTML.Append("<TD align=center valign=top><b><FONT color='RED'>" + strWeekDayName + "</FONT></b></TD>")
                Else
                    strHTML.Append("<TD align=center valign=top><b>" + strWeekDayName + "</b></TD>")
                End If
                tempdate = DateAdd("d", 1, tempdate)
            End While
            strHTML.Append("</TR>")

            If dsWorkbox.Tables.Count > 0 Then
                For Each objDr As DataRow In dsWorkbox.Tables(0).Rows
                    If (intRowsCounter + m_intDetailViewPageSize) >= (m_intDetailViewPageSize * m_intCurrentPageNumber) Then
                        strHTML.Append("<TR onmouseover='javascript:ChangeMouseOverStyle(this)' onmouseout='javascript:ChangeMouseOutStyle(this)' class='clsTRBlank' style='font-size:10px;'>")
                        strSummary = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("TaskName"), ""), "")
                        strHTML.Append("<TD width='20%' title='" + strSummary + "' align=Left  valign=top>")
                        strHTML.Append(IIf(strSummary.Length > 40, strSummary.Substring(0, Math.Min(40, strSummary.Length)) + "..", strSummary).ToString)
                        strHTML.Append("</TD>")
                        intCnt = 1
                        tempdate = StartDate
                        While DateDiff("d", tempdate, EndDate) >= 0
                            If intCnt = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Diff"), "0"), "0") + 1 Then
                                strHTML.Append("<TD align=center valign=top><img src='../../Images/Home/diamond.gif'>")
                            Else
                                strHTML.Append("<TD align=center valign=top>&nbsp;")
                            End If
                            strHTML.Append("</TD>")
                            tempdate = DateAdd("d", 1, tempdate)
                            intCnt = intCnt + 1
                        End While
                        strHTML.Append("</TR>")
                    End If
                    intRowsCounter += 1
                Next
            End If
           
        End If

        If intRowsCounter < 5 Then
            strHTML.Append("<TR class='clsTRBlank' style='font-size:10px;'>")
            intCnt = IIf(intPeriod = 1, 3, IIf(intPeriod = 2, 8, IIf(intPeriod = 3, 15, IIf(intPeriod = 4, 32, 2)))).ToString
            strHTML.Append("<TD width=100% align=left align=Left colspan='" + intCnt.ToString.ToString + "' valign=top >&nbsp;")
            strHTML.Append("<table CELLPADDING=""0"" CELLSPACING=""0"" Class='clsTable' width='99.99%' style='border: 0px solid gray;overflow:auto;'>") ' height='110px'

            For intBlankRowsCount = 1 To intPageSize - intRowsCounter
                strHTML.Append("<TR class='clsTRBlank' style='font-size:10px;'>")
                strHTML.Append("<TD width=100% align=left align=Left valign=top >&nbsp;")
                strHTML.Append("</TD></TR>")
            Next
            strHTML.Append("</TABLE>")
            If intShowall = 1 Then
                strHTML.Append("</TD>")
                strHTML.Append("</TR></TABLE>")
            End If
        End If


        strHTML.Append("</TABLE>")
        If intFromAjax = 1 Then
            Response.Clear()
            sbHTML.Append("Tasks##")
            sbHTML.Append(WeekdayName(Weekday(StartDate), True, vbSunday) + " ")
            sbHTML.Append(CommonFunction.Dates.CGetDate(StartDate) + "##")
            sbHTML.Append(WeekdayName(Weekday(EndDate), True, vbSunday) + " ")
            sbHTML.Append(CommonFunction.Dates.CGetDate(EndDate) + "##")
            sbHTML.Append(strHTML.ToString)
            Response.Write(sbHTML.ToString)
            sbHTML = Nothing
            strHTML = Nothing
            dsWorkbox = Nothing
            Response.End()
        Else
            Return strHTML.ToString
        End If

    End Function

    Function GetShortDate(ByVal dTDate As Date) As String
        Dim intDate As Integer
        Dim strMonth As String

        intDate = Day(dTDate)
        strMonth = MonthName(Month(dTDate), True) + " " + CType(intDate, String)

        GetShortDate = strMonth

    End Function

    Protected Overrides Sub Finalize()
        dsWorkbox = Nothing
        MyBase.Finalize()
    End Sub

    Protected Function GetDetails_ShowAll(ByVal strSQL As String, ByVal intGroupID As Integer) As String

        Dim sbHTML As New System.Text.StringBuilder
        Dim dsGrid As DataSet
        Dim intCount As Integer = 0
        Dim intCountRecords As Integer = 0
        Dim strSortColumnName As String = ""
        m_objDetailsGrid = New WebPages.Template.GenericGrid
        Dim intAdditionalColumn As Integer = -1
        'Dim arrCheckBox() As String = {"", "", "", "", "", "", "chkResourceTimesheetApprover"}

        strSQL = strSQL + "," + m_intCurrentPageNumber.ToString
        dsGrid = CommonFunction.Data.GetDataSet(strSQL, "DetailsGrid")
        If dsGrid.Tables.Count > 0 Then
            If dsGrid.Tables(0).Columns.Count < 4 Then
                m_intNoOfDisplayDetailsViewColumn = dsGrid.Tables(0).Columns.Count
            End If
        End If
        If m_strTagID = "2125" And intGroupID = MenuGridIds.MY_WORK_BOX Then
            intAdditionalColumn = 1
        End If
        m_intGroupPanelID = intGroupID
        sbHTML.Append("<Table valign='top' id='tblGroup" + intGroupID.ToString + "' width='100%' CellSpacing=1 CellPadding=0  class='clsTable' >")
        sbHTML.Append("<tr><td>")
        Dim arrActualColumns(m_intNoOfDisplayDetailsViewColumn + intAdditionalColumn) As String '= {"EmployeeName", "FromDate", "ToDate", "LeaveType", "", ""}
        Dim arrUserFriendlyColumn(m_intNoOfDisplayDetailsViewColumn + intAdditionalColumn) As String '= {"Employee Name", "From Date", "To Date", "Leave Type", "Comment", "Select"}
        Dim arrTDStyle(m_intNoOfDisplayDetailsViewColumn + intAdditionalColumn) As String '= {"align=left", "align=left", "align=left", "align=left", "align=center", "align=center"}
        Dim arrCheckBox(m_intNoOfDisplayDetailsViewColumn + intAdditionalColumn) As String
        ' Dim arrCheckBox(m_intNoOfDisplayDetailsViewColumn) As String '= {"", "", "", "", "", "chkLeaveApprove"}
        If dsGrid.Tables.Count > 0 Then
            For Each dsColumnName As DataColumn In dsGrid.Tables(0).Columns
                If intCount < m_intNoOfDisplayDetailsViewColumn Then
                    If dsColumnName.DataType.ToString.ToUpper = "INT" Or dsColumnName.DataType.ToString.ToUpper = "FLOAT" Or dsColumnName.DataType.ToString.ToUpper = "SYSTEM.SINGLE" Then
                        arrTDStyle(intCount) = "Right"
                    Else
                        arrTDStyle(intCount) = "Left"
                    End If
                    arrActualColumns(intCount) = dsColumnName.ColumnName.ToString
                    arrUserFriendlyColumn(intCount) = dsColumnName.ColumnName.ToString
                    arrCheckBox(intCount) = ""
                End If
                If intCount = 0 Then
                    m_strSearchColumn = dsColumnName.ColumnName.ToString
                    strSortColumnName = dsColumnName.ColumnName.ToString
                End If
                intCount += 1
            Next
            If m_strTagID = "2125" And intGroupID = MenuGridIds.MY_WORK_BOX Then
                arrActualColumns(m_intNoOfDisplayDetailsViewColumn) = ""
                arrUserFriendlyColumn(m_intNoOfDisplayDetailsViewColumn) = "Comment"
                arrTDStyle(m_intNoOfDisplayDetailsViewColumn) = "center"
                arrCheckBox(m_intNoOfDisplayDetailsViewColumn) = ""
                arrActualColumns(m_intNoOfDisplayDetailsViewColumn + intAdditionalColumn) = ""
                arrUserFriendlyColumn(m_intNoOfDisplayDetailsViewColumn + intAdditionalColumn) = "Select"
                arrTDStyle(m_intNoOfDisplayDetailsViewColumn + intAdditionalColumn) = "center"
                arrCheckBox(m_intNoOfDisplayDetailsViewColumn + intAdditionalColumn) = "chkResourceTimesheetApprover"
            End If
            sbHTML.Append(WritePaging(intGroupID))
            With m_objDetailsGrid
                .UserFriendlyColumnArray = arrUserFriendlyColumn
                .ActualColumnArray = arrActualColumns
                .TDStyleArray = arrTDStyle
                If m_strTagID = "2125" And intGroupID = MenuGridIds.MY_WORK_BOX Then
                    .CheckBoxIDArray = arrCheckBox
                    .NoOfDataColumns = m_intNoOfDisplayDetailsViewColumn + 2
                Else
                    .NoOfDataColumns = m_intNoOfDisplayDetailsViewColumn
                End If
                .EmptyValueReplacement = "&nbsp;"
                .PrimaryKey = "EntityID"
                .PageSize = m_intDetailViewPageSize
                .CurrentPage = m_intCurrentPageNumber
                .GridDataTable = dsGrid.Tables(0)
                .UseSQL = MyBase.UseSQL
                .SortBy = strSortColumnName
                .SortOrder = "ASC"
                .DIVID = "DivDetailsView"
                .DIVHeight = 350
                .DIVStyle = "overflow:auto;width:99.99%;"
                .returnHTML = True
                sbHTML.Append(.DrawGrid())
            End With
        End If
        sbHTML.Append("</td><tr></table>")
        m_objDetailsGrid = Nothing
        dsGrid = Nothing

        'dsGrid = CommonFunction.Data.GetDataSet(strSQL, "DetailsGrid")
        'sbHTML.Append("<Table valign='top' id='tblGroup" + intGroupID.ToString + "' width='100%' CellSpacing=1 CellPadding=0  class='clsGridTable' >")
        'sbHTML.Append("<TR class='clsTRColumnHeader'>")
        'Dim arrAlignColumn(dsGrid.Tables(0).Columns.Count) As String
        'If dsGrid.Tables(0).Columns.Count < 4 Then
        '    m_intNoOfDisplayDetailsViewColumn = arrAlignColumn.Length
        'End If
        'For Each dsColumnName As DataColumn In dsGrid.Tables(0).Columns
        '    If intCount < m_intNoOfDisplayDetailsViewColumn Then
        '        If dsColumnName.DataType.ToString.ToUpper = "INT" Or dsColumnName.DataType.ToString.ToUpper = "FLOAT" Or dsColumnName.DataType.ToString.ToUpper = "REAL" Then
        '            strAlign = "Right"
        '        Else
        '            strAlign = "Left"
        '        End If
        '        arrAlignColumn(intCount) = strAlign
        '        sbHTML.Append("<TD align='" + strAlign + "'><b>")
        '        sbHTML.Append(dsColumnName.ColumnName.ToString)
        '        sbHTML.Append("</b></TD>")
        '    End If
        '    intCount += 1
        'Next
        'sbHTML.Append("</TR>")
        'intCount = 0
        'Dim strColumnValue As String = ""
        'Dim strPageNAme As String = ""
        'Dim strProjectID As String = "0"
        'Dim strEntityID As String = "0"

        'For Each dsRowsName As DataRow In dsGrid.Tables(0).Rows
        '    strPageNAme = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dsRowsName("PageName"), ""), ""))
        '    strProjectID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dsRowsName("ProjectID"), "0"), "0").ToString
        '    strEntityID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dsRowsName("EntityID"), ""), "")

        '    sbHTML.Append("<TR class='clsTROdd' onmouseover='this.className=""cSelected""' onmouseout='this.className=""clsTROdd""'>")
        '    If CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dsRowsName("Entity"), ""), "") = "IR" Then
        '        strPKToken = CommonFunctions.Security.Token.GetToken(CType(strEntityID, String) + m_intUserID.ToString + CType(2074, String) + CType(0, String) + CType(strProjectID, String))
        '    Else
        '        strPKToken = CommonFunctions.Security.Token.GetToken(strEntityID.ToString + m_intUserID.ToString + "0" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dsRowsName("TagID"), ""), ""))
        '    End If

        '    For intCount = 0 To m_intNoOfDisplayDetailsViewColumn - 1
        '        strColumnValue = HttpContext.Current.Server.HtmlEncode(CommonFunction.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dsRowsName(intCount), ""), ""))).ToString()
        '        sbHTML.Append("<td align='" + arrAlignColumn(intCount).ToString + "' title='" + strColumnValue + "' ")

        '        If intCount = 0 Then
        '            strSummary = IIf(strColumnValue.Length > 50, strColumnValue.Substring(0, Math.Min(50, strColumnValue.Length)) + "....", CommonFunction.General.BuildQueryString(strColumnValue)).ToString
        '            If m_strTagID = "40002" Or m_strTagID = "1208" Then
        '                sbHTML.Append(">")
        '            Else
        '                sbHTML.Append(" style='cursor:pointer;'  valign='top' onclick=javascript:OpenPage('" + strPageNAme + "','" + strPKToken + "'," + strProjectID + ")>")
        '            End If
        '            sbHTML.Append(CommonFunction.General.BuildQueryString(strSummary))
        '        Else
        '            sbHTML.Append(">")
        '            sbHTML.Append(CommonFunction.General.BuildQueryString(strColumnValue))
        '        End If
        '        sbHTML.Append("</TD>")
        '    Next
        '    intCountRecords += 1
        '    sbHTML.Append("</TR>")
        'Next
        'sbHTML.Append("</Table>")
        Return sbHTML.ToString
        sbHTML = Nothing
    End Function
    Private Function GenerateMenu(ByVal strCurrentPageNumber As String, ByVal strMenuGroupID As String, ByVal strTagID As String) As String
        '=====================================================================
        ' function Name         : GenerateTopMenu()	
        ' Purpose               : To generate top and bottom menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 9:57 AM 9/17/2007
        ' Revisions             :
        '=====================================================================
        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/approve.gif'>Approve")
        ArrTopMenuToolTipsList.Add("Approve")
        ArrTopMenuFunctionsList.Add("Approve_OnClick(" + strCurrentPageNumber + "," + strMenuGroupID + "," + strTagID + ")")

        ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/SelectAll.gif'>Select All")
        ArrTopMenuToolTipsList.Add("Select All")
        ArrTopMenuFunctionsList.Add("SelectAll_OnClick()")

        ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/ClearAll.gif'>ClearAll")
        ArrTopMenuToolTipsList.Add("Claer All")
        ArrTopMenuFunctionsList.Add("ClearAllOnClick()")

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing
        Return m_objMenu.DrawMenuWithEvents(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True, , "clsRoundedTableHeader")
    End Function
    Private Function WritePaging(ByVal intMenuGroupID As Integer) As String
        '=====================================================================
        ' function Name         : WritePaging(ByVal strGridName As String, ByVal intGridNo As Integer)
        ' Purpose               : To write the paging for the request grid
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                :  MahendraV
        ' Created               : 11:10 AM 9/17/2007
        ' Revisions             :
        '=====================================================================

        Dim intRecordCount As Integer
        Dim dsObject As DataSet
        Dim sbPagingHTML As New StringBuilder

        sbPagingHTML.Append("<TABLE border='0' cellspacing = '1' width = '100%'class='clsGridTable'><TR class='clsTRBlank'><TD width = '100%' valign=middle align=center >")

        sbPagingHTML.Append("<TABLE border='0' cellspacing = '0' width = '100%'class='clsTable'><TR class='clsTRBlank'><TD width = '20%' valign=top align=left >")

        ' sbPagingHTML.Append("<span valign=middle style='float:left;'>")
        'sbPagingHTML.Append(m_strSearchColumn + " : <input type='text' valign='middle' id='txtSearch_" + intMenuGroupID.ToString + "'  onkeypress='txtSearch_onkeypress(" & intMenuGroupID.ToString & ",event," + m_strTagID + ")'>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''sbPagingHTML.Append(m_strSearchColumn + " :" + CommonFunction.HTMLControls.DrawTextBox("txtSearch_" + CType(intMenuGroupID, String), "txtSearch_" + CType(intMenuGroupID, String), , 200, 400, m_strSearchText, "left", ToBeInserted:="onkeypress='txtSearch_onkeypress(" & intMenuGroupID.ToString & ",event," + m_strTagID + ")'", returnHTML:=True))
        sbPagingHTML.Append(m_strSearchColumn + " :" + CommonFunction.HTMLControls.DrawTextBox("txtSearch_" + CType(intMenuGroupID, String), "txtSearch_" + CType(intMenuGroupID, String), , 200, 400, m_strSearchText, "left", ToBeInserted:="onkeypress='txtSearch_onkeypress(" & intMenuGroupID.ToString & ",event," + m_strTagID + ")'", returnHTML:=True, EnableHTMLEncode:=True))
        sbPagingHTML.Append("</TD>")
        'sbPagingHTML.Append("<span  valign=middle style='float:right;'>")
        sbPagingHTML.Append("<TD width = '50%' valign=top align=right >")
        If m_strTagID = "2125" And intMenuGroupID = MenuGridIds.MY_WORK_BOX Then
            sbPagingHTML.Append(GenerateMenu(m_intCurrentPageNumber, intMenuGroupID, m_strTagID))
        End If
        sbPagingHTML.Append("</TD>")
        'sbPagingHTML.Append("<span valign=middle style='float:right;'>")
        sbPagingHTML.Append("<TD width = '30%' valign=top align=right >")
        sbPagingHTML.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage(" + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">&nbsp;")
        sbPagingHTML.Append("<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>")
        sbPagingHTML.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage(" + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbPagingHTML.Append("<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>")

        Select Case intMenuGroupID
            Case MenuGridIds.MY_WORK_BOX
                'm_intTotalNoOfRows = m_intLeaveTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intDetailViewPageSize) < m_intCurrentPageNumber Then
                    m_intCurrentPageNumber = 1
                End If
                If m_intCurrentPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    '    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True))
                    'Else
                    '    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, m_intCurrentPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True))
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, m_intCurrentPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))

                End If
            Case MenuGridIds.TIMESHEET
                ' m_intTotalNoOfRows = m_intIRTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intDetailViewPageSize) < m_intCurrentPageNumber Then
                    m_intCurrentPageNumber = 1
                End If
                If m_intCurrentPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    '    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True))
                    'Else
                    '    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, m_intCurrentPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True))
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, m_intCurrentPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))

                End If
            Case MenuGridIds.SHOW_TASK
                'm_intTotalNoOfRows = m_intExpenseTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intDetailViewPageSize) < m_intCurrentPageNumber Then
                    m_intCurrentPageNumber = 1
                End If
                If m_intCurrentPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    '    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True))
                    'Else
                    '    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, m_intCurrentPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True))
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, m_intCurrentPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))
                End If
            Case MenuGridIds.MY_REQUEST
                ' m_intTotalNoOfRows = m_intProjectTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intDetailViewPageSize) < m_intCurrentPageNumber Then
                    m_intCurrentPageNumber = 1
                End If
                If m_intCurrentPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    '    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True))
                    'Else
                    '    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, m_intCurrentPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True))
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, m_intCurrentPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))

                End If
            Case MenuGridIds.HELP_DESK
                ' m_intTotalNoOfRows = m_intProjectTimeSheetTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intDetailViewPageSize) < m_intCurrentPageNumber Then
                    m_intCurrentPageNumber = 1
                End If
                If m_intCurrentPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, m_intCurrentPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))
                End If
            Case MenuGridIds.KNOWLEDGE
                '  m_intTotalNoOfRows = m_intResourceTimeSheetTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intDetailViewPageSize) < m_intCurrentPageNumber Then
                    m_intCurrentPageNumber = 1
                End If
                If m_intCurrentPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, m_intCurrentPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))
                End If
            Case MenuGridIds.PEOPLE_I_KNOW
                ' m_intTotalNoOfRows = m_intResourceTimeSheetTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intDetailViewPageSize) < m_intCurrentPageNumber Then
                    m_intCurrentPageNumber = 1
                End If
                If m_intCurrentPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intMenuGroupID, String), "txtPageNumber" + CType(intMenuGroupID, String), , 50, 4, m_intCurrentPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")", returnHTML:=True, EnableHTMLEncode:=True))
                End If
        End Select

        sbPagingHTML.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage(" + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbPagingHTML.Append("<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>")
        sbPagingHTML.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage(" + CType(intMenuGroupID, String) + "," + CType(m_strTagID, String) + ")"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbPagingHTML.Append("<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> ")
        sbPagingHTML.Append("<input type=hidden id=hidNoOfPages" + CType(intMenuGroupID, String) + " value=" + (Math.Ceiling(m_intTotalNoOfRows / m_intDetailViewPageSize)).ToString + ">")
        sbPagingHTML.Append("of " + (Math.Ceiling(m_intTotalNoOfRows / m_intDetailViewPageSize)).ToString)
        'sbPagingHTML.Append(" |<A href='javascript:NumPage_OnClick(""-1""," + CType(intMenuGroupID, String) + ")' TITLE='Show All Records'><B>All</B> </A>")
        sbPagingHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages" + CType(intMenuGroupID, String), "txtNoOfPages" + CType(intMenuGroupID, String), , , , (Math.Ceiling(m_intTotalNoOfRows / m_intDetailViewPageSize)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))
        sbPagingHTML.Append("</TD>")
        sbPagingHTML.Append("</TR></TABLE>")
        sbPagingHTML.Append("</TD></TR></TABLE>")
        Return sbPagingHTML.ToString
    End Function

    Private Sub m_objDetailsGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objDetailsGrid.ColumnHeaderTD_BeforePrint
        If m_strTagID = "2125" And m_intGroupPanelID = MenuGridIds.MY_WORK_BOX Then
            If Args.ColumnName.ToUpper = "COMMENT" Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_0'  src='../../Images/Home/Details.gif' expand='true' onclick='javascript:DisplayComment(event,0)'  alt='Click to add Comment for all records.' >  <input type='hidden' id='txt_" + strEntityID + "' name='txt_0'</td>"
            End If
        End If
    End Sub

    Private Sub m_objDetailsGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objDetailsGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 0 Then
            Cancel = True
            strPageNAme = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("PageName"), ""), ""))
            strProjectID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), "0").ToString
            strEntityID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EntityID"), ""), "")
            If CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Entity"), ""), "") = "IR" Then
                strPKToken = CommonFunctions.Security.Token.GetToken(CType(strEntityID, String) + m_intUserID.ToString + CType(2074, String) + CType(0, String) + CType(strProjectID, String))
            Else
                strPKToken = CommonFunctions.Security.Token.GetToken(strEntityID.ToString + m_intUserID.ToString + "0" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TagID"), ""), ""))
            End If
            strColumnValue = HttpContext.Current.Server.HtmlEncode(CommonFunction.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Args.DataReader(0), ""), ""))).ToString()
            strSummary = IIf(strColumnValue.Length > 50, strColumnValue.Substring(0, Math.Min(50, strColumnValue.Length)) + "....", CommonFunction.General.BuildQueryString(strColumnValue)).ToString
            Args.StringToBeInserted = "<td align='left' title='" + strColumnValue + "'  "
            If m_strTagID = "40002" Or m_strTagID = "1209" Then
                Args.StringToBeInserted += ">"
            Else
                Args.StringToBeInserted += " onmouseover='javascript:ChangeMouseOverStyle(this)' onmouseout='javascript:ChangeMouseOutStyle(this)' style='cursor:pointer;'  valign='top'  onclick=javascript:OpenPage('" + strPageNAme + "','" + strPKToken + "'," + strProjectID + "," + strEntityID + ")>"
            End If
            Args.StringToBeInserted += CommonFunction.General.BuildQueryString(strSummary)
            Args.StringToBeInserted += "</TD>"
        End If

        If m_strTagID = "2125" And m_intGroupPanelID = MenuGridIds.MY_WORK_BOX Then
            If Args.ColumnName.ToUpper = "SELECT" Then
                Dim strEmployeeNAme As String = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Employee"), ""), ""))
                strEntityID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EntityID"), ""), "")

                Cancel = True
                Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strEntityID + "' name='Title_" + strEntityID + "' value = '" + strEmployeeNAme + " for Resource Timesheet Approvals'>"
                Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkResourceTimeSheetShow", "chkResourceTimeSheetShow", , False, strEntityID, , "language=Javascript OnClick=chkShow_OnClick()", True)
                Args.StringToBeInserted &= "</TD>"
            End If
            If Args.ColumnName.ToUpper = "COMMENT" Then
                Cancel = True
                 strEntityID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EntityID"), ""), "")
                Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(strEntityID, String) + "' disabled src='../../Images/Home/Details.gif' expand='true' onclick='javascript:DisplayComment(event," + CType(strEntityID, String) + ")'  alt='Click to add Comment' >  <input type='hidden' id='txt_" + strEntityID + "' name='txt_" + strEntityID + "'</td>"
            End If
        End If


    End Sub
End Class

