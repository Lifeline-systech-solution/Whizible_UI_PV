Public Class PM_ResourceSiteDetails
    Inherits WebPages.Template.WhizTemplate
    Protected m_PKToken_FromPSDList As String = ""
    Protected m_PKToken_ToPSDList As String = ""

    Public UserID As String
    Public ProjectID As String = False 'For Session Project ID
    Protected m_blnRSDAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnRSDEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnRSDDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnRSDViewAccess As Boolean = False 'View access for the logged in user

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ResourceSiteDetails", "Whizible2Resources")
        CreateRSDGlobalObject()
    End Sub

    Private Sub CreateRSDGlobalObject()
        'Global object

        Dim blnPrjExists As Boolean = False

        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 2252

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnRSDAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnRSDDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnRSDEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnRSDViewAccess = objAccess.View 'If user has View Access

        If (m_blnRSDAddAccess = True And m_blnRSDEditAccess = True) Then
            If (m_blnRSDViewAccess = False) Then
                m_blnRSDViewAccess = True
            Else
                m_blnRSDViewAccess = True
            End If

        Else
            If (m_blnRSDViewAccess = False) Then
                m_blnRSDViewAccess = False
            Else
                m_blnRSDViewAccess = True
            End If
        End If

        ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        m_PKToken_FromPSDList = CommonFunctions.Security.Token.GetToken("2252" + ProjectID + CType(Session("intUserID"), String))



        If (((m_PKToken_FromPSDList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("2252" + ProjectID + CType(Session("intUserID"), String), m_PKToken_FromPSDList) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If


    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GeneratePK_Token(ByVal ProjectID As String) As String
        Try
            Dim ResourceProjectID As String
            ResourceProjectID = ProjectID

        Dim m_PKToken_FromResourcesList As String
        m_PKToken_FromResourcesList = CommonFunctions.Security.Token.GetToken("2252" + ResourceProjectID + CType(HttpContext.Current.Session("intUserID"), String))

        Return m_PKToken_FromResourcesList
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ValidatePK_Token(ByVal ProjectID As String, ByVal PKToken As String) As Boolean
        Try
            If (((PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("2252" + ProjectID + CType(HttpContext.Current.Session("intUserID"), String), PKToken) = False)) Then

                'System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836", False)

                Return False
            Else

                Return True

            End If

        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function


End Class