'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  PbNITE
' Module Name           :  PM_TaskReallocation.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  RajkumarM
' Reviewed              :  
' Tested                :  
' Created               :  17 Aug 2004
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class PM_TaskReallocation
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

#Region "Member Variables"

    Protected m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 1019
    Protected m_strPageID, m_ReallocateID, m_lngEmployeeID, m_lngProjectID, m_lngEmpRoleID, m_strEmpRoleID As Long
    Protected m_strTitle, m_strPageTitle, m_strReallocateTaskList As String
    Private m_strToEmployeeName, m_strFromEmployeeName, m_strFromUserName, m_strRoleDescription As String
    Private WithEvents m_objgrid As New WebPages.Template.GenericGrid
    Protected m_objGlobal As WebPages.Template.IGlobal
    'added by HarshK for sp4 issueid 120,121
    Protected m_strInvalidTaskList As String
    Protected m_bitResourceValidation As Int16 = 1 'on 06/10/2005
    'End added by HarshK for sp4 issueid 120,121
#End Region

#Region "Functions and Sub-Procedures"

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   PrakashR
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()
        ' Modified By NitinVS 0n 26 Apr 2007 for WhizilbeSEM SP 8 regression Fixes 
        Call CreateTaskList()
        'End modifiction By NitinVS 0n 26 Apr 2007 for WhizilbeSEM SP 8 regression Fixes 
    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  RajkumarM
        ' Created               :  17 Aug 2004
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objGlobal.TagID = 1019

        m_objAccessRights = New cAccessRights(m_objGlobal)

        m_objAccessRights.GetAccess()

        m_lngTagId = m_objGlobal.TagID
    End Sub
    Public Sub CreateTaskList()
        '====================================================================
        ' Procedure Name        :   CreateTaskList
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   This procedure construct the list 
        ' Description           :   Displays list of Incomplete Tasks in grid.
        ' Assumptions           :   sessions :ProjectID
        ' Dependencies          :   usp_Sel_tbl_PM_ProjectTasks_Incomplete
        '                           usp_Upd_tbl_PM_ReallocateTasktemp
        '                           usp_Sel_tbl_PM_ReallocateTasktemp
        '                           usp_Upd_tbl_PM_ReallocateTask
        '                           tbl_PM_RelocatedTasks
        ' Author                :   RajkumarM
        ' Created               :   17 Aug 2004
        '=====================================================================

        Dim strSQL As String
        Dim arrReallocateTaskList() As String
        Dim cmd As SqlClient.SqlCommand
        Dim m_count As Integer


        'If last time user has clicked Delete link:
        If Request("mode") = "Reallocatetemp" Then
            'Get to Reallocate list
            If Not IsDBNull(m_strReallocateTaskList) Then
                arrReallocateTaskList = m_strReallocateTaskList.Split(CType(",", Char))
                For m_count = 0 To arrReallocateTaskList.Length - 2
                    strSQL = "usp_Upd_tbl_PM_ReallocateTasktemp " & m_strEmpRoleID & "," & m_lngEmployeeID & "," & m_lngProjectID & "," & (arrReallocateTaskList(m_count)).Trim() & "," & m_ReallocateID & ""
                    m_ReallocateID = CType(CommonFunctions.Data.GetDataScalar(strSQL, True, CommonFunction.General.GetConnectionString()), Long)
                Next
            End If
        End If

        If Request("mode") = "Assign" Then
            'Get to delete list
            If Not IsDBNull(m_strReallocateTaskList) Then
                arrReallocateTaskList = m_strReallocateTaskList.Split(CType(",", Char))
                For m_count = 0 To arrReallocateTaskList.Length - 2
                    'modified by harshk for sp4 issueid 120,121
                    If IsvalidTaskID(arrReallocateTaskList(m_count).Trim()) = True Then
                        Try
                            cmd = New SqlClient.SqlCommand("usp_Upd_tbl_PM_ReallocateTask " & m_strEmpRoleID & "," & m_lngEmployeeID & "," & m_lngProjectID & "," & (arrReallocateTaskList(m_count)).Trim() & "")
                            cmd = CommonFunctions.Data.GetSQLCommandExecute(cmd, True, CommonFunction.General.GetConnectionString())
                        Catch e_data As DataException
                            Response.Redirect("../General/ErrorPage.aspx?Type=data")
                        Catch e_Null As NullReferenceException
                            Response.Redirect("../General/ErrorPage.aspx?Type=NullReference")
                        Finally
                            cmd = Nothing
                        End Try
                    End If
                    'End modified by harshk for sp4 issueid 120,121
                Next
            End If
            CommonFunctions.General.WriteHTML("<SCRIPT language=javascript>")
            CommonFunctions.General.WriteHTML("window.close();")
            CommonFunctions.General.WriteHTML("</SCRIPT>")
        End If

        'Draw a menu without paging

        GenerateMenu()

        Response.Write("<br/>")
        MyBase.InitializeResources("AppResources.PM_Taskreallocation", "AppResources")
        'Display page caption
        GeneratePageCaption()

        'Draw Table for Formatting

        'CommonFunctions.General.WriteHTML("<DIV Id='PageDiv'>  ")

        CommonFunctions.General.WriteHTML("<DIV Id='PageDiv' style='height:300px'>  ")




        If m_strPageID = 0 Then

            m_strTitle = MyBase.GetResourceString("PAGE_CAPTIONFIRST")
            CommonFunction.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, m_strTitle, , , True))
            CommonFunction.General.WriteHTML("<br/>")
            'modified by harshk for sp4 issueid 120,121
            'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE  class=clsTable cellspacing=0 cellpadding=0  width=99.9% >")
            'END modified by harshk for sp4 issueid 120,121
            CommonFunction.General.WriteHTML("<TR  width='100%'><td valign=top>")
            'Draw a grid
            GenerateGrid(m_strPageID)
            CommonFunctions.General.WriteHTML("</TD></TR>")
            '################# Footer Section
            'Modified by harshk for sp4 issueid 120,121
            CommonFunction.General.WriteHTML("<TR width='100%' class=clsTRBlank><td valign=top> ")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FOOTER_MESSAGE"))
            CommonFunctions.General.WriteHTML("</TD></TR>")
            '################# End Footer Section
            CommonFunctions.General.WriteHTML("</TABLE>")
            Response.Write("<br/>")
            'End Modfied by harshk for sp4 issueid 120,121
        ElseIf m_strPageID = 1 Then

            m_strTitle = MyBase.GetResourceString("PAGE_CAPTIONSECOND")
            CommonFunction.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, m_strTitle, , , True))
            CommonFunction.General.WriteHTML("<br/>")
            CommonFunction.General.WriteHTML("<TABLE  cellspacing=0 cellpadding=0  width=99.9%>")
            CommonFunction.General.WriteHTML("<TR  class=clsTRColumnHeader Width=100%><td valign=top>&nbsp;&nbsp;&nbsp;")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("RESOURCE"))
            strSQL = "usp_Sel_CurrentTeamMembers_Except_Employee " + m_lngProjectID.ToString + "," + m_strEmpRoleID.ToString
            'CommonFunctions.General.WriteHTML("</TD><TD valign=top>")
            CommonFunctions.HTMLControls.DrawComboBox("cboResource", strSQL, , CType(m_lngEmployeeID, String), , True)
            CommonFunctions.General.WriteHTML("</TD><TD valign=top>")
            CommonFunctions.General.WriteHTML("</TD></TR>")
            CommonFunctions.General.WriteHTML("</TABLE>")

        ElseIf m_strPageID = 2 Then
            m_strTitle = MyBase.GetResourceString("PAGE_CAPTIONTHIRD")
            m_strTitle = m_strTitle.Replace("<FromName>", m_strFromEmployeeName)
            m_strTitle = m_strTitle.Replace("<ToName>", m_strToEmployeeName)
            CommonFunction.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, m_strTitle, , , True))
            CommonFunction.General.WriteHTML("<br/>")
            'modified by harshk for sp4 issueid 120,121
            CommonFunction.General.WriteHTML("<TABLE  class=clsTable cellspacing=0 cellpadding=0  width=99.9% >")
            'end modified by harshk for sp4 issueid 120,121
            CommonFunction.General.WriteHTML("<TR  width='100%'><td valign=top> ")
            CommonFunctions.General.WriteHTML("</TD></TR>")
            CommonFunction.General.WriteHTML("<TR  width='100%'><td valign=top>")
            GenerateGrid(m_strPageID)
            CommonFunctions.General.WriteHTML("</TD></TR>")
            'Added by harshk for sp4 issueid 120,121
            '################# Footer Section
            If m_bitResourceValidation = 1 Then
                CommonFunction.General.WriteHTML("<TR width='100%' class=clsTRBlank><td valign=top> ")
                CommonFunction.General.WriteHTML("<B>Note: </B><I>")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FOOTER_MESSAGE_INVALID_TASK"))
                CommonFunction.General.WriteHTML("</I>")
                CommonFunctions.General.WriteHTML("</TD></TR>")
            End If
            '################# End Footer Section
            'End Added by harshk for sp4 issueid 120,121
            CommonFunctions.General.WriteHTML("</TABLE>")
        End If
        Response.Write("<br/>")

        CommonFunctions.General.WriteHTML("</DIV>")

        GenerateMenu()
    End Sub
    Public Sub GenerateMenu()
        '====================================================================
        ' Procedure Name        :CreateTestList
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws a menu without paging
        ' Description           : same
        ' Assumptions           : None
        ' Dependencies          : none
        ' Author                : RajkumarM
        ' Created               : 18 Aug 2004
        '=====================================================================

        'Menus :-

        MyBase.InitializeResources("AppResources.PM_Taskreallocation", "AppResources")
        Dim objMenu As WebPages.Template.StaticMenu
        Dim strMenu As String

        'Modified by NitinVS on 26 Apr 2007 for WhizibleSEM SP 8 regression Fixes 
        'To check for edit access of Employee Page to perform reallocation tasks 

        If m_objAccessRights.Edit = False Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            'Dim arrmenuFun() As String = {"Next_onClick(" & m_strPageID + 1 & ")", "SelectAll_onClick()", "ClearAll_onClick()", "Close_onClick()", "Help_onClick()"}
            'modified by harshada d for whiziblesem 6 on 10 April 2006 for updating help for task reallocation
            Dim arrmenuFun() As String = {"Close_onClick()", "Help_onClick('PM_REALLOCATION')"}
            Dim arrtoolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            strMenu = objMenu.DrawMenu(arrMenu, arrmenuFun, arrtoolTip, True)
        Else

            If m_strPageID = 0 Then
                ' 
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_NEXT"), MyBase.GetResourceString("MENU_SELECTALL"), MyBase.GetResourceString("MENU_CLEARALL"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                'Dim arrmenuFun() As String = {"Next_onClick(" & m_strPageID + 1 & ")", "SelectAll_onClick()", "ClearAll_onClick()", "Close_onClick()", "Help_onClick()"}
                'modified by harshada d for whiziblesem 6 on 10 April 2006 for updating help for task reallocation
                Dim arrmenuFun() As String = {"Next_onClick(" & m_strPageID + 1 & ")", "SelectAll_onClick()", "ClearAll_onClick()", "Close_onClick()", "Help_onClick('PM_REALLOCATION')"}
                Dim arrtoolTip() As String = {MyBase.GetResourceString("MENU_NEXT_TOOLTIP"), MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                strMenu = objMenu.DrawMenu(arrMenu, arrmenuFun, arrtoolTip, True)
            ElseIf m_strPageID = 1 Then
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_NEXT"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrmenuFun() As String = {"Back_onClick(" & m_strPageID - 1 & ")", "Next_onClick(" & m_strPageID + 1 & ")", "Close_onClick()", "Help_onClick('PM_REALLOCATION')"}
                Dim arrtoolTip() As String = {MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_NEXT_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                strMenu = objMenu.DrawMenu(arrMenu, arrmenuFun, arrtoolTip, True)
            Else
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_ASSIGN"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrmenuFun() As String = {"Back_onClick(" & m_strPageID - 1 & ")", "Assign_onClick()", "Close_onClick()", "Help_onClick('PM_REALLOCATION')"}
                Dim arrtoolTip() As String = {MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGN_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                strMenu = objMenu.DrawMenu(arrMenu, arrmenuFun, arrtoolTip, True)
            End If

        End If
        'End Modification By NitinVS on 26 Apr 2007 for WhizibleSEM SP 8 regression Fixes 

        Response.Write(strMenu)
    End Sub
    Public Sub GenerateGrid(ByVal m_strPageID As Long)
        '====================================================================
        ' Procedure Name        :GenerateGrid
        ' Parameters Passed     : alphabet,sortBy,sortOrder
        ' Returns               : None
        ' Parameters Affected   : Grid to display list of tests
        ' Description           : same
        ' Assumptions           : None
        ' Dependencies          : none
        ' Author                : RajkumarM
        ' Created               : 18 Aug 2004
        '=====================================================================

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        If m_strPageID = 0 Then
            'Task List in grid format :
            Dim allCols() As String = {MyBase.GetResourceString("WHICHTASK"), MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("STARTDATE"), MyBase.GetResourceString("ENDDATE"), MyBase.GetResourceString("WORK"), MyBase.GetResourceString("ACTUALWORK"), MyBase.GetResourceString("SELECT")}
            Dim actualCols() As String = {"WhichTask", "TaskName", "StartDate", "EndDate", "Work", "ActualWork", ""}
            Dim arrChkbox() As String = {"", "", "", "", "", "", "chkReallocate"}
            Dim arrAlign() As String = {"align=left width=0%", "align=left width=50%", "align=left width=15%", "align=left width=15%", "align=right width=7%", "align=right width=8%", "align=center width=5%"}
            Dim arrLink() As String = {"", "", "", "", "", "", ""}
            Dim arrGroupby() As String = {"WhichTask"}


            With m_objgrid
                .UserFriendlyColumnArray = allCols
                .ActualColumnArray = actualCols
                .NoOfDataColumns = 6
                .SQL = ("usp_Sel_tbl_PM_ProjectTasks_Incomplete  " & m_strEmpRoleID & "," & m_lngProjectID)
                .UseSQL = True
                ' .DIVID = "PageDiv"
                .CheckBoxIDArray = arrChkbox
                .PrimaryKey = "TaskID" 'primary key for Delete
                .TDStyleArray = arrAlign
                .RowLinkArray = arrLink
                .GroupOnColumn = arrGroupby
                'Added And Commented By Vidya J On 8-12-2015
                .DIVStyle = "height:310px;"
                'End Of Added And Commented By Vidya J On 8-12-2015
                ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                ''End of Addition by Dhanashri S on 7 Oct 2015
            End With

        ElseIf m_strPageID = 2 Then
            'Task List to be updated in grid format :
            Dim allCols() As String = {MyBase.GetResourceString("WHICHTASK"), MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("STARTDATE"), MyBase.GetResourceString("ENDDATE"), MyBase.GetResourceString("WORK")}
            Dim actualCols() As String = {"WhichTask", "TaskName", "Startdate", "Enddate", "Work"}
            Dim arrChkbox() As String = {"", "", "", "", ""}
            Dim arrAlign() As String = {"align=left width=0%", "align=left width=50%", "align=left width=20%", "align=left width=20%", "align=right width=10%"}
            Dim arrLink() As String = {"", "", "", "", ""}
            Dim arrGroupby() As String = {"WhichTask"}

            With m_objgrid
                .UserFriendlyColumnArray = allCols
                .ActualColumnArray = actualCols
                .NoOfDataColumns = 6
                .SQL = ("usp_Sel_tbl_PM_ReallocateTasktemp  " & m_ReallocateID & "," & m_lngEmployeeID)
                .UseSQL = True
                .DIVID = "PageDiv"
                .CheckBoxIDArray = arrChkbox
                .PrimaryKey = "UniqueID" 'primary key for reallocate
                .TDStyleArray = arrAlign
                .RowLinkArray = arrLink
                .GroupOnColumn = arrGroupby
                ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                ''End of Addition by Dhanashri S on 7 Oct 2015
            End With

        End If
        'Draw a grid
        'Added by HarshK for sp4 issueid 120,121
        m_strInvalidTaskList = "0"
        'End by HarshK for sp4 issueid 120,121
        Response.Write(m_objgrid.DrawGrid())
        'Added by HarshK for sp4 issueid 120,121

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunctions.HTMLControls.DrawTextBox("hdnInvalidTaskIDs", "hdnInvalidTaskIDs", , , , m_strInvalidTaskList, , , , , , True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015 

        'End by HarshK for sp4 issueid 120,121

        m_objgrid = Nothing

    End Sub
    Public Sub GeneratePageCaption()
        '====================================================================
        ' Procedure Name        :GeneratePageCaption
        ' Parameters Passed     : none
        ' Returns               : None
        ' Parameters Affected   : Displays a page caption on page.
        ' Description           : same
        ' Assumptions           : None
        ' Dependencies          : none
        ' Author                : RajkumarM
        ' Created               : 18 Aug 2004
        '=====================================================================
        'Display Page Caption
        'Commented and Modified By JyotiG
        'Start_JG_12776_10-Apr-2007
        'CommonFunction.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, m_strPageTitle, MyBase.GetResourceString("RESOURCE") + m_strFromEmployeeName, , True))
        CommonFunction.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, m_strPageTitle, MyBase.GetResourceString("RESOURCE") + " : " + m_strFromUserName + " - " + m_strFromEmployeeName + "[" + m_strRoleDescription + "]", , True))
        'End_JG_12776_10-Apr-2007
        CommonFunction.General.WriteHTML("<br/>")
    End Sub


    Private Sub m_objgrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objgrid.DataRowTD_BeforePrint
        '====================================================================
        'Procedure(Name) : m_objgrid_DataRowTD_BeforePrint()
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure is used for formatting the grid as 
        '                         required before printing DataRow TD tag
        ' Description           : It Selects checkboxes if 
        '                         they are prevoiusly selected
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : RajkumarM
        ' Date                  : 18 Aug 2004
        '=====================================================================

        Try

            'Check the Select checkboxes if they are Previously Selected
            If Args.ColumnName = "Select" Then
                If InStr(m_strReallocateTaskList, CType(Args.DataReader("TaskID"), String) & ",") > 0 Then
                    Args.IsCheckBoxChecked = True
                End If
                ' Code Added by RajkumarM on 4th Dec to Disable check box for tasks with 
                ' Actual work greater than Planned work.
                If CType(Args.DataReader("AllowReallocate"), Integer) = 0 Then
                    Args.IsCheckBoxDisabled = True
                End If
                ' Code Addition Ends
            End If
            'Added by harshk for sp4 issueid 120,121 , , MyBase.GetResourceString("WORK")}{"WhichTask", "TaskName", "Startdate", "Enddate", "Work"}
            If m_strPageID = 2 Then
                If m_bitResourceValidation = 1 Then
                    If CType(Args.DataReader("IsValid"), String) = "0" Then
                        m_strInvalidTaskList = m_strInvalidTaskList & "," & CType(Args.DataReader("TaskID"), String)
                        Args.TDStyle = "style=""COLOR: red"""
                    End If
                End If
            End If
            'end by harshk for sp4 issueid 120,121 'style="COLOR: red"
        Catch e_data As DataException
            Response.Redirect("../General/ErrorPage.aspx?Type=data")
        Catch e_Null As NullReferenceException
            Response.Redirect("../General/ErrorPage.aspx?Type=NullReference")

        End Try


    End Sub
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim strSQL As String
        Dim drTemp As IDataReader
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_lngEmployeeID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID"), "0"), Long)
        m_lngProjectID = CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"), Long)
        m_strReallocateTaskList = CommonFunctions.General.CheckIsNothing(Request.QueryString("ReallocateTaskList"))
        m_strEmpRoleID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("EMP_ID"), "0"), Long)
        '-- Get the ProjectEmployeeRoleID
        m_lngEmpRoleID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectEmployeeRoleID"), "0"), Long)
        m_strPageID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("PageID"), "0"), Long)


        strSQL = "usp_Sel_tbl_PM_Employee_ProjectEmployeeRoleID " + m_lngEmpRoleID.ToString


        '-- Get EmployeeID and UserName
        If m_strEmpRoleID = 0 Then
            drTemp = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drTemp.Read Then
                m_strEmpRoleID = CType(CommonFunctions.Data.CheckIsDBNull(drTemp("EmployeeID"), "0"), Long)
                m_strFromEmployeeName = CommonFunctions.Data.CheckIsDBNull(drTemp("EmployeeName")).ToString
                m_strFromUserName = CommonFunctions.Data.CheckIsDBNull(drTemp("UserName")).ToString
                m_strRoleDescription = CommonFunctions.Data.CheckIsDBNull(drTemp("RoleDescription")).ToString

            End If
            CommonFunctions.Data.DisposeDataReader(drTemp)
        End If

        'strSQL = "Select Username from tbl_PM_Employee where EmployeeID= " + m_lngEmployeeID.ToString
        strSQL = "usp_sel_tbl_PM_Employee_UserNameForEmployeeID " + m_lngEmployeeID.ToString

        If m_lngEmployeeID > 0 Then
            drTemp = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drTemp.Read Then
                m_strToEmployeeName = CommonFunctions.Data.CheckIsDBNull(drTemp("UserName")).ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drTemp)
        End If

        'Added by HarshK for sp4 issueID 120,121 on 06/10/2005
        'Dim strQuery2 As String = "select IsNull(ResourceValidation,0) from tbl_PM_Project WHERE ProjectID = " & m_lngProjectID.ToString
        Dim strQuery2 As String = "usp_sel_tbl_PM_Project_ResourceValidation_ProjectID " & m_lngProjectID.ToString
        If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery2, MyBase.UseSQL), "True"), Boolean) = True Then
            m_bitResourceValidation = 1
        Else
            m_bitResourceValidation = 0
        End If
        'End  Added by HarshK for sp4 issueID 120,121 on 06/10/2005

        'Addition done by SuchitraP on 31-July-2007
        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            If m_bitResourceValidation = 1 Then
                Response.Write(GetTaskDetails())
            Else
                Response.Write("0")
            End If
            Response.End()
        End If
        'End of addition by SuchitraP on 31-July-2007
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

