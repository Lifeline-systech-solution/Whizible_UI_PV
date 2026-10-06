Public Class Test_Case_Responses
    Inherits WebPages.Template.WhizTemplate

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
        'Put user code to initialize the page here
    End Sub
#Region "Variables"
    Private Const PageSize As Integer = 8
    Private m_intPageNumber As Integer
    Private m_intTotalRecords As Integer
    Private m_intTotalNoOfPages As Integer
    Protected m_intProjectID As Integer
    Private blnIsShowAll As Boolean


    Private m_strTestSectionID As String
    Private m_strTestSessionID As String
    Private m_strTestSetID As String
    Private m_strTestResultID As String

    Private m_intResultID As Integer
    Private m_intActStaffTimeID As Integer
    Private m_strNotes As String
    Private m_strOrderBy As String
    Private m_strAction As String
    Private m_strGridSQL As String
    Private m_strNoOfRowsSQL As String
    Private m_strProgressSQL As String

    
    Protected blnIsTestSessionClosed As Boolean = False
    Private m_strAllBKMK_Info As String ' "1,2" '1=TestCaseID AND 2=PageNo
    Private m_strFirstBKMKCurrPage As String

    '''Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
    'Private m_intFlag As Integer
    'Private m_ReleaseID As String = "NULL"
    'Private m_IterationID As String = "NULL"
    '''End of Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)


