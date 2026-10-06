Public Class SCM_New
    Inherits WebPages.Template.WhizTemplate
    Protected m_blnAddAccess As Boolean = False 'user has Add Access ?
    Protected m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Protected m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public m_blnViewAccess As Boolean = False 'User has View Access ?
    Protected m_ProjectId As Long = 0 'Current Project ID

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        CreateGlobalObject()
        Try
            ' Safely initialize resources if available; keep page resilient if not present
            MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_SCMPlan", "Whizible2Resources")
        Catch
        End Try

        Dim UserName As String = Session("strUserName").ToString()
    End Sub

    Public Sub CreateGlobalObject()
        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights

        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 1053, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        ' Set the current project ID from the global object
        If objGlobal.ProjectID > 0 Then
            m_ProjectId = objGlobal.ProjectID
            System.Diagnostics.Debug.WriteLine($"SCM_New: Set m_ProjectId to {m_ProjectId} from objGlobal.ProjectID")
        Else
            System.Diagnostics.Debug.WriteLine($"SCM_New: objGlobal.ProjectID is {objGlobal.ProjectID}, keeping m_ProjectId as {m_ProjectId}")
        End If

        m_blnAddAccess = m_objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = m_objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = m_objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = m_objAccess.View 'If user has View Access

        If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
            m_blnViewAccess = True
        End If
    End Sub
    
    Public Function GetProjectID() As String
        ' Debug logging
        System.Diagnostics.Debug.WriteLine($"SCM_New GetProjectID: Session('intProjectID') = {Session("intProjectID")}")
        System.Diagnostics.Debug.WriteLine($"SCM_New GetProjectID: Request.QueryString('ProjectID') = {Request.QueryString("ProjectID")}")
        System.Diagnostics.Debug.WriteLine($"SCM_New GetProjectID: m_ProjectId = {m_ProjectId}")
        
        ' Try to get ProjectID from URL parameter first (like PM_BackupPlans)
        Dim urlProjectID As String = Request.QueryString("ProjectID")
        If Not String.IsNullOrEmpty(urlProjectID) AndAlso urlProjectID <> "null" AndAlso urlProjectID <> "0" Then
            System.Diagnostics.Debug.WriteLine($"SCM_New GetProjectID: Using URL ProjectID = {urlProjectID}")
            Return urlProjectID
        End If
        
        ' Try to get ProjectID from session second
        If Session("intProjectID") IsNot Nothing AndAlso Session("intProjectID").ToString() <> "" AndAlso Session("intProjectID").ToString() <> "0" Then
            System.Diagnostics.Debug.WriteLine($"SCM_New GetProjectID: Using session ProjectID = {Session("intProjectID")}")
            Return Session("intProjectID").ToString()
        End If
        
        ' Fallback to m_ProjectId if neither URL nor session is available
        System.Diagnostics.Debug.WriteLine($"SCM_New GetProjectID: Using m_ProjectId = {m_ProjectId}")
        Return m_ProjectId.ToString()
    End Function
    
    Public Function GetUserID() As String
        Return Session("intUserID").ToString()
    End Function
    
    Public Function GetUserName() As String
        Return Session("strUserName").ToString()
    End Function
End Class
