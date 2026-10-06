Imports CommonFunctions
Imports System.Globalization
'**********************************************************************************
'                  CSPL Code Header
' Project Name     :	Chanakya
' Module Name      :	TaskSelection.asp
' Purpose          :	Facilitates user to select the Task.
' Description      :	Same as above.
' Assumptions      :	None.
' Dependencies     :	
' Author           :	PrasannaP
' Reviewed         :	
' Tested           :	
' Created          :	23rd Feb 2004
' Revisions        :			
'**********************************************************************************

Public Class PM_TaskSelection
    Inherits WebPages.Template.WhizTemplate

#Region " Variable Declaration "
    '=====================================================================
    ' VARIABLE DECLARATIONS.
    '=====================================================================
    Protected Const PROJECT_SPECIFIC_TASKS As String = "M"
    Protected Const GENERAL_TASKS As String = "D"
    Protected Const ASSIGNED_TASKS As String = "O"
    Protected Const DEFECTS_ASSIGNED As String = "B"
    Protected Const ALL_TASK_TYPES As String = "A"
    Protected m_strWindowTitle As String
    Protected m_strPageNumber As String

    Private WithEvents m_objPaging As New WebPages.Template.Paging
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Private m_strPagingAlphabet As String = ""
    Private m_strSessionUserID As String        'For storing the User ID from Session
    Private m_strSessionPostID As String        'For storing the Post ID from Session
    Private m_strSessionClientDate As String    'For storing the Client Date from Session
    Private strSQLQuery, strLinkQuery As String
    Private m_intProjectID As Integer
    Private m_blnIncludeCompletedTasks As Boolean
    Private m_strSortByField, m_strAscOrDesc As String
    Private m_blnTaskTypesApplicable As Boolean
    Private m_intTaskTypeID As Integer
    Private m_strTaskTypeName As String
    Private m_drProject As IDataReader
    Private m_drTaskType As IDataReader

    Private m_strDefaultSortField As String = "A.TaskName"
    Private m_strDefaultSortOrder As String = "ASC"

    Public m_strQSParameters As String = "Task Selection"
    Public m_strTaskType As String

    Protected m_strPKToken As String





#End Region

