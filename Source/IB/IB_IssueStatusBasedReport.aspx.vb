'=====================================================================
'                       CSPL Code Header                              
' Project Name          :   WhizibleE
' Module Name           :   IBIssueStatusBasedReport.aspx
' Purpose               :   To draw the Status Based Report
' Description           : 
' Dependencies          :   None
' Author                :   VivekP
' Reviewed              :  
' Tested                :  
' Created               :   13 Apr 2005
' Revisions             :
'=====================================================================

#Region "Imports"
Option Strict Off
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class IB_IssueStatusBasedReport
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
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected WithEvents frmIBIssueStatusBasedReport As System.Web.UI.HtmlControls.HtmlForm
    Protected WithEvents tblGraphs As System.Web.UI.HtmlControls.HtmlTable 'table to insert graph
    Dim Row As New System.Web.UI.HtmlControls.HtmlTableRow 'row to insert the graph
    Dim cell As New System.Web.UI.HtmlControls.HtmlTableCell 'cell  to insert the graph
    Protected m_lngTagId As Long = 0
    Public intProjectID As Integer 'Session ProjectID
    Dim strSQL As String 'to store the SQL query
    Dim strSelectedStatus As String 'For Corporate Staus
    Dim rsDataReader As IDataReader 'DataReader For Total number of issues
    Dim rsIssues As IDataReader 'DataReader For Issues selected
    Dim strStatus As String 'To store the value of system status
    Dim strDivName As String
    Dim strClass As String 'To store the value of store
    Protected WithEvents divGraphs As System.Web.UI.HtmlControls.HtmlGenericControl
    Dim intRow As Integer 'To store the value of rows number
    Dim objMenu As New WebPages.Template.StaticMenu 'To draw the static menu for close and help link
    Dim objMenuIssue As New WebPages.Template.StaticMenu
    Public index As String 'To maintain the state of combobox
    Dim intCheckNull As Integer = 0  'if issues are present then it will be 1 and graph will be displayed
    Dim intCheckNull1 As Integer = 0 'if issues are present then it will be 1 and graph will be displayed
    Dim strConnectionString As String = "" 'ConnectionString used during creating the graph
    Dim strGraphSQL As String 'To store the SQL Query for the graph
    Public strStatusChange As String
    Private WithEvents objgrid As New WebPages.Template.GenericGrid
    Private WithEvents objOpenRequest As New WebPage.Templates.GenericGrid
    Private WithEvents objThreadGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objResolvedRequest As New WebPage.Templates.GenericGrid
    Protected m_PKToken_Query_DT As String
    Protected m_CustomerName As String
    Protected m_lngEmployeeID As String
    Protected customerid As String
    Protected QueryID As String
    Protected m_strToken As String

    ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
    Protected m_Flag As String
    ''End of Addition by Dhanashri S on 11 Aug 2016
#End Region

