Imports CommonFunctions

Public Class PM_ReviewerSelection
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
    Private m_blnShowReviewer As Boolean
    Private m_blnShowReviewee As Boolean 'Added by SatyanarayanaA on 19-Jan-2006
    Protected m_strReviewStatisticsID As String
    Private m_strReviewerIDList As String    ' The comma separated list of Reviewer IDs.
    Private m_strRevieweeIDList As String = "" 'Added By SatyanarayanaA 19-Jan-2006
    Private m_strFilter As String
    Private WithEvents objGrid As New WebPage.Templates.GenericGrid
    'Added by MrugajaB on 1st Feb 2006
    Protected m_intReviewee As Integer
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

        'Modified by MrugajaB on 1st Feb 2006 for Issue ID.1835
        'Purpose:-Display page caption conditionally depending upon whether reviewers /reviewees are displayed on page
        If Request.QueryString("intReviewee") & "" = "1" Then
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_REVIEWEE")
        Else
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_REVIEWER")
        End If
        'End Addition
        ''Added  By Shamkant s 31/12/2015
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
        'Ended By Shamkant s 31/12/2015
    End Sub
    ''Added by Yogesh J on 01-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowSchedule_OnClick(EmployeeList As String, EmployeeID As String, FromDate As String, ToDate As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(EmployeeList, String) + CType(FromDate, String) + CType(ToDate, String) + "0" + "0")

        Return m_PKToken_Request_Multiple
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 01-Feb-2016
    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        'initialize the resource file for send Email page.
        MyBase.InitializeResources("AppResources.PM_ReviewerSelection", "AppResources")
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
    ' Author				:	SachinR
    ' Created				:	Feb 16 2004
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

        'Added by MrugajaB on 20th Feb 2006 for Issue ID.1835
        Dim strReviewstatisticsID As String
        'End Addition

        m_strMode = Request.QueryString("Mode") + ""
        m_strDate = Request.QueryString("ReviewedDate") + ""
        m_lngProjectID = CType(Session("intProjectID"), Long)

        'Added by MrugajaB on 1st Feb 2006
        m_intReviewee = CType(Request.QueryString("intReviewee"), Integer)
        'End If

        ' Get the flag indicating whether all the resources must be listed or only the reviewers must be listed.
        ' For the first time, in the "Add New" mode, all the resources will be listed.
        If m_strMode.ToUpper.Trim = "ADD" Then
            m_blnShowReviewer = False
        ElseIf m_strMode.ToUpper.Trim = "EDIT" Then
            m_blnShowReviewer = True
        Else
            If MyBase.GetFormValue("txtShowReviewers") = "1" Then
                m_blnShowReviewer = True
                m_strMode = "EDIT"
            Else
                m_blnShowReviewer = False
                m_strMode = "ADD"
            End If
        End If
        'Added by SatyanarayanaA on 19-Jan-2006
        If m_strMode.ToUpper.Trim = "ADD" Then
            m_blnShowReviewee = False
        ElseIf m_strMode.ToUpper.Trim = "EDIT" Then
            m_blnShowReviewee = True
        Else
            If MyBase.GetFormValue("txtShowReviewee") = "1" Then
                m_blnShowReviewee = True
                m_strMode = "EDIT"
            Else
                m_blnShowReviewer = False
                m_strMode = "ADD"
            End If
        End If
        'Ended by SatyanarayanaA on 19-Jan-2006
        m_strAlphabet = Request.QueryString("Alphabet") + ""
        If m_strAlphabet = "" Then m_strAlphabet = "-1"
        m_strAction = Request.QueryString("Action") + ""
        ' Get the Review ID, and the comma separated list of reviewer IDs.
        ' When this page is called for the first time, retrieve the values from the QueryString collection.
        If Not IsPostBack Then
            m_strReviewStatisticsID = Request.QueryString("ReviewStatisticsID") + ""
            m_strReviewerIDList = Request.QueryString("ReviewerIDList") + ""
            'Added By SatyanarayanaA on 19-Jan-2005 
            m_strRevieweeIDList = Request.QueryString("RevieweeIDList") + ""
            'Ended By SatyanarayanaA on 19-Jan-2005 
        Else
            m_strReviewStatisticsID = MyBase.GetFormValue("txtReviewStatisticsID") + ""
            m_strReviewerIDList = MyBase.GetFormValue("txtReviewerIDList")
            'Added By SatyanarayanaA on 19-Jan-2005 
            m_strRevieweeIDList = MyBase.GetFormValue("txtRevieweeIDList")
            'Ended By SatyanarayanaA on 19-Jan-2005 
        End If
        m_strDepartment = MyBase.GetFormValue("cboDepartment") + ""
        m_strLocation = MyBase.GetFormValue("cboLocation") + ""
        m_strDesignation = MyBase.GetFormValue("cboDesignation") + ""

        Select Case m_strMode.ToUpper
            Case CONST_ADD, CONST_EDIT

                If m_strAction <> "" Then
                    'update the database based on the action
                    Call performAction()
                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                'Added by SatyanarayanaA on 19-Jan-2006 to check for the for the Reviewer/Reviewee
                If Request.QueryString("intReviewee") & "" = "1" Then
                    MyBase.InitializeResources("AppResources.PM_ReviewerSelection", "AppResources")

                    arrMenu.Add(MyBase.GetResourceString("MENU_SET_REVIEWEE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SET_REVIEWEE_TOOLTIP")) : arrClientSideFunctions.Add("SetReviewer_OnClick()")

                    If m_blnShowReviewee = True Then
                        'Modified by MrugajaB on 6th March 2006 for Issue ID.1835
                        'arrMenu.Add(MyBase.GetResourceString("MENU_SHOW_ALL_REVIEWEE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SHOW_ALL_REVIEWEE_TOOLTIP")) : arrClientSideFunctions.Add("ShowAll_OnClick()")
                        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
                        arrMenu.Add(MyBase.GetResourceString("MENU_SHOW_ALL_RESOURCES")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SHOW_ALL_RESOURCES_TOOLTIP")) : arrClientSideFunctions.Add("ShowAll_OnClick()")
                        'End Modifiction
                    Else
                        arrMenu.Add(MyBase.GetResourceString("MENU_SHOW_REVIEWEE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SHOW_REVIEWEE_TOOLTIP")) : arrClientSideFunctions.Add("ShowReviewer_OnClick()")
                    End If
                    MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                Else
                    arrMenu.Add(MyBase.GetResourceString("MENU_SET_REVIEWER")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SET_REVIEWER_TOOLTIP")) : arrClientSideFunctions.Add("SetReviewer_OnClick()")
                    If m_blnShowReviewer = True Then
                        arrMenu.Add(MyBase.GetResourceString("MENU_SHOW_ALL_RESOURCES")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SHOW_ALL_RESOURCES_TOOLTIP")) : arrClientSideFunctions.Add("ShowAll_OnClick()")
                    Else
                        arrMenu.Add(MyBase.GetResourceString("MENU_SHOW_REVIEWER")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SHOW_REVIEWER_TOOLTIP")) : arrClientSideFunctions.Add("ShowReviewer_OnClick()")
                    End If
                End If
                'Ended By SatyanarayanaA on 19-Jan-2006


                ''Commented Added by SatyanarayanaA on 19-Jan-2006
                'arrMenu.Add(MyBase.GetResourceString("MENU_SET_REVIEWER")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SET_REVIEWER_TOOLTIP")) : arrClientSideFunctions.Add("SetReviewer_OnClick()")
                'If m_blnShowReviewer = True Then
                '    arrMenu.Add(MyBase.GetResourceString("MENU_SHOW_ALL_RESOURCES")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SHOW_ALL_RESOURCES_TOOLTIP")) : arrClientSideFunctions.Add("ShowAll_OnClick()")
                'Else
                '    arrMenu.Add(MyBase.GetResourceString("MENU_SHOW_REVIEWER")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SHOW_REVIEWER_TOOLTIP")) : arrClientSideFunctions.Add("ShowReviewer_OnClick()")
                'End If
                ''Commented Ended By SatyanarayanaA on 19-Jan-2006
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
                If m_intReviewee = 1 Then
                    arrClientSideFunctions.Add("Help_OnClick('Reviewee Selection')")
                Else
                    arrClientSideFunctions.Add("Help_OnClick('Reviewer Selection')")
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

                'Added by SatyanarayanaA on 19-Jan-2005 for Paging
                If Request.QueryString("intReviewee") & "" = "1" Then
                    strSQL = "usp_Sel_tbl_PM_ReviewStatistics_RevieweeList_PagingAlphabet 'ReviewedOf', " + m_lngProjectID.ToString + ", NULL, "
                Else
                    strSQL = "usp_Sel_tbl_PM_ReviewStatistics_ReviewerList_PagingAlphabet 'ReviewedBy', " + m_lngProjectID.ToString + ", NULL, "
                End If
                'Ended by SatyanarayanaA on 19-Jan-2005

                'create the pagin links
                'plot the grid for the list of assigned resources
                'Commented by SatyanarayanaA on 19-Jan-2005 strSQL = "usp_Sel_tbl_PM_ReviewStatistics_ReviewerList_PagingAlphabet 'ReviewedBy', " + m_lngProjectID.ToString + ", NULL, "
                ' Apply the Department ID filter if selected.					
                If m_strDepartment = "" Then
                    m_strFilter += "NULL,"
                Else
                    m_strFilter += m_strDepartment.Trim + ","
                End If
                ' Apply the Location ID filter if selected. 
                If m_strLocation = "" Then
                    m_strFilter += "NULL,"
                Else
                    m_strFilter += m_strLocation.Trim + ","
                End If
                ' Apply the Role ID filter if selected.
                If m_strDesignation = "" Then
                    m_strFilter += "NULL,"
                Else
                    m_strFilter += m_strDesignation.Trim + ","
                End If
                ' Apply the "Reviewers/Reviewee Only" filter if required.
                'Added By SatyanarayanaA on 19-Jan-2005
                If Request.QueryString("intReviewee") & "" = "1" Then
                    If m_blnShowReviewee Then
                        m_strFilter += "'AND E.EmployeeID IN (0" + m_strRevieweeIDList.Trim + "0)',"
                    Else
                        m_strFilter += "Null,"
                    End If
                Else
                    If m_blnShowReviewer Then
                        m_strFilter += "'AND E.EmployeeID IN (0" + m_strReviewerIDList.Trim + "0)',"
                    Else
                        m_strFilter += "Null,"
                    End If
                End If
                strSQL += m_strFilter + "NULL"
                'Ended By SatyanarayanaA on 19-Jan-2005

                'Added by MrugajaB on 20th Feb 2006 for Issue ID.1835
                'If Request.QueryString("intReviewee") & "" = "1" Then
                strReviewstatisticsID = CType(CommonFunction.Data.CheckIsDBNull(Request.QueryString("ReviewstatisticsID"), "0"), String)

                If strReviewstatisticsID = "" Then strReviewstatisticsID = "0"
                strSQL += "," + strReviewstatisticsID
                'End If
                'End Addition

                'display the paging links on the menu bar
                objPaging = New WebPage.Templates.Paging
                strPagingHTML = objPaging.DrawPaging(m_strAlphabet, strSQL, MyBase.GetResourceString("PAGING_SELECT"), "Paging_OnClick", "EmployeeName", True)
                objPaging = Nothing

                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, strPagingHTML)
                'draw upper menu
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")
                'create lower menu without paging
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                'initialize the resource file for PM_ReviewerAssignment page.
                MyBase.InitializeResources("AppResources.PM_ReviewerSelection", "AppResources")

                'draw page caption 

                'Modified by MrugajaB on 1st Feb 2006
                'Purpose:-Display page caption conditionally depending upon whether reviewers /reviewees are displayed on page
                If Request.QueryString("intReviewee") & "" = "1" Then
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_REVIEWEE"))
                Else
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_REVIEWER"))
                End If
                'End Addition

                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen with data
                Call plotReviewerList()
            Case Else
        End Select

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

        'plot the filter textbox
        General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9% >")

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left' width=100% nowrap colspan=3 >" + MyBase.GetResourceString("CAP_SHOW_NAME") + "&nbsp;")   '</TD>")
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txtFilter", "txtFilter", , 50, , strFilter.Trim, , , , , , , , True, EnableHTMLEncode:=True))
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
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

        'diplay dpartment combo
        General.WriteHTML("<TR class='clsTREven'>")
        strSQL = "usp_Sel_PM_DepartmentList"
        'Modified by MrugajaB on 6th March 2006 for Issue ID.1835
        'Purpose:Department combo is made hidden
        General.WriteHTML("<TD align='left' nowrap style='display:none'>" + MyBase.GetResourceString("CAP_DEPARTMENT") + "&nbsp;")
        'End Modification
        General.WriteHTML(HTMLControls.DrawComboBox("cboDepartment", strSQL, 120, m_strDepartment.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")

        'display location combo
        'Modified by MrugajaB on 6th March 2006 for Issue ID.1835
        'Purpose:Location combo is made hidden when reviewee is to be selected
        strSQL = "usp_Sel_PM_LocationList"
        If m_intReviewee = 1 Then
            General.WriteHTML("<TD align='left' nowrap style='display:none'>" + MyBase.GetResourceString("CAP_LOCATION") + "&nbsp;")
            General.WriteHTML(HTMLControls.DrawComboBox("cboLocation", strSQL, 120, m_strLocation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        Else
            General.WriteHTML("<TD align='left' nowrap>" + MyBase.GetResourceString("CAP_LOCATION") + "&nbsp;")
            General.WriteHTML(HTMLControls.DrawComboBox("cboLocation", strSQL, 120, m_strLocation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        End If
        'End Modification

        'display Designation combo
        'Modified by MrugajaB for Issue ID.1835
        'Purpose:At the time of Reviewee selection ,display Project level roles
        If m_intReviewee = 1 Then
            strSQL = "EXEC usp_sel_tbl_PM_ProjectRoles " + m_lngProjectID.ToString
            General.WriteHTML("<TD align='left' nowrap >" + "Project Role" + "&nbsp;")
        Else
            strSQL = "usp_Sel_tbl_PM_Role"
            General.WriteHTML("<TD align='left' nowrap >" + MyBase.GetResourceString("CAP_DESIGNATION") + "&nbsp;")
        End If
        'End Modification

        General.WriteHTML(HTMLControls.DrawComboBox("cboDesignation", strSQL, 150, m_strDesignation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")
        'Added By SatyanarayanaA on 19-Jan-2005
        ' Build the query to retrieve the list of resources based on the filtering criteria selected.
        If Request.QueryString("intReviewee") & "" = "1" Then
            strSQL = "usp_Sel_tbl_PM_ReviewStatistics_RevieweeList 'ReviewedOf', " + m_lngProjectID.ToString + ", NULL, "
        Else
            strSQL = "usp_Sel_tbl_PM_ReviewStatistics_ReviewerList 'ReviewedBy', " + m_lngProjectID.ToString + ", NULL, "
        End If
        'Ended By SatyanarayanaA on 19-Jan-2005

        strSQL += m_strFilter

        If strFilter <> "" Then
            strSQL += "'" + General.BuildQueryString(strFilter.Trim) + "'"
        Else
            strSQL += "'" + General.BuildQueryString(m_strAlphabet.Trim) + "'"
        End If

        'If Request.QueryString("intReviewee") & "" = "1" Then
        strReviewstatisticsID = CType(CommonFunction.Data.CheckIsDBNull(Request.QueryString("ReviewstatisticsID"), "0"), String)

        If strReviewstatisticsID = "" Then strReviewstatisticsID = "0"
        strSQL += "," + strReviewstatisticsID
        'End If

        'Dim arrColHeader() As String = {MyBase.GetResourceString("COL_USER_NAME"), MyBase.GetResourceString("COL_DEPARTMENT"), MyBase.GetResourceString("COL_LOCATION"), MyBase.GetResourceString("COL_DESIGNATION"), MyBase.GetResourceString("COL_SHOW_SCHEDULE"), MyBase.GetResourceString("COL_SHOW_SKILLS"), MyBase.GetResourceString("COL_SELECT")}
        Dim arrColHeader() As String = {MyBase.GetResourceString("COL_USER_NAME"), "Resource Name", MyBase.GetResourceString("COL_LOCATION"), MyBase.GetResourceString("COL_DESIGNATION"), MyBase.GetResourceString("COL_SHOW_SCHEDULE"), MyBase.GetResourceString("COL_SHOW_SKILLS"), MyBase.GetResourceString("COL_SELECT")}

        'Dim arrAN() As String = {"Employee Name", "Department", "Location", "Designation", MyBase.GetResourceString("COL_SHOW_SCHEDULE_LINK"), MyBase.GetResourceString("COL_SHOW_SKILLS_LINK"), ""}
        'Modified by MrugajaB on 6th March 2006 for issue ID.1835
        'Department combo and column is hidden and Reviewee/Reviewer Column Name is added
        'When reviewee is to be chosen ,organization unit column will not be dislayed
        Dim arrAN() As String = {"Employee Name", "Resource Name", "Location", "Designation", MyBase.GetResourceString("COL_SHOW_SCHEDULE_LINK"), MyBase.GetResourceString("COL_SHOW_SKILLS_LINK"), ""}
        'End Addition

        Dim arrRowLink() As String = {"", "", "", "", "ShowSchedule_OnClick(EmployeeID)", "ShowSkills_OnClick(Employee Name)", ""}
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "chkSelect"}
        Dim arrCheckBoxCheck() As String = {"", "", "", "", "", "", ""}
        Dim arrTDStyle() As String = {"align='left'", "align='left'", "align='left'", "align='left'", "align='left'", "align='left'", "align='center'"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'create Grid object and set the properties
        'objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.RowLinkArray = arrRowLink
        objGrid.CheckBoxIDArray = arrCheckBox
        objGrid.CheckboxCheckOnColumnArray = arrCheckBoxCheck
        objGrid.TDStyleArray = arrTDStyle
        objGrid.PrimaryKey = "EmployeeID"
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 300
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = 4
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = strSQL
        objGrid.UseSQL = MyBase.UseSQL
        'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()

        objGrid = Nothing
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txtReviewStatisticsID", "txtReviewStatisticsID", , , , m_strReviewStatisticsID.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtReviewerIDList", "txtReviewerIDList", , , , m_strReviewerIDList.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'Added By SatyanarayanaA on 19-Jan-2005
        General.WriteHTML(HTMLControls.DrawTextBox("txtRevieweeIDList", "txtRevieweeIDList", , , , m_strRevieweeIDList.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'Ended By SatyanarayanaA on 19-Jan-2005
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

        If m_blnShowReviewer = True Then
            'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtShowReviewers", "txtShowReviewers", , , , "1", , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        Else
            'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtShowReviewers", "txtShowReviewers", , , , "", , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        End If
        'Added By SatyanarayanaA on 19-Jan-2005
        If m_blnShowReviewee = True Then
            'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtShowReviewee", "txtShowReviewee", , , , "1", , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        Else
            'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtShowReviewee", "txtShowReviewee", , , , "", , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        End If
        'Ended By SatyanarayanaA on 19-Jan-2005

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
        strReviewerNameList = ""
        arrIDList = Split(m_strReviewerIDList, ",")
        Dim i As Integer
        'Added By SatyanarayanaA on 19-Jan-2005 for Spliting
        If Request.QueryString("intReviewee") & "" = "1" Then
            arrIDList = Split(m_strRevieweeIDList, ",")
            For i = 0 To arrIDList.Length - 1
                If arrIDList(i).Trim <> "" Then
                    'get the name of the employee
                    Call CommonFunction.EmailMessages.GetEmployeeInfo(CType(arrIDList(i).Trim, Long), strUserName, "")

                    If strUserName <> "" Then
                        strRevieweeNameList += strUserName + ","
                    End If
                End If
            Next
        Else

            For i = 0 To arrIDList.Length - 1
                If arrIDList(i).Trim <> "" Then
                    'get the name of the employee
                    Call CommonFunction.EmailMessages.GetEmployeeInfo(CType(arrIDList(i).Trim, Long), strUserName, "")

                    If strUserName <> "" Then
                        strReviewerNameList += strUserName + ","
                    End If
                End If
            Next
        End If
        'Ended By SatyanarayanaA on 19-Jan-2005 for Spliting
        'Added By SatyanarayanaA on 19-Jan-2005 
        If Request.QueryString("intReviewee") & "" = "1" Then
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
            CommonFunction.General.WriteHTML("<Script language=javascript >")
            'Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
            'Purpose : Firefox Support, used GetParentObjectReference instead of opener.frmCommonPage.....
            'CommonFunction.General.WriteHTML("window.opener.frmCommonPage.NonDatabase12.value="""";")
            'CommonFunction.General.WriteHTML("window.opener.frmCommonPage.NonDatabase12.value=""" + m_strRevieweeIDList.Trim + """;")
            'CommonFunction.General.WriteHTML("window.opener.frmCommonPage.Reviewee.value="""";")
            'CommonFunction.General.WriteHTML("window.opener.frmCommonPage.Reviewee.value=""" + strRevieweeNameList.Trim + """;")
            General.WriteHTML("var objNDB12 = GetParentObjectReference('frmCommonPage','NonDatabase12');")
            '//Modified By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507
            'Added script to check existance of the object
            General.WriteHTML(" if (objNDB12 != null ) {  ")
            General.WriteHTML("objNDB12.value="""";")
            General.WriteHTML("objNDB12.value=""" + m_strRevieweeIDList.Trim + """;")
            General.WriteHTML("var objReviewee = GetParentObjectReference('frmCommonPage','Reviewee');")
            General.WriteHTML("objReviewee.value="""";")
            General.WriteHTML("objReviewee.value=""" + strRevieweeNameList.Trim + """;")
            'Modification Ends by SantoshK on June 8, 2006
            General.WriteHTML(" } ")
            '//End Modification By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507

            CommonFunction.General.WriteHTML("window.close();")


        Else
            ' Remove the last comma from the list of reviewer names.
            strReviewerNameList = strReviewerNameList.TrimEnd(","c)
            ' Trim the reviewers list to 500 characters.
            If strReviewerNameList.Length > 500 Then
                strReviewerNameList = strReviewerNameList.Substring(0, 500)
            End If

            ' Update the parent page Reviewer(s) text box with the new set of reviewers. 
            ' Update the hidden control on the parent page with the concatenated ID list.
            General.WriteHTML("<Script language=javascript >")
            'Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
            'Purpose : Firefox Support, used GetParentObjectReference instead of opener.frmCommonPage.....
            'General.WriteHTML("opener.frmCommonPage.NonDatabase1.value="""";")
            'General.WriteHTML("opener.frmCommonPage.NonDatabase1.value=""" + m_strReviewerIDList.Trim + """;")
            'General.WriteHTML("opener.frmCommonPage.ReviewedBy.value="""";")
            'General.WriteHTML("opener.frmCommonPage.ReviewedBy.value=""" + strReviewerNameList.Trim + """;")
            General.WriteHTML("var objNDB1 = GetParentObjectReference('frmCommonPage','NonDatabase1');")
            '//Modified By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507
            'Added script to check existance of the object
            General.WriteHTML(" if (objNDB1 != null ) {  ")
            General.WriteHTML("objNDB1.value="""";")
            General.WriteHTML("objNDB1.value=""" + m_strReviewerIDList.Trim + """;")
            General.WriteHTML("var objRB = GetParentObjectReference('frmCommonPage','ReviewedBy');")
            General.WriteHTML("objRB.value="""";")
            General.WriteHTML("objRB.value=""" + strReviewerNameList.Trim + """;")
            'Modification Ends by SantoshK on June 8, 2006
            General.WriteHTML(" } ")
            '//End Modification By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507
            General.WriteHTML("window.close();")

        End If
        'Ended By SatyanarayanaA on 19-Jan-2005 
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
            strEmpID = Args.DataReader("EmployeeID").ToString + ""
            'Added By SatyanarayanaA on 19-Jan-2005 
            If Request.QueryString("intReviewee") & "" = "1" Then
                If m_strRevieweeIDList.IndexOf("," + strEmpID.Trim + ",") <> -1 Then
                    blnChecked = True
                End If
            Else
                If m_strReviewerIDList.IndexOf("," + strEmpID.Trim + ",") <> -1 Then
                    blnChecked = True
                End If
            End If
            'Ended By SatyanarayanaA on 19-Jan-2005 

            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , blnChecked, strEmpID.Trim, , " onclick=javascript:chkSelect_OnClick(this)", True) + "</td>"
            Cancel = True
        End If

        'Added by MrugajaB on 6th March 2006 for Issue ID.1835
        'Purpose:When Reviewee is to be selected ,OU should not be displayed
        If m_intReviewee = 1 Then
            If Args.ColumnName.ToUpper = "ORGANIZATION UNIT" Then
                Cancel = True
            End If
        End If
        'End Addition
    End Sub


    Private Sub objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objGrid.ColumnHeaderTD_BeforePrint
        'Added by MrugajaB on 6th March 2006 for Issue ID.1835
        'Purpose:When Reviewee is to be selected ,OU should not be displayed
        If m_intReviewee = 1 Then
            If Args.ColumnName.ToUpper = "ORGANIZATION UNIT" Then
                Cancel = True
            End If

            If Args.ColumnName.ToUpper = "ROLE" Then
                Args.ColumnName = "Project Role"
            End If
        End If
        'End Addition
    End Sub
    ''Added by Yogesh J on 03-Mar-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowSkillls(EmployeeName As String, EmpDate As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeName, String) + CType(EmpDate, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 03-Mar-2016 to generate and validate Token		

End Class
