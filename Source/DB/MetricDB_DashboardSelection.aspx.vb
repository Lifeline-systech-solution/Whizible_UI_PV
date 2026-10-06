'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhiziblePPM
' Module Name           :  MetricDB_DashboardSelection.aspx
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

Public Class MetricDB_DashboardSelection
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
        Dim strSQL As String
        Call GetGlobalObject()

        '--1. Write the Combo for e-Dashboard selections
        CommonFunctions.General.WriteHTML("<TABLE Class=clsTable Width=99.9%>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption>")
        CommonFunctions.General.WriteHTML("<TD>")

        '-- Initialize the Resource File
        MyBase.InitializeResources("AppResources.DeveloperDB", "AppResources")
        Response.Write("<b>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("PAGE_CAPTION"))

        '-- Combo box to select the Type of e-Dashboard
        If Trim(Session("intPostID").ToString) <> "" Then
            strSQL = "usp_CDB_GetUserDashboardsForCombo  " + Session("intUserID").ToString + "," + Session("intPostID").ToString
        Else
            strSQL = "usp_CDB_GetUserDashboardsForCombo  " + Session("intUserID").ToString
        End If

        CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", strSQL, , "../DB/PMDashboard.aspx", "OnChange='JavaScript:cboDashboard_OnChange()'")
        
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")

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
        '  MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

End Class
