Public Class HR_ResourceSkillDetails
    Inherits WebPages.Template.WhizTemplate
    Protected m_AddAccess As Boolean = False 'Add access for the logged in user
    Protected m_EditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_DeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_ViewAccess As Boolean = False 'View access for the logged in user

    Protected m_PKToken As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        MyBase.InitializeResources("Whizible2Resources.Source.Resource.HR_ResourceSkillDetails", "Whizible2Resources")

        CreateGlobalObject()


        m_PKToken = CommonFunctions.Security.Token.GetToken("3861" + CType(Session("intUserID"), String))

        If (((m_PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("3861" + CType(Session("intUserID"), String), m_PKToken) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If

    End Sub

    Private Sub CreateGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3861

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_AddAccess = objAccess.Add 'If user has AddNew Access
        m_DeleteAccess = objAccess.Delete 'If User has Delete Access
        m_EditAccess = objAccess.Edit 'If user has Edit Access
        m_ViewAccess = objAccess.View 'If user has View Access

        If (m_AddAccess = True Or m_EditAccess = True Or m_DeleteAccess = True) Then
            m_ViewAccess = True
        End If
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
                Return False
            Else
                Return True
            End If

        Catch ex As Exception
            Return False
        End Try
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GeneratePK_TokenResumePage(ByVal EmployeeID As String) As String

        Dim m_PKToken_FromResumeList As String
        m_PKToken_FromResumeList = CommonFunctions.Security.Token.GetToken("3861" + EmployeeID + CType(HttpContext.Current.Session("intUserID"), String))

        Return m_PKToken_FromResumeList
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ValidatePK_TokenResumePage(ByVal EmployeeID As String, ByVal PKToken As String) As Boolean
        Try
            If (((PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("3861" + EmployeeID + CType(HttpContext.Current.Session("intUserID"), String), PKToken) = False)) Then
                Return False
            Else
                Return True
            End If

        Catch ex As Exception
            Return False
        End Try
    End Function

End Class