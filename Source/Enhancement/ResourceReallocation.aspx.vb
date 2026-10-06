Imports Whizible
Public Class ResourceReallocation
    Inherits WebPages.Template.WhizTemplate
    'Private WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected m_intProjectID As Integer
    Protected m_strAction As String
    Protected m_strLoginType As String
    Protected m_lngEmployeeID As Integer
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights          'This variable is for access rights of page.
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected strTemplate As String = "0"
    Protected m_TotalPlannedHours As Double = 0.0
    Protected AvailableWorkHours As Double = 0.0
    Protected Const m_MismatchAlert As String = "Available hours have exhausted, Please replan."

    Private m_TotalRecords As Integer
    Public m_RecruiterID As String
    Public m_BGID As String
    Public m_HiringManager As String
    Public m_strRecruiterId As String
    Public m_strPipelineId As String
    Public m_strOpportunityId As String

    'Added By Bharat Tekade on 2nd-April-2015
    Protected strStartDate As String = ""
    Protected strEndDate As String = ""
    Protected strBusinessGroup As String = "0"
    Protected strHiringMgr As String = "0"
    Protected strBGTemplate As String = "0"
    Protected strHMTemplate As String = "0"
    Protected m_strStartDate As String = ""
    Protected m_strEndDate As String = ""

    Public dtmSelectedDate As String
    Public dtmFromDate As String, dtmFromDate1 As String
    Public dtmToDate As String, dtmToDate1 As String
    Private m_strUserName As String = ""
    Protected strMenu As String
    'Ended By Bharat Tekade
    Protected intLostToCompetition As String
    Protected intLostWashByClient As String
    Protected intLostUnableToFulfill As String
    Protected intNoBid As String
    Protected RequestFTE As String
    Protected ApprovedFTE As String
    Protected StaffineNumber As String
    Protected JoinedFTE As String
    Protected OfferedFTE As String
    Protected WIP As String
    Protected Status As String
    Protected Employeeid, EmployeeName, ExpectedStartDate, ExpectedEndDate, ResourcePercentage As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'm_strLoginType = Session("LoginType").ToString
        'm_lngEmployeeID = CType(Session("intUserID"), Long)
        m_intProjectID = Session("intProjectID").ToString

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        If Not Request.QueryString("PipelineID_PK") Is Nothing Then
            m_strPipelineId = HttpContext.Current.Request.QueryString("PipelineID_PK")
        Else
            m_strPipelineId = ""
        End If

        If Not Request.QueryString("OpportunityID") Is Nothing Then
            m_strOpportunityId = HttpContext.Current.Request.QueryString("OpportunityID")
        Else
            m_strOpportunityId = ""
        End If
        ''

    End Sub
    'Commented by Dhanashri
    'Public Sub New()
    '    MyBase.ApplySecurity()
    '    MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    'End Sub
    'End of Comment

    Public Sub PageInit()
        GetGlobalObject()
        'InitVariables()
        Dim strSQLQuery As String
        Dim drResourceReallocation As IDataReader


        If m_strAction.ToUpper = "SAVE" Then
            SaveData()
        ElseIf m_strAction.ToUpper = "ISCHECKED" Then
            CheckedData()      
        End If

        'strSQLQuery = "usp_sel_ResourceDetails_ForReallocation " '& m_strOpportunityId & "," & m_strPipelineId
        'drResourceReallocation = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        'While drResourceReallocation.Read
        '    EmployeeName = CommonFunction.General.CheckIsNothing(drResourceReallocation("EmployeeName"))
        '    ExpectedStartDate = CommonFunction.General.CheckIsNothing(drResourceReallocation("ExpectedStartDate"))
        '    ExpectedEndDate = CommonFunction.General.CheckIsNothing(drResourceReallocation("ExpectedEndDate"))
        '    ResourcePercentage = CommonFunction.General.CheckIsNothing(drResourceReallocation("ResourcePercentage"))
        'End While

        WriteMenu_Filters()

        WritePage()

    End Sub
    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub

    Private Sub InitVariables()
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        m_intProjectID = CInt(Session("intProjectID"))
    End Sub

    Protected Sub WriteMenu_Filters()
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String
        Dim sbSTRHTML As New System.Text.StringBuilder


        Dim m_arrMenu() As String = {"Save", "Select All", "Clear All", "Close"}
        Dim m_arrMenuToolTip() As String = {"Save", "Select All", "Clear All", "Close"}
        Dim m_arrCSFunction() As String = {"Save_OnClick();", "SelectAll_OnClick()", "ClearAll_OnClick()", "window.close();"}

        arrMenu = m_arrMenu
        arrMenuToolTip = m_arrMenuToolTip
        arrCSFunction = m_arrCSFunction

        'Dim strMenu, strLegend As String
        'Dim arrLegend() As String = {"Mandatory"}
        'Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)

        CommonFunction.General.WriteHTML(strMenu)

        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Resource Reallocation", , , True))

        sbSTRHTML.Append("</BR>")

        'DrawStaffingPlanInfo(sbSTRHTML)


        ''DrawFields(sbSTRHTML)

        ''sbSTRHTML.Append("</div>")
        'sbSTRHTML.Append("<br>")

        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

    End Sub

    Protected Sub WritePage()

        Dim sbSTRHTML As New System.Text.StringBuilder

        sbSTRHTML.Append("<div id='divList' name='divList' style='overflow:auto;width:100%;' >") ''overflow:auto;
        'Diasplay Details in Grid
        'DisplayData_Grid(sbSTRHTML)
        sbSTRHTML.Append("<div id='divList1' name='divList1' style='overflow:auto;width:100%;background-color: #f6eee4;margin-bottom: 1px;' >") ''overflow:auto;
        UpdateStatusSection(sbSTRHTML)
        sbSTRHTML.Append("</div>")

        sbSTRHTML.Append("<div id='divList2' name='divList2' style='overflow:auto;width:100%;height: 515px;' >") ''overflow:auto;
        DisplayData_Grid(sbSTRHTML)
        sbSTRHTML.Append("</div>")

        sbSTRHTML.Append("</div>")
        'sbSTRHTML.Append("<div id=footer style='position:absolute;bottom:0;'>")
        sbSTRHTML.Append("<div id=footer style='bottom:0;'>")
        sbSTRHTML.Append(strMenu)
        sbSTRHTML.Append("</div>")
        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

    End Sub

    Protected Sub DrawStaffingPlanInfo(ByRef sbSTRHTML As System.Text.StringBuilder)
        Dim strQuery As String
        Dim strTemplateQryRecuiter As String = ""
        Dim strTemplateQryBG As String = ""
        Dim strTemplateQryHM As String = ""
        Dim dr As IDataReader
        Dim strStartDate As String
        Dim strEndDate As String
        Dim WorkHours As Double
        Dim strTempHTML As String = ""

        strQuery = ""

        sbSTRHTML.Append("<Div id=StaffingInfo >")

        sbSTRHTML.Append("<table id='tblStaffInfo' CellSpacing=0 CellPadding=0' class=clsTable width=100%>")
        sbSTRHTML.Append("<TR class='clsTREven'>")

        sbSTRHTML.Append("<TD valign='Top' align='Left' width=22%> Staffing Plan :</TD>")
        sbSTRHTML.Append("<TD valign='Top' align='Left'> " & StaffineNumber & " </TD>")
        sbSTRHTML.Append("</TR>")

        sbSTRHTML.Append("<TR class='clsTREven'>")
        sbSTRHTML.Append("<TD valign='Top' align='Left' width=18%> Requested FTE :</TD>")
        sbSTRHTML.Append("<TD valign='Top' align='Left'> " & RequestFTE & " </TD>")
        sbSTRHTML.Append("</TR>")

        sbSTRHTML.Append("<TR class='clsTREven'>")
        sbSTRHTML.Append("<TD valign='Top' align='Left' width=18%> Approved FTE :</TD>")
        sbSTRHTML.Append("<TD valign='Top' align='Left'> " & ApprovedFTE & "  </TD>")
        sbSTRHTML.Append("</TR>")
        sbSTRHTML.Append("</Table>")
        sbSTRHTML.Append("</Div>") ' Closing of staffing info div

    End Sub


    'Private Sub DisplayData_Grid(ByRef sbSTRHTML As System.Text.StringBuilder)
    '    Dim strQuery As String = ""

    '    'Commented and Added by ShubhangiD On 11 Aug 2015 : Removing Current City, current CTC, Expected CTC columns
    '    'Dim arrActualColumns() As String = {"CandidateName", "Qualification", "CurrentCity", "CurrentCompany", "PrimarySkills", "TotalExp", "NoticePeriod", "ContactNumber", "CurrentCTC", "ExpectedCTC", "IndustryWorked", "", "Stage", "Status", "", "", "", "", ""}
    '    'Dim arrUserFriendlyColumn() As String = {"Candidate Name", "Qualification", "Current city", "Current company", "Primary skills", "Total Exp", "Notice period", "Contact number", "Current CTC", "Expected CTC", "Industry worked", "Resume", "Stage", "Status", "Form", "Reimbursement Form", "Comments", "Uploaded Forms", "Select"}
    '    'Dim arrTDStyle() As String = {"Align=Center", "Align=Center", "", "", "", "align='center'", "", "", "", "", "", "", "", "", "", "", "", ""}
    '    'Dim arrCheckBox() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "chkSelect"}
    '    Dim arrActualColumns() As String = {"EmployeeName", "ExpectedStartDate", "ExpectedEndDate", "ResourcePercentage", ""}
    '    Dim arrUserFriendlyColumn() As String = {"Employee Name", "Start Date", "End Date", "Percentage Allocation", "Select"}
    '    Dim arrTDStyle() As String = {"Align=Center", "Align=Center", "", "", "align='center'"}
    '    Dim arrCheckBox() As String = {"", "", "", "", "chkSelect"}
    '    'End of Commented and Added by ShubhangiD On 11 Aug 2015 : Removing Current City, current CTC, Expected CTC columns

    '    m_strAction = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), ""), String)

    '    'strQuery = "EXEC usp_sel_ResourceDetails_ForReallocation " & m_strPipelineId.ToString
    '    strQuery = "EXEC usp_sel_ResourceDetails_ForReallocation "

    '    With m_objGrid
    '        .UserFriendlyColumnArray = arrUserFriendlyColumn
    '        .ActualColumnArray = arrActualColumns
    '        .TDStyleArray = arrTDStyle
    '        '.PrimaryKey = "CandidateID"
    '        .SQL = strQuery
    '        '.UseSQL = MyBase.UseSQL
    '        .UseSQL = True
    '        .DIVID = "divList"
    '        .DIVHeight = 110
    '        .DIVStyle = "overflow:auto;width:100%;height:505px !important;"
    '        .NoOfDataColumns = 4
    '        .EmptyValueReplacement = "&nbsp;"
    '        .returnHTML = True
    '        m_TotalRecords = .NoOfRows
    '        sbSTRHTML.Append(.DrawGrid())
    '    End With

    '    m_objGrid = Nothing

    'End Sub
    Private Sub DisplayData_Grid(ByRef sbSTRHTML As System.Text.StringBuilder)
        Dim intRowCountTickets As Integer = 0
        Dim strSQL As String
        Dim chkSelect As String
        Dim dsResourceReallocation As DataSet
        Dim strDisabled As String = "disabled"
        Dim blnIsReadOnly As Boolean = True

        Dim strStartDate As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("dtStartDate"), "")
        Dim strEndDate As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("dtEndDate"), "")
        Dim strPerAllocation As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtAllocation"), "")
        Dim IsSelect As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Select"), "")

        '--------------------------------------------------------------------------------
        'Chakshuta

        'Chakshuta
        '-----------------------------------------------------------------------------
        sbSTRHTML.Append("<table id='tbl_Page' CellSpacing=0 CellPadding=0' class=clsTable width=100%>")
        sbSTRHTML.Append("<TR id='tbl_Timesheet' class='clsTRColumnHeader'>")
        'sbSTRHTML.Append("<TD valign=center align=left></td>")
        'sbSTRHTML.Append("<TD valign=center align=left> Ticket </TD>")
        'sbSTRHTML.Append("<TD align=left> Ticket Date </TD>")
        'sbSTRHTML.Append("<TD align=left> Mode Of Travel </TD>")
        ''Added By Chakshuta H on 12th-Aug-2015 Purpose::Add Airlines Dropdown
        'sbSTRHTML.Append("<TD align=left> Airlines </TD>")
        'End Of Addition By Chakshuta H on 12th-Aug-2015 Purpose::Add Airlines Dropdown
        sbSTRHTML.Append("<TD align=left> Employee Name </TD>")
        sbSTRHTML.Append("<TD align=left> Start Date </TD>")
        sbSTRHTML.Append("<TD align=left> End Date </TD>")
        sbSTRHTML.Append("<TD align=left> % Allocation </TD>")
        sbSTRHTML.Append("<TD align=left> Select </TD>")
        sbSTRHTML.Append("</TR>")


        strSQL = "usp_sel_ResourceDetails_ForReallocation " & m_intProjectID.ToString
        dsResourceReallocation = CommonFunction.Data.GetDataSet(strSQL, True)
        If dsResourceReallocation.Tables(0).Rows.Count > 0 Then
            For Each dsResourceReallocation1 As DataRow In dsResourceReallocation.Tables(0).Rows
                intRowCountTickets = intRowCountTickets + 1
                Employeeid = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dsResourceReallocation1("EmployeeID"), ""), "")
                EmployeeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dsResourceReallocation1("EmployeeName"), ""), "")
                ExpectedStartDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dsResourceReallocation1("ExpectedStartDate"), ""), "")
                'ExpectedEndDate = Convert.ToDateTime(CommonFunction.Data.CheckIsDBNull(dsResourceReallocation1("ExpectedEndDate"), ""))
                ExpectedEndDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dsResourceReallocation1("ExpectedEndDate"), ""), "")
                ResourcePercentage = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dsResourceReallocation1("ResourcePercentage"), ""), "")
                'Added By Chakshuta H on 12th-Aug-2015 Purpose::Add Airlines Dropdown                               
                chkSelect = CType(Request.Form("chkSelect" + CStr(intRowCountTickets)), String)
                sbSTRHTML.Append("<tr>")
                'sbSTRHTML.Append("<td  class=clsTREven align=center width='1%'></td>")

                sbSTRHTML.Append("<TD align=left>")
                'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeName" + CStr(intRowCountTickets), "txtEmployeeName" + CStr(intRowCountTickets), , 90, 100, EmployeeName, "right", , True, , , , , True, True))
                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeName" + Employeeid, "txtEmployeeName" + Employeeid, , 90, 100, EmployeeName, "right", , True, , , , , True, True))
                sbSTRHTML.Append("<label  id='lblEmployeeName' class='' align='center' name='lblEmployeeName'  runat='server'>" + EmployeeName + "</label>")
                'CommonFunctions.General.WriteHTML("<label  id='lblEmployeeName' class='' align='center' name='lblEmployeeName'  runat='server'>" + EmployeeName + "</label>")
                sbSTRHTML.Append("</TD>")


                sbSTRHTML.Append("<TD align=left>")
                'Modified(Added form name frmAddTravelDetails) By Bharat Tekade on 29th-May-2015
                'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtStartDate" & CStr(intRowCountTickets) & "", "txtStartDate" + CStr(intRowCountTickets) + "", , 80, ExpectedStartDate, , "frmResourceReallocation", , , , , , , True, True, , , ))
                If (strStartDate <> "") Or (strEndDate <> "") Or (strPerAllocation <> "") Then
                    sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtStartDate" + Employeeid & "", "txtStartDate" + Employeeid + "", , 80, ExpectedStartDate, , "frmResourceReallocation", , , , True, , , True, True, , , ))
                Else
                    'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtStartDate" + Employeeid & "", "txtStartDate" + Employeeid + "", , 80, ExpectedStartDate, , "frmResourceReallocation", , , , , blnIsReadOnly, , True, True, , strDisabled, ))
                    sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtStartDate" + Employeeid & "", "txtStartDate" + Employeeid + "", , 80, ExpectedStartDate, , "frmResourceReallocation", , , , , , , True, True, , , ))
                End If

                'End Of Modifications By Bharat Tekade on 29th-May-2015
                sbSTRHTML.Append("</TD>")

                sbSTRHTML.Append("<TD align=left>")
                'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtEndDate" & CStr(intRowCountTickets) & "", "txtEndDate" + CStr(intRowCountTickets) + "", , 80, ExpectedEndDate, , "frmResourceReallocation", , , , , , , True, True, , , ))
                'If (strStartDate = "" Or strStartDate = Nothing) And (strEndDate = "" Or strEndDate = Nothing) And (strPerAllocation = "" Or strPerAllocation = Nothing) Then
                If (strStartDate <> "") Or (strEndDate <> "") Or (strPerAllocation <> "") Then
                    sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtEndDate" + Employeeid & "", "txtEndDate" + Employeeid + "", , 80, ExpectedEndDate, , "frmResourceReallocation", , , , True, , , True, True, , , ))
                Else
                    'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtEndDate" + Employeeid & "", "txtEndDate" + Employeeid + "", , 80, ExpectedEndDate, , "frmResourceReallocation", , , , , blnIsReadOnly, , True, True, , strDisabled, ))
                    sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtEndDate" + Employeeid & "", "txtEndDate" + Employeeid + "", , 80, ExpectedEndDate, , "frmResourceReallocation", , , , , , , True, True, , , ))
                End If

                sbSTRHTML.Append("</TD>")

                'Added By Chakshuta H on 12th-Aug-2015 Purpose::Add Airlines Dropdown--AirlineID
                sbSTRHTML.Append("<TD align=left>")
                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAllocation" + CStr(intRowCountTickets), "txtAllocation" + CStr(intRowCountTickets), , 90, 100, ResourcePercentage, "right", , , , , , , True, True))
                If (strStartDate <> "") Or (strEndDate <> "") Or (strPerAllocation <> "") Then
                    ''sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAllocation" + Employeeid, "txtAllocation" + Employeeid, , 90, 5, ResourcePercentage, "right", , True, , , , , True, True))
                    sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAllocation" + Employeeid, "txtAllocation" + Employeeid, , 90, 5, ResourcePercentage, "right", , True, , , , , True, True, EnableHTMLEncode:=True))
                Else
                    'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAllocation" + Employeeid, "txtAllocation" + Employeeid, , 90, 100, ResourcePercentage, "right", , True, , , , , True, True))
                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    '' sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAllocation" + Employeeid, "txtAllocation" + Employeeid, , 90, 5, ResourcePercentage, "right", , , , , , , True, True))
                    sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAllocation" + Employeeid, "txtAllocation" + Employeeid, , 90, 5, ResourcePercentage, "right", , , , , , , True, True, EnableHTMLEncode:=True))
                End If


                sbSTRHTML.Append("</TD>")
                'End Of Added By Chakshuta H on 12th-Aug-2015 Purpose::Add Airlines Dropdown


                sbSTRHTML.Append("<TD align=left>")

                If (strStartDate = "" Or strStartDate = Nothing) And (strEndDate = "" Or strEndDate = Nothing) And (strPerAllocation = "" Or strPerAllocation = Nothing) Then
                    'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkSelect" + CStr(intRowCountTickets), "chkSelect" + CStr(intRowCountTickets), , False, "", False, "OnClick=Select_OnClick(this.id);", returnHTML:=True))
                    'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkSelect" + Employeeid, "chkSelect" + Employeeid, , False, Employeeid.ToString, False, "OnClick=Select_OnClick(this.id);", returnHTML:=True))
                    'sbSTRHTML.Append("<Input type=checkbox name='chkSelect' id='chkSelect_" + Employeeid + "' class='clsCheckBox' value=" + Employeeid.ToString + ">")
                    sbSTRHTML.Append("<Input type=checkbox name='chkSelect' id='chkSelect_" + Employeeid + "' class='clsCheckBox' value=" + Employeeid.ToString + " onclick='chkSelect_onclick(this)'>")
                Else
                    'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkSelect" + CStr(intRowCountTickets), "chkSelect" + CStr(intRowCountTickets), , False, "", False, "OnClick=Select_OnClick(this.id);", returnHTML:=True))
                    'sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkSelect" + Employeeid, "chkSelect" + Employeeid, , False, Employeeid.ToString, False, "OnClick=Select_OnClick(this.id);", returnHTML:=True))
                    'sbSTRHTML.Append("<Input type=checkbox name='chkSelect' id='chkSelect_" + Employeeid + "' class='clsCheckBox' value=" + Employeeid.ToString + ">")

                    sbSTRHTML.Append("<Input type=checkbox name='chkSelect' id='chkSelect_" + Employeeid + "' class='clsCheckBox' value=" + Employeeid.ToString + " onclick='chkSelect_onclick(this)'>")
                End If
                sbSTRHTML.Append("</TD>")



                'sbSTRHTML.Append("</TD>")
                'sbSTRHTML.Append("</tr>")
                '---------------MultiAttachment Feature---------------------


                'sbSTRHTML.Append("</TD>")
                sbSTRHTML.Append("</tr>")

                '------------------------------------

            Next
        End If
        sbSTRHTML.Append("</TABLE>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        '' sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , intRowCountTickets.ToString, , , , , , True, , True))
        sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , intRowCountTickets.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        '-----------------------------------------------------------------------------------
        ''sbSTRHTML.Append("<Table id=tblStaffGrid CellSpacing=0 CellPadding=0' class=clsTable border=1 width=80%>")

        ''sbSTRHTML.Append("<THEAD class=clsTRColumnHeader>")
        ''sbSTRHTML.Append("<TH align=left width=20%>Employee Name</TH>")
        ''sbSTRHTML.Append("<TH align=left width=20%>Start Date</TH>")
        ''sbSTRHTML.Append("<TH align=left width=20%>End Date</TH>")
        ''sbSTRHTML.Append("<TH align=left width=20%>Percent Allocation</TH>")
        ''sbSTRHTML.Append("<TH align=left width=20%>Select</TH>")
        ''sbSTRHTML.Append("</THEAD>")

        ''sbSTRHTML.Append("<TBODY>")
        ' ''EmployeeName, ExpectedStartDate, ExpectedEndDate, ResourcePercentage
        ''sbSTRHTML.Append("<TR class='clsTREven'>")
        ''sbSTRHTML.Append("<TD valign='Top' align='Left'> EmployeeName </TD>")
        ''sbSTRHTML.Append("<TD valign='Top' align='Left'> " & EmployeeName & " </TD>")
        ''sbSTRHTML.Append("</TR>")

        ''sbSTRHTML.Append("<TR class='clsTREven'>")
        ''sbSTRHTML.Append("<TD valign='Top' align='Left'> ExpectedStartDate </TD>")
        ' ''sbSTRHTML.Append("<TD valign='Top' align='Left'> " & ExpectedStartDate & " </TD>")
        ''sbSTRHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtStartDate" & CStr(intRowCountTickets) & "", "txtStartDate" + CStr(intRowCountTickets) + "", , 80, ExpectedStartDate, , "frmAddTravelDetails", , , , True, , , True, True, , , ))
        ''sbSTRHTML.Append("</TR>")

        ''sbSTRHTML.Append("<TR class='clsTREven'>")
        ''sbSTRHTML.Append("<TD valign='Top' align='Left'> ExpectedEndDate </TD>")
        ''sbSTRHTML.Append("<TD valign='Top' align='Left'> " & ExpectedEndDate & " </TD>")
        ''sbSTRHTML.Append("</TR>")

        ''sbSTRHTML.Append("<TR class='clsTREven'>")
        ''sbSTRHTML.Append("<TD valign='Top' align='Left'> ResourcePercentage </TD>")
        ''sbSTRHTML.Append("<TD valign='Top' align='Left'> " & ResourcePercentage & " </TD>")
        ''sbSTRHTML.Append("</TR>")

        'sbSTRHTML.Append("<TR class='clsTREven'>")
        'sbSTRHTML.Append("<TD valign='Top' align='Left'> Lost-Unable To Fulfill </TD>")
        'sbSTRHTML.Append("<TD valign='Top' align='Left'> " & intLostUnableToFulfill & " </TD>")
        'sbSTRHTML.Append("</TR>")

        'sbSTRHTML.Append("<TR class='clsTREven'>")
        'sbSTRHTML.Append("<TD valign='Top' align='Left'> No Bid </TD>")
        'sbSTRHTML.Append("<TD valign='Top' align='Left'> " & intNoBid & " </TD>")
        'sbSTRHTML.Append("</TR>")

        'sbSTRHTML.Append("<TR class='clsTREven'>")
        'sbSTRHTML.Append("<TD valign='Top' align='Left'> WIP </TD>")
        'sbSTRHTML.Append("<TD valign='Top' align='Left'> " & WIP & " </TD>")
        'sbSTRHTML.Append("</TR>")

        'sbSTRHTML.Append("<TR class='clsTREven'>")
        'sbSTRHTML.Append("<TD valign='Top' align='Left'> Open Or Closed </TD>")
        'sbSTRHTML.Append("<TD valign='Top' align='Left'> " & Status & " </TD>")
        'sbSTRHTML.Append("</TR>")

        ''sbSTRHTML.Append("</TBODY>")
        ''sbSTRHTML.Append("</table><BR>")

    End Sub
    Protected Sub UpdateStatusSection(ByRef sbSTRHTML As System.Text.StringBuilder)
        'sbSTRHTML.Append("<TABLE align=center class=clsTable cellSpacing=0 cellPadding=0 width=99.9% border=0><TBODY>")
        'sbSTRHTML.Append("<TR class=clsTRMenu>")
        'sbSTRHTML.Append("<TD align=right>")
        'sbSTRHTML.Append("<A href=Javascript:Save_OnClick()  id=SAVEUI_HEAD title='Save' class=Menu style='TEXT-DECORATION: none'>| Save |</A>")

        'sbSTRHTML.Append("</TD></TR></TBODY></TABLE>")


        'sbSTRHTML.Append("<TABLE id=tblCap00 class=clsTable cellSpacing=0 cellPadding=1 width=99.9%><TBODY>")
        'sbSTRHTML.Append("<TR class=clsTRPageCaption>")
        'sbSTRHTML.Append("<TD align=left>Update Status</TD></TR></TBODY></TABLE>")
        'Dim strStartDate As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("dtStartDate"), "")
        'Dim strEndDate As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("dtEndDate"), "")
        'Dim strPerAllocation As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtPercAllocation"), "")

        sbSTRHTML.Append("<TABLE class=clsTable align=center cellSpacing=5 cellPadding=0 >")

        sbSTRHTML.Append("<TR class=clsTREven>")
        sbSTRHTML.Append("<TD>Start Date</TD>")
        sbSTRHTML.Append("<TD>")
        'Modified(removed mandatory) By Bharat T on 12th-July-2017 for NextBase Resource Reallocation Changes
        sbSTRHTML.Append(CommonFunction.HTMLControls.DrawDateControl("dtStartDate", "dtStartDate", , , strStartDate, , "frmResourceReallocation", , , , , , , returnHTML:=True, IsMandatory:=False, ToBeInserted:="onblur=""javascript:Date_OnClick('dtStartDate',this)"""))


        'sbSTRHTML.Append(CommonFunction.HTMLControls.DrawDateControl("dtStartDate", "dtStartDate", , , strStartDate, "Date_OnClick", "frmResourceReallocation", , , , , , , returnHTML:=True, IsMandatory:=True))
        'sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtLTCompetition", "txtLTCompetition", , 90, , , , , , , , , "OnBlur=javascript:Controls_OnBlur(this); ", True))
        sbSTRHTML.Append("<TD>")
        'sbSTRHTML.Append("</TR>")

        'sbSTRHTML.Append("<TR class=clsTREven>")
        sbSTRHTML.Append("<TD>End Date</TD>")
        sbSTRHTML.Append("<TD>")
        'sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtLWashByClient", "txtLWashByClient", , 90, , , , , , , , , "OnBlur=javascript:Controls_OnBlur(this);", True))
        'sbSTRHTML.Append(CommonFunction.HTMLControls.DrawDateControl("dtEndDate", "dtEndDate", , , strEndDate, , "frmResourceReallocation", , , , , , , True, True))
        sbSTRHTML.Append(CommonFunction.HTMLControls.DrawDateControl("dtEndDate", "dtEndDate", , , strEndDate, , "frmResourceReallocation", , , , , , , returnHTML:=True, IsMandatory:=False, ToBeInserted:="onblur=""javascript:Date_OnClick('dtEndDate',this)"""))
        sbSTRHTML.Append("<TD>")
        'sbSTRHTML.Append("</TR>")

        'sbSTRHTML.Append("<TR class=clsTREven>")
        sbSTRHTML.Append("<TD>% Allocation</TD>")
        sbSTRHTML.Append("<TD>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPercAllocation", "txtPercAllocation", , 90, 5, , "right", , , , , , "onblur=Date_OnClick('txtPercAllocation',1)", True, True))
        sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPercAllocation", "txtPercAllocation", , 90, 5, , "right", , , , , , "onblur=Date_OnClick('txtPercAllocation',1)", True, False, EnableHTMLEncode:=True))
        'End of Modified By Bharat T on 12th-July-2017 for NextBase Resource Reallocation Changes

        sbSTRHTML.Append("<TD>")
        sbSTRHTML.Append("</TR>")


        sbSTRHTML.Append("</TABLE>")
    End Sub
    Private Sub CheckedData()
        Dim intRowCount As Integer = 0
        Dim strRecruiterID As String = ""
        Dim strRecruiterIDValues As String = ""

        Dim strSQL As String
        Dim dr As IDataReader
        Dim newStageID As Integer
        Dim newStatusID As Integer
        intRowCount = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtHidRC"), 0)
        Dim strSQLQuery As New System.Text.StringBuilder
        Dim strEmployeeID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelect"), "")
        Dim IsSelect As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Select"), "")

        If strEmployeeID <> "" Then
            Dim strArray() As String = strEmployeeID.Split(",")
            For intRowCount = 0 To strArray.Length - 1               
                ''Ani
                Dim CurrEmployeeID As String = strArray(intRowCount)
                strSQLQuery = New StringBuilder()
                strSQLQuery.Append("Exec usp_Upd_tbl_PM_ProjectEmployeeRole_Selectbit ")
                strSQLQuery.Append(CurrEmployeeID)
                If (IsSelect = "" Or IsSelect = Nothing) Then
                    strSQLQuery.Append("," & "0")
                Else
                    strSQLQuery.Append(",'" & IsSelect & "'")
                End If
            
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)

                'strStartDate = Nothing
                'strEndDate = Nothing
                'strPerAllocation = Nothing
                CurrEmployeeID = Nothing
            Next
        End If

    End Sub
    Private Sub SaveData()
        Dim intRowCount As Integer = 0
        Dim strRecruiterID As String = ""
        Dim strRecruiterIDValues As String = ""

        Dim strSQL As String
        Dim dr As IDataReader
        Dim newStageID As Integer
        Dim newStatusID As Integer
        intRowCount = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtHidRC"), 0)
        Dim strSQLQuery As New System.Text.StringBuilder
        Dim strEmployeeID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelect"), "")
        Dim strStartDate As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("dtStartDate"), "")
        Dim strEndDate As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("dtEndDate"), "")
        Dim strStartDate1 As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("FFE29587WHIZ_dtStartDate"), "")
        Dim strEndDate1 As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("FFE29587WHIZ_dtEndDate"), "")
        Dim strPerAllocation As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtPercAllocation"), "")


        If (strStartDate = "" Or strStartDate = Nothing) And (strEndDate = "" Or strEndDate = Nothing) And (strPerAllocation = "" Or strPerAllocation = Nothing) Then
            If strEmployeeID <> "" Then
                Dim strArray() As String = strEmployeeID.Split(",")
                For intRowCount = 0 To strArray.Length - 1
                    'strRecruiterID = HttpContext.Current.Request.Form("cboRecruiterID" & strArray(intRowCount))
                    Dim StartDate As String = HttpContext.Current.Request.Form("txtStartDate" & strArray(intRowCount))
                    Dim EndDate As String = HttpContext.Current.Request.Form("txtEndDate" & strArray(intRowCount))
                    Dim StartDate1 As String = HttpContext.Current.Request.Form("FFE29587WHIZ_txtStartDate" & strArray(intRowCount))
                    Dim EndDate1 As String = HttpContext.Current.Request.Form("FFE29587WHIZ_txtEndDate" & strArray(intRowCount))
                    Dim PerAllocation As String = HttpContext.Current.Request.Form("txtAllocation" & strArray(intRowCount))

                    ''Ani
                    ''If (StageID = "" Or StageID = Nothing) Then
                    ''    StageID = newStageID
                    ''End If
                    ''If (StatusID = "" Or StatusID = Nothing) Then
                    ''    StatusID = newStatusID
                    ''End If
                    ''Ani
                    Dim CurrEmployeeID As String = strArray(intRowCount)
                    strSQLQuery = New StringBuilder()
                    strSQLQuery.Append("Exec usp_Upd_tbl_PM_ProjectEmployeeRole_AfterReallocation ")
                    strSQLQuery.Append(CurrEmployeeID)
                    If (StartDate1 = "" Or StartDate1 = Nothing) Then
                        strSQLQuery.Append("," & "NULL")
                    Else
                        strSQLQuery.Append(",'" & StartDate1 & "'")
                    End If
                    If (EndDate1 = "" Or EndDate1 = Nothing) Then
                        strSQLQuery.Append("," & "NULL")
                    Else
                        strSQLQuery.Append(",'" & EndDate1 & "'")
                    End If
                    If (PerAllocation = "" Or PerAllocation = Nothing) Then
                        strSQLQuery.Append("," & "NULL")
                    Else
                        strSQLQuery.Append("," & PerAllocation)
                    End If                   
                        strSQLQuery.Append("," & m_intProjectID)


                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)

                    strStartDate = Nothing
                    strEndDate = Nothing
                    strPerAllocation = Nothing
                    CurrEmployeeID = Nothing
                Next
            End If
        Else
            ''Ani
            If strEmployeeID <> "" Then
                Dim strArray() As String = strEmployeeID.Split(",")
                For intRowCount = 0 To strArray.Length - 1
                    'strRecruiterID = HttpContext.Current.Request.Form("cboRecruiterID" & strArray(intRowCount))
                    'Dim StageID As String = HttpContext.Current.Request.Form("cboStageID" & strArray(intRowCount))
                    'Dim StatusID As String = HttpContext.Current.Request.Form("cboStatusID" & strArray(intRowCount))

                    ''Ani
                    ''If (StageID = "" Or StageID = Nothing) Then
                    ''    StageID = newStageID
                    ''End If
                    ''If (StatusID = "" Or StatusID = Nothing) Then
                    ''    StatusID = newStatusID
                    ''End If
                    ''Ani
                    Dim CurrEmployeeID As String = strArray(intRowCount)
                    strSQLQuery = New StringBuilder()
                    strSQLQuery.Append("Exec usp_Upd_tbl_PM_ProjectEmployeeRole_AfterReallocation ")
                    strSQLQuery.Append(CurrEmployeeID)
                    If (strStartDate1 = "" Or strStartDate1 = Nothing) Then
                        strSQLQuery.Append("," & "NULL")
                    Else
                        strSQLQuery.Append(",'" & strStartDate1 & "'")
                    End If
                    If (strEndDate1 = "" Or strEndDate1 = Nothing) Then
                        strSQLQuery.Append("," & "NULL")
                    Else
                        strSQLQuery.Append(",'" & strEndDate1 & "'")
                    End If
                    If (strPerAllocation = "" Or strPerAllocation = Nothing) Then
                        strSQLQuery.Append("," & "NULL")
                    Else
                        strSQLQuery.Append("," & strPerAllocation)
                    End If
                    strSQLQuery.Append("," & m_intProjectID)

                    'm_intProjectID

                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)

                    'strStartDate = Nothing
                    'strEndDate = Nothing
                    'strPerAllocation = Nothing
                    CurrEmployeeID = Nothing
                Next
            End If
        End If
        'Code Added By Chakshuta H on 25th-Apr-2015 To Refresh Parent Parent Page
        Response.Write("<script language= javascript> " + vbCrLf)
        CommonFunctions.General.WriteHTML("window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?MasterTagID=1019&FromWhere=PM';" + vbCrLf)
        CommonFunctions.General.WriteHTML("window.opener.document.forms['frmCommonList'].submit();" + vbCrLf)
        'CommonFunctions.General.WriteHTML("window.close(); " + vbCrLf)
        Response.Write("</script>")
        'Ended By Chakshuta H 
        'For intRowCount = 0 To strPipelineIDValues.Length

        '    strRecruiterIDValues = HttpContext.Current.Request.Form("cboRecruiterID " & intRowCount)

        '    strSQLQuery = New StringBuilder()
        '    strSQLQuery.Append("Exec usp_upd_tbl_RM_Pipeline_ForAssignment ")
        '    strSQLQuery.Append(strPipelineIDValues)
        '    strSQLQuery.Append("," & strRecruiterIDValues)

        '    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
        'Next
    End Sub

    ' End of Added By Bharat T on 12th-July-2017 for NextBase Resource Reallocation Changes
    'Private Sub SaveData()

    '    Dim intRowCount As Integer = 0
    '    Dim strRecruiterID As String = ""
    '    Dim strRecruiterIDValues As String = ""
    '    Dim LostToCompetion As String
    '    Dim LostWashByClient As String
    '    Dim LostUnableToFulfill As String
    '    Dim NoBid As String
    '    Dim OtherStatus1 As String
    '    Dim OtherStatus2 As String

    '    Dim strIsTAOrHiringManager As String

    '    LostToCompetion = CommonFunction.General.CheckIsNothing(Request.Form("txtLTCompetition"))
    '    LostWashByClient = CommonFunction.General.CheckIsNothing(Request.Form("txtLWashByClient"))
    '    LostUnableToFulfill = CommonFunction.General.CheckIsNothing(Request.Form("txtLUnableToFulfill"))
    '    NoBid = CommonFunction.General.CheckIsNothing(Request.Form("txtNoBid"))
    '    OtherStatus1 = CommonFunction.General.CheckIsNothing(Request.Form("txtOStatus1"))
    '    OtherStatus2 = CommonFunction.General.CheckIsNothing(Request.Form("txtOStatus2"))

    '    If LostToCompetion = "" Then
    '        LostToCompetion = "NULL"
    '    End If
    '    If LostWashByClient = "" Then
    '        LostWashByClient = "NULL"
    '    End If
    '    If LostUnableToFulfill = "" Then
    '        LostUnableToFulfill = "NULL"
    '    End If
    '    If NoBid = "" Then
    '        NoBid = "NULL"
    '    End If
    '    If OtherStatus1 = "" Then
    '        OtherStatus1 = "NULL"
    '    End If
    '    If OtherStatus2 = "" Then
    '        OtherStatus2 = "NULL"
    '    End If

    '    Dim strSQLQuery As String
    '    ''Commented and Modified By Aniruddh Gujar on 28-Mar-2016 Purpose::EASi Demand UAT Issue fixing
    '    ''strIsTAOrHiringManager = CommonFunctions.Data.GetDataScalar("Usp_Check_IsTAOrHiringManager " & m_lngEmployeeID, MyBase.UseSQL)
    '    strIsTAOrHiringManager = CommonFunctions.Data.GetDataScalar("Usp_Check_IsTAOrHiringManager " & m_lngEmployeeID & "," & m_strPipelineId, MyBase.UseSQL)
    '    ''End of Commented and Modified By Aniruddh Gujar on 28-Mar-2016 Purpose::EASi Demand UAT Issue fixing

    '    If strIsTAOrHiringManager = "1" Or Session("intUserID") = "61" Then
    '        If m_strPipelineId <> "" And m_strOpportunityId <> "" Then
    '            strSQLQuery = "Usp_Upd_tbl_RM_StatusDashboard " & m_strOpportunityId & "," & m_strPipelineId & "," & LostToCompetion & "," & LostWashByClient & "," & LostUnableToFulfill & "," & NoBid & "," & OtherStatus1 & "," & OtherStatus2
    '            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
    '        End If
    '    Else
    '        'ClientScript.RegisterClientScriptBlock(Me.GetType, "WINDOW", "alert('Only HM or TA Manager can update the status!'); return;", True)
    '        CommonFunctions.General.WriteHTML("<script type=text/javascript language=javascript>")
    '        Response.Write("alert('Only Hiring Manager or TA Manager can update the status!'); return;")
    '        CommonFunctions.General.WriteHTML("</script>")
    '    End If

    '    'ClientScript.RegisterClientScriptBlock(Me.GetType, "WINDOW", "window.opener.location.href=window.opener.location.href; window.close();", True)
    '    CommonFunctions.General.WriteHTML("<script type=text/javascript language=javascript>")
    '    Response.Write("window.opener.location.href=window.opener.location.href; window.close();")
    '    CommonFunctions.General.WriteHTML("</script>")

    'End Sub


    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

