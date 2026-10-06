Imports CommonFunctions


Public Class IB_QueryBuilder
    Inherits WebPages.Template.WhizTemplate

    Protected CONST_QUERY_WIZ As String = "QUERYWIZ"
    Protected CONST_EXECUTE As String = "QUERYEXEC"
    Protected CONST_QUERY_DETAILS As String = "QUERYDETAIL"
    Protected CONST_ACTION_DELETE As String = "DEL"
    Protected CONST_ACTION_EXECUTE As String = "EXEC"
    Protected CONST_ACTION_SETDEFAULT As String = "SETDEF"
    Protected CONST_ACTION_SAVE As String = "SAVE"
    Protected CONST_ACTION_APPLY As String = "APPLY"
    Private CONST_USER_ADMINID As Long = 7
    'Added by tejal D Purpose PKToken on 11/8/2016
    'Private m_blnValidate As Boolean
    Protected m_strMode As String
    Protected m_strAlphabet As String
    Protected m_strWindowTitle As String
    Protected m_arrQueryName(0) As String
    Protected m_lngQueryID As Long
    Protected m_intCnt As Integer
    Protected m_strIsValidQuery As String = "YES"
    Private m_strAction As String
    Private m_lngProjectID As Long
    Private m_lngUserID As Long
    Private m_strLoginType As String
    Private m_lngRoleID As Long
    Private m_strQueryName As String
    Private m_blnValidate As Boolean = True
    Private WithEvents objGrid As WebPage.Templates.GenericGrid
    'Added by SandeepA on 6 Dec,2005 for Editable Date Control Issue.
    Public m_intEditableDateControl As Int16 = 0
    'End of addition by SandeepA on 6 Dec,2005 for Editable Date Control Issue.
    'Added By VarunA on 12-July-2007 Whizible Development & Release
    Dim m_strDefaultQueryID As String = ""
    'End By VarunA on 12-July-2007
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
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_QUERY_WIZ")

        'Added By SandeepA on 6 Oct,2005 for Editable Date Control Issue
        If CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled") = True Then
            m_intEditableDateControl = 1
        Else
            m_intEditableDateControl = 0
        End If
        'End of Addition By SandeepA on 6 Oct,2005 for Editable Date Control Issue


    End Sub

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.IB_QueryBuilder", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 31 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String
        Dim arrlstQueryName As Collections.ArrayList
        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_QUERY_WIZ 'default mode 
        m_strAlphabet = Request.QueryString("Alphabet") + ""
        If m_strAlphabet = "" Then m_strAlphabet = "-1"
        m_strAction = Request.QueryString("Action") + ""
        If Request.QueryString("QueryID") <> "" Then m_lngQueryID = CType(Request.QueryString("QueryID"), Long)

        ''Added by Dhanashri S on 17 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
        If (m_strAction <> "SAVE" And m_strAction <> "APPLY") Then
            ''End of addition by Dhanashri S on 17 Aug 2016 
            ''Added by Yogesh J on on 29-Jan-2016 to validate Token

            ''If Request.QueryString("QueryID") <> "" And Request.QueryString("PKToken") = "" Then
            If (Request.QueryString("QueryID") <> "") Then

                If (((Request.QueryString("PKToken") = "") And (Session("intUserID") <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("QueryID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False)) Then

                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Query Builder", 0, 0, "QueryID", CType(Request.QueryString("QueryID"), String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If


            End If
        End If


        'If (m_strAction <> "SAVE") Then
        '    If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
        '        m_blnValidate = False
        '    ElseIf (m_lngQueryID <> 0 And HttpContext.Current.Session("intUserID")) Then

        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("QueryID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
        '            m_blnValidate = False
        '        End If

        '    End If


        '    If (m_blnValidate = False) Then
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If


        ''End of addition by Yogesh J on on 29-Jan-2016 to validate Token
        'commented by AniruddhaD on 18 Nov 2005 for Providing projects combo on issue list page(IssueID:685).
        'm_lngProjectID = CType(Session("intProjectID"), Long)

        'Added by AniruddhaD on 18 Nov 2005 for Providing projects combo on issue list page(IssueID:685).
        m_lngProjectID = CType(Session("IssueProject"), Long)
        'Commented And Added By Chakshuta H on 23rd-Aug-2016 Purpose::Qa issue fixing
        'm_strLoginType = Session("LoginType").ToString
        m_strLoginType = CType(Session("LoginType"), String)
        If m_strLoginType Is Nothing Then
            m_strLoginType = ""
        End If
        If m_lngProjectID = 0 And m_strLoginType = "" And m_strMode = "QUERYWIZ" Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End Of Commented And Added By Chakshuta H on 23rd-Aug-2016 Purpose::Qa issue fixing

        m_lngUserID = CType(Session("intUserID"), Long)
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        m_lngRoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_lngProjectID, String) & "," & CType(m_lngUserID, String), MyBase.UseSQL), "0"), Long)
        'm_lngRoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_lngProjectID, String) & " And EmployeeID=" & CType(m_lngUserID, String), MyBase.UseSQL), "0"), Long)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        If Not m_lngRoleID > 0 Then
            m_lngRoleID = CType(Session("intPostID"), Long)
        End If
        'added by SandipL on 8 Feb 2006 to show current Project Name as right PageCaption
        Dim strProjectName As String
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(m_lngProjectID, String), True), String)
        strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectNameID " + CType(m_lngProjectID, String), True), String)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        'End addition by SandipL
        'TODO: get fromthe session or querystring, hardcoded for testing
        'm_lngProjectID = 268
        'm_lngUserID = 7
        'm_strLoginType = "E"


        Select Case m_strMode
            Case CONST_QUERY_WIZ

                If m_strAction <> "" Then
                    Call performQueryWizAction(m_lngQueryID)
                End If
                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add(MyBase.GetResourceString("MENU_ADDNEW")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP")) : arrClientSideFunctions.Add("AddNew_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_EXECUTE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_EXECUTE_TOOLTIP")) : arrClientSideFunctions.Add("ExecuteQuery_OnClick()")
                'if the user is Admin then only show the Delete and select All link
                'Isssue No 11367
                'Modified by SachinR    on 05 Jun 2004
                'purpose    to remove the condition and apply delete to admin for all the queries and 
                'others to only myqueries
                'If m_lngRoleID = CommonFunctions.Constants.ROLE_ADMINISTRATOR Then
                arrMenu.Add(MyBase.GetResourceString("MENU_DELETE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP")) : arrClientSideFunctions.Add("Delete_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_SELECTALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")) : arrClientSideFunctions.Add("SelectAll_OnClick()")
                ''Added By Vaijat K ON 4/11/2015 Purpose: Clear all link
                arrMenu.Add(MyBase.GetResourceString("MENU_CLEARALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP")) : arrClientSideFunctions.Add("ClearAll_OnClick('frmQueryBuilder','chkDelete')")
                'End If
                'end modification
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('IB_QUERY')")

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

                'initialize the resource file for SDLC_Process page.
                MyBase.InitializeResources("AppResources.IB_QueryBuilder", "AppResources")

                'display the paging links on the menu bar
                objPaging = New WebPage.Templates.Paging
                strSQL = "Usp_Sel_tbl_IB_Query -1," + m_lngProjectID.ToString + "," + m_lngUserID.ToString + ",'','" + m_strLoginType.Trim + "'"
                'Added by PrashantD on 3 April 2007 for IssueId 11524
                If m_strAlphabet = "AND" Then
                    m_strAlphabet = "&"
                ElseIf m_strAlphabet = "HASH" Then
                    m_strAlphabet = "#"
                End If
                'End of addition by PrashantD for IssueID 11524

                strPagingHTML = objPaging.DrawPaging(m_strAlphabet, strSQL, MyBase.GetResourceString("PAGING_SELECT"), "Paging_OnClick", "Links", True)
                objPaging = Nothing

                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, strPagingHTML)

                'draw upper menu
                General.WriteHTML(strMenu)
                'create lower menu without paging links 
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                'draw page caption 
                'Modified by SandipL on 8 Feb 2006 -- added rightCaption for Project
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_QUERY_WIZ"), "Project: " & strProjectName)
                'end Modification by SandipL on 8 Feb 2006
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_QUERY_WIZ") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the controls 
                Call plotScreenForQueryWizard()

            Case CONST_QUERY_DETAILS

                If m_strAction <> "" Then
                    Call performQueryDetailAction(m_lngQueryID)
                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add(MyBase.GetResourceString("MENU_APPLY_WITHOUT_SAVING")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_APPLY_WITHOUT_SAVING_TOOLTIP")) : arrClientSideFunctions.Add("Apply_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("QuerySave_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_BACK")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP")) : arrClientSideFunctions.Add("Back_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('IB_QUERY')")

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
                'draw upper menu
                General.WriteHTML(strMenu)

                'initialize the resource file for SDLC_Process page.
                MyBase.InitializeResources("AppResources.IB_QueryBuilder", "AppResources")

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {MyBase.GetResourceString("LEGEND_CUSTOM_FIELD"), "Mandatory"}
                Dim strarrLegendImage() As String = {"", "<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                'draw page caption 
                If m_lngQueryID > 0 Then
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_QUERY_DETAILS"), MyBase.GetResourceString("CAP_QUERY_ID") + " : " + m_lngQueryID.ToString)
                Else
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_QUERY_DETAILS"), MyBase.GetResourceString("CAP_QUERY_ID") + " : " + MyBase.GetResourceString("MSG_NO_QUERYID"))
                End If
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_QUERY_DETAILS") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the controls 
                Call plotScreenForQueryDetails(m_lngQueryID)

                'fill the array with query names to check it at client side
                arrlstQueryName = New Collections.ArrayList
                strSQL = "Usp_Sel_tbl_IB_Query NULL," + m_lngProjectID.ToString + "," + m_lngUserID.ToString + ",'','" + m_strLoginType.Trim + "'"
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                While objDR.Read
                    If Not IsDBNull(objDR("QueryName")) Then
                        If m_strQueryName.Trim <> objDR("QueryName").ToString.Trim Then
                            arrlstQueryName.Add(objDR("QueryName").ToString.Trim)
                        End If
                    End If
                End While
                objDR.Close()
                objDR.Dispose()
                objDR = Nothing
                'copy the array from array list to string array
                ReDim m_arrQueryName(arrlstQueryName.Count)
                arrlstQueryName.CopyTo(m_arrQueryName)
                arrlstQueryName = Nothing
            Case Else
        End Select

        'plot the lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotScreenForQueryWizard
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls and grid for the query list on the page
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 3 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenForQueryWizard()
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strQueryID As String
        Dim strViewID As String
        Dim objLink As WebPage.UI.cDynamicLink
        Dim arrlstColHeader As Collections.ArrayList
        Dim arrlstAN As Collections.ArrayList
        Dim arrlstRowLink As Collections.ArrayList
        Dim arrlstRowLinkEnable As Collections.ArrayList
        Dim arrlstCheckBox As Collections.ArrayList

        'get the selected query id and view id, not for the first time
        strQueryID = MyBase.GetFormValue("cboQuery") + ""
        strViewID = MyBase.GetFormValue("cboView") + ""

        'plot the combo for query and view
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<Table width=99.9% cellspacing=0 cellpadding=0 class='clsTable'>")
        General.WriteHTML("<TR class='clsTREven'>")

        'Query to populate the Use Query Combo
        General.WriteHTML("<TD>" + MyBase.GetResourceString("CAP_USE_QUERY") + "&nbsp;")
        strSQL = "Exec Usp_Sel_tbl_IB_Query Null," + m_lngProjectID.ToString + "," + m_lngUserID.ToString + ",'','" + m_strLoginType.Trim + "','A'"
        General.WriteHTML(HTMLControls.DrawComboBox("cboQuery", strSQL, 200, strQueryID.Trim, , False, True, , True))
        General.WriteHTML("</TD>")

        'Query to populate the Use Query Combo
        General.WriteHTML("<TD>" + MyBase.GetResourceString("CAP_USE_VIEW") + "&nbsp;")
        strSQL = "Exec usp_Sel_tbl_IB_Project_Views " + m_lngProjectID.ToString + ",'" + m_strLoginType.Trim + "'," + m_lngUserID.ToString + ", NULL, 4, '-1'"
        General.WriteHTML(HTMLControls.DrawComboBox("cboView", strSQL, 200, strViewID.Trim, , False, True, , True))
        General.WriteHTML("</TD>")

        'display the execute link
        objLink = New WebPage.UI.cDynamicLink
        objLink.FunctionName = "Execute_OnClick()"
        objLink.LinkName = MyBase.GetResourceString("LINK_EXECUTE") + ""
        objLink.ReturnHTML = True
        objLink.Tooltip = MyBase.GetResourceString("LINK_EXECUTE_TOOLTIP") + ""
        General.WriteHTML("<TD align='middle'>" + objLink.GetDynamicLink() + "</TD>")
        objLink = Nothing

        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        arrlstColHeader = New Collections.ArrayList
        arrlstAN = New Collections.ArrayList
        arrlstRowLink = New Collections.ArrayList
        arrlstRowLinkEnable = New Collections.ArrayList
        arrlstCheckBox = New Collections.ArrayList

        arrlstColHeader.Add("") : arrlstColHeader.Add(MyBase.GetResourceString("COL_QUERY_ID")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_QUERY_NAME")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_CREATED_ON")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_QUERY")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_SET_DEFAULT"))
        arrlstAN.Add("GroupName") : arrlstAN.Add("QueryID") : arrlstAN.Add("QueryName") : arrlstAN.Add("CreatedDate") : arrlstAN.Add("QueryText") : arrlstAN.Add(MyBase.GetResourceString("COL_SET_DEFAULT_LINK"))
        arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("Query_OnClick(QueryID)") : arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("SetDefault_OnClick(QueryID)")
        arrlstRowLinkEnable.Add("") : arrlstRowLinkEnable.Add("") : arrlstRowLinkEnable.Add("MyQuery") : arrlstRowLinkEnable.Add("") : arrlstRowLinkEnable.Add("") : arrlstRowLinkEnable.Add("")
        arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("")

        Dim arrGroup() As String = {"1"}

        'Isssue No 11367
        'Modified by SachinR    on 05 Jun 2004
        'purpose    to remove the condition and apply delete to admin for all the queries and 
        'others to only myqueries
        'If m_lngRoleID = CommonFunctions.Constants.ROLE_ADMINISTRATOR Then
        arrlstColHeader.Add(MyBase.GetResourceString("COL_DELETE"))
        arrlstAN.Add("")
        arrlstRowLink.Add("")
        arrlstRowLinkEnable.Add("")
        arrlstCheckBox.Add("chkDelete")
        'End If
        'end modification
        arrlstColHeader.Add(MyBase.GetResourceString("COL_EXECUTE"))
        arrlstAN.Add("")
        arrlstRowLink.Add("")
        arrlstRowLinkEnable.Add("")
        arrlstCheckBox.Add("chkExecute")

        Dim arrColHeader(arrlstColHeader.Count) As String
        Dim arrAN(arrlstAN.Count) As String
        Dim arrRowLink(arrlstRowLink.Count) As String
        Dim arrRowLinkEnable(arrlstRowLinkEnable.Count) As String
        Dim arrCheckBox(arrlstCheckBox.Count) As String

        arrlstColHeader.CopyTo(arrColHeader)
        arrlstAN.CopyTo(arrAN)
        arrlstRowLink.CopyTo(arrRowLink)
        arrlstRowLinkEnable.CopyTo(arrRowLinkEnable)
        arrlstCheckBox.CopyTo(arrCheckBox)

        arrlstColHeader = Nothing
        arrlstAN = Nothing
        arrlstRowLink = Nothing
        arrlstRowLinkEnable = Nothing
        arrlstCheckBox = Nothing

        'plot the grid for the query list

        'create the SP for grid data without sorting 
        strSQL = "Exec usp_Sel_tbl_IB_Query_QueryBuilder " + m_lngUserID.ToString + "," + m_lngProjectID.ToString + ",'" + General.BuildQueryString(m_strAlphabet.Trim) + "','" + m_strLoginType.Trim + "'"

        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid

        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.RowLinkArray = arrRowLink
        objGrid.RowLinkEnableOnColumn = arrRowLinkEnable
        objGrid.CheckBoxIDArray = arrCheckBox
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.GroupOnColumn = arrGroup
        objGrid.PrimaryKey = "QueryID"
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 400
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = 5
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = strSQL
        objGrid.UseSQL = MyBase.UseSQL

        'plot the grid 
        objGrid.DrawGrid()

        'get the total no of rows plotted and store it in the hidden textbox
        Dim i As Integer = 0
        i = objGrid.NoOfRows
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("hdtxtRowCount", "hdtxtRowCount", , , , i.ToString, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        objGrid = Nothing

    End Sub

    Private Sub objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
        End If
    End Sub

    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        'Added By VarunA on 12-July-2007 Whizible Development & Release
        'Purpose : To have the Query Name as blue in color
        If m_strDefaultQueryID = "" Then
            m_strDefaultQueryID = CType(Args.DataReader("DefaultQueryID").ToString(), String)
        End If
        'End By VarunA on 12-July-2007 Whizible Development & Release
        If Args.ColumnName = MyBase.GetResourceString("COL_QUERY_NAME") Then
            Args.EnableLink = True
            Dim a As String = Args.DataReader("MyQuery").ToString
            'added By   SachinR     On 05 Jun 2004
            'purpose    To apply delete to all users.Admin can delete all the queries
            '           Other user can delete only My queries
        ElseIf Args.ColumnName = MyBase.GetResourceString("COL_DELETE") Then
            If m_lngRoleID <> CommonFunctions.Constants.ROLE_ADMINISTRATOR Then
                If m_lngUserID <> CType(Data.CheckIsDBNull(Args.DataReader("EmployeeID").ToString, "0"), Long) Then
                    Args.IsCheckBoxDisabled = True
                End If
            End If
            'end addition
        End If
        If Args.DataReader("QueryID").ToString = m_strDefaultQueryID Then
            Args.TDStyle += "style = 'color:Blue'"
            Select Case Args.ColIndex
                Case 1
                    Args.StringToBeInserted = "<TD  vAlign=top align=right style='color:Blue' title=""Query ID"">" + Args.DataReader("QueryID").ToString + "</td>"
                    Cancel = True
                Case 2

                    Args.StringToBeInserted = "<TD  vAlign=top  title=""Query Name""><A style = 'color:Blue' href=""JavaScript:Query_OnClick('" + Args.DataReader("QueryID").ToString + "')"">" + Args.DataReader("QueryName").ToString + "</A></TD>"
                    Cancel = True
                Case 5
                    Args.StringToBeInserted = "<TD align=left ><A style = 'color:Blue' href=""JavaScript:SetDefault_OnClick('" + Args.DataReader("QueryID").ToString + "')"">Set As Default</A></TD>"
                    Cancel = True

            End Select
        End If
        'Added By VarunA on 12-July-2007 Whizible Development & Release 7.0
        'Purpose : Not to have link for Other Views in View List
        If Args.DataReader("GROUPNAME").ToString().ToUpper = "OTHER QUERIES" Then
            Select Case Args.ColIndex
                Case 2
                    If Args.DataReader("QueryID").ToString = m_strDefaultQueryID Then
                        Args.StringToBeInserted = "<TD  vAlign=top  title=""Query Name""><Font color='Blue'>" + Args.DataReader("QueryName").ToString + "</TD>"
                    Else
                        Args.StringToBeInserted = "<TD  vAlign=top  title=""Query Name"">" + Args.DataReader("QueryName").ToString + "</TD>"
                    End If
                    Cancel = True
            End Select
        End If
        'End By VarunA on 12-July-2007

    End Sub


    '=====================================================================
    ' Procedure Name		:	performQueryWizAction
    ' Parameters Passed		:	lngQueryID - Long 
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the database based on the action given
    ' Description			:	This procedure will update the database for queryid passed as paramter
    '                           based on the action given.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 3 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performQueryWizAction(ByVal lngQueryID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strDeleteQueryIdList As String
        Dim strQueryID As String
        Dim strViewID As String

        Select Case m_strAction
            Case CONST_ACTION_SETDEFAULT

                strSQL = "Exec usp_Upd_IB_SetDefaultQuery " + m_lngProjectID.ToString + ",'" + m_strLoginType.Trim + "'," + m_lngUserID.ToString

                If m_lngQueryID > 0 Then
                    strSQL += "," + lngQueryID.ToString
                Else
                    strSQL += ",NULL"
                End If
                'update the database for making the query as default query
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            Case CONST_ACTION_DELETE

                'get the list of the query id's to be deleted
                strDeleteQueryIdList = MyBase.GetFormValue("chkDelete") + ""

                If strDeleteQueryIdList <> "" Then
                    strSQL = "Usp_Del_tbl_IB_Query '" + strDeleteQueryIdList.Trim + "'"

                    'delete the selected queries
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If

            Case CONST_ACTION_EXECUTE
                'get the selected queryid and view id
                strQueryID = MyBase.GetFormValue("cboQuery") + ""
                strViewID = MyBase.GetFormValue("cboView") + ""

                'set the default query and view for the session and refresh the parent
                If strQueryID <> "" Then
                    Session("intQueryID") = strQueryID.Trim
                    Session("UnsavedQuery") = ""
                Else
                    Session("intQueryID") = ""
                End If

                If strViewID <> "" Then
                    Session("intViewID") = strViewID.Trim
                Else
                    Session("intViewID") = ""
                End If

                'Commnet by PrashantD on 13 March 2007 for IssueID 11573
                'write client side script to refresh parent
                ''General.WriteHTML("<script language=javascript>")
                ''General.WriteHTML("try{")
                ''General.WriteHTML("opener.location.href='IBIssueList.aspx?cboQuery=" + strQueryID.Trim + "';")
                ''General.WriteHTML("} catch(e){ }")
                ''General.WriteHTML("</Script>")
                'End of Commnet by PrashantD on 13 March 2007 for IssueID 11573

            Case Else

        End Select

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotScreenForQueryDetails
    ' Parameters Passed		:	lngQueryID - Long 
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the screen for editing the query in Query Detail mode.
    ' Description			:	same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 4 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenForQueryDetails(ByVal lngQueryID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strFieldName As String
        Dim objLink As WebPage.UI.cDynamicLink
        Dim strField As String
        Dim strOperator As String
        Dim strValue As String
        Dim strQueryText As String

        'get the details of the query
        m_strQueryName = ""
        strField = ""
        strQueryText = ""
        If lngQueryID > 0 Then
            strSQL = "Usp_Sel_tbl_IB_Query " + lngQueryID.ToString
            objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDR.Read Then
                If Not IsDBNull(objDR("QueryName")) Then
                    m_strQueryName = objDR("QueryName").ToString + ""
                End If
                If Not IsDBNull(objDR("QueryText")) Then
                    strQueryText = objDR("QueryText").ToString + ""
                End If
            End If
            objDR.Close()
            objDR.Dispose()
            objDR = Nothing
        End If

        'plot the controls
        General.WriteHTML("<Div id='DivList' width=100% style='Overflow: auto;' height=90%>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0 >")

        'display query name
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='left' >" + MyBase.GetResourceString("CAP_QUERY_NAME") + "&nbsp;</TD>")
        General.WriteHTML("<TD colspan=4 align='left'>")

        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txtQueryName", "txtQueryName", , 500, 100, m_strQueryName.Trim, , , , , , , , True, True, EnableHTMLEncode:=True) + "</TD>")
        'ended by Yogesh J for HTML encoding Date:07/10/15
        General.WriteHTML("<TD>&nbsp;</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("<TR class='clsTREven'>")
        'display field
        General.WriteHTML("<TD align='left' >" + MyBase.GetResourceString("CAP_FIELD") + "&nbsp;</TD>")
        'Modified by Harshk for sp4 issueid 539
        strSQL = "Exec usp_Sel_tbl_IB_Issue_GetFieldList_InOrder " + m_lngProjectID.ToString + "," + m_lngRoleID.ToString + ",1," + m_lngUserID.ToString
        'End Modified by Harshk for sp4 issueid 539
        General.WriteHTML("<TD align='left' >")
        General.WriteHTML(HTMLControls.DrawComboBox("cboField", strSQL, 150, , " onchange='javascript:Field_OnChange()'", True, True) + "</TD>")

        'display operator
        General.WriteHTML("<TD align='left' >" + MyBase.GetResourceString("CAP_OPERATOR") + "&nbsp;")
        strSQL = "usp_sel_queryBuilder_Operator"
        General.WriteHTML(HTMLControls.DrawComboBox("cboOperator", strSQL, 100, , , True, True) + "</TD>")

        'display value textbox
        General.WriteHTML("<TD align='left' >" + MyBase.GetResourceString("CAP_VALUE") + "&nbsp;</TD>")
        General.WriteHTML("<TD id='TDFieldValue' align='left' >")

        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txtValue", "txtValue", , 100, 100, , , , , , , , , True, EnableHTMLEncode:=True) + "&nbsp;</TD>")
        'ended by Yogesh J for HTML encoding Date:07/10/15
        '*************************************************************************************************
        'plot the dynamic controls for each field and hide them
        'General.WriteHTML("<TD style='Display: none'>")
        strSQL = "Exec Usp_Sel_IB_Project_Resources " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboAssignTo", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_IB_Project_Resources " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboCodedBy", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_IB_ReportedBy " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboReportedBy", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_IB_Project_Version " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboCorrectedInVersion", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_IB_Project_Version " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboReportedInVersion", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboPhase", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboFixedInPhase", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboFoundInPhase", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_PM_ProjectHardware " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboHardware", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_IB_Project_Kernels " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboKernels", strSQL, 100, , , True, , , , , True)
        ' Added By MahendraV On 11:09 AM 5/21/2007
        ' IssueID : 13360,Modules: Closed Modules are not displayed in the Query of Issue Base.
        ' strSQL = "Exec Usp_Sel_tbl_PM_Module_ProjectGroup " + m_lngProjectID.ToString
        ' Start_MV_5/21/2007
        strSQL = "Exec usp_Sel_tbl_PM_Module_Filter_And_Query " + m_lngProjectID.ToString

        ' End_MV_5/21/2007
        CommonFunction.HTMLControls.DrawComboBox("cboModuleName", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_IB_Project_OS " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboOs", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_IB_Project_Priorities " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboPriority", strSQL, 100, , , True, , , , , True)

        'Code Commented By DipaliS on 25 June 2004 and added following
        'strSQL = "Exec Usp_Sel_tbl_IB_Project_Sub_Type_TYPE " + m_lngProjectID.ToString

        '*********Code Added*********
        'By     :   DipaliS
        'Reason :   Apply Role Level Security
        'Date   :   25 June 2004
        'Requirement No.:IB_PBN_ENT_01
        'Changes Made: Added One More parameter RoleID to the SP that fetches the Types  
        strSQL = "Exec Usp_Sel_tbl_IB_Project_Sub_Type_TYPE " + m_lngProjectID.ToString + "," + m_lngRoleID.ToString
        '*********End Addition*********

        CommonFunction.HTMLControls.DrawComboBox("cboType", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_IB_Project_Sub_Type_SUB_TYPE " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboSubtype", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_IB_Project_Severity " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboSeverity", strSQL, 100, , , True, , , , , True)

        'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
        'Code Added By PradipK on 15 Feb 2006
        strSQL = "Exec usp_Sel_tbl_IB_Project_Complexity " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboComplexity", strSQL, 100, , , True, , , , , True)
        'End Addtion By PradipK on 15 Feb 2006

        'Code Commented By DipaliS on 28 June 2004 and added following
        'strSQL = "Exec usp_Sel_tbl_IB_Project_Type_Status_Status " + m_lngProjectID.ToString

        '*********Code Added*********
        'By     :   DipaliS
        'Reason :   Apply Role Level Security
        'Date   :   28 June 2004
        'Requirement No.:IB_PBN_ENT_01
        'Changes Made: Added One More parameter RoleID to the SP that fetches the Status
        strSQL = "Exec usp_Sel_tbl_IB_Project_Type_Status_Status " + m_lngProjectID.ToString + "," + m_lngRoleID.ToString
        '*********End Addition*********

        CommonFunction.HTMLControls.DrawComboBox("cboStatus", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec usp_Sel_tbl_IB_Project_Keywords " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboKeywords", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec usp_Sel_QueryBuilder_YesNo"
        CommonFunction.HTMLControls.DrawComboBox("cboShowToCustomer", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec usp_Sel_tbl_IB_GetListOfSharedProjects_ProjectName " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboProject", strSQL, 100, , , True, , , , , True)

        'added By SachinR   on 19 Jul 2004
        'Issue - 12018
        'purpose :  To plot the combobox for RootCause and ServiceRequest field
        strSQL = "usp_sel_tbl_IB_Project_RootCause_QueryBuilder " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboRootCause", strSQL, 100, , , True, , , , , True)
        'addition end


        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunction.HTMLControls.DrawTextBox("txtCustomerIssueID", "txtCustomerIssueID", , 100, 100, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtDescription", "txtDescription", , 100, 100, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtImportID", "txtImportID", , 100, 30, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtIsuueID", "txtIsuueID", , 100, 9, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtChangeRequestID", "txtChangeRequestID", , 100, 9, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtSummary", "txtSummary", , 100, 200, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        '****Code Added***************************************************************************
        'Added By       :   SandeepA
        'Reason         :   Added Date Control (SP4) for Editable Date Control Issue
        'Date           :   5 Dec,2005
        'Requirement No.:
        'Addition       : Added date control and commented the original textbox controls.  
        '******************************************************************************************
        CommonFunctions.HTMLControls.DrawDateControl("txtDueDate", "txtDueDate", , 100, , , , , , , , True, , , , , , True)
        CommonFunctions.HTMLControls.DrawDateControl("txtReportedDate", "txtReportedDate", , 100, , , , , , , , True, , , , , , True)
        CommonFunctions.HTMLControls.DrawDateControl("txtCreatedDate", "txtCreatedDate", , 100, , , , , , , , True, , , , , , True)
        CommonFunctions.HTMLControls.DrawDateControl("txtClosedDate", "txtClosedDate", , 100, , , , , , , , True, , , , , , True)
        'End of Addition by SandeepA on 5 Dec,2005 for Editable Date Control Issue(SP4)


        'Code Commented By SandeepA on 5 Dec,2005 for Editable Date Control Issue (SP4)
        'CommonFunction.HTMLControls.DrawTextBox("txtDueDate", "txtDueDate", , 100, 10, , , , , True, , , , , , , , True)
        'CommonFunction.HTMLControls.DrawTextBox("txtReportedDate", "txtReportedDate", , 100, 10, , , , , True, , , , , , , , True)
        'CommonFunction.HTMLControls.DrawTextBox("txtCreatedDate", "txtCreatedDate", , 100, 10, , , , , True, , , , , , , , True)
        'CommonFunction.HTMLControls.DrawTextBox("txtClosedDate", "txtClosedDate", , 100, 10, , , , , True, , , , , , , , True)
        'End of Comment By SandeepA on 5 Dec,2005 for Editable Date Control Issue (SP4)


        General.WriteHTML(HTMLControls.DrawImage("../../Images/calendar.gif", "imgCalendar", " style='Display: none; CURSOR: hand;'", "javascript:Calender_OnClick()", , , "Click to open calendar", True))

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Reported Time Feature
        'Date   :   1 July 2004
        'Requirement No.:IB_PBN_ENT_04
        'Addition   :   Added the case for Reported Time

        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunction.HTMLControls.DrawTextBox("txtReportedTime", "txtReportedTime", , 100, 5, , , , , , , , "onkeypress=""Time_OnKeyPress(event)""", , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        '********End Addition*********

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Deliverabel Feature
        'Date   :   19 Aug 2004
        'Addition   :   Added the case for Deliverable
        strSQL = "usp_sel_tbl_PM_OtherSchedules_QueryBuilder " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboDeliverable", strSQL, 100, , , True, , , , , True)
        '********End Addition*********

        'Integrated by SandipL SP8 to SP9
        'Integrated by PrashantD on 5 March 2007 for Product Execution Project
        ' Added By NitinVS on 26 MAy 06 for Roamware customization 
        ' Product Version 
        strSQL = "USP_SEL_Tbl_PRD_ProductVersion_CustomerWise " + Session("intUserID").ToString + " , '" + Session("LoginType").ToString + "' ," + CType(Session("intLoginID"), String) + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", ",0")) + ", 1 , NULL , " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboProductVersionID", strSQL, 100, displaynone:=True)
        ' Component 
        strSQL = "USP_SEL_Tbl_PRD_ProductVersion_Component Null , Null , " + m_lngProjectID.ToString + " ," + Session("intUserID").ToString + " , '" + Session("LoginType").ToString + "' ," + CType(Session("intLoginID"), String) + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", ",0")) + ", 1"
        CommonFunction.HTMLControls.DrawComboBox("cboComponentID", strSQL, 100, displaynone:=True)

        ' Customer
        strSQL = "usp_SEL_Tbl_PM_Customer_forQueryBuilder " + m_lngProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboCustomer", strSQL, 100, displaynone:=True)

        ' End Addition  By NitinVS on 26 MAy 06 for Roamware customization 
        'End of Integration by PrashantD on 5 March 2007 for Product Execution Project
        'End Integration by SandipL SP8 to SP9

        'plot the controls for the custom controls depending on tht type of the controls
        'get the field Name and search for the type in the name of the field like if name contains COMBO 
        ' then display combobox, if TEXT then display textbox, TEXTA then display text box but with more 
        'maxlength than TEXT
        strSQL = "Usp_Sel_tbl_IB_CustomFields_Master " + m_lngProjectID.ToString
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDR.Read

            If Not IsDBNull(objDR("DatabaseFieldName")) Then

                'get the field name
                strFieldName = objDR("DatabaseFieldName").ToString

                If InStr(strFieldName.ToUpper, "TEXTAREA3") > 0 Then

                    'Commented and added by Yogesh J for HTML encoding Date:07/10/15
                    CommonFunction.HTMLControls.DrawTextBox(strFieldName.Trim, strFieldName.Trim, , 100, 4000, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:07/10/15
                ElseIf InStr(strFieldName.ToUpper, "TEXTAREA") > 0 Then
                    'Commented and added by Yogesh J for HTML encoding Date:07/10/15
                    CommonFunction.HTMLControls.DrawTextBox(strFieldName.Trim, strFieldName.Trim, , 100, , , , , , , , , , , , , , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:07/10/15
                ElseIf InStr(strFieldName.ToUpper, "TEXT") > 0 Then
                    'Commented and added by Yogesh J for HTML encoding Date:07/10/15
                    CommonFunction.HTMLControls.DrawTextBox(strFieldName.Trim, strFieldName.Trim, , 100, 100, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:07/10/15
                ElseIf InStr(strFieldName.ToUpper, "COMBO") > 0 Then
                    strSQL = "Exec Usp_Sel_tbl_IB_CustomFields_Details '" + strFieldName.Trim + "'," + m_lngProjectID.ToString
                    CommonFunction.HTMLControls.DrawComboBox(strFieldName.Trim, strSQL, 100, , , True, , , , , True)
                ElseIf InStr(strFieldName.ToUpper, "DATE") > 0 Then
                    CommonFunction.HTMLControls.DrawDateControl(strFieldName.Trim, strFieldName.Trim, , 100, , , "frmQueryBuilder", , , , , , , , , , , True)
                End If
            End If

        End While
        objDR.Close()
        objDR.Dispose()
        objDR = Nothing
        '*************************************************************************************************
        'General.WriteHTML("</TD>")
        'display append link
        objLink = New WebPage.UI.cDynamicLink
        objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
        objLink.LinkName = MyBase.GetResourceString("LINK_APPEND")
        objLink.Tooltip = MyBase.GetResourceString("LINK_APPEND_TOOLTIP")
        objLink.FunctionName = "Append_OnClick()"
        objLink.ReturnHTML = True
        General.WriteHTML("<TD align='left'>| <B>" + objLink.GetDynamicLink() + "</B> |</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        General.WriteHTML("<Table width=99.9% class='clsTable' cellpadding=0 cellspacing=0>")

        'display links for (,),AND,OR
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left' width=5% >" + MyBase.GetResourceString("CAP_INSERT") + "</TD>")
        General.WriteHTML("<TD align='left' >")
        objLink.LinkName = " ( "
        objLink.FunctionName = "Bracket_OnClick('(')"
        General.WriteHTML("| <B> " + objLink.GetDynamicLink() + "</B> |")
        objLink.LinkName = " ) "
        objLink.FunctionName = "Bracket_OnClick(')')"
        General.WriteHTML(" <B>" + objLink.GetDynamicLink() + "</B> |")
        objLink.LinkName = MyBase.GetResourceString("OP_AND") + ""
        objLink.FunctionName = "Operator_OnClick('" + MyBase.GetResourceString("OP_AND") + "')"
        General.WriteHTML(" <B>" + objLink.GetDynamicLink() + "</B> |")
        objLink.LinkName = MyBase.GetResourceString("OP_OR") + ""
        objLink.FunctionName = "Operator_OnClick('" + MyBase.GetResourceString("OP_OR") + "')"
        General.WriteHTML(" <B>" + objLink.GetDynamicLink() + "</B> |")
        General.WriteHTML("</TD>")
        General.WriteHTML("<TD width=10% >&nbsp;</TD>")
        General.WriteHTML("</TR>")

        'display query textbox
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left' colspan=2 >")
        'Modified By ShraddhaM on 27 July 2006
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'General.WriteHTML(HTMLControls.DrawTextArea("txtQueryText", "txtQueryText", , , , "frmQueryBuilder", , , 600, 100, , strQueryText.Trim, , , , , , , , True, True, , , , , , "Soft", ) + "</TD>")
        General.WriteHTML(HTMLControls.DrawTextArea("txtQueryText", "txtQueryText", , , , "frmQueryBuilder", , , 600, 100, , strQueryText.Trim, , , , , , , , True, True, , , , , , "Soft", , EnableHTMLEncode:=True) + "</TD>")
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        General.WriteHTML("<TD align='left'>&nbsp;</TD>")
        General.WriteHTML("</TR>")

        'display Clear all link
        objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR_ALL")
        objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_ALL_TOOLTIP")
        objLink.FunctionName = "ClearAll_OnClick()"
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' colspan=2 ><B> | </B>" + objLink.GetDynamicLink() + "<B> | </B></TD>")
        General.WriteHTML("<TD align='left' >&nbsp;</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("</div>")
        objLink = Nothing

    End Sub

    '=====================================================================
    ' Procedure Name		:	performQueryDetailAction
    ' Parameters Passed		:	lngQueryID - Long 
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the database for query details.
    ' Description			:	This procedure will update the database for the query details.
    '                           Before updating the data query is validated for the correct syntax.
    '                           for the Apply without saving action this wont update the data only 
    '                           validate the query and apply it to parent window.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 4 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performQueryDetailAction(ByVal lngQueryID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strQueryName As String
        Dim strFieldName As String
        Dim strValue As String
        Dim strOperator As String
        Dim strQueryText As String
        Dim blnValidQuery As Boolean
        Dim strSQLQuery As String
        Dim blnIsValidQuery As Boolean
        Dim strNewQueryID As String

        'get the values forn the controls
        strQueryName = MyBase.GetFormValue("txtQueryName", False) + ""
        'Intigrated by Harshk on 02/09/2005 for sp4 issueid 150
        'added by harshada d for SRIT issue ID : 20021
        'strQueryText = MyBase.GetFormValue("txtQueryText", False) + ""
        strQueryText = Replace(MyBase.GetFormValue("txtQueryText", False), Chr(13), "") + ""
        strQueryText = Replace(strQueryText, Chr(10), "")
        'end of addition by harshadad for  SRIT issue ID : 20021
        'END Intigration by Harshk on 02/09/2005 for sp4 issueid 150
        'Create the SQL query
        strSQLQuery = "SELECT * FROM v_tbl_IB_Issue WHERE " + strQueryText.Trim
        strSQLQuery += " ORDER BY IssueID , ImportID , ProjectID , Type , CorporateType , SubType , CorporateSubType , Priority , CorporatePriority , Status , CorporateStatus ,"
        strSQLQuery += " Severity , CorporateSeverity , ReportedBy , AssignTo , ReportedDate , CreatedDate , CustomerIssueID , ReportedInVersion , CorrectedInVersion , "
        strSQLQuery += " Summary ,  ModuleName , OS , Hardware , Kernel , Duration , Duedate , Phase , FoundInPhase , FixedInPhase , CodedBy , ShowToCustomer , "
        strSQLQuery += " Keywords , CreatorOrModifier , CustomFieldText1 , CustomFieldText2 , CustomFieldText3 , CustomFieldText4 , CustomFieldText5 , CustomFieldText6 , "
        strSQLQuery += " CustomFieldText7 , CustomFieldText8 , CustomFieldText9 , CustomFieldText10 , CustomFieldCombo1 , CustomFieldCombo2 , CustomFieldCombo3 ,"
        strSQLQuery += " CustomFieldCombo4 , CustomFieldCombo5 , CustomFieldCombo6 , CustomFieldCombo7 , CustomFieldCombo8 , CustomFieldCombo9 , CustomFieldCombo10 , "
        strSQLQuery += " CustomFieldDate1 , CustomFieldDate2 , CustomFieldDate3 , CustomFieldDate4 , CustomFieldDate5 , CustomFieldTextArea3 , ClosedDate , ProjectName "

        'validate the query
        blnIsValidQuery = CommonFunction.Data.ValidateQuery(strSQLQuery, MyBase.UseSQL)

        'set the flag to display the client side message for invalid query
        If blnIsValidQuery = False Then m_strIsValidQuery = "NO"

        Select Case m_strAction
            Case CONST_ACTION_SAVE

                If blnIsValidQuery = True Then
                    'save the query, if query ID is passed then update the query 
                    'else insert as new query
                    If lngQueryID > 0 Then
                        'update the query
                        strSQL = "Usp_Upd_tbl_IB_Query " + lngQueryID.ToString + "," + m_lngProjectID.ToString + "," + m_lngUserID.ToString
                        strSQL += ",'" + General.BuildQueryString(strQueryName.Trim) + "','" + General.BuildQueryString(strQueryText.Trim) + "','" + General.BuildQueryString(m_strLoginType.Trim) + "'"
                        strNewQueryID = Data.GetDataScalar(strSQL, MyBase.UseSQL).ToString + ""

                    Else
                        'insert new query
                        strSQL = "Usp_Ins_tbl_IB_Query " + m_lngProjectID.ToString + "," + m_lngUserID.ToString
                        strSQL += ",'" + General.BuildQueryString(strQueryName.Trim) + "','" + General.BuildQueryString(strQueryText.Trim) + "','" + General.BuildQueryString(m_strLoginType.Trim) + "'"
                        strNewQueryID = Data.CheckIsDBNull(Data.GetDataScalar(strSQL, MyBase.UseSQL), "").ToString + ""
                    End If

                    'set the current query id equal to newly inserted query or modified query id
                    If strNewQueryID <> "" Then
                        m_lngQueryID = CType(strNewQueryID, Long)
                    End If

                End If
            Case CONST_ACTION_APPLY

                If blnIsValidQuery = True Then
                    'apply the query to parent page without saving it
                    'keep the query(only condition) in the session and refresh the parent
                    Session("UnsavedQuery") = strQueryText.Trim
                    Session("intQueryID") = ""
                    'refresh the parent, first check whether parent page is IBIssueList,then refresh.
                    General.WriteHTML("<Script language=javascript>")

                    General.WriteHTML(" var strParentPage; ")
                    General.WriteHTML(" try { ")
                    General.WriteHTML(" strParentPage=new String(); ")
                    General.WriteHTML(" strParentPage=opener.location.href; ")
                    General.WriteHTML(" if(strParentPage.toUpperCase().indexOf('IBISSUELIST.ASPX') != -1) {")
                    'Commented and Added By Chakshuta H on 22nd-Aug-2016 Purpose::Query result not coming properly
                    'General.WriteHTML(" opener.location.href=opener.location.href; ")
                    General.WriteHTML(" opener.location.href='IBIssueList.aspx'; ")
                    'End Of Commented and Added By Chakshuta H on 22nd-Aug-2016 Purpose::Query result not coming properly
                    General.WriteHTML(" window.close();  } ")
                    General.WriteHTML(" } catch(e){ } ")

                    General.WriteHTML("</Script>")

                End If

            Case Else
        End Select

    End Sub
    ''Added by Yogesh J on 02-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_Query_OnClick(QueryID As String, EmployeeID As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(QueryID, String) + CType(EmployeeID, String) + "0" + "0")

        'm_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(QueryID, String) + "0" + "0")

        Return m_PKToken_Request_Multiple

    End Function
    ''End of addition by Yogesh J on 02-Feb-2016

End Class
