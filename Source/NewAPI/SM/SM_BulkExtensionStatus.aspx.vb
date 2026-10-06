Public Class SM_BulkExtensionStatus
    Inherits WebPages.Template.WhizTemplate
    Protected m_blnAddAccess As Boolean = False 'user has Add Access ?
    Protected m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Protected m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public m_blnViewAccess As Boolean = False 'User has View Access ?

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        CreateGlobalObject()

        'MyBase.InitializeResources("Whizible2Resources.Source.SM.SM_BulkExtensionStatus", "Whizible2Resources")
        MyBase.InitializeResources("Whizible2Resources.Source.SM.SM_BulkExtensionStatus", "Whizible2Resources")
    End Sub

    Public Sub CreateGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 36140

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = objAccess.View 'If user has View Access

        If (m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True) Then
            m_blnViewAccess = True
        End If
    End Sub

End Class