Public Class KM_PageListings
    Inherits WebPages.Template.WhizTemplate
#Region "Global Variables"
    Private m_lngUserId As Long = 0
    Private m_lngPostId As Long = 0
    Protected m_lngSpaceID As Long = 0
    Private m_strAction As String = ""
    Private m_strUserName As String = ""
    Private m_intPageNumber As Integer = 1
    Protected m_intTotalNoOfRows As Integer
    Private m_strAlphabet As String = "-1"
    Private m_strAlphaNumericPagingSQL As String
    Private m_strSQL As String = ""
    'Addition by SuchitraP on 25-Aug-2008 to get the Mode when cliked on display link only if that user has Edit Access for that Space
    Protected m_strFromWhere As String
    Protected m_strmode As String = ""
    Protected m_strtxtSearch As String = ""
    Protected m_strPagingNumber As String = ""
    Protected m_strTeamID As String = ""
    Protected m_strActionLink As String
    Protected m_strPrimaryKey As String
    Protected flag As String
    'End of addition by SuchitraP
#End Region

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

        ''commented by nilesh g on 31/12/2015 for Security
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
        ''end of commented by nilesh g on 31/12/2015 for Security
        InitPage()
        PerformAction()
    End Sub
    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag("Pages")
    End Sub
    Private Sub PerformAction()
        Dim strSQL As String
        Dim strPageIDs As String
        If m_strAction.ToUpper = "SELECT" Then
            strPageIDs = Request("chkSelect")
            strSQL = " usp_Ins_tbl_KM_SpacePages " & m_lngSpaceID & ",'" & strPageIDs & "','" & m_strUserName & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Response.Write("<script>window.close();</script>") 'Added by Usha Pandit on 21 Dec 2018 for adding existing articles, as window was getting closed before operation
        End If
    End Sub
    ''Added by Usha Pandit on 17.01.2019 for added space not getting display in spacelist without refresh
    <System.Web.Services.WebMethod>
    Public Shared Function PerformAddition(strAction As String, lngSpaceID As Long, strSelectedIDs As String) As String
        Try
            Dim strSQL As String
            Dim strSpaceIDs As String

        'Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)
        If strAction = "ADDSPACE" Then
            'End Of Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)

            strSQL = " usp_Ins_tbl_KM_SpacePages " & lngSpaceID & ",'" & strSelectedIDs & "','" & HttpContext.Current.Session("strUserName") & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

        End If
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function
    ''End of Added by Usha Pandit on 17.01.2019 for added space not getting display in spacelist without refresh
    Private Sub InitPage()
        Dim strSearchText As String = ""

        m_lngUserId = Session("intUserID")
        m_lngPostId = Session("intPostID")
        m_strUserName = Session("strUserName")
        If Not Request("SpaceID") Is Nothing Then
            m_lngSpaceID = Request("SpaceID")
        Else
            m_lngSpaceID = Request.Form("txthdnSpaceID")
        End If
        If Not Request("Action") Is Nothing Then
            m_strAction = Request("Action")
        End If

        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If

        If Not Request.QueryString("PagingAlphabet") Is Nothing Then
            m_strAlphabet = Request.QueryString("PagingAlphabet")
        Else
            If IsPostBack() = True Then
                m_strAlphabet = CommonFunctions.General.CheckIsNothing(Request("txthdnPagingAlphabet"), "")
            End If
        End If

        If Not Request.Form("txtSearch") Is Nothing Then
            strSearchText = Request.Form("txtSearch").Trim()
            strSearchText = CommonFunctions.General.BuildQueryString(strSearchText)
        End If

        'Addition by SuchitraP on 25-Aug-2008 to get the Mode when cliked on display link only if that user has Edit Access for that Space
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "") <> "" Then
            m_strFromWhere = Request.QueryString("FromWhere")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidFromwhere"), "") <> "" Then
            m_strFromWhere = Request.Form("hidFromwhere")
        End If
        'End of addition by SuchitraP

        If CommonFunction.General.CheckIsNothing(Request.QueryString("txtSearch"), "") <> "" Then
            m_strtxtSearch = Request.QueryString("txtSearch")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtSearch"), "") <> "" Then
            m_strtxtSearch = Request.Form("hidtxtSearch")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("PageNumber"), "") <> "" Then
            m_strPagingNumber = Request.QueryString("PageNumber")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtPageNumber"), "") <> "" Then
            m_strPagingNumber = Request.Form("hidtxtPageNumber")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("ActionLink"), "") <> "" Then
            m_strActionLink = Request.QueryString("ActionLink")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidActionLink"), "") <> "" Then
            m_strActionLink = Request.Form("hidActionLink")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("PrimaryKey"), "") <> "" Then
            m_strPrimaryKey = Request.QueryString("PrimaryKey")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidPrimaryKey"), "") <> "" Then
            m_strPrimaryKey = Request.Form("hidPrimaryKey")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") <> "" Then
            m_strmode = Request.QueryString("Mode")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidMode"), "") <> "" Then
            m_strmode = Request.Form("hidMode")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("TeamID"), "") <> "" Then
            m_strTeamID = Request.QueryString("TeamID")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidTeamID"), "") <> "" Then
            m_strTeamID = Request.Form("hidTeamID").ToString
        End If


        If CommonFunction.General.CheckIsNothing(Request.QueryString("Myflag"), "") <> "" Then
            flag = Request.QueryString("Myflag")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidMyflag"), "") <> "" Then
            flag = Request.Form("hidMyflag")
        End If

        'If Not Request.QueryString("PagingAlphabet") Is Nothing Then
        '    m_strAlphabet = Request.QueryString("PagingAlphabet")
        'Else
        '    If IsPostBack() = True Then
        '        m_strAlphabet = CommonFunctions.General.CheckIsNothing(Request("txtPagingAlphabet"), "")
        '    End If

        'End If

        m_strAlphaNumericPagingSQL = "usp_Sel_tbl_KM_CodeHeadings_ForSpace_Paging " & m_lngUserId.ToString & "," & m_lngSpaceID & ",N'" & strSearchText & "'"

        'm_strAlphaNumericPagingSQL = m_strSQL.Replace("usp_Sel_tbl_KM_CodeHeadings_ForSpace", "usp_Sel_tbl_KM_CodeHeadings_ForSpace_Paging")

    End Sub
    Public Sub WritePage()
        Dim strMenu As String
        strMenu = InitializeMenu()
        Response.Write(strMenu)
        Response.Write("<br>")
        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, "Article Listing", , , True))
        Response.Write("<br>")

        PlotSearchControl()
        PlotList()
        PlotHiddenControls()
        Response.Write(strMenu)
    End Sub
    Private Sub PlotSearchControl()
        Dim sbHTML As New System.Text.StringBuilder
        Dim strSearchText As String = ""
        If Not Request.Form("txtSearch") Is Nothing Then
            strSearchText = Request.Form("txtSearch").Trim()
        End If
        sbHTML.Append("<TABLE id='tblSearch'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTREven valign=middle>")
        sbHTML.Append("<td title='Contains' > Search </td><td>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 200, value:=strSearchText, TobeInserted:="Title='Contains' onkeypress=txtSearch_KeyPress(event)", returnHTML:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 200, value:=strSearchText, ToBeInserted:="Title='Contains' onkeypress=txtSearch_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        sbHTML.Append("</td></tr></Table><br>")
        CommonFunctions.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing
    End Sub
    Private Sub PlotHiddenControls()
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'CommonFunctions.HTMLControls.DrawTextBox("txthdnSpaceID", "txthdnSpaceID", , 200, value:=m_lngSpaceID, IsHidden:=True)
        'CommonFunctions.HTMLControls.DrawTextBox("txthdnPagingAlphabet", "txthdnPagingAlphabet", , 200, value:=m_strAlphabet, IsHidden:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthdnSpaceID", "txthdnSpaceID", , 200, value:=m_lngSpaceID, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthdnPagingAlphabet", "txthdnPagingAlphabet", , 200, value:=m_strAlphabet, IsHidden:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        CommonFunction.General.WriteHTML("<input type=hidden name=hidMode id=hidMode value=" + Request.QueryString("Mode") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidFromwhere id=hidFromwhere value=" + Request.QueryString("Fromwhere") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtSearch id=hidtxtSearch value=" + Request.QueryString("txtSearch") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtPageNumber id=hidtxtPageNumber value=" + Request.QueryString("PageNumber") + ">" + vbCrLf)
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidTeamID' id='hidTeamID' value='" + Request.QueryString("TeamID") + "'>")
        CommonFunction.General.WriteHTML("<input type=hidden name=hidActionLink id=hidActionLink value=" + Request.QueryString("ActionLink") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidMyflag id=hidMyflag value=" + Request.QueryString("MyFlag") + ">" + vbCrLf)
    End Sub
    Private Sub PlotList()
        Dim strSQL As String
        Dim dsPages As DataSet
        Dim blnOddEven As Boolean = False
        Dim strTRClass As String
        Dim strSearchText As String = ""

        Dim intRowStart As Integer = 1
        Dim intRowEnd As Integer = 1
        Dim intGridRecords As Integer
        Dim inCount As Integer

   

        If Not Request.Form("txtSearch") Is Nothing Then
            strSearchText = Request.Form("txtSearch").Trim()
            strSearchText = CommonFunctions.General.BuildQueryString(strSearchText)
        End If

        strSQL = "usp_Sel_tbl_KM_CodeHeadings_ForSpace " & m_lngUserId.ToString & "," & m_lngSpaceID & ",N'" & strSearchText & "','" & m_strAlphabet & "'"

        WritePaging(strSQL)

        If m_intPageNumber > 0 Then
            intRowStart = (m_intPageNumber - 1) * 50 + 1
        End If

        CommonFunctions.General.WriteHTML("<DIV ID=divList style='OVERFLOW:auto;width:100%'>")

        CommonFunctions.General.WriteHTML("<Table ID=tblList width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH  ALIGN='left' WIDTH=90% class='divListTag' >Title</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='left' WIDTH=10% class='divListTag'>Select</TH>")
        CommonFunctions.General.WriteHTML("</THEAD>")

        dsPages = CommonFunctions.Data.GetDataSet(strSQL, "Pages", , , MyBase.UseSQL)
        intRowEnd = dsPages.Tables(0).Rows.Count

        If m_intPageNumber > 0 Then
            intGridRecords = IIf((intRowEnd - intRowStart) > 50, 50, (intRowEnd - intRowStart) + 1)
        Else
            intGridRecords = intRowEnd
        End If


        For inCount = intRowStart To intRowStart + intGridRecords - 1

            'blnOddEven = Not blnOddEven
            'If blnOddEven = True Then
            strTRClass = "clsTREven"
            'Else
            '    strTRClass = "clsTROdd"
            'End If

            CommonFunctions.General.WriteHTML("<Tr class=" & strTRClass & ">")

            'Commented and Added By Bharat T on 30th-Nov-2015 for HTML Encode
            'CommonFunctions.General.WriteHTML("<td WIDTH=90% ALIGN='Left' class=clsTDHoverTest>" & dsPages.Tables(0).Rows(inCount - 1).Item("ProcedureTitle") & "</td>")
            CommonFunctions.General.WriteHTML("<td WIDTH=90% ALIGN='Left' class=clsTDHoverTest>" & HttpUtility.HtmlEncode(dsPages.Tables(0).Rows(inCount - 1).Item("ProcedureTitle")) & "</td>")
            'End of Commented and Added By Bharat T on 30th-Nov-2015 for HTML Encode


            CommonFunctions.General.WriteHTML("<td WIDTH=10% align='Center'>")
            CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", Value:=dsPages.Tables(0).Rows(inCount - 1).Item("ProcedureID"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("</tr>")

        Next
        CommonFunctions.General.WriteHTML("</Table>")

        CommonFunctions.General.WriteHTML("</DIV>")

    End Sub
    Private Sub WritePaging(ByVal PagingSQL As String)
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
        '=====================================================================


        Dim intRecordCount As Integer
        Dim strPaging As String = ""

        PagingSQL = PagingSQL.Replace("usp_Sel_tbl_KM_CodeHeadings_ForSpace", "usp_Sel_tbl_KM_CodeHeadings_ForSpace_Count")

        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)


        If Math.Ceiling(m_intTotalNoOfRows / 50) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            '    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
            'Else
            '    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)

            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                    End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 50)).ToString + ">"

        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 50)).ToString
        strPaging += "|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All<B></A>"
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 50)).ToString, returnhtml:=True, displaynone:=True)
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 50)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding


        If Trim(strPaging & "") <> "" Then
            Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
        End If
    End Sub
    Private Function InitializeMenu() As String
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        Dim strMenu As String = ""
        Dim objMenu As New WebPages.Template.StaticMenu
        Dim objPaging As WebPages.Template.Paging
        Dim strPagingHTML As String


        ArrMenuCaptionsList.Add("Add")
        ArrMenuToolTipsList.Add("Add")
        ArrClientSideFunctionsList.Add("Select_OnClick()")

        ArrMenuCaptionsList.Add("Select All")
        ArrMenuToolTipsList.Add("Select All")
        ArrClientSideFunctionsList.Add("SelectAll_OnClick('frmKMPageList','chkSelect')")

        ArrMenuCaptionsList.Add("Clear All")
        ArrMenuToolTipsList.Add("Clear All")
        ArrClientSideFunctionsList.Add("ClearAll_OnClick('frmKMPageList','chkSelect')")


        ArrMenuCaptionsList.Add("Close")
        ArrMenuToolTipsList.Add("Close")
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        objPaging = New WebPage.Templates.Paging
        strPagingHTML = objPaging.DrawPaging(m_strAlphabet, m_strAlphaNumericPagingSQL, "Page", "AlphaNumericPaging_OnClick", "ProcedureTitle", True)
        objPaging = Nothing

        objMenu = New WebPage.Templates.StaticMenu
        strMenu = objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True, strPagingHTML)
        'strMenu = objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        objMenu = Nothing

        Return strMenu
    End Function
End Class
