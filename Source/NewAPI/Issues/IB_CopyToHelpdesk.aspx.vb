Public Class IB_CopyToHelpdesk
    Inherits WebPages.Template.WhizTemplate
    Protected IsSeparatelyCopyDiscussion As String
    Public m_blnAddAccess As Boolean = False 'user has Add Access ?
    Public m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Public m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        GetDiscussionConfiguration()
        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IB_IssueToCopy", "Whizible2Resources")
        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights

        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 5, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        m_blnAddAccess = m_objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = m_objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = m_objAccess.Edit 'If user has Edit Access
    End Sub


    Private Sub GetDiscussionConfiguration()
        Dim drGetConf As IDataReader
        Dim strHTML As New StringBuilder
        Dim StrQuery As String = ""
        StrQuery = "usp_Whizible2_tbl_PM_CompanyInformation_Discussion "
        drGetConf = CommonFunctions.Data.GetDataReader(StrQuery, True)
        While drGetConf.Read
            IsSeparatelyCopyDiscussion = CommonFunctions.Data.CheckIsDBNull(drGetConf("IsSeparatelyCopyDiscussion").ToString, "")

        End While

    End Sub


End Class