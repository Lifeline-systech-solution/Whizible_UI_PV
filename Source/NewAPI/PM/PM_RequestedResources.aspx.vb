Public Class PM_RequestedResources
    Inherits WebPages.Template.WhizTemplate
    Protected m_PKToken_ToResourcesList As String = ""
    Protected m_PKToken_FromResourcesList As String = ""
    Public UserID As String
    Public ProjectID As String
    Public selProjectId As String
    Public strProjectId As String
    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnViewAccess As Boolean = False 'View access for the logged in user
    Protected Count_Request_ResourceSkill As String
    Protected IsRequestResourceSkillMandatory As String
    Protected IsResourceSkillCoreCompetencyMandatory As String
    Protected IsResourceRequestsplittingbased As String
    Protected IsResourceRequestNewFieldsManatory As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_Resources", "Whizible2Resources")


        'strProjectId = Trim(Request.QueryString("ProjectID") & "")
        'If ((strProjectId Is Nothing Or strProjectId = "")) Then
        '    selProjectId = 0
        'Else
        '    selProjectId = CType(strProjectId, Long)
        'End If



        ProjectID = Trim(Request.QueryString("ProjectID") & "")
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 1220
        CreateGlobalObject()
        GetResourceRequestConfiguration()

        m_PKToken_FromResourcesList = Trim(Request.QueryString("PKToken") & "")

        m_PKToken_ToResourcesList = CommonFunctions.Security.Token.GetToken("1220" + ProjectID + CType(Session("intUserID"), String))

        If (((m_PKToken_FromResourcesList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("1220" + ProjectID + CType(Session("intUserID"), String), m_PKToken_FromResourcesList) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If
    End Sub

    Private Sub CreateGlobalObject()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        Dim blnPrjExists As Boolean = False

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 1220

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = objAccess.View 'If user has View Access

        If (m_blnAddAccess = True And m_blnEditAccess = True) Then
            If (m_blnViewAccess = False) Then
                m_blnViewAccess = True
            Else
                m_blnViewAccess = True
            End If

        Else
            If (m_blnViewAccess = False) Then
                m_blnViewAccess = False
            Else
                m_blnViewAccess = True
            End If
        End If
    End Sub

    '//Added By Dipali V On 15th Nov 2022 For Sonata Customzation
    Private Sub GetResourceRequestConfiguration()
        Dim drGetConf As IDataReader
        Dim strHTML As New StringBuilder
        Dim StrQuery As String = ""
        StrQuery = "usp_Whizible2_Tbl_Whizible_ResourceRequestConfiguration "
        drGetConf = CommonFunctions.Data.GetDataReader(StrQuery, True)
        While drGetConf.Read
            Count_Request_ResourceSkill = CommonFunctions.Data.CheckIsDBNull(drGetConf("Count_Request_ResourceSkill").ToString, "")
            IsRequestResourceSkillMandatory = CommonFunctions.Data.CheckIsDBNull(drGetConf("IsRequestResourceSkillMandatory").ToString, "")
            IsResourceSkillCoreCompetencyMandatory = CommonFunctions.Data.CheckIsDBNull(drGetConf("IsResourceSkillCoreCompetencyMandatory").ToString, "")
            IsResourceRequestsplittingbased = CommonFunctions.Data.CheckIsDBNull(drGetConf("IsResourceRequestsplittingbased").ToString, "")
            IsResourceRequestNewFieldsManatory = CommonFunctions.Data.CheckIsDBNull(drGetConf("IsResourceRequestNewFieldsManatory").ToString, "")

        End While
        '//End of Added By Dipali V On 15th Nov 2022 For Sonata Customzation
    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function GeneratePK_TokenUtilization(ByVal ProjectID As String, ByVal EmployeeID As String) As String
        Dim ResourceProjectID As String
        ResourceProjectID = ProjectID

        Dim m_PKToken_FromResourcesList As String
        m_PKToken_FromResourcesList = CommonFunctions.Security.Token.GetToken("1019" + ResourceProjectID + EmployeeID + CType(HttpContext.Current.Session("intUserID"), String))

        Return m_PKToken_FromResourcesList
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ValidatePK_TokenUtilization(ByVal ProjectID As String, ByVal EmployeeID As String, ByVal PKToken As String) As Boolean
        Try
            If (((PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("1019" + ProjectID + EmployeeID + CType(HttpContext.Current.Session("intUserID"), String), PKToken) = False)) Then

                'System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836", False)

                Return False
            Else

                Return True

            End If

        Catch ex As Exception
            Return False
        End Try
    End Function

End Class