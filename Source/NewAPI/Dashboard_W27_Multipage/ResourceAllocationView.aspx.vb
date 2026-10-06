Public Class ResourceAllocationView
    Inherits WebPages.Template.WhizTemplate

    Protected m_blnAddAccess As Boolean = False       'User has Add Access?
    Protected m_blnDeleteAccess As Boolean = False    'User has Delete Access?
    Protected m_blnEditAccess As Boolean = False      'User has Edit Access?
    Public m_blnViewAccess As Boolean = False         'User has View Access?

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        MyBase.ApplySecurity(True)
        CreateGlobalObject()

        MyBase.InitializeResources(
            "Whizible2Resources.Source.PM.ResourceAllocationView",
            "Whizible2Resources"
        )

        Dim UserName As String = Session("strUserName").ToString()

    End Sub

    'Created By : Vyankat B.
    'Purpose    : To handle role-level access for Resource Allocation View page.

    Public Sub CreateGlobalObject()

        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim m_objAccess As New WebPage.Templates.AccessRights

        m_objAccess = New WebPage.Templates.AccessRights

        Dim objGlobal As New WebPage.Templates.WhizGlobal(
            Session("strUserName").ToString(),
            21045,
            CType(Session("intPostID"), Integer),
            CType(Session("intUserID"), Integer),
            Session("LoginType").ToString()
        )

        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        m_blnAddAccess = m_objAccess.Add
        m_blnDeleteAccess = m_objAccess.Delete
        m_blnEditAccess = m_objAccess.Edit
        m_blnViewAccess = m_objAccess.View

        If m_blnAddAccess = True Or
           m_blnEditAccess = True Or
           m_blnDeleteAccess = True Then

            m_blnViewAccess = True

        End If

    End Sub

End Class