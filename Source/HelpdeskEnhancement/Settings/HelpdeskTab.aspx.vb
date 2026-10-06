Public Class HelpdeskTab
    Inherits WebPages.Template.WhizTemplate

    Protected m_lngTagID As Long
    Protected IsHRMOrAdmin As String
    Private m_blnAddAccess, m_blnDeleteAccess, m_blnEditAccess As Boolean
    Protected objAccess As New WebPage.Templates.AccessRights


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        CreateGlobalObject()
    End Sub
    Private Sub CreateGlobalObject()
      '=====================================================================
        ' Procedure Name        : WritePaging
        ' Description           : To plot pagination of the grid
        ' Created Date           : 17th-OCT-2017
        'Author                 : Bharat T.
        '=====================================================================

        'Global object
        Dim objGlobal As WebPages.Template.IGlobal

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject

        m_lngTagID = 914
        objGlobal.TagID = m_lngTagID
        objGlobal.ParentTagID = 1254
        objAccess.GetAccess(objGlobal, True)

        'destroy global and AccessRights objects

        Dim strsql As String
        strsql = "EXEC usp_NG2_chk_IsHRMOrAdmin " & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("LoginType") & "'"
        IsHRMOrAdmin = CommonFunction.Data.GetDataScalar(strsql, True)

        objGlobal = Nothing

    End Sub
End Class