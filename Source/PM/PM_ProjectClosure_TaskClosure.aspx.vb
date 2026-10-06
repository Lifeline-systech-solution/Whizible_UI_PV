#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_ProjectClosure_TaskClosure
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

#End Region

#Region "PageEvents"
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngProjectID = CInt(Session("intProjectID"))
        Initialize()
       
    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

    Public Sub PageInit()
        Dim objHeaderFooter As WebPages.Template.HeaderFooter
        Dim strSQLQuery As String
        Dim m_strCnt As String = "0"

        If Not IsNothing(HttpContext.Current.Request.QueryString("FromSaveAndClose")) Then
            m_strFromSaveAndClose = HttpContext.Current.Request.QueryString("FromSaveAndClose").ToString
        End If

        'This will initialize all the global objects.
        GetGlobalObject()

        'Display the Menu at Bottom
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)

        'Display the page caption.
        DrawPageCaption()

        'Get the Mode
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        If m_strMode = "" Then
            m_strMode = MODE_LIST
        End If

        'If Mode is Save...update the IsTaskComplete field in the tbl_PM_ProjectTasks
        If m_strMode = MODE_SAVE Then
            ' Save Task Completion details
            UpdateTasksCompletion()
            ' Save Void Taskdetails
            UpdateTasksVoid()

            ' Added BY MahendraV On 03:40 AM 5/10/2007 for Module closure
            'Start_MV_5/10/2007
            If m_strModuleMode.Equals("CLOSE_MODULE_TASKS") Then
               
                If m_strFromSaveAndCloseModule = "1" Then
                   Dim strPostedURL As String = "../General/CommonPage.aspx?ModuleId_PK=" + m_strModuleId_PK + "&MasterTagID=454&FromWhere=PM&PagingAlphabet=- 1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&CloseModule=1"
                    Response.Write("<script> refreshParent('frmCommonPage', 'CommonPage.aspx', '" + strPostedURL + "', true);window.close();</script>")
                ElseIf m_strFromSaveAndCloseModule = "0" Then
                    Dim strPostedURL As String = "../General/CommonPage.aspx?ModuleId_PK=" + m_strModuleId_PK + "&MasterTagID=454&FromWhere=PM&PagingAlphabet=- 1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"
                    Response.Write("<script> refreshParent('frmCommonPage', 'CommonPage.aspx', '" + strPostedURL + "', true); window.close(); </script>")

                End If

                'End_MV_5/10/2007
                ' Added BY MahendraV On 4:10 PM 5/12/2007 for SubProject closure
                'Start_MV_5/12/2007

            ElseIf m_strSubProjectMode.Equals("CLOSE_SUBPROJECT_TASKS") Then

                If m_strFromSaveAndCloseSubProject = "1" Then
                    'Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited 		    
                    'Dim strPostedURL As String = "../General/CommonPage.aspx?SubProjectId_PK=" + m_strSubProjectId_PK + "&MasterTagID=661&FromWhere=PM&PagingAlphabet=- 1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&CloseSubProject=1"
                    'Response.Write("<script> refreshParent('frmCommonPage', 'CommonPage.aspx', '" + strPostedURL + "', true);window.close();</script>")
                    Dim strPostedURL As String = "../PM/SubProject_CommonPage.aspx?SubProjectId_PK=" + m_strSubProjectId_PK + "&MasterTagID=661&FromWhere=PM&PagingAlphabet=- 1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&CloseSubProject=1"
                    Response.Write("<script> refreshParent('frmCommonPage', 'CommonPage.aspx', '" + strPostedURL + "', true);window.close();</script>")
                    'End of Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited 
                ElseIf m_strFromSaveAndCloseSubProject = "0" Then
                    Dim strPostedURL As String = "../General/CommonPage.aspx?SubProjectId_PK=" + m_strSubProjectId_PK + "&MasterTagID=661&FromWhere=PM&PagingAlphabet=- 1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"
                    Response.Write("<script> refreshParent('frmCommonPage', 'CommonPage.aspx', '" + strPostedURL + "', true); window.close(); </script>")

                End If
                'End_MV_5/12/2007
                ' Added BY MahendraV On 3:03 PM 5/15/2007 for MileStone closure
                'Start_MV_5/15/2007
            ElseIf m_strMileStoneMode.Equals("CLOSE_MILESTONE_TASKS") Then

                If m_strFromSaveAndCloseMileStone = "1" Then
                    Dim strPostedURL As String = "../General/CommonPage.aspx?MileStoneId_PK=" + m_strMileStoneId_PK + "&MasterTagID=34&FromWhere=PM&PagingAlphabet=- 1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&CloseMileStone=1"
                    Response.Write("<script> refreshParent('frmCommonPage', 'CommonPage.aspx', '" + strPostedURL + "', true);window.close();</script>")
                ElseIf m_strFromSaveAndCloseMileStone = "0" Then
                    Dim strPostedURL As String = "../General/CommonPage.aspx?MileStoneId_PK=" + m_strMileStoneId_PK + "&MasterTagID=34&FromWhere=PM&PagingAlphabet=- 1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"
                    Response.Write("<script> refreshParent('frmCommonPage', 'CommonPage.aspx', '" + strPostedURL + "', true); window.close(); </script>")

                End If

                'End_MV_5/15/2007



            Else
                m_strCnt = CType(CommonFunction.Data.GetDataScalar("usp_sel_cnt_TaskForCompletion_VoidedTasks_ProjectClosure " + Session("intProjectID").ToString, MyBase.UseSQL), String)
                If m_strCnt = "0" And HttpContext.Current.Request.QueryString("FromSaveAndClose").ToString = "1" Then
                    'Response.Write("<script> refreshParent('frmProjectClosure', 'PM_ProjectClosure.aspx', 'PM_ProjectClosure.aspx', true);</script>")
                    Response.Write("<script> var obj = GetParentObjectReference('frmProjectClosure', 'txtCnt'); if (obj!=null){obj.value=" + m_strCnt + "} refreshParent('frmProjectClosure', 'PM_ProjectClosure.aspx', 'PM_ProjectClosure.aspx?MasterTagID=468&Action=Save', true);</script>")
                ElseIf m_strCnt = "0" And HttpContext.Current.Request.QueryString("FromSaveAndClose").ToString = "0" Then
                    Response.Write("<script> var obj = GetParentObjectReference('frmProjectClosure', 'txtCnt'); if (obj!=null){obj.value=" + m_strCnt + "} </script>")
                End If
            End If
        End If

        If (Request.Form("hidTaskCompletionFilterDivStatus") & "") = "Open" Or (Request.Form("hidTaskCompletionFilterDivStatus") & "") = "" Then
            m_FilterTaskcompletionDivStatus = True
        Else
            m_FilterTaskcompletionDivStatus = False
        End If

        ''Added By Chakshuta H on 31st March 2014
        If (Request.Form("hidTaskMPPFilterDivStatus") & "") = "Open" Or (Request.Form("hidTaskMPPFilterDivStatus") & "") = "" Then
            m_FilterTaskMPPDivStatus = True
        Else
            m_FilterTaskMPPDivStatus = False
        End If
        ''Ended By Chakshuta H on 31st March 2014

        If (Request.Form("hidTaskVoidFilterDivStatus") & "") = "Open" Or (Request.Form("hidTaskVoidFilterDivStatus") & "") = "" Then
            m_FilterTaskvoidDivStatus = True
        Else
            m_FilterTaskvoidDivStatus = False
        End If

        'Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto;Height=1000px'>")
        Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto;'>")

        If m_FilterTaskcompletionDivStatus = True Then
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidTaskCompletionFilterDivStatus id=hidTaskCompletionFilterDivStatus value='Open' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskCompletion_div()""><Img Border=0 id=imgTaskCompletionShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_COMPLETION_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='TaskCompletion' name='TaskCompletion' height=200px style=""overflow:auto;display:''"">")
        Else
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidTaskCompletionFilterDivStatus id=hidTaskCompletionFilterDivStatus value='Close' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskCompletion_div()""><Img Border=0 id=imgTaskCompletionShowHide Src='../../Images/plus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_COMPLETION_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='TaskCompletion' name='TaskCompletion' height=200px style=""overflow:auto;display:'none'"">")
        End If

        Call DisplayTaskCompletionGrid()
        HttpContext.Current.Response.Write("</DIV>")

        If m_FilterTaskvoidDivStatus = True Then
            CommonFunctions.General.WriteHTML("<input type=hidden name=m_FilterTaskVoidDivStatus id=m_FilterTaskVoidDivStatus value='Open' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskVoid_div()""><Img Border=0 id=imgTaskVoidShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_VOID_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='TaskVoid' name='TaskVoid' height=200px style=""overflow:auto;display:''"">")
        Else
            CommonFunctions.General.WriteHTML("<input type=hidden name=m_FilterTaskVoidDivStatus id=m_FilterTaskVoidDivStatus value='Close' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskVoid_div()""><Img Border=0 id=imgTaskVoidShowHide Src='../../Images/plus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_VOID_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='Void' name='Void' height=200px style=""overflow:auto;display:'none'"">")
        End If

        Call DisplayTasktobeVoidedGrid()
        HttpContext.Current.Response.Write("</DIV>")

        ''Added by Chakshuta H 31st March 2014
        Dim strmessage As String = "Please Close All MPP Tasks in MPP Plan"
        If m_FilterTaskMPPDivStatus = True Then
            CommonFunctions.General.WriteHTML("<input type=hidden name=m_FilterTaskMPPDivStatus id=m_FilterTaskMPPDivStatus value='Open' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskMPP_div()""><Img Border=0 id=imgTaskMPPShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & strmessage & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='TaskMPP' name='TaskMPP' height=200px style=""overflow:auto;display:''"">")
        Else
            CommonFunctions.General.WriteHTML("<input type=hidden name=m_FilterTaskMPPDivStatus id=m_FilterTaskMPPDivStatus value='Close' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskMPP_div()""><Img Border=0 id=imgTaskMPPShowHide Src='../../Images/plus.gif' title=''></A>&nbsp;&nbsp; " & strmessage & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='MPP' name='MPP' height=200px style=""overflow:auto;display:'none'"">")
        End If


        Call DisplayTasksMPPGrid()
        HttpContext.Current.Response.Write("</DIV>")

        'If m_FilterTaskMPPDivStatus = True Then
        '    CommonFunctions.General.WriteHTML("<input type=hidden name=m_FilterTaskVoidDivStatus id=m_FilterTaskVoidDivStatus value='Open' />")
        '    CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskVoid_div()""><Img Border=0 id=imgTaskVoidShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_VOID_DIV") & " </TD></TR></TABLE>")
        '    CommonFunctions.General.WriteHTML("<DIV id='TaskVoid' name='TaskVoid' height=200px style=""overflow:auto;display:''"">")
        'Else
        '    CommonFunctions.General.WriteHTML("<input type=hidden name=m_FilterTaskVoidDivStatus id=m_FilterTaskVoidDivStatus value='Close' />")
        '    CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskVoid_div()""><Img Border=0 id=imgTaskVoidShowHide Src='../../Images/plus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_VOID_DIV") & " </TD></TR></TABLE>")
        '    CommonFunctions.General.WriteHTML("<DIV id='Void' name='Void' height=200px style=""overflow:auto;display:'none'"">")
        'End If
        'Ended by Chakshuta H 31st March 2014

        HttpContext.Current.Response.Write("</DIV>")
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        DisposeObjects()
    End Sub

    Private Sub Initialize()
        Dim strSQLQuery As String
        Dim strTaskIDs As String
        
        m_lngTagId = m_objGlobal.TagID
        ' Added BY MahendraV On 10:40 AM 5/10/2007 for module closure
        'Start_MV_5/10/2007


        If Not IsNothing(HttpContext.Current.Request.QueryString("MODULE_MODE")) Then
            m_strModuleMode = HttpContext.Current.Request.QueryString("MODULE_MODE")
        End If

        If Not IsNothing(HttpContext.Current.Request.QueryString("ModuleId_PK")) Then
            m_strModuleId_PK = HttpContext.Current.Request.QueryString("ModuleId_PK")
        End If

        If Not IsNothing(HttpContext.Current.Request.QueryString("FromSaveAndCloseModule")) Then
            m_strFromSaveAndCloseModule = HttpContext.Current.Request.QueryString("FromSaveAndCloseModule")
        End If
        'End_MV_5/10/2007

        ' Added BY MahendraV On 3:47 PM 5/12/2007 for SubProject closure
        'Start_MV_5/12/2007


        If Not IsNothing(HttpContext.Current.Request.QueryString("SUBPROJECT_MODE")) Then
            m_strSubProjectMode = HttpContext.Current.Request.QueryString("SUBPROJECT_MODE")
        End If

        If Not IsNothing(HttpContext.Current.Request.QueryString("SubProjectId_PK")) Then
            m_strSubProjectId_PK = HttpContext.Current.Request.QueryString("SubProjectId_PK")
        End If

        If Not IsNothing(HttpContext.Current.Request.QueryString("FromSaveAndCloseSubProject")) Then
            m_strFromSaveAndCloseSubProject = HttpContext.Current.Request.QueryString("FromSaveAndCloseSubProject")
        End If
        'End_MV_5/12/2007


        ' Added BY MahendraV On 3:04 PM 5/15/2007 for MileStone closure
        'Start_MV_5/15/2007 


        If Not IsNothing(HttpContext.Current.Request.QueryString("MILESTONE_MODE")) Then
            m_strMileStoneMode = HttpContext.Current.Request.QueryString("MILESTONE_MODE")
        End If

        If Not IsNothing(HttpContext.Current.Request.QueryString("MileStoneId_PK")) Then
            m_strMileStoneId_PK = HttpContext.Current.Request.QueryString("MileStoneId_PK")
        End If

        If Not IsNothing(HttpContext.Current.Request.QueryString("FromSaveAndCloseMileStone")) Then
            m_strFromSaveAndCloseMileStone = HttpContext.Current.Request.QueryString("FromSaveAndCloseMileStone")
        End If
        'End_MV_5/15/2007 


    End Sub

#End Region

#Region "Constants"

    '--- Constants for Mode
    Private Const MODE_LIST As String = "List"
    Private Const MODE_SAVE As String = "Save"

#End Region

#Region "Member Variables"

    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objTaskCompletionGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.
    Private WithEvents m_objTaskVoidGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.

    'Added By Chakshuta H on 31st March 2014
    Private WithEvents m_objTaskMPPGrid As New WebPages.Template.GenericGrid
    'Ended By Chakshuta H on 31st March 2014

    'Private WithEvents m_objSkillsGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.
    Private m_objGlobal As WebPages.Template.IGlobal                    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights        'This variable is for access rights of page.
    Protected WithEvents frmTaskUpdation As System.Web.UI.HtmlControls.HtmlForm

    Private strMenu As String                           'stores the static menu string.
    Protected m_lngProjectID As Long                   'Project ID
    Protected m_strWindowTitle As String                'Page Title
    Protected m_lngTagId As Long = 0                    'Tag ID
    Private m_strMode As String                         'Mode
    Private m_intCount As Integer
    Protected m_lngEmployeeID As Long = 0
    Private m_strEmployeeName As String
    'Protected m_strTimesheetApprover As String
    'Protected m_strExpenseApprover As String
    'Protected m_strnewTimesheetDefaultApprover As String
    'Protected m_strnewExpenseDefaultApprover As String
    'Protected m_strIssue As String
    'Protected m_strnewDeliverableResponsiblePerson As String
    'Protected m_strnewIssueResponsiblePerson As String
    'Protected m_strnewResponsiblePersonForIssue As String
    'Protected m_strnewResponsiblePersonForInvoice As String
    'Protected m_strnewMSPFileOwner As String
    'Protected m_strnewRisksResponsiblePerson As String
    'Protected m_strnewPersonResponsibleForTimesheetblocking As String
    Protected m_lngUniqueID As Long

    Protected m_FilterTaskcompletionDivStatus As Boolean = True
    Protected m_FilterTaskvoidDivStatus As Boolean = True
    'Protected m_FilterApproverDivStatus As Boolean = True
    'Protected m_FilterSkillsDivStatus As Boolean = True
    ''Added By Chakshuta H on 31st March 2014
    Protected m_FilterTaskMPPDivStatus As Boolean = True
    ''Ended By Chakshuta H on 31st March 2014

    'Private m_strStartDate As String = ""
    'Private m_intYearsToBeShown As Integer = 0
    'Private m_intMonthsToBeShown As Integer = 0
    'Private m_strUserName As String = ""
    'Private m_intTotalDays As Integer = 0
    'Private m_intEmployeeYears As Integer = 0
    'Private m_intEmployeeMonths As Integer = 0
    'Private m_intEmployeeDays As Integer = 0
    Protected m_strFromSaveAndClose As String = "0"

    ' Added BY MahendraV On 10:40 AM 5/10/2007 for module closure
    'Start_MV_5/10/2007

    Protected m_strModuleMode As String = ""
    Protected m_strModuleId_PK As String = ""
    Protected m_strFromSaveAndCloseModule As String = ""

    'End_MV_5/10/2007

    ' Added BY MahendraV On 3:51 PM 5/12/2007 for SubProject closure
    'Start_MV_5/12/2007

    Protected m_strSubProjectMode As String = ""
    Protected m_strSubProjectId_PK As String = ""
    Protected m_strFromSaveAndCloseSubProject As String = ""

    'End_MV_5/12/2007

    ' Added BY MahendraV On 3:06 PM 5/15/2007 for MileStone closure
    'Start_MV_5/15/2007

    Protected m_strMileStoneMode As String = ""
    Protected m_strMileStoneId_PK As String = ""
    Protected m_strFromSaveAndCloseMileStone As String = ""

    'End_MV_5/15/2007

#End Region

#Region "General Functions"

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function
    Private Sub UpdateTasksCompletion()
        'get the list of all ID's
        Dim strTaskIDs As String
        Dim arrTaskIDList() As String
        Dim strTaskID As String
        Dim strSQL As String
        Dim i As Integer
        strTaskIDs = MyBase.GetFormValue("chkTaskcomplete") + ""

        ' Insert data in User Access table.
        If strTaskIDs <> "" Then
            arrTaskIDList = Split(strTaskIDs, ",")

            For i = 0 To arrTaskIDList.Length - 1
                strTaskID = CType(arrTaskIDList(i), String)
                
                strSQL = "usp_Upd_AssignedTasks_Updation_ProjectClosure 1," + m_lngProjectID.ToString + "," + strTaskID.ToString

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Next
        End If
    End Sub
    Private Sub UpdateTasksVoid()
        'get the list of all ID's
        Dim strTaskIDs As String
        Dim arrTaskIDList() As String
        Dim strTaskID As String
        Dim strSQL As String
        Dim i As Integer
        strTaskIDs = MyBase.GetFormValue("chkTaskvoid") + ""

        ' Insert data in User Access table.
        If strTaskIDs <> "" Then
            arrTaskIDList = Split(strTaskIDs, ",")

            For i = 0 To arrTaskIDList.Length - 1
                strTaskID = CType(arrTaskIDList(i), String)

                strSQL = "usp_Upd_AssignedTasks_Updation_ProjectClosure 2," + m_lngProjectID.ToString + "," + strTaskID.ToString

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Next
        End If
    End Sub

    'Private Sub GetProjectDetails()
    '    Dim drWork As IDataReader
    '    Dim strQuery As String = ""
    '    Dim lngTempUsed As Long = 0

    '    m_intYearsToBeShown = 0
    '    m_intMonthsToBeShown = 0

    '    strQuery = "Exec usp_Sel_tbl_PM_Project_ActualStartDate " & m_lngProjectID.ToString()
    '    drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
    '    If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
    '        If drWork.Read() Then
    '            m_strStartDate = CommonFunctions.Data.CheckIsDBNull(drWork.Item("ActualStartDate")).ToString()
    '            If ("" & m_strStartDate).Trim() <> "" Then
    '                lngTempUsed = DateDiff(DateInterval.Month, CType(m_strStartDate, Date), Now)
    '                m_intYearsToBeShown = CType(lngTempUsed / 12, Integer)
    '                If lngTempUsed >= 11 Then
    '                    m_intYearsToBeShown += 1
    '                End If
    '                If m_intYearsToBeShown = 0 Then
    '                    lngTempUsed = DateDiff(DateInterval.Day, CType(m_strStartDate, Date), Now())
    '                    m_intMonthsToBeShown = CType(lngTempUsed / 30, Integer)

    '                    If m_intMonthsToBeShown < 11 Then
    '                        m_intMonthsToBeShown += 1
    '                    End If

    '                Else
    '                    m_intMonthsToBeShown = 11
    '                End If
    '            End If
    '        End If
    '    End If
    '    CommonFunctions.Data.DisposeDataReader(drWork)
    'End Sub
#End Region

#Region "Functions & Procedures"

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub

    Private Sub DrawMenu()
        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strGrid As String
        
        arrMenuList.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        arrClientSideFunctionList.Add("Save_OnClick()")
        
        arrMenuList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SELECT_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("SelectAll_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("ClearAll_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('Tasks Closure')")

        'Create the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)
    End Sub

    Private Sub DrawPageCaption()
        Response.Write("<BR>")
        Response.Write(PageCaption.GetPageCaptions(m_objGlobal, "Tasks Closure", , , True))
        Response.Write("<BR>")
    End Sub

    Private Sub DisposeObjects()
        m_objMenu = Nothing
        m_objTaskCompletionGrid = Nothing
        m_objTaskVoidGrid = Nothing
        'Added By Chakshuta H
        m_objTaskMPPGrid = Nothing
        'End
        'm_objSkillsGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing
    End Sub
 
    Private Sub DisplayTaskCompletionGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""
    
        ' Added BY MahendraV On 10:40 AM 5/10/2007 for module closure
        'Start_MV_5/10/2007
        If m_strModuleMode.Equals("CLOSE_MODULE_TASKS") Then
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForCompletion_ModuleClosure " & CType(m_lngProjectID, String) & "," & CType(m_strModuleId_PK, String)

            'End_MV_5/10/2007
            ' Added BY MahendraV On 4:04 PM 5/12/2007 for SubProject closure
            'Start_MV_5/12/2007 
        ElseIf m_strSubProjectMode.Equals("CLOSE_SUBPROJECT_TASKS") Then
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForCompletion_SubProjectClosure " & CType(m_lngProjectID, String) & "," & CType(m_strSubProjectId_PK, String)

            'End_MV_5/12/2007 

            ' Added BY MahendraV On 3:08 PM 5/15/2007 for MileStone closure
            'Start_MV_5/15/2007 
        ElseIf m_strMileStoneMode.Equals("CLOSE_MILESTONE_TASKS") Then
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForCompletion_MileStoneClosure " & CType(m_lngProjectID, String) & "," & CType(m_strMileStoneId_PK, String)

            'End_MV_5/15/2007 
        Else


            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForCompletion_ProjectClosure " & CType(m_lngProjectID, String)
        End If





        Dim arrActualColumns() As String = {"TaskName", "EmployeeName", "StartDate", "EndDate", _
                                            "ActualStartDate", "PlannedWork", "ActualWork", "ActualPercentComplete", ""}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("HEADING_TASK_NAME"), MyBase.GetResourceString("HEADING_EMPLOYEE_NAME"), _
                                                 MyBase.GetResourceString("HEADING_START_DATE"), MyBase.GetResourceString("HEADING_END_DATE"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_START_DATE"), _
                                                 MyBase.GetResourceString("HEADING_EFFORTS"), MyBase.GetResourceString("HEADING_ACTUAL_EFFORTS"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_PERCENT_COMPLETE"), MyBase.GetResourceString("HEADING_IS_TASK_COMPLETE")}
        Dim arrstrTDStyle() As String = {"align='left' width=40%", "align='left' width=5%", "align='left' width=5%", _
                                         "align='left' width=5%", "align='left' width=5%", "align='right' width=5%", "align='right' width=5%", _
                                         "align='right' width=5%", "align='center' width=5%"}
        Dim arrstrCheckboxID() As String = {"", "", "", "", "", "", "", "", "chkTaskcomplete"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With m_objTaskCompletionGrid
            .ColNameToolTipOnEachRow = True
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .NoOfDataColumns = arrUserFriendlyColumn.GetLength(0) - 1
            .PrimaryKey = "TaskID"
            .CheckBoxIDArray = arrstrCheckboxID
            .ColumnHeaderAlignment = "left"
            .SQL = strSQLQuery
            .DIVHeight = 0
            .DIVID = "divList1"
            .UseSQL = True
            .TDStyleArray = arrstrTDStyle
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub
    Private Sub DisplayTasktobeVoidedGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""
       
        ' Added BY MahendraV On 10:40 AM 5/10/2007 module closure
        'Start_MV_5/10/2007


        If m_strModuleMode.Equals("CLOSE_MODULE_TASKS") Then
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForVoiding_ModuleClosure " & CType(m_lngProjectID, String) & "," & CType(m_strModuleId_PK, String)
            'End_MV_5/10/2007
            ' Added BY MahendraV On 4:05 PM 5/12/2007 SubProject closure
            'Start_MV_5/12/2007
        ElseIf m_strSubProjectMode.Equals("CLOSE_SUBPROJECT_TASKS") Then
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForVoiding_SubProjectClosure " & CType(m_lngProjectID, String) & "," & CType(m_strSubProjectId_PK, String)
            'End_MV_5/12/2007
            ' Added BY MahendraV On 3:11 PM 5/15/2007 MileStone closure
            'Start_MV_5/15/2007
        ElseIf m_strMileStoneMode.Equals("CLOSE_MILESTONE_TASKS") Then
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForVoiding_MileStoneClosure " & CType(m_lngProjectID, String) & "," & CType(m_strMileStoneId_PK, String)
            'End_MV_5/15/2007
        Else
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForVoiding_ProjectClosure " & CType(m_lngProjectID, String)
        End If
        Dim arrActualColumns() As String = {"TaskName", "EmployeeName", "StartDate", "EndDate", _
                                            "ActualStartDate", "PlannedWork", "ActualWork", "ActualPercentComplete", ""}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("HEADING_TASK_NAME"), MyBase.GetResourceString("HEADING_EMPLOYEE_NAME"), _
                                                 MyBase.GetResourceString("HEADING_START_DATE"), MyBase.GetResourceString("HEADING_END_DATE"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_START_DATE"), _
                                                 MyBase.GetResourceString("HEADING_EFFORTS"), MyBase.GetResourceString("HEADING_ACTUAL_EFFORTS"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_PERCENT_COMPLETE"), MyBase.GetResourceString("HEADING_IS_TASK_VOID")}
        Dim arrstrTDStyle() As String = {"align='left' width=40%", "align='left' width=5%", "align='left' width=5%", _
                                         "align='left' width=5%", "align='left' width=5%", "align='right' width=5%", "align='right' width=5%", _
                                         "align='right' width=5%", "align='center' width=5%"}
        Dim arrstrCheckboxID() As String = {"", "", "", "", "", "", "", "", "chkTaskvoid"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With m_objTaskVoidGrid
            .ColNameToolTipOnEachRow = True
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .NoOfDataColumns = arrUserFriendlyColumn.GetLength(0) - 1
            .PrimaryKey = "TaskID"
            .CheckBoxIDArray = arrstrCheckboxID
            .ColumnHeaderAlignment = "left"
            .SQL = strSQLQuery
            .DIVHeight = 0
            .DIVID = "divList2"
            .UseSQL = True
            .TDStyleArray = arrstrTDStyle
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub


    'Added by Chakshuta H on 31st March 2014
    'Purpose:To Show All MPP Tasks in the table
    Private Sub DisplayTasksMPPGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""

        ' Added BY MahendraV On 10:40 AM 5/10/2007 module closure
        'Start_MV_5/10/2007


        If m_strModuleMode.Equals("CLOSE_MODULE_TASKS") Then
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForMPPing_ModuleClosure " & CType(m_lngProjectID, String) & "," & CType(m_strModuleId_PK, String)
            'End_MV_5/10/2007
            ' Added BY MahendraV On 4:05 PM 5/12/2007 SubProject closure
            'Start_MV_5/12/2007
        ElseIf m_strSubProjectMode.Equals("CLOSE_SUBPROJECT_TASKS") Then
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForMPPing_SubProjectClosure " & CType(m_lngProjectID, String) & "," & CType(m_strSubProjectId_PK, String)
            'End_MV_5/12/2007
            ' Added BY MahendraV On 3:11 PM 5/15/2007 MileStone closure
            'Start_MV_5/15/2007
        ElseIf m_strMileStoneMode.Equals("CLOSE_MILESTONE_TASKS") Then
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForMPPing_MileStoneClosure " & CType(m_lngProjectID, String) & "," & CType(m_strMileStoneId_PK, String)
            'End_MV_5/15/2007
        Else
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForMPPing_ProjectClosure " & CType(m_lngProjectID, String)
        End If
        Dim arrActualColumns() As String = {"TaskName", "EmployeeName", "StartDate", "EndDate", _
                                            "ActualStartDate", "PlannedWork", "ActualWork", "ActualPercentComplete"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("HEADING_TASK_NAME"), MyBase.GetResourceString("HEADING_EMPLOYEE_NAME"), _
                                                 MyBase.GetResourceString("HEADING_START_DATE"), MyBase.GetResourceString("HEADING_END_DATE"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_START_DATE"), _
                                                 MyBase.GetResourceString("HEADING_EFFORTS"), MyBase.GetResourceString("HEADING_ACTUAL_EFFORTS"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_PERCENT_COMPLETE")}
        Dim arrstrTDStyle() As String = {"align='left' width=40%", "align='left' width=5%", "align='left' width=5%", _
                                         "align='left' width=5%", "align='left' width=5%", "align='right' width=5%", "align='right' width=5%", _
                                         "align='right' width=5%"}
        'Dim arrstrCheckboxID() As String = {"", "", "", "", "", "", "", "", "chkTaskvoid"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With m_objTaskMPPGrid
            .ColNameToolTipOnEachRow = True
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .NoOfDataColumns = arrUserFriendlyColumn.GetLength(0) - 1
            .PrimaryKey = "TaskID"
            '.CheckBoxIDArray = arrstrCheckboxID
            .ColumnHeaderAlignment = "left"
            .SQL = strSQLQuery
            .DIVHeight = 0
            .DIVID = "divList3"
            .UseSQL = True
            .TDStyleArray = arrstrTDStyle
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
    End Sub

    'Ended by Chakshuta H 31st March 2014

#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_ProjectClosure_TaskClosure", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region
End Class