#Region " General Events Definition"

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objGrid_DataRowTD_BeforePrint
        ' Purpose               : To modify the Grid For Recruiter Assignment
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        'Dim strUniqueID As String
        'Dim strTxtName As String
        'Dim intUniqueID As Integer
        'Dim blnIsChecked As Boolean = False
        Dim strResourcePercentage As String
        Dim strEmployeeID As String
        Dim strGridStartDate, strGridEndDate As String
        strResourcePercentage = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ResourcePercentage"), "0"), Integer)
        strEmployeeID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), "0"), Integer)
        strGridStartDate = CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpectedStartDate"), "")
        strGridEndDate = CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpectedEndDate"), "")
        'strUniqueID = CType(intUniqueID, String)
        'strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String)
        'strEmployeeName = strEmployeeName.Replace("'", "").Trim()

        Dim strTemplateQry As String = ""
        strTemplateQry = "Exec usp_Sel_cbo_TBL_RM_Opportunity"

        'If Args.ColumnName.ToUpper = "RESUME" Then
        '    Dim ResumeName As String
        '    Dim SysFileName As String

        '    Dim strTempQryR = "usp_sel_tbl_RM_CandidateResumes " & Args.DataReader("CandidateID")
        '    Dim dr As IDataReader = CommonFunction.Data.GetDataReader(strTempQryR, True)
        '    While dr.Read()
        '        ResumeName = dr("FileName")
        '        SysFileName = dr("SystemFileName")
        '    End While


        '    Cancel = True
        '    Args.StringToBeInserted = "<TD align='center'> "
        '    Args.StringToBeInserted &= "<A href=""JavaScript:Resume_OnClick(" & Args.DataReader("CandidateID") & ",'" & SysFileName & "','" & ResumeName & "')"">" & ResumeName & "</a>"
        '    Args.StringToBeInserted &= "</TD>"
        'End If
        If Args.ColumnName.ToUpper = "START DATE" Then
            Cancel = True

            Args.StringToBeInserted = "<TD align='center'> "
            'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawDateControl("dtStartDate", "dtStartDate", , , strStartDate, , "frmResourceReallocation", , , , , True, , , True, , , True)
            'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txtStartDate_" + Args.DataReader.Item("EmployeeID").ToString, "txtStartDate_" + Args.DataReader.Item("EmployeeID").ToString, , , , CommonFunction.Dates.GetDate(CType(Args.DataReader.Item("ExpectedStartDate").ToString, Date)), , returnHTML:=True)

            'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawDateControl("txtStartDate_" + Args.DataReader.Item("EmployeeID").ToString, "txtStartDate_" + Args.DataReader.Item("EmployeeID").ToString, , , CommonFunction.Data.CheckIsDBNull(CommonFunction.Dates.GetDate(CType(Args.DataReader.Item("ExpectedStartDate").ToString, Date)), ""), , "frmResourceReallocation", returnHTML:=True)
            'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawDateControl("txtStartDate_" + Args.DataReader.Item("EmployeeID").ToString, "txtStartDate_" + Args.DataReader.Item("EmployeeID").ToString, , , strGridStartDate, , "frmResourceReallocation", returnHTML:=True)
            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawDateControl("txtStartDate_" + Args.DataReader.Item("EmployeeID").ToString, "txtStartDate_" + Args.DataReader.Item("EmployeeID").ToString, , , strGridStartDate, , "frmResourceReallocation", returnHTML:=True)

            'Args.StringToBeInserted = "<td Title = 'Column Name : Baseline Start Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtStartDate" + strEmployeeID, "txtStartDate" + strEmployeeID, , 70, strGridStartDate, , "frmResourceReallocation", , "StartDate", , , , , True, True, , , ) + "</td>"

            'Args.StringToBeInserted &= CommonFunction.HTMLControls.DrawDateControl("dtStartDate", "dtStartDate", , , strStartDate, , "frmResourceReallocation", , , , , , , True, True)
            Args.StringToBeInserted &= "</TD>"

        End If
        If Args.ColumnName.ToUpper = "END DATE" Then
            Cancel = True

            Args.StringToBeInserted = "<TD align='center'> "
            'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawDateControl("dtEndDate", "dtEndDate", , , strEndDate, , "frmResourceReallocation", , , , , True, , , True, , , True)
            'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txtEndDate_" + Args.DataReader.Item("EmployeeID").ToString, "txtEndDate_" + Args.DataReader.Item("EmployeeID").ToString, , , , CommonFunction.Dates.GetDate(CType(Args.DataReader.Item("ExpectedEndDate").ToString, Date)), , returnHTML:=True)
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            '' Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawDateControl("txtEndDate_" + Args.DataReader.Item("EmployeeID").ToString, "txtEndDate_" + Args.DataReader.Item("EmployeeID").ToString, , , strGridEndDate, , "frmResourceReallocation", returnHTML:=True)
            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawDateControl("txtEndDate_" + Args.DataReader.Item("EmployeeID").ToString, "txtEndDate_" + Args.DataReader.Item("EmployeeID").ToString, , , strGridEndDate, , "frmResourceReallocation", returnHTML:=True)
            Args.StringToBeInserted &= "</TD>"

        End If
        If Args.ColumnName.ToUpper = "PERCENTAGE ALLOCATION" Then
            Cancel = True

            Args.StringToBeInserted = "<TD align='center'> "
            'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawComboBox("cboCopyToStaffingPlan" + strCandidateID, strTemplateQry1, 150, , , True, True)
            'Args.StringToBeInserted &= CommonFunction.HTMLControls.DrawTextBox("txtAllocation", "txtAllocation", , 90, , , , , , , , , , True)
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txtPerAllocation_" + Args.DataReader.Item("EmployeeID").ToString, "txtPerAllocation_" + Args.DataReader.Item("EmployeeID").ToString, , 50, , strResourcePercentage, , , returnHTML:=True)
            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txtPerAllocation_" + Args.DataReader.Item("EmployeeID").ToString, "txtPerAllocation_" + Args.DataReader.Item("EmployeeID").ToString, , 50, , strResourcePercentage, , , returnHTML:=True, EnableHTMLEncode:=True)
            Args.StringToBeInserted &= "</TD>"
        End If
        '"Start Date", "End Date", "Percentage Allocation",
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            ''Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkSelect_OnClick(""intUniqueID"",1) ", True)
            Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelect' id='chkSelect_" + Args.DataReader("EmployeeID").ToString + "' class='clsCheckBox' value=" + Args.DataReader("EmployeeID").ToString + "></td>"
            Args.StringToBeInserted &= "</TD>"
        End If
        If Args.ColumnName.ToUpper = "CURRENT COMPANY" Then
            Args.TDStyle = "nowrap=false width='20%'"
            'Args.ApplyNoWrap = False
        End If
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

        'Added by PrashantD on 8 March 2007 for IssueID 11109
        If Request.QueryString("ReportID") = 20045 Then
            If Args.LinkName.ToUpper = "ADD TO DASHBOARD" Then
                Cancel = True
            End If
        End If
        'End of addition by PrashantD on 8 March 2007


    End Sub
#End Region
End Class