#End Region

    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_Taskreallocation", "AppResources")
    End Sub


    Private Sub m_objgrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objgrid.ColumnHeaderTD_BeforePrint
        If Args.ColumnName = "Whichtask" Then
            Args.ColumnName = ""
        End If
    End Sub
    'Added by HarshK sp4 issueid 120,121
    Private Function IsvalidTaskID(ByVal strTaskID As String) As Boolean
        Dim arrInvalidTaskID() As String = CType(CommonFunctions.General.CheckIsNothing(Request("hdnInvalidTaskIDs"), "0"), String).Split(CType(",", Char))
        Dim intIndex As Integer
        If m_bitResourceValidation = 1 Then
            For intIndex = 0 To arrInvalidTaskID.Length - 1
                If strTaskID = arrInvalidTaskID(intIndex) Then
                    Return False
                End If
            Next
        End If
        Return True
    End Function
    'End by HarshK sp4 issueid 120,121
    'Addition done by SuchitraP on 31-July-2007
    Private Function GetTaskDetails() As String
        'Dim strProjectEmployeeRoleID As String
        Dim strTaskList As String
        Dim lngEmployeeID As Long
        Dim sbHtml As System.Text.StringBuilder = New System.Text.StringBuilder
        Dim strHtml As String
        Dim strSQL As String
        Dim lngProjectID As Long
        Dim dr As IDataReader
        Dim count As Integer
        count = 0

        'strProjectEmployeeRoleID = Request.QueryString("ProjectEmployeeRoleID")
        strTaskList = Request.QueryString("ReallocateTaskList")
        lngEmployeeID = CType(Request.QueryString("EmployeeID"), Long)
        lngProjectID = CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"), Long)
        strSQL = "EXEC usp_ValidateProjectDate_Resources " + lngProjectID.ToString + "," + lngEmployeeID.ToString + ",'" + strTaskList + "'"
        'strResult = CType(CommonFunction.Data.GetDataScalar(strSQL, True), String)
        dr = CommonFunction.Data.GetDataReader(strSQL, True)
        While dr.Read
            If count = 0 Then
                sbHtml.Append("1|")
                sbHtml.Append(dr("StartDate").ToString)
                sbHtml.Append("|")
                sbHtml.Append(dr("EndDate").ToString)
                sbHtml.Append("|")
            End If
            sbHtml.Append(dr("TaskName").ToString)
            sbHtml.Append("|")
            count += 1
        End While

        strHtml = sbHtml.ToString
        CommonFunction.Data.DisposeDataReader(dr)

        If Not strHtml = "" Then
            strHtml = strHtml.Substring(0, sbHtml.Length - 1)
            Return strHtml
        Else
            Return "0"
        End If

    End Function
    'End of Addition done by SuchitraP on 31-July-2007
End Class
