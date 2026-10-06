Imports Whiz
Public Class PM_ProjectTimesheetlist
    Inherits WebPages.Template.WhizTemplate
    Protected m_AddAccess As Boolean = False 'Add access for the logged in user
    Protected m_EditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_DeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_ViewAccess As Boolean = False 'View access for the logged in user

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim strstring As String
        strstring = Session("intUserID").ToString
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 1049
        CreateGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectTimesheetList", "Whizible2Resources")

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GeneratePK_Token(ByVal ProjectID As String, ByVal EmployeeID As String) As String
        Dim m_PKToken_FromTimesheetList As String
        m_PKToken_FromTimesheetList = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Session("intProjectID").ToString, "0"), String) + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "1049")
        Return m_PKToken_FromTimesheetList
    End Function

    Private Sub CreateGlobalObject()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 1049

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_AddAccess = objAccess.Add 'If user has AddNew Access
        m_DeleteAccess = objAccess.Delete 'If User has Delete Access
        m_EditAccess = objAccess.Edit 'If user has Edit Access
        m_ViewAccess = objAccess.View 'If user has View Access

        If (m_AddAccess = True And m_EditAccess = True) Then
            If (m_ViewAccess = False) Then
                m_ViewAccess = True
            Else
                m_ViewAccess = True
            End If

        Else
            If (m_ViewAccess = False) Then
                m_ViewAccess = False
            Else
                m_ViewAccess = True
            End If
        End If
    End Sub
End Class