Imports CommonFunctions
'Code Added by SwatiC on 6 Jun 2007 For IssueID : 12859
Imports WebPages.Security
Imports WebPages.Template
'End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12859
Public Class PRO_SDLCProcess
    Inherits WebPages.Template.WhizTemplate

    Protected CONST_PROCESS_INFO As String = "PROCESS"
    Protected CONST_ACTION_SAVE As String = "SAVE"
    Protected CONST_ACTIVITY_INFO As String = "ADD_NEW"
    Protected CONST_EDIT_ACTIVITY As String = "EDITACTIVITY"
    Protected CONST_REVISION_REASON As String = "REASON"
    Protected CONST_SHOW_DETAILS As String = "DETAILS"
    Protected CONST_SHOW_TEMPLATE As String = "TEMPLATE"

    Protected m_strMode As String
    Protected m_strAction As String
    Protected m_lngProcessID As Long = 0
    Protected m_lngProjectID As Long = 0
    Protected m_lngActivityID As Long = 0
    Protected m_strWindowTitle As String
    Private WithEvents objGridActivityDetails As WebPage.Templates.GenericGrid

    'Code added by SwatiC on 6 Jun 2007 For IssueID : 12856
    Private m_objAccessRights As cAccessRights
    Private m_objGlobal As IGlobal
    Private WithEvents m_objGrid As WebPage.Templates.GenericGrid
    'End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12856


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
        If Request.QueryString("Mode") = CONST_ACTIVITY_INFO Then
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_ACTIVITY")
        ElseIf Request.QueryString("Mode") = CONST_SHOW_DETAILS Then
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_DETAILS")
        ElseIf Request.QueryString("Mode") = CONST_EDIT_ACTIVITY Then
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_EDIT_ACTIVITY")
        ElseIf Request.QueryString("Mode") = CONST_REVISION_REASON Then
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_REVISION")
        Else
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_SDLC_PROC")
        End If

    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.PRO_SDLCProcess", "AppResources")
    End Sub
    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception
        ex.Source = "SDLCProcess->InvalidInput"
        Throw ex
    End Sub


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
    ' Created				:	Jan 29 2004
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
        Dim strProcessName As String
        Dim strTemplateFileName As String
        Dim lngTemplateID As Long
        Dim strRevisionReason As String
        Dim strUserName As String

        'Code added by SwatiC on 6 Jun 2007 For IssueID : 12856
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objGlobal.TagID = 2022
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)

        m_objAccessRights.GetAccess()
        'End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12856

        'get the values from the queryString
        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_PROCESS_INFO 'default mode
        m_strAction = Request.QueryString("Action") + ""
        If Request.QueryString("ProcessID") <> "" Then
            m_lngProcessID = CType(Request.QueryString("ProcessID"), Long)
        End If
        If Session("intProjectID").ToString <> "" Then
            m_lngProjectID = CType(Session("intProjectID"), Long)
        End If
        If Request.QueryString("ActivityID") <> "" Then
            m_lngActivityID = CType(Request.QueryString("ActivityID"), Long)
        End If

        ''TODO : get it form the query string
        'If m_lngProcessID <= 0 Then m_lngProcessID = 130
        'If m_lngProjectID <= 0 Then m_lngProjectID = 279
        'If m_strMode = "" Then m_strMode = CONST_PROCESS_INFO

        Select Case (m_strMode.ToUpper)

            Case CONST_PROCESS_INFO, CONST_SHOW_TEMPLATE

                If m_strAction.ToUpper = CONST_ACTION_SAVE Then
                    Call performProcessInfoAction()
                End If

                'if user clicked on the template then show the template file in new window, template filename
                'is taken from the database and then open it.
                If m_strMode.ToUpper = CONST_SHOW_TEMPLATE Then
                    lngTemplateID = CType(Request.QueryString("TemplateID"), Long)

                    'This function is not used, instead CommonFunction.General.funcReturnOriginalFileName is used
                    'strTemplateFileName = getTemplateFileName(lngTemplateID)
                    strTemplateFileName = CommonFunction.General.funcReturnOriginalFileName("TPT", lngTemplateID)

                    General.WriteHTML("<script language=javascript >")
                    General.WriteHTML("window.open('../General/ViewAttachment.aspx?FromWhere=TPT&FileName=" + strTemplateFileName.Trim + "','pp','MENUBAR=no,TITLEBAR=yes,TOOLBAR=no,RESIZABLE=yes');")
                    General.WriteHTML("</script>")

                    m_strMode = CONST_PROCESS_INFO
                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                'if there is any activity not assigned to project then only show add new link
                strSQL = "usp_Sel_Activities_Not_Assigned_To_Project " + m_lngProjectID.ToString + "," + m_lngProcessID.ToString
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDR.Read Then
                    'Code added by SwatiC on 6 Jun 2007 For IssueID : 12856
                    If m_objAccessRights.Add Then
                        'End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12856
                        arrMenu.Add(MyBase.GetResourceString("MENU_ADDNEW")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP")) : arrClientSideFunctions.Add("AddNew_OnClick()")
                        'Code added by SwatiC on 6 Jun 2007 For IssueID : 12856
                    End If
                    'End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12856
                End If
                objDR.Close()
                objDR.Dispose()
                objDR = Nothing
                'Code added by SwatiC on 6 Jun 2007 For IssueID : 12856
                If m_objAccessRights.Edit Then
                    'End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12856
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
                End If
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('SDLCProcess')")

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
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                'draw upper menu
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                'initialize the resource file for SDLC_Process page.
                MyBase.InitializeResources("AppResources.PRO_SDLCProcess", "AppResources")

                'get the process name and display
                strProcessName = ""
                strSQL = "usp_sel_SDLCProcess_Information 3," + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + ",NULL"
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDR.Read Then
                    If Not IsDBNull(objDR("ProcessName")) Then
                        strProcessName = objDR("ProcessName").ToString + ""
                    End If
                End If
                objDR.Close()
                objDR.Dispose()
                objDR = Nothing

                'draw page caption with entity name
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_SDLC_PRO") + " : " + strProcessName.Trim)
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_SDLC_PRO") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the grid
                Call plotGridForProcess(m_lngProcessID, m_lngProjectID)

            Case CONST_ACTIVITY_INFO

                    If m_strAction.ToUpper = CONST_ACTION_SAVE Then
                        Call performActivityInfoAction()

                        'refresh parent
                        General.WriteHTML("<Script language=javascript>")
                        General.WriteHTML("opener.location.reload();")
                        General.WriteHTML("</Script>")
                    End If

                    'initialize the resource file for standard menu.
                    MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                    arrMenu = New System.Collections.ArrayList
                    arrMenuToolTip = New System.Collections.ArrayList
                    arrClientSideFunctions = New System.Collections.ArrayList

                    'if there is any activity not assigned to project then only show add new link
                    strSQL = "usp_Sel_Activities_Not_Assigned_To_Project " + m_lngProjectID.ToString + "," + m_lngProcessID.ToString
                    objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If objDR.Read Then
                        arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("ActivitySave_OnClick()")
                        arrMenu.Add(MyBase.GetResourceString("MENU_SELECTALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")) : arrClientSideFunctions.Add("SelectAll_OnClick()")
                        arrMenu.Add(MyBase.GetResourceString("MENU_CLEARALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP")) : arrClientSideFunctions.Add("ClearAll_OnClick()")
                    End If
                    objDR.Close()
                    objDR.Dispose()
                    objDR = Nothing
                    arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('SDLCProcess')")

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
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                    'draw upper menu
                    General.WriteHTML(strMenu)
                    General.WriteHTML("<BR>")

                    'initialize the resource file for SDLC_Process page.
                    MyBase.InitializeResources("AppResources.PRO_SDLCProcess", "AppResources")

                    'get the process name and display
                    strProcessName = ""
                    strSQL = "usp_sel_SDLCProcess_Information 3," + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + ",NULL"
                    objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If objDR.Read Then
                        If Not IsDBNull(objDR("ProcessName")) Then
                            strProcessName = objDR("ProcessName").ToString + ""
                        End If
                    End If
                    objDR.Close()
                    objDR.Dispose()
                    objDR = Nothing

                    'draw page caption with entity name
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_ACTIVITY") + " : " + strProcessName.Trim)
                    General.WriteHTML("<BR>")

                    ''draw page description
                    'objHeader = New WebPage.Templates.HeaderFooter
                    'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_ACTIVITY") + ""
                    'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                    'General.WriteHTML("<BR>")
                    'objHeader = Nothing

                    'plot the grid for activity list
                    Call plotGridOfActivities(m_lngProcessID, m_lngProjectID)

            Case CONST_EDIT_ACTIVITY

                    If m_strAction.ToUpper = CONST_ACTION_SAVE Then
                        Call performEditActivityAction()
                    End If

                    'initialize the resource file for standard menu.
                    MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                    arrMenu = New System.Collections.ArrayList
                    arrMenuToolTip = New System.Collections.ArrayList
                    arrClientSideFunctions = New System.Collections.ArrayList

                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("ActivityEditSave_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE_WITH_REVISION")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_WITH_REVISION_TOOLTIP")) : arrClientSideFunctions.Add("SaveWithRevision_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_BACK")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP")) : arrClientSideFunctions.Add("Back_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('SDLCProcess')")

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
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                    'draw upper menu
                    General.WriteHTML(strMenu)
                    General.WriteHTML("<BR>")

                    'initialize the resource file for SDLC_Process page.
                    MyBase.InitializeResources("AppResources.PRO_SDLCProcess", "AppResources")

                    'get the process name and display
                    strProcessName = ""
                    'strSQL = "usp_sel_SDLCProcess_Information 3," + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + ",NULL"
                    'objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                    'If objDR.Read Then
                    '    If Not IsDBNull(objDR("ProcessName")) Then
                    '        strProcessName = objDR("ProcessName").ToString + ""
                    '    End If
                    'End If
                    'objDR.Close()
                    'objDR.Dispose()
                    'objDR = Nothing

                    'draw page caption with entity name
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_EDIT_ACTIVITY"))
                    General.WriteHTML("<BR>")

                    ''draw page description
                    'objHeader = New WebPage.Templates.HeaderFooter
                    'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_EDIT_ACTIVITY") + ""
                    'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                    'General.WriteHTML("<BR>")
                    'objHeader = Nothing

                    'plot the grid for activity list
                    Call plotScreenToEditActivity(m_lngProcessID, m_lngProjectID, m_lngActivityID)

            Case CONST_REVISION_REASON

                    If m_strAction.ToUpper = CONST_ACTION_SAVE Then
                        'if it saved with revision then get the reason text from the textbox
                        'and save it
                        strUserName = Session("strUserName").ToString + ""
                        strRevisionReason = General.BuildQueryString(MyBase.GetFormValue("txtRevisionReason") + "") + ""
                        If strRevisionReason <> "" Then
                            strSQL = "usp_ins_Save_Revisions 1," + m_lngProjectID.ToString + ",'" + General.BuildQueryString(strUserName.Trim) + "','" + General.BuildQueryString(strRevisionReason.Trim) + "'"
                            Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                        End If

                        'write client side script to submit the parent to save to activity info
                        'strRevisionReason is used for temporary purpose.
                        strRevisionReason = "PRO_SDLCProcess.aspx?Mode=" + CONST_EDIT_ACTIVITY + "&Action=" + CONST_ACTION_SAVE + "&ProcessID=" + m_lngProcessID.ToString + "&ProjectID=" + m_lngProjectID.ToString + "&ActivityID=" + m_lngActivityID.ToString
                        General.WriteHTML("<script language=javascript>")
                        General.WriteHTML("refreshParent('frmSDLCProcess','PRO_SDLCProcess.aspx','" + strRevisionReason.Trim + "')")
                        General.WriteHTML("window.close();")
                        General.WriteHTML("</Script>")
                    End If

                    'initialize the resource file for standard menu.
                    MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                    arrMenu = New System.Collections.ArrayList
                    arrMenuToolTip = New System.Collections.ArrayList
                    arrClientSideFunctions = New System.Collections.ArrayList

                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("RevisionSave_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('SDLCProcess')")

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
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                    'draw upper menu
                    General.WriteHTML(strMenu)
                    General.WriteHTML("<BR>")

                    'initialize the resource file for SDLC_Process page.
                    MyBase.InitializeResources("AppResources.PRO_SDLCProcess", "AppResources")

                    'plot the grid for activity list
                    Call plotReasonForRevisionScreen()

            Case CONST_SHOW_DETAILS

                    'initialize the resource file for standard menu.
                    MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                    arrMenu = New System.Collections.ArrayList
                    arrMenuToolTip = New System.Collections.ArrayList
                    arrClientSideFunctions = New System.Collections.ArrayList

                    arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('SDLCProcess')")

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
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                    'draw upper menu
                    General.WriteHTML(strMenu)
                    General.WriteHTML("<BR>")

                    'initialize the resource file for SDLC_Process page.
                    MyBase.InitializeResources("AppResources.PRO_SDLCProcess", "AppResources")

                    'get the process name and display
                    strProcessName = ""
                    strSQL = "usp_sel_SDLCProcess_Information 3," + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + ",NULL"
                    objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If objDR.Read Then
                        If Not IsDBNull(objDR("ProcessName")) Then
                            strProcessName = objDR("ProcessName").ToString + ""
                        End If
                    End If
                    objDR.Close()
                    objDR.Dispose()
                    objDR = Nothing

                    'draw page caption with entity name
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_DETAILS") + " : " + strProcessName.Trim)
                    General.WriteHTML("<BR>")

                    ''draw page description
                    'objHeader = New WebPage.Templates.HeaderFooter
                    'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_DETAILS") + ""
                    'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                    'General.WriteHTML("<BR>")
                    'objHeader = Nothing

                    'plot the grid for activity list
                    General.WriteHTML("<Div id='DivList' width=100% height=90% style='Overflow: auto;' >")
                    Call showActivityDetailsScreen(m_lngProcessID, m_lngProjectID, m_lngActivityID)
                    General.WriteHTML("</Div>")

            Case Else
        End Select

        'draw lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)
        m_objGlobal = Nothing

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotGridForProcess
    ' Parameters Passed		:	lngProcessID - Long
    '                           lngProjectID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw the grid for the activity information
    ' Description			:	This procedure will plot the grid for the activity information of the process
    '                           for the project ID.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 29 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotGridForProcess(ByVal lngProcessID As Long, ByVal lngProjectID As Long)
        Dim strSql As String
        ' 'Code added by SwatiC on 6 Jun 2007 For IssueID : 12856
        'Dim objGrid As WebPage.Templates.GenericGrid
        ' End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12856
        Dim arrColHeader() As String = {MyBase.GetResourceString("COL_ACTIVITY"), MyBase.GetResourceString("COL_TAILORING"), MyBase.GetResourceString("COL_DEVIATION"), MyBase.GetResourceString("COL_APPLICABLE_TEMPLATE"), MyBase.GetResourceString("COL_APPLICABLE_CHECKLIST"), MyBase.GetResourceString("COL_REQUIRED"), MyBase.GetResourceString("COL_IS_PERFORMED"), MyBase.GetResourceString("COL_DETAILS")}
        Dim arrAN() As String = {"Title", "Tailoring", "Deviation", "TemplateList", "CheckList", "", "", MyBase.GetResourceString("COL_DETAILS_LINK")}
        Dim arrRowLink() As String = {"Activity_OnClick(ActivityID)", "", "", "", "", "", "", "ShowDetails_OnClick(ActivityID)"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "chkIsRequired", "chkIsPerformed", ""}
        Dim arrCheckBoxCheck() As String = {"", "", "", "", "", "IsRequired", "IsPerformed", ""}
        Dim arrTDStyle() As String = {"align='left'", "align='center'", "align='center'", "align='center'", "align='center'", "align='center'", "align='center'", "align='center'"}
        Dim arrLink() As String = {"IsRequired", "", "", "", "", "", "", ""}
        Dim arrIgnoreHTML() As String = {"0", "0", "0", "1", "1", "0", "0", "0"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '' Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'create the SP for grid data without sorting 
        strSql = "usp_sel_ActivityList_ForProcessNProject " + lngProcessID.ToString + "," + lngProjectID.ToString + ",'" + MyBase.GetResourceString("YES") + "','" + MyBase.GetResourceString("NO") + "'"

        'create Grid object and set the properties
        m_objGrid = New WebPage.Templates.GenericGrid

        m_objGrid.ActualColumnArray = arrAN
        m_objGrid.UserFriendlyColumnArray = arrColHeader
        m_objGrid.RowLinkArray = arrRowLink
        m_objGrid.IgnoreHTMLEncode = arrIgnoreHTML
        m_objGrid.RowLinkEnableOnColumn = arrLink
        m_objGrid.CheckBoxIDArray = arrCheckBox
        m_objGrid.CheckboxCheckOnColumnArray = arrCheckBoxCheck
        m_objGrid.TDStyleArray = arrTDStyle
        m_objGrid.PrimaryKey = "ActivityID"
        m_objGrid.DIVID = "DivList"
        m_objGrid.DIVHeight = 400
        m_objGrid.DIVStyle = "overflow: auto"
        m_objGrid.NoOfDataColumns = 5
        m_objGrid.PrinterFriendlyVersion = False
        m_objGrid.VerticalDisplay = False
        m_objGrid.ColNameToolTipOnEachRow = True
        m_objGrid.returnHTML = False
        m_objGrid.EmptyValueReplacement = "-"
        m_objGrid.SQL = strSql
        m_objGrid.UseSQL = MyBase.UseSQL
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        m_objGrid.IgnoreHTMLEncode = arrIgnoreHtml
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'plot the grid 
        m_objGrid.DrawGrid()

        m_objGrid = Nothing
    End Sub

    '=====================================================================
    ' Procedure Name		:	performProcessInfoAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data for the process and activity info.
    ' Description			:	same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 30 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performProcessInfoAction()
        Dim strSQL As String
        Dim arrChk() As String
        Dim strIsRequired As String
        Dim strIsPerformed As String

        Select Case m_strAction
            Case CONST_ACTION_SAVE

                'get the activity ids to update the isRequired property.
                strIsRequired = MyBase.GetFormValue("chkIsRequired") + ""
                If strIsRequired <> "" Then

                    arrChk = Split(strIsRequired, ",")
                    Dim i As Integer
                    For i = 0 To arrChk.Length - 1

                        strSQL = "EXEC usp_sel_SDLCProcess_Information 7," + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + "," + arrChk(i).Trim
                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                    Next
                    arrChk = Nothing
                End If


                'get the activity ids to update the Isperformed property
                strIsPerformed = MyBase.GetFormValue("chkIsPerformed") + ""
                If strIsPerformed <> "" Then

                    arrChk = Split(strIsPerformed, ",")
                    Dim i As Integer
                    For i = 0 To arrChk.Length - 1

                        strSQL = "EXEC usp_sel_SDLCProcess_Information 9," + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + "," + arrChk(i).Trim
                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                    Next

                End If

                strSQL = "EXEC usp_upd_SDLCProcess " + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + ",'" + strIsRequired.Trim + "','" + strIsPerformed.Trim + "'"
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            Case Else
        End Select
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotGridOfActivities
    ' Parameters Passed		:	lngProcessID - Long
    '                           lngProjectID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the grid of the activities for the given process id and project id.
    ' Description			:	same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 30 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotGridOfActivities(ByVal lngProcessID As Long, ByVal lngProjectID As Long)
        Dim strSql As String
        Dim objGrid As WebPage.Templates.GenericGrid

        Dim arrColHeader() As String = {MyBase.GetResourceString("COL_PROCESS_ACTIVITY"), MyBase.GetResourceString("COL_SELECT")}
        Dim arrAN() As String = {"Title", ""}
        Dim arrRowLink() As String = {"", ""}
        Dim arrCheckBox() As String = {"", "chkSelect"}
        Dim arrCheckBoxCheck() As String = {"", ""}
        Dim arrTDStyle() As String = {"align='left'", "align='center'"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'create the SP for grid data without sorting 
        strSql = "EXEC usp_Sel_Activities_Not_Assigned_To_Project " + lngProjectID.ToString + "," + lngProcessID.ToString

        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid

        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.RowLinkArray = arrRowLink
        objGrid.CheckBoxIDArray = arrCheckBox
        objGrid.CheckboxCheckOnColumnArray = arrCheckBoxCheck
        objGrid.TDStyleArray = arrTDStyle
        objGrid.PrimaryKey = "ActivityID"
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 400
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = 1
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = strSql
        objGrid.UseSQL = MyBase.UseSQL
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHtml
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()

        'keep the row count in the hidden variable
        Dim i As Integer = 0
        i = objGrid.NoOfRows
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '' CommonFunctions.HTMLControls.DrawTextBox("hdtxtRowCount", "hdtxtRowCount", , , , i.ToString, , , , , , True)
        CommonFunctions.HTMLControls.DrawTextBox("hdtxtRowCount", "hdtxtRowCount", , , , i.ToString, , , , , , True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        objGrid = Nothing
    End Sub

    '=====================================================================
    ' Procedure Name		:	performActivityInfoAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data for the process and activity info.
    ' Description			:	same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 30 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performActivityInfoAction()
        Dim strSQL As String
        Dim strActivityIDList As String
        Dim arrActivityID() As String

        'get the selected Activity IDs
        strActivityIDList = MyBase.GetFormValue("chkSelect") + ""
        If strActivityIDList <> "" Then

            arrActivityID = Split(strActivityIDList, ",")
            Dim i As Integer
            For i = 0 To arrActivityID.Length - 1

                'Add the precess activity to the Project
                strSQL = "usp_Ins_tbl_PRS_Project_SDLC " + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + "," + arrActivityID(i).Trim
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Next

        End If
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotScreenToEditActivity
    ' Parameters Passed		:	lngProcessID - Long
    '                           lngProjectID - Long
    '                           lngActivityID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To get the data from the database about the activity for the process and project id
    '                           and plot the screen for edting the activity.
    ' Description			:	same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 30 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenToEditActivity(ByVal lngProcessID As Long, ByVal lngProjectID As Long, ByVal lngActivityID As Long)
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strActivityName As String = ""
        Dim strReferences As String = ""
        Dim strTailoringDesc As String = ""
        Dim strDeviationDesc As String = ""
        Dim lngReviewFrequency As Long = 0
        Dim blnReview As Boolean = False
        Dim strTemplateIDList As String
        Dim strChecklistIDList As String

        'get the activity name 
        strSQL = "usp_sel_SDLCProcess_Information 8,Null,Null," + lngActivityID.ToString
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            If Not IsDBNull(objDr("Title")) Then
                strActivityName = objDr("Title").ToString + ""
            End If
        End If
        objDr.Close()
        objDr.Dispose()
        objDr = Nothing

        'get the details of the activity 
        strSQL = "usp_sel_SDLCProcess_Information 1," + lngProjectID.ToString + "," + lngProcessID.ToString + "," + lngActivityID.ToString
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            If Not IsDBNull(objDr("Reference")) Then
                strReferences = objDr("Reference").ToString + ""
            End If
            If Not IsDBNull(objDr("Tailoring")) Then
                strTailoringDesc = objDr("Tailoring").ToString + ""
            End If
            If Not IsDBNull(objDr("Deviation")) Then
                strDeviationDesc = objDr("Deviation").ToString + ""
            End If
            If Not IsDBNull(objDr("ReviewActivity")) Then
                blnReview = CType(objDr("ReviewActivity"), Boolean)
            End If
            If Not IsDBNull(objDr("ReviewFrequency")) Then
                lngReviewFrequency = CType(objDr("ReviewFrequency"), Long)
            End If
        End If
        objDr.Close()
        objDr.Dispose()
        objDr = Nothing

        'modified by SachinR    On 29 Jun 2004
        'To implement SRS - PM_PBN_41_01
        'Following code is commented as it this list is not need now, two seperate listboxes are 
        'displayed to show selected and available templates/checklists
        ''create the quama seperated Template ID list for this activity for this project and process
        'strTemplateIDList = ""
        'strSQL = "usp_sel_SDLCProcess_Information 2," + lngProjectID.ToString + "," + lngProcessID.ToString + "," + lngActivityID.ToString
        'objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        'While objDr.Read
        '    strTemplateIDList += "," + objDr("TemplateID").ToString + ""
        'End While
        'strTemplateIDList += ","
        'objDr.Close()
        'objDr.Dispose()
        'objDr = Nothing

        ''create the quama seperated ChecklistId list for this activity for this project and process
        'strChecklistIDList = ""
        'strSQL = "usp_Sel_tbl_PRS_SDLC_Checklists " + lngProjectID.ToString + "," + lngProcessID.ToString + "," + lngActivityID.ToString
        'objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        'While objDr.Read
        '    strChecklistIDList += "," + objDr("ChecklistID").ToString + ""
        'End While
        'strChecklistIDList += ","
        'objDr.Close()
        'objDr.Dispose()
        'objDr = Nothing
        '**********************************************************************************************************
        'modification end 

        'plot the screen
        General.WriteHTML("<Div id='DivList' width=100% height=90% style='Overflow: auto;'>")
        General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0>")

        'display Activity Name
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=30% align='right'>" + MyBase.GetResourceString("CAP_ACTIVITY_NAME") + "&nbsp;</TD>")
        General.WriteHTML("<TD width=70% align='left'>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
       '' General.WriteHTML(HTMLControls.DrawTextBox("txtActivityName", "txtActivityName", , 450, 500, strActivityName.Trim, , , True, , , , , True) + "</TD>")
        General.WriteHTML(HTMLControls.DrawTextBox("txtActivityName", "txtActivityName", , 450, 500, strActivityName.Trim, , , True, , , , , True, EnableHTMLEncode:=True) + "</TD>")
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        General.WriteHTML("</TR>")

        'display references
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=30% align='right' valign='top'>" + MyBase.GetResourceString("CAP_REFERENCES") + "&nbsp;</TD>")
        General.WriteHTML("<TD width=70% align='left'>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''General.WriteHTML(HTMLControls.DrawTextArea("txtReferences", "txtReferences", , , , "frmSDLCProcess", , , 450, 50, 500, strReferences.Trim, , , , , , , , True) + "</TD>")
        General.WriteHTML(HTMLControls.DrawTextArea("txtReferences", "txtReferences", , , , "frmSDLCProcess", , , 450, 50, 500, strReferences.Trim, , , , , , , , True, EnableHTMLEncode:=True) + "</TD>")
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        General.WriteHTML("</TR>")

        'display tailoring description
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=30% align='right' valign='top'>" + MyBase.GetResourceString("CAP_TAILORING_DESC") + "&nbsp;</TD>")
        General.WriteHTML("<TD width=70% align='left'>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''General.WriteHTML(HTMLControls.DrawTextArea("txtTailoringDesc", "txtTailoringDesc", , , , "frmSDLCProcess", , , 450, 50, 1000, strTailoringDesc.Trim, , , , , , , , True) + "</TD>")
        General.WriteHTML(HTMLControls.DrawTextArea("txtTailoringDesc", "txtTailoringDesc", , , , "frmSDLCProcess", , , 450, 50, 1000, strTailoringDesc.Trim, , , , , , , , True, EnableHTMLEncode:=True) + "</TD>")
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        General.WriteHTML("</TR>")

        'display deviation description
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=30% align='right' valign='top'>" + MyBase.GetResourceString("CAP_DEVIATION_DESC") + "&nbsp;</TD>")
        General.WriteHTML("<TD width=70% align='left'>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''General.WriteHTML(HTMLControls.DrawTextArea("txtDeviationDesc", "txtDeviationDesc", , , , "frmSDLCProcess", , , 450, 50, 1000, strDeviationDesc.Trim, , , , , , , , True) + "</TD>")
        General.WriteHTML(HTMLControls.DrawTextArea("txtDeviationDesc", "txtDeviationDesc", , , , "frmSDLCProcess", , , 450, 50, 1000, strDeviationDesc.Trim, , , , , , , , True, EnableHTMLEncode:=True) + "</TD>")
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        General.WriteHTML("</TR>")

        If blnReview = True Then
            'display review frequency
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD width=30% align='right'>" + MyBase.GetResourceString("CAP_FREQUENCY") + "&nbsp;</TD>")
            General.WriteHTML("<TD width=70% align='left'>")
            strSQL = "usp_sel_SDLC_Review_Frequency"
            General.WriteHTML(HTMLControls.DrawComboBox("cboFrequency", strSQL, 150, lngReviewFrequency.ToString, , True, True) + "</TD>")
            General.WriteHTML("</TR>")
        End If

        'added by SachinR    On 29 Jun 2004
        'To implement SRS - PM_PBN_41_01
        'Following code is added as two seperate listboxes are displayed to show 
        'selected and available templates/checklists

        'display template list
        '*********************************************************************************
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=100% align='center' valign='top' colspan=2>")

        General.WriteHTML("<Table class=clsTable cellspacing=0 cellpadding=0 width=99.9%>")
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width='45%' align='left'>")
        General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("CAP_AVAILABLETEMPLATE") + "</TD>")
        General.WriteHTML("<TD width='10%' >&nbsp;</TD>")
        General.WriteHTML("<TD width='45%' align='left'>")
        General.WriteHTML(MyBase.GetResourceString("CAP_SELECTEDTEMPLATE") + "</TD>")
        General.WriteHTML("</TR>")

        'plot the available template list box
        strSQL = "usp_Sel_tbl_PRS_Activity_Templates_Available " + lngProjectID.ToString + "," + lngProcessID.ToString + "," + lngActivityID.ToString
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width='45%' align='right' rowspan=4>")
        General.WriteHTML(HTMLControls.DrawListBox("lstAvailableTemplates", strSQL, 300, 100, , "ondblclick=javascript:Add_OnClick(""lstAvailableTemplates"",""lstTemplate"")", , True))
        General.WriteHTML("</TD>")

        'plot the image links
        General.WriteHTML("<TD width='10%' align='middle'>")
        General.WriteHTML("<a href='JavaScript:AddAll_OnClick(""lstAvailableTemplates"",""lstTemplate"")'>" + HTMLControls.DrawImage("../../images/allright.gif", , , , , , MyBase.GetResourceString("BTN_ADDALL_TOOLTIP"), True) + "</a>")
        General.WriteHTML("</TD>")

        'plot selected template list box
        strSQL = "usp_Sel_tbl_PRS_Activity_Templates_Selected " + lngProjectID.ToString + "," + lngProcessID.ToString + "," + lngActivityID.ToString
        General.WriteHTML("<TD width='45%' align='left' rowspan=4>")
        General.WriteHTML(HTMLControls.DrawListBox("lstTemplate", strSQL, 300, 100, , "ondblclick=javascript:Remove_OnClick(""lstAvailableTemplates"",""lstTemplate"")", , True))
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        'plot the image links
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width='10%' align='middle'>")
        General.WriteHTML("<a href='JavaScript:Add_OnClick(""lstAvailableTemplates"",""lstTemplate"")'>" + HTMLControls.DrawImage("../../images/right.gif", , , , , , MyBase.GetResourceString("BTN_ADD_TOOLTIP"), True) + "</a></TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width='10%' align='middle'>")
        General.WriteHTML("<a href='JavaScript:Remove_OnClick(""lstAvailableTemplates"",""lstTemplate"")'>" + HTMLControls.DrawImage("../../images/left.gif", , , , , , MyBase.GetResourceString("BTN_REMOVE_TOOLTIP"), True) + "</a></TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width='10%' align='middle'>")
        General.WriteHTML("<a href='JavaScript:RemoveAll_OnClick(""lstAvailableTemplates"",""lstTemplate"")'>" + HTMLControls.DrawImage("../../images/allleft.gif", , , , , , MyBase.GetResourceString("BTN_REMOVEALL_TOOLTIP"), True) + "</a></TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")

        General.WriteHTML("</TR>")
        '*********************************************************************************

        'display list of checklist
        '*********************************************************************************
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=100% align='center' valign='top' colspan=2>")

        General.WriteHTML("<Table class=clsTable cellspacing=0 cellpadding=0 width=99.9%>")
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width='45%' align='left'>")
        General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("CAP_AVAILABLECHECKLIST") + "</TD>")
        General.WriteHTML("<TD width='10%' >&nbsp;</TD>")
        General.WriteHTML("<TD width='45%' align='left'>")
        General.WriteHTML(MyBase.GetResourceString("CAP_SELECTEDCHECKLIST") + "</TD>")
        General.WriteHTML("</TR>")

        'plot the available checklist list box
        strSQL = "usp_Sel_tbl_PRS_Activity_References_Published_Checklists_Available " + lngProjectID.ToString + "," + lngProcessID.ToString + "," + lngActivityID.ToString
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width='45%' align='right' rowspan=4>")
        General.WriteHTML(HTMLControls.DrawListBox("lstAvailableChecklist", strSQL, 300, 100, , "ondblclick=javascript:Add_OnClick(""lstAvailableChecklist"",""lstChecklist"")", , True))
        General.WriteHTML("</TD>")

        'plot the image links
        General.WriteHTML("<TD width='10%' align='middle'>")
        General.WriteHTML("<a href='JavaScript:AddAll_OnClick(""lstAvailableChecklist"",""lstChecklist"")'>" + HTMLControls.DrawImage("../../images/allright.gif", , , , , , MyBase.GetResourceString("BTN_ADDALL_TOOLTIP"), True) + "</a>")
        General.WriteHTML("</TD>")

        'plot selected checklist list box
        strSQL = "usp_Sel_tbl_PRS_Activity_References_Published_Checklists_Selected " + lngProjectID.ToString + "," + lngProcessID.ToString + "," + lngActivityID.ToString
        General.WriteHTML("<TD width='45%' align='left' rowspan=4>")
        General.WriteHTML(HTMLControls.DrawListBox("lstChecklist", strSQL, 300, 100, , "ondblclick=javascript:Remove_OnClick(""lstAvailableChecklist"",""lstChecklist"")", , True))
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        'plot the image links
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width='10%' align='middle'>")
        General.WriteHTML("<a href='JavaScript:Add_OnClick(""lstAvailableChecklist"",""lstChecklist"")'>" + HTMLControls.DrawImage("../../images/right.gif", , , , , , MyBase.GetResourceString("BTN_ADD_TOOLTIP"), True) + "</a></TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width='10%' align='middle'>")
        General.WriteHTML("<a href='JavaScript:Remove_OnClick(""lstAvailableChecklist"",""lstChecklist"")'>" + HTMLControls.DrawImage("../../images/left.gif", , , , , , MyBase.GetResourceString("BTN_REMOVE_TOOLTIP"), True) + "</a></TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width='10%' align='middle'>")
        General.WriteHTML("<a href='JavaScript:RemoveAll_OnClick(""lstAvailableChecklist"",""lstChecklist"")'>" + HTMLControls.DrawImage("../../images/allleft.gif", , , , , , MyBase.GetResourceString("BTN_REMOVEALL_TOOLTIP"), True) + "</a></TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")

        General.WriteHTML("</TR>")
        '*********************************************************************************
        'addition end

        'close the table and outer div
        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

        '**********************************************************************************************************

    End Sub

    '=====================================================================
    ' Procedure Name		:	performEditActivityAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data of the activity for the given project and process id
    ' Description			:	same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 30 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performEditActivityAction()
        Dim strSQL As String
        Dim strActivityName As String
        Dim strReferences As String
        Dim strTailoringDesc As String
        Dim strDeviationDesc As String
        Dim strReviewFrequency As String
        Dim blnReview As Boolean = False
        Dim strTemplateIDList As String
        Dim strChecklistIDList As String
        Dim arrIDList() As String


        'get the values form the form fields
        strReferences = MyBase.GetFormValue("txtReferences", False) + ""
        strTailoringDesc = MyBase.GetFormValue("txtTailoringDesc", False) + ""
        strDeviationDesc = MyBase.GetFormValue("txtDeviationDesc", False) + ""
        strReviewFrequency = MyBase.FixString(MyBase.GetFormValue("cboFrequency"), 9, True, False)
        strTemplateIDList = MyBase.GetFormValue("lstTemplate") + ""
        strChecklistIDList = MyBase.GetFormValue("lstChecklist") + ""

        Select Case (m_strAction)
            Case CONST_ACTION_SAVE

                'update the activity info
                strSQL = "usp_ins_SDLC_ActivityDetails " + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + "," + m_lngActivityID.ToString
                strSQL += ",'" + General.BuildQueryString(strReferences.Trim) + "','" + General.BuildQueryString(strTailoringDesc.Trim) + "','" + General.BuildQueryString(strDeviationDesc.Trim) + "','" + strReviewFrequency.Trim + "'"
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                'first delete all the templates for this activity for this process and project
                'and then insert new records for selected templates
                strSQL = "EXEC usp_del_SDLCTemplates " + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + "," + m_lngActivityID.ToString
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                If strTemplateIDList <> "" Then
                    arrIDList = Split(strTemplateIDList, ",")
                    Dim i As Integer
                    For i = 0 To arrIDList.Length - 1
                        If arrIDList(i) <> "" Then
                            strSQL = "usp_ins_Insert_SDLCTemplates " + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + "," + m_lngActivityID.ToString + "," + arrIDList(i).Trim
                            Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                        End If
                    Next
                    arrIDList = Nothing
                End If

                'first delete all the checklists for this activity for this process and project id
                'and then insert new records for the seletced checklists
                strSQL = "usp_Del_tbl_PRS_SDLC_Checklists " + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + "," + m_lngActivityID.ToString
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                If strChecklistIDList <> "" Then
                    arrIDList = Split(strChecklistIDList, ",")
                    Dim i As Integer
                    For i = 0 To arrIDList.Length - 1
                        If arrIDList(i) <> "" Then
                            strSQL = "usp_Ins_tbl_PRS_SDLC_Checklists " + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + "," + m_lngActivityID.ToString + "," + arrIDList(i).Trim
                            Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                        End If
                    Next
                    arrIDList = Nothing
                End If
            Case Else
        End Select

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotReasonForRevisionScreen
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the screen for the dialouge box of reason for save with revision
    '                           mode of the page.
    ' Description			:	same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 30 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotReasonForRevisionScreen()

        'plot the screen
        General.WriteHTML("<Div id='DivList' width=99.9% height=90% style='Overflow: auto;'>")
        General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0>")

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=30% align='right' valign='top'>" + MyBase.GetResourceString("CAP_REASON") + "&nbsp;</TD>")
        General.WriteHTML("<TD width=70% align='left'>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''General.WriteHTML(HTMLControls.DrawTextArea("txtReason", "txtReason", , , , "frmSDLCProcess", , , 450, 50, 999, , , , , , , , , True) + "</TD>")
        General.WriteHTML(HTMLControls.DrawTextArea("txtReason", "txtReason", , , , "frmSDLCProcess", , , 450, 50, 999, , , , , , , , , True, EnableHTMLEncode:=True) + "</TD>")
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")
    End Sub

    '=====================================================================
    ' Procedure Name		:	showActivityDetailsScreen
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the screen for showing the details of the activity selected
    ' Description			:	same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 30 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub showActivityDetailsScreen(ByVal lngProcessid As Long, ByVal lngProjectid As Long, ByVal lngActivityid As Long)
        Dim strSql As String
        Dim objDr As IDataReader
        Dim objGrid As WebPage.Templates.GenericGrid
        Dim strName As String
        Dim strDesc As String
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHTML() As String = {"0", "1"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '**********************************************************************************************************
        Dim arrColHeader() As String = {MyBase.GetResourceString("CAP_ACTIVITY_ID"), MyBase.GetResourceString("CAP_ACTIVITY_NAME"), MyBase.GetResourceString("CAP_OBJECTIVE"), MyBase.GetResourceString("CAP_SCOPE"), MyBase.GetResourceString("CAP_INPUT_CRITERIA"), MyBase.GetResourceString("CAP_INPUTS"), MyBase.GetResourceString("CAP_DESCRIPTION"), MyBase.GetResourceString("CAP_EXIT_CRITERIA")}
        Dim arrAN() As String = {"ActivityStageID", "Title", "Objective", "Scope", "Inputcriteria", "Inputs", "Description", "Exitcriteria"}
        'Dim arrTDStyle() As String = {"align='left'", "align='left'"}

        'create the SP for grid data without sorting 
        'Integrated by MrugajaB on 3rd Jan 2006 for Whiz2 Processes - Build 29 
        'strSql = "EXEC usp_sel_Activity_Details " + lngActivityid.ToString
        '******************************************************************************************
        'Code Added     :       PramodA     15th December 2004
        'Purpose        :       To show the Activity Details from project instead of coporate...
        '******************************************************************************************
        'strSql = "EXEC usp_sel_Activity_Details " + lngActivityid.ToString
        strSql = "EXEC usp_Sel_tbl_PRS_Project_SDLC_Details " + m_lngProjectID.ToString + "," + m_lngProcessID.ToString + "," + lngActivityid.ToString
        '******************************************************************************************
        'End of Addition    :   PramodA     15th December 2004
        '******************************************************************************************
		'End Integration

        'create Grid object and set the properties

        'Modified by    SachinR     On 05 May 2004
        'Issue ID 10942
        'grid taken with events as event has to be handled to apply PRE tag for the 
        'description data
        objGridActivityDetails = New WebPage.Templates.GenericGrid
        With objGridActivityDetails
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            'objGrid.TDStyleArray = arrTDStyle
            .DIVID = "DivGrid1"
            .DIVHeight = 300
            .DIVStyle = "overflow:auto; width:100%; "
            .NoOfDataColumns = 8
            .PrinterFriendlyVersion = False
            .VerticalDisplay = True
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .EmptyValueReplacement = "-"
            .SQL = strSql
            .UseSQL = MyBase.UseSQL

            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'plot the grid 
            .DrawGrid()
        End With
        objGridActivityDetails = Nothing
        'modification end
        '**********************************************************************************************************

        'plot the lower section of the screen
        General.WriteHTML("<BR>")
        General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0>")
        General.WriteHTML("<TR class='clsTRSectionHeader'>")
        General.WriteHTML("<TD clospan=2><B>" + MyBase.GetResourceString("CAP_QUALITY_REFERENCES") + "</B></TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("<TR class='clsTRSectionHeader'>")
        General.WriteHTML("<TD clospan=2>" + MyBase.GetResourceString("CAP_QUALITY_RECORDS") + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")

        ReDim arrColHeader(2)
        ReDim arrAN(2)
        arrColHeader(0) = MyBase.GetResourceString("CAP_NAME") : arrColHeader(1) = MyBase.GetResourceString("CAP_DESCRIPTION")
        'Modified by SonalD on 21st Nov
        'arrAN(0) = "QualityRecordName" : arrAN(0) = "QualityRecordDescription"
        arrAN(0) = "QualityRecordName" : arrAN(1) = "QualityRecordDescription"
        'End of modifiv=cation by sonalD

        'create the SP for grid data without sorting 
        strSql = "usp_Sel_Activity_Quality_References_Published " + lngProcessid.ToString + "," + lngActivityid.ToString + ",'Q'"

        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN
        'Added by SonalD on 21ST Nov 2008 for RequestID 16512
        'Purpose: To Ignore HTML tags 

        objGrid.IgnoreHTMLEncode = arrIgnoreHTML
        'End of addition by SonalD on 21ST Nov 2008
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.DIVID = "DivGrid2"
        objGrid.DIVHeight = 100
        objGrid.DIVStyle = "overflow: none;"
        objGrid.NoOfDataColumns = 2
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = True
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = strSql
        objGrid.UseSQL = MyBase.UseSQL

        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTML
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing
        '**********************************************************************************************************

        General.WriteHTML("<BR>")
        'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0>")
        General.WriteHTML("<TR class='clsTRSectionHeader'>")
        General.WriteHTML("<TD clospan=2>" + MyBase.GetResourceString("CAP_GUIDLINES") + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")

        ReDim arrColHeader(4)
        ReDim arrAN(4)
        arrColHeader(0) = MyBase.GetResourceString("CAP_TITLE") : arrColHeader(1) = MyBase.GetResourceString("CAP_OBJECTIVE")
        arrColHeader(2) = MyBase.GetResourceString("CAP_SCOPE") : arrColHeader(3) = MyBase.GetResourceString("CAP_GUIDELINE_DETAIL")
        'Code Commented And added by SwatiC on 6 Jun 2007 for IssueID : 12863
        'arrAN(0) = "Title" : arrAN(0) = "Objective"
        arrAN(0) = "Title" : arrAN(1) = "Objective"
        'End of Code addition by SwatiC on 6 Jun 2007 for IssueID : 12863
        arrAN(2) = "Scope" : arrAN(3) = "GuidelineDetails"

        'create the SP for grid data without sorting 
        strSql = "usp_Sel_Activity_Quality_References_Published " + lngProcessid.ToString + "," + lngActivityid.ToString + ",'G'"

        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN
        'Added by SonalD on 10th Nov 2008 for RequestID 16512
        'Purpose: To Ignore HTML tags 
        Dim arrIgnoreHTML1() As String = {"0", "1", "1", "1"}
        objGrid.IgnoreHTMLEncode = arrIgnoreHTML1
        'End of addition by SonalD on 10th Nov 2008
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.DIVID = "DivGrid3"
        objGrid.DIVHeight = 150
        objGrid.DIVStyle = "overflow: none;"
        objGrid.NoOfDataColumns = 4
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = True
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = strSql
        objGrid.UseSQL = MyBase.UseSQL
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTML
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing
        '**********************************************************************************************************
    End Sub

    '=====================================================================
    ' Procedure Name		:	getTemplteFileName
    ' Parameters Passed		:	lngTemplateID - Long
    ' Returns				:	String, File name for the give template id
    ' Parameters Affected	:	None
    ' Purpose				:	To get the filename fromthe database for given templateid
    '                           and create the new file for that template id and return that filename with path.
    ' Description			:	This function will get the filename for the given template ID from the database
    '                           create the new copy of the file with the original filename given in the database 
    '                           at server and return filename with path.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 31 2004
    ' Revisions				:	
    '=====================================================================
    Private Function getTemplateFileName(ByVal lngTemplateID As Long) As String
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strSourceFileName As String = ""
        Dim strDestinationFileName As String = ""

        'get the filename and original filename for the template id
        strSQL = "usp_sel_tbl_PRS_Templates " + lngTemplateID.ToString
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            If Not IsDBNull(objDr("FileName")) Then
                strSourceFileName = objDr("FileName").ToString
            End If
            If Not IsDBNull(objDr("OriginalFileName")) Then
                strDestinationFileName = objDr("OriginalFileName").ToString
            End If
        End If
        objDr.Close()
        objDr.Dispose()
        objDr = Nothing

        strSourceFileName = "..\..\Attachments\TPT\" + strSourceFileName.Trim
        strDestinationFileName = "\" + strDestinationFileName.Trim

        getTemplateFileName = strDestinationFileName

    End Function

    'Added by    SachinR     On 05 May 2004
    'Issue ID 10942
    'Purpose    :   To apply PRE tag to the data in the Description column
    Private Sub objGridActivityDetails_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGridActivityDetails.DataRowTD_BeforePrint
        If Args.DataField = "Description" Then
            Args.StringToBeInserted = "<TD align=right valign=top ><B>" + MyBase.GetResourceString("CAP_DESCRIPTION") + "</B></TD><TD align=left ><PRE>" + Args.DataFieldValue.ToString + "</PRE></TD>"
            Cancel = True
        ElseIf Args.DataField = "Exitcriteria" Then
            Args.StringToBeInserted = "<TD align=right valign=top ><B>" + MyBase.GetResourceString("CAP_EXIT_CRITERIA") + "</B></TD><TD align=left ><PRE>" + Args.DataFieldValue.ToString + "</PRE></TD>"
            Cancel = True
            'added by SachinR   on 23 Jul 2004
            'Issue - 12093
            'make th ecaptions of following columns as Top align
        ElseIf Args.DataField.ToUpper = "OBJECTIVE" Then
            Args.StringToBeInserted = "<TD align=right valign=top ><B>" + MyBase.GetResourceString("CAP_OBJECTIVE") + "</B></TD><TD align=left ><PRE>" + Args.DataFieldValue.ToString + "</PRE></TD>"
            Cancel = True
        ElseIf Args.DataField.ToUpper = "SCOPE" Then
            Args.StringToBeInserted = "<TD align=right valign=top ><B>" + MyBase.GetResourceString("CAP_SCOPE") + "</B></TD><TD align=left ><PRE>" + Args.DataFieldValue.ToString + "</PRE></TD>"
            Cancel = True
        ElseIf Args.DataField.ToUpper = "INPUTCRITERIA" Then
            Args.StringToBeInserted = "<TD align=right valign=top ><B>" + MyBase.GetResourceString("CAP_INPUT_CRITERIA") + "</B></TD><TD align=left ><PRE>" + Args.DataFieldValue.ToString + "</PRE></TD>"
            Cancel = True
        ElseIf Args.DataField.ToUpper = "INPUTS" Then
            Args.StringToBeInserted = "<TD align=right valign=top ><B>" + MyBase.GetResourceString("CAP_INPUTS") + "</B></TD><TD align=left ><PRE>" + Args.DataFieldValue.ToString + "</PRE></TD>"
            Cancel = True
            'addition end          

        End If
    End Sub
    'Code added by SwatiC on 6 Jun 2007 For IssueID : 12856
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "TITLE" Then
            If Not (m_objAccessRights.Edit) Then
                Args.EnableLink = False
            End If
        End If
    End Sub
    'End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12856
End Class