#Region "Functions and Sub-Procedures"

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw the Status Based Report on the page
        ' Description           :   This is main procedure on this page which actually draw the page with total 
        '                           number of issues. 
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   VivekP
        ' Created               :   13 Apr 2005  
        ' Revisions             :   
        '=====================================================================
        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim strQuery As String
        Dim strGrid As String
        Dim statusofstatus As String
        'Added by TruptiK on 30-Aug-2008
        Dim Mode As String
        Dim Detail As String
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:07/10/15
        Mode = CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "")
        customerid = CommonFunction.General.CheckIsNothing(Request.QueryString("CustomerID"), "")
        Detail = CommonFunction.General.CheckIsNothing(Request.QueryString("Detail"), "")

        QueryID = CommonFunction.General.CheckIsNothing(Request.QueryString("QueryID"), "")
        'End of addition by TruptiK
        Call GetGlobalObject()

        'To select Project ID
        'intProjectID = Session("intProjectID")
        'Response.Write("projectID" + Session("intProjectID"))
        'To select the corporate status
        intProjectID = Request.QueryString("ProjectID")
        strSelectedStatus = "Null"
        'If Request.Form("cboStatus") <> "" Then
        '    strSelectedStatus = Request.Form("cboStatus")
        'Else
        '    strSelectedStatus = "Null"
        'End If

        Dim m_OrderBy As String
        Dim m_Order As String
        If Not Request.QueryString("OrderBy") Is Nothing Then
            m_OrderBy = Request.QueryString("OrderBy")
        Else
            m_OrderBy = "IssueId"
        End If

        If Not Request.QueryString("ASCDESC") Is Nothing Then
            m_Order = Request.QueryString("ASCDESC")
        Else
            m_Order = "Desc"
        End If

        If Request.QueryString("ComboVal") <> "" Then
            index = Request.QueryString("ComboVal")
            strSelectedStatus = Request.QueryString("ComboVal")
        Else
            index = ""
            strSelectedStatus = "NULL"
        End If


        'To draw the close and help link
        'TruptiK

        Dim arrMenu() As String = {"Close", "?"}
        'Modified By VidyaJ - For IssueID - 492 - SP4 
        Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick('STATUSBASEDREPORT')"}
        Dim arrMenuToolTip() As String = {"Close", "Help"}

        'End By TrupitK
        'To draw the back link on issue list page
        Dim arrMenuIssue() As String = {"Back"}
        Dim arrClientSideFunctionsIssue() As String = {"Back_OnClick()"}
        Dim arrMenuToolTipIssue() As String = {"Back"}

        Dim arrMenuIssue1() As String = {"Back"}
        Dim arrClientSideFunctionsIssue1() As String = {"Back1_OnClick()"}
        Dim arrMenuToolTipIssue1() As String = {"Back"}
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'statusofstatus = CommonFunctions.Data.GetDataScalar("SELECT SS.StatusOfStatus From tbl_IB_Status S inner join tbl_IB_Status_for_Status SS ON  S.StatusOfStatusID=SS.StatusOfStatusID Where Status='" + Request.QueryString("Status") + "'", MyBase.UseSQL)
        statusofstatus = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_IB_Status_StatusOfStatus '" + Request.QueryString("Status") + "'", MyBase.UseSQL)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        'strSQL = "usp_GetIssueReport " & intProjectID & ", '" & strSelectedStatus & "','" & Session("LoginType") & "'"
        'rsDataReader = CommonFunction.Data.GetDataReader(strSQL, True)

        'Code To display Issue List
        If Mode <> "Dashboard" Then
            If Request.QueryString("StatusVal") = "true" Then
                'Added by TruptiK

                strSQL = "usp_GetIssueReport " & intProjectID & ", '" & strSelectedStatus & "','" & Session("LoginType") & "'"
                rsDataReader = CommonFunction.Data.GetDataReader(strSQL, True)
                Response.Write(objMenuIssue.DrawMenu(arrMenuIssue, arrClientSideFunctionsIssue, arrMenuToolTipIssue, True))
                Response.Write("<BR>")
                'Modified by HarshK for sp4 issueid 617
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><tr><td class='clsTDHeader' align='left'><b>System Issue Status Report</b></td></tr></table>")
                'End Modified by HarshK for sp4 issueid 617
                'To Get the isssues table
                Response.Write("<BR>")
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><tr><td class='clsTDHeader' align='left'><font size='2'>Status&nbsp;:-&nbsp;" + Request.QueryString("Status") + "</font></td>")
                'If index <> "" Then
                Response.Write("<td align='right' class='clsTDHeader'><font size='2'>Corporate Status&nbsp;:-&nbsp;" + statusofstatus + "</font></td>")
                'End If
                Response.Write("</tr></table>")
                Response.Write("<BR>")
                Dim arrActualColumnArray() As String = {"IssueID", _
                                                    "Summary", _
                                                    "Type", _
                                                    "SubType", "Severity", "ReportedDate", "ReportedBy"}

                Dim arrUserFriendlyArray() As String = {"IssueID", _
                                                    "Summary", _
                                                    "Type", _
                                                    "SubType", "Severity", "ReportedDate", "ReportedBy"}


                strStatusChange = Request.QueryString("Status")
                strQuery = "Exec usp_GetIssueReportChanged " & intProjectID & ", '" & strSelectedStatus & "','" & Session("LoginType") & "','" & Request.QueryString("Status") & "','" & m_OrderBy & "','" & m_Order & "'"
                With objgrid
                    .PrimaryKey = "IssueID"
                    .ActualColumnArray = arrActualColumnArray
                    .UserFriendlyColumnArray = arrUserFriendlyArray
                    .returnHTML = True
                    .UseSQL = MyBase.UseSQL
                    .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                    .SQL = strQuery
                    .NoOfDataColumns = 7
                    .EmptyValueReplacement = " "
                    .VerticalDisplay = False
                    .DIVHeight = 280
                    .ColNameToolTipOnEachRow = True
                    .DIVStyle = "Overflow:auto;width=100%"
                    .ClientSideSortFunctionName = "Sort_OnClick"
                    .SortBy = m_OrderBy
                    .SortOrder = m_Order

                End With


                strGrid = objgrid.DrawGrid()
                objgrid = Nothing
                CommonFunction.Data.DisposeDataReader(rsDataReader)
                Response.Write(strGrid)
                Response.Write(objMenuIssue.DrawMenu(arrMenuIssue, arrClientSideFunctionsIssue, arrMenuToolTipIssue, True))
            End If
            'Added by TruptiK
        End If
        'End
        'Response.Write("<table><tr><td>")
        'strSQL = "usp_GetIssueReport " & intProjectID & ", '" & strSelectedStatus & "','" & Session("LoginType") & "'"
        'rsDataReader = CommonFunction.Data.GetDataReader(strSQL, True)

        'Code To display Total Number Of Issues and Issue Based Graph
        If Mode <> "Dashboard" Then
            If Request.QueryString("StatusVal") <> "true" Then
                strSQL = "usp_GetIssueReport " & intProjectID & ", '" & strSelectedStatus & "','" & Session("LoginType") & "'"
                rsDataReader = CommonFunction.Data.GetDataReader(strSQL, True)
                Response.Write(objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True))
                Response.Write("<BR>")
                'Modified by HarshK for sp4 issueid 617
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><tr><td class='clsTDHeader' align='left'><b>System Issue Status Report</b></td></tr></table>")
                'End Modified by HarshK for sp4 issueid 617
                Response.Write("<BR>")
                'TO draw the status ComboBox
                'Response.Write("<PRE>                    <font size='2' face='Arial'><b>Select System Status </b></font>")
                'Modified by HarshK for sp4 issueid 617
                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><tr class='clsTREven'><td  align='center'>")
                Response.Write("<center><font size='2' face='Arial'>Corporate Status</font>&nbsp;")
                'End Modified by HarshK for sp4 issueid 617
                'If Request.QueryString("ComboVal") <> "" Then
                If index <> "" Then
                    'index = Request.QueryString("ComboVal")
                    'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    'Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "SELECT StatusOfStatus FROM tbl_IB_Status_For_Status", , index, " onChange=ChangeStatus(this.value)", True, True) + "</center>")
                    Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_sel_tbl_IB_Status_For_Status_StatusOfStatus", , index, " onChange=ChangeStatus(this.value)", True, True) + "</center>")
                    'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                Else
                    'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    'Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "SELECT StatusOfStatus FROM tbl_IB_Status_For_Status", , "", " onChange=ChangeStatus(this.value)", True, True) + "</center>")
                    Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_sel_tbl_IB_Status_For_Status_StatusOfStatus", , "", " onChange=ChangeStatus(this.value)", True, True) + "</center>")
                    'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                End If
                Response.Write("</td></tr></table>")
                'End Modified by HarshK for sp4 issueid 617

                'To Get the total number of issues Table
                Response.Write("<BR>")
                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable' border='0'>")
                Response.Write("<TR><TD valign=top>")
                'Response.Write("<table CellSpacing='1'  class='clsTable' border='0'><TR><TD class='clsTDHeader' colspan=2><b>Total Number of Issues<b></TD></TR>")
                Response.Write("<DIV id='DivMain' style='Overflow:scroll;width:90%;Height:200px'><table CellSpacing='1'  class='clsTable' border='0' width:99.9%><TR><TD class='clsTDHeader'><b>Status<b></TD><TD class='clsTDHeader'><b>Count<b></TD></TR>")
                strStatus = ""
                intRow = 0
                strDivName = 0
                While rsDataReader.Read()
                    If rsDataReader("Status") <> strStatus Then
                        strStatus = rsDataReader("Status")
                        strDivName = strDivName + 1
                    End If
                    intCheckNull1 = 1
                    intRow = intRow + 1
                    If intRow Mod 2 = 0 Then
                        strClass = "clsTDEven"
                    Else
                        strClass = "clsTDOdd"
                    End If
                    Response.Write("<TR>")
                    Response.Write("<TD class=" + strClass + "><A STYLE=TEXT-DECORATION:NONE Href ='JavaScript:Status_OnClick(" + strDivName + ",""" + rsDataReader("Status") + """)'><U>" + rsDataReader("Status").ToString() + "</U></A></TD>")
                    Response.Write("<TD class=" + strClass + ">" + rsDataReader("NoOfIssues").ToString() + "</TD>")
                    Response.Write("</TR>")
                End While
                If intCheckNull1 = 0 Then
                    Response.Write("<TR>")
                    Response.Write("<TD class='clsTDEven' COLSPAN=2><CENTER>There is no items in this view.</CENTER></TD>")
                    Response.Write("</TR>")
                End If
                Response.Write("</TABLE></DIV></TD><TD valign=middle>")
                'If intCheckNull1 = 1 Then
                'To draw the Graph
                'strGraphSQL = "usp_GetNoOfIssues " & intProjectID & ",'" & strSelectedStatus & "','" & Session("LoginType") & "'"
                tblGraphs.Rows.Add(Row)
                Row.Controls.Add(cell)
                'cell.Controls.Add(CreateGraph(strGraphSQL, 400, 300, strConnectionString))
                cell.Controls.Add(CreateGraph(strSQL, 400, 300, strConnectionString))
                'End If
                CommonFunction.Data.DisposeDataReader(rsDataReader)
            End If
        End If
        If Mode = "Dashboard" And Detail = "" Then
            If Request.QueryString("StatusVal") <> "true" Then
                strSQL = "usp_sel_RequestsGraph_customer " & customerid & "," & strSelectedStatus
                rsDataReader = CommonFunction.Data.GetDataReader(strSQL, True)
                Response.Write("<BR>")
                'Modified by HarshK for sp4 issueid 617
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><tr><td class='clsTDHeader' align='left'><b>System Request Status Report</b></td></tr></table>")
                'End Modified by HarshK for sp4 issueid 617
                Response.Write("<BR>")
                'TO draw the status ComboBox
                'Response.Write("<PRE>                    <font size='2' face='Arial'><b>Select System Status </b></font>")
                'Modified by HarshK for sp4 issueid 617
                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><tr class='clsTREven'><td  align='center'>")
                Response.Write("<center><font size='2' face='Arial'>Status</font>&nbsp;")
                'End Modified by HarshK for sp4 issueid 617
                'If Request.QueryString("ComboVal") <> "" Then
                If index <> "" Then
                    'index = Request.QueryString("ComboVal")
                    'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    'Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "SELECT StatusID,Status FROM tbl_crm_status where statusid in(1,3)", , index, " onChange=ChangeStatus1(this.value)", True, True) + "</center>")
                    Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_sel_tbl_crm_status_StatusID", , index, " onChange=ChangeStatus1(this.value)", True, True) + "</center>")
                    'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                Else
                    'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    'Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "SELECT StatusID,Status FROM tbl_crm_status where statusid in(1,3)", , index, " onChange=ChangeStatus1(this.value)", True, True) + "</center>")
                    Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_sel_tbl_crm_status_StatusID", , "", " onChange=ChangeStatus1(this.value)", True, True) + "</center>")
                    'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                End If
                Response.Write("</td></tr></table>")
                'End Modified by HarshK for sp4 issueid 617

                'To Get the total number of issues Table
                Response.Write("<BR>")
                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable' border='0'>")
                Response.Write("<TR><TD valign=top>")
                'Response.Write("<table CellSpacing='1'  class='clsTable' border='0'><TR><TD class='clsTDHeader' colspan=2><b>Total Number of Issues<b></TD></TR>")
                Response.Write("<DIV id='DivMain' style='Overflow:scroll;width:90%;Height:200px'><table CellSpacing='1'  class='clsTable' border='0' width:99.9%><TR><TD class='clsTDHeader'><b>Status<b></TD><TD class='clsTDHeader'><b>Count<b></TD></TR>")
                strStatus = ""
                intRow = 0
                strDivName = 0
                While rsDataReader.Read()
                    If rsDataReader("Status") <> strStatus Then
                        strStatus = rsDataReader("Status")
                        strDivName = strDivName + 1
                    End If
                    intCheckNull1 = 1
                    intRow = intRow + 1
                    If intRow Mod 2 = 0 Then
                        strClass = "clsTDEven"
                    Else
                        strClass = "clsTDOdd"
                    End If
                    Response.Write("<TR>")
                    Response.Write("<TD class=" + strClass + "><A STYLE=TEXT-DECORATION:NONE Href ='JavaScript:Status1_OnClick(" + customerid + ",""" + rsDataReader("Status") + """)'><U>" + rsDataReader("Status").ToString() + "</U></A></TD>")
                    Response.Write("<TD class=" + strClass + ">" + rsDataReader("NoOfIssues").ToString() + "</TD>")
                    Response.Write("</TR>")
                End While
                If intCheckNull1 = 0 Then
                    Response.Write("<TR>")
                    Response.Write("<TD class='clsTDEven' COLSPAN=2><CENTER>There is no items in this view.</CENTER></TD>")
                    Response.Write("</TR>")
                End If
                Response.Write("</TABLE></DIV></TD><TD valign=middle>")
                'If intCheckNull1 = 1 Then
                'To draw the Graph
                'strGraphSQL = "usp_GetNoOfIssues " & intProjectID & ",'" & strSelectedStatus & "','" & Session("LoginType") & "'"
                tblGraphs.Rows.Add(Row)
                Row.Controls.Add(cell)
                'cell.Controls.Add(CreateGraph(strGraphSQL, 400, 300, strConnectionString))
                cell.Controls.Add(CreateGraph(strSQL, 400, 300, strConnectionString))
                CommonFunction.Data.DisposeDataReader(rsDataReader)
            End If
        End If
        If Mode = "Dashboard" And Detail = "" Then
            If Request.QueryString("StatusVal") = "true" Then
                Dim Status As String
                Status = Request.QueryString("Status")
                Response.Write(objMenuIssue.DrawMenu(arrMenuIssue1, arrClientSideFunctionsIssue1, arrMenuToolTipIssue1, True))
                Response.Write("<BR>")
                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><tr><td class='clsTDHeader' align='left'><b>System Request Status Report</b></td></tr></table>")
                'End Modified by HarshK for sp4 issueid 617
                'To Get the isssues table
                Response.Write("<BR>")
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><tr><td class='clsTDHeader' align='left'><font size='2'>Status&nbsp;:-&nbsp;" + Request.QueryString("Status") + "</font></td>")
                'If index <> "" Then
                'Response.Write("<td align='right' class='clsTDHeader'><font size='2'>Corporate Status&nbsp;:-&nbsp;" + statusofstatus + "</font></td>")
                'End If
                Response.Write("</tr></table>")
                Response.Write("<BR>")
                If Status = "Open" Then
                    Call DisplayRequestsGrid()
                ElseIf Status = "Resolved" Then
                    Call DisplayResolvedRequestsGrid()
                End If
            End If
            If Mode = "Discussionthread" Then
                Call DisplayDiscussionThreadGrid()
            End If
        End If
        If Mode = "Dashboard" And Detail = "Issue" Then
            If Request.QueryString("StatusVal") <> "true" Then
                strSQL = "usp_GetIssueReport_Customer " & customerid & "," & strSelectedStatus
                rsDataReader = CommonFunction.Data.GetDataReader(strSQL, True)
                Response.Write("<BR>")
                'Modified by HarshK for sp4 issueid 617
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><tr><td class='clsTDHeader' align='left'><b>System Request Status Report</b></td></tr></table>")
                'End Modified by HarshK for sp4 issueid 617
                Response.Write("<BR>")
                'TO draw the status ComboBox
                'Response.Write("<PRE>                    <font size='2' face='Arial'><b>Select System Status </b></font>")
                'Modified by HarshK for sp4 issueid 617
                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><tr class='clsTREven'><td  align='center'>")
                Response.Write("<center><font size='2' face='Arial'>Status</font>&nbsp;")
                'End Modified by HarshK for sp4 issueid 617
                'If Request.QueryString("ComboVal") <> "" Then
                If index <> "" Then
                    'index = Request.QueryString("ComboVal")
                    'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    'Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "SELECT StatusOfStatusID,StatusOfStatus FROM tbl_IB_Status_for_Status where StatusOfStatusID in(1,3)", , index, " onChange=ChangeStatus2(this.value)", True, True) + "</center>")
                    Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_sel_Status_tbl_IB_Status_for_Status", , index, " onChange=ChangeStatus2(this.value)", True, True) + "</center>")
                    'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                Else
                    'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    'Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "SELECT StatusOfStatusID,StatusOfStatus FROM tbl_IB_Status_for_Status where StatusOfStatusID in(1,3)", , "", " onChange=ChangeStatus2(this.value)", True, True) + "</center>")
                    Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_sel_Status_tbl_IB_Status_for_Status", , "", " onChange=ChangeStatus2(this.value)", True, True) + "</center>")
                    'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                End If
                Response.Write("</td></tr></table>")
                'End Modified by HarshK for sp4 issueid 617

                'To Get the total number of issues Table
                Response.Write("<BR>")
                Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable' border='0'>")
                Response.Write("<TR><TD valign=top>")
                'Response.Write("<table CellSpacing='1'  class='clsTable' border='0'><TR><TD class='clsTDHeader' colspan=2><b>Total Number of Issues<b></TD></TR>")
                Response.Write("<DIV id='DivMain' style='Overflow:scroll;width:90%;Height:200px'><table CellSpacing='1'  class='clsTable' border='0' width:99.9%><TR><TD class='clsTDHeader'><b>Status<b></TD><TD class='clsTDHeader'><b>Count<b></TD></TR>")
                strStatus = ""
                intRow = 0
                strDivName = 0
                While rsDataReader.Read()
                    If rsDataReader("Status") <> strStatus Then
                        strStatus = rsDataReader("Status")
                        strDivName = strDivName + 1
                    End If
                    intCheckNull1 = 1
                    intRow = intRow + 1
                    If intRow Mod 2 = 0 Then
                        strClass = "clsTDEven"
                    Else
                        strClass = "clsTDOdd"
                    End If
                    Response.Write("<TR>")
                    Response.Write("<TD class=" + strClass + "><A STYLE=TEXT-DECORATION:NONE Href ='JavaScript:Status2_OnClick(" + customerid + ",""" + rsDataReader("Status") + """)'><U>" + rsDataReader("Status").ToString() + "</U></A></TD>")
                    Response.Write("<TD class=" + strClass + ">" + rsDataReader("NoOfIssues").ToString() + "</TD>")
                    Response.Write("</TR>")
                End While
                If intCheckNull1 = 0 Then
                    Response.Write("<TR>")
                    Response.Write("<TD class='clsTDEven' COLSPAN=2><CENTER>There is no items in this view.</CENTER></TD>")
                    Response.Write("</TR>")
                End If
                Response.Write("</TABLE></DIV></TD><TD valign=middle>")
                'If intCheckNull1 = 1 Then
                'To draw the Graph
                'strGraphSQL = "usp_GetNoOfIssues " & intProjectID & ",'" & strSelectedStatus & "','" & Session("LoginType") & "'"
                tblGraphs.Rows.Add(Row)
                Row.Controls.Add(cell)
                'cell.Controls.Add(CreateGraph(strGraphSQL, 400, 300, strConnectionString))
                cell.Controls.Add(CreateGraph(strSQL, 400, 300, strConnectionString))
                CommonFunction.Data.DisposeDataReader(rsDataReader)
            End If
        End If

    End Sub
    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  VivekP
        ' Created               :  13 apr 2005  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub
    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by Yogesh J on 02-FEB-2016 to validate Token

        If Not Request.QueryString("Flag") Is Nothing Then
            m_Flag = Request.QueryString("Flag").ToString
        End If

        'If Request.QueryString("ProjectID") <> "" And Request.QueryString("PKToken") <> "" Then
        '    m_strToken = CType(Request.QueryString("PKToken"), String)
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("ProjectID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Status", 0, 0, "ProjectID", CType(Request.QueryString("ProjectID"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        ''End of addition by Yogesh J on 02-FEB-2016 to validate Token

        m_strToken = CType(Request.QueryString("PKToken"), String)
        If ((Request.QueryString("ProjectID") <> "") And (m_Flag = "1")) Then
            If (((m_strToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("ProjectID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False)) Then
                ''Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Status", 0, 0, "ProjectID", CType(Request.QueryString("ProjectID"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

    End Sub
    Private Function CreateGraph(ByVal SQL As String, ByVal Height As Integer, ByVal Width As Integer, ByVal ConnectionString As String, Optional ByRef ImagePath As String = "") As WebControl
        '=====================================================================
        ' Procedure Name        : CreateGraph()
        ' Purpose               : To create the graph control
        ' Description           : Same as above
        ' Parameters Passed     : Graph Type ID
        ' Returns               : Graph Control
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : vivekP
        ' Created               : 13 Apr 2005
        ' Revisions             :
        '=====================================================================
        'Variables Declaration
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strBorderStyle As String = "FRAMETITLE5"""
        Dim strBorderColor As String = "Blue"""
        Dim strChartBackColor As String = "AliceBlue"
        Dim strChartAreaColor As String = "AliceBlue"
        Dim strCaptionColor As String = "Black"
        Dim strTitleColor As String = "AliceBlue"
        Dim blnShowLegends As Boolean = True
        Dim intUCL As Integer = 0
        Dim intLCL As Integer = 0
        Dim strUCLColor As String = ""
        Dim strLCLColor As String = ""
        Dim strPieLabelStyle As String = "INSIDE"
        Dim blnShowExplodedPie As Boolean = False
        Dim strItemName As String = ""
        Dim intGraphID As Integer = 2
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim strPalleteStyle As String = "EARTHTONES"
        Dim intXAxisMax As Long = 0
        Dim intXAxisMin As Long = 0
        Dim intXAxisInterval As Long = 0
        Dim arr() As String = {"PIE", "PIE"}

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") = "Dashboard" Then
            Height = 200
            Width = 540
        Else
            Height = 200
            Width = 540
        End If

        ' create the grpah for the item values
        objGraph = New Graph.Graph
        objGraph.ConnectionString = ConnectionString
        objGraph.VirtualImagePath = "../../Images/" : objGraph.Enable3D = blnEnable3D
        'objGraph.ChartType = GetChartType(intGraphID)
        objGraph.ChartType = arr
        objGraph.BorderStyle = strBorderStyle
        objGraph.GraphTitle = strItemName : objGraph.TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
        objGraph.GraphTitleColor = strTitleColor
        objGraph.SQL = SQL : objGraph.Width = Width : objGraph.Height = Height
        objGraph.ShowExplodedPie = blnShowExplodedPie : objGraph.ChartBackColor = strChartBackColor
        objGraph.ChartAreaColor = strChartAreaColor : objGraph.PalleteStyle = strPalleteStyle
        objGraph.LegendFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)
        objGraph.LegendCaptionColor = strCaptionColor : objGraph.LegendBorderColor = strCaptionColor
        objGraph.BorderColor = strBorderColor : objGraph.ShowLegends = blnShowLegends
        objGraph.BorderGradientColor = "WHITE"
        objGraph.BorderGradientStyle = "TOPBOTTOM"
        objGraph.ChartBackGradientColor = "WHITE"
        objGraph.ChartBackGradientStyle = "TOPBOTTOM"
        objGraph.ChartAreaGradientColor = "WHITE"
        If objGraph.ChartType(0) = "PIE" Or objGraph.ChartType(0) = "DOUGHNUT" Then
            objGraph.ChartAreaGradientStyle = "CENTER"
        Else
            objGraph.ChartAreaGradientStyle = "TOPBOTTOM"
        End If
        objGraph.PieChartLabelStyle = strPieLabelStyle

        objGraph.EntityID = lngEntityID : objGraph.Nomenclature = strNomenclature
        If intGraphID <> 5 Then
            objGraph.LCL = intLCL : objGraph.LCLColor = strLCLColor
            objGraph.UCL = intUCL : objGraph.UCLColor = strUCLColor
        End If
        objGraph.YAxisMin = intXAxisMin
        If intXAxisMax <> 0 Then
            objGraph.YAxisMax = intXAxisMax
        End If
        If intXAxisInterval <> 0 Then
            objGraph.YAxisInterval = intXAxisInterval
        End If
        objGraph.XAxisInterval = 1
        ' return the graph control
        Return objGraph.GenerateChartControl()
    End Function
    Private Sub DisplayRequestsGrid()
        '=====================================================================
        ' Procedure Name        : PlotTaskListGrid()	
        ' Purpose               : TO plot task list grid (Mode=view)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : TruptiK
        ' Created               : 16-July-2008
        ' Revisions             :
        '=====================================================================
        Dim status As String
        Dim CustomerID1
        status = CommonFunction.General.CheckIsNothing(Request.QueryString("Status"), "")
        CustomerID1 = CommonFunction.General.CheckIsNothing(Request.QueryString("customerid"), "")
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        Dim ArrActualFieldNames() As String = {"CustomerName", "Attachments", "Discussions", "QueryID", "Department", "SUBJECT", "Priority", "RequestType", "SubmittedDate", "CRMExpectedResolvedDate", "ShowSLA"}
        Dim ArrUserFriendlyFieldNames() As String = {"Customer Name", "<img src='../../Images/pin.gif'>", "Discussions", "Request ID", "Department", "Subject", "Priority", "Request Type", "Requested On", "CRM Expected Resolved Date", "Show SLA"}
        Dim ArrTDStyle() As String = {"align=left width=15%", "align=centre width=5%", "align=left width=5%", "align=left width=5%", "align=left width=10%", "align=LEFT width=15%", "align=left width=10%", "align=left width=15%", "align=centre width=15%", "align=centre width=10%", "align=centre width=10%"}
        Dim arrIgnoreHTMLEncode() As String = {"", "1", "1"}
        Dim arrRowLink() As String = {"", "Document_OnClick(QueryID)", "", "", "", "", "", "", "", "", "ShowSLA_OnClick(QueryID)"}
        Dim strSQL As String
        strSQL = " Exec usp_sel_Requests " & CustomerID1 & ",'" & status & "'," & m_lngEmployeeID
        With objOpenRequest
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 11
            .DIVID = "divList"
            .DIVHeight = 600
            .DIVStyle = "overflow:auto;width:100%;"
            .RowLinkArray = arrRowLink
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .PrimaryKey = "QueryID"
            '.PrimaryKey = "IRID"
            '.RowLinkArray = arrRowLink
            '.GroupSummaryFunc = ArrGroupSummaryFunctions
            '.GroupSummaryFunc = ArrGroupSummaryFunctions
            '.SummaryFunctions = ArrSummaryFunctions
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            .DrawGrid()
        End With

    End Sub
    Private Sub DisplayResolvedRequestsGrid()
        '=====================================================================
        ' Procedure Name        : PlotTaskListGrid()	
        ' Purpose               : TO plot task list grid (Mode=view)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : TruptiK
        ' Created               : 16-July-2008
        ' Revisions             :
        '=====================================================================
        Dim status As String
        Dim CustomerID1
        status = CommonFunction.General.CheckIsNothing(Request.QueryString("Status"), "")
        CustomerID1 = CommonFunction.General.CheckIsNothing(Request.QueryString("customerid"), "")
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        Dim ArrActualFieldNames() As String = {"CustomerName", "Attachments", "Discussions", "QueryID", "SUBJECT", "RequestType", "CRMExpectedResolvedDate", "ResolvedDate", "LastDiscussionThread", "Comments", "ShowSLA"}
        Dim ArrUserFriendlyFieldNames() As String = {"Customer Name", "<img src='../../Images/pin.gif'>", "Discussions", "Request ID", "Subject", "Request Type", "CRM Expected Resolved Date", "Resolved Date", "Last Discussion Thread", "CRM Comments", "Show SLA"}
        Dim ArrTDStyle() As String = {"align=left width=5%", "align=centre width=5%", "align=left width=5%", "align=left width=5%", "align=left width=20%", "align=LEFT width=10%", "align=left width=5%", "align=left width=5%", "align=left width=30%", "align=left width=15%", "align=centre width=5%"}
        Dim arrIgnoreHTMLEncode() As String = {"", "1", "1", "", "", "", "", "", "", "1"}
        Dim arrRowLink() As String = {"", "Document_OnClick(QueryID)", "", "", "", "", "", "", "", "", "ShowSLA_OnClick(QueryID)"}
        Dim strSQL As String
        strSQL = " Exec usp_sel_Requests " & customerid & ",'" & status & "'," & m_lngEmployeeID
        With objResolvedRequest
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 12
            .DIVID = "divList"
            .DIVHeight = 600
            .DIVStyle = "overflow:auto;width:100%;"
            .RowLinkArray = arrRowLink
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .PrimaryKey = "QueryID"
            '.PrimaryKey = "IRID"
            .RowLinkArray = arrRowLink
            '.GroupSummaryFunc = ArrGroupSummaryFunctions
            '.GroupSummaryFunc = ArrGroupSummaryFunctions
            '.SummaryFunctions = ArrSummaryFunctions
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            .DrawGrid()
        End With

    End Sub
    Private Sub DisplayDiscussionThreadGrid()
        '=====================================================================
        ' Procedure Name        : PlotTaskListGrid()	
        ' Purpose               : TO plot task list grid (Mode=view)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : TruptiK
        ' Created               : 16-July-2008
        ' Revisions             :
        '=====================================================================


        Dim ArrActualFieldNames() As String = {"SubmittedBy", "SubmittedDate", "DiscussionThread"}
        Dim ArrUserFriendlyFieldNames() As String = {"User Name", "Date", "Comments"}
        Dim ArrTDStyle() As String = {"align=left width=20%", "align=centre width=30%", "align=left width=50%"}
        'Dim arrIgnoreHTMLEncode() As String = {"", "1", "1"}
        'Dim arrRowLink() As String = {"", "Document_OnClick(QueryID)", "", "", "", "", "", "", "", "", "", "ShowSLA_OnClick(QueryID)"}
        Dim strSQL As String
        strSQL = " Exec usp_CRM_Discussions " & QueryID
        With objThreadGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 3
            .DIVID = "divList"
            .DIVHeight = 600
            .DIVStyle = "overflow:auto;width:100%;"
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            .DrawGrid()
        End With

    End Sub
