'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleE
' Module Name           :  DB_MyTaskLinks.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class DB_MyTaskLinks
    Inherits WebPages.Template.WhizTemplate

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
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
#End Region

#Region "Functions and Sub-Procedures"

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   PrakashR
        ' Created               :   
        ' Revisions             :   
        '=====================================================================

        Call GetGlobalObject()
        'added by harshada d for WhizibleSEM SP7.2 for Access rights of the links on 8 Aug 2006

        Dim strQuery As String
        Dim drIsTagAccessible As IDataReader
        Dim intIsTagAccessible As Integer = 0

        Response.Write("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'><TR class='clsTRPageCaption'>")
        Response.Write("<TD align=left>Tasks</TD>")
        Response.Write("<TD align=Right>")
        'added by harshada d for WhizibleSEM SP7.2 for Access rights of the links on 8 Aug 2006
        strQuery = "usp_DB_IsTagAccessible 2172," + CType(Session("intUserID"), String)

        drIsTagAccessible = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drIsTagAccessible) <> "" Then
            If drIsTagAccessible.Read() Then
                intIsTagAccessible = CType(CommonFunctions.Data.CheckIsDBNull(drIsTagAccessible("IsAccessible"), "0"), Integer)
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drIsTagAccessible)
        'If intIsTagAccessible = 1 Then
        '    'end of addition by harshada d 
        '    Response.Write("|<b><a class='Menu' Title='Task Completion' href='javascript:Tab_OnClick(1)'>Task Completion</a></b>|")
        '    intIsTagAccessible = 0
        '    'added by harshada d for WhizibleSEM SP7.2 for Access rights of the links on 8 Aug 2006
        'End If

        strQuery = "usp_DB_IsTagAccessible 1038," + CType(Session("intUserID"), String)
        drIsTagAccessible = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If CommonFunctions.General.CheckIsNothing(drIsTagAccessible) <> "" Then
            If drIsTagAccessible.Read() Then
                intIsTagAccessible = CType(CommonFunctions.Data.CheckIsDBNull(drIsTagAccessible("IsAccessible"), "0"), Integer)
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drIsTagAccessible)
        If intIsTagAccessible = 1 Then
            'end of addition by harshada d 
            Response.Write("<b><a class='Menu' Title='Create Task' href='javascript:Tab_OnClick(2)'>|Create Task</a></b>|")
            intIsTagAccessible = 0
        End If
        'added by harshada d for WhizibleSEM SP7.2 for Access rights of the links on 8 Aug 2006
        strQuery = "usp_DB_IsTagAccessible 3026," + CType(Session("intUserID"), String)
        drIsTagAccessible = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drIsTagAccessible) <> "" Then
            If drIsTagAccessible.Read() Then
                intIsTagAccessible = CType(CommonFunctions.Data.CheckIsDBNull(drIsTagAccessible("IsAccessible"), "0"), Integer)
            End If
        End If

        If intIsTagAccessible = 1 Then
            'end of addition by harshada d 
            Response.Write("<b><a class='Menu' Title='Task Status Management' href='javascript:Tab_OnClick(3)'>Task Status Management</a><b>|")
            intIsTagAccessible = 0
        End If

        Response.Write("</TD>")
        Response.Write("</TR></TABLE>" & vbCrLf)
        CommonFunctions.Data.DisposeDataReader(drIsTagAccessible)

    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub


#End Region

    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

End Class
