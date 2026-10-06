'Public Class FA_TimesheetListing1
'    Inherits System.Web.UI.Page

'    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

'    End Sub

'End Class

'Added by Vaibhav K on 26-12-25 for W26 Project Timesheet Approval page on  05-03-26

Public Class FA_TimesheetListing_new
    Inherits WebPages.Template.WhizTemplate
    Protected m_blnAddAccess As Boolean = False
    Protected m_blnDeleteAccess As Boolean = False
    Protected m_blnEditAccess As Boolean = False
    Public m_blnViewAccess As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        CreateGlobalObject()

        'MyBase.InitializeResources("Whizible2Resources.Source.Resource.MyLeave", "Whizible2Resources")
        'MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectTimesheetList", "Whizible2Resources")
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectTimeSheetApproval", "Whizible2Resources")





    End Sub

    Public Sub CreateGlobalObject()
        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights

        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 42, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        m_blnAddAccess = m_objAccess.Add
        m_blnDeleteAccess = m_objAccess.Delete
        m_blnEditAccess = m_objAccess.Edit
        m_blnViewAccess = m_objAccess.View

        If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
            m_blnViewAccess = True
        End If
    End Sub


    ''Added for redirecting to new page 
    <System.Web.Services.WebMethod()>
    Public Shared Function GeneratePK_Token(ByVal ProjectID As String, ByVal EmployeeID As String) As String
        Dim m_PKToken_FromTimesheetList As String
        m_PKToken_FromTimesheetList = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Session("intProjectID").ToString, "0"), String) + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "1049")
        Return m_PKToken_FromTimesheetList
    End Function


End Class

'End of Added by Vaibhav K on 26-12-25 for W26 Project Timesheet Approvalk page  on  05-03-26
