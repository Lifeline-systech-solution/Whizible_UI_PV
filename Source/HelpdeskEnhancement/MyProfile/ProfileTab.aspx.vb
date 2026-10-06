Public Class ProfileTab
    Inherits WebPages.Template.WhizTemplate

    Protected m_lngTagID As Long
    Private m_blnAddAccess, m_blnDeleteAccess, m_blnEditAccess As Boolean
    Protected objAccess As New WebPage.Templates.AccessRights
    Protected m_intRoleID As Integer = 0
    Protected strLoginType = ""


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        CreateGlobalObject()
    End Sub
    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Procedure Name        : WritePaging
        ' Description           : To plot pagination of the grid
        ' Created Date           : 13-Dec-2017
        'Author                 : Aniruddh GUjar
        '=====================================================================

        'Global object
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, "1085", m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)


        'MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objAccess.GetAccess(objGlobal)

        'destroy global and AccessRights objects
      
        'm_objGlobalAlert = objGlobalAlert

    End Sub
End Class