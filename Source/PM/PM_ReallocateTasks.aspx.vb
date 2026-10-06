Public Class PM_ReallocateTasks
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : PM_ReallocateTasks
    ' Purpose               : Reallocate the tasks assigned to one resource to another resource
    ' Description           : 
    ' Parameters Passed     : 
    ' Assumptions           : AppResources.PM_ReallocateTasks.resx Resource file exists
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SuryabirD
    ' Created               : Mar 18th, 2004
    ' Revisions             : 
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

    Protected m_strPageTitle, m_strMode As String
    Protected m_lngEmployeeID, m_lngProjectID As Long
    Protected m_lngEmpRoleID As Long
    Protected m_lngTagID As Long

    Protected WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_strEmployeeName As String

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Function Name         : CreateGlobalObject
        ' Purpose               : Creates the Global Object for accessing TagID, FrowWhere etc.
        ' Description           : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Feb 16, 2004
        ' Revisions             : 
        '=====================================================================

        'Global object
        Dim objAccess As New WebPage.Templates.AccessRights

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject

        objAccess.GetAccess(m_objGlobal)

        'm_blnAddAccess = objAccess.Add          'If user has AddNew Access
        'm_blnDeleteAccess = objAccess.Delete    'If User has Delete Access
        'm_blnEditAccess = objAccess.Edit        'If user has Edit Access

        'destroy global and AccessRights objects
        objAccess = Nothing

    End Sub

    Protected Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Plots the Main controls on the Page
        ' Description           : 3 Combos For all 3 Types: M, O, B
        ' Parameters Passed     : None
        ' Returns               : None
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Mar 18,2004   
        '=====================================================================

        Dim strMenu, strSQL As String
        Dim objTask As Object
        Dim lngTaskCount As Long
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter

        '-- Display Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<BR>")

        '-- Page Caption
        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_TITLE"), " Resource: " + m_strEmployeeName, , True))
        Response.Write("<BR>")

        '-- Display header
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing

        Response.Write("<DIV ID='DivList' Style='WIDTH:100%;OVERFLOW:auto;'>")

        '-- Display the 3 Combo boxes for assigning tasks to different resources

        Response.Write("<TABLE class=clsTable cellspacing =0 width=99.9%><TR>")
        Response.Write("<TD>")
        Response.Write("</TD></TR></TABLE>")

        '-- Check if Any Inclomplete MPP Tasks exist 
        strSQL = "usp_Sel_ProjectTasks_Count " + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString + ",'M', 1, 0"
        lngTaskCount = CType(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), Long)

        '--1st TR For MPP Tasks
        Response.Write("<TABLE class=clsTable cellspacing =0 width=99.9%>")
        Response.Write("<TR class=clsTRColumnHeader Width=100%><TD Align=Left>")
        Response.Write(MyBase.GetResourceString("TASK_TYPE"))
        Response.Write("</TD><TD>")
        Response.Write(MyBase.GetResourceString("ALLOCATE_TO"))
        Response.Write("</TD></TR>")

        Response.Write("<TR class=clsTREven Width=100%><TD Align=Left>")
        Response.Write(MyBase.GetResourceString("MPP_TASKS") + " (" + lngTaskCount.ToString + ")")
        Response.Write("</TD>")
        Response.Write("<TD Align=Left>")
        If lngTaskCount = 0 Then
            Response.Write(MyBase.GetResourceString("NO_MPP_TASKS"))
        Else
            strSQL = "usp_Sel_CurrentTeamMembers_Except_Employee " + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString
            CommonFunctions.HTMLControls.DrawComboBox("cboResourceMPP", strSQL, , , , True)
        End If
        Response.Write("</TD>")
        Response.Write("</TR>")

        '-- Check if Any Inclomplete Assigned Tasks exist 
        strSQL = "usp_Sel_ProjectTasks_Count " + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString + ",'O', 1, 0"
        lngTaskCount = CType(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), Long)

        '--2nd TR For Assigned Tasks
        Response.Write("<TR class=clsTROdd Width=100%>")
        Response.Write("<TD Align=Left>")
        Response.Write(MyBase.GetResourceString("ASS_TASKS") + " (" + lngTaskCount.ToString + ")")
        Response.Write("</TD>")
        Response.Write("<TD Align=Left>")
        If lngTaskCount = 0 Then
            Response.Write(MyBase.GetResourceString("NO_ASS_TASKS"))
        Else
            strSQL = "usp_Sel_CurrentTeamMembers_Except_Employee " + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString
            CommonFunctions.HTMLControls.DrawComboBox("cboResourceASS", strSQL, , , , True)
        End If
        Response.Write("</TD></TR>")

        '-- Check if Any Inclomplete Assigned Tasks exist 
        strSQL = "usp_Sel_ProjectTasks_Count " + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString + ",'B', 1, 0"
        lngTaskCount = CType(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), Long)

        '-- 3rd Row for Issues
        Response.Write("<TR class=clsTREven Width=100%>")
        Response.Write("<TD Align=Left>")
        Response.Write(MyBase.GetResourceString("ISS_TASKS") + " (" + lngTaskCount.ToString + ")")
        Response.Write("</TD>")
        Response.Write("<TD Align=Left>")
        If lngTaskCount = 0 Then
            Response.Write(MyBase.GetResourceString("NO_ISS_TASKS"))
        Else
            strSQL = "usp_Sel_CurrentTeamMembers_Except_Employee " + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString
            CommonFunctions.HTMLControls.DrawComboBox("cboResourceISS", strSQL, , , , True)
        End If
        Response.Write("</TD></TR></TABLE>")

        Response.Write("</DIV>")

        '-- Display Footer
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing

        '-- Bottom Menu
        Response.Write("<BR>" + strMenu)

    End Sub

    Private Sub AssignTasks_NewResource()
        '=====================================================================
        ' Procedure Name        : AssignTasks_NewResource
        ' Purpose               : Assigns Tasks to the newly selected resource
        ' Description           : For all 3 Types: M, O, B
        ' Parameters Passed     : None
        ' Returns               : None
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Mar 18,2004   
        '=====================================================================
        Dim strSQL As String
        Dim strEmployeeID As String

        strEmployeeID = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboResourceMPP"), "")
        '-- Assign MPP Tasks to new Resource
        If strEmployeeID <> "" Then
            strSQL = "usp_Upd_tbl_PM_ProjectTasks_ReallocateTasks " + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString + "," + strEmployeeID + ",M"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        End If

        '-- Assigned Tasks
        strEmployeeID = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboResourceASS"), "")
        '-- Assign Assigned Tasks to new Resource
        If strEmployeeID <> "" Then
            strSQL = "usp_Upd_tbl_PM_ProjectTasks_ReallocateTasks " + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString + "," + strEmployeeID + ",O"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        End If

        '-- Issues Tasks
        strEmployeeID = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboResourceISS"), "")
        '-- Assign issues to new Resource
        If strEmployeeID <> "" Then
            strSQL = "usp_Upd_tbl_PM_ProjectTasks_ReallocateTasks " + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString + "," + strEmployeeID + ",B"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        End If

    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.PM_ReallocateTasks", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ASSIGN"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ASSIGN_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Assign_OnClick()", "Close_OnClick()", "Help_OnClick(" + m_lngTagID.ToString + ")"}

        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        m_objMenu = Nothing
        Return strMenu

    End Function
    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

        MyBase.InitializeResources("AppResources.PM_ReallocateTasks", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim strSQL As String
        Dim drTemp As IDataReader

        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_lngEmployeeID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("EMP_ID"), "0"), Long)
        m_lngProjectID = CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"), Long)
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("MODE"))
        m_lngTagID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagID")), Long)

        '-- Get the ProjectEmployeeRoleID
        m_lngEmpRoleID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectEmployeeRoleID"), "0"), Long)
        strSQL = "usp_Sel_tbl_PM_Employee_ProjectEmployeeRoleID " + m_lngEmpRoleID.ToString

        Call CreateGlobalObject()

        '-- Get EmployeeID and UserName
        If m_lngEmployeeID = 0 Then
            drTemp = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drTemp.Read Then
                m_lngEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(drTemp("EmployeeID"), "0"), Long)
                m_strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drTemp("UserName")).ToString

            End If
            CommonFunctions.Data.DisposeDataReader(drTemp)
        End If

        If m_strMode.Trim.ToUpper = "ASSIGN" Then
            Call AssignTasks_NewResource()
        End If
    End Sub
End Class
