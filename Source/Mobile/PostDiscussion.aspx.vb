
Partial Class PostDiscussion
    Inherits System.Web.UI.MobileControls.MobilePage


    Private strUserName As String
    Private strUserID As String
    Private strToken As String
    Private strQueryID As String


    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strMode As String
        Dim dsQuery As DataSet

        strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        strUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()
        strUserName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()

        If strMode.ToLower = "logout" Then
            Call LogOut()
        End If


        strToken = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Token"), "").ToString()

        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
        Dim key As New Encryption.Data("crazyFrogJumpsTo")
        Dim encryptedData As New Encryption.Data
        encryptedData.Base64 = strToken

        Dim decrypteddata As Encryption.Data
        decrypteddata = sym.Decrypt(encryptedData, key)
        strQueryID = HttpUtility.UrlDecode(decrypteddata.ToString)

        dsQuery = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_CRM_Query_Master " + strQueryID, "Tbl", UseSQL:=True)

        LnkBack.NavigateUrl = "Mobile_RequestlList.aspx?Mode=HelpDesk"
        LnkBack1.NavigateUrl = "Mobile_RequestlList.aspx?Mode=HelpDesk"
        TxtQueryID.Text = "<b>Request ID: </b>" + strQueryID
        TxtSubject.Text = "<b>Subject: </b>" + CommonFunctions.Data.CheckIsDBNull(dsQuery.Tables(0).Rows(0)("Subject"), "")
        TxtUserName.Text = "<b>User Name: </b>" + strUserName
        TxtDate.Text = "<b>Date: </b>" + CommonFunctions.Dates.CGetDate(Date.Now) + " " + Date.Now.ToLongTimeString()

    End Sub

    Private Sub LogOut()
        'Logout
        Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

    Private Sub CmdSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdSubmit.Click
        Dim strSQL As New StringBuilder 
        Dim dr As IDataReader
        Dim blnShowPopup As Boolean
        Dim blnSendMail As Boolean
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject, strMessage As String

        If Page.IsValid Then
            ' save the discussion
            strSQL.Append("usp_CRM_Insert_DiscussionThread " & strQueryID)
            strSQL.Append(",'" & Now().ToString() & "'")
            strSQL.Append(",N'" & CommonFunctions.General.BuildQueryString(strUserName) & "'")
            strSQL.Append(",'E'")
            strSQL.Append(",N'" & CommonFunctions.General.BuildQueryString(TxtComments.Text) & "'")
            strSQL.Append(",'" & Now().ToString() & "'")
            strSQL.Append(",'" & Date.Now.ToShortTimeString() & "'")

            CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), True)

            strSQL = Nothing
            TxtComments.Text = ""

            ' send mail
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 47", True)
            If dr.Read Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
            End If
            CommonFunctions.Data.DisposeDataReader(dr)

            If blnSendMail Then
                ' silent mail
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_47(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, CType(strQueryID, Long))
                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
            End If
        End If
    End Sub

    Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender

        Dim dsDiscussions As DataSet
        Dim strText As New StringBuilder()

        dsDiscussions = CommonFunctions.Data.GetDataSet("usp_CRM_Discussions " + strQueryID, "TblDiscussion", 0, 3, True)

        For Each drDiscussion As DataRow In dsDiscussions.Tables(0).Rows
            strText.Append("<b>User Name: </b>")
            strText.Append(CommonFunctions.Data.CheckIsDBNull(drDiscussion("SubmittedBy"), "-"))
            strText.Append(" <b>Date: </b>")
            If CommonFunctions.Data.CheckIsDBNull(drDiscussion("SubmittedDate"), "").ToString() = "" Then
                strText.Append("-")
            Else
                strText.Append(CommonFunctions.Dates.CGetDate(drDiscussion("SubmittedDate")) + " " + CType(drDiscussion("SubmittedDate"), Date).ToLongTimeString)
            End If
            strText.Append(" <b>Comment: </b>")
            strText.Append(CommonFunctions.Data.CheckIsDBNull(drDiscussion("DiscussionThread"), "-"))
            strText.Append("</br>")
        Next
        TxtDisussions.Text = strText.ToString()
        strText = Nothing
    End Sub

End Class
