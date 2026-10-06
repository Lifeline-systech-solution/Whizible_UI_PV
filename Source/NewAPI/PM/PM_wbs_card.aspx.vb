Imports Whiz
Public Class PM_wbs_card
    Inherits WebPages.Template.WhizTemplate
    Protected m_roleLevel As String
    Protected m_AddAccess As String
    Protected m_EditAccess As String
    Protected m_DeleteAccess As String
    Protected m_ViewAccess As String
    Protected m_strStartingDayOfWeek As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.WBS.WBS", "Whizible2Resources")

        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        ' objGlobal.TagID = 22599
        objGlobal.TagID = 1038
        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)
        m_roleLevel = objGlobal.RoleLevel
        m_AddAccess = objAccess.Add
        m_EditAccess = objAccess.Edit
        m_DeleteAccess = objAccess.Delete
        m_ViewAccess = objAccess.View

        'Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
        Dim intSessionProjectID As Integer = Convert.ToInt32(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"))
        Dim strIsSessionProjectClosed As String = "0"

        If intSessionProjectID > 0 Then
            strIsSessionProjectClosed = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_CheckSessionProjectClosed @SessionProjectID = " & intSessionProjectID, True), "0"))

            If strIsSessionProjectClosed = "1" OrElse strIsSessionProjectClosed.ToLower() = "true" Then
                m_AddAccess = False
                m_EditAccess = False
                m_DeleteAccess = False
            End If
        End If
        'End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
        'Added By Chetan M on 12th feb 2020
        If (m_AddAccess = True Or m_EditAccess = True Or m_DeleteAccess = True) Then
            m_ViewAccess = True
        End If
        'End of Added By Chetan M on 12th feb 2020
        m_strStartingDayOfWeek = CommonFunction.Application.StartDayOfWeek.ToString()

    End Sub


End Class