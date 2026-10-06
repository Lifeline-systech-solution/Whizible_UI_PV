'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888
Public Class PT_OnSiteResources
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


    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Public m_strEmployeeName As String
    Public m_intEmployeeID As Integer
    Public m_strAlphabet As String
    Public strStartDate As String
    Public strEndDate As String
    Public strPagingHTML As String
    Public intCurrentPeriod As Integer
    Dim strQuery As String

    Public Sub PageInit()
        '######### Page Code starts here

        Dim intWorkingDays As Integer
        Dim dblWorkingHours As Double
        Dim strSQLQuery As String
        Dim drTimesheet As IDataReader
        Dim strAction As String

        Dim strPagingSQL As String
        Dim objPaging As WebPage.Templates.Paging

        'intCurrentPeriod = 0


        Dim strFromDate As String = ""
        Dim strToDate As String = ""

        CommonFunction.Dates.GetFromAndToDates("1", strFromDate, strToDate, CType(Now.Date, String))
        strToDate = DateAdd("d", 6, strFromDate).ToString("dd, MMM yyyy")
        strFromDate = DateAdd("d", -6, strToDate).ToString("dd, MMM yyyy")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'CommonFunction.HTMLControls.DrawTextBox("hdntxtToDate", "hdntxtToDate", , , , strToDate, , , , , , True)
        'CommonFunction.HTMLControls.DrawTextBox("hdntxtFromDate", "hdntxtFromDate", , , , strFromDate, , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("hdntxtToDate", "hdntxtToDate", , , , strToDate, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("hdntxtFromDate", "hdntxtFromDate", , , , strFromDate, , , , , , True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding


        'Modified By VidyaJ - IssueID - 11171
        If Request.QueryString("Alphabet") <> "" Then
            m_strAlphabet = Request.QueryString("Alphabet") + ""

            'Modified By VidyaJ - issueID- 11107
            If m_strAlphabet = "AND" Then
                m_strAlphabet = "&"
            End If
            If m_strAlphabet = "'" Then
                m_strAlphabet = "" & CommonFunctions.General.BuildQueryString(m_strAlphabet) & ""
            End If
        Else
            m_strAlphabet = "-1"
        End If

        'strAction = CType(HttpContext.Current.Request.QueryString("Action"), String)
        ''getting startdate and end date and depending upon that get the Work hours
        'strStartDate = HttpContext.Current.Request.QueryString("StartDate")
        'strEndDate = HttpContext.Current.Request.QueryString("EndDate")

        'If strAction = "GENERATE" Then
        '    AutoBookDA()
        'End If

        'If strAction = "APPROVE" Then
        '    AproveTimeSheet()
        'End If

        'If strAction = "DELETE" Then
        '    DeleteTimeSheet()
        'End If

        ''If the action is move previous
        'If strAction = "MOVE_PREVIOUS" Then
        '    strSQLQuery = "EXEC usp_GetFromAndToDates_ForSpecificFrequecy NULL,NULL,'" + strStartDate + "',-1"
        '    'If the action is move next
        'ElseIf strAction = "MOVE_NEXT" Then
        '    strSQLQuery = "EXEC usp_GetFromAndToDates_ForSpecificFrequecy NULL,NULL,'" + strEndDate + "',1"
        'Else
        '    If strStartDate Is Nothing And strEndDate Is Nothing Then
        '        strSQLQuery = "EXEC usp_GetFromAndToDates_ForSpecificFrequecy "
        '    ElseIf strStartDate <> "" And strEndDate <> "" Then
        '        strSQLQuery = "EXEC usp_GetFromAndToDates_ForSpecificFrequecy '" + strStartDate + "','" + strEndDate + "'"
        '    End If
        'End If

        'drTimesheet = CommonFunction.Data.GetDataReader(strSQLQuery, True)

        'Retrive the work hours and working days 
        'If drTimesheet.Read() Then
        '    strStartDate = CType(drTimesheet("StartDate"), String)
        '    strEndDate = CType(drTimesheet("EndDate"), String)
        '    intWorkingDays = CType(drTimesheet("Workingdays"), Integer)
        '    dblWorkingHours = CType(drTimesheet("WorkingHours"), Double)
        'End If

        'CommonFunction.Data.DisposeDataReader(drTimesheet)


        'Chek Whethere Perod is Current Period
        'Then dont allow to move next
        'Dim strCurStatDate As String
        'Dim strCurEndDate As String

        'drTimesheet = CommonFunction.Data.GetDataReader("EXEC usp_GetFromAndToDates_ForSpecificFrequecy", True)

        ''Retrive the work hours and working days 
        'If drTimesheet.Read() Then
        '    strCurStatDate = CType(drTimesheet("StartDate"), String)
        '    strCurEndDate = CType(drTimesheet("EndDate"), String)
        'End If

        'CommonFunction.Data.DisposeDataReader(drTimesheet)

        ''If period is Current Period then set the variable
        'If DateDiff(DateInterval.Day, CType(strCurStatDate, Date), CType(strStartDate, Date)) = 0 Then
        '    intCurrentPeriod = 1
        'Else
        '    intCurrentPeriod = 0
        'End If



        'Paging
        strPagingSQL = "EXEC usp_sel_ProxyUser_OnsiteResources_forPaging " + CType(Session("intUserID"), String)
        objPaging = New WebPage.Templates.Paging
        strPagingHTML = objPaging.DrawPaging(m_strAlphabet, strPagingSQL, , "Paging_OnClick", "EmployeeName", True)
        objPaging = Nothing

        'Passed Paramenter 1 for top Menu
        'Draw Paging in the Top Menu
        Call DrawMenu(1)

        'Page Caption
        CommonFunctions.General.WriteHTML("<BR>")
        WebPages.Template.PageCaption.GetPageCaptions(, "Onsite Resource Timesheets")
        CommonFunctions.General.WriteHTML("<BR>")

        Call DrawTimesheetGrid()

        Call drawFooterNote()
        Call DrawMenu(0)

    End Sub

    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

        MyBase.InitializeResources("AppResources.PT_OnSiteResources", "AppResources")
    End Sub

    Protected Sub drawFooterNote()
        
        CommonFunction.General.WriteHTML("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'><TD><b>Note</b> :Employee Name marked in <Font color=red>RED</Font> indicates either login is not created or login is inactive.</td></tr></table></br>")

    End Sub


    Public Sub DrawTimesheetGrid()
        '=====================================================================
        ' Procedure Name        : DrawTimesheetGrid()	
        ' Purpose               : Plots the grid displaying timesheets of employee
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 20,20004
        ' Revisions             :
        '=====================================================================


        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrCheckBoxes() As String = {"", "", "", ""}

        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"style='width:15%' align='left'"}
        Dim arrColRowLinks() As String = {""}
        Dim arrAlignment() As String = {"left"}


        'Modified By VidyaJ - for issueID - 11106
        strQuery = "usp_sel_ProxyUser_OnsiteResources " + CType(Session("intUserID"), String) + ",'" + m_strAlphabet + "'"

        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        arrColumnHeadingList.Add("Employee Name")
        'arrColumnHeadingList.Add("Status")
        'arrColumnHeadingList.Add("Project Name")
        'arrColumnHeadingList.Add("Work(hours)")
        'arrColumnHeadingList.Add("AutoBook & Generate")
        'arrColumnHeadingList.Add("Approve")
        'arrColumnHeadingList.Add("Delete")


        '##### Actual Column Names List
        arrActualColumnNames.Add("EmployeeName")
        'arrActualColumnNames.Add("Status")
        'arrActualColumnNames.Add("ProjectName")
        'arrActualColumnNames.Add("WorkHours")
        'arrActualColumnNames.Add("AutoBook")
        'arrActualColumnNames.Add("Approve")
        'arrActualColumnNames.Add("Delete")
        '##### End


        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxes
            .NoOfDataColumns = 1
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto;height:400px;width:100%;z-index=2;"
            .ColNameToolTipOnEachRow = True
            .DIVID = "PageDiv"
            .DIVHeight = 450
            .SQL = strQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .DrawGrid()
        End With
        m_objGrid = Nothing
    End Sub
    Private Sub DrawMenu(ByVal intTop As Integer)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VivekP
        ' Created               : 8 Oct 2005
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim strPageAlphabets As String

        m_objMenu = New WebPages.Template.StaticMenu



        'arrMenuCaptionsList.Add("Select All")
        'arrMenuToolTipsList.Add("Select All")
        'arrClientSideFunctionList.Add("SelectAll_OnClick()")

        'arrMenuCaptionsList.Add("Clear All")
        'arrMenuToolTipsList.Add("Clear All")
        'arrClientSideFunctionList.Add("ClearAll_OnClick()")

        'arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_PREVIOUS_PERIOD"))
        'arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_PREVIOUS_PERIOD_TOOLTIP"))
        'arrClientSideFunctionList.Add("Previous_OnClick()")


        'arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_NEXT_PERIOD"))
        'arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_NEXT_PERIOD_TOOLTOP"))
        'arrClientSideFunctionList.Add("Next_OnClick()")

        'arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_AUTOBOOK_GENERATE"))
        'arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_AUTOBOOK_GENERATE_TOOLTOP"))
        'arrClientSideFunctionList.Add("Generate_OnClick()")


        'arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_APPROVE"))
        'arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_APPROVE_TOOLTOP"))
        'arrClientSideFunctionList.Add("Approve_OnClick()")

        'arrMenuCaptionsList.Add("Delete")
        'arrMenuToolTipsList.Add("Delete")
        'arrClientSideFunctionList.Add("Delete_OnClick()")

        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add("Help")
        arrClientSideFunctionList.Add("Help_OnClick('PT_OnSiteResource')")

        'if the top menu then only draw paging, else no paging
        If intTop = 1 Then
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True, strPagingHTML)
        Else
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        End If

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VivekP
        ' Created               : 8 oct 2005
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    'Private Sub AutoBookDA()
    '    Dim strCheckBox As String
    '    Dim arrstrCheckBox() As String
    '    strCheckBox = HttpContext.Current.Request.Form("chkAutoBook")
    '    If strCheckBox Is Nothing Then
    '        strCheckBox = ""
    '    End If

    '    'Means the Action is AutoBook and Generate the Timesheet for Selected Employees
    '    'If StrCheckBox is having some value means checkboxes are selected
    '    'So Auto Book(Automatically fillup the DA for Selected Period) and Genearte the Timesheet
    '    Dim intCounter As Integer

    '    Dim intEmployeeID As String
    '    Dim dtmStartDate As Date
    '    Dim dtmEndDate As Date
    '    Dim intTimeSheetID As Integer
    '    Dim strSQLQuery As String
    '    Dim drTimesheet As IDataReader


    '    If strCheckBox <> "" Then
    '        arrstrCheckBox = strCheckBox.Split(CType(",", Char))

    '        dtmStartDate = CType(strStartDate, Date)
    '        dtmEndDate = CType(strEndDate, Date)

    '        For intCounter = 0 To arrstrCheckBox.Length - 1
    '            intTimeSheetID = 0
    '            intEmployeeID = arrstrCheckBox(intCounter)


    '            '##########################################################
    '            'AutoDABookUP

    '            'Check Whether DA is filled for that Period
    '            'If DA is already filled then skip usp_upd_AutoDABooking
    '            Dim isDAExists As Boolean
    '            isDAExists = False
    '            strSQLQuery = "SELECT DailyActivityEntryID FROM tbl_PM_DailyActivity WHERE (EntryDate BETWEEN '" + CType(dtmStartDate, String) + "' AND '" + CType(dtmEndDate, String) + "') AND EmployeeID =" + CType(intEmployeeID, String)
    '            drTimesheet = CommonFunction.Data.GetDataReader(strSQLQuery, True)
    '            'IF no DA Exists for that period then only Autobook DA
    '            If Not drTimesheet.Read() Then
    '                strSQLQuery = "EXEC usp_upd_AutoDABooking " + CStr(intEmployeeID) + ",'" + CStr(dtmStartDate) + "','" + CStr(dtmEndDate) + "'"
    '                drTimesheet = CommonFunction.Data.GetDataReader(strSQLQuery, True)
    '                CommonFunction.Data.DisposeDataReader(drTimesheet)
    '            Else
    '                isDAExists = True
    '            End If
    '            CommonFunction.Data.DisposeDataReader(drTimesheet)

    '            'Check Whether Timesheet already Exists for that period
    '            'If Timesheet Exists then Pass new Timesheet ID 
    '            drTimesheet = CommonFunction.Data.GetDataReader("SELECT TimesheetID FROM tbl_PM_ResourceTimesheet WHERE DATEDIFF(DD,FromDate,'" + CStr(dtmStartDate) + "')=0  AND DATEDIFF(DD,ToDate,'" + CStr(dtmEndDate) + "') = 0 AND EmployeeID = " + CType(intEmployeeID, String), True)
    '            If drTimesheet.Read() Then
    '                intTimeSheetID = CType(drTimesheet("TimesheetID"), Integer)
    '            Else
    '                intTimeSheetID = 0
    '            End If
    '            CommonFunction.Data.DisposeDataReader(drTimesheet)


    '            strSQLQuery = "SELECT DailyActivityEntryID FROM tbl_PM_DailyActivity WHERE (EntryDate BETWEEN '" + CType(dtmStartDate, String) + "' AND '" + CType(dtmEndDate, String) + "') AND EmployeeID =" + CType(intEmployeeID, String)
    '            drTimesheet = CommonFunction.Data.GetDataReader(strSQLQuery, True)
    '            'IF no DA Exists for that period then only Autobook DA
    '            If drTimesheet.Read() Then
    '                isDAExists = True
    '            Else
    '                isDAExists = False
    '            End If
    '            CommonFunction.Data.DisposeDataReader(drTimesheet)



    '            'Code Added by SantoshK on 25th Nov 2005
    '            'If DA Exists then only Generate the Timesheet Otherwise Dont Generate the Timesheet
    '            If isDAExists = True Then
    '                'Generate Timesheet
    '                strSQLQuery = "EXEC usp_GenerateResourceTimeSheet " + CStr(intEmployeeID) + ",'" + CStr(dtmStartDate) + "','" + CStr(dtmEndDate) + "'," + CStr(intTimeSheetID)
    '                drTimesheet = CommonFunction.Data.GetDataReader(strSQLQuery, True)
    '                If drTimesheet.Read Then
    '                    intTimeSheetID = CType(CommonFunction.Data.CheckIsDBNull(drTimesheet("TimesheetID"), "0"), Integer)
    '                End If
    '                CommonFunction.Data.DisposeDataReader(drTimesheet)


    '                'Send for Approval
    '                Dim drEmailMessage As IDataReader
    '                Dim blnSendEmail As Boolean, blnShowPopup As Boolean
    '                Dim strFromEmailID As String
    '                Dim strToEmailID As String
    '                Dim strCCEmailID As String
    '                Dim strSubject As String
    '                Dim strMessage As String

    '                strSQLQuery = "EXEC usp_Upd_ProxyTimesheetStatus " + CStr(intTimeSheetID) + ",'R'" + "," + CType(Session("intUserID"), String)

    '                drTimesheet = CommonFunction.Data.GetDataReader(strSQLQuery, True)
    '                If drTimesheet.Read Then
    '                    intTimeSheetID = CType(CommonFunction.Data.CheckIsDBNull(drTimesheet("TimesheetID"), "0"), Integer)
    '                End If
    '                CommonFunction.Data.DisposeDataReader(drTimesheet)

    '                '--- Set the StatusCode of the Timesheet to STATUS_READY_FOR_VERIFICATION
    '                'm_strTimesheetStatus = STATUS_READY_FOR_VERIFICATION

    '                strSQLQuery = "usp_Sel_tbl_PM_EmailMessages 5000"
    '                drEmailMessage = CommonFunctions.Data.GetDataReader(strSQLQuery, True)

    '                If drEmailMessage.Read Then
    '                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
    '                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
    '                End If
    '                CommonFunctions.Data.DisposeDataReader(drEmailMessage)

    '                ' Check if the mail has to be sent.
    '                If blnSendEmail = True Then
    '                    ' Check if a popup message has to be shown.
    '                    If blnShowPopup = True Then
    '                        CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
    '                        CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=5000&TimesheetID=" + intTimeSheetID.ToString + "&ResourceID=" + CType(intEmployeeID, String) + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
    '                        CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
    '                        ' Else, if the mail has to be sent silently, then...
    '                    Else
    '                        'TO DO: SEND EMAIL MESSAGE WITH CC
    '                        'CommonFunction.EmailMessages.ProxyTimehsheetMessages.GetEmailMessage_5000(strFromEmailID, strToEmailID, strCCEmailID, strSubject, strMessage, intTimeSheetID)
    '                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage)

    '                    End If
    '                End If
    '            End If
    '            '##########################################################
    '        Next intCounter
    '    End If
    'End Sub

    'Private Sub AproveTimeSheet()
    '    Dim strEmployeeList As String
    '    Dim strSQL As String


    '    strEmployeeList = HttpContext.Current.Request.Form("chkApprove")

    '    If Not strStartDate Is Nothing And Not strEndDate Is Nothing Then
    '        If Not strEmployeeList Is Nothing Then
    '            Dim strchkEmployees As String() = strEmployeeList.Split(CType(",", Char))
    '            Dim strEmployee As String
    '            Dim strTest As String
    '            For Each strEmployee In strchkEmployees
    '                'Call Approve Timesheet Procedure for Each Employee
    '                strSQL = "usp_ApproveProxyTimesheet " + strEmployee + ",'" + strStartDate + "','" + strEndDate + "'," + CType(HttpContext.Current.Session("intUserID"), String)
    '                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
    '            Next
    '            'Addition Ends by SantoshK on 18th Oct 2005
    '        End If
    '    End If
    'End Sub

    'Private Sub DeleteTimeSheet()
    '    Dim strEmployeeList As String
    '    Dim strSQL As String


    '    strEmployeeList = HttpContext.Current.Request.Form("chkDelete")

    '    If Not strStartDate Is Nothing And Not strEndDate Is Nothing Then
    '        If Not strEmployeeList Is Nothing Then
    '            Dim strchkEmployees As String() = strEmployeeList.Split(CType(",", Char))
    '            Dim strEmployee As String
    '            Dim strTest As String
    '            For Each strEmployee In strchkEmployees
    '                'Call Approve Timesheet Procedure for Each Employee
    '                strSQL = "usp_del_ProxyTimesheet " + strEmployee + ",'" + strStartDate + "','" + strEndDate + "'," + CType(HttpContext.Current.Session("intUserID"), String)
    '                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
    '            Next
    '            'Addition Ends by SantoshK on 18th Oct 2005
    '        End If
    '    End If
    'End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'Modified by NitinVS on 9Aug 2007 for WhizibleSEM 7 
        'To verify active login for the resource else remove link.
        If Args.DataField.ToUpper = "EMPLOYEENAME" Then
            '        Args.StringToBeInserted = "<TD></TD>"
            Dim strLoginId As String
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strLoginId = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("if exists ( SELECT LoginID FROM tbl_PM_Login WHERE IsActiveLogin=1 AND EmployeeID = " + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OnsiteResourceID"), "0"), String) + " ) SELECT 1 ELSE SELECT 0 ", MyBase.UseSQL), ""), "")
            strLoginId = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Login_emp " + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OnsiteResourceID"), "0"), String), MyBase.UseSQL), ""), "")

            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            'CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(

            If strLoginId = "1" Then

                Args.StringToBeInserted = "<TD Align='Left'> <a href='javascript:ViewEDITPage(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OnsiteResourceID"), "0"), String) + ")'>" + CType(Args.DataReader.Item("EmployeeName"), String) + "</a> </TD>"
                m_intEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OnsiteResourceID"), "0"), Integer)
                Cancel = True

            Else

                Args.StringToBeInserted = "<TD Align='Left' style='color:red'> " + CType(Args.DataReader.Item("EmployeeName"), String) + " </TD>"
                m_intEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OnsiteResourceID"), "0"), Integer)
                Cancel = True


            End If

        End If

        '    If Args.DataField.ToUpper = "AUTOBOOK" Then
        '        Args.StringToBeInserted = "<TD></TD>"
        '        Cancel = True
        '    End If

        '    If Args.DataField.ToUpper = "APPROVE" Then
        '        Args.StringToBeInserted = "<TD></TD>"
        '        Cancel = True
        '    End If

        '    If Args.DataField.ToUpper = "STATUS" Then
        '        Args.StringToBeInserted = "<TD></TD>"
        '        Cancel = True
        '    End If

        '    If Args.DataField.ToUpper = "DELETE" Then
        '        Args.StringToBeInserted = "<TD></TD>"
        '        Cancel = True
        '    End If

        '    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), String) = "" Then
        '        If Args.DataField.ToUpper = "PROJECTNAME" Then
        '            Args.StringToBeInserted = "<TD></TD>"
        '            Cancel = True
        '        End If

        '        If Args.DataField.ToUpper = "WORKHOURS" Then
        '            Args.StringToBeInserted = "<TD></TD>"
        '            Cancel = True
        '        End If
        '    End If

    End Sub
    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        '    Dim drTimesheet As IDataReader
        '    Dim intTimesheetID As Integer

        '    Dim strGenerateCheckBox As String
        '    Dim strApproveCheckBox As String
        '    Dim strDeleteCheckBox As String

        '    Dim strStatus As String


        '    If m_intEmployeeID <> CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OnsiteResourceID"), "0"), Integer) Then
        '        'Getting the TimesheetID falling in that Period
        '        drTimesheet = CommonFunction.Data.GetDataReader("SELECT TimesheetID FROM tbl_PM_ResourceTimesheet WHERE DATEDIFF(DD,FromDate,'" + strStartDate + "')=0  AND DATEDIFF(DD,ToDate,'" + strEndDate + "') = 0 AND EmployeeID = " + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OnsiteResourceID"), "0"), String), True)
        '        If drTimesheet.Read() Then
        '            intTimesheetID = CType(drTimesheet("TimesheetID"), Integer)
        '        Else
        '            intTimesheetID = 0
        '        End If
        '        CommonFunction.Data.DisposeDataReader(drTimesheet)

        '        'Modified by VivekP On 22 Nov 2005 For Timesheet Status
        '        'Getting the Grid Formatting Rules for the Checkboxes
        '        drTimesheet = CommonFunction.Data.GetDataReader("EXEC usp_sel_GridFormattingForProxyTimesheet " + CType(Session("intUserID"), String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OnsiteResourceID"), "0"), String) + ",'" + strStartDate + "','" + strEndDate + "'," + intTimesheetID.ToString, True)
        '        'End Of Modification
        '        If drTimesheet.Read() Then
        '            'Generate Checkbox
        '            If CType(drTimesheet("IsGenerate"), Integer) = 0 Then
        '                strGenerateCheckBox = " disabled"
        '            Else
        '                strGenerateCheckBox = ""
        '            End If
        '            'Approve CheckBox
        '            If CType(drTimesheet("IsApprove"), Integer) = 0 Then
        '                strApproveCheckBox = " disabled"
        '            Else
        '                strApproveCheckBox = ""
        '            End If

        '            'Delete CheckBox
        '            If CType(drTimesheet("IsDelete"), Integer) = 0 Then
        '                strDeleteCheckBox = " disabled"
        '            Else
        '                strDeleteCheckBox = ""
        '            End If

        '            'Added by VivekP On 22 Nov 2005 For Timesheet Status
        '            If CType(drTimesheet("Status"), String) <> "" Then
        '                strStatus = CType(drTimesheet("Status"), String)
        '            Else
        '                strStatus = ""
        '            End If
        '            'End Of Addition

        '        End If
        '        CommonFunction.Data.DisposeDataReader(drTimesheet)

        'Args.StringToBeInserted = "<tr class='clsTROdd' valign=top><TD Align='Left'> <a href='javascript:ViewEDITPage(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OnsiteResourceID"), "0"), String) + ")'>" + CType(Args.DataReader.Item("EmployeeName"), String) + "</a> </TD></TR>"
        'Getting into public variable
        'm_intEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OnsiteResourceID"), "0"), Integer)
        '    End If
        'End Sub

    End Sub
End Class
'Addition End by SantoshK on 20th March 2006