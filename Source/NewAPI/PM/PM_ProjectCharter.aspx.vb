Public Class PM_ProjectCharter
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

    Protected m_blnAddAccess As Boolean = False
    Protected m_blnEditAccess As Boolean = False
    Protected m_blnDeleteAccess As Boolean = False
    Protected m_blnViewAccess As Boolean = False

    Protected m_UserId As Long
    Protected m_UserName As String
    Protected m_LoginType As String
    Protected m_RoleId As Long
    Protected m_RoleLevel As Integer
    Protected m_ProjectId As Long
    Protected m_CultureId As Long
    Public m_TagId As Long
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            ' Apply authentication & authorization
            MyBase.ApplySecurity(True)

            ' Get logged in user
            Dim strUserId As String
            strUserId = Session("intUserID").ToString

            ' Initialize global object & access
            CreateGlobalObject()

            ' Initialize resource file
            Try
                MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectCharter", "Whizible2Resources")
            Catch ex As Exception
                ' Ignore resource failure
            End Try

        Catch ex As Exception
            Response.Redirect("../../General/ErrorPage.aspx?Mode=PageLoad&Error=" & Server.UrlEncode(ex.Message))
        End Try
    End Sub


    Public Sub CreateGlobalObject()
        Try
            Dim objGlobal As WebPages.Template.IGlobal

            ' Fill global object
            MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID,
                CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
            objGlobal = MyBase.GlobalObject

            ' ================= Tag ID for Project Charter =================
            objGlobal.TagID = 36   ' <-- Project Charter Tag ID

            Dim objAccess As New WebPages.Template.AccessRights
            objAccess.GetAccess(objGlobal)

            ' Project ID
            m_ProjectId = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")

            ' User info
            m_UserId = objGlobal.UserID
            m_UserName = objGlobal.UserName
            m_LoginType = objGlobal.LoginType
            m_RoleId = objGlobal.RoleID
            m_RoleLevel = objGlobal.RoleLevel
            m_CultureId = objGlobal.LCID
            m_TagId = objGlobal.TagID

            ' Page access rights
            m_blnAddAccess = objAccess.Add
            m_blnEditAccess = objAccess.Edit
            m_blnDeleteAccess = objAccess.Delete
            m_blnViewAccess = objAccess.View

            ' If Add/Edit/Delete → View must be true
            If m_blnAddAccess OrElse m_blnEditAccess OrElse m_blnDeleteAccess Then
                m_blnViewAccess = True
            End If

        Catch ex As Exception
            ' Safe fallback – View only
            m_blnAddAccess = False
            m_blnEditAccess = False
            m_blnDeleteAccess = False
            m_blnViewAccess = True
        End Try
    End Sub
End Class