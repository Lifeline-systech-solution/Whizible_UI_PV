
Public Class DB_ProjectDashboard
    Inherits WebPages.Template.WhizTemplate

    Protected m_intProjectID As Integer
    Protected m_intCount As Integer
    Private m_blnUseSQL As Boolean
    Public Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)
        m_blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

    End Sub

    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        '-- To get the Menu captions
        '-- Load this page's specific resource file
        MyBase.InitializeResources("AppResources.DB_ProjectDashboard", "AppResources")
    End Sub

    Protected Sub PageInit()
        Dim strMenu As String
        Dim strQuery As String
        Dim drGraphs As IDataReader
        Dim strImageFileName As String
        Dim strGraphName, strGraphDesc As String
        Dim intTDCounter As Integer
        Dim intGraphID As Integer
        Dim strProjectName As String
        Dim drProjectInfo As IDataReader
        Dim strMode, strFunc As String
        Dim intIndex, intCount As Integer
        Dim cObjPageCaption As New WebPage.Templates.PageCaption
        Dim strClassName As String
        Dim intCounter As Integer = 0

        '=== FOR TESTING ====
        'Session("intUserID") = 210
        m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)
        strMode = Request.QueryString("MODE")

        '====================

        'Draw Top Menu
        MyBase.InitializeResources("AppResources.DB_ProjectDashboard", "AppResources")
        
        Select Case Trim(strMode + "")

            '-- Main Page
            Case ""
                strMenu = PrepareMenu(strMenu)
                CommonFunctions.General.WriteHTML(strMenu + "<BR>")

                '-- Get Project Name
                drProjectInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + m_intProjectID.ToString, m_blnUseSQL)
                If drProjectInfo.Read Then
                    strProjectName = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("ProjectName"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drProjectInfo)

                '-- Page Caption
                MyBase.InitializeResources("AppResources.DB_ProjectDashboard", "AppResources")
                CommonFunction.General.WriteHTML(cObjPageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION") & " for " & strProjectName, , , True) + vbCrLf)
                cObjPageCaption = Nothing

                CommonFunction.General.WriteHTML("<DIV id='InitialDiv' STYLE='OVERFLOW:auto;Width: 100%'>")
                CommonFunction.General.WriteHTML("" + vbCrLf)
                'CommonFunction.General.WriteHTML("<form id='frmProjectDashboard' method='post' runat='server'>")
                '-- Get List of All Graphs User has selected to View
                strQuery = "usp_Sel_ProjectDB_UserSelectedGraphs " + Session("intUserID").ToString + ",0,'" + Session("LoginType").ToString + "'"
                drGraphs = CommonFunctions.Data.GetDataReader(strQuery, m_blnUseSQL)

                '-- When The User has not chosen any graphs then he/She will be shown all the grpahs 
                '-- We Insert All the graphs into the tbl_ProjectDB_UserSelectedGraphs by default

                If Not drGraphs.Read Then
                    '-- Insert all the records into Table 
                    CommonFunctions.Data.InsertOrUpdateData(" usp_Ins_tbl_ProjectDB_UserSelectedGraphs " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "'", m_blnUseSQL)

                End If
                CommonFunction.Data.DisposeDataReader(drGraphs)
                'drGraphs.Close()
                drGraphs = CommonFunctions.Data.GetDataReader(strQuery, m_blnUseSQL)

                intTDCounter = 0
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                Response.Write("<table align=center class=clsTable width=99.9% cellPadding=0 cellSpacing=0>")
                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                'Response.Write("<TR>")
                'Response.Write("<td>")
                'Response.Write("<table class=clsTable border=0 cellPadding=0 cellSpacing=0 width=100% >")

                Do While drGraphs.Read
                    If intTDCounter = 0 Then
                        Response.Write("<TR class=clsTREven>")
                    End If

                    If CommonFunctions.General.CheckIsNothing(drGraphs) <> "" Then
                        intGraphID = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphID"), ""), Integer)
                        strGraphName = CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphName"), "").ToString
                        strGraphDesc = CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphDescription"), "").ToString
                        strImageFileName = drGraphs("GraphFileName").ToString & m_intProjectID.ToString & ".png"

                        With Response
                            .Write("<td>")
                            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                            .Write("<table class=clsTable border=0 cellPadding=0 cellSpacing=0 width=99.9%>")
                            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                            .Write("<tr class=clsTRColumnHeader>")
                            .Write("<td align=middle>" & CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphName"), "").ToString & " </td></tr>")
                            .Write("<input name=GraphName" & intGraphID & " ID ='" & "GraphName" & intGraphID & "' type=hidden value='" & strGraphName & "'>")
                            .Write("<tr class=clsTREven>")
                            .Write("<td align=middle><b>" & strGraphDesc & "&nbsp;</b></td></tr>")
                            .Write("<tr class=clsTREven>")
                            .Write("<td class=clsTDOdd align=middle vAlign=center>")
                            .Write("<a href=""javascript:showBiggerview(" & intGraphID & ",'" & strImageFileName & "'," & m_intProjectID.ToString & ")"">")

                            '-- If Graph has been generated Previously then show the Image else show the 'NoPreview' Image
                            If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & strImageFileName)) Then
                                .Write("<img border=0 src='" & GRAPH_DIRECTORY & strImageFileName & "' WIDTH=186 HEIGHT=70></a>")
                            Else

                                .Write("<img border=0 src='" & GRAPH_DIRECTORY & "../NoPreview.gif' WIDTH=186 HEIGHT=70></a>")
                            End If

                            .Write("</td></tr></table></td>")

                            '-- We keep 3 graphs in a row, thus we keep this counter, 
                            ' When the counter is > 3 we goto new row (TR) and re-initialize the counter
                            intTDCounter = intTDCounter + 1

                            If intTDCounter >= 3 Then
                                intTDCounter = 0
                                Response.Write("</TR>")
                                Response.Write("<TR class=clsTRColumnHeader><td colspan=3>&nbsp;</td></TR>")
                            End If

                        End With
                    End If
                Loop

                '--release datareader 
                CommonFunctions.Data.DisposeDataReader(drGraphs)

                '-- When a row contains only 1 or 2 graphs then we complete the 
                '-- column headers for that row
                If intTDCounter = 1 Or intTDCounter = 2 Then
                    Response.Write("<td colspan=2 >")
                    'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                    Response.Write("<table class=clsTable border=0 cellPadding=0 cellSpacing=0 width=99.9%>")
                    'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                    Response.Write("<tr class=clsTRColumnHeader valign=top><td valign=top> &nbsp;</td></tr>	 ")
                    Response.Write("<tr class=clsTREven valign=top><td valign=top height='100%'> &nbsp;</td></tr>")
                    Response.Write("<tr class=clsTREven HEIGHT=78 valign=top><td align=center WIDTH=186 HEIGHT=70> &nbsp;</td></tr>")
                    Response.Write("</table>")
                    Response.Write("</td>")
                    Response.Write("</tr>")
                    Response.Write("<TR class=clsTRColumnHeader><td colspan=3>&nbsp;</td></TR>")
                End If

                'CommonFunction.General.WriteHTML("</TABLE></TD></TR></TABLE>")
                CommonFunction.General.WriteHTML("</TABLE>")
                'CommonFunction.General.WriteHTML("</form>")
                CommonFunction.General.WriteHTML("</DIV>")

                '=====================================================================
                '	DASHBOARD CONFIGURATION SCREEN
                '=====================================================================

            Case "CONFIGURE"

                strFunc = Request.QueryString("Func")
                '-- NOTE: In CONFIGURATION: 2 modes are there: 'List' Table and 'Save' 
                Select Case strFunc
                    '-- Mode 1: SAVING Logic: When we have Posted the Data: After saving redirect to Main Project DB
                Case "Save"  '-- Save Mode in Configuration DB

                        'CommonFunction.General.WriteHTML("<form id='frmProjectDashboard' method='post' runat='server'>")
                        m_intCount = CType(MyBase.GetFormValue("hdRowCount"), Integer) '-- Get count of total checkboxes on page
                        'Dim arrtxthiddenGraphID() As String = Split(Request.Form("txthiddenGraphID"), ",")

                        For intIndex = 0 To m_intCount - 1 '-- Building Querystring to save settings
                            If Request.Form.Get("chkSelected" & Request.Form.GetValues("txthiddenGraphID")(intIndex)) <> "" Then
                                'Response.write "<br>Update tbl set ordernumber =" & Request.Form("txtOrderNumber")(intIndex) & ", IsVisible =1 where GraphID = " & Request.Form("txthiddenGraphID")(intIndex) & " and UserID = " & Session("intUserID")
                                strQuery = "usp_Upd_tbl_ProjectDB_UserSelectedGraphs " + Session("intUserID").ToString + "," + Request.Form.GetValues("txthiddenGraphID")(intIndex) + "," + Request.Form.GetValues("txtOrderNumber")(intIndex) + ",1,'" + Session("LoginType").ToString + "'"
                                'Response.Write(strQuery)
                                CommonFunctions.Data.InsertOrUpdateData(strQuery, m_blnUseSQL)
                            Else
                                'Response.write "<br>Update tbl set ordernumber =" & Request.Form("txtOrderNumber")(intIndex) & ", IsVisible =0 where GraphID = " & Request.Form("txthiddenGraphID")(intIndex) & " and UserID = " & Session("intUserID")	
                                strQuery = "usp_Upd_tbl_ProjectDB_UserSelectedGraphs " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "'," & Request.Form.GetValues("txthiddenGraphID")(intIndex) & "," & Request.Form.GetValues("txtOrderNumber")(intIndex) & ",0,'" + Session("LoginType").ToString + "'"
                                'Response.Write("<br>" & strQuery)
                                CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_ProjectDB_UserSelectedGraphs " + Session("intUserID").ToString + "," + Request.Form.GetValues("txthiddenGraphID")(intIndex) + "," + Request.Form.GetValues("txtOrderNumber")(intIndex) + ",0,'" + Session("LoginType").ToString + "'", m_blnUseSQL)
                            End If

                        Next

                        '-- Goto Dasbboard Mode after saving
                        'Response.Redirect "ProjectDashboard.asp?Mode=DB"

                        CommonFunctions.General.WriteHTML(" <Script Language=javascript>")
                        CommonFunctions.General.WriteHTML("window.opener.frmProjectDashboard.action= 'DB_ProjectDashboard.aspx?ProjectID=" + m_intProjectID.ToString + "';")
                        CommonFunctions.General.WriteHTML("window.opener.frmProjectDashboard.submit();")
                        CommonFunctions.General.WriteHTML("window.close();")
                        CommonFunctions.General.WriteHTML("</Script>")
                        'CommonFunction.General.WriteHTML("</form>")
                        '-- ### Mode 2: Show the Complete LIST of Graphs ###	
                    Case Else
                        '-- Get the List of Graphs with there settings from table (for this User)
                        '-- and accordingly display the Checkboxes (checked or unchecked)

                        drGraphs = CommonFunctions.Data.GetDataReader("usp_Sel_ProjectDB_UserSelectedGraphs " + Session("intUserID").ToString + ",1,'" + Session("LoginType").ToString + "'", m_blnUseSQL)
                        intCount = 0 ' Counter for the textboxes: OrderNumber

                        strMenu = PrepareMenu(strMode)
                        CommonFunctions.General.WriteHTML(strMenu + "<BR>")

                        '-- Page Caption
                        MyBase.InitializeResources("AppResources.DB_ProjectDashboard", "AppResources")
                        CommonFunction.General.WriteHTML(cObjPageCaption.GetPageCaptions(, MyBase.GetResourceString("CONFIGURE"), , , True) + vbCrLf)
                        CommonFunction.General.WriteHTML("<DIV id='InitialDiv' STYLE='OVERFLOW:auto; Width: 100%'>")
                        CommonFunction.General.WriteHTML("" + vbCrLf)
                        'CommonFunction.General.WriteHTML("<form id='frmProjectDashboard' method='post' runat='server'>")

                        With Response
                            .Write("<table class=clsTable style=WIDTH:100% cellspacing=0>")
                            .Write("<tr class=clsTRColumnHeader >")
                            .Write("<td align=center>Graph ID</td>")
                            .Write("<td align=center>Graph Name</td>")
                            .Write("<td align=center>Order Number</td>")
                            .Write("<td align=center>Show on Dashboard</td>")
                            .Write("</tr>")

                            intCounter = 0
                            Do While drGraphs.Read
                                '-- For deciding on the Row's style class (Odd or Even)
                                If intCounter Mod 2 = 0 Then
                                    strClassName = "clsTROdd"
                                Else
                                    strClassName = "clsTREven"
                                End If
                                intCounter += 1
                                .Write("<tr class=" + strClassName + " >")

                                .Write("<td width=5% align=left>" & drGraphs("GraphID").ToString & "</td>")
                                .Write("<td width=40% align=left>" & drGraphs("GraphName").ToString & "</td>")
                                .Write("<td width=10% align=center>")

                                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                                CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber", "txtOrderNumber", , 40, 3, drGraphs("OrderNumber").ToString, "Right", , , , , , "", EnableHTMLEncode:=True)
                                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                                .Write("</td>")
                                .Write("<td width=5% align=center>")

                                '-- Provide Checked/ Unchecked checkboxes for each graph according to Chosen settings
                                If CType(drGraphs("IsVisible"), Boolean) Then
                                    CommonFunctions.HTMLControls.DrawCheckBox("chkSelected" & drGraphs("GraphID").ToString, "chkSelected", , True, "1")
                                Else
                                    CommonFunctions.HTMLControls.DrawCheckBox("chkSelected" & drGraphs("GraphID").ToString, "chkSelected", , False, "1")
                                End If
                                '-- Hidden varaible stores the Graph ID

                                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                                CommonFunctions.HTMLControls.DrawTextBox("txthiddenGraphID", "txthiddenGraphID", , , , drGraphs("GraphID").ToString, , , , , , True, EnableHTMLEncode:=True)
                                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                                .Write("</td>")
                                .Write("</tr>")

                                intCount = intCount + 1
                            Loop
                            '-- Add Rwcount to Hidden Variable

                            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("hdRowCount", "hdRowCount", , , , intCount.ToString, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                            .Write("</table>")
                        End With

                        CommonFunctions.Data.DisposeDataReader(drGraphs)
                        'CommonFunction.General.WriteHTML("</form>")
                        CommonFunction.General.WriteHTML("</DIV>")

                End Select
        End Select
        Response.Write("<BR>" + strMenu)
    End Sub

    Private Function PrepareMenu(ByVal strMode As String) As String
        '=====================================================================
        ' Procedure Name        : PrepareMenu
        ' Purpose               : To write the page for displaying static Project Dashboard's graphs
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        Dim strMenu As String
        Select Case strMode
            
            Case "CONFIGURE"
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick('PROJECT_GRAPHS')"}
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

            Case Else

                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CONFIGURE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CONFIGURE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                Dim arrClientSideFunctions() As String = {"Configure_OnClick()", "Close_OnClick()", "Help_OnClick('PROJECT_GRAPHS')"}
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        End Select
        Return strMenu

    End Function

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class
