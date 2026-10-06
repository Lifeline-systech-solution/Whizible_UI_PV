Public Class Issue_Aging
    Inherits WebPages.Template.WhizTemplate

    Protected m_PKToken_FromPSDList As String = ""
    Protected m_PKToken_ToPSDList As String = ""

    Public m_AddAccess As Boolean = False
    Public m_DeleteAccess As Boolean = False
    Public m_EditAccess As Boolean = False
    Public m_ViewAccess As Boolean = False
    Public SLAEnabled As Boolean = False


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IssueAging", "Whizible2Resources")
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        CreateGlobalObject()
        m_PKToken_FromPSDList = CommonFunctions.Security.Token.GetToken("36010" + CType(Session("intUserID"), String))
        If (((m_PKToken_FromPSDList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("36010" + CType(Session("intUserID"), String), m_PKToken_FromPSDList) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If

        'Added by imran on 26-09-2022
        Dim strSqlFile As String = "usp_Whizible2_Sel_SLAENabledSetting "
        Dim drGetUserStoryFileDetail As IDataReader
        drGetUserStoryFileDetail = CommonFunctions.Data.GetDataReader(strSqlFile, True)
        If drGetUserStoryFileDetail.Read Then
            SLAEnabled = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryFileDetail("SLA").ToString, 0)
        End If
        'End of comment by imran on 26-09-2022
    End Sub

    Public Sub CreateGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 36010
        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)
        m_AddAccess = objAccess.Add 'If user has AddNew Access
        m_DeleteAccess = objAccess.Delete 'If User has Delete Access
        m_EditAccess = objAccess.Edit 'If user has Edit Access
        m_ViewAccess = objAccess.View 'If user has Edit Access
        If (m_AddAccess = True Or m_EditAccess = True Or m_DeleteAccess = True) Then
            m_ViewAccess = True
        End If
    End Sub

End Class