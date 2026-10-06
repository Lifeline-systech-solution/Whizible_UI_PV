Imports Whiz
Public Class PM_ReportUIBuilder
    Inherits WebPages.Template.WhizTemplate

    Public m_blnAddAccess As Boolean = False 'user has Add Access ?
    Public m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Public m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public m_blnViewAccess As Boolean = False 'User has View Access ?
    Public m_intProjectID As Long = 0
    Public m_intUserID As Long = 0
    Public m_intReportID As Long = 0
    
    'Hidden field controls
    Protected WithEvents hdnViewAccess As System.Web.UI.WebControls.HiddenField

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            'Apply security
            MyBase.ApplySecurity(True)

            'Initialize resources for this page
            'Note: Resources are used in ASPX file via MyBase.GetResourceString()
            'This ensures proper resource file initialization
            Try
                'Initialize resources if available; keep page resilient if not present
                'Adjust the resource namespace/assembly name based on your actual resource file structure
                'Following the pattern from PM_ProjectSites.aspx.vb
                MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ReportUIBuilder", "Whizible2Resources")
            Catch
                'Resources may be initialized elsewhere or base class handles it
            End Try

            'Initialize session variables
            If Session("intProjectID") IsNot Nothing Then
                m_intProjectID = CType(Session("intProjectID"), Long)
            End If

            If Session("intUserID") IsNot Nothing Then
                m_intUserID = CType(Session("intUserID"), Long)
            End If

            'Get ReportID from query string if available
            If Request.QueryString("ReportID") IsNot Nothing AndAlso Request.QueryString("ReportID") <> "" Then
                Try
                    m_intReportID = CType(Request.QueryString("ReportID"), Long)
                Catch ex As Exception
                    m_intReportID = 0
                End Try
            End If

            'Fill Global Object for access rights
            Dim objGlobal As WebPages.Template.IGlobal
            MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
            objGlobal = MyBase.GlobalObject
            'Set appropriate TagID for report access - 80020
            objGlobal.TagID = 80020

            'Get access rights
            Dim objAccess As New WebPage.Templates.AccessRights
            objAccess.GetAccess(objGlobal)

            m_blnAddAccess = objAccess.Add 'If user has AddNew Access
            m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
            m_blnEditAccess = objAccess.Edit 'If user has Edit Access
            m_blnViewAccess = objAccess.View 'If user has View Access

            'Set access for view if any other access exists
            If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
                m_blnViewAccess = True
            End If

        Catch ex As Exception
            'Log error if needed
            'Note: Error message could be externalized to resource file if needed
            'For now, using direct string as it's primarily for logging/debugging
            Throw New Exception("Error in Page_Load: " & ex.Message)
        End Try
    End Sub

End Class

