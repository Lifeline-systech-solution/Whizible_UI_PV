Public Class KM_SpaceListing
    Inherits WebPages.Template.WhizTemplate
#Region "Global Variables"
    Private m_lngUserId As Long = 0
    Private m_lngPostId As Long = 0
    Protected m_lngTeamID As Long = 0
    Private m_strAction As String = ""
    Private m_strUserName As String = ""
    Private m_intPageNumber As Integer = 1
    Protected m_intTotalNoOfRows As Integer
    Private m_strAlphabet As String = "-1"
    Private m_strAlphaNumericPagingSQL As String
    Protected m_strFrom As String
    Protected m_strPKtoken As String = ""
    Protected m_strtxtSearch As String = ""
    Protected m_strPagingNumber As String = ""
    Protected m_strfilter As String = ""
    'Private m_strSQL As String = ""
    Private m_blnValidate As Boolean = True
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
        Dim strSpaceIDs As String
        'Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)
        If m_strAction.ToUpper = "SELECT" Then
            'End Of Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)
            strSpaceIDs = Request("chkSelect")
            strSQL = " usp_Ins_tbl_KM_TeamSpaces " & m_lngTeamID & ",'" & strSpaceIDs & "','" & m_strUserName & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        End If
    End Sub
    ''Added by Usha Pandit on 17.01.2019 for added space not getting display in spacelist without refresh
    <System.Web.Services.WebMethod>
    Public Shared Function PerformAddition(strAction As String, lngTeamID As Long, strSelectedIDs As String) As String
        Try
            Dim strSQL As String
            Dim strSpaceIDs As String

            'Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)
            If strAction = "SELECT" Then
                'End Of Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)

                strSQL = " usp_Ins_tbl_KM_TeamSpaces " & lngTeamID & ",'" & strSelectedIDs & "','" & HttpContext.Current.Session("strUserName") & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

            End If
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Added by Usha Pandit on 17.01.2019 for added space not getting display in spacelist without refresh
    Private Sub InitPage()
        Dim strSearchText As String
        'Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation

        m_strfilter = Request.QueryString("Filter")
        If m_strfilter <> "1" Then
            If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID").ToString <> "0") And Request.QueryString("Action") <> "SAVE" Then
                m_blnValidate = False
            ElseIf Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TeamID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
                m_blnValidate = False
            End If
            If m_blnValidate = False Then
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

        'End Of Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
        m_lngUserId = Session("intUserID")
        m_lngPostId = Session("intPostID")
        m_strUserName = Session("strUserName")
        If Not Request("TeamID") Is Nothing Then
            m_lngTeamID = Request("TeamID")
        Else
            m_lngTeamID = Request.Form("txthdnTeamID")
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

        If Not Request.QueryString("From") Is Nothing Then
            If Request.QueryString("From").ToUpper = "MANAGE" Then
                m_strFrom = Request.QueryString("From")
            Else
                m_strFrom = Request.QueryString("From")
            End If
        Else
            m_strFrom = Request.Form("hidFrom")
        End If
        ''addded by Nilesh g on 19/9/2016 Purpose : PkToken Issue
        m_strPKtoken = CommonFunctions.Security.Token.GetToken(CType(m_lngTeamID, String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
        m_strAlphaNumericPagingSQL = "usp_Sel_tbl_KM_Spaces_ForTeam_Paging " & m_lngUserId.ToString & "," & m_lngTeamID & ",N'" & strSearchText & "'"


    End Sub
    Public Sub WritePage()
        Dim strMenu As String
        strMenu = InitializeMenu()
        Response.Write(strMenu)
        Response.Write("<br>")
        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, "Space Listing", , , True))
        Response.Write("<br>")

        CommonFunctions.General.WriteHTML("<input type=hidden name='hidFrom' id='hidFrom' value='" + m_strFrom + "'>")

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
        ''sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 200, value:=strSearchText, TobeInserted:="Title='Contains' onkeypress=txtSearch_KeyPress(event) ", returnHTML:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 200, value:=strSearchText, ToBeInserted:="Title='Contains' onkeypress=txtSearch_KeyPress(event) ", returnHTML:=True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        sbHTML.Append("</td></tr></Table><br>")
        CommonFunctions.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing
    End Sub
    Private Sub PlotHiddenControls()
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.HTMLControls.DrawTextBox("txthdnTeamID", "txthdnTeamID", , 200, value:=m_lngTeamID, IsHidden:=True)
        ''CommonFunctions.HTMLControls.DrawTextBox("txthdnPagingAlphabet", "txthdnPagingAlphabet", , 200, value:=m_strAlphabet, IsHidden:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthdnTeamID", "txthdnTeamID", , 200, value:=m_lngTeamID, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthdnPagingAlphabet", "txthdnPagingAlphabet", , 200, value:=m_strAlphabet, IsHidden:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtSearch id=hidtxtSearch value=" + Request.QueryString("txtSearch") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtPageNumber id=hidtxtPageNumber value=" + Request.QueryString("PageNumber") + ">" + vbCrLf)
    End Sub
    Private Sub PlotList()
        Dim strSQL As String
        Dim dsSpaces As DataSet
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


        strSQL = "usp_Sel_tbl_KM_Spaces_ForTeam " & m_lngUserId.ToString & "," & m_lngTeamID & ",N'" & strSearchText & "','" & m_strAlphabet & "'"

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
        'drSpaces = CommonFunctions.Data.GetDataReader(strSQL, True)

        dsSpaces = CommonFunctions.Data.GetDataSet(strSQL, "Spaces", , , MyBase.UseSQL)
        intRowEnd = dsSpaces.Tables(0).Rows.Count

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
            ' CommonFunctions.General.WriteHTML("<td WIDTH=90% ALIGN='Left' class=clsTDHoverTest>" & dsSpaces.Tables(0).Rows(inCount - 1).Item("SpaceName")) & "</td>"
            'Commented added by Shamkant S on 24 Nov 2015
            CommonFunctions.General.WriteHTML("<td WIDTH=90% ALIGN='Left' class=clsTDHoverTest>" & HttpUtility.HtmlEncode(dsSpaces.Tables(0).Rows(inCount - 1).Item("SpaceName")) & "</td>")
            'Commented ended by Shamkant S on 24 Nov 2015


            CommonFunctions.General.WriteHTML("<td WIDTH=10% align='Center'>")
            CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", Value:=dsSpaces.Tables(0).Rows(inCount - 1).Item("SpaceID"))
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

        PagingSQL = PagingSQL.Replace("usp_Sel_tbl_KM_Spaces_ForTeam", "usp_Sel_tbl_KM_Spaces_ForTeam_Count")

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
            '' strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
            ''        Else
            ''strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
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
        ArrClientSideFunctionsList.Add("SelectAll_OnClick('frmKMSpaceList','chkSelect')")

        ArrMenuCaptionsList.Add("Clear All")
        ArrMenuToolTipsList.Add("Clear All")
        ArrClientSideFunctionsList.Add("ClearAll_OnClick('frmKMSpaceList','chkSelect')")

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
        strPagingHTML = objPaging.DrawPaging(m_strAlphabet, m_strAlphaNumericPagingSQL, "Select", "AlphaNumericPaging_OnClick", "SpaceName", True)
        objPaging = Nothing


        objMenu = New WebPage.Templates.StaticMenu
        'strMenu = objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        strMenu = objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True, strPagingHTML)
        objMenu = Nothing

        Return strMenu
    End Function
End Class
