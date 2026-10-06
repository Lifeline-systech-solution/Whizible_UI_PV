Public Class Help
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
    Private strMode As String = ""
    Private strAction As String = ""
    Private strHelpID As String = ""

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        If Not Request.QueryString.Item("Mode") Is Nothing Then strMode = Request.QueryString.Item("Mode").ToString
        If Not Request.QueryString.Item("Action") Is Nothing Then strAction = Request.QueryString.Item("Action").ToString
        If Not Request.QueryString.Item("HelpID") Is Nothing Then
            strHelpID = CommonFunction.General.BuildQueryString(Request.QueryString.Item("HelpID").ToString)
        Else
            strHelpID = "DA"
        End If


    End Sub
#Region "Public Functions"
    Public Sub DrawPage()
        '=====================================================================
        ' Procedure  Name		:	DrawHelp
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw the help
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	Oct 9 2003
        ' Revisions				:	
        '=====================================================================
        'If strMode is edit then call edit help procedure
        If strMode = "Edit" Then
            'call edithelp procedure
            EditHelp()
        Else
            'call draw help procedure
            Call DrawHelp()
            'Cal window onload function to writer client side window onload event
            WindowOnload(False)
        End If
    End Sub
#End Region
#Region "Private Function"
    Private Sub DrawHelp()
        '=====================================================================
        ' Procedure  Name		:	DrawHelp
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw the help
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	Oct 9 2003
        ' Revisions				:	
        '=====================================================================
        Dim strMenu As String

        'If role is administrator then only show this link
        If CType(Session("intPostID"), Long) = CommonFunction.Constants.ROLE_ADMINISTRATOR Then

            Dim strLinkArray As String() = {MyBase.GetResourceString("MENU_EDIT")}
            Dim strFunctionName As String() = {"edit_onclick()"}
            Dim strToolTip As String() = {MyBase.GetResourceString("MENU_EDIT_TOOLTIP")}
            'call DrawMenu function of template static menu class object
            strMenu = WebPage.Templates.StaticMenu.DrawMenu(strLinkArray, strFunctionName, strToolTip, True)
            Response.Write(strMenu + "<BR>")
        End If

        Dim objHelp As HelpDetails
        'get the help details
        objHelp = GetHelpDetails()

        Response.Write("<TABLE class=clsTABLE width='99.9%'>")
        Response.Write("<TR><TD align=center class=clsTDColumnHeader>" & objHelp.HelpTitle & "</TD></TR>")
        Response.Write("<TR><TD class=clsTDHelp>" & objHelp.Help & "</TD></TR>")
        Response.Write("</TABLE>")
        objHelp = Nothing
        'Call getreatedtopics procedure to draw the related topics of this help
        Call GetRelatedTopics()
        'Check for admnistrator role
        If CType(Session("intPostID"), Long) = CommonFunction.Constants.ROLE_ADMINISTRATOR Then
            Response.Write("<BR>" + strMenu)
        End If

    End Sub
    Private Function GetHelpDetails() As HelpDetails
        '=====================================================================
        ' Function  Name		:	GetHelpDetails
        ' Parameters Passed		:	None
        ' Returns				:	HelpDetails class oobject
        ' Parameters Affected	:	None
        ' Purpose				:	To get the help details.
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	Oct 8 2003
        ' Revisions				:	
        '=====================================================================
        Dim strSQL As String
        Dim drHelp As IDataReader

        'check for Default cultureid and current reqeust culture id
        If (CType(MyBase.DefaultUILCID, Integer) = MyBase.CurrentThreadUICultureID) Then
            strSQL = "EXEC usp_tbl_PBN_Help '" & strHelpID & "',NULL"
        Else
            'Check whether current thread culutre id is supported by the system or not
            'If InStr(CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"), CType(MyBase.CurrentThreadUICultureID, String)) > 0 Then
            strSQL = "EXEC usp_tbl_PBN_Help '" & strHelpID & "'," + CType(MyBase.CurrentThreadUICultureID, String)
            'Else    'else call the default one
            '   strSQL = "EXEC usp_tbl_PBN_Help '" & strHelpID & "',NULL"
            'End If
        End If
        'get the data reader object
        drHelp = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'create the help details class object
        Dim objHelp As New HelpDetails()

        If drHelp.Read Then

            objHelp.HelpTitle = drHelp("HelpTitle").ToString
            objHelp.Help = drHelp("ActualHelp").ToString
        Else
            objHelp.HelpTitle = "Sorry, help is not available for this Topic."
            objHelp.Help = ""
        End If
        'close the data reader
        drHelp.Close()
        drHelp = Nothing
        GetHelpDetails = objHelp
        'destroy the help class object
        objHelp = Nothing

    End Function

    Private Sub GetRelatedTopics()
        '=====================================================================
        ' Procedure  Name		:	GetRelatedTopics
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To print the related topics
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	Oct 9 2003
        ' Revisions				:	
        '=====================================================================
        Dim drRelatedTopics As IDataReader
        Dim strSQL As String

        strSQL = "EXEC usp_Sel_tbl_PBN_Help_RelatedTopic '" & strHelpID & "'"

        drRelatedTopics = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If drRelatedTopics.Read Then
            Response.Write("<BR><BR><TABLE class=clsTable width='99.9%'>")
            Response.Write("<TR><TD class=clsTDGroupFooter>Related topics</TD></TR>")
            'loop to print help related topics
            While drRelatedTopics.Read
                Response.Write("<TR><TD class=clsTDHelp><A Href='Help.aspx?HelpID=" & CType(drRelatedTopics("HelpID"), String) & "'>" & CType(drRelatedTopics("HelpTitle"), String) & "</A></TD></TR>")
            End While

        End If
        'close the data reader object
        drRelatedTopics.Close()
        drRelatedTopics = Nothing
    End Sub
    Private Class HelpDetails
        Public HelpTitle As String
        Public Help As String
    End Class
    Private Sub EditHelp()
        '=====================================================================
        ' Procedure  Name		:	EditHelp
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To edit the respective help id
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	Oct 9 2003
        ' Revisions				:	
        '=====================================================================
        Dim strMenu As String

        If CType(Session("intPostID"), Long) = CommonFunction.Constants.ROLE_ADMINISTRATOR Then
            Dim strLinkArray As String() = {MyBase.GetResourceString("MENU_SAVE")}
            Dim strFunctionName As String() = {"save_onclick()"}
            Dim strToolTip As String() = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP")}
            'call DrawMenu function of template static menu class object
            strMenu = WebPage.Templates.StaticMenu.DrawMenu(strLinkArray, strFunctionName, strToolTip, True)
            Response.Write(strMenu)
        End If

        If strAction = "Save" Then
            'call save data procedure to save data
            SaveData()
            'Cal window onload function to writer client side window onload event
            WindowOnload(False)
            Exit Sub
        End If
        Dim objHelp As HelpDetails
        objHelp = GetHelpDetails()
        'Cal window onload function to writer client side window onload event
        WindowOnload(True)

        Response.Write("<BR><DIV id=divList style='overflow:auto;width:100%'>")
        Response.Write("	<TABLE class=clsTABLE cellspacing=0 style='width=100%;height=100%'>")
        Response.Write("	<TR class=clsTROdd>")
        Response.Write("<TD>")
        Response.Write("<TEXTAREA style='height=100%;width:100%;' id=txtHelp name=txtHelp>" & objHelp.Help & "</TEXTAREA>")
        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("</TABLE>")
        Response.Write("</DIV><BR>")

        If CType(Session("intPostID"), Long) = CommonFunction.Constants.ROLE_ADMINISTRATOR Then Response.Write(strMenu)

        objHelp = Nothing


    End Sub
    Private Sub SaveData()
        '=====================================================================
        ' Procedure  Name		:	SaveData
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To edit the respective help id
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	Oct 9 2003
        ' Revisions				:	
        '=====================================================================
        'call Base calls getformvalue function get the form value
        Dim strHelp As String = MyBase.GetFormValue("txtHelp", True)

        Dim strSQL As String
        'Check for validating the current thread lcid is match with default UICultureID
        If CType(MyBase.DefaultUILCID, Integer) = MyBase.CurrentThreadUICultureID Then
            strSQL = "EXEC usp_upd_tbl_PBN_Help '" + strHelpID + "','" + strHelp & "'"
        Else
            'Check whether current thread culutre id is supported by the system or not
            If InStr(CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"), CType(MyBase.CurrentThreadUICultureID, String)) > 0 Then
                strSQL = "EXEC usp_upd_tbl_PBN_Help '" + strHelpID + "','" + strHelp + "'," + MyBase.CurrentThreadUICultureID.ToString
            Else 'called default one
                strSQL = "EXEC usp_upd_tbl_PBN_Help '" + strHelpID + "','" + strHelp & "'"
            End If

        End If
        'update the data
        Dim intResult As Integer = CommonFunction.Data.SQLInsertOrUpdateData(strSQL)
        'write client side script to refresh the parent window and close the window.
        CommonFunction.General.WriteHTML(vbCrLf & "<script LANGUAGE=javascript>")
        CommonFunction.General.WriteHTML("var strParentPage;")
        CommonFunction.General.WriteHTML("try")
        CommonFunction.General.WriteHTML("{	")
        CommonFunction.General.WriteHTML("strParentPage = new String();")
        CommonFunction.General.WriteHTML("strParentPage = opener.location.href")

        CommonFunction.General.WriteHTML("if (strParentPage.toUpperCase().indexOf('HELP.ASPX') != -1)")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("opener.location.href = opener.location.href")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("catch(e)")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("//Do nothing")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("window.close();")
        CommonFunction.General.WriteHTML("</script>")

    End Sub

    Private Sub WindowOnload(ByVal ResizeDiv As Boolean)
        '=====================================================================
        ' Procedure  Name		:	WindowOnload
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To write the client side script window_onload
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	Oct 9 2003
        ' Revisions				:	
        '=====================================================================
        CommonFunction.General.WriteHTML(vbCrLf & "<SCRIPT Language=JavaScript>")

        CommonFunction.General.WriteHTML("function window_onload()")
        CommonFunction.General.WriteHTML("{")
        If ResizeDiv = True Then
            CommonFunction.General.WriteHTML("var intDivHeight ;")
            CommonFunction.General.WriteHTML("var intDivHeightRisk;")
            CommonFunction.General.WriteHTML("var lc;")
            CommonFunction.General.WriteHTML("intDivHeight = document.body.offsetHeight - divList.offsetTop - 60;")
            CommonFunction.General.WriteHTML("if (intDivHeight < 100)")
            CommonFunction.General.WriteHTML("intDivHeight = 100;")
            CommonFunction.General.WriteHTML("divList.style.height = intDivHeight;")
        End If
        CommonFunction.General.WriteHTML("}")

        CommonFunction.General.WriteHTML("function window_onresize()")
        CommonFunction.General.WriteHTML("{")
        If ResizeDiv = True Then
            CommonFunction.General.WriteHTML("var intDivHeight ;")
            CommonFunction.General.WriteHTML("var intDivHeightRisk;")
            CommonFunction.General.WriteHTML("intDivHeight = document.body.offsetHeight - divList.offsetTop - 60;")
            CommonFunction.General.WriteHTML("if (intDivHeight < 100) ")
            CommonFunction.General.WriteHTML("intDivHeight = 100;")
            CommonFunction.General.WriteHTML("divList.style.height = intDivHeight	;")
        End If
        CommonFunction.General.WriteHTML("}")


        CommonFunction.General.WriteHTML("</SCRIPT>")

    End Sub

    Sub New()
        '=====================================================================
        ' Procedure  Name		:	New (Constructor of this class)
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	to call the base class functions
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	Oct 9 2003
        ' Revisions				:	
        '=====================================================================
        'MyBase.ApplySecurity()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

    End Sub
#End Region 'Private functions
End Class
