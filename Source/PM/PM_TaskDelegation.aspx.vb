Imports CommonFunctions

Public Class PM_TaskDelegation
    Inherits WebPages.Template.WhizTemplate

    Protected CONST_MODE_ACCESS As String = "ACCESSRIGHTS"
    Protected CONST_MODE_NODE As String = "NODEACCESS"
    Protected CONST_ACTION_SAVE As String = "SAVE"
    Protected CONST_ACTION_RESTORE As String = "RESTORE"

    Protected m_strWindowTitle As String
    Protected m_strMode As String
    Protected m_strEmployeeID As String
    Private m_strProjectEmployeeRoleID As String
    Private m_strProjectID As String
    Private m_strRoleID As String
    Private m_strDelegatorRoleID As String
    Private m_strAction As String
    Private WithEvents m_objGrid As WebPage.Templates.GenericGrid


    ''Added by Dhanashri S on 29 Jan 2016
    Protected m_PKToken_ModifyAccess As String
    Protected m_PKToken_EmployeeID As String
    Protected m_PKToken_NodeAccess As String
    Protected m_PKToken_TaskID As String
    ''End of Addition by Dhanashri S on 29 Jan 2016

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
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_TASK")
        ''Added  By Shamkant s 31/12/2015
        'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '    Response.Write(vbCrLf + "<script>")
        '    Response.Write(vbCrLf + "		if (window.opener == null)")
        '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '    If strRedirectToPage.Trim = "" Then
        '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '    Else
        '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        '    End If
        '    Response.Write(vbCrLf + "</script>")
        'End If
        'Ended By Shamkant s 31/12/2015


        ''Added by Dhanashri S on 29 Jan 2016 for PkToken Validation
        If Not Request.QueryString("PkTokenModifyAccess") Is Nothing Then
            m_PKToken_ModifyAccess = Request.QueryString("PkTokenModifyAccess").ToString
        End If
        If Not Request.QueryString("EmployeeID") Is Nothing Then
            m_PKToken_EmployeeID = Request.QueryString("EmployeeID").ToString
        End If
        If Not Request.QueryString("NodeAccess") Is Nothing Then
            m_PKToken_NodeAccess = Request.QueryString("NodeAccess").ToString
        End If
        If Not Request.QueryString("TaskID") Is Nothing Then
            m_PKToken_TaskID = Request.QueryString("TaskID").ToString
        Else
            m_PKToken_TaskID = 0
        End If

        If m_PKToken_ModifyAccess <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_PKToken_EmployeeID, String) + CType(m_PKToken_NodeAccess, String) + CType(m_PKToken_TaskID, String) + CType(0, String) + CType(0, String), m_PKToken_ModifyAccess) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_PKToken_EmployeeID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End of Addition by Dhanashri S on 29 Jan 2016

        ''Added by Yogesh Jalamkar  on 02 AUG 2016 to validate Token
        If Request.QueryString("EmployeeID") IsNot Nothing And Request.QueryString("PkTokenRestoreAll") IsNot Nothing Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("EmployeeID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PkTokenRestoreAll")) = False) Then
                ' Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_YearValue, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If

        End If
        '  End of addition Yogesh Jalamkar  on 02 AUG 2016 to validate Token

    End Sub

    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.PM_TaskDelegation", "AppResources")
    End Sub

    ''Added by Dhanashri S on 29 Jan 2016 for PkToken Validation
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ModifyAccess_OnClick(EmployeeID As String, NodeAccess As String, TaskID As String) As String
        Try
            Dim m_PKToken_ModifyAccess_Multiple As String
            m_PKToken_ModifyAccess_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(NodeAccess, String) + CType(TaskID, String) + "0" + "0")

            Return m_PKToken_ModifyAccess_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_TabAccess_OnClick(EmployeeID As String, TagID As String) As String
        Try
            Dim m_PKToken_TabAccess_Multiple As String
            m_PKToken_TabAccess_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(TagID, String) + "0" + "0")

            Return m_PKToken_TabAccess_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Addition by Dhanashri S on 29 Jan 2016


    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 8 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strRole As String
        Dim strEmployeeName As String
        Dim strUserName As String
        Dim strTaskID As String

        m_strProjectEmployeeRoleID = Request.QueryString("ProjectEmployeeRoleID") + ""
        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_MODE_ACCESS
        m_strAction = Request.QueryString("Action") + ""
        strTaskID = Request.QueryString("TaskID") + ""
        m_strProjectID = Session("intProjectID").ToString + ""
        m_strDelegatorRoleID = Session("intPostID").ToString + ""

        If m_strProjectEmployeeRoleID <> "" Then
            'get the employeeID form the database, as page is called first time
            'strSQL = "select employeeID from tbl_PM_projectEmployeeRole where ProjectEmployeeRoleID=" + m_strProjectEmployeeRoleID.Trim
            strSQL = "usp_sel_tbl_PM_projectEmployeeRole_employeeID_ProjectEmployeeRoleID " + m_strProjectEmployeeRoleID.Trim
            m_strEmployeeID = Data.CheckIsDBNull(Data.GetDataScalar(strSQL, MyBase.UseSQL), "0").ToString + ""
        Else
            'get the employeeID from the query string as page is posted back
            m_strEmployeeID = Request.QueryString("EmployeeID") + ""
        End If

        Select Case m_strMode.ToUpper
            Case CONST_MODE_ACCESS

                If m_strAction <> "" Then
                    Call performAccessAction()
                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_RESTORE_CORPORATE_ACCESS_RIGHTS")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_RESTORE_CORPORATE_ACCESS_RIGHTS_TOOLTIP")) : arrClientSideFunctions.Add("RestoreAll_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('TASK_DELEGATION')")

                'copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                'draw upper menu
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                'get the employee name
                strEmployeeName = ""
                strUserName = ""
                strSQL = "usp_tbl_Sel_EmployeeInfo " + m_strEmployeeID.Trim
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDR.Read Then
                    strUserName = Data.CheckIsDBNull(objDR("UserName"), "").ToString + ""
                    strEmployeeName = Data.CheckIsDBNull(objDR("EmployeeName"), "").ToString + ""
                End If
                Data.DisposeDataReader(objDR)

                'get the role of the employee for the current project
                'strSQL = "SELECT Role FROM tbl_PM_ProjectEmployeeRole WHERE ProjectID = " + m_strProjectID.Trim + " AND EmployeeID=" + m_strEmployeeID.Trim
                strSQL = "usp_sel_tbl_PM_ProjectEmployeeRole_Role " + m_strProjectID.Trim + "," + m_strEmployeeID.Trim
                m_strRoleID = Data.CheckIsDBNull(Data.GetDataScalar(strSQL, MyBase.UseSQL), "0").ToString + ""

                'get the role name of the employee
                strRole = ""
                strSQL = "usp_Sel_tbl_PM_Role " + m_strRoleID.Trim
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDR.Read Then
                    strRole = Data.CheckIsDBNull(objDR("RoleDescription"), "").ToString + ""
                End If
                Data.DisposeDataReader(objDR)

                'initialize the resource file for task Delegation page.
                MyBase.InitializeResources("AppResources.PM_TaskDelegation", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_TASK"), MyBase.GetResourceString("CAP_USER_NAME") + " : " + strUserName.Trim + " - " + strEmployeeName.Trim + "[" + strRole.Trim + "]")
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_TASK") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen 
                Call plotTaskListGrid()

                'draw lower menu
                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)

            Case CONST_MODE_NODE
                If m_strAction <> "" Then
                    Call performSingleNodeAction(strTaskID)
                    'General.WriteHTML("<Script language=javascript>")
                    'General.WriteHTML(" opener.frmTaskDelegation.action='PM_TaskDelegation.aspx?Mode=" + CONST_MODE_ACCESS + "&Action=" + CONST_ACTION_SAVE + "&EmployeeID=" + m_strEmployeeID + "';")
                    'General.WriteHTML(" opener.frmTaskDelegation.submit();")
                    'General.WriteHTML(" window.close();")
                    'General.WriteHTML("</Script>")
                End If

                '****************************************************************************************
                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add(MyBase.GetResourceString("MENU_SET_ACCESS_RIGHTS")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SET_ACCESS_RIGHTS_TOOLTIP")) : arrClientSideFunctions.Add("SetNodeAccess_OnClick(" + strTaskID.Trim + ")")
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('TASK_DELEGATION')")

                'copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing
                'create menu HTML
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                'draw upper menu
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                'initialize the resource file for task Delegation page.
                MyBase.InitializeResources("AppResources.PM_TaskDelegation", "AppResources")

                'draw the grid 
                Call plotSingleTagAccess(strTaskID)

                'plot lower menu
                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)

                ''refresh parent window when data is updated
                'If m_strAction <> "" Then
                '    General.WriteHTML("<Script language=javascript>")
                '    General.WriteHTML("opener.frmTaskDelegation.action = opener.location.href;")
                '    General.WriteHTML("opener.frmTaskDelegation.submit();")
                '    General.WriteHTML("</Script>")
                'End If

                'write client side script to submit the parent to upadate the data.
                'Modified by NiranjanK on Date June 09,2006 for WhizibleSEM Issue ID.4168
                General.WriteHTML("<Script language=javascript>")
                General.WriteHTML(" function updateDataByParent(strNodeAccess)")
                General.WriteHTML(" { ")
                General.WriteHTML(" GetParentObjectReference('frmTaskDelegation','txtNodeAccess" + strTaskID.Trim + "').value= strNodeAccess;")
                General.WriteHTML(" GetParentObjectReference('frmTaskDelegation','txtNodeAccessModified" + strTaskID.Trim + "').value= '1';")
                General.WriteHTML(" opener.frmTaskDelegation.action='PM_TaskDelegation.aspx?Mode=" + CONST_MODE_ACCESS + "&Action=" + CONST_ACTION_SAVE + "&EmployeeID=" + m_strEmployeeID + "';")
                General.WriteHTML(" opener.frmTaskDelegation.submit();")
                General.WriteHTML(" window.close();")
                General.WriteHTML(" } ")
                General.WriteHTML("</Script>")
                'End of modification by NiranjanK June 09,2006 for WhzibleSEM Issue ID.4168
            Case Else
                General.WriteHTML("<Div id='DivList'></Div>")
        End Select

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotTaskListGrid
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the grid for features list.
    ' Description			:	Here list of features available to te current user is displayed.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 8 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotTaskListGrid()
        Dim strSQL As String
        Dim objDr As IDataReader

        strSQL = "usp_Sel_tbl_PM_TaskDelegation 'PM'," + m_strRoleID.Trim + "," + m_strProjectID.Trim + "," + m_strEmployeeID.Trim + ",0"

        'plot the table 
        'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
        ''dhn
        ''General.WriteHTML("<Div id='DivList' width=99.9% height=90% style='overflow: auto;'>")
        General.WriteHTML("<Div id='DivList' width=99.9% style='overflow: auto;'>")
        ''dhn
        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

        'display column headers
        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_ACCESSIBLE_COMPONENTS") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_CORPORATE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_DELEGATE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_ACCESS") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_ACCESS_DETAILS") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_RESTORE_RIGHTS") + "</TD>")

        'Integrated By MrugajaB on 14 Mar 2005 for WhizibleSEM SP2 Issue ID.16639
        'Added by DipaliS_23122004
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_TAB_ACCESS") + "</TD>")
        'End Addition by DipaliS_23122004

        General.WriteHTML("</TR>")

        'call recursive method to plot the rows for parent tag and subtags
        Dim intNodes As Integer
        intNodes = 0
        Call plotRowForTags(0, 0, intNodes)

        If intNodes <= 0 Then
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='center'>" + MyBase.GetResourceString("NODATAFOUND") + "</TD>")
            General.WriteHTML("</TR>")
        End If

        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

        'save the record count in the hidden control
        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        General.WriteHTML(HTMLControls.DrawTextBox("txthdRowCount", "txthdRowCount", , , , intNodes.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        '''End of Modification by Dhanashri S on 7 Oct 2015

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotRowForTags
    ' Parameters Passed		:	lngParentTagID  - Long - parent tag id for which sub tags are to be displayed
    ' Returns				:	String     - quama seperated list of chield Node Tag IDs
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the rows for the Tags.
    ' Description			:	This procedure will plot the rows for the Tags and subtags for the given parentTagID.
    '                           This procedure will call itself recursively. It will call recursively untill
    '                           there are parent Tags present.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 8 2004
    ' Revisions				:	
    '=====================================================================
    Private Function plotRowForTags(ByVal lngParentTagID As Long, ByVal intLevel As Integer, ByRef intNodeCounter As Integer) As String
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim blnIsParentTag As Boolean
        Dim lngTagID As Long
        Dim strCorporate_NodeAccess As String
        Dim strDelegated_NodeAccess As String
        Dim blnUseDelegatedNodeAccess As Boolean
        Dim intParentNodeCtrValue As Integer
        Dim strChildNodesList As String
        Dim blnCheckBoxChecked As Boolean
        Dim blnCheckBoxDisable As Boolean

        blnUseDelegatedNodeAccess = False
        intParentNodeCtrValue = intNodeCounter - 1
        strChildNodesList = ","

        strSQL = "usp_Sel_tbl_PM_TaskDelegation 'PM'," + m_strDelegatorRoleID.Trim + "," + m_strProjectID.Trim + "," + m_strEmployeeID.Trim + "," + lngParentTagID.ToString
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDr.Read

            lngTagID = CType(Data.CheckIsDBNull(objDr("TagID"), "0"), Long)

            ' Retrieve the node level access rights granted at corporate level.	
            strCorporate_NodeAccess = ""
            If CType(Data.CheckIsDBNull(objDr("Corporate_A"), "0").ToString, Boolean) = True Then strCorporate_NodeAccess += "1" Else strCorporate_NodeAccess += "0"
            If CType(Data.CheckIsDBNull(objDr("Corporate_D"), "0").ToString, Boolean) = True Then strCorporate_NodeAccess += ",1" Else strCorporate_NodeAccess += ",0"
            If CType(Data.CheckIsDBNull(objDr("Corporate_E"), "0").ToString, Boolean) = True Then strCorporate_NodeAccess += ",1" Else strCorporate_NodeAccess += ",0"
            If CType(Data.CheckIsDBNull(objDr("Corporate_V"), "0").ToString, Boolean) = True Then strCorporate_NodeAccess += ",1" Else strCorporate_NodeAccess += ",0"

            ' Retrieve the node level access rights delegated to the user.	
            strDelegated_NodeAccess = ""
            If CType(Data.CheckIsDBNull(objDr("Delegated_A"), "0").ToString, Boolean) = True Then strDelegated_NodeAccess += "1" Else strDelegated_NodeAccess += "0"
            If CType(Data.CheckIsDBNull(objDr("Delegated_D"), "0").ToString, Boolean) = True Then strDelegated_NodeAccess += ",1" Else strDelegated_NodeAccess += ",0"
            If CType(Data.CheckIsDBNull(objDr("Delegated_E"), "0").ToString, Boolean) = True Then strDelegated_NodeAccess += ",1" Else strDelegated_NodeAccess += ",0"
            If CType(Data.CheckIsDBNull(objDr("Delegated_V"), "0").ToString, Boolean) = True Then strDelegated_NodeAccess += ",1" Else strDelegated_NodeAccess += ",0"

            If Not IsDBNull(objDr("Delegated_A")) Then
                blnUseDelegatedNodeAccess = True
            Else
                blnUseDelegatedNodeAccess = False
            End If

            blnIsParentTag = CType(Data.CheckIsDBNull(objDr("IsParent"), "0"), Boolean)
            blnCheckBoxChecked = False
            blnCheckBoxDisable = False
            If CType(Data.CheckIsDBNull(objDr("CorporateRights"), "0"), Boolean) = True Or CType(Data.CheckIsDBNull(objDr("DelegatedRights"), "0"), Boolean) = True Then
                blnCheckBoxChecked = True
            End If
            If CType(Data.CheckIsDBNull(objDr("CorporateRights"), "0"), Boolean) = True Then
                blnCheckBoxDisable = True
            End If

            'set the class for the TR and plot the TR
            If intNodeCounter Mod 2 = 0 Then
                General.WriteHTML("<TR class='clsTROdd'>")
            Else
                General.WriteHTML("<TR class='clsTREven'>")
            End If

            'if the tag is parent tag then display only Tag desc.
            If blnIsParentTag = True Then
                General.WriteHTML("<TD align='left' colspan=3 ><B>")
                Dim i As Integer
                For i = 0 To intLevel
                    General.WriteHTML("&nbsp;&nbsp;&nbsp;")
                Next
                General.WriteHTML(Data.CheckIsDBNull(objDr("TagDescription"), "").ToString)
                General.WriteHTML("</B></TD>")
                'Integrated By MrugajaB  on 14 Mar 2005 for WhizibleSEM SP2 Issue ID.16639
                'Commented by DipaliS_23122004
                'General.WriteHTML("<TD align='center' colspan=3>")
                'Integrated By MrugajaB  on 14 Mar 2005 for WhizibleSEM SP2 Issue ID.16639
                'Added by DipaliS_23122004
                General.WriteHTML("<TD align='center' colspan=4>")
                'End Addition by DipaliS_23122004

                General.WriteHTML(HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnCheckBoxChecked, lngTagID.ToString, blnCheckBoxDisable, " onpropertychange='javascript:SetParentAccess(" + intNodeCounter.ToString + "," + intParentNodeCtrValue.ToString + ")'", True, , , , True))
                General.WriteHTML("</TD>")
            Else
                General.WriteHTML("<TD align='left' >")
                Dim i As Integer
                For i = 0 To intLevel
                    General.WriteHTML("&nbsp;&nbsp;&nbsp;")
                Next
                General.WriteHTML(Data.CheckIsDBNull(objDr("TagDescription"), "").ToString)
                General.WriteHTML("</TD>")

                If CType(Data.CheckIsDBNull(objDr("CorporateRights"), "0"), Boolean) = True Then
                    General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("YES") + "</B></TD>")
                Else
                    General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("NO") + "</TD>")
                End If
                If CType(Data.CheckIsDBNull(objDr("DelegatedRights"), "0"), Boolean) = True Or blnUseDelegatedNodeAccess = True Then
                    General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("YES") + "</B></TD>")
                Else
                    General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("NO") + "</TD>")
                End If

                'If CType(Data.CheckIsDBNull(objDr("CorporateRights"), "0"), Boolean) = True Or CType(Data.CheckIsDBNull(objDr("DelegatedRights"), "0"), Boolean) = True Then
                '    blnCheckBoxChecked = True
                'End If
                'If CType(Data.CheckIsDBNull(objDr("CorporateRights"), "0"), Boolean) = True Then
                '    blnCheckBoxDisable = True
                'End If

                General.WriteHTML("<TD align='center'>")
                General.WriteHTML(HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnCheckBoxChecked, lngTagID.ToString, blnCheckBoxDisable, " onpropertychange='javascript:SetParentAccess(" + intNodeCounter.ToString + "," + intParentNodeCtrValue.ToString + ")'", True))
                General.WriteHTML("</TD>")

                General.WriteHTML("<TD align='left'>")
                General.WriteHTML("<A href='javascript:ModifyAccess_OnClick(" + lngTagID.ToString + "," + intNodeCounter.ToString + ")'>" + MyBase.GetResourceString("LINK_MODIFY_ACCESS") + "</A>")
                General.WriteHTML("</TD>")

                If CType(Data.CheckIsDBNull(objDr("DelegatedRights"), "0"), Boolean) = True Or blnUseDelegatedNodeAccess = True Then
                    General.WriteHTML("<TD align='left'>")
                    General.WriteHTML("<A href='javascript:Reset_OnClick(" + lngTagID.ToString + "," + intNodeCounter.ToString + "," + intParentNodeCtrValue.ToString + ")'>" + MyBase.GetResourceString("LINK_RESTORE_ACCESS") + "</A>")
                    General.WriteHTML("</TD>")
                Else
                    General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("NA") + "</TD>")
                End If

                'Integrated By MrugajaB  on 14 Mar 2005 for WhizibleSEM SP2 Issue ID.16639
                'Added by DipaliS_23122004
                If CType(CommonFunction.Data.CheckIsDBNull(objDr("HasSubTags"), "0"), Integer) > 0 And blnCheckBoxChecked = True Then
                    General.WriteHTML("<TD align='left'>")
                    General.WriteHTML("<A href='javascript:TabAccess_OnClick(" + lngTagID.ToString + "," + intNodeCounter.ToString + ")'>" + MyBase.GetResourceString("LINK_TAB_ACCESS") + "</A>")
                    General.WriteHTML("</TD>")
                Else
                    General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("NA") + "</TD>")
                End If
                'End addition by DipaliS_23122004

            End If

            General.WriteHTML("</TR>")

            'plot the hidden controls to keep the values
            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            General.WriteHTML(HTMLControls.DrawTextBox("txtTagID", "txtTagID", , , , Data.CheckIsDBNull(objDr("TagID"), "0").ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtNodeAccessModified" + lngTagID.ToString, "txtNodeAccessModified" + lngTagID.ToString, , , , "0", , , , , , True, , True, EnableHTMLEncode:=True))
            '''End of Modification by Dhanashri S on 7 Oct 2015

            If blnUseDelegatedNodeAccess = True Then
                '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                General.WriteHTML(HTMLControls.DrawTextBox("txtNodeAccess" + lngTagID.ToString, "txtNodeAccess" + lngTagID.ToString, , , , strDelegated_NodeAccess.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            Else
                General.WriteHTML(HTMLControls.DrawTextBox("txtNodeAccess" + lngTagID.ToString, "txtNodeAccess" + lngTagID.ToString, , , , strCorporate_NodeAccess.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
                '''End of Modification by Dhanashri S on 7 Oct 2015
            End If

            strChildNodesList += intNodeCounter.ToString + ","
            intNodeCounter += 1

            If blnIsParentTag = True Then
                Dim strTempChildNodeList As String
                Dim intCurrentParent As Integer
                intCurrentParent = intNodeCounter - 1

                'give recursive call to the procedure as this is parent Tag and its subtags
                'are to plotted
                strTempChildNodeList = plotRowForTags(lngTagID, intLevel + 1, intNodeCounter)

                '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                General.WriteHTML(HTMLControls.DrawTextBox("txtChildNodesList" + intCurrentParent.ToString, "txtChildNodesList" + intCurrentParent.ToString, , , , strTempChildNodeList.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
                '''End of Modification by Dhanashri S on 7 Oct 2015
            End If

        End While
        Data.DisposeDataReader(objDr)

        plotRowForTags = strChildNodesList
    End Function

    '=====================================================================
    ' Procedure Name		:	performAccessAction
    ' Parameters Passed		:	None
    ' Returns				:	None
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data.
    ' Description			:	This procedure will update the data for the Task access. Data updation is 
    '                           done based on the action variable.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 9 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performAccessAction()
        Dim strSQL As String
        Dim strTagToBeResetID As String
        Dim strTagIDs As String
        Dim strAccessRights As String
        Dim strNodeAccess As String
        Dim arrTagID() As String
        Dim strTagID As String
        Dim intNodeCount As Integer

        Select Case m_strAction
            Case CONST_ACTION_RESTORE
                'If all the access rights are to be reset to the corporate level
                strSQL = "usp_Del_tbl_PM_TaskDelegation " + m_strProjectID.Trim + "," + m_strEmployeeID.Trim
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            Case CONST_ACTION_SAVE
                Dim i As Integer

                strTagToBeResetID = Request.QueryString("TagToBeReset") + ""
                strTagIDs = MyBase.GetFormValue("chkAccess") + ""
                strAccessRights = ","

                'First insert the list of TagIDs to give the access to he tags.	
                'Here create the quama seperated list of tag IDs
                If strTagIDs <> "" Then
                    arrTagID = Split(strTagIDs, ",")
                    For i = 0 To arrTagID.Length - 1
                        If arrTagID(i).Trim <> "" Then
                            If strTagToBeResetID <> arrTagID(i).Trim Then
                                strAccessRights += arrTagID(i).Trim + ","
                            End If
                        End If
                    Next
                End If

                strSQL = "usp_Ins_tbl_PM_TaskDelegation " + m_strProjectID.Trim + "," + m_strEmployeeID.Trim + ",'" + strAccessRights.Trim + "'"
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                strTagIDs = MyBase.GetFormValue("txtTagID") + ""

                'Then insert the individual access rights into the table. 
                'Delete the rest of the data, when the access rights are removed.
                If strTagIDs <> "" Then
                    arrTagID = Split(strTagIDs, ",")
                    For i = 0 To arrTagID.Length - 1
                        strTagID = arrTagID(i).Trim
                        If strTagID <> "" Then
                            If MyBase.GetFormValue("txtNodeAccessModified" + strTagID.Trim) = "1" Then
                                strNodeAccess = MyBase.GetFormValue("txtNodeAccess" + strTagID.Trim) + ""
                                strSQL = "usp_Ins_tbl_PM_TaskDelegation_Details " + strTagID.Trim + "," + m_strProjectID.Trim + "," + m_strEmployeeID.Trim + "," + strNodeAccess.Trim
                                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                            End If
                        End If
                    Next
                End If
                'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                'Added By NileshD on 13 Sep 2005 REQID - WAF3_PB_8
                Dim strRole As String
                'strRole = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT Role FROM tbl_PM_ProjectEmployeeRole WHERE ProjectID = " + m_strProjectID.Trim + " AND EmployeeID=" + m_strEmployeeID.Trim, MyBase.UseSQL), "0")
                strRole = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " + m_strProjectID.Trim + "," + m_strEmployeeID.Trim, MyBase.UseSQL), "0")
                CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'T','PM'," + strRole + "," + m_strEmployeeID + "," + m_strProjectID)
                'End OF Addition By NileshD on 13 Sep 2005 REQID - WAF3_PB_8
                'End Of Modifications - IssueID : 672
        End Select
        '' START : Integrated By ParagD On 6-Oct-2006
        '           w.r.t. IssueID #7105
        'Added by TruptiK
        CommonEngines.HashTables.GetHashTableObject.ClearRoleHashTable()
        'End of addition by TruptiK
        '' END : Integrated By ParagD On 6-Oct-2006
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotSingleTagAccess
    ' Parameters Passed		:	strTaskID   - String 
    ' Returns				:	None
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the screen for the single node access mode.
    ' Description			:	Here node access of the Task for the given task ID,employee ID and current 
    '                           project are taken from the database.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 9 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotSingleTagAccess(ByVal strTaskID As String)
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strNodeAccess As String
        Dim arrAccess() As String
        Dim blnAdd As Boolean
        Dim blnDelete As Boolean
        Dim blnEdit As Boolean
        Dim blnView As Boolean

        'get the node access for th task fromthe query string, This is stored 
        strNodeAccess = Request.QueryString("NodeAccess") + ""
        arrAccess = Split(strNodeAccess, ",")

        If arrAccess(0).Trim = "1" Then blnAdd = True Else blnAdd = False
        If arrAccess(1).Trim = "1" Then blnDelete = True Else blnDelete = False
        If arrAccess(2).Trim = "1" Then blnEdit = True Else blnEdit = False
        If arrAccess(3).Trim = "1" Then blnView = True Else blnView = False

        'plot the table 
        General.WriteHTML("<Div id='DivList' width=100% height=90% style='overflow: auto;'>")
        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_ADD") + "</TD>")
        General.WriteHTML("<TD align='left'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkAdd", "chkAdd", , blnAdd, "1", , , True))
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_DELETE") + "</TD>")
        General.WriteHTML("<TD align='left'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , blnDelete, "1", , , True))
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_EDIT") + "</TD>")
        General.WriteHTML("<TD align='left'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnEdit, "1", , , True))
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_VIEW") + "</TD>")
        General.WriteHTML("<TD align='left'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkView", "chkView", , blnView, "1", , , True))
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        General.WriteHTML(HTMLControls.DrawTextBox("txtOldNodeAccess", "txtOldNodeAccess", , , , strNodeAccess, , , , , , True, , True, EnableHTMLEncode:=True))
        '''End of Modification by Dhanashri S on 7 Oct 2015 

    End Sub

    '=====================================================================
    ' Procedure Name		:	performSingleNodeAction
    ' Parameters Passed		:	strTaskID   - String    - task id whose access are to be set
    ' Returns				:	None
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data.
    ' Description			:	Here data base is updated for the access rights of the Task for the employee
    '                           whose ids are given for the current project.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 9 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performSingleNodeAction(ByVal strTaskID As String)
        Dim strSQL As String
        Dim strNodeAccess As String
        Dim strOldNodeAccess As String

        'get the old access of the task stored in the hidden control
        strOldNodeAccess = MyBase.GetFormValue("txtOldNodeAccess") + ""

        ''first inser the access record for the tag
        'strSQL = "usp_Ins_tbl_PM_TaskDelegation " + m_strProjectID.Trim + "," + m_strEmployeeID.Trim + ",'" + strTaskID.Trim + "'"
        'Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        If MyBase.GetFormValue("chkAdd") <> "" Then
            strNodeAccess = "1"
        Else
            strNodeAccess = "0"
        End If
        If MyBase.GetFormValue("chkDelete") <> "" Then
            strNodeAccess += ",1"
        Else
            strNodeAccess += ",0"
        End If
        If MyBase.GetFormValue("chkEdit") <> "" Then
            strNodeAccess += ",1"
        Else
            strNodeAccess += ",0"
        End If
        If MyBase.GetFormValue("chkView") <> "" Then
            strNodeAccess += ",1"
        Else
            strNodeAccess += ",0"
        End If

        'If strOldNodeAccess <> strNodeAccess Then
        'strSQL = "usp_Ins_tbl_PM_TaskDelegation_Details " + strTaskID.Trim + "," + m_strProjectID.Trim + "," + m_strEmployeeID.Trim + "," + strNodeAccess.Trim
        'Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        'End If

    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
    ''Added by Yogesh Jalamkar  on 02 AUG 2016 to validate Token	
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_RestoreAllOnclick(EmployeeID As String, Employee_ID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(Employee_ID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 02 AUG 2016
End Class
