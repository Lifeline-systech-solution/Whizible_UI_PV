#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class DB_TaskManagementLinks
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Page Name 	        :	
    ' Purpose				:	
    ' Description			:	
    ' Assumptions			:	
    ' Dependencies			:	
    ' Author				:	
    ' Created				:	
    ' Revisions				:	
    '=====================================================================

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Member Variables"
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu as string                           'stores the static menu string.
#End Region

#Region "Functions & Procedures"

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing
    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        GetGlobalObject()
        Dim drGetAccess As IDataReader
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<Table class=clsTable cellspacing=0 cellpadding=0 width='99.9%'><TR class='clsTRPageCaption'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<TD Align='Left' valign= 'top'>Tasks</TD>")
        CommonFunctions.General.WriteHTML("<TD Align='Right' valign= 'top'>")

        CommonFunctions.General.WriteHTML("<b>|<a class='Menu' href='javascript:Tab_OnClick(1)'>Weekly TimeSheet</a><b>")

        drGetAccess = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_UI_NodeAccess 2172," & CType(Session("intPostID"), String), MyBase.UseSQL)
        If drGetAccess.Read Then
            If CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("A"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("D"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("E"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("V"), "0"), Boolean) = True Then
                CommonFunctions.General.WriteHTML("<b>|<a class='Menu' href='javascript:Tab_OnClick(2)'>Task Completion</a><b>")
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drGetAccess)

        drGetAccess = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_UI_NodeAccess 3026," & CType(Session("intPostID"), String), MyBase.UseSQL)
        If drGetAccess.Read Then
            If CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("A"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("D"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("E"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("V"), "0"), Boolean) = True Then
                CommonFunctions.General.WriteHTML("<b>|<a class='Menu' href='javascript:Tab_OnClick(3)'>Task Status Management</a><b>")
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drGetAccess)

        CommonFunctions.General.WriteHTML("<b>|<b></TD></TR></Table>")

        DisposeObjects()
    End Sub

#End Region

# Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        'MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
# End Region

# Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
# End Region

End Class