#End Region

    Private Sub objOpenRequest_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objOpenRequest.ColumnHeaderTD_BeforePrint
        Select Case UCase(Trim(Args.DataField & ""))
            Case "DISCUSSIONS"
                Args.ApplySorting = False
                Args.ColumnName = "<IMG border=0 src='../../Images/Discussions.gif'>"
                Args.ApplyHTMLEncode = False

        End Select
    End Sub

    Private Sub objOpenRequest_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objOpenRequest.DataRowTD_BeforePrint
        If Args.ColIndex = 0 Then 'if first column(Employee Name)

            'Determine stylesheet for row
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
                Args.StringToBeInserted = "<TD align='left'></TD>"
            Else
                Args.StringToBeInserted = "<TD align='left'></TD>"
            End If
            Cancel = True
        End If

        Select Case UCase(Trim(Args.DataField & ""))
            Case "ATTACHMENTS"
                '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                ''Args.ApplyHTMLEncode = False
                ''Args.TDStyle = " title='Attachments' "
                If Trim(Args.DataReader("Attachments").ToString & "") <> "" Then
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    '' Args.StringToBeInserted = "<TD  NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "'  style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A> " & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"
                    Args.StringToBeInserted = "<TD vAlign=top title='Attachments' style='TEXT_DECORATION:None' nowrap;>" _
                                & "<A href=""JavaScript:Document_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & Trim(Args.DataReader("Attachments").ToString & "") & "</A></TD>"

                    Cancel = True
                Else
                    Args.DataFieldValue = " "
                End If
            Case "DISCUSSIONS"
                If Trim(Args.DataReader("NoOfDiscussions").ToString & "") <> "" And Trim(Args.DataReader("NoOfDiscussions").ToString & "") <> "0" Then
                    If Not CType(Args.DataReader("IsDiscussionViewed"), Boolean) Then

                        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                        'Args.StringToBeInserted = "<TD NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "' style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A> " & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"
                        'Cancel = True
                        Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "' style='TEXT_DECORATION:None' nowrap;>" _
                                                          & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A>" & ("New") & "</TD>"

                        Cancel = True

                        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    Else
                        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                        'Args.StringToBeInserted = "<TD NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "' style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"
                        'Cancel = True
                        Args.StringToBeInserted = "<TD vAlign=top title='" & ("DISCUSSIONS") & "' style='TEXT_DECORATION:None' nowrap;>" _
                                                         & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"

                        Cancel = True
                        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    End If
                Else
                    ''Args.DataFieldValue = "<IMG border=0 src='../../Images/Discussions.gif' title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "'>"
                    ''Args.ApplyHTMLEncode = False
                    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    Args.StringToBeInserted = "<TD vAlign=top>" _
                                                & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif' alt= " & MyBase.GetResourceString("DISCUSSIONS") & "></A></TD>"
                    Cancel = True
                    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                End If
        End Select
    End Sub


    Private Sub objOpenRequest_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objOpenRequest.DataRowTR_BeforePrint
        If m_CustomerName <> Args.DataReader("CustomerNAME").ToString.Trim Then
            m_CustomerName = Args.DataReader("CustomerNAME").ToString.Trim + ""

            Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=11>" + Args.DataReader("CustomerNAME").ToString + "</FONT></TD></TR>"

        End If

    End Sub
    Private Sub objResolvedRequest_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objResolvedRequest.ColumnHeaderTD_BeforePrint
        Select Case UCase(Trim(Args.DataField & ""))
            Case "DISCUSSIONS"
                Args.ApplySorting = False
                Args.ColumnName = "<IMG border=0 src='../../Images/Discussions.gif'>"
                Args.ApplyHTMLEncode = False

        End Select
    End Sub

    Private Sub objResolvedRequest_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objResolvedRequest.DataRowTD_BeforePrint
        If Args.ColIndex = 0 Then 'if first column(Employee Name)

            'Determine stylesheet for row
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
                Args.StringToBeInserted = "<TD align='left'></TD>"
            Else
                Args.StringToBeInserted = "<TD align='left'></TD>"
            End If
            Cancel = True
        End If

        Select Case UCase(Trim(Args.DataField & ""))
            Case "ATTACHMENTS"
                '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                ''Args.ApplyHTMLEncode = False
                ''Args.TDStyle = " title='Attachments' "
                If Trim(Args.DataReader("Attachments").ToString & "") <> "" Then
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    '' Args.StringToBeInserted = "<TD  NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "'  style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A> " & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"
                    Args.StringToBeInserted = "<TD vAlign=top title='Attachments' style='TEXT_DECORATION:None' nowrap;>" _
                                & "<A href=""JavaScript:Document_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & Trim(Args.DataReader("Attachments").ToString & "") & "</A></TD>"

                    Cancel = True
                Else
                    Args.DataFieldValue = " "
                End If

            Case "LASTDISCUSSIONTHREAD"
                Args.ApplyHTMLEncode = False
            Case "DISCUSSIONS"
                If Trim(Args.DataReader("NoOfDiscussions").ToString & "") <> "" And Trim(Args.DataReader("NoOfDiscussions").ToString & "") <> "0" Then
                    If Not CType(Args.DataReader("IsDiscussionViewed"), Boolean) Then

                        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                        'Args.StringToBeInserted = "<TD NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "' style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A> " & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"
                        'Cancel = True
                        Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "' style='TEXT_DECORATION:None' nowrap;>" _
                                                          & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A>" & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"

                        Cancel = True

                        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    Else
                        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                        'Args.StringToBeInserted = "<TD NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "' style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"
                        'Cancel = True
                        Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "' style='TEXT_DECORATION:None' nowrap;>" _
                                                         & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"

                        Cancel = True
                        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    End If
                Else
                    ''Args.DataFieldValue = "<IMG border=0 src='../../Images/Discussions.gif' title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "'>"
                    ''Args.ApplyHTMLEncode = False
                    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    Args.StringToBeInserted = "<TD vAlign=top>" _
                                                & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif' alt= " & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "></A></TD>"
                    Cancel = True
                    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                End If
        End Select
    End Sub
    Private Sub objResolvedRequest_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objResolvedRequest.DataRowTR_BeforePrint
        If m_CustomerName <> Args.DataReader("CustomerNAME").ToString.Trim Then
            m_CustomerName = Args.DataReader("CustomerNAME").ToString.Trim + ""

            Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=14>" + Args.DataReader("CustomerNAME").ToString + "</FONT></TD></TR>"

        End If
    End Sub
End Class