#End Region
    Private Sub InitializeVariables()
        '=====================================================================
        ' Procedure Name        : InitializeVariables()
        ' Purpose               : Initialize all variables used in Functions
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : This function must be called first before any activity has to be taken.
        ' Author                : PrashantD
        ' Created               : Feb 3, 2006
        ' Revisions             :
        '=====================================================================




        'Session is passed as queryString for first hit. Then its value is persisted in hidden control
        If Not Request.QueryString("TestSessionID") Is Nothing Then
            m_strTestSessionID = Request.QueryString("TestSessionID")
        Else
            m_strTestSessionID = Request.Form("hidSessionID")
        End If


        'Modified By VarunA on 25-Sep-2008 IssueID-22556
        'Purpose : To have id for hiiden value (Mozilla)
        'CommonFunction.General.WriteHTML("<INPUT TYPE=HIDDEN name=hidSessionID VALUE=" + m_strTestSessionID + ">")
        CommonFunction.General.WriteHTML("<INPUT TYPE=HIDDEN id='hidSessionID' name='hidSessionID' VALUE=" + m_strTestSessionID + ">")
        'End By VarunA on 25-Sep-2008 IssueID-22556

        m_strAction = Request.Form("hidAction")

        CommonFunction.General.WriteHTML("<INPUT TYPE=HIDDEN name=hidAction >")
        CommonFunction.General.WriteHTML("<INPUT TYPE=HIDDEN name=hidActionMode >")


        If m_strAction Is Nothing Then
            m_strAction = Request.QueryString("Action")
            If m_strAction Is Nothing Then 'Action for first hit
                m_strAction = "NONE"
            End If
        ElseIf m_strAction = "" Then
            m_strAction = Request.QueryString("Action")
            If m_strAction Is Nothing Then 'Action for first hit
                m_strAction = "NONE"
            End If
        End If



        m_intProjectID = CInt(Session("intProjectID"))

        m_strGridSQL = "usp_Sel_grid_tbl_TCM_TestCaseDetails " + m_intProjectID.ToString + "," + CStr(Session("intUserID")) + ",0," + m_strTestSessionID
        m_strNoOfRowsSQL = "usp_Sel_grid_tbl_TCM_TestCaseDetails " + m_intProjectID.ToString + "," + CStr(Session("intUserID")) + ",1," + m_strTestSessionID
        m_strProgressSQL = "usp_Sel_graph_tbl_TCM_TestCaseDetails " + m_intProjectID.ToString + "," + m_strTestSessionID

        ''Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
        'If Not Request.QueryString("ReleaseID") Is Nothing Then
        '    CommonFunction.General.WriteHTML("<INPUT TYPE=HIDDEN id='hidReleaseID' name='hidReleaseID' VALUE=" + Request.QueryString("ReleaseID").ToString + ">")
        '    CommonFunction.General.WriteHTML("<INPUT TYPE=HIDDEN id='hidIterationID' name='hidIterationID' VALUE=" + Request.QueryString("IterationID").ToString + ">")
        'Else
        '    Dim ReleaseID As String = Request.Form("hidReleaseID")
        '    Dim IterationID As String = Request.Form("hidIterationID")
        '    CommonFunction.General.WriteHTML("<INPUT TYPE=HIDDEN id='hidReleaseID' name='hidReleaseID' VALUE=" + ReleaseID + ">")
        '    CommonFunction.General.WriteHTML("<INPUT TYPE=HIDDEN id='hidIterationID' name='hidIterationID' VALUE=" + IterationID + ">")
        'End If
        ''End of Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)




        'Initializing variables when Page is first hitted 
        If m_strAction = "NONE" Then
            m_intPageNumber = 1
            m_strOrderBy = "ASC"
            '--- Commented and added by purvaj on 3 Jul 2009 8.1 Issue fixes 
            '--- blank value from test set combo removed as test set selection is mandatory. By default 1st test set's data will be displayed
            '''m_strTestSetID = "0"
            m_strTestSetID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_combo_v_tbl_TCM_ProjectTestSessionTestSet " + m_strTestSessionID, True), "0"), "0")
            '--- End addition purvaj
            m_strTestResultID = "00"
            m_strTestSectionID = ""
            '--- Commented by purvaj on 3 Jul 2009 8.1 Issue fixes 
            '--- blank value from test set combo removed as test set selection is mandatory. By default 1st test set's data will be displayed
            '--- code moved out of IF block.
            '''''m_strGridSQL += ",0,0,0 "
            '''''m_strNoOfRowsSQL += ",0,0,0"
            '''''m_strProgressSQL += ",0,0,0"
            '--- End comment purvaj
        Else 'Common for all Actions 

            Try
                m_intPageNumber = CInt(Request.Form("txtPageNumber"))
                If m_intPageNumber = 0 Then
                    m_intPageNumber = 1
                End If
            Catch
                m_intPageNumber = 1
            End Try

            m_strOrderBy = Request.Form("hidOrderBy")
            m_strTestSetID = Request.Form("cboTestSet")
            m_strTestResultID = Request.Form("cboTestResult")
            m_strTestSectionID = Request.Form("cboTestSection")

            ''Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
            'm_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_intProjectID.ToString, MyBase.UseSQL)))
            'If m_intFlag = 1 Then
            '    If m_strAction.ToUpper = "SAVE" Then
            '        m_ReleaseID = Request.Form("hidReleaseID")
            '        m_IterationID = Request.Form("hidIterationID")
            '    End If
            'End If


            ''End of Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)

            '--- Commented by purvaj on 3 Jul 2009 8.1 Issue fixes 
            '--- blank value from test set combo removed as test set selection is mandatory. By default 1st test set's data will be displayed
            '--- code moved out of IF block.

            '''m_strGridSQL += "," + m_strTestSetID
            '''m_strNoOfRowsSQL += "," + m_strTestSetID
            '''m_strProgressSQL += "," + m_strTestSetID

            '''If m_strTestSectionID <> "" Then
            '''    m_strGridSQL += "," + m_strTestSectionID
            '''    m_strNoOfRowsSQL += "," + m_strTestSectionID
            '''    m_strProgressSQL += "," + m_strTestSectionID
            '''Else
            '''    m_strGridSQL += ",NULL"
            '''    m_strNoOfRowsSQL += ",NULL"
            '''    m_strProgressSQL += ",NULL"
            '''End If

            '''If m_strTestResultID <> "" Then
            '''    m_strGridSQL += "," + m_strTestResultID
            '''    m_strNoOfRowsSQL += "," + m_strTestResultID
            '''    m_strProgressSQL += "," + m_strTestResultID
            '''Else
            '''    m_strGridSQL += ",NULL"
            '''    m_strNoOfRowsSQL += ",NULL"
            '''    m_strProgressSQL += ",NULL"
            '''End If
            '--- End comment purvaj
        End If

        '--- Added by purvaj on 3 Jul 2009 8.1 Issue fixes 
        '--- blank value from test set combo removed as test set selection is mandatory. By default 1st test set's data will be displayed
        '--- this is the code moved from IF block
        m_strGridSQL += "," + m_strTestSetID
        m_strNoOfRowsSQL += "," + m_strTestSetID
        m_strProgressSQL += "," + m_strTestSetID

        If m_strTestSectionID <> "" Then
            m_strGridSQL += "," + m_strTestSectionID
            m_strNoOfRowsSQL += "," + m_strTestSectionID
            m_strProgressSQL += "," + m_strTestSectionID
        Else
            m_strGridSQL += ",NULL"
            m_strNoOfRowsSQL += ",NULL"
            m_strProgressSQL += ",NULL"
        End If

        If m_strTestResultID <> "" Then
            m_strGridSQL += "," + m_strTestResultID
            m_strNoOfRowsSQL += "," + m_strTestResultID
            m_strProgressSQL += "," + m_strTestResultID
        Else
            m_strGridSQL += ",NULL"
            m_strNoOfRowsSQL += ",NULL"
            m_strProgressSQL += ",NULL"
        End If
        '--- End addition purvaj

        ''''Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
        'If m_ReleaseID <> "" Then
        '    m_strGridSQL += "," + m_ReleaseID
        '    m_strNoOfRowsSQL += "," + m_ReleaseID
        '    m_strProgressSQL += "," + m_ReleaseID
        'Else
        '    m_strGridSQL += ",NULL"
        '    m_strNoOfRowsSQL += ",NULL"
        '    m_strProgressSQL += ",NULL"
        'End If
        'If m_IterationID <> "" Then
        '    m_strGridSQL += "," + m_IterationID
        '    m_strNoOfRowsSQL += "," + m_IterationID
        '    m_strProgressSQL += "," + m_IterationID
        'Else
        '    m_strGridSQL += ",NULL"
        '    m_strNoOfRowsSQL += ",NULL"
        '    m_strProgressSQL += ",NULL"
        'End If
        ''''Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)

        m_intTotalNoOfPages = CInt(CInt(CommonFunction.Data.GetDataScalar(m_strNoOfRowsSQL, MyBase.UseSQL)))
        m_intTotalRecords = m_intTotalNoOfPages
        m_intTotalNoOfPages = CInt(Math.Ceiling(m_intTotalNoOfPages / PageSize))

        If m_intTotalNoOfPages < 1 Then
            m_intPageNumber = 0
        End If

        'Setting Show all records in hidden form
        If Request.Form("hidIsShowAll") = "TRUE" Then
            CommonFunction.General.WriteHTML("<INPUT Type=Hidden name=hidIsShowAll id=hidIsShowAll value=TRUE>")
            blnIsShowAll = True
            m_intPageNumber = -2

        Else
            CommonFunction.General.WriteHTML("<INPUT Type=Hidden name=hidIsShowAll id=hidIsShowAll value=FALSE>")
            blnIsShowAll = False
        End If

        Select Case m_strAction.ToUpper
            'Case "PAGING"
            '    If Request.QueryString("Show") = "ALL" Then
            '        m_intPageNumber = -2
            '    End If

            Case "BOOKMK"
                SaveBookMark()
        End Select
        If Request.Form("hidActionMode") = "SAVE" Or m_strAction.ToUpper = "SAVE" Then
            SaveData()
        End If

        If Not Request.Form("hidPostForBKMKID") Is Nothing Then
            CommonFunction.General.WriteHTML("<input type=hidden name=hidPostForBKMKID id=hidPostForBKMKID value='" + Request.Form("hidPostForBKMKID") + "'> ")
        Else
            CommonFunction.General.WriteHTML("<input type=hidden name=hidPostForBKMKID id=hidPostForBKMKID value='' > ")
        End If

        If Request.Form("hidIsTestSessionClosed") <> "" Then
            blnIsTestSessionClosed = CType(Request.Form("hidIsTestSessionClosed"), Boolean)
        Else
            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''blnIsTestSessionClosed = CBool(CommonFunction.Data.GetDataScalar("SELECT isnull(Closed,0) FROM tbl_TCM_TestSession WHERE TestSessionID=" + m_strTestSessionID, MyBase.UseSQL))
            blnIsTestSessionClosed = CBool(CommonFunction.Data.GetDataScalar("usp_sel_tbl_TCM_TestSession_TestSID " + m_strTestSessionID, MyBase.UseSQL))
        End If

        CommonFunction.General.WriteHTML("<input type=hidden name=hidIsTestSessionClosed id=hidIsTestSessionClosed value='" + blnIsTestSessionClosed.ToString.ToUpper + "'> ")

    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : Start of Page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : This function must be called within FORM tag in aspx page.
        ' Author                : PrashantD
        ' Created               : Feb 3, 2006
        ' Revisions             :
        '=====================================================================

        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.Test_Case_Responses", "AppResources")

        InitializeVariables()

        arrMenu.Add(MyBase.GetResourceString("MENU_ISSUE_BASE"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ISSUE_BASE"))
        arrCSFunction.Add("openIssueBase()")

        If blnIsTestSessionClosed = False Then
            arrMenu.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrCSFunction.Add("Save_Click()")
        End If


        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP"))
        arrCSFunction.Add("Close_OnClick()")
        arrCSFunction.Add("Help_OnClick('TCM')")



        With Response

            'Upper menu
            .Write(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))
            .Write("<BR>")

            'page caption

            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("LBL_TEST_EXECUTION"), "Test Session: " + CType(CommonFunction.Data.GetDataScalar("SELECT Title FROM tbl_TCM_TestSession WHERE TestSessionID=" + m_strTestSessionID, MyBase.UseSQL), String)))
            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("LBL_TEST_EXECUTION"), "Test Session: " + CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_TCM_TestSession_Title_TestSession " + m_strTestSessionID, MyBase.UseSQL), String)))
            .Write("<BR>")


            'Page Filters
            DrawPageFiltersPaging()

            'Grid
            DrawGrid()
            .Write("<BR>")
            'Bottom Menu

            '.Write(WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip))
            .Write(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))

            .Write("<BR>")

            'Initalize Book Mark. Plot information of bookmarks in hidden controls
            BookMarkInitalization()


        End With

    End Sub
    Private Sub DrawPageFiltersPaging()
        '=====================================================================
        ' Procedure Name        : DrawPageFiltersPaging()
        ' Purpose               : Plotting Page Filters controls and calling Numeric Paging function.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : Feb 3, 2006
        ' Revisions             :
        '=====================================================================

        'Filter Div

        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunction.General.WriteHTML("<TD  align=Left width='1%'><A href='Javascript:showHide_divFilter()'>")
        CommonFunction.General.WriteHTML("<Img Border=0 id=pageFilterImg Src='../../Images/minus.gif' title=''></A></TD>")
        CommonFunction.General.WriteHTML("<TD> " + MyBase.GetResourceString("LBL_FILTER") + "</TD>")
        CommonFunction.General.WriteHTML("<TD id=TDPaging align=Right><font style='FONT-WEIGHT: normal' >")
        DrawPaging() 'New place paging
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")

        CommonFunction.General.WriteHTML("<DIV id=pageFilterDiv>")

        CommonFunction.General.WriteHTML("<TABLE ID='PageFilter' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        'Test Set Combo 
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEST_SET"))
        CommonFunction.General.WriteHTML("</TD><TD>")
        '--- Modified by purvaj on 3 Jul 2009 for 8.1 Issue fixes
        '--- insert blank record set to False
        CommonFunction.HTMLControls.DrawComboBox("cboTestSet", "usp_Sel_combo_v_tbl_TCM_ProjectTestSessionTestSet " + m_strTestSessionID, 200, m_strTestSetID, "onchange=TestSet_onChange()", False, , , True)
        '--- End modification purvaj
        CommonFunction.General.WriteHTML("<A href='JavaScript:showTestSetHistory_onClick()' Title='Click here to view history of Test Set' > " + MyBase.GetResourceString("LNK_TEST_SET_HISTORY") + "</A>")
        CommonFunction.General.WriteHTML("</TD>")

        'New place Test Section
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEST_SECTION"))
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboTestSection", "usp_Sel_combo_tbl_TCM_TestSection_Execution " + m_strTestSetID, 200, m_strTestSectionID, "onchange=TestSet_onChange()", True)
        CommonFunction.General.WriteHTML("</TD>")
        'End new place Test Section


        'Paging

        'CommonFunction.General.WriteHTML("<TD align=right>")
        'DrawPaging()
        'CommonFunction.General.WriteHTML("</TD>")

        CommonFunction.General.WriteHTML("<TD></TD>")
        CommonFunction.General.WriteHTML("</TR>")

        'Test Section
        ''CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        ''CommonFunction.General.WriteHTML("<TD align=right>")
        ''CommonFunction.General.WriteHTML(MyBase.GetResourceString("TEST_SECTION"))
        ''CommonFunction.General.WriteHTML("</TD><TD>")
        ''CommonFunction.HTMLControls.DrawComboBox("cboTestSection", "usp_Sel_combo_tbl_TCM_TestSection " + m_strTestSetID, 200, m_strTestSectionID, "onchange=TestSet_onChange()", True)
        ''CommonFunction.General.WriteHTML("</TD>")

        'Book Mark
        '''CommonFunction.General.WriteHTML("<TD align=right>")
        '''DrawBookMarks()
        '''CommonFunction.General.WriteHTML("</TD>")

        '''CommonFunction.General.WriteHTML("<TD></TD>")
        '''CommonFunction.General.WriteHTML("</TR>")


        'Result
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML("Result")
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboTestResult", "usp_Sel_combo_tbl_TCM_TestResultMaster 1", 200, m_strTestResultID, "onchange=TestSet_onChange()", True)
        CommonFunction.General.WriteHTML("</TD>")

        ''Added by NitinC on 27 June 2011 for Agile Methodology
        ''User Story For Agile Methodology

        'm_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_intProjectID.ToString, MyBase.UseSQL)))
        'If m_intFlag = 1 Then
        '    CommonFunction.General.WriteHTML("<TD align=right>")
        '    CommonFunction.General.WriteHTML("User Story")
        '    CommonFunction.General.WriteHTML("</TD><TD>")
        '    CommonFunction.HTMLControls.DrawComboBox("cboUserStory", "select UserStoryID,UserStoryName from d_tbl_PM_ScrumUserStory Where ProjectID = " + m_intProjectID.ToString + " AND IterationID is not null", 200, m_ReleaseID, "onchange=UserStory_onChange()", True, , , True)
        '    CommonFunction.General.WriteHTML("</TD>")
        'End If

        ''End of - Added by NitinC on 27 June 2011 for Agile Methodology

        'New place BookMarks
        CommonFunction.General.WriteHTML("<TD></TD><TD>")
        DrawBookMarks()
        CommonFunction.General.WriteHTML("</TD>")

        CommonFunction.General.WriteHTML("<TD></TD></TR><TR class=clsTREven>") 'This is new line
        'End new place bookmarks

        'Progress Bar
        Dim dr As IDataReader
        Dim intTotalResponses As Integer
        Dim intNegResponses As Integer
        Dim intNonNegResponses As Integer
        Dim intNonTestedResponses As Integer
        Dim fltNegResponsesPercent As Double
        Dim fltNonNegResponsesPercent As Double
        Dim fltNonTestedResponses As Double


        'this is new line for placing controls
        'CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML("<TD align=center colspan=4>")

        dr = CommonFunction.Data.GetDataReader(m_strProgressSQL, MyBase.UseSQL)
        If dr.Read Then
            intTotalResponses = CInt(dr("Total"))
            intNegResponses = CInt(dr("Fail"))
            intNonNegResponses = CInt(dr("Pass"))

            If intTotalResponses <> 0 Then
                fltNegResponsesPercent = (100 * intNegResponses) / intTotalResponses
                fltNonNegResponsesPercent = (100 * intNonNegResponses) / intTotalResponses

                intNonTestedResponses = CInt(intTotalResponses - intNegResponses - intNonNegResponses)
                fltNonTestedResponses = (100 * intNonTestedResponses) / intTotalResponses
            End If


            CommonFunction.General.WriteHTML("<TABLE class=clsTable width=80% cellspacing=0 cellpadding=0 >")
            CommonFunction.General.WriteHTML("<TR class=clsTREven ><TD colspan=3 align=center > " + MyBase.GetResourceString("LBL_RESULTS") + " &nbsp;" + _
                        MyBase.GetResourceString("LBL_TOTAL") + "-" + intTotalResponses.ToString + "  &nbsp;" + _
                        MyBase.GetResourceString("LBL_FAIL") + "-" + intNegResponses.ToString + " [" + fltNegResponsesPercent.ToString("f") + "%] &nbsp;" + _
                        MyBase.GetResourceString("LBL_PASS") + "-" + intNonNegResponses.ToString + " [" + fltNonNegResponsesPercent.ToString("f") + "%] &nbsp;" + _
                        MyBase.GetResourceString("LBL_NONTESTED") + "-" + intNonTestedResponses.ToString + " [" + fltNonTestedResponses.ToString("f") + "%] &nbsp;")
            CommonFunction.General.WriteHTML("</TD></TR>")

            ''If intTotalResponses <> 0 Then
            ''    intNegResponses = CInt(Math.Ceiling(((100 * intNegResponses) / intTotalResponses)))
            ''    intNonNegResponses = CInt(Math.Ceiling(((100 * intNonNegResponses) / intTotalResponses)))
            ''End If
            intTotalResponses = CInt(100 - intNegResponses - intNonNegResponses)


            CommonFunction.General.WriteHTML("<TR >")

            If fltNegResponsesPercent <> 0 Then
                CommonFunction.General.WriteHTML("<TD width='" + fltNegResponsesPercent.ToString("f") + "%' ><img title='Fail' height=12px width=100%  src='../../images/BookMark/FailResponses.jpg'> </TD>")
            Else
                CommonFunction.General.WriteHTML("<TD width='0%'></TD>")
            End If
            If fltNonNegResponsesPercent <> 0 Then
                CommonFunction.General.WriteHTML("<TD width='" + fltNonNegResponsesPercent.ToString("f") + "%' ><img title='Pass' height=12px width=100%  src='../../images/BookMark/PassResponses.jpg'> </TD>")
            Else
                CommonFunction.General.WriteHTML("<TD width='0%'></TD>")
            End If
            If fltNonTestedResponses <> 0 Then
                CommonFunction.General.WriteHTML("<TD width='" + fltNonTestedResponses.ToString("f") + "%' ><img title='Non Tested' height=12px width=100%  src='../../images/BookMark/TotalResponses.jpg'> </TD>")
            Else
                CommonFunction.General.WriteHTML("<TD width='0%'></TD>")
            End If

            CommonFunction.General.WriteHTML("</TR>")
            CommonFunction.General.WriteHTML("</TABLE>")

        End If
        'end of progress bar

        CommonFunction.Data.DisposeDataReader(dr)

        CommonFunction.General.WriteHTML("</TD><TD></TD>")
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")

    End Sub
    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawPageFiltersPaging()
        ' Purpose               : Plotting Page List and controls within List. 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : Feb 3, 2006
        ' Revisions             :
        '=====================================================================
        Dim drTestCases As IDataReader
        Dim strCssEven As String = "clsTREven"

        Dim strToRestainCtrl As String
        'Dim strResultHTML As String ' New System.Text.StringBuilder
        Dim intHidVarCounter As Integer
        Dim intpageSizeSkipCounter As Integer
        Dim strTempHold As String


        'drTestCases = CommonFunction.Data.GetDataReader("usp_Sel_combo_tbl_TCM_TestResultMaster", MyBase.UseSQL)
        'strResultHTML.Append("<OPTION value=''></OPTION>")
        'While drTestCases.Read
        '    If Not IsDBNull(drTestCases) Then
        '        strResultHTML.Append("<OPTION value='" + drTestCases(0).ToString + "'>")
        '        strResultHTML.Append(drTestCases(1).ToString + "</OPTION>")
        '    End If
        'End While
        'CommonFunction.Data.DisposeDataReader(drTestCases)

        ''strResultHTML = CommonFunction.HTMLControls.DrawComboBox("cboCurrResult", "usp_Sel_combo_tbl_TCM_TestResultMaster", , , , True, True)

        m_strGridSQL = m_strGridSQL + ",'" + m_strOrderBy + "'"

        CommonFunction.General.WriteHTML("<input type=hidden id=hidOrderBy name=hidOrderBy value=" + m_strOrderBy + ">")
        CommonFunction.General.WriteHTML("<Input type=HIDDEN name='hidAddRemBKMK' id='hidAddRemBKMK' >")


        'CommonFunction.General.WriteHTML("<DIV Id=divListPageTag Style='HEIGHT:450px;OVERFLOW:auto; WIDTH:100%'><DIV Id=divListTag Style='overflow:auto;height:400px;width:100%;z-index=2;'>")
        ' CommonFunction.General.WriteHTML("<STYLE type=text/css>" + _
        '{TABLE " + _
        ' "{TABLE-LAYOUT: fixed;}" + _
        ' "THEAD TH.divListTag {POSITION: relative;}" + _
        ' "THEAD TH.divListTag.locked {POSITION: relative;}" + _
        ' "THEAD TH.divListTag {Z-INDEX: 10; ; TOP:expression(document.getElementById('divListTag').scrollTop -1)}" + _
        ' "THEAD TH.divListTag.locked {Z-INDEX: 30}" + _
        ' "TH.divListTag.locked {Z-INDEX: 10; ; LEFT:expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
        ' "}" + _
        ' " </STYLE>")
        ' CommonFunction.General.WriteHTML("<STYLE type=text/css>" + _
        '"{TABLE " + _
        '"{TABLE-LAYOUT: fixed;}" + _
        '"THEAD TH.Sort_divListTag {POSITION: relative;}" + _
        '"THEAD TH.Sort_divListTag.locked {POSITION: relative;}" + _
        '"THEAD TH.Sort_divListTag {Z-INDEX: 10; ; TOP:expression(document.getElementById('divListTag').scrollTop -1)}" + _
        '"THEAD TH.Sort_divListTag.locked {Z-INDEX: 30}" + _
        '"TH.Sort_divListTag.locked {Z-INDEX: 10; ; LEFT:expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
        '"THEAD TH.Sort_divListTag{border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: normal; font-size: 11px; padding-bottom: 1pt; border-left: thin; color: white; padding-top: 1pt; border-bottom: thin; font-family: Verdana, Arial; height: 22px; background: #3D5FA3; background-image: url(../../Images/bsImages/columnhdr_sel_bg.gif);}}" + _
        '" </STYLE>")

        ' CommonFunction.General.WriteHTML("<STYLE type=text/css>" + _
        ' "{TABLE " + _
        ' "{TABLE-LAYOUT: fixed;}" + _
        ' "THEAD TH.Separator_divListTag {POSITION: relative;}" + _
        ' "THEAD TH.Separator_divListTag.locked {POSITION: relative;}" + _
        ' "THEAD TH.Separator_divListTag {Z-INDEX: 10; ; TOP:expression(document.getElementById('divListTag').scrollTop -1)}" + _
        ' "THEAD TH.Separator_divListTag.locked {Z-INDEX: 30}" + _
        ' "TH.Separator_divListTag.locked {Z-INDEX: 10; ; LEFT:expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
        ' "THEAD TH.Separator_divListTag {border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: bolder; font-size: 1pt; background-image: none; padding-bottom: 1pt; border-left: thin; width: 1px; color: black; padding-top: 1pt; border-bottom: thin; height: 22px; background-color: #D3E4FB;}" + _
        ' "}" + _
        ' " </STYLE>")

        ' CommonFunction.General.WriteHTML("<STYLE type=text/css>{" + _
        '"TABLE {TABLE-LAYOUT: fixed;}" + _
        '"THEAD TH.divListTag_Column {POSITION: relative;}" + _
        '"THEAD TH.divListTag_Column.locked {POSITION: relative;}" + _
        '"THEAD TH.divListTag_Column.locked {Z-INDEX: 30}" + _
        '"THEAD TH.divListTag_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('divListTag').scrollTop -1)}" + _
        '"TH.divListTag_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
        ' "}</STYLE>")

        ' CommonFunction.General.WriteHTML("<STYLE type=text/css>{" + _
        '"TABLE {TABLE-LAYOUT: fixed;}" + _
        '"THEAD TH.Separator_divListTag_Column {POSITION: relative;}" + _
        '"THEAD TH.Separator_divListTag_Column.locked {POSITION: relative;}" + _
        '"THEAD TH.Separator_divListTag_Column.locked {Z-INDEX: 30}" + _
        '"THEAD TH.Separator_divListTag_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('divListTag').scrollTop -1)}" + _
        '"TH.Separator_divListTag_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
        '"THEAD TH.Separator_divListTag {border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: bolder; font-size: 1pt; background-image: none; padding-bottom: 1pt; border-left: thin; width: 1px; color: black; padding-top: 1pt; border-bottom: thin; height: 22px; background-color: #D3E4FB;}" + _
        ' "}</STYLE>")

        ' CommonFunction.General.WriteHTML("<STYLE type=text/css>{" + _
        ' "TABLE {TABLE-LAYOUT: fixed;}" + _
        ' "THEAD TH.Sort_divListTag_Column {POSITION: relative;}" + _
        ' "THEAD TH.Sort_divListTag_Column.locked {POSITION: relative;}" + _
        ' "THEAD TH.Sort_divListTag_Column.locked {Z-INDEX: 30}" + _
        ' "THEAD TH.Sort_divListTag_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('divListTag').scrollTop -1)}" + _
        ' "TH.Sort_divListTag_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
        ' "THEAD TH.Sort_divListTag_Column {border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: normal; font-size: 11px; padding-bottom: 1pt; border-left: thin; color: white; padding-top: 1pt; border-bottom: thin; font-family: Verdana, Arial; height: 22px; background: #3D5FA3; background-image: url(../../Images/bsImages/columnhdr_sel_bg.gif);}" + _
        ' " }</STYLE>")

        ' CommonFunction.General.WriteHTML("<STYLE type=text/css>" + _
        ' "Td.Locked, th.Locked {" + _
        ' "left: expression(document.getElementById('divListTag').scrollLeft);" + _
        ' "position: relative;" + _
        ' "z-index: 5;" + _
        ' "}" + _
        ' "</STYLE>")

        CommonFunction.General.WriteHTML("<DIV Id=divPage Style='HEIGHT:400px;OVERFLOW:auto; WIDTH:100%'>")
        CommonFunction.General.WriteHTML("<Table class=clsGridTable cellSpacing=1 cellPadding=0 width='99.9%'> ")
        CommonFunction.General.WriteHTML("<THead class='clsTRColumnHeader'>")
        CommonFunction.General.WriteHTML("<TH  class='divListTag' align='Left' width=10px >")
        'Showing title
        CommonFunction.General.WriteHTML("<Img Border=0 src='../../Images/BookMark/BKMK.gif' align='top'>")
        CommonFunction.General.WriteHTML("</TH>")
        CommonFunction.General.WriteHTML("<TH  class='divListTag' align='Left' width=65% >")
        'Commented Order by Img
        ''If m_strOrderBy = "DESC" Then
        ''    CommonFunction.General.WriteHTML("<A Href=""JavaScript:SortBy('ASC')""><IMG Border=0  SRC='../../Images/Sort_Down.gif'></A>")
        ''Else
        ''    CommonFunction.General.WriteHTML("<A Href=""JavaScript:SortBy('DESC')""><IMG Border=0  SRC='../../Images/Sort_Up.gif'></A>")
        ''End If
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEST_CASE"))
        CommonFunction.General.WriteHTML("</TH>")
        CommonFunction.General.WriteHTML("<TH  class='Sort_divListTag' align='Left' nowrap >")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_RESULT"))
        CommonFunction.General.WriteHTML("</TH>")
        CommonFunction.General.WriteHTML("</THead>")





        drTestCases = CommonFunction.Data.GetDataReader(m_strGridSQL, MyBase.UseSQL)
        intpageSizeSkipCounter = 0
        intHidVarCounter = 1
        While drTestCases.Read()
            'If intpageSizeSkipCounter >= (m_intPageNumber - 1) * PageSize AND Then
            If Not IsDBNull(drTestCases("BookMarkID")) Then

                If blnIsShowAll Then
                    m_strAllBKMK_Info += "," + drTestCases("ProjectTestCaseID").ToString + ",1"
                Else
                    m_strAllBKMK_Info += "," + drTestCases("ProjectTestCaseID").ToString + "," + Math.Ceiling((intpageSizeSkipCounter + 1) / PageSize).ToString
                End If


                ''''m_strAllBKMK_Info += "," + drTestCases("ProjectTestCaseID").ToString + "," + Math.Ceiling((intpageSizeSkipCounter + 1) / PageSize).ToString
            End If



            If (intpageSizeSkipCounter >= (m_intPageNumber - 1) * PageSize And intpageSizeSkipCounter <= (Math.Abs(m_intPageNumber) * PageSize) - 1) _
                    Or Request.Form("hidIsShowAll") = "TRUE" Then
                'If intpageSizeSkipCounter = ((m_intPageNumber - 1) * PageSize) + PageSize Then
                '    Exit While
                'End If

                'Storing variable in hidden form for saving
                If Not IsDBNull(drTestCases("TestCaseResponseID")) Then
                    CommonFunction.General.WriteHTML("<input type=HIDDEN name='hidTestCaseResponseID" + intHidVarCounter.ToString + "' value='" + drTestCases("TestCaseResponseID").ToString + "'>")
                Else
                    CommonFunction.General.WriteHTML("<input type=HIDDEN name='hidTestCaseResponseID" + intHidVarCounter.ToString + "' value='NULL' >")
                End If
                CommonFunction.General.WriteHTML("<Input type=HIDDEN name='hidTestCaseID" + intHidVarCounter.ToString + "' value='" + drTestCases("ProjectTestCaseID").ToString + "'>")

                CommonFunction.General.WriteHTML("<TR class='" + strCssEven + "' valign=top>")

                'BookMark TD
                CommonFunction.General.WriteHTML("<TD width=10px Title='click here to add/remove bookmark' onclick=placeHolder_onClick(" + drTestCases("ProjectTestCaseID").ToString + ",'" + drTestCases("BookMarkID").ToString + "')>")
                If Not IsDBNull(drTestCases("BookMarkID")) Then

                    If m_strFirstBKMKCurrPage = "" Then
                        m_strFirstBKMKCurrPage = drTestCases("ProjectTestCaseID").ToString
                    End If

                    CommonFunction.General.WriteHTML("<A Name=BKMK" + drTestCases("ProjectTestCaseID").ToString + "></A>")
                    CommonFunction.General.WriteHTML("<IMG src=""../../Images/BookMark/BKMK.gif"" >")
                    ''Else
                    ''    CommonFunction.General.WriteHTML("<TD width=10px onclick=placeHolder_onClick(this,'" + IsDBNull(drTestCases("TestCaseResponseID")).ToString + "'," + drTestCases("TestCaseID").ToString + ",0)>")
                End If

                CommonFunction.General.WriteHTML("</TD>")


                CommonFunction.General.WriteHTML("<TD width=65%>")


                CommonFunction.General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width='100%'>")

                'Test Code
                CommonFunction.General.WriteHTML("<TR class='" + strCssEven + "'>")
                CommonFunction.General.WriteHTML("<TD valign=center width=115px align=right>")
                CommonFunction.General.WriteHTML("<B>Test Code:</B>")
                CommonFunction.General.WriteHTML("</TD><TD valign=top >")

                CommonFunction.General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width='100%'>")
                CommonFunction.General.WriteHTML("<TR class='" + strCssEven + "'><TD>")
                If Not IsDBNull(drTestCases("TestCaseCode")) Then
                    CommonFunction.General.WriteHTML(drTestCases("TestCaseCode").ToString)
                End If
                CommonFunction.General.WriteHTML("</TD><TD align=right>")
                'Show Detail Link
                CommonFunction.General.WriteHTML("<A href='JavaScript:showTestCaseDetails_onClick(" + drTestCases("ProjectTestCaseID").ToString + ")' Title='Click here to view Test case details'  >" + MyBase.GetResourceString("LNK_SHOW_DETAILS") + "</A>")

                CommonFunction.General.WriteHTML("</TD></TR></Table>")

                CommonFunction.General.WriteHTML("</TD></TR>")



                'Test Procedure
                'CommonFunction.General.WriteHTML("<BR>")
                CommonFunction.General.WriteHTML("<TR class='" + strCssEven + "'>")
                CommonFunction.General.WriteHTML("<TD valign=top align=right>")
                CommonFunction.General.WriteHTML("<B>Test Procedure:</B>")
                CommonFunction.General.WriteHTML("</TD><TD valign=top>")
                If Not IsDBNull(drTestCases("TestProcedure")) Then
                    CommonFunction.General.WriteHTML(drTestCases("TestProcedure").ToString)
                End If
                CommonFunction.General.WriteHTML("</TD></TR>")

                'Test Verification

                'CommonFunction.General.WriteHTML("<BR>")
                CommonFunction.General.WriteHTML("<TR class='" + strCssEven + "'>")
                CommonFunction.General.WriteHTML("<TD valign=top align=right>")
                CommonFunction.General.WriteHTML("<B>Verification:</B>")
                CommonFunction.General.WriteHTML("</TD><TD align=top>")
                If Not IsDBNull(drTestCases("VerificationProcedure")) Then
                    CommonFunction.General.WriteHTML(drTestCases("VerificationProcedure").ToString)
                End If
                CommonFunction.General.WriteHTML("</TD></TR></TABLE>")



                CommonFunction.General.WriteHTML("</TD>")



                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML("<DIV id='divresult'>")
                'Previous Result
                If Not IsDBNull(drTestCases("PrevTestResult")) Then
                    strToRestainCtrl = drTestCases("PrevTestResult").ToString
                Else
                    strToRestainCtrl = "-"
                End If

                CommonFunction.General.WriteHTML("<Table width=100% class=clsTable id='tblresult'>")
                CommonFunction.General.WriteHTML("<TR class='" + strCssEven + "'>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML("<B>Previous Result:</B>")
                CommonFunction.General.WriteHTML(strToRestainCtrl)

                CommonFunction.General.WriteHTML("</TD><TD align=right>")
                CommonFunction.General.WriteHTML("<A href='JavaScript:showTestCaseHistory_onClick(" + drTestCases("ProjectTestCaseID").ToString + ")' Title='Click here to view history of Test Case' >" + MyBase.GetResourceString("LNK_TEST_CASE_HISTORY") + "</A>")
                CommonFunction.General.WriteHTML("</TD></TR></TABLE>")

                'Current Result AND Issue Details
                'CommonFunction.General.WriteHTML("<BR>")

                CommonFunction.General.WriteHTML("<Table width=100% class=clsTable>")
                CommonFunction.General.WriteHTML("<TR class='" + strCssEven + "'>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML("<B>Current Result:</B>")
                If Not IsDBNull(drTestCases("CurrTestResultID")) Then
                    CommonFunction.HTMLControls.DrawComboBox("cboCurrResult" + intHidVarCounter.ToString, "usp_Sel_combo_tbl_TCM_TestResultMaster", , drTestCases("CurrTestResultID").ToString, "onchange = currResult_onChange(" + intHidVarCounter.ToString + ")", True)
                Else
                    CommonFunction.HTMLControls.DrawComboBox("cboCurrResult" + intHidVarCounter.ToString, "usp_Sel_combo_tbl_TCM_TestResultMaster", , , "onchange = currResult_onChange(" + intHidVarCounter.ToString + ")", True)
                End If

                CommonFunction.General.WriteHTML("</TD>")

                If Not IsDBNull(drTestCases("TestCaseResponseID")) Then
                    CommonFunction.General.WriteHTML("<TD id=TDIBDetails" + drTestCases("TestCaseResponseID").ToString + " align=right>")
                Else
                    CommonFunction.General.WriteHTML("<TD  align=right>")
                End If
                If Not IsDBNull(drTestCases("IssueID")) Then
                    CommonFunction.General.WriteHTML("<A href='JavaScript:showIssueDetails_onClick(" + drTestCases("IssueID").ToString + ",""" + CommonFunctions.Security.Token.GetToken(CType(drTestCases("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0") + """" + _
                    ")' Title='Click here to open Issue Details' >" + MyBase.GetResourceString("LNK_ISSUE_DETAILS") + "</A>")
                End If

                CommonFunction.General.WriteHTML("</TD></TR></TABLE>")




                'Test Run Time
                If Not IsDBNull(drTestCases("ActualStaffTime")) Then
                    strToRestainCtrl = drTestCases("ActualStaffTime").ToString
                Else
                    strToRestainCtrl = ""
                End If
                'CommonFunction.General.WriteHTML("<BR>")
                CommonFunction.General.WriteHTML("<B>Test run time(in Minutes):</B>")
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                CommonFunction.HTMLControls.DrawTextBox("txtActStaffTime" + intHidVarCounter.ToString, "txtActStaffTime" + intHidVarCounter.ToString, , 30, 4, strToRestainCtrl, "Right", , , , , , "onchange=time_onChange(" + intHidVarCounter.ToString + ")", EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
                'Notes
                If Not IsDBNull(drTestCases("Notes")) Then
                    strToRestainCtrl = drTestCases("Notes").ToString
                Else
                    strToRestainCtrl = ""
                End If
                ' CommonFunction.General.WriteHTML("<BR>")


                CommonFunction.General.WriteHTML("<Table class=clsTable> <TR class='" + strCssEven + "'><TD valign=top> ")
                CommonFunction.General.WriteHTML("<B>Notes:</B>")
                CommonFunction.General.WriteHTML("</TD><TD>")
                'CommonFunction.HTMLControls.DrawTextArea("txtNotes"  + intHidVarCounter.ToString, "txtNotes", , , , "frmTestCaseResponse", , , 200, 50, , strToRestainCtrl, , , , , , , "onchange=notes_onChange(" + intHidVarCounter.ToString + ")")
                strTempHold = intHidVarCounter.ToString
                CommonFunction.General.WriteHTML("<Textarea wrap=off  name='txtNotes" + strTempHold + "' id='txtNotes" + strTempHold + "' class='clsTextArea' style='OVERFLOW:scroll;width:200px  ; height:50px  ; text-align:Left' onchange=notes_onChange(" + strTempHold + ") >")
                CommonFunction.General.WriteHTML(strToRestainCtrl + "</Textarea>")
                CommonFunction.General.WriteHTML("<A Href=""JavaScript:preopentextdialog('frmTestCaseResponse','txtNotes" + strTempHold + "','txtNotes" + strTempHold + "','False','" + strTempHold + "')"" tabindex='-1'><img Border=0 valign=Top src='../../images/zoomin.gif' alt='Double click the text area to add more text'></img></a>")
                CommonFunction.General.WriteHTML("</TD></TR></table>")


                'MultiAttachment
                CommonFunction.General.WriteHTML("<TABLE class=clsTable><TR class=" + strCssEven + "><TD>")
                CommonFunction.General.WriteHTML("<A href='JavaScript:addAttachemnt(" + drTestCases("ProjectTestCaseID").ToString + "," + m_strTestSessionID + ")'>Attachments:</A>")
                CommonFunction.General.WriteHTML("</TD><TD>")
                CommonFunction.General.WriteHTML("<DIV id=lblAtt" + drTestCases("ProjectTestCaseID").ToString + ">")
                CommonFunction.General.WriteHTML(drTestCases("AttachedFileNos").ToString)
                CommonFunction.General.WriteHTML("</DIV>")
                CommonFunction.General.WriteHTML("</TD></TR></TABLE>")

                CommonFunction.General.WriteHTML("</DIV>")
                CommonFunction.General.WriteHTML("</TD>")

                CommonFunction.General.WriteHTML("</TR>")


                intHidVarCounter += 1
                'End If 'of  commented "exit while" if stmt
            End If
            intpageSizeSkipCounter += 1

            If strCssEven = "clsTREven" Then
                strCssEven = "clsTROdd"
            Else
                strCssEven = "clsTREven"
            End If
        End While

        CommonFunction.General.WriteHTML("</TABLE>")

        'Saving plotted no. of TestCases
        CommonFunction.General.WriteHTML("<input type=HIDDEN name='hidNoOfTestCases' value='" + intHidVarCounter.ToString + "'>")
        'Modified By VarunA on 25-Sep-2008 IssueID-22556
        'Purpose : To have id for hiiden value (Mozilla)
        'CommonFunction.General.WriteHTML("<input type=HIDDEN name='hidNoOfAlteredTestCases' >")
        CommonFunction.General.WriteHTML("<input type=HIDDEN id='hidNoOfAlteredTestCases' name='hidNoOfAlteredTestCases' >")
        'End By VarunA on 25-Sep-2008 IssueID-22556

        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.Data.DisposeDataReader(drTestCases)

    End Sub
    Private Sub DrawPaging()
        '=====================================================================
        ' Procedure Name        : DrawPageFiltersPaging()
        ' Purpose               : Plotting  Numeric Paging controls.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : Feb 3, 2006
        ' Revisions             :
        '=====================================================================
        ''''If m_intPageNumber <= 0 Then
        ''''    CommonFunction.General.WriteHTML(MyBase.GetResourceString("PAGE"))

        ''''    CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 30, 4, "", "right", tobeinserted:=" onkeypress=txtPageNumber_KeyPress(event)")
        ''''Else
        ''''    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PAGE"))
        ''''    CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 30, 4, m_intPageNumber.ToString, "right", tobeinserted:=" onkeypress=txtPageNumber_KeyPress(event)")
        ''''End If
        ''''CommonFunctions.General.WriteHTML(" of " + m_intTotalNoOfPages.ToString)

        ''''CommonFunctions.General.WriteHTML("<A  title='Previous Page'  style='TEXT-DECORATION: none' ")
        ''''CommonFunctions.General.WriteHTML(" href = 'Javascript:NumPageing_OnClick(-1)'>")
        ''''CommonFunctions.General.WriteHTML(" <IMG id='imgPrev' src='../../Images/NumNavPreviousEnable.gif' align=top border=0></A> ")


        ''''CommonFunctions.General.WriteHTML("<A  title='Next Page'  style='TEXT-DECORATION: none' ")
        ''''CommonFunctions.General.WriteHTML(" href = 'Javascript:NumPageing_OnClick(1)'>")
        ''''CommonFunctions.General.WriteHTML(" <IMG id='imgNext' src='../../Images/NumNavNextEnable.gif' align=top border=0></A> ")


        ''''CommonFunctions.General.WriteHTML("|<A href='javascript:NumPageing_OnClick(0)' TITLE='Show All Records'><B>All</B> </A>")

        CommonFunction.General.WriteHTML("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:NumPageing_OnClick('F')"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        Response.Write("<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>")
        Response.Write("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:NumPageing_OnClick(-1)"" Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        Response.Write("<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>")


        If m_intPageNumber <= 0 Then
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", "clsNewTextBox", 50, , "", "right", ToBeInserted:=" onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True))
        Else
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", "clsNewTextBox", 50, , m_intPageNumber.ToString, "right", ToBeInserted:=" onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If

        Response.Write("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:NumPageing_OnClick(1)"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        Response.Write("<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>")

        Response.Write("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:NumPageing_OnClick('L')"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        Response.Write("<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A>")
        Response.Write(" of " + m_intTotalNoOfPages.ToString)

        Response.Write("|<A href='javascript:NumPageing_OnClick(0)' TITLE='Show All Records'><B>All</B> </A>")

        CommonFunction.General.WriteHTML("<input type=hidden id=hidNoOfPages name=hidNoOfPages value = " + m_intTotalNoOfPages.ToString + ">")





        CommonFunction.General.WriteHTML("")
    End Sub
    Private Sub SaveData()
        '=====================================================================
        ' Procedure Name        : DrawPageFiltersPaging()
        ' Purpose               : Saving Data.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : Feb 7, 2006
        ' Revisions             :
        '=====================================================================
        Dim intcounter As Integer
        intcounter = 0
        Dim strTestCasesID_Nos As String
        Dim strInsUpdSQL As String
        Dim strNotes As String = ""
        Dim strCurrResult As String
        Dim strTime As String
        strTestCasesID_Nos = Request.Form("hidNoOfAlteredTestCases")
        Dim arr_strTestCasesID_Nos() As String = strTestCasesID_Nos.Split(CChar(","))

        While intcounter < arr_strTestCasesID_Nos.Length
            strNotes = Request.Form("txtNotes" + arr_strTestCasesID_Nos(intcounter))
            strNotes = strNotes.Replace("'", "''")
            strTime = Request.Form("txtActStaffTime" + arr_strTestCasesID_Nos(intcounter))
            If strTime.Trim = "" Then
                strTime = "NULL"
            Else
                strTime = "'" + strTime + "'"
            End If

            If Request.Form("cboCurrResult" + arr_strTestCasesID_Nos(intcounter)) = "" Then
                strCurrResult = "NULL"
            Else
                strCurrResult = Request.Form("cboCurrResult" + arr_strTestCasesID_Nos(intcounter))
            End If

            If Request.Form("hidTestCaseResponseID" + arr_strTestCasesID_Nos(intcounter)) = "NULL" Then
                strInsUpdSQL = "usp_InsUpd_tbl_TCM_TestCaseResponses NULL," + m_strTestSessionID + "," + _
                                m_intProjectID.ToString + "," + Request.Form("hidTestCaseID" + arr_strTestCasesID_Nos(intcounter)) + "," + _
                                strCurrResult + "," + _
                                 strTime + _
                                ",'" + strNotes + "'," + Session("intUserID").ToString
            Else
                strInsUpdSQL = "usp_InsUpd_tbl_TCM_TestCaseResponses " + Request.Form("hidTestCaseResponseID" + arr_strTestCasesID_Nos(intcounter)) + "," + m_strTestSessionID + "," + _
                                m_intProjectID.ToString + "," + Request.Form("hidTestCaseID" + arr_strTestCasesID_Nos(intcounter)) + "," + _
                                strCurrResult + "," + _
                                strTime + _
                                ",'" + strNotes + "'," + Session("intUserID").ToString
            End If

            intcounter += 1
            CommonFunction.Data.InsertOrUpdateData(strInsUpdSQL, MyBase.UseSQL)


        End While
    End Sub
    Private Sub DrawBookMarks()
        'CommonFunction.General.WriteHTML("<DIV id=divBK>")
        CommonFunction.General.WriteHTML("<Table class=clsTable id=divBKTbl><TR class=clsTREven><TD id=tdPrevBKMK >Previous")
        CommonFunction.General.WriteHTML("<A id=prevBKMK onblur=onBlurBKMK('prev') onclick=onClickBKMK('prev') style='TEXT-DECORATION:NONE' HREF=""#Book1"" Title=""Move the caret to the previous bookmark"" onmouseover=""window.status='Previous Bookmark';return true;"" onmouseout=""window.status=' ';return true;"">")
        Response.Write("<Img Border=0 src='../../Images/BookMark/PrevBKMK.gif' align='top'></A>")
        CommonFunction.General.WriteHTML("</TD><TD id=tdNextBKMK >Next")
        CommonFunction.General.WriteHTML("<A id=nextBKMK onblur=onBlurBKMK('next') onclick=onClickBKMK('next') style='TEXT-DECORATION:NONE' HREF=""#Book2"" Title=""Move the caret to the next bookmark"" onmouseover=""window.status='Next Bookmark';return true;"" onmouseout=""window.status=' ';return true;"">")
        Response.Write("<Img Border=0 src='../../Images/BookMark/NextBKMK.gif' align='top'></A>")
        'CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.General.WriteHTML("</TR></Table>")

    End Sub
    Private Sub SaveBookMark()
        Dim strBKMK_SaveInfo() As String = Request.Form("hidAddRemBKMK").Split(CChar(","))
        'strBKMK_SaveInfo(0) - BookId
        'strBKMK_SaveInfo(1) - TestCaseID
        If strBKMK_SaveInfo(0) = "0" Then
            CommonFunction.Data.InsertOrUpdateData("usp_InsDel_tbl_TCM_TestCaseResponses_BookMarks NULL," + Session("intUserID").ToString + "," + m_strTestSessionID + "," + strBKMK_SaveInfo(1), MyBase.UseSQL)

        Else
            CommonFunction.Data.InsertOrUpdateData("usp_InsDel_tbl_TCM_TestCaseResponses_BookMarks " + strBKMK_SaveInfo(0) + "," + Session("intUserID").ToString + "," + m_strTestSessionID + "," + strBKMK_SaveInfo(1), MyBase.UseSQL)

        End If



    End Sub
    Private Sub BookMarkInitalization()
        CommonFunction.General.WriteHTML("<INPUT type=hidden id=allBKMK value=" + m_strAllBKMK_Info + ">")
        CommonFunction.General.WriteHTML("<INPUT type=hidden id=FirstBKMKCurrPage value=" + m_strFirstBKMKCurrPage + ">")
        ''''CommonFunction.General.WriteHTML("<INPUT type=hidden id=hidAddRemBKMK >")  'Used to add and remove book Mark

    End Sub
    ''Added by Yogesh J on 02-Mar-2016 for to generate  Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_showTestSetHistory(TestSetID As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(TestSetID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 02-Mar-2016
    ''Added by Yogesh J on 03-Mar-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_OpenIssue(TestSession As String, ProjectTestID As String, TestSectionID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(TestSession, String) + CType(ProjectTestID, String) + CType(TestSectionID, String) + "0" + "0")

        Return m_PKToken_Request_Multiple
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 03-Mar-2016 to generate and validate Token		
End Class