#Region " Page Initialization Function "

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strWindowTitle = MyBase.GetResourceString("PAGE_TITLE")


    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : Init Function 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 23, 2004
        ' Revisions             :
        '=====================================================================

        m_strSessionUserID = CType(Session("intUserID"), String)
        m_strSessionPostID = CType(Session("intPostID"), String)
        m_strSessionClientDate = CType(Session("ClientDate"), String)

        If Trim(Request("txtSortField")) <> "" Then
            m_strSortByField = Trim(Request("txtSortField"))
            m_strAscOrDesc = Trim(Request("txtSortOrder"))
        Else
            m_strSortByField = m_strDefaultSortField
            m_strAscOrDesc = m_strDefaultSortOrder
        End If

        ' Retrieve the Project ID.


        If Request.QueryString("PKToken") <> "" Then
            m_strPKToken = CType(Request.QueryString("PKToken"), String)
        End If

        If Request.QueryString("ProjectID") <> "" Then
            m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)
        Else
            m_intProjectID = 0
        End If

        m_strQSParameters = "&ProjectID=" & m_intProjectID
        If Trim(Request.QueryString("FromWhere")) <> "" Then
            m_strQSParameters = m_strQSParameters & "&FromWhere=" & Trim(Request.QueryString("FromWhere"))
        End If

        ' Retrieve the Task Type.
        If Request.QueryString("TaskType") <> "" Then
            m_strTaskType = Request.QueryString("TaskType")
        ElseIf MyBase.GetFormValue("optTasks") <> "" Then
            m_strTaskType = FixString(MyBase.GetFormValue("optTasks"), 0, False, True)
        Else
            m_strTaskType = PROJECT_SPECIFIC_TASKS
        End If

        ' Modified By NitinVS on 15 Apr 2005 for Da Wincey Customization Request
        m_blnTaskTypesApplicable = True
        '' Check whether Task Types are applicable for the current project.
        'm_blnTaskTypesApplicable = False
        'm_drProject = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " & m_intProjectID, MyBase.UseSQL)
        'If m_drProject.Read Then
        '    m_blnTaskTypesApplicable = CType(CommonFunctions.Data.CheckIsDBNull(m_drProject("HaveSubTaskTypes"), "0"), Boolean)
        'End If
        'CommonFunctions.Data.DisposeDataReader(m_drProject)
        ' End Modification By NitinVS on 15 Apr 2005 for Da Wincey Customization Request

        If m_blnTaskTypesApplicable Then

            ' Retrieve the Task Type ID.
            If MyBase.GetFormValue("cboTaskType") <> "" Then
                m_intTaskTypeID = CType(FixString(MyBase.GetFormValue("cboTaskType"), 0, True, True), Integer)
            ElseIf Request.QueryString("TaskTypeID") <> "" Then
                m_intTaskTypeID = CType(Request.QueryString("TaskTypeID"), Integer)
            Else
                m_intTaskTypeID = 0
            End If

            ''added by Nilesh g on 5/2/2016 for url issue
            If (m_strPKToken <> "" And (CommonFunctions.Security.Token.ValidateToken(CType(m_strTaskType, String) + CType(m_intProjectID, String) + CType(m_intTaskTypeID, String) + "0" + "0", m_strPKToken) = False)) Then
                '' Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_strPKToken, String))
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
            ''added by Nilesh g on 5/2/2016 for url issue

            ' Get the name of the selected Task Type.	
            m_drTaskType = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_TaskTypes " & m_intTaskTypeID, MyBase.UseSQL)
            If m_drTaskType.Read Then
                m_strTaskTypeName = CType(CommonFunctions.Data.CheckIsDBNull(m_drTaskType("TaskType"), ""), String)
            End If
            CommonFunctions.Data.DisposeDataReader(m_drTaskType)

        End If

        If InStr(1, Request("IncludeCompletedTasks"), "1") <> 0 Then
            m_blnIncludeCompletedTasks = True
        Else
            m_blnIncludeCompletedTasks = False
        End If

        ' Get the currently selected page number.
        If Not Page.IsPostBack Then
            m_strPageNumber = CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(FixString(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidPageNo_TaskSelection")), 0, False, False)))
        Else
            m_strPageNumber = CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(FixString(CommonFunctions.General.CheckIsNothing(Request.QueryString("PageNumber")), 0, False, False)))
        End If
        If m_strPageNumber = "" Then m_strPageNumber = "-1"
        'Added by PrashantD on 27 March 2007 for WhizibleSem Regession Testing IssueID 11133
        'strSQLQuery = "usp_Sel_tbl_PM_ProjectTasks_ForSimpleDA " & m_intProjectID & "," & m_strSessionUserID
        If Request.QueryString("FromWhere") <> "TaskTypeTimesheet" Then
            strSQLQuery = "usp_Sel_tbl_PM_ProjectTasks_ForSimpleDA " & m_intProjectID & "," & m_strSessionUserID
        Else
            strSQLQuery = "usp_Sel_tbl_PM_ProjectTasks_ForTaskTypeTimesheet " & m_intProjectID & "," & m_strSessionUserID
        End If
        'End of addition by PrashantD

        Select Case m_strTaskType
            Case DEFECTS_ASSIGNED
                strSQLQuery = strSQLQuery & ",1,NULL,NULL,NULL"
            Case GENERAL_TASKS
                strSQLQuery = strSQLQuery & ",NULL,1,NULL,NULL"
            Case PROJECT_SPECIFIC_TASKS
                strSQLQuery = strSQLQuery & ",NULL,NULL,1,NULL"
            Case ASSIGNED_TASKS
                strSQLQuery = strSQLQuery & ",NULL,NULL,NULL,1"
            Case Else
                strSQLQuery = strSQLQuery & ",NULL,NULL,1,NULL"
        End Select
        strSQLQuery = strSQLQuery & ",NULL, NULL, NULL, 1, NULL"

        strSQLQuery = strSQLQuery & ", ' "
        'Added following if condition and else block for IssueID 11133 by PrashantD 
        If Request.QueryString("FromWhere") <> "TaskTypeTimesheet" Then
            If Not m_blnIncludeCompletedTasks Then
                strSQLQuery = strSQLQuery & "AND IsTaskComplete = 0 "
            End If
        Else
            strSQLQuery = strSQLQuery & "AND A.IsTaskComplete = 0 "
        End If
        'Modified By nitinVs on 16 Apr 2007 for whizibleSEM SP 8 Regression Fixes IssueID 12535 
        'Handled single quote for module name 

        If m_blnTaskTypesApplicable Then
            If m_intTaskTypeID <> 0 Then
                'strSQLQuery = strSQLQuery & "AND ModuleName = """ & m_strTaskTypeName & """ "
                'Added following if condition and else block for IssueID 11133 & 12504 by PrashantD 
                If Request.QueryString("FromWhere") <> "TaskTypeTimesheet" Then
                    If m_strTaskType = ASSIGNED_TASKS Then
                        strSQLQuery = strSQLQuery & "AND TaskTypeID = " & m_intTaskTypeID & " "
                    Else
                        strSQLQuery = strSQLQuery & "AND ModuleName = ''" & CommonFunction.General.BuildQueryString(m_strTaskTypeName) & "'' "
                    End If
                Else
                    If m_strTaskType = ASSIGNED_TASKS Then
                        strSQLQuery = strSQLQuery & "AND A.TaskTypeID = " & m_intTaskTypeID & " "
                    Else
                        strSQLQuery = strSQLQuery & "AND A.ModuleName = ''" & CommonFunction.General.BuildQueryString(m_strTaskTypeName) & "'' "
                    End If
                End If
            End If
        End If
        'End Modification By nitinVs on 16 Apr 2007 for whizibleSEM SP 8 Regression Fixes IssueID 12535 

        strLinkQuery = strSQLQuery
        Response.Write("<input type=""hidden"" id=""txtSortField"" name=""txtSortField"" value=""" & m_strSortByField & """>")
        Response.Write("<input type=""hidden"" id=""txtSortOrder"" name=""txtSortOrder"" value=""" & m_strAscOrDesc & """>")
        If m_blnIncludeCompletedTasks Then
            Response.Write("<INPUT id=""IncludeCompletedTasks"" name=""IncludeCompletedTasks"" type=""hidden"" value=""1"">")
        Else
            Response.Write("<INPUT id=""IncludeCompletedTasks"" name=""IncludeCompletedTasks"" type=""hidden"" value=""0"">")
        End If
        DrawMenu("Top")
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:450px'>")
        CommonFunctions.General.WriteHTML("<br>")
        DrawPage()
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunction.General.WriteHTML("</div>")
        DrawMenu("Bottom")
    End Sub
#End Region

#Region " Plots the Menu "
    Private Sub DrawMenu(ByVal strLocation As String)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 24, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim strPageAlphabets As String

        m_objMenu = New WebPages.Template.StaticMenu


        If strLocation = "Top" Then
            strLinkQuery = strLinkQuery & " ORDER BY " & m_strSortByField & " " & m_strAscOrDesc & "'"
            strLinkQuery = strLinkQuery & ", '-1'"

            ' Modified By NitinVS on 15 Apr 2005 for Da Wincey Customization Request
            'Modified By VivekP
            'If m_intTaskTypeID = 0 Then
            '    strLinkQuery = strLinkQuery & ", Null , " & "0"
            'Else
            '    strLinkQuery = strLinkQuery & ", Null ,  " + m_intTaskTypeID.ToString
            'End If
            'If m_intTaskTypeID = 0 Then
            '    strLinkQuery = strLinkQuery & ",0"
            'Else
            '    strLinkQuery = strLinkQuery & "," + m_intTaskTypeID.ToString
            'End If
            'end if modification
            ' end Modification By NitinVS on 15 Apr 2005 for Da Wincey Customization Request

            strPageAlphabets = m_objPaging.DrawPagingWithEvents(m_strPageNumber, strLinkQuery, "Select ", , "TaskName", True)
            If strPageAlphabets = "" Then m_strPageNumber = "-1"
        End If


        If m_strTaskType <> GENERAL_TASKS Then
            If m_blnIncludeCompletedTasks Then
                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOW_INCOMPLETE_TASKS"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOW_INCOMPLETE_TASKS"))
                arrClientSideFunctionList.Add("IncludeCompletedTasks(0)")
            Else
                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOW_ALL_TASKS"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOW_ALL_TASKS"))
                arrClientSideFunctionList.Add("IncludeCompletedTasks(1)")
            End If
        End If
        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrClientSideFunctionList.Add("Help_OnClick('DA_TASK_SELECTION')")

        If strLocation = "Top" Then
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True, strPageAlphabets)
        ElseIf strLocation = "Bottom" Then
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        End If

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
        strPageAlphabets = ""
    End Sub
#End Region

#Region " Generic Functions "
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
        ' Author                : PrasannaP
        ' Created               : Feb 24, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
#End Region

#Region " Page Draw Function "
    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()
        ' Purpose               : Function to draw the Page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 23, 2004
        ' Revisions             :
        '=====================================================================
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        Dim strHTML As String = ""

        strHTML = CommonFunction.HTMLControls.DrawOptionButton("optTasks", "optGeneralTasks", , m_strTaskType = GENERAL_TASKS, GENERAL_TASKS, , "Language=Javascript OnClick=Task_OnClick('" & GENERAL_TASKS & "')", True)
        strHTML = strHTML + MyBase.GetResourceString("GENERAL_TASK") + "&nbsp;&nbsp;&nbsp;"
        strHTML = strHTML + CommonFunction.HTMLControls.DrawOptionButton("optTasks", "optProjectTasks", , m_strTaskType = PROJECT_SPECIFIC_TASKS, PROJECT_SPECIFIC_TASKS, , "Language=Javascript OnClick=Task_OnClick('" & PROJECT_SPECIFIC_TASKS & "')", True)
        strHTML = strHTML + MyBase.GetResourceString("MPP_TASKS") + "&nbsp;&nbsp;&nbsp;"
        strHTML = strHTML + CommonFunction.HTMLControls.DrawOptionButton("optTasks", "optAssignedTasks", , m_strTaskType = ASSIGNED_TASKS, ASSIGNED_TASKS, , "Language=Javascript OnClick=Task_OnClick('" & ASSIGNED_TASKS & "')", True)
        strHTML = strHTML + MyBase.GetResourceString("ASSIGNED_TASKS") + "&nbsp;&nbsp;&nbsp;"
        strHTML = strHTML + CommonFunction.HTMLControls.DrawOptionButton("optTasks", "optDefectTasks", , m_strTaskType = DEFECTS_ASSIGNED, DEFECTS_ASSIGNED, , "Language=Javascript OnClick=Task_OnClick('" & DEFECTS_ASSIGNED & "')", True)
        strHTML = strHTML + MyBase.GetResourceString("ISSUES_ASSIGNED") + "&nbsp;&nbsp;&nbsp;"
        strHTML = strHTML + "</BR></BR>"

        If m_blnTaskTypesApplicable Then
            strHTML = strHTML + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("TASK_TYPE")
            strHTML = strHTML + "&nbsp;" + CommonFunction.HTMLControls.DrawComboBox("cboTaskType", "usp_Sel_tbl_PM_Project_TaskTypes " & m_intProjectID, 300, CType(m_intTaskTypeID, String), "Language=Javascript OnChange=TaskType_OnChange()", True, True)
        End If

        With cObjSectionTitle
            strHTML = .GetSectionTitle(strHTML, "", "", , , , , , , , , , False, False)
        End With

        CommonFunctions.General.WriteHTML(strHTML)

        DrawGrid()
    End Sub
#End Region

#Region " Plot Grid Function "
    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()
        ' Purpose               : Function to draw the Grid o the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 23, 2004
        ' Revisions             :
        '=====================================================================

        Dim drDailyActivity As IDataReader
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"style='width:40%'", "", "", "", ""}
        Dim arrColRowLinks() As String = {"LinkField_OnClick(TaskID)", "", "", "", ""}

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        m_strDefaultSortField = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"))
        m_strDefaultSortField = CommonFunctions.General.UnBuildQueryString(m_strDefaultSortField)
        m_strDefaultSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"))
        m_strDefaultSortOrder = CommonFunctions.General.UnBuildQueryString(m_strDefaultSortOrder)
        'Added by PrashantD on 27 March 2007 for WhizibleSem Regession Testing IssueID 11133
        'If m_strDefaultSortField = "" Then m_strDefaultSortField = "TaskName"
        If Request.QueryString("FromWhere") <> "TaskTypeTimesheet" Then
            If m_strDefaultSortField = "" Then m_strDefaultSortField = "TaskName"
        Else
            If m_strDefaultSortField = "" Then m_strDefaultSortField = "A.TaskName"
        End If
        'End of addition by PrashantD

        If m_strDefaultSortOrder = "" Then m_strDefaultSortOrder = "ASC"
        strSQLQuery = strSQLQuery + " ORDER BY " + m_strDefaultSortField + " " + m_strDefaultSortOrder + "', '" + m_strPageNumber + "'"
        CommonFunctions.General.WriteHTML("<br><DIV id=DivTaksList style='Overflow:auto;width=100%;Height:250'>")

        'ADDED BY PrasannaP ON 20TH May 2004 - BEGIN
        'GET THE ROLE ID OF THE EMPLOYEE
        Dim drProject As IDataReader
        drProject = CommonFunction.Data.GetDataReader("Select ROLE from tbl_PM_ProjectEmployeeRole Where ProjectId=" & m_intProjectID & " and EmployeeId=" & m_strSessionUserID, MyBase.UseSQL)
        If drProject.Read() Then
            If m_strTaskType = GENERAL_TASKS Then
                strSQLQuery = strSQLQuery + "," + CType(CommonFunction.Data.CheckIsDBNull(drProject("ROLE"), ""), String)

                '' Modified By NitinVS on 15 Apr 2005 for Da Wincey Customization Request
                'If m_intTaskTypeID = 0 Then
                '    strSQLQuery = strSQLQuery & ", " & "0"
                'End If
            Else
                'If m_intTaskTypeID = 0 Then
                '    strSQLQuery = strSQLQuery & ", Null , " & "0"
                'Else
                '    strSQLQuery = strSQLQuery & ", Null ,  " + m_intTaskTypeID.ToString
                'End If
                If m_intTaskTypeID = 0 Then
                    strSQLQuery = strSQLQuery & ",0"
                Else
                    strSQLQuery = strSQLQuery & "," + m_intTaskTypeID.ToString
                End If
                ' end Modification By NitinVS on 15 Apr 2005 for Da Wincey Customization Request


            End If
        Else
            drProject = CommonFunction.Data.GetDataReader("Select PostId from tbl_PM_Employee Where EmployeeId=" & m_strSessionUserID, MyBase.UseSQL)

            'Added by DipaliS 27 Oct 2004
            'Purpose    :   Issue 13656
            If drProject.Read() Then
                'End addition by DipaliS

                If m_strTaskType = GENERAL_TASKS Then
                    strSQLQuery = strSQLQuery & "," & CType(CommonFunction.Data.CheckIsDBNull(drProject("PostId"), ""), String)


                    ' Modified By NitinVS on 15 Apr 2005 for Da Wincey Customization Request
                    'If m_intTaskTypeID = 0 Then
                    'strSQLQuery = strSQLQuery & ", " & "0"
                    'End If
                Else
                    'Modified By VivekP
                    'If m_intTaskTypeID = 0 Then
                    '    strSQLQuery = strSQLQuery & ", Null , " & "0"
                    'Else
                    '    strSQLQuery = strSQLQuery & ", Null ,  " + m_intTaskTypeID.ToString
                    'End If
                    'If m_intTaskTypeID = 0 Then
                    '    strSQLQuery = strSQLQuery & ",0"
                    'Else
                    '    strSQLQuery = strSQLQuery & "," + m_intTaskTypeID.ToString
                    'End If
                    'End Of modification
                    ' end Modification By NitinVS on 15 Apr 2005 for Da Wincey Customization Request
                End If

                'Added by DipaliS 27 Oct 2004
                'Purpose    :   Issue 13656
            End If
            'End addition by DipaliS
            CommonFunction.Data.DisposeDataReader(drProject)
        End If
        CommonFunction.Data.DisposeDataReader(drProject)
        'Addition End


        'Plots the Table for Daily Activity .
        '-------------------------------------------------------------------
        arrColumnHeadingList.Add(MyBase.GetResourceString("TASK_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("TASK_NOTES"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("START_DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("END_DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("DURATION"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("WORK"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("ACTUAL_START_DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("ACTUAL_WORK"))

        arrActualColumnNames.Add("TaskName")
        arrActualColumnNames.Add("TaskNotes")
        arrActualColumnNames.Add("StartDate")
        arrActualColumnNames.Add("EndDate")
        arrActualColumnNames.Add("Duration")
        arrActualColumnNames.Add("Work")
        arrActualColumnNames.Add("ActualStartDate")
        arrActualColumnNames.Add("ActualWork")

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 8
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .RowLinkArray = arrColRowLinks
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .SortBy = m_strDefaultSortField
            .SortOrder = m_strDefaultSortOrder
            .ClientSideSortFunctionName = "Sort_OnClick"
            .UseSQL = True
            .PrimaryKey = "TaskName"
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With
        m_objGrid = Nothing
        CommonFunctions.General.WriteHTML("<br></DIV>")

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunctions.HTMLControls.DrawTextBox("txthidPageNo_TaskSelection", "txthidPageNo_TaskSelection", , , , m_strPageNumber, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strDefaultSortField, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strDefaultSortOrder, , , , , , True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015 

    End Sub
#End Region

#Region " Event Handling "
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If Args.LinkName = MyBase.GetResourceString("MENU_SHOW_ALL_TASKS") Then
            Cancel = True
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Args.TDStyle = " NOWRAP "
    End Sub

    Private Sub m_objPaging_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink) Handles m_objPaging.Before_Link_Print
        If m_strPagingAlphabet = "" Then
            m_strPagingAlphabet = Args.CurrentLink
        ElseIf m_strPagingAlphabet = Args.CurrentLink Then
            Cancel = True
        Else
            m_strPagingAlphabet = Args.CurrentLink
        End If

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        ' Added By MahendraV On 2:21 PM 7/2/2007
        ' Database update need remove order by due to DataSet Related Changes For Whiziblesem 7
        ' Start_MV_7/2/2007
        If Args.ColumnName = MyBase.GetResourceString("TASK_NOTES") Then
            Args.ApplySorting = False

        End If
        ' End_MV_7/2/2007
    End Sub

#End Region

#Region " Constructor "
    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_TaskSelection", "AppResources")
    End Sub
#End Region

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub InitializeComponent()

    End Sub

End Class