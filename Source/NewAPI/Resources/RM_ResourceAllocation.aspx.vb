Public Class RM_ResourceAllocation

    Inherits WebPages.Template.WhizTemplate
    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnViewAccess As Boolean = False 'View access for the logged in user
    Public m_PKToken_FromResourcesList As String = ""
    Private m_lngTagId As Long = 0
    Protected m_lngRequestProjectId As Long = 0
    Private m_strProjectName As String = ""
    Private m_strProjectStartDate As String = ""
    Private m_strProjectEndDate As String = ""
    Private m_dblProjectWorkHours As Double = 0
    Protected m_lngRequestTeamID As Long = 0
    Protected TYPE_PER_DAY As String = "HPD"
    Protected TYPE_TOTAL_WORKHOURS As String = "TH"
    Protected TYPE_PERCENT_WORKHOURS As String = "P"
    Protected m_blnUseProjectPool As Boolean
    Protected m_intSelectEmployeeType As Integer
    Protected TYPE_TH As String = "TH"
    Protected TYPE_P As String = "P"
    Protected TYPE_HPD As String = "HPD"
    Protected ResourceAllocationLevel As String = ""
    Protected ResourceAllocationSettingValue As String = ""
    Protected IsConfigureAllocationType As Boolean = False
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        MyBase.ApplySecurity(True)
        'added by Riddhesh P on 10-04-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by Riddhesh P on 10-04-2023
        CreateGlobalObject()
        GetProjectInformation()
        MyBase.InitializeResources("AppResources.PM_ResourceAllocationDetails", "AppResources")
        MyBase.InitializeResources("Whizible2Resources.Source.Resource.RM_ResourceAllocation", "Whizible2Resources")
        Dim strQuery As String = "Exec usp_Sel_tbl_PM_CompanyInformation "
        Dim drRequest As IDataReader = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drRequest) <> "" Then
            If drRequest.Read() Then
                m_blnUseProjectPool = CType(CommonFunctions.Data.CheckIsDBNull(drRequest.Item("UseProjectPool"), "False"), Boolean)
                ResourceAllocationLevel = CType(CommonFunctions.Data.CheckIsDBNull(drRequest.Item("ResourceAllocationLevel"), ""), String)
            End If
        End If

        Dim strSQL As String = "Exec usp_Whizible2_sel_tbl_sem_settings_SettingValue "
        ResourceAllocationSettingValue = CommonFunctions.Data.GetDataScalar(strSQL, True)

        IsConfigureAllocationType = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_sel_Tbl_Whizible_ResourceRequestConfiguration ", True), "False"), Boolean)

        CommonFunctions.Data.DisposeDataReader(drRequest)
        If m_blnUseProjectPool Then
            If m_intSelectEmployeeType = 0 Then m_intSelectEmployeeType = 3
        End If
    End Sub
    Private Sub CreateGlobalObject()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        Dim blnPrjExists As Boolean = False
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 1225

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)
        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = objAccess.View 'If user has View Access

        m_PKToken_FromResourcesList = CommonFunctions.Security.Token.GetToken("1225" + CType(Session("intUserID"), String))
        If (((m_PKToken_FromResourcesList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("1225" + CType(Session("intUserID"), String), m_PKToken_FromResourcesList) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If
    End Sub

    Private Sub GetProjectInformation()
        '====================================================================
        ' Procedure Name        : GetProjectInformation
        ' Parameters Passed     : None
        ' Returns               : None 
        ' Parameters Affected   : None
        ' Purpose               : This procedure fetch the project related information from database.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================

        Dim drProject As IDataReader
        Dim strQuery As String = ""

        strQuery = "EXEC usp_Sel_tbl_PM_ProjectExpectedDates " & m_lngRequestProjectId.ToString()
        drProject = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drProject) <> "" Then
            If drProject.Read() Then
                'Commented AND Added by KIRAN K K For IssueId:2695
                m_strProjectStartDate = drProject.Item("ExpectedStartDate").ToString()
                'm_strProjectStartDate = Format(CType(FormatDateTime(CType(drProject.Item("ExpectedStartDate").ToString, Date), DateFormat.ShortDate), Date), "MM/dd/yyyy")
                'Commented AND Added End by KIRAN K K For IssueId:2695  
                m_strProjectStartDate = CommonFunctions.Dates.GetDate(CType(m_strProjectStartDate, Date))
                'Commented AND Added by KIRAN K K For IssueId:2695  
                m_strProjectEndDate = drProject.Item("ExpectedEndDate").ToString()
                'm_strProjectEndDate = Format(CType(FormatDateTime(CType(drProject.Item("ExpectedEndDate").ToString, Date), DateFormat.ShortDate), Date), "MM/dd/yyyy")

                ' m_strProjectEndDate = CommonFunctions.Dates.GetDate(CType(m_strProjectEndDate, Date)) 
                m_strProjectEndDate = CommonFunctions.Dates.GetDate(Convert.ToDateTime(drProject.Item("ExpectedEndDate").ToString))
                'Commented AND Added  End by KIRAN K K For IssueId:2695
                m_lngRequestTeamID = CType(CommonFunctions.Data.CheckIsDBNull(drProject.Item("ResourceGroupID"), "0"), Long)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drProject)

        strQuery = "Exec usp_Sel_tbl_PM_GetWorkingHours " & m_lngRequestProjectId.ToString()
        m_dblProjectWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Double)
    End Sub

    <System.Web.Services.WebMethod>
    Public Shared Function Resume_OnClick(EmployeeID As String, LoginEmployeeID As String) As String
        Dim m_PKToken_Request_Task As String
        m_PKToken_Request_Task = CommonFunctions.Security.Token.GetToken("1225" + CType(EmployeeID, String) + CType(LoginEmployeeID, String))

        Return m_PKToken_Request_Task

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ResourceLoad_OnClick(ByVal ProjectID As String, ByVal EmployeeID As String) As String
        Dim ResourceProjectID As String
        ResourceProjectID = ProjectID

        Dim m_PKToken_FromResourcesList As String
        m_PKToken_FromResourcesList = CommonFunctions.Security.Token.GetToken("1019" + ResourceProjectID + EmployeeID + CType(HttpContext.Current.Session("intUserID"), String))

        Return m_PKToken_FromResourcesList
    End Function
End Class