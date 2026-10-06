'==================================================================================
'                       CSPL Code Header                              
' Project Name          :  PbNITE
' Module Name           :  PM_WORevisionFields.aspx
' Purpose               :  This page is to allow access to various revision fields
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  May 03, 2004
' Revisions             :  
'==================================================================================
#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class PM_WORevisionFields
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

    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Private WithEvents m_objStaticMenu As New StaticMenu

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
        ' Created               :   May 03, 2004
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()
        Call DrawMenu()
        WriteHTML("<DIV id=""PageDiv"" style=""OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100%"">")
        WriteHTML("<BR>")
        WriteHTML(PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("WO_REVISION_FIELDS"), , , True))
        WriteHTML("<BR>")

        Dim strMode As String = Request.QueryString("MODE")
        If Not (strMode Is Nothing) AndAlso strMode = "UPDATE" Then
            Dim SelectedFields As String
            Dim strSQL As String
            Dim index As Integer
            SelectedFields = Request.Form("lstSelectedFields")
            strSQL = "Exec usp_Upd_tbl_PM_RevisionFields '" & SelectedFields & "', 32"
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            strSQL = ""
        End If

        Call DrawListBoxes()
        WriteHTML("<BR>")
        WriteHTML("</DIV>")
        Call DrawMenu()
    End Sub

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()        
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.PM_WORevisionFields", "AppResources")
    End Sub

#Region "Functions and Sub-Procedures"
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
        ' Created               :  May 03, 2004
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        :  DrawMenu
        ' Parameters Passed     :  None 
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  Initialization of the menu
        ' Description           :  This function renders the menu
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  May 03, 2004
        ' Revisions             : 
        '=====================================================================
        Dim strMenu As String
        Dim arrMenu() As String = {MyBase.GetResourceString("SAVE"), MyBase.GetResourceString("HELP")}
        Dim arrMenuTooltip() As String = {MyBase.GetResourceString("SAVE_TOOLTIP"), MyBase.GetResourceString("HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Help_OnClick()"}
        m_objStaticMenu = New StaticMenu
        strMenu = m_objStaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuTooltip, True)

        WriteHTML(strMenu)
    End Sub

    Private Sub DrawListBoxes()
        '====================================================================
        ' Procedure Name        :  DrawListBoxes
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To render the two list boxes containing the Attributes.
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  May 03, 2004
        ' Revisions             :  May 20, 2004: Replaced the queries for AllFieldsSQL and SelectedFieldsSQL 
        '                                   with an SP usp_Sel_tbl_PM_RevisionFields_Master_RevisionFields.
        '=====================================================================
        Dim strAllFieldsSQL, strSelectedFieldsSQL As String

        strAllFieldsSQL = "EXEC usp_Sel_tbl_PM_RevisionFields_Master_RevisionFields 0"

        strSelectedFieldsSQL = "EXEC usp_Sel_tbl_PM_RevisionFields_Master_RevisionFields 1"

        WriteHTML("<TABLE class=clstable cellspacing=0 cellpadding=0 width=99.9%>")
        WriteHTML("<TR class=clsTREven>")

        'List of all Fields
        WriteHTML("<TD align=center >")
        WriteHTML(MyBase.GetResourceString("LIST_OF_FIELDS"))
        WriteHTML("</TD>")

        WriteHTML("<TD align=center >")
        WriteHTML("</TD>")

        'Selected Fields
        WriteHTML("<TD align=center >")
        WriteHTML(MyBase.GetResourceString("SELECTED_FIELDS"))
        WriteHTML("</TD>")

        WriteHTML("</TR>")
        WriteHTML("</TABLE>")

        'Display list boxes
        Response.Write("<TABLE class=clstable cellspacing=0 cellpadding=0 width=99.9%>")
        Response.Write("<TR class=clsTREven>")

        'All Fields
        Response.Write("<TD align=center valign=center>")
        CommonFunction.HTMLControls.DrawListBox("lstAllFields", strAllFieldsSQL, 250, 385, , "ondblclick=javascript:GrantAccess_OnClick()")
        Response.Write("</TD>")

        'Links
        Response.Write("<TD align=center valign=center>")
        Response.Write("<a HREF='javascript:AddAll_OnClick()'><img id='lnkGrantAll' border=0 src='../../images/allright.gif' LANGUAGE='javascript' WIDTH=18 HEIGHT=14></a>")
        Response.Write("<BR><BR><BR>")
        Response.Write("<a HREF='javascript:GrantAccess_OnClick()'><img id='lnkGrantAccess' border=0 src='../../images/right.gif' LANGUAGE='javascript' WIDTH=18 HEIGHT=14></a>")
        Response.Write("<BR><BR><BR>")
        Response.Write("<a HREF='javascript:RevokeAccess_OnClick()'><img id='lnkRevokeAccess' border=0 src='../../images/left.gif' LANGUAGE='javascript' WIDTH=18 HEIGHT=14></a>")
        Response.Write("<BR><BR><BR>")
        Response.Write("<a HREF='javascript:RemoveAll_OnClick()'><img id='lnkRevokeAll' border=0 src='../../images/allleft.gif' LANGUAGE='javascript' WIDTH=18 HEIGHT=14></a>")
        Response.Write("</TD>")

        'Accessible Fields
        Response.Write("<TD align=center valign=center>")
        CommonFunction.HTMLControls.DrawListBox("lstSelectedFields", strSelectedFieldsSQL, 250, 385, , "ondblclick=javascript:RevokeAccess_OnClick()")
        Response.Write("</TD>")

        Response.Write("</TR>")
        Response.Write("</TABLE>")

    End Sub
#End Region
End Class
