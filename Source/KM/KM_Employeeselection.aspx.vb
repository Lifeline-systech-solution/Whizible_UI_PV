Public Class KM_Employeeselection
    Inherits WebPages.Template.WhizTemplate
#Region " Global Variables "
    Private m_strMode As String = "View"
    Private m_strUserIDList As String = ""
    Private m_strLocation As String = ""
    Private m_strDesignation As String = ""
    Private m_strEmpNameFilter As String = ""
    Protected m_strParentformName As String
    Protected m_strParentUsersControl As String
    Protected m_strParentUserIDsControl As String
    Private m_strSQL As String
    Private m_strAlphaNumericPagingSQL As String
    Private m_strAlphabet As String = "-1"
    Private m_intPageNumber As Integer = 1
    Protected m_intTotalNoOfRows As Integer
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
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        InitPage()
    End Sub
    Private Sub InitPage()
        

        Dim strWherClause As String = ""
        If IsPostBack() = False Then
            If Not Request("UsersTextBox") Is Nothing Then
                m_strParentUsersControl = Request("UsersTextBox")
            End If
            If Not Request("UserIDsTextBox") Is Nothing Then
                m_strParentUserIDsControl = Request("UserIDsTextBox")
            End If
            If Not Request("FormName") Is Nothing Then
                m_strParentformName = Request("FormName")
            End If
            If Not Request("UserIDs") Is Nothing Then
                m_strUserIDList = Request("UserIDs")
            End If
        Else
            m_strParentUsersControl = Request("txtUsersTextBox")
            m_strParentUserIDsControl = Request("txtUserIDsTextBox")
            m_strParentformName = Request("txtFormName")
            m_strUserIDList = Request("txtUserIDs")
            m_strLocation = CommonFunctions.General.CheckIsNothing(Request("cboLocation"), "")
            m_strDesignation = CommonFunctions.General.CheckIsNothing(Request("cboDesignation"), "")
            m_strEmpNameFilter = CommonFunctions.General.CheckIsNothing(Request("txtEmployeeName"), "")
            If Not Request.QueryString("PagingAlphabet") Is Nothing Then
                m_strAlphabet = Request.QueryString("PagingAlphabet")
            Else
                m_strAlphabet = CommonFunctions.General.CheckIsNothing(Request("txtPagingAlphabet"), "")
            End If

        End If
        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If

        'Commented by SuchitraP on 3-July-2008
        'm_strSQL = " usp_Sel_tbl_PM_Employee_Selection Null"
        m_strSQL = " usp_Sel_KM_Employee_Selection " + HttpContext.Current.Session("intUserID").ToString + ",Null"
        'End of Comment by SuchitraP on 3-July-2008

        'm_strAlphaNumericPagingSQL = " usp_Sel_tbl_PM_Employee_Selection_Paging Null"
        If m_strLocation.Trim() <> "" Then
            m_strSQL = m_strSQL & "," & m_strLocation
        Else
            m_strSQL = m_strSQL & ",Null"
        End If
        If m_strDesignation.Trim() <> "" Then
            m_strSQL = m_strSQL & "," & m_strDesignation
        Else
            m_strSQL = m_strSQL & ",Null"
        End If
        If m_strEmpNameFilter.Trim() <> "" Then
            strWherClause = m_strEmpNameFilter.Replace("'", "''")
        End If
        m_strSQL = m_strSQL & " ,'" & strWherClause & "'"
        If m_strAlphabet.Trim() <> "" And m_strAlphabet.Trim() <> "-1" Then
            m_strSQL = m_strSQL & ",Null,'" & m_strAlphabet.Replace("'", "''") & "'"
        End If

        'Commented by SuchitraP on 3-July-2008
        'm_strAlphaNumericPagingSQL = m_strSQL.Replace("usp_Sel_tbl_PM_Employee_Selection", "usp_Sel_tbl_PM_Employee_Selection_Paging")
        m_strAlphaNumericPagingSQL = m_strSQL.Replace("usp_Sel_KM_Employee_Selection", "usp_Sel_tbl_PM_Employee_Selection_Paging")
        'End of Comment by SuchitraP on 3-July-2008
    End Sub
    Protected Sub WritePage()
        Dim strMenu As String
        Dim strEditUsers As String = ""
        If IsPostBack() = True Then
            strEditUsers = CommonFunctions.General.CheckIsNothing(Request("txtUsers"), "")
        End If
        strMenu = InitializeMenu()
        Response.Write(strMenu)

        Response.Write("<br>")
        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, "Users Selection", , , True))
        Response.Write("<br>")
        PlotHiddenControls()

        CommonFunctions.General.WriteHTML("<Table CellSpacing=0 class='clsTable' >")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td>Users</td><td>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.HTMLControls.DrawTextArea("txtUsers", "txtUsers", "Users", value:=strEditUsers, widthInPixel:=800, heightInPixel:=50, IsReadonly:=True)
        CommonFunctions.HTMLControls.DrawTextArea("txtUsers", "txtUsers", "Users", value:=strEditUsers, widthInPixel:=800, heightInPixel:=50, IsReadonly:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        CommonFunctions.General.WriteHTML("</td></tr></Table>")

        PlotFilters()
        WritePaging(m_strSQL)
        Response.Write("<br>")
        ' Response.Write("<DIV Id=divList Style='HEIGHT:99.9%;OVERFLOW:auto; WIDTH:100%'>")
        'commented added by Shamkant S on 6 Nov 2015
        Response.Write("<DIV Id=divList Style='OVERFLOW:auto; WIDTH:100%'>")
        PlotList()
        Response.Write("</DIV>")
        Response.Write(strMenu)
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

        'Commented by SuchitraP on 3-July-2008
        'PagingSQL = PagingSQL.Replace("usp_Sel_tbl_PM_Employee_Selection", "usp_Sel_tbl_PM_Employee_SelectionCount")
        PagingSQL = PagingSQL.Replace("usp_Sel_KM_Employee_Selection", "usp_Sel_tbl_PM_Employee_SelectionCount")
        'End if Comment by SuchitraP on 3-July-2008

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
            '    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
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
        ''strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 50)).ToString, returnHTML:=True, DisplayNone:=True)
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 50)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        If Trim(strPaging & "") <> "" Then
            Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
        End If
    End Sub
    Private Sub PlotList()
        Dim strSQL As String
        Dim drEmployee As IDataReader
        Dim dsEmployee As DataSet
        Dim blnOddEven As Boolean = False
        Dim strTRClass As String = "clsTREven"
        Dim strSearchText As String = ""
        'Dim strListHeadCaption As String
        Dim strEditFunctionName As String
        Dim blnSelected As Boolean = False
        Dim strWherClause As String = ""
        Dim intRowStart As Integer = 1
        Dim intRowEnd As Integer = 1
        Dim intGridRecords As Integer
        Dim inCount As Integer

        If m_intPageNumber > 0 Then
            intRowStart = (m_intPageNumber - 1) * 50 + 1
        End If


        m_strUserIDList = "," + m_strUserIDList

        CommonFunctions.General.WriteHTML("<Table ID=tblList width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'  >")

        CommonFunctions.General.WriteHTML("<THEAD class='clsTRColumnHeader'>")


        CommonFunctions.General.WriteHTML("<TH class='divListTag' align=left >Employee Name</TH>")
        CommonFunctions.General.WriteHTML("<TH class='divListTag' align=left>User Name</TH>")

        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' width=10%>Select</TH>")

        CommonFunctions.General.WriteHTML("</THEAD>")

        dsEmployee = CommonFunctions.Data.GetDataSet(m_strSQL, "Employee")

        intRowEnd = dsEmployee.Tables(0).Rows.Count
        If m_intPageNumber > 0 Then
            intGridRecords = IIf((intRowEnd - intRowStart) > 50, 50, (intRowEnd - intRowStart) + 1)
        Else
            intGridRecords = intRowEnd
        End If


        For inCount = intRowStart To intRowStart + intGridRecords - 1

            ''strTRClass = "clsTREven"
            If strTRClass = "clsTROdd" Then
                strTRClass = "clsTREven"
            Else
                strTRClass = "clsTROdd"
            End If

            If m_strUserIDList.IndexOf("," & dsEmployee.Tables(0).Rows(inCount - 1).Item("EmployeeID") & ",") >= 0 Then
                blnSelected = True
            Else
                blnSelected = False
            End If

            CommonFunctions.General.WriteHTML("<Tr class=" & strTRClass & ">")


            CommonFunctions.General.WriteHTML("<td>" & dsEmployee.Tables(0).Rows(inCount - 1).Item("EmployeeName") & "</td>")
            CommonFunctions.General.WriteHTML("<td>" & dsEmployee.Tables(0).Rows(inCount - 1).Item("UserName") & "</td>")

            CommonFunctions.General.WriteHTML("<td WIDTH=10% align=center>")
            CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , blnSelected, value:=CStr(dsEmployee.Tables(0).Rows(inCount - 1).Item("EmployeeID")) + "-->" + dsEmployee.Tables(0).Rows(inCount - 1).Item("UserName"), ToBeInserted:="Onclick=""Checked(" & CStr(dsEmployee.Tables(0).Rows(inCount - 1).Item("EmployeeID")) & ",'" & Replace(CStr(dsEmployee.Tables(0).Rows(inCount - 1).Item("UserName")), "'", "\'") & "',this)""")
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("</tr>")
            'End While
        Next
        'dsEmployee.Tables(1).Rows(1).Item()

        CommonFunctions.General.WriteHTML("</Table>")



    End Sub
    Private Sub PlotFilters()

        Dim strSQL As String

        Response.Write("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9% >")

        Response.Write("<TR class='clsTREven'>")

        Response.Write("<TD align='left' nowrap Title='Contains'  >Employee Name&nbsp;</td>")
        Response.Write("<TD align='left' Title='Contains' nowrap >")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeName", "txtEmployeeName", , 150, 50, m_strEmpNameFilter.Trim, , , , , , , "onkeypress=txtEmp_KeyPress(event)", True))
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeName", "txtEmployeeName", , 150, 50, m_strEmpNameFilter.Trim, , , , , , , "onkeypress=txtEmp_KeyPress(event)", True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'Response.Write("<TR class='clsTREven'>")
        'display location combo
        strSQL = " usp_Sel_PM_LocationList "
        Response.Write("<TD align='right' Title='Equals' nowrap >Location&nbsp;" + "</TD>")
        Response.Write("<TD align='left' Title='Equals' nowrap >")
        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboLocation", strSQL, 150, m_strLocation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")

        'CommonFunction.General.WriteHTML("</TR>")

        'CommonFunction.General.WriteHTML("<TR class='clsTREven'>")


        'display Role combo
        strSQL = " usp_Sel_tbl_PM_Role "
        Response.Write("<TD align='right' Title='Equals' nowrap >Role&nbsp;</TD>")
        Response.Write("<TD align='left' nowrap >")
        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", strSQL, 150, m_strDesignation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        CommonFunction.General.WriteHTML("</TR></Table>")


    End Sub
    Private Sub PlotHiddenControls()

        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtUsersTextBox", "txtUsersTextBox", , , , m_strParentUsersControl.Trim, , , , , , True, , True))
        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtUserIDsTextBox", "txtUserIDsTextBox", , , , m_strParentUserIDsControl.Trim, , , , , , True, , True))
        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtFormName", "txtFormName", , , , m_strParentformName.Trim, , , , , , True, , True))
        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtUserIDs", "txtUserIDs", , , , m_strUserIDList.Trim, , , , , , True, , True))
        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtPagingAlphabet", "txtPagingAlphabet", , , , m_strAlphabet.Trim, , , , , , True, , True))
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtUsersTextBox", "txtUsersTextBox", , , , m_strParentUsersControl.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtUserIDsTextBox", "txtUserIDsTextBox", , , , m_strParentUserIDsControl.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtFormName", "txtFormName", , , , m_strParentformName.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtUserIDs", "txtUserIDs", , , , m_strUserIDList.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtPagingAlphabet", "txtPagingAlphabet", , , , m_strAlphabet.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
    End Sub

    Private Function InitializeMenu() As String
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        Dim strMenu As String = ""
        Dim objMenu As WebPage.Templates.StaticMenu
        Dim objPaging As WebPages.Template.Paging
        Dim strPagingHTML As String

        ArrMenuCaptionsList.Add("Save")
        ArrMenuToolTipsList.Add("SAve")
        ArrClientSideFunctionsList.Add("Select_OnClick()")

        ArrMenuCaptionsList.Add("Select All")
        ArrMenuToolTipsList.Add("Select All")
        ArrClientSideFunctionsList.Add("SelectAll_Click()")

        ArrMenuCaptionsList.Add("Clear All")
        ArrMenuToolTipsList.Add("Clear All")
        ArrClientSideFunctionsList.Add("ClearAll_Click()")

        ArrMenuCaptionsList.Add("Clear All Users")
        ArrMenuToolTipsList.Add("Clear All Users")
        ArrClientSideFunctionsList.Add("Clear_Click()")

        ArrMenuCaptionsList.Add("Close")
        ArrMenuToolTipsList.Add("Close")
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        ArrMenuCaptionsList.Add("?")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("Help_OnClick('RestrictUser')")


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
        strPagingHTML = objPaging.DrawPaging(m_strAlphabet, m_strAlphaNumericPagingSQL, "Select", "AlphaNumericPaging_OnClick", "EmployeeName", True)
        objPaging = Nothing

        objMenu = New WebPage.Templates.StaticMenu
        strMenu = objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True, strPagingHTML)
        objMenu = Nothing

        Return strMenu
    End Function

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag("User List")
    End Sub
End Class
