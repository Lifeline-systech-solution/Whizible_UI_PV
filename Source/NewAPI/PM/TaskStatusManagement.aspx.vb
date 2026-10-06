Public Class TaskStatusManagement
    Inherits WebPages.Template.WhizTemplate
    Protected m_intProjectID As String = ""
    Protected strSQLQuery As String = ""
    Protected m_intEmployeeID As String = ""
    Protected Const TASK_TYPE_ASSIGNED As String = "O"
    Protected Const TASK_TYPE_MPP As String = "M"
    Protected Const TASK_TYPE_ISSUE As String = "B"
    Protected Const TASK_TYPE_REVIEW As String = "R"
    Protected Const TASK_TYPE_HELPDESK As String = "H"
    Protected Const OPERATION_VOID_TASKS As Integer = 1
    Protected Const OPERATION_VALID_TASKS As Integer = 2
    Protected Const OPERATION_BILLABEL_TASKS As Integer = 3
    Protected Const OPERATION_NONBILLABEL_TASKS As Integer = 4
    Protected Const OPERATION_ONHOLD_TASKS As Integer = 5
    Protected Const OPERATION_REMOVE_ONHOLD_TASKS As Integer = 6
    Protected Const OPERATION_REOPEN_TASKS As Integer = 7
    Protected Const OPERATION_ACCRUAL_PRORATA As Integer = 9
    Protected Const OPERATION_ACCRUAL_ONCOMPLETION As Integer = 10
    Protected Const OPERATION_SET_BASELINE As Integer = 11
    Protected Const OPERATION_CLEAR_BASELINE As Integer = 12
    Protected Const OPERATION_SAVE_PERCENTCOMPLETE As Integer = 13
    Protected Const MODE_LIST As String = "List"
    Protected Const MODE_SAVE As String = "Save"
    Protected m_btRestrictDurationChange_M As Boolean 'Added by KapilK On 11-Sep-08
    Protected m_intMSPIntegrationMethod As Integer 'Added by KapilK On 11-Sep-08
    Protected m_strProjectStartDate As String
    Protected m_strProjectEndDate As String
    Public m_blnAddAccess As Boolean = False 'user has Add Access ?
    Public m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Public m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public m_blnViewAccess As Boolean = False 'User has View Access ?
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_TaskStatusManagement", "AppResources")
        m_intProjectID = Session("intProjectID").ToString()
        m_intEmployeeID = CType(Session("intUserID"), String)

        'commented And AddedControl by Aditya J. On 20-08-2026 For showing the closed projects
        ' Commented and updated by Vyankat Bhure on 1st April 2026 for changing the SP to resolve placeholder issue

        'strSQLQuery = "EXEC usp_Sel_AccessibleProjects_ForEmployee " + CType(Session("intUserID"), String) & ",0,0,0,0,'" & CType(Session("LoginType"), String) & "',0," & CType(Session("intLoginID"), Long) & ",1,0"
        'commented And AddedControl() by Aditya J. on 20-08-2026 for showing the closed projects
        'strSQLQuery = "EXEC usp_Sel_AccessibleProjects_TaskStatus " + CType(Session("intUserID"), String) & ",0,0,0,0,'" & CType(Session("LoginType"), String) & "',0," & CType(Session("intLoginID"), Long) & ",1,0"
        strSQLQuery = "EXEC usp_Whizible2_Sel_AccessibleProjects_WithSelected " &
              CType(Session("intUserID"), String) & ",'" &
              CType(Session("LoginType"), String) &
              "',1,0,'[Over] = ''0''','ProjectName ASC'," &
              IIf(String.IsNullOrEmpty(Convert.ToString(Session("intProjectID"))) OrElse
                  Convert.ToString(Session("intProjectID")) = "0",
                  "NULL",
                  Convert.ToString(Session("intProjectID")))

        ' End of Commented and updated by Vyankat Bhure on 1st April 2026 for changing the SP to resolve placeholder issue
        'End Of commented And AddedControl by Aditya J. On 20-08-2026 For showing the closed projects

        Dim drProjectCompanySetting As IDataReader

        drProjectCompanySetting = CommonFunctions.Data.GetDataReader("usp_sel_Project_CompanySetting " & m_intProjectID, True)

        While drProjectCompanySetting.Read
            m_btRestrictDurationChange_M = CommonFunctions.Data.CheckIsDBNull(drProjectCompanySetting("RestrictDurationChange_M"))
            m_intMSPIntegrationMethod = CType(CommonFunctions.Data.CheckIsDBNull(drProjectCompanySetting("MSPIntegrationMethod")), Integer)
            m_strProjectStartDate = CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drProjectCompanySetting("ProjectStartDate")), Date))
            m_strProjectEndDate = CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drProjectCompanySetting("ProjectEndDate")), Date))
        End While
        CommonFunctions.Data.DisposeDataReader(drProjectCompanySetting)
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        'objGlobal.TagID = 3026
        objGlobal.TagID = 1038

        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = objAccess.View 'If user has View Access

        'Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
        Dim intSessionProjectID As Integer = Convert.ToInt32(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"))
        Dim strIsSessionProjectClosed As String = "0"

        If intSessionProjectID > 0 Then
            strIsSessionProjectClosed = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_CheckSessionProjectClosed @SessionProjectID = " & intSessionProjectID, True), "0"))

            If strIsSessionProjectClosed = "1" OrElse strIsSessionProjectClosed.ToLower() = "true" Then
                m_blnAddAccess = False
                m_blnEditAccess = False
                m_blnDeleteAccess = False
            End If
        End If
        'End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
    End Sub

End Class