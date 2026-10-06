Public Class PM_Template
    Inherits WebPages.Template.WhizTemplate
    Protected m_CustomerTemplateAddAccess As Boolean = False
    Protected m_CustomerTemplateDeleteAccess As Boolean = False
    Protected m_CustomerTemplateEditAccess As Boolean = False
    Protected m_CustomerTemplateViewAccess As Boolean = False
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        Create_CustomerTemplateGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.CustomerTemplate", "Whizible2Resources")
    End Sub

    Private Sub Create_CustomerTemplateGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 22607

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_CustomerTemplateAddAccess = objAccess.Add 'If user has AddNew Access
        m_CustomerTemplateDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_CustomerTemplateEditAccess = objAccess.Edit 'If user has Edit Access
        m_CustomerTemplateViewAccess = objAccess.View 'If user has View Access

        'If (m_CustomerTemplateAddAccess = True And m_CustomerTemplateEditAccess = True) Then
        '    If (m_CustomerTemplateViewAccess = False) Then
        '        m_CustomerTemplateViewAccess = True
        '    Else
        '        m_CustomerTemplateViewAccess = True
        '    End If

        'Else
        '    If (m_CustomerTemplateViewAccess = False) Then
        '        m_CustomerTemplateViewAccess = False
        '    Else
        '        m_CustomerTemplateViewAccess = True
        '    End If
        'End If

        If (m_CustomerTemplateAddAccess = True Or m_CustomerTemplateEditAccess = True Or m_CustomerTemplateDeleteAccess = True) Then
            m_CustomerTemplateViewAccess = True
        End If

    End Sub

End Class