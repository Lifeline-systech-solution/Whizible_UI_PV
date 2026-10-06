Public Class PM_Bulk_Extension
    Inherits WebPages.Template.WhizTemplate
    Protected m_blnAddAccess As Boolean = False 'user has Add Access ?
    Protected m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Protected m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public m_blnViewAccess As Boolean = False 'User has View Access ?
    Protected m_ProjectId As Long 'ProjectId
    Protected m_blnPMAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnPMEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnPMDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnPMViewAccess As Boolean = False 'User has Edit Access ?
    Protected m_blnResAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnResEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnResDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnResViewAccess As Boolean = False 'User has Edit Access ?

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        CreateGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_Bulk_Extension", "Whizible2Resources")
        'MyBase.InitializeResources("Whizible2Resources.Source.SM.SM_CityMaster", "Whizible2Resources")
    End Sub


    Public Sub CreateGlobalObject()
        'Dim m_objGlobal As WebPages.Template.IGlobal
        'Dim m_objAccess As New WebPage.Templates.AccessRights
        'm_objAccess = New WebPage.Templates.AccessRights

        'Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 36089, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        'm_objAccess.GetAccess(objGlobal)
        'm_objGlobal = objGlobal

        'm_blnAddAccess = m_objAccess.Add 'If user has AddNew Access
        'm_blnDeleteAccess = m_objAccess.Delete 'If User has Delete Access
        'm_blnEditAccess = m_objAccess.Edit 'If user has Edit Access
        'm_blnViewAccess = m_objAccess.View 'If user has View Access

        'If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
        '    m_blnViewAccess = True
        'End If
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        m_ProjectId = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 36127

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = objAccess.View 'If user has View Access

        'm_blnAddAccess = False
        'm_blnDeleteAccess = False
        'm_blnEditAccess = False
        'm_blnViewAccess = False

        If (m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True) Then
            m_blnViewAccess = True
        End If
        'Added By Riddhesh Patil on 29 Jan 2025
        CreatePMGlobalObject()
        CreateResGlobalObject()
        'End of Added By Riddhesh Patil on 29 Jan 2025
    End Sub
    'Added By Riddhesh Patil on 29 Jan 2025
    Private Sub CreatePMGlobalObject()
        'Throw New NotImplementedException()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 36129

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnPMAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnPMDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnPMEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnPMViewAccess = objAccess.View

        If (m_blnPMAddAccess = True Or m_blnPMEditAccess = True Or m_blnPMDeleteAccess = True) Then
            m_blnPMViewAccess = True
        End If

    End Sub
    Private Sub CreateResGlobalObject()
        'Throw New NotImplementedException()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 36130

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnResAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnResDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnResEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnResViewAccess = objAccess.View
        If (m_blnResAddAccess = True Or m_blnResEditAccess = True Or m_blnResDeleteAccess = True) Then
            m_blnResViewAccess = True
        End If
    End Sub
    'End of Added By Riddhesh Patil on 29 Jan 2025 
End Class

