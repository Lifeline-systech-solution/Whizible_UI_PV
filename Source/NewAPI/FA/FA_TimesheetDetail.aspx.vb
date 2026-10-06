

'Added by Vaibhav K on 26-12-25 for W26 Project Timesheet Approval page on  05-03-26
Public Class FA_TimesheetDetail
    Inherits WebPages.Template.WhizTemplate
    Protected m_AddAccess As Boolean = False 'Add access for the logged in user
    Protected m_EditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_DeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_ViewAccess As Boolean = False 'View access for the logged in user
    Protected m_blnTimeSheetAuthenticated As Boolean = False
    Protected m_blnTImeSheetReadyForAuthentication As Boolean = False
    'Protected MinHoursForDAEntry As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim strstring As String
        Dim intTimeSheetNo As String
        strstring = Session("intUserID").ToString
        intTimeSheetNo = Trim(Request.QueryString("TimeSheetNo") & "")
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 42
        CreateGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectTimeSheetApproval", "Whizible2Resources")
        m_blnTimeSheetAuthenticated = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_udf_TimeSheetAuthenticated " + intTimeSheetNo.ToString, MyBase.UseSQL), "False"), Boolean)
        m_blnTImeSheetReadyForAuthentication = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_udf_TimeSheetReadyForAuthentication " + intTimeSheetNo.ToString, MyBase.UseSQL), "False"), Boolean)
    End Sub
    Private Sub CreateGlobalObject()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        Dim blnPrjExists As Boolean = False

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 42

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

'End of Added by Vaibhav K on 26-12-25 for W26 Project Timesheet Approvalk page  on  05-03-26