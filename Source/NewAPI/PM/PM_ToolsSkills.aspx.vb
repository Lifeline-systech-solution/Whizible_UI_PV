
Public Class PM_ToolsSkills
    Inherits WebPages.Template.WhizTemplate
    Protected m_blnAddAccess As Boolean = False
    Protected m_blnDeleteAccess As Boolean = False
    Protected m_blnEditAccess As Boolean = False
    Public m_blnViewAccess As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        CreateGlobalObject()

        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ToolSkillNew", "Whizible2Resources")

    End Sub

    Public Sub CreateGlobalObject()
        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights

        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 35, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        m_blnAddAccess = m_objAccess.Add
        m_blnDeleteAccess = m_objAccess.Delete
        m_blnEditAccess = m_objAccess.Edit
        m_blnViewAccess = m_objAccess.View

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

        If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
            m_blnViewAccess = True
        End If
    End Sub

End Class
