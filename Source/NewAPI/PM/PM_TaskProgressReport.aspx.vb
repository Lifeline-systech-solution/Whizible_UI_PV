Imports Whiz
Namespace Whizible
    Public Class PM_TaskProgressReport
        Inherits WebPages.Template.WhizTemplate

        Protected m_blnAddAccess As Boolean = False 'user has Add Access ?
        Protected m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
        Protected m_blnEditAccess As Boolean = False 'User has Edit Access ?
        Protected m_blnViewAccess As Boolean = False 'User has View Access ?
        Public m_intProjectID As Long = 0
        Public m_intUserID As Long = 0
        Public m_intReportID As Long = 996 ' Task Progress Report ID
        
        'Hidden field controls
        Protected WithEvents hdnViewAccess As System.Web.UI.WebControls.HiddenField
        Protected WithEvents hdnProjectID As System.Web.UI.WebControls.HiddenField
        Protected WithEvents hdnUserID As System.Web.UI.WebControls.HiddenField
        Protected WithEvents hdnReportID As System.Web.UI.WebControls.HiddenField

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                'Apply security
                MyBase.ApplySecurity(True)

                'Initialize resources for this page
                Try
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

                'Get ReportID from query string if available (should be 996 for Task Progress Report)
                If Request.QueryString("ReportID") IsNot Nothing AndAlso Request.QueryString("ReportID") <> "" Then
                    Try
                        m_intReportID = CType(Request.QueryString("ReportID"), Long)
                    Catch ex As Exception
                        m_intReportID = 996 ' Default to Task Progress Report
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

                'Set hidden fields
                hdnProjectID.Value = m_intProjectID.ToString()
                hdnUserID.Value = m_intUserID.ToString()
                hdnReportID.Value = m_intReportID.ToString()
                hdnViewAccess.Value = m_blnViewAccess.ToString().ToLower()

            Catch ex As Exception
                'Log error if needed
                Throw New Exception("Error in Page_Load: " & ex.Message)
            End Try
        End Sub

    End Class
End Namespace

