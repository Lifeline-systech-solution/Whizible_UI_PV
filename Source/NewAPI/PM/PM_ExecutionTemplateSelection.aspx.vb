Public Class PM_ExecutionTemplateSelection
    Inherits WebPages.Template.WhizTemplate
    Protected m_PKToken_FromETSList As String = ""
    Protected m_PKToken_ToETSList As String = ""

    Public UserID As String
    Public ProjectID As String = False 'For Session Project ID
    Protected m_blnETSAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnETSEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnETSDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnETSViewAccess As Boolean = False 'View access for the logged in user
    Protected m_PKToken_ExecutionTemplateSelection As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ExecutionTemplateSelection", "Whizible2Resources")
        CreateETSGlobalObject()
        m_PKToken_ExecutionTemplateSelection = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ExecutionTemplateSelection) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub

    Private Sub CreateETSGlobalObject()
        'Global object

        Dim blnPrjExists As Boolean = False

        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 2175

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnETSAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnETSDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnETSEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnETSViewAccess = objAccess.View 'If user has View Access


        If (m_blnETSAddAccess = True And m_blnETSEditAccess = True) Then
            If (m_blnETSViewAccess = False) Then
                m_blnETSViewAccess = True
            Else
                m_blnETSViewAccess = True
            End If

        Else
            If (m_blnETSViewAccess = False) Then
                m_blnETSViewAccess = False
            Else
                m_blnETSViewAccess = True
            End If
        End If

        'ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        'm_PKToken_FromETSList = CommonFunctions.Security.Token.GetToken("2175" + ProjectID + CType(Session("intUserID"), String))



        'If (((m_PKToken_FromETSList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("2175" + ProjectID + CType(Session("intUserID"), String), m_PKToken_FromETSList) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
        If (m_blnETSAddAccess = True Or m_blnETSEditAccess = True Or m_blnETSDeleteAccess = True) Then
            m_blnETSViewAccess = True
        End If

    End Sub
End Class