Imports CommonFunctions
Public Class Alerts_EmployeeSelection
    Inherits WebPages.Template.WhizTemplate

    Private CONST_ADD As String = "ADD"
    Private CONST_EDIT As String = "EDIT"
    Protected CONST_ACTION_SAVE As String = "SAVE"

    Protected m_strWindowTitle As String
    Protected m_strMode As String
    Protected m_strAction As String
    Protected m_strAlphabet As String
    Protected m_strDate As String
    Private m_lngProjectID As Long
    Private m_strDepartment As String
    Private m_strLocation As String
    Private m_strDesignation As String
    '    Private m_blnShowReviewer As Boolean
    '   Private m_blnShowReviewee As Boolean 'Added by SatyanarayanaA on 19-Jan-2006
    Protected m_strReviewStatisticsID As String
    Private m_strEmployeeIDList As String = "" 'Added By SatyanarayanaA 19-Jan-2006
    Private m_strFilter As String
    Private WithEvents objGrid As New WebPage.Templates.GenericGrid
    'Protected WithEvents frmReviewerSelection As System.Web.UI.HtmlControls.HtmlForm
    'Added by MrugajaB on 1st Feb 2006
    Protected m_intReviewee As Integer
    Dim m_blnShowAllEmployeesLink As Boolean
    Protected WithEvents frmCustomerSelection As System.Web.UI.HtmlControls.HtmlForm
    Private m_EmployeeList As String
    'End Addition

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
        'set the window title 
        m_strWindowTitle = "Select Employees"
        If (Request.QueryString("PKToken") <> "" And Request.QueryString("EntryID") <> "" And Request.QueryString("Customers") <> "") Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EntryID"), String) + CType(Request.QueryString("Customers"), String) + "0" + "0", Request.QueryString("PKToken")) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("EntryID"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
    End Sub
    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        'initialize the resource file for send Email page.
        MyBase.InitializeResources("AppResources.Alerts_CustomerSelection", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML body tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	PrashantD
    ' Created				:	May 30, 2007
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strSQL As String
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String
        Dim drEmployee As IDataReader

        'Added by MrugajaB on 20th Feb 2006 for Issue ID.1835
        Dim strReviewstatisticsID As String
        'End Addition

        If MyBase.GetFormValue("txtShowEmployee") = "1" Then
            m_blnShowAllEmployeesLink = True
        End If

        m_strAlphabet = Request.QueryString("Alphabet") + ""
        If m_strAlphabet = "" Then m_strAlphabet = "-1"
        m_strAction = Request.QueryString("Action") + ""
        ' Get the Review ID, and the comma separated list of reviewer IDs.
        ' When this page is called for the first time, retrieve the values from the QueryString collection.
        'If Not IsPostBack Then
        m_strReviewStatisticsID = Request.QueryString("EntryID") + ""
        m_strEmployeeIDList = ""
        m_strEmployeeIDList = MyBase.GetFormValue("txtEmployeeIDList")

        If m_strAction = CONST_ACTION_SAVE Then
            If m_strEmployeeIDList.Chars(0) = CChar(",") Then
                strSQL = "usp_Ins_tbl_PM_FlagforTracking_CustomerFlag_EmployeeList " + CType(Session("intUserID"), String) + ",'" + m_strEmployeeIDList + "'"
            Else
                strSQL = "usp_Ins_tbl_PM_FlagforTracking_CustomerFlag_EmployeeList " + CType(Session("intUserID"), String) + ",'," + m_strEmployeeIDList + "'"
            End If

            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        End If

            'If m_strEmployeeIDList = "" Then
        strSQL = "USP_SEL_TBL_PM_FLAGFORTRACKING_CONFIGURE " & CType(Session("intUserID"), String)
        drEmployee = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drEmployee.Read Then
            m_strEmployeeIDList = drEmployee("EmployeeList").ToString
        End If
        CommonFunctions.Data.DisposeDataReader(drEmployee)
        'End If

        If m_strAction <> "" Then
            'update the database based on the action
            'Call performAction()
        End If

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        MyBase.InitializeResources("AppResources.Alerts_Customerselection", "AppResources")

        arrMenu.Add("Set Employees") : arrMenuToolTip.Add("Set Employees") : arrClientSideFunctions.Add("SetEmployee_OnClick()")

        If m_blnShowAllEmployeesLink = True Then
            arrMenu.Add("Show All Employees") : arrMenuToolTip.Add("Show All Employees") : arrClientSideFunctions.Add("ShowAll_OnClick()")
        Else
            arrMenu.Add("Show Selected Employees") : arrMenuToolTip.Add("Show Selected Employees") : arrClientSideFunctions.Add("ShowEmployee_OnClick()")
        End If
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        If m_intReviewee = 1 Then
            arrClientSideFunctions.Add("Help_OnClick('Select_Customers')")
        Else
            arrClientSideFunctions.Add("Help_OnClick('Select_Customers')")
        End If

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

        strSQL = "usp_Sel_tbl_PM_Employees_PagingAlphabet " + CType(Session("intUserID"), String) + ","

        If m_blnShowAllEmployeesLink Then
            'm_strFilter += "'AND CustomerID IN (0" + m_strEmployeeIDList.Trim + "0)',"
            'm_strFilter += "'AND CustomerID IN (" + m_strEmployeeIDList.Trim + ")',"
            m_strFilter = "'AND CharIndex('','' + CONVERT(VARCHAR,UserName) + '','', '','' + ''" + Replace(m_strEmployeeIDList.Trim, "'", "''''") + "'' + '','' )>0',"

        Else
            m_strFilter += "Null,"
        End If

        strSQL += m_strFilter + "NULL"

        'Added by MrugajaB on 20th Feb 2006 for Issue ID.1835
        'If Request.QueryString("intReviewee") & "" = "1" Then
        strReviewstatisticsID = CType(CommonFunction.Data.CheckIsDBNull(Request.QueryString("EntryID"), "0"), String)

        If strReviewstatisticsID = "" Then strReviewstatisticsID = "0"
        strSQL += "," + strReviewstatisticsID
        'End If
        'End Addition

        Dim strAlpha As String = m_strAlphabet
        If strAlpha.ToUpper = "AND" Then
            strAlpha = "&"
        End If
        If Request.Form("txtFilter") = "" Then
            'display the paging links on the menu bar
            objPaging = New WebPage.Templates.Paging
            strPagingHTML = objPaging.DrawPaging(strAlpha, strSQL, MyBase.GetResourceString("PAGING_SELECT"), "Paging_OnClick", "EmployeeName", True)
            objPaging = Nothing
        Else
            strPagingHTML = ""
        End If

        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, strPagingHTML)
        'draw upper menu
        General.WriteHTML(strMenu)
        General.WriteHTML("<BR>")
        'create lower menu without paging
        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

        'initialize the resource file for Alerts_Customerselection page.
        MyBase.InitializeResources("AppResources.Alerts_Customerselection", "AppResources")

        'draw page caption 
        WebPage.Templates.PageCaption.GetPageCaptions(, "Select Employees")

        General.WriteHTML("<BR>")

        'plot the screen with data
        Call plotReviewerList()

        'plot the lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotReviewerList
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls to show list of resources only and reviewer.
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 16 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotReviewerList()
        Dim strSQL As String
        Dim strCurrentEmpIDList As String
        Dim objdr As IDataReader
        Dim objLink As WebPage.UI.cDynamicLink
        Dim strFilter As String

        'Added by MrugajaB on 11th Feb 2006 for multiple reviewees feature Issue ID.1835
        Dim strReviewstatisticsID As String
        'End Addition

        'get the filter string if spacified
        strFilter = MyBase.GetFormValue("txtFilter", False) + ""

        ''plot the filter textbox
        General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9% >")

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left' width=100% nowrap colspan=3 >" + MyBase.GetResourceString("CAP_SHOW_NAME") + "&nbsp;")   '</TD>")
        '        General.WriteHTML(HTMLControls.DrawTextBox("txtFilter", "txtFilter", , 50, 100, strFilter.Trim, , , , , , , "onkeypress=txtFilter_KeyPress(event)", True))
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txtFilter", "txtFilter", , 50, 100, strFilter.Trim, , , , , , , , True, , , , , , EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'display links
        objLink = New WebPage.UI.cDynamicLink
        objLink.ReturnHTML = True
        objLink.LinkName = MyBase.GetResourceString("LINK_SHOW") + ""
        objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_TOOLTIP") + ""
        objLink.FunctionName = "Show_OnClick()"
        General.WriteHTML(" | <B>" + objLink.GetDynamicLink() + "</B> | ")
        objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR") + ""
        objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP") + ""
        objLink.FunctionName = "Clear_OnClick()"
        General.WriteHTML("<B>" + objLink.GetDynamicLink() + "</B> | ")
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        ' Build the query to retrieve the list of resources based on the filtering criteria selected.
        strSQL = "usp_Sel_tbl_PM_Employee_Selection " + CType(Session("intUserID"), String) + ","

        strSQL += m_strFilter

        If strFilter <> "" Then
            strSQL += "'" + General.BuildQueryString(strFilter.Trim) + "'"
        Else
            strSQL += "'" + General.BuildQueryString(m_strAlphabet.Trim) + "'"
        End If

        'If Request.QueryString("intReviewee") & "" = "1" Then
        strReviewstatisticsID = CType(CommonFunction.Data.CheckIsDBNull(Request.QueryString("EntryID"), "0"), String)

        If strReviewstatisticsID = "" Then strReviewstatisticsID = "0"
        strSQL += "," + strReviewstatisticsID

        Dim arrColHeader() As String = {"Employee Code", "Employee Name", MyBase.GetResourceString("COL_SELECT")}

        Dim arrAN() As String = {"Employee Code", "Employee Name", ""}
        'End Addition

        Dim arrCheckBox() As String = {"", "", "chkSelect"}
        Dim arrCheckBoxCheck() As String = {"", "", ""}
        Dim arrTDStyle() As String = {"align='left'", "align='left'", "align='center'"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'create Grid object and set the properties
        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.CheckBoxIDArray = arrCheckBox
        objGrid.CheckboxCheckOnColumnArray = arrCheckBoxCheck
        objGrid.TDStyleArray = arrTDStyle
        objGrid.PrimaryKey = "CustomerID"
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 300
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = 2
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = strSQL
        objGrid.UseSQL = MyBase.UseSQL
        'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()

        objGrid = Nothing

        If Left(m_strEmployeeIDList, 1) <> "," Then
            m_strEmployeeIDList = "," + m_strEmployeeIDList
        End If

        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txtEmployeeIDList", "txtEmployeeIDList", , , , m_strEmployeeIDList.Trim, , , , , , True, , True, , , , , , EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding

        If m_blnShowAllEmployeesLink = True Then
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtShowEmployee", "txtShowEmployee", , , , "1", , , , , , True, , True, , , , , , EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        Else
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtShowEmployee", "txtShowEmployee", , , , "", , , , , , True, , True, , , , , , EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        End If

    End Sub

    '=====================================================================
    ' Procedure Name(Event)	:	performAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the parent window controls with the updated list od IDs and Names of reviewers                           
    ' Description			:	this procedure will perform the action based on the action specified.
    '                           Here parent window controls are updated with new ID list and Name list for reviewers by
    '                           writing client side script.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 17 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performAction()
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strReviewerNameList As String
        Dim strRevieweeNameList As String
        Dim arrIDList() As String
        Dim strUserName As String

        'get the array of ID List
        Dim i As Integer
        arrIDList = Split(m_strEmployeeIDList, ",")
        For i = 0 To arrIDList.Length - 1
            If arrIDList(i).Trim <> "" Then
                'get the name of the employee
                Call CommonFunction.EmailMessages.GetEmployeeInfo(CType(arrIDList(i).Trim, Long), strUserName, "")

                If strUserName <> "" Then
                    strRevieweeNameList += strUserName + ","
                End If
            End If
        Next

        If Not strRevieweeNameList Is Nothing Then
            ' Remove the last comma from the list of reviewer names.
            strRevieweeNameList = strRevieweeNameList.TrimEnd(","c)
            ' Trim the reviewers list to 500 characters.
            If strRevieweeNameList.Length > 500 Then
                strRevieweeNameList = strRevieweeNameList.Substring(0, 500)
            End If
        Else
            strRevieweeNameList = ""
        End If
        ' Update the parent page Reviewer(s) text box with the new set of reviewers. 
        ' Update the hidden control on the parent page with the concatenated ID list.
        'CommonFunction.General.WriteHTML("<Script language=javascript >")
        'General.WriteHTML("var objNDB12 = GetParentObjectReference('frmCommonPage','NonDatabase12');")
        'General.WriteHTML("objNDB12.value="""";")
        'General.WriteHTML("objNDB12.value=""" + m_strEmployeeIDList.Trim + """;")
        'General.WriteHTML("var objReviewee = GetParentObjectReference('frmCommonPage','Reviewee');")
        'General.WriteHTML("objReviewee.value="""";")
        'General.WriteHTML("objReviewee.value=""" + strRevieweeNameList.Trim + """;")

        CommonFunction.General.WriteHTML("window.close();")

        General.WriteHTML("</Script>")

    End Sub

    '=====================================================================
    ' Procedure Name(Event)	:	objGrid_DataRowTD_BeforePrint
    ' Parameters Passed		:	Cancel - boolean
    '                           Args   - WAF_DataRowID
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the checkbox for the last column 'Select' with the onclick event.                           
    ' Description			:	As it is not possible to set the event handler using the properties of grid class.
    '                           In this event original checkbox is canceled and new check box plotted with event handler.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 17 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        Dim blnChecked As Boolean = False
        Dim strEmpID As String

        If Args.CheckBoxId <> "" Then
            'if EmployeeID present in the list then check the checkbox
            strEmpID = Args.DataReader("UserName").ToString + ""
            'strEmpID = "'" + Args.DataReader("Customer ID").ToString + "" + "'"

            If (m_strEmployeeIDList <> "") Or (Not (m_strEmployeeIDList Is Nothing)) Then
                If m_strEmployeeIDList.IndexOf("," + strEmpID.Trim + ",") <> -1 Then
                    blnChecked = True
                    m_EmployeeList = m_EmployeeList + strEmpID + ","
                End If
            End If
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , blnChecked, strEmpID.Trim, , " onclick=javascript:chkSelect_OnClick(this)", True) + "</td>"
            Cancel = True
        End If

    End Sub

End Class
