Public Class MultipleLogin
    Inherits WebPages.Template.WhizTemplate


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
       
            ' ***********************************************************************************
            ' Added  Dec 1 2015 Swapnil A For Securtiy[Prevent multiple login]
        ' ***********************************************************************************
        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: Multiple Login validate
        ''Dim Value2 As ArrayList = CommonEngines.HashTables.GetHashTableObject.GetUserSessionCacheItemValue(Session("intLoginID"))
        Dim Value2 As ArrayList = CommonEngines.HashTables.GetHashTableObject.GetUserSessionCacheItemValue(Session("intLoginID"))
        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            If Value2 IsNot Nothing Then
            For i As Integer = 0 To Value2.Count - 1
                ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: Multiple Login validate
                'If Value2.Item(i) <> Session.SessionID Then
                If Value2.Item(i) <> Session("SessionID") Then
                    ''End of Comment and Addition by Dhanashri S on 3 Aug 2016
                    CommonEngines.HashTables.GetHashTableObject.RemoveUserSessionCacheItem(Session("intLoginID"))
                    Session("intUserID") = Nothing
                    Session.Abandon()
                    Response.Redirect("../../Default.aspx?Message=SESSIONEXPIRED")
                End If
            Next
            End If
            ' ***********************************************************************************
            ' Ended  Dec 1 2015 Swapnil A For Securtiy[Prevent multiple login]
            ' ***********************************************************************************



    End Sub
    Protected Sub CheckValidAccess()
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
    End Sub
End Class