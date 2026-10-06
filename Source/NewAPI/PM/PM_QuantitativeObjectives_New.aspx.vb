Namespace Whizible
    Partial Public Class PM_QuantitativeObjectives_New
        Inherits WebPages.Template.WhizTemplate

        ' Access rights flags
        Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
        Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
        Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
        Protected m_blnViewAccess As Boolean = False 'View access for the logged in user
        Public m_PKToken_FromQuantitativeObjectives As String = ""

        ' Page variables
        Protected m_ProjectId As Long 'ProjectId
        Protected QuantObjProjectID As String
        Protected strProjectId As String
        Protected selProjectId As String
        Private m_strMode As String = ""
        Private m_strProjectName As String = ""

        ' Constants for page modes
        Private Const MODE_LIST As String = "L"
        Private Const MODE_ADD As String = "A"
        Private Const MODE_EDIT As String = "E"
        Private Const MODE_VIEW As String = "V"

        ' Constants for actions
        Private Const ACTION_SAVE As String = "SAVE"
        Private Const ACTION_DELETE As String = "DELETE"
        Private Const ACTION_CANCEL As String = "CANCEL"

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                MyBase.ApplySecurity(True)

                ' Get user ID for logging/tracking
                Dim strUserId As String
                strUserId = Session("intUserID").ToString

                ' Get project ID from session or query string
                m_ProjectId = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
                strProjectId = Trim(Request.QueryString("ProjectID") & "")

                If ((strProjectId Is Nothing Or strProjectId = "")) Then
                    selProjectId = 0
                Else
                    selProjectId = CType(strProjectId, Long)
                End If

                If Not selProjectId = 0 Then
                    m_ProjectId = selProjectId
                End If

                ' Get page mode from query string
                m_strMode = Request.QueryString("Mode")
                If String.IsNullOrEmpty(m_strMode) Then
                    m_strMode = MODE_LIST
                End If

                ' Initialize access rights and global object
                CreateGlobalObject()

                ' Initialize resources
                Try
                    MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_QuantitativeObjectives_New", "Whizible2Resources")
                Catch ex As Exception
                    ' Continue if resource initialization fails
                End Try

            Catch ex As Exception
                ' Log error and redirect to error page
                Response.Redirect("../../General/ErrorPage.aspx?Mode=PageLoad&Error=" + Server.UrlEncode(ex.Message))
            End Try
        End Sub

        Private Sub CreateGlobalObject()
            Try
                ' Global object
                Dim objGlobal As WebPages.Template.IGlobal
                Dim blnPrjExists As Boolean = False

                ' Fill global object
                MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
                objGlobal = MyBase.GlobalObject
                objGlobal.TagID = 689 ' Tag ID for Quantitative Objectives

                Dim objAccess As New WebPages.Template.AccessRights
                objAccess.GetAccess(objGlobal)

                ' Handle project ID from form or session
                If Not MyBase.GetFormValue("cboProject") Is Nothing Then
                    If MyBase.GetFormValue("cboProject") <> "" Then
                        m_ProjectId = CType(MyBase.GetFormValue("cboProject"), Integer)
                    Else
                        m_ProjectId = 0
                    End If
                    QuantObjProjectID = m_ProjectId
                ElseIf Not QuantObjProjectID Is Nothing And (HttpContext.Current.Request.QueryString("StartPage") Is Nothing Or Not HttpContext.Current.Request.QueryString("ApplyFilter") Is Nothing) Then
                    m_ProjectId = CType(QuantObjProjectID, Long)
                Else
                    If CType(Session("intRoleLevel"), Integer) = 3 Then
                        blnPrjExists = True
                        If blnPrjExists = True Then
                            m_ProjectId = objGlobal.ProjectID
                            QuantObjProjectID = m_ProjectId
                        Else
                            m_ProjectId = 0
                        End If
                    Else
                        m_ProjectId = objGlobal.ProjectID
                        QuantObjProjectID = m_ProjectId
                    End If
                End If

                ' Set access rights
                m_blnAddAccess = objAccess.Add 'If user has AddNew Access
                m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
                m_blnEditAccess = objAccess.Edit 'If user has Edit Access
                m_blnViewAccess = objAccess.View 'If user has View Access
                
                ' If user has any access level (Add/Edit/Delete), they should have View access too
                If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
                    m_blnViewAccess = True
                End If

                ' Generate security token
                m_PKToken_FromQuantitativeObjectives = CommonFunctions.Security.Token.GetToken("689" + QuantObjProjectID + CType(Session("intUserID"), String))

                ' Validate security token
                If (((m_PKToken_FromQuantitativeObjectives = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("689" + QuantObjProjectID + CType(Session("intUserID"), String), m_PKToken_FromQuantitativeObjectives) = False)) Then
                    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
                End If

            Catch ex As Exception
                ' Keep page resilient if access initialization fails - default to view-only (no edit/add/delete)
                m_blnAddAccess = False
                m_blnDeleteAccess = False
                m_blnEditAccess = False
                m_blnViewAccess = True
            End Try
        End Sub

        Private Sub InitializePage()
            ' Initialize page based on current mode
            Select Case m_strMode
                Case MODE_LIST
                    InitializeListMode()
                Case MODE_ADD, MODE_EDIT
                    InitializeEditMode()
                Case MODE_VIEW
                    InitializeViewMode()
                Case Else
                    InitializeListMode()
            End Select
        End Sub

        Private Sub InitializeListMode()
            ' Initialize list mode - load existing objectives
            ' This would typically load data from database
            ' For now, just set up the UI
        End Sub

        Private Sub InitializeEditMode()
            ' Initialize edit mode - load data for editing
            ' This would typically load existing data if in edit mode
        End Sub

        Private Sub InitializeViewMode()
            ' Initialize view mode - display read-only data
            ' This would typically load and display data in read-only format
        End Sub

        ' Public properties for access from aspx page
        Public ReadOnly Property CurrentMode() As String
            Get
                Return m_strMode
            End Get
        End Property

        Public ReadOnly Property ProjectId() As Long
            Get
                Return m_ProjectId
            End Get
        End Property

        Public ReadOnly Property ProjectName() As String
            Get
                Return m_strProjectName
            End Get
        End Property

        Public ReadOnly Property CanAdd() As Boolean
            Get
                Return m_blnAddAccess
            End Get
        End Property

        Public ReadOnly Property CanEdit() As Boolean
            Get
                Return m_blnEditAccess
            End Get
        End Property

        Public ReadOnly Property CanDelete() As Boolean
            Get
                Return m_blnDeleteAccess
            End Get
        End Property

        ' Method to save objectives (placeholder for future API integration)
        Public Function SaveObjectives() As Boolean
            Try
                ' This method would be called from the aspx page
                ' Implementation would include API calls to save data
                ' For now, return true as placeholder
                Return True
            Catch ex As Exception
                ' Log error
                Return False
            End Try
        End Function

        ' Method to load objectives (placeholder for future API integration)
        Public Function LoadObjectives() As String
            Try
                ' This method would be called to load existing objectives
                ' Implementation would include API calls to retrieve data
                ' For now, return empty JSON as placeholder
                Return "[]"
            Catch ex As Exception
                ' Log error
                Return "[]"
            End Try
        End Function

        ''' <summary>
        ''' Generate security token for metrics utilization
        ''' </summary>
        <System.Web.Services.WebMethod()>
        Public Shared Function GeneratePK_TokenUtilization(ByVal ProjectID As String, ByVal MetricID As String, ByVal EmployeeID As String) As String
            Try
                Dim QuantObjProjectID As String
                QuantObjProjectID = ProjectID

                Dim m_PKToken_FromQuantitativeObjectives As String
                m_PKToken_FromQuantitativeObjectives = CommonFunctions.Security.Token.GetToken("689" + QuantObjProjectID + MetricID + EmployeeID + CType(HttpContext.Current.Session("intUserID"), String))

                Return m_PKToken_FromQuantitativeObjectives
            Catch ex As Exception
                Return "Bad Request Found"
            End Try
        End Function

        ''' <summary>
        ''' Validate security token for metrics utilization
        ''' </summary>
        <System.Web.Services.WebMethod()>
        Public Shared Function ValidatePK_TokenUtilization(ByVal ProjectID As String, ByVal MetricID As String, ByVal EmployeeID As String, ByVal PKToken As String) As Boolean
            Try
                If (((PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("689" + ProjectID + MetricID + EmployeeID + CType(HttpContext.Current.Session("intUserID"), String), PKToken) = False)) Then
                    Return False
                Else
                    Return True
                End If
            Catch ex As Exception
                Return False
            End Try
        End Function

        ''' <summary>
        ''' Generate security token for project
        ''' </summary>
        <System.Web.Services.WebMethod()>
        Public Shared Function GeneratePK_Token(ByVal ProjectID As String) As String
            Try
                Dim QuantObjProjectID As String
                QuantObjProjectID = ProjectID

                Dim m_PKToken_FromQuantitativeObjectives As String
                m_PKToken_FromQuantitativeObjectives = CommonFunctions.Security.Token.GetToken("689" + QuantObjProjectID + CType(HttpContext.Current.Session("intUserID"), String))

                Return m_PKToken_FromQuantitativeObjectives
            Catch ex As Exception
                Return "Bad Request Found"
            End Try
        End Function

        ''' <summary>
        ''' Validate security token for project
        ''' </summary>
        <System.Web.Services.WebMethod()>
        Public Shared Function ValidatePK_Token(ByVal ProjectID As String, ByVal PKToken As String) As Boolean
            Try
                If (((PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("689" + ProjectID + CType(HttpContext.Current.Session("intUserID"), String), PKToken) = False)) Then
                    Return False
                Else
                    Return True
                End If
            Catch ex As Exception
                Return False
            End Try
        End Function

    End Class
End Namespace