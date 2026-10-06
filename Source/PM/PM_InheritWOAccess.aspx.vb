
'=====================================================================
' Module Name       :       PM_InheritWOAccess
' Purpose           :       The UI for Inheiring Role Access for WO
' Description       :       Same as above
' Dependencies      : None
' Author            : DipaliS
' Created : May 03, 2004
' Revisions :
'=====================================================================
Public Class PM_InheritWOAccess
    Inherits WebPages.Template.WhizTemplate

    Private m_strMode As String = ""

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


    Public Sub PageInit()
        Dim strSourceRole As String
        Dim strDestinationRole As String
        Dim strSQL As String
        m_strMode = Request.QueryString("Mode")

        If m_strMode Is Nothing Then
            m_strMode = ""
        End If

        If m_strMode.ToLower = "save" Then
            If Request.Form("cboSourceRole") = "" Then
                strSourceRole = "Null"
            Else
                strSourceRole = Request.Form("cboSourceRole")
            End If

            If Request.Form("cboDestinationRole") = "" Then
                strDestinationRole = "Null"
            Else
                strDestinationRole = Request.Form("cboDestinationRole")
            End If


            strSQL = "Exec usp_InheritWOUserAcess " & strSourceRole & "," & strDestinationRole

            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            'Response.Write strSQL
            'Response.End 

        End If




        '######### Page Code starts here
        GetMenu()

        GetPageCaption()

        GetUI()

        GetMenu()

    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name        : GetMenu()	
    ' Purpose               : Function To Draw the Menu
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : May 3, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        Dim objMenu As WebPages.Template.StaticMenu
        objMenu = New WebPages.Template.StaticMenu

        'Plot the Menu and the pager
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), _
                         MyBase.GetResourceString("MENU_CLOSE"), _
                          MyBase.GetResourceString("MENU_HELP")}

        Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick('897')"}

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_HELP_TOOLTIP")}


        objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, False)
        objMenu = Nothing
        MyBase.InitializeResources("Appresources.PM_InheritWoAccess", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name        : GetPageCaption()	
    ' Purpose               : Function To Page Caption
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 3, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetPageCaption()
        'If Apply Filter Mode
        MyBase.InitializeResources("Appresources.PM_InheritWoAccess", "AppResources")
        WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("PAGE_CAPTION"))
    End Sub
    '=====================================================================
    ' Procedure Name        : GetUI()	
    ' Purpose               : Function To Draw the UI for inherit Access Rights
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : May 3, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetUI()
        Response.Write("<div ID=PageDiv Style=HEIGHT: 279px; OVERFLOW: Auto; WIDTH:100%>")
        Response.Write("<table CellSpacing=4 width=99.9% border=0>")
        Response.Write("<tr><td colspan=4>&nbsp;</td></tr>")

        If m_strMode.ToLower = "save" Then
            Response.Write("<TR><TD class=clsTDHeader colspan = 2>" & MyBase.GetResourceString("SUCCESS_MESSAGE") & "</TD></TR>")
        Else
            Response.Write("<TR><TD class=clsTDHeader>" & MyBase.GetResourceString("SOURCE_ROLE") & "</TD>")
            Response.Write("<TD class=clsTDHeader>" & MyBase.GetResourceString("DESTINATION_ROLE") & "</TD></TR>")
            Response.Write("<TR><TD align=center>")
            CommonFunctions.HTMLControls.DrawComboBox("cboSourceRole", "EXEC usp_GetRoleForTag 27", 225, , , True)
            Response.Write("</TD><TD align=center>")
            CommonFunctions.HTMLControls.DrawComboBox("cboDestinationRole", "EXEC usp_GetRoleForTag 27", 225, , , True)
            Response.Write("</TD></TR>")
        End If
        Response.Write("</TR></table>")
        Response.Write("</Div>")
    End Sub

End Class
