Public Class IB_IssueToCopy
    Inherits WebPages.Template.WhizTemplate
    Protected IsSeparatelyCopyDiscussion As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        GetDiscussionConfiguration()
        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IB_IssueToCopy", "Whizible2Resources")
    End Sub

    ''
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