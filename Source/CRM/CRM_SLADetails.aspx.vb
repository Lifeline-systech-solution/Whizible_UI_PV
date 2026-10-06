'=====================================================================
' Class	Name	        :	CRM_SLADetails
' Purpose				:	Page to view Details of Helpdesk Requests SLA
' Description			:	Same as above
' Assumptions			:	None
' Dependencies			:	None
' Author				:	SandipL
' Created				:	22 June 2007
' Revisions				:	
'=====================================================================
Public Class CRM_SLADetails
    Inherits WebPage.Templates.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()

    End Sub

#End Region
    Protected m_CategoryID As Integer
    Protected m_intMonth As Integer
    Protected m_filterID As Integer = 0
    Private m_strFilterText As String
    Private m_lngEmployeeID As Integer
    Protected m_intSubRequestTypeID As Integer
    Private WithEvents m_objGrid As WebPages.Template.GenericGrid
    Protected m_blnFromGraph As Boolean = True
    Protected m_strMode As String = "DB"
    Private m_strLogintype As String = "E"
    Protected m_intYear As Integer = Year(Now())
    Private m_blnFilter As Boolean = False
    Private m_strRequester As String = ""
    Private m_strQueryID As String = ""
    Private m_blnRequestLevelSLA As Boolean = False
    Protected m_blnFromAgeingGraph As Boolean = False
    Protected m_strStatus As String
    Protected m_strAgeing As String
    Protected m_PkToken As String

    Private Enum MetNotMet
        CONST_NOTMET = 0
        CONST_MET = 1
        CONST_NOTAPPLICABLE = 2
    End Enum
    Private m_intSeries As MetNotMet

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub WritePage()
        Initialize()
        ''added by Nilesh g on 22/1/2016 for URL security Issue
        If (m_PkToken <> "") Then
            If (m_PkToken <> "" And CommonFunctions.Security.Token.ValidateToken(CType(m_blnRequestLevelSLA, String) + CType(m_strQueryID, String) + "0" + "0", m_PkToken) = False) Then
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        writeMenu()
        Response.Write("<br>")
        Call GeneratePageCaption()
        If m_blnRequestLevelSLA = False Then
            Call PlotFilterSection()
        End If
        Response.Write("<br>")
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:100%'>")
        If m_blnFromAgeingGraph = False Then
            WriteSLAGrid()
        Else
            WriteRequestAgeingGrid()
        End If

        CommonFunctions.General.WriteHTML("</DIV>")
        Response.Write("<br>")
        writeMenu()
    End Sub
    Private Sub GeneratePageCaption()
        If m_blnFromAgeingGraph = False Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "SLA Details", , , True))
        Else
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Request Details", , , True))
        End If

    End Sub
    Private Sub PlotFilterSection()
        CommonFunctions.General.WriteHTML("<DIV id='DivFilter'  style='Overflow:auto;width:100%;'>")
        CommonFunctions.General.WriteHTML("<Table id=tblFilter CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class=clsTable>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='Right' Title='Contains'>Requestor</td><td align='left' Title='Contains'>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtRequester", "txtRequester", , , 100, m_strRequester, ToBeInserted:=" OnKeyPress=SetFilter(event)", EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td align='Right' Title='Equals'>Request ID</td><td align='left' Title='Equals'>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtQueryID", "txtQueryID", , , 8, m_strQueryID, ToBeInserted:=" OnKeyPress=SetFilter(event)", EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("</DIV>")
    End Sub
    Private Sub Initialize()
        Dim strSeries As String
        Dim strMonth As String

        m_strLogintype = CStr(HttpContext.Current.Session("LoginType"))
        m_lngEmployeeID = CInt(HttpContext.Current.Session("intUserID"))

        If Not Request("FilterID") Is Nothing Then
            If Request("FilterID") <> "" Then
                m_filterID = CInt(Request("FilterID"))
            End If
        End If

        If Not Request("FromGraph") Is Nothing Then
            If Request("FromGraph") <> "" Then
                m_blnFromGraph = CBool(Request("FromGraph"))
            End If
        End If

        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode")
        End If
        ''added by Nilesh g on 22/1/2016 for URL security Issue
        If Not Request.QueryString("PKToken") Is Nothing Then
            m_PkToken = Request.QueryString("PKToken")
        End If


        If Not Request.QueryString("Year") Is Nothing Then
            If Request.QueryString("Year") <> "" Then
                m_intYear = CInt(Request.QueryString("Year"))
            End If
        End If
        If Not Request.QueryString("ApplyFilter") Is Nothing Then
            If Request.QueryString("ApplyFilter") = "1" Then
                m_blnFilter = True
                m_strRequester = Request("txtRequester").Trim()
                m_strQueryID = Request("txtQueryID").Trim()
            End If
        End If
        If Not Session("strCRM_Filter_" & UCase(Trim(m_strMode & ""))) Is Nothing Then
            m_strFilterText = CStr(Session("strCRM_Filter_" & UCase(Trim(m_strMode & ""))))
        End If
        If Not Request.QueryString("FromAgeingGraph") Is Nothing Then
            If Request.QueryString("FromAgeingGraph") <> "" Then
                m_blnFromAgeingGraph = CBool(Request.QueryString("FromAgeingGraph"))
                m_strStatus = Request.QueryString("Status")
                m_strAgeing = Request.QueryString("Ageing")
            End If
        End If


        If m_blnFromGraph = True Then
            If Not Request("CategoryID") Is Nothing Then
                If Request("CategoryID") <> "" Then
                    m_CategoryID = CInt(Request("CategoryID"))
                End If
            End If
            If Not Request("Series") Is Nothing Then
                If Request("Series") <> "" Then
                    strSeries = Request("Series")
                    Select Case strSeries.ToUpper
                        Case "SERIES2"
                            m_intSeries = MetNotMet.CONST_MET
                        Case "SERIES3"
                            m_intSeries = MetNotMet.CONST_NOTMET
                        Case "SERIES4"
                            m_intSeries = MetNotMet.CONST_NOTAPPLICABLE
                    End Select
                End If
            End If
            If Not Request("Series") Is Nothing Then
                If Request("Series") <> "" Then
                    strMonth = Request("Month")
                    m_intMonth = CInt(Left(strMonth, 2))
                End If
            End If
        End If

        If Not Request("MonthID") Is Nothing Then
            If Request("MonthID") <> "" Then
                m_intMonth = CInt(Request("MonthID"))
            End If
        End If

        If Not Request("SubRequestTypeID") Is Nothing Then
            If Request("SubRequestTypeID") <> "" Then
                m_intSubRequestTypeID = CInt(Request("SubRequestTypeID"))
            End If
        End If

        If Not Request.QueryString("RequestSLA") Is Nothing Then
            If Request.QueryString("RequestSLA") = "1" Then
                m_blnRequestLevelSLA = True
                m_strQueryID = Request("QueryID")
            End If
        End If
        ''Added  By Shamkant s 30/12/2015
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
        'Ended By Shamkant s 30/12/2015
    End Sub
    Private Sub WriteSLAGrid()
        'm_objGrid = New WebPages.Template.GenericGrid
        ' Added by MahendraV On 3:17 PM 7/3/2007 To display output using HTML table in place of DataGrid
        ' Start_MV_7/3/2007
        Dim intCntSLADetails As Integer = 1
        Dim blnRecordPresent As Boolean = False
        Dim strTRstyleSLADetails As String
        Dim drSLADetails As IDataReader
        Dim strQueryID As String = ""
        Dim strDate As String = ""
        Dim m_intQueries As Integer = 0
        Dim m_intTotalRecords As Integer = 0
        ' End_MV_7/3/2007
        Dim strSQL As String = ""
        'Integrated by vidyak on 07-Jun-2010 for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on SLA details page)
        Dim arrUserFriendlyCols() As String = {"Request ID", "Subject", "Priority", "Request Type", "SubRequest type", "S L A", "Norm", "Actual", "Met/ NotMet", "Remaining"}
        'End-Integrated by vidyak for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on SLA details page)
        Dim arrActualCols() As String = {"QueryID", "HelpDeskName", "Priority", "RequestType", "SubRequestType", "SLAName", "strNorm", "strActualDuration", "MetApplicable"}
        Dim arrGroupOnColumn() As String = {"1"}
        'Dim arrIgnoreHTMLEncode() As String = {"", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"}
        If m_blnRequestLevelSLA = True Then
            strSQL = "usp_PM_CalculateSLAForHelpDesk_Query_Details " & m_strQueryID.ToString
        Else
            If m_blnFromGraph Then
                strSQL = "usp_PM_CalculateSLAForHelpDesk_Graphs_Details " & m_lngEmployeeID.ToString & "," & m_intMonth.ToString & ",'" & m_strMode & "','" & m_strLogintype & "'," & m_intYear.ToString & "," & m_CategoryID.ToString & "," & m_intSeries & ",NULL"
            Else
                strSQL = "usp_PM_CalculateSLAForHelpDesk_Graphs_Details " & m_lngEmployeeID.ToString & "," & m_intMonth.ToString & ",'" & m_strMode & "','" & m_strLogintype & "'," & m_intYear.ToString & ",NULL,NULL," & m_intSubRequestTypeID.ToString
            End If

            If m_filterID > 0 Then
                strSQL = strSQL & "," & m_filterID.ToString & ",NULL"
            Else
                strSQL = strSQL & ",NULL"
                If m_strFilterText <> "" Then
                    strSQL = strSQL + ",'" + CommonFunctions.General.BuildQueryString(m_strFilterText) + "'"
                Else
                    strSQL = strSQL + ",NULL"
                End If

            End If
            If m_blnFilter Then
                If m_strRequester <> "" Then
                    strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(m_strRequester) & "'"
                Else
                    strSQL = strSQL & ",NULL"
                End If
                If m_strQueryID <> "" Then
                    strSQL = strSQL & "," & m_strQueryID
                End If
            End If
        End If


        drSLADetails = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        CommonFunctions.General.WriteHTML("<DIV id='DivGrid' style='overflow:auto;width:100%;'>")
        ' Added and commented by MahendraV On 3:17 PM 7/3/2007 To display output using HTML table in place of DataGrid
        ' Start_MV_7/3/2007
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        If m_blnFromGraph = True And m_blnRequestLevelSLA = False Then
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Request ID</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Subject</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Priority</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Request Type</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>SubRequest Type</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Submitted</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Requestor</TH>")
        End If
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>S L A</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Norm</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Actual</TH>")
		'Integrated by vidyak on 07 Jun 2010 for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on SLA details page)
   		If m_blnRequestLevelSLA = True Then
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Remaining</TH>")
        End If
        'Integrated by vidyak for WhizibleSem9 SP1 - HotFix 9.0.048 
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Met/ NotMet</TH>")
        CommonFunctions.General.WriteHTML("</THEAD>")
        While drSLADetails.Read()
            m_intTotalRecords = m_intTotalRecords + 1
            blnRecordPresent = True
            If (m_blnFromGraph = False Or m_blnRequestLevelSLA = True) And CommonFunctions.Data.CheckIsDBNull(drSLADetails("QueryID"), "").ToString <> strQueryID Then
                intCntSLADetails = 1
                m_intQueries = m_intQueries + 1
                strQueryID = CommonFunctions.Data.CheckIsDBNull(drSLADetails("QueryID"), "").ToString()
                'Integrated by vidyak on 07 Jun 2010  for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on SLA details page)
  				If m_blnRequestLevelSLA = True Then
                    CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD colspan=5  ><b>" & strQueryID & ":-</b>")
                Else
                CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD colspan=4  ><b>" & strQueryID & ":-</b>")
                End If
                'End-Integrated by vidyak on 07 Jun 2010  for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on SLA details page)
                'CommonFunctions.General.WriteHTML("<TD WIDTH=10%>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("HelpDeskName"), "").ToString() & "</TD>")
                'CommonFunctions.General.WriteHTML("<TD WIDTH=10%>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("Priority"), "").ToString() & "</TD>")
                'CommonFunctions.General.WriteHTML("<TD WIDTH=10%>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("RequestType"), "").ToString() & "</TD>")
                'CommonFunctions.General.WriteHTML("<TD WIDTH=10% >" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubRequestType"), "").ToString() & "</TD>")
                CommonFunctions.General.WriteHTML(CommonFunctions.Data.CheckIsDBNull(drSLADetails("HelpDeskName"), "").ToString() & "<Br>")
                CommonFunctions.General.WriteHTML("<B> Priority:-</B>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("Priority"), "").ToString())
                CommonFunctions.General.WriteHTML("<B> Request Type:-</B>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("RequestType"), "").ToString())
                CommonFunctions.General.WriteHTML("<B> Sub Request Type:-</B>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubRequestType"), "").ToString())
                If CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedDate"), "").ToString() <> "" Then
                    strDate = CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedDate"), "").ToString(), Date))
                End If

                If CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedTime"), "").ToString <> "" Then
                    'CommonFunctions.General.WriteHTML("<TD align='right'   Width=10% > " & strDate & " " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedTime"), "").ToString & " </TD>")
                    CommonFunctions.General.WriteHTML("<BR><B> Submitted:-</B>" & strDate & " " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedTime"), "").ToString)
                Else
                    'CommonFunctions.General.WriteHTML("<TD align='right'   Width=10% > " & strDate & " </TD>")
                    CommonFunctions.General.WriteHTML("<BR><B> Submitted:-</B>" & strDate)
                End If
                CommonFunctions.General.WriteHTML("<B> Requestor:-</B>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("Requester"), "").ToString() & " </TD></TR>")

                'CommonFunctions.General.WriteHTML("<TD WIDTH=40% colspan=4>&nbsp;</TD></TR>")

            Else
                intCntSLADetails = intCntSLADetails + 1
            End If


            If (intCntSLADetails Mod 2) = 0 Then
                strTRstyleSLADetails = "clsTREvenRow"
            Else
                strTRstyleSLADetails = "clsTROdd"
            End If
            CommonFunctions.General.WriteHTML("<TR class=" & strTRstyleSLADetails & ">")
            'CommonFunctions.General.WriteHTML("<TD align='right'   Width=60% >&nbsp;</TD>")
            If m_blnFromGraph = True And m_blnRequestLevelSLA = False Then
                CommonFunctions.General.WriteHTML("<TD WIDTH=10%  >" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("QueryID"), "").ToString() & "</td>")
                CommonFunctions.General.WriteHTML("<TD WIDTH=10%>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("HelpDeskName"), "").ToString() & "</TD>")
                CommonFunctions.General.WriteHTML("<TD WIDTH=10%>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("Priority"), "").ToString() & "</TD>")
                CommonFunctions.General.WriteHTML("<TD WIDTH=10%>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("RequestType"), "").ToString() & "</TD>")
                CommonFunctions.General.WriteHTML("<TD WIDTH=10% >" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubRequestType"), "").ToString() & "</TD>")
                If CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedDate"), "").ToString() <> "" Then
                    strDate = CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedDate"), "").ToString(), Date))
                End If

                If CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedTime"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD align='right'   Width=10% > " & strDate & " " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedTime"), "").ToString & " </TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD align='right'   Width=10% > " & strDate & " </TD>")
                End If
                CommonFunctions.General.WriteHTML("<TD WIDTH=10% >" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("Requester"), "").ToString() & "</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("SLAName"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("SLAName"), "").ToString & " </TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("strNorm"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("strNorm"), "").ToString & " </TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("strActualDuration"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("strActualDuration"), "").ToString & " </TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If
			'Integrated by vidyak on 07 Jun 2010  for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on SLA details page)
			If m_blnRequestLevelSLA = True Then
                If CommonFunctions.Data.CheckIsDBNull(drSLADetails("RemainingHrsMin"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> <FONT color='red'>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("RemainingHrsMin"), "").ToString & "</FONT> </TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
                End If
            End If
            'End-Integrated by vidyak on 07 Jun 2010  for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on SLA details page)
            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("MetApplicable"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("MetApplicable"), "").ToString & " </TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD></TR>")
            End If

        End While
        CommonFunctions.Data.DisposeDataReader(drSLADetails)
        If blnRecordPresent = False Then
            CommonFunctions.General.WriteHTML("<TR class=clsTREvenRow><TD align='center' colspan=11 Width=10%>There are no items to show in this view.</TD></TR>")
        End If
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.General.WriteHTML("</DIV>")
        If m_intTotalRecords > 0 Then
            If m_blnFromGraph = False And m_blnRequestLevelSLA = False Then
                CommonFunctions.General.WriteHTML("<Table class='clsTable'  WIDTH='99.9%'><TR class=clsTrOdd><td align=Right>Total Requests: " & m_intQueries.ToString & " </td></tr></table>")
            Else
                CommonFunctions.General.WriteHTML("<Table class='clsTable'  WIDTH='99.9%'><TR class=clsTrOdd><td align=Right>Total Records: " & m_intTotalRecords.ToString & " </td></tr></table>")
            End If
        End If


        'With m_objGrid

        '    .NoOfDataColumns = arrUserFriendlyCols.Length
        '    .UserFriendlyColumnArray = arrUserFriendlyCols
        '    .ActualColumnArray = arrActualCols
        '    .GroupOnColumn = arrGroupOnColumn
        '    '.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        '    '.RowLinkArray = arrLink
        '    '.CheckBoxIDArray = arrchkbox
        '    '.PrimaryKey = "QueryID"
        '    .returnHTML = False
        '    .SQL = strSQL
        '    .UseSQL = True
        '    '.CurrentPage = m_intPageNumber
        '    '.PageSize = 20
        '    .DIVID = "divGrid"
        '    .DIVStyle = "overflow:auto;width:100%;"
        '    .DIVHeight = 375
        '    .ColNameToolTipOnEachRow = True
        '    .EmptyValueReplacement = "-"
        '    .DrawGrid()

        'End With
        'm_objGrid = Nothing
        ' End_MV_7/3/2007
    End Sub
    Private Sub WriteRequestAgeingGrid()
        Dim strSQL As String = ""
        Dim arrUserFriendlyCols() As String = {"Request ID", "Subject", "Priority", "Status", "Request Type", "Sub Request type", "Requestor", "Department", "Last Response Date"}
        Dim arrActualCols() As String = {"QueryID", "Subject", "Priority", "Status", "RequestType", "SubRequestType", "CustomerID", "Department", "LastStatusChangedate"}
        'Dim arrGroupOnColumn() As String = {"1"}

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15
        Dim dsAgeing As DataSet

        m_objGrid = New WebPages.Template.GenericGrid
        strSQL = "usp_PM_HelpDeskStatuswiseAgeing_details " & m_lngEmployeeID.ToString & ",'" & m_strMode & "','" & m_strLogintype & "'," & m_strAgeing & ",'" & m_strStatus & "'," & m_intYear.ToString

        If m_filterID > 0 Then
            strSQL = strSQL & "," & m_filterID.ToString & ",NULL"
        Else
            strSQL = strSQL & ",NULL"
            If m_strFilterText <> "" Then
                strSQL = strSQL + ",'" + CommonFunctions.General.BuildQueryString(m_strFilterText) + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If

        End If
        If m_blnFilter Then
            If m_strRequester <> "" Then
                strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(m_strRequester) & "'"
            Else
                strSQL = strSQL & ",NULL"
            End If
            If m_strQueryID <> "" Then
                strSQL = strSQL & "," & m_strQueryID
            End If
        End If
        dsAgeing = CommonFunctions.Data.GetDataSet(strSQL, "Ageing")


        With m_objGrid

            .NoOfDataColumns = arrUserFriendlyCols.Length
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            '.GroupOnColumn = arrGroupOnColumn
            '.IgnoreHTMLEncode = arrIgnoreHTMLEncode
            '.RowLinkArray = arrLink
            '.CheckBoxIDArray = arrchkbox
            '.PrimaryKey = "QueryID"
            .returnHTML = False
            .SQL = strSQL
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .UseSQL = True
            '.CurrentPage = m_intPageNumber
            '.PageSize = 20
            .DIVID = "divGrid"
            .DIVStyle = "overflow:auto;width:100%;"
            '.DIVHeight = 375
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = "-"
            .DrawGrid()

        End With
        m_objGrid = Nothing
        CommonFunctions.General.WriteHTML("<Table class='clsTable'  WIDTH='99.9%'><TR class=clsTrOdd><td align=right>Total Requests: " & dsAgeing.Tables(0).Rows.Count & " </td></tr></table>")
    End Sub

    Private Sub writeMenu()
        Dim arrMenu() As String = {"Close"}
        Dim arrMenuToolTip() As String = {"Close"}
        Dim arrCSFunction() As String = {"Close_OnClick()"}
        Dim objMenu As New WebPage.Templates.StaticMenu
        objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, False)

    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "QUERYID" Then
            Args.ApplyDataTypeBasedFormatting = False
        End If
        If Args.DataField.ToUpper = "LASTSTATUSCHANGEDATE" Then
            Args.ShowTimeWithDate = True
        End If
    End Sub
End Class
