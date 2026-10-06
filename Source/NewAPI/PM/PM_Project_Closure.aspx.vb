Public Class PM_Project_Closure
    Inherits WebPages.Template.WhizTemplate
    Protected m_PM_ProjectClosureblnAddAccess As Boolean = False
    Protected m_PM_ProjectClosureblnDeleteAccess As Boolean = False
    Protected m_PM_ProjectClosureblnEditAccess As Boolean = False
    Protected m_PM_ProjectClosureblnViewAccess As Boolean = False
    Protected m_ProjectID As String = ""
    Public Sub New()
        'CreateGlobalObject()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectClosure", "Whizible2Resources")
        CreatePM_ProjectClosureGlobalObject()
        m_ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
    End Sub

    Protected Sub CreatePM_ProjectClosureGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 468

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_PM_ProjectClosureblnAddAccess = objAccess.Add 'If user has AddNew Access
        m_PM_ProjectClosureblnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_PM_ProjectClosureblnEditAccess = objAccess.Edit 'If user has Edit Access
        m_PM_ProjectClosureblnViewAccess = objAccess.View

        If (m_PM_ProjectClosureblnAddAccess = True And m_PM_ProjectClosureblnEditAccess = True) Then
            If (m_PM_ProjectClosureblnViewAccess = False) Then
                m_PM_ProjectClosureblnViewAccess = True
            Else
                m_PM_ProjectClosureblnViewAccess = True
            End If

        Else
            If (m_PM_ProjectClosureblnViewAccess = False) Then
                m_PM_ProjectClosureblnViewAccess = False
            Else
                m_PM_ProjectClosureblnViewAccess = True
            End If
        End If





    End Sub

End Class