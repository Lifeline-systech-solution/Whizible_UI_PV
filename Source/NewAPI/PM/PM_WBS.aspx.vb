Public Class PM_WBS
    Inherits WebPages.Template.WhizTemplate

    Protected m_SubProjectblnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_SubProjectblnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_SubProjectblnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_SubProjectblnViewAccess As Boolean = False 'Delete access for the logged in user
    Public pm_Phase_blnAddAccess As Boolean = False 'user has Add Access ?
    Public pm_Phase_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Public pm_Phase_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public pm_Phase_blnViewAccess As Boolean = False 'User has Edit Access ?
    Public m_blnMLViewAccess As Boolean = False 'User has Edit Access ?

    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnViewAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnMLAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnMLEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnMLDeleteAccess As Boolean = False 'Delete access for the logged in user
    'Protected m_blnMLViewAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnDlvAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnDlvViewAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnDlvEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnDlvDeleteAccess As Boolean = False 'Delete access for the logged in user
    'Added By Vyankat Bhure on 08-07-2026 for WBS Excel Upload role access (TagID 86168)
    'Protected m_blnWBSExcelAddAccess As Boolean = False 'Add access for WBS Excel Upload (TagID 86168)
    'Protected m_blnWBSExcelEditAccess As Boolean = False 'Edit access for WBS Excel Upload (TagID 86168)
    'Protected m_blnWBSExcelDeleteAccess As Boolean = False 'Delete access for WBS Excel Upload (TagID 86168)
    'Public m_blnWBSExcelViewAccess As Boolean = False 'View access for WBS Excel Upload (TagID 86168)
    'End of Added By Vyankat Bhure on 08-07-2026 for WBS Excel Upload role access (TagID 86168)

    Protected m_blnWBSExcelAddAccess As Boolean = False
    Protected m_blnWBSExcelDeleteAccess As Boolean = False
    Protected m_blnWBSExcelEditAccess As Boolean = False
    Public m_blnWBSExcelViewAccess As Boolean = False

    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    MyBase.ApplySecurity(True)
    '    CreateGlobalObject()

    '    MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_Releases", "Whizible2Resources")

    'End Sub


    Protected m_ProjectID As String = "" 'Delete access for the logged in user
    Public Sub New()
        'CreateGlobalObject()
    End Sub
    Public Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        CreateWBSExcelGlobalObject()
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023



        CreateSubProjectGlobalObject()
        PhaseAccess()
        CreateGlobalObject()
        CreateMLGlobalObject()
        CreateDlvGlobalObject()
        'Added By Vyankat Bhure on 08-07-2026 for WBS Excel Upload role access (TagID 86168)
        'End of Added By Vyankat Bhure on 08-07-2026 for WBS Excel Upload role access (TagID 86168)
        m_ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_WBS", "Whizible2Resources")
    End Sub
    Private Sub CreateSubProjectGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 661


        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_SubProjectblnAddAccess = objAccess.Add 'If user has AddNew Access
        m_SubProjectblnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_SubProjectblnEditAccess = objAccess.Edit 'If user has Edit Access
        m_SubProjectblnViewAccess = objAccess.View 'If user has Edit Access

        'Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
        Dim intSessionProjectID As Integer = Convert.ToInt32(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"))
        Dim strIsSessionProjectClosed As String = "0"

        If intSessionProjectID > 0 Then
            strIsSessionProjectClosed = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_CheckSessionProjectClosed @SessionProjectID = " & intSessionProjectID, True), "0"))

            If strIsSessionProjectClosed = "1" OrElse strIsSessionProjectClosed.ToLower() = "true" Then
                m_SubProjectblnAddAccess = False
                m_SubProjectblnEditAccess = False
                m_SubProjectblnDeleteAccess = False
            End If
        End If
        'End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects

    End Sub
    Public Sub PhaseAccess()
        Dim m_objGlobal As WebPages.Template.IGlobal

        Dim m_objAccess As New Whiz.WebPage.Templates.AccessRights
        m_objAccess = New Whiz.WebPage.Templates.AccessRights


        ' Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)


        Dim objGlobal As New Whiz.WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 516, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        pm_Phase_blnAddAccess = m_objAccess.Add 'If user has AddNew Access
        pm_Phase_blnDeleteAccess = m_objAccess.Delete 'If User has Delete Access
        pm_Phase_blnEditAccess = m_objAccess.Edit 'If user has Edit Access
        pm_Phase_blnViewAccess = m_objAccess.View 'If user has view Access

        'Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
        Dim intSessionProjectID As Integer = Convert.ToInt32(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"))
        Dim strIsSessionProjectClosed As String = "0"

        If intSessionProjectID > 0 Then
            strIsSessionProjectClosed = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_CheckSessionProjectClosed @SessionProjectID = " & intSessionProjectID, True), "0"))

            If strIsSessionProjectClosed = "1" OrElse strIsSessionProjectClosed.ToLower() = "true" Then
                pm_Phase_blnAddAccess = False
                pm_Phase_blnEditAccess = False
                pm_Phase_blnDeleteAccess = False
            End If
        End If
        'End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
    End Sub
    Private Sub CreateGlobalObject()

        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 454


        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = objAccess.View 'If user has Edit Access

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
    End Sub

    Private Sub CreateMLGlobalObject()
        'Throw New NotImplementedException()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 34

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnMLAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnMLDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnMLEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnMLViewAccess = objAccess.View

        'Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
        Dim intSessionProjectID As Integer = Convert.ToInt32(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"))
        Dim strIsSessionProjectClosed As String = "0"

        If intSessionProjectID > 0 Then
            strIsSessionProjectClosed = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_CheckSessionProjectClosed @SessionProjectID = " & intSessionProjectID, True), "0"))

            If strIsSessionProjectClosed = "1" OrElse strIsSessionProjectClosed.ToLower() = "true" Then
                m_blnMLAddAccess = False
                m_blnMLEditAccess = False
                m_blnMLDeleteAccess = False
            End If
        End If
        'End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
    End Sub

    Private Sub CreateDlvGlobalObject()
        'Throw New NotImplementedException()
        Dim objGlobal As WebPages.Template.IGlobal

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 2133

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnDlvAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDlvDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnDlvEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnDlvViewAccess = objAccess.View 'If user has Edit Access

        'Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
        Dim intSessionProjectID As Integer = Convert.ToInt32(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"))
        Dim strIsSessionProjectClosed As String = "0"

        If intSessionProjectID > 0 Then
            strIsSessionProjectClosed = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_CheckSessionProjectClosed @SessionProjectID = " & intSessionProjectID, True), "0"))

            If strIsSessionProjectClosed = "1" OrElse strIsSessionProjectClosed.ToLower() = "true" Then
                m_blnDlvAddAccess = False
                m_blnDlvEditAccess = False
                m_blnDlvDeleteAccess = False
            End If
        End If
        'End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects

    End Sub

    'Added By Vyankat Bhure on 08-07-2026 for WBS Excel Upload role access (TagID 86168)

    'Public Sub CreateWBSExcelGlobalObject()
    '    Dim objAccess As New Whiz.WebPage.Templates.AccessRights
    '    Dim objGlobal As New Whiz.WebPage.Templates.WhizGlobal(
    '        Session("strUserName").ToString(),
    '        86168,
    '        CType(Session("intPostID"), Integer),
    '        CType(Session("intUserID"), Integer),
    '        Session("LoginType").ToString())

    '    objAccess.GetAccess(objGlobal)

    '    m_blnWBSExcelAddAccess = objAccess.Add
    '    m_blnWBSExcelDeleteAccess = objAccess.Delete
    '    m_blnWBSExcelEditAccess = objAccess.Edit
    '    m_blnWBSExcelViewAccess = objAccess.View

    '    If m_blnWBSExcelAddAccess = True Or m_blnWBSExcelEditAccess = True Or m_blnWBSExcelDeleteAccess = True Then
    '        m_blnWBSExcelViewAccess = True
    '    End If

    'End Sub
    'End of Added By Vyankat Bhure on 08-07-2026 for WBS Excel Upload role access (TagID 86168)


    Public Sub CreateWBSExcelGlobalObject()
        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights

        ' TODO: Update the page ID (694) with the correct page ID for Releases
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 86168, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        'Dim objGlobal As WebPages.Template.IGlobal

        'MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        'objGlobal = MyBase.GlobalObject
        'objGlobal.TagID = 86168

        'Dim objAccess As New WebPages.Template.AccessRights
        'objAccess.GetAccess(objGlobal)

        'Dim objAccess As New WebPages.Template.AccessRights
        'objAccess.GetAccess(objGlobal)


        m_blnWBSExcelAddAccess = m_objAccess.Add
        m_blnWBSExcelDeleteAccess = m_objAccess.Delete
        m_blnWBSExcelEditAccess = m_objAccess.Edit
        m_blnWBSExcelViewAccess = m_objAccess.View

        'Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
        Dim intSessionProjectID As Integer = Convert.ToInt32(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"))
        Dim strIsSessionProjectClosed As String = "0"

        If intSessionProjectID > 0 Then
            strIsSessionProjectClosed = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_CheckSessionProjectClosed @SessionProjectID = " & intSessionProjectID, True), "0"))

            If strIsSessionProjectClosed = "1" OrElse strIsSessionProjectClosed.ToLower() = "true" Then
                m_blnWBSExcelAddAccess = False
                m_blnWBSExcelEditAccess = False
                m_blnWBSExcelDeleteAccess = False
            End If
        End If
        'End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects

        If m_blnWBSExcelAddAccess = True Or m_blnWBSExcelEditAccess = True Or m_blnWBSExcelDeleteAccess = True Then
            m_blnWBSExcelViewAccess = True
        End If
    End Sub

End Class





