Imports CommonEngines.General.cEventHandlers
Public Class cDB_SelectProject_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cDB_SelectProject_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cDB_SelectProject_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cDB_SelectProject_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        Dim strSQLQuery As String
        If Args.ControlName = "ProjectID" Then
            'Modified By VidyaJ - SP4 - IssueID - 362
            Dim intRoleLevel As Integer
            Dim m_strProjectFilters As String
            intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intRoleLevel"), "0"), Integer)
            m_strProjectFilters = ""
            'If middle level then apply filter for Projects
            If intRoleLevel = 2 Then
                'Apply Role Access Filter for Project List
                m_strProjectFilters = ""
                Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
                If strFilter <> "" Then
                    m_strProjectFilters += strFilter
                End If

                Dim strRemove As String = "ProjectID IN"
                m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)

                m_strProjectFilters = m_strProjectFilters.Replace("'", "")
            End If

            'modified by harshada d on 9 th Aug 2006 for showing the projects which has access for tasks creation
            'strSQLQuery = "EXEC usp_Sel_AccessibleProjects_ForEmployee " + CType(HttpContext.Current.Session("intUserID"), String) & ",0,0,0,0,'" & CType(HttpContext.Current.Session("LoginType"), String) & "',0," & CType(HttpContext.Current.Session("intLoginID"), Long) & ",1,1"
            'usp_Sel_AccessibleProjects_ForEmployee_CreateTask
            'Modified By ShraddhaM on 11 Sep 2006 for issue ID 6185 AND 6179

            strSQLQuery = "EXEC usp_Sel_AccessibleProjects_ForEmployee_CreateTask " + CType(HttpContext.Current.Session("intUserID"), String) & ",0,0,0,0,'" & CType(HttpContext.Current.Session("LoginType"), String) & "',0," & CType(HttpContext.Current.Session("intLoginID"), Long) & ",3,1"
            'end of modification by harshada d
            'End Addition
            Args.IgnoreActualValue = True
            If CType(HttpContext.Current.Session("intProjectID"), String) <> "" Then
                Args.DefaultValue = CType(HttpContext.Current.Session("intProjectID"), String)
            End If
            Args.DropDownEditSQL = strSQLQuery

        End If
    End Sub
End Class


Public Class DB_SelectProject_CommonPage
    Inherits CommonPage
    Public intSessionProjectID As Integer
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "CommonList.aspx"
        MyBase.strFormPage = "DB_SelectProject_CommonPage.aspx"
        intSessionProjectID = CType(Session("intProjectID"), Integer)
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName = "Next" Then

            '//Modified By ShraddhaM on 2/08/2006 for Whiziblesem 6.0 SP 7.2
            Args.ToBeInsertedInFunction = " var objProject = GetObjectReference('frmCommonPage','ProjectID');"
            'Args.ToBeInsertedInFunction += "var objProject1 = GetObjectReference('frmCommonPage','objProject.selectedIndex');"
            'added by harshada d for whiziblesem SP7.2 for project cannot be blank validation on 10 Aug 2006
            Args.ToBeInsertedInFunction += " if(disallowBlank(objProject,'Project cannot be blank ',true)) return; "
            'end of addition by harshada d for whiziblesem SP7.2 
            Args.ToBeInsertedInFunction += " if (" + CType(intSessionProjectID, String) + "!= objProject.value && objProject.value != """" ) "
            Args.ToBeInsertedInFunction += "{"

            'Args.ToBeInsertedInFunction += " var name = confirm('This will select the Project -'+ objProject.children[objProject.selectedIndex].innerHTML);"
            Args.ToBeInsertedInFunction += " var name = confirm('The selected Project will be set as session project.Do you want to continue?');"

            Args.ToBeInsertedInFunction += "if (name==true)"
            Args.ToBeInsertedInFunction += "{"

            'Args.ToBeInsertedInFunction += " opener.parent.parent.parent.frames[0].location.href=""../General/Navigation.aspx?subPage=../DB/DB_SelectProject_CommonPage.aspx&FromWhere=DB&MasterTagID=3620&ProjectID_PK=""+objProject.value;"
            Args.ToBeInsertedInFunction += " opener.parent.parent.parent.parent.frames[0].location.href=""../General/Navigation.aspx?subPage=../DB/DB_SelectProject_CommonPage.aspx&FromWhere=DB&MasterTagID=3620&ProjectID_PK=""+objProject.value;"
            'Modified By JyotiG
            'Date : 18-Aug-2006
            'Purpose : Open Page in Add Mode
            'Start
            'Args.ToBeInsertedInFunction += " opener.parent.frames[1].location.href = ""../PM/PM_AssignedTaskList.aspx?FromWhere=PM&MasterTagId=1038"";"
            Args.ToBeInsertedInFunction += " opener.parent.parent.frames[1].location.href = ""../PM/PM_TaskAssignment.aspx?Mode=New&MasterTagID=1038&PageNumber=-1undefined"";"
            'End
            Args.ToBeInsertedInFunction += " window.close();"
            Args.ToBeInsertedInFunction += "}"
            Args.ToBeInsertedInFunction += "else"
            Args.ToBeInsertedInFunction += "{"
            Args.ToBeInsertedInFunction += " return ;"
            Args.ToBeInsertedInFunction += "}"
            Args.ToBeInsertedInFunction += "}"
            Args.ToBeInsertedInFunction += "else"
            Args.ToBeInsertedInFunction += "{"
            'Modified By JyotiG
            'Date : 18-Aug-2006
            'Purpose : Open Page in Add Mode
            'Start
            'Args.ToBeInsertedInFunction += " opener.parent.frames[1].location.href = ""../PM/PM_AssignedTaskList.aspx?FromWhere=PM&MasterTagId=1038"";"
            Args.ToBeInsertedInFunction += " opener.parent.parent.frames[1].location.href = ""../PM/PM_TaskAssignment.aspx?Mode=New&MasterTagID=1038&PageNumber=-1undefined"";"
            'End
            Args.ToBeInsertedInFunction += " window.close();"
            Args.ToBeInsertedInFunction += "}"
            Args.ToBeInsertedInFunction += " return;"
        End If
    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cDB_SelectProject_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cDB_SelectProject_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cDB_SelectProject_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cDB_SelectProject_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    'Protected Overloads Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cDB_SelectProject_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    'End Function
End Class
