Public Class CRM_ShowSLAdetails
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

        ''Added by Dhanashri S on 28 Mar 2016
        If Request.QueryString("Mode") = "SR" Or Request.QueryString("Mode") = "AR" Then
            If (Request.QueryString("PKSLAdetailsToken") <> "" And Request.QueryString("Year") <> "" And Request.QueryString("FilterID") <> "") Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("Year"), String) + CType(Request.QueryString("FilterID"), String) + "0" + "0", Request.QueryString("PKSLAdetailsToken")) = False) Then

                    'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If
        ''End of Addition by Dhanashri S on 28 MAr 2016
    End Sub

#End Region
    Protected m_filterID As Integer = 0
    Private m_strFilterText As String
    Private m_lngEmployeeID As Integer
    Protected m_intYear As Integer = Year(Now())
    Protected m_strMode As String = "DB"
    Private m_strLogintype As String = "E"
    Private m_blnFilter As Boolean = False
    Private m_strRequester As String = ""
    Private m_strQueryID As String = ""
    Private m_strRequestType As String = ""
    Private m_strSubRequestType As String = ""
    Private m_strDepartment As String = ""
    Private m_strStatus As String = ""
    Private m_strSortBy As String = "QueryID"
    Private m_strAscDesc As String = "Asc"
    Private WithEvents m_objGrid As WebPages.Template.GenericGrid
    Protected m_intTotalNoOfRows As Integer = 0
    Protected m_intPageNumber As Integer = 1
    Private WithEvents m_objSectionTitle As New WebPage.Templates.SectionTitle

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub WritePage()
        Initialize()
        writeMenu()
        CommonFunctions.General.WriteHTML("<br>")
        PlotHiddenControls()
        CommonFunctions.General.WriteHTML("<DIV id='DivMain'  style='Overflow:auto;width:100%;'>")

        GeneratePageCaption()
        PlotFilterSection()
        WriteSLAGrid()
        CommonFunctions.General.WriteHTML("</DIV>")
        CommonFunctions.General.WriteHTML("<br>")
        writeMenu()
    End Sub
    Private Sub GeneratePageCaption()
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "SLA Details", , , True))
    End Sub
    Private Sub PlotFilterSection()
        Dim strSQL As String

        strSQL = " Select 'SLA Not Defined' as status UNION Select 'Not Acknowledged' as status  UNION " + vbCrLf
        strSQL = strSQL & " Select 'Met' as status UNION Select 'Not Met' as status   "

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
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td align='Right' Title='Contains'>Department</td><td align='left' Title='Contains'>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtDept", "txtDept", , , 100, m_strDepartment, ToBeInserted:=" OnKeyPress=SetFilter(event)", EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td> </tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")

        CommonFunctions.General.WriteHTML("<td align='Right' Title='Contains'>Request Type</td><td align='left' Title='Starts with'>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtRequestType", "txtRequestType", , , 100, m_strRequestType, ToBeInserted:=" OnKeyPress=SetFilter(event)", EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td align='Right' Title='Equals'>SubRequest Type</td><td align='left' Title='Equals'>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtSubRequestType", "txtSubRequestType", , , 100, m_strSubRequestType, ToBeInserted:=" OnKeyPress=SetFilter(event)", EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td align='Right' Title='Equals'>Overall Status</td><td align='left' Title='Equals'>")
        CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, 100, m_strStatus, " Onchange=Staus_OnChange()", True)
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("</DIV>")
    End Sub
    Private Sub Initialize()
        m_strLogintype = CStr(HttpContext.Current.Session("LoginType"))
        m_lngEmployeeID = CInt(HttpContext.Current.Session("intUserID"))

        If Not Request("FilterID") Is Nothing Then
            If Request("FilterID") <> "" Then
                m_filterID = CInt(Request("FilterID"))
            End If
        End If
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode")
        End If
        If Not Request.QueryString("ApplyFilter") Is Nothing Then
            If Request.QueryString("ApplyFilter") = "1" Then
                m_blnFilter = True
                m_strRequester = Request("txtRequester").Trim()
                m_strQueryID = Request("txtQueryID").Trim()
                m_strDepartment = Request("txtDept").Trim()
                m_strRequestType = Request("txtRequestType").Trim()
                m_strSubRequestType = Request("txtSubRequestType").Trim()
                m_strStatus = Request("cboStatus")
            End If
        End If
        If Not Session("strCRM_Filter_" & UCase(Trim(m_strMode & ""))) Is Nothing Then
            m_strFilterText = CStr(Session("strCRM_Filter_" & UCase(Trim(m_strMode & ""))))
        End If
        If Not Request.QueryString("Year") Is Nothing Then
            If Request.QueryString("Year") <> "" Then
                m_intYear = CInt(Request.QueryString("Year"))
            End If
        End If
        If Not Request.QueryString("PageNumber") Is Nothing Then
            If Request.QueryString("PageNumber") <> "" Then
                m_intPageNumber = CInt(Request.QueryString("PageNumber"))
            End If
        End If

        If Not Request("txthdnSortBy") Is Nothing Then
            m_strSortBy = Request("txthdnSortBy")
            m_strAscDesc = Request("txthdnAscDesc")
        End If

    End Sub
    Private Sub WriteSLAGrid()
        Dim strSQL As String = ""
        Dim arrUserFriendlyCols() As String = {"Request ID", "Subject", "Request Type", "SubRequest type", "Department", "Requestor", "Acknowledgement", "Response", "Resolution", "Closure", "Overall"}
        Dim arrActualCols() As String = {"QueryID", "Subject", "RequestType", "SubRequestType", "Department", "CustomerID", "Acknowledgement", "Response", "Resolution", "Closure", "Overall"}
        'Dim arrGroupOnColumn() As String = {"1"}
        Dim arrIgnoreHTMLEncode() As String = {"0", "0", "0", "0", "0", "0", "1", "1", "1", "1", "1"}
        Dim dsGrid As DataSet
        Dim PagingSQL As String = ""
        m_objGrid = New WebPages.Template.GenericGrid
        strSQL = "usp_PM_CalculateSLAForHelpDesk_AllRequest_Details " & m_lngEmployeeID.ToString & ",'" & m_strMode & "','" & m_strLogintype & "'," & m_intYear.ToString & ",'" & m_strSortBy & "','" & m_strAscDesc & "'"

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
            Else
                strSQL = strSQL & ",NULL"
            End If
            If m_strDepartment <> "" Then
                strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(m_strDepartment) & "'"
            Else
                strSQL = strSQL & ",NULL"
            End If
            If m_strRequestType <> "" Then
                strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestType) & "'"
            Else
                strSQL = strSQL & ",NULL"
            End If
            If m_strSubRequestType <> "" Then
                strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(m_strSubRequestType) & "'"
            Else
                strSQL = strSQL & ",NULL"
            End If

            If m_strStatus <> "" Then
                strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(m_strStatus) & "'"
            Else
                strSQL = strSQL & ",NULL"
            End If
        Else
            strSQL = strSQL & ",NULL,NULL,NULL,NULL,NULL,NULL"
        End If



        If m_strStatus <> "" Then
            dsGrid = CommonFunctions.Data.GetDataSet(strSQL, "SLA_Details")
            m_intTotalNoOfRows = dsGrid.Tables(0).Rows.Count
        Else
            PagingSQL = strSQL.Replace("usp_PM_CalculateSLAForHelpDesk_AllRequest_Details", "usp_PM_CalculateSLAForHelpDesk_AllRequest_Count")
            m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)
        End If

        If Math.Ceiling(m_intTotalNoOfRows / 20) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        WritePaging()

        If m_strStatus = "" Then
            If m_intPageNumber > 0 Then
                strSQL = strSQL & "," & m_intPageNumber.ToString
            End If
            dsGrid = CommonFunctions.Data.GetDataSet(strSQL, "SLA_Details")
        End If
        'If m_strStatus <> "" Then
        '    WritePaging(strSQL, dsGrid.Tables(0).Rows.Count)
        'Else
        '    WritePaging(strSQL)
        '    If m_intPageNumber > 0 Then
        '        strSQL = strSQL & "," & m_intPageNumber.ToString
        '    End If
        '    dsGrid = CommonFunctions.Data.GetDataSet(strSQL, "SLA_Details")
        'End If

        With m_objGrid

            .NoOfDataColumns = arrUserFriendlyCols.Length
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            '.GroupOnColumn = arrGroupOnColumn
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            '.RowLinkArray = arrLink
            '.CheckBoxIDArray = arrchkbox
            '.PrimaryKey = "QueryID"
            .returnHTML = False
            '.SQL = strSQL
            .UseSQL = True
            .GridDataTable = dsGrid.Tables(0)
            '.CurrentPage = m_intPageNumber
            '.PageSize = 20
            .DIVID = "divGrid"
            .DIVStyle = "overflow:auto;width:100%;"
            '.DIVHeight = 375
            .SortBy = m_strSortBy
            .PageSize = 20
            .CurrentPage = m_intPageNumber
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortOrder = m_strAscDesc
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = "-"
            .DrawGrid()

        End With
        m_objGrid = Nothing
        CommonFunctions.General.WriteHTML("<Table class='clsTable'  WIDTH='99.9%'><TR class=clsTrOdd><td align=Right>Total Records: " & m_intTotalNoOfRows.ToString & " </td></tr></table>")
    End Sub
    Private Sub writeMenu()
        Dim arrMenu() As String = {"Close"}
        Dim arrMenuToolTip() As String = {"Close"}
        Dim arrCSFunction() As String = {"Close_OnClick()"}
        Dim objMenu As New WebPage.Templates.StaticMenu
        objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, False)
    End Sub
    Private Sub PlotHiddenControls()
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthdnSortBy", "txthdnSortBy", , , 100, m_strSortBy, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthdnAscDesc", "txthdnAscDesc", , , 8, m_strAscDesc, IsHidden:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex > 5 Then
            Args.ApplySorting = False
        End If
    End Sub
    Private Sub WritePaging()
        '=====================================================================
        ' Procedure Name        : WritePaging
        ' Description           : To write the paging for the request grid
        ' Purpose               : 
        ' Parameters Passed     : SQL for paging
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             : NitinVS on 26 July 2005 for PSPL 
        '                         Inplace of Paging Search paging is implemented
        '=====================================================================
        Dim ds As DataSet
        Dim intRecordCount As Integer
        'Dim strPaging As String = WebPages.Template.Paging.DrawPaging(m_intPageNumber.ToString, PagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClick", "", True, , , True, 20)
        Dim strPaging As String = ""
        Dim strSectionTag As String = "divGrid"
        Dim strFunctionName As String = "ShowHide_divGrid"

        'If intTotalRecordCount <> 0 Then
        '    m_intTotalNoOfRows = intTotalRecordCount
        'Else
        '    PagingSQL = PagingSQL.Replace("usp_PM_CalculateSLAForHelpDesk_AllRequest_Details", "usp_PM_CalculateSLAForHelpDesk_AllRequest_Count")
        '    m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)
        'End If

        'If Math.Ceiling(m_intTotalNoOfRows / 20) < m_intPageNumber Then
        '    m_intPageNumber = 1
        'End If


        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15

        End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString + ">"

        'End of comment and addition by PrashantD on 24 May 2007 for CleanUp Activity

        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        strPaging += "|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All</B> </A>"
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        '' End Modification By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 Search Paging is Implemented 

        Response.Write(m_objSectionTitle.GetSectionTitle("Requests", strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
        Response.Write("<script language=javascript>" & m_objSectionTitle.ClientsideScript & "</script>")

        m_objSectionTitle = Nothing


    End Sub

End Class
