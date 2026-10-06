#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_TaskCostCategory
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Page Name 	        :	
    ' Purpose				:	
    ' Description			:	
    ' Assumptions			:	
    ' Dependencies			:	
    ' Author				:	
    ' Created				:	
    ' Revisions				:	
    '=====================================================================

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

#End Region

#Region "PageEvents"
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        Initialize()
    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here

        'This will initialize all the global objects.
        GetGlobalObject()

        m_blnUseClientDateForDA = CommonFunction.Application.UseClientDateForDA()

        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'Display the page caption.
        DrawPageCaption()
        'Display the Header if exist. 
        DrawHeader()

        Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto;Height=420px'>")

        '--- Display filters for selection
        DisplaySelectionHeader()

        '--- Display Grid with tasks for updation
        DisplayGrid()

        HttpContext.Current.Response.Write("</DIV>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        DisposeObjects()
    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page.
        ' Description           : Also gets the various User Preferences from the Database and 
        '                         information from the Querystring
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : Priyanka
        ' Created               : 19th July 2004
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery As String
        Dim strTaskIDs As String
        Dim drCompanyInformation As IDataReader
        Dim intFirstDay As Integer
        Dim dtFromDate As Date
        Dim drDates As IDataReader
        Dim strCCArray As String


        m_lngTagId = m_objGlobal.TagID
        m_strWindowTitle = "Task Cost Category Association"

        '--- Get the StartingDayOfWeek
        strSQLQuery = "EXEC usp_Sel_tbl_PM_CompanyInformation"
        drCompanyInformation = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drCompanyInformation.Read Then
            intFirstDay = CType(CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("StartingDayOfWeek"), "1"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drCompanyInformation)

        '--- Get the Mode

        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        If m_strMode = "" Then
            m_strMode = MODE_LIST
        End If

        '--- Gets information from the Querystring
        '--- Task Type
        m_strTaskType = CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskType"), TASK_TYPE_ASSIGNED)

        '--- If Mode is Save...update the IsTaskComplete field in the tbl_PM_ProjectTasks
        If m_strMode = MODE_SAVE Then
            strTaskIDs = CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskIDs"), "")
            strCCArray = CommonFunctions.General.CheckIsNothing(Request.QueryString("CCArray"), "")
            If Not strTaskIDs = Nothing Then
                If CommonFunctions.General.CheckIsNothing(Request.QueryString("CostCategory"), "") <> "" Then
                    m_intCostCategory = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("CostCategory"), ""), Integer)
                    UpdateTasks(strTaskIDs)
                ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("CCArray"), "") <> "" Then
                    UpdateTasks(strTaskIDs, strCCArray)
                End If
            End If
        End If

        m_strMode = MODE_LIST
        '--- From Date
        m_dtFromDate = Request.QueryString("FromDate")

        '--- To Date
        m_dtToDate = Request.QueryString("ToDate")

        '--- ProjectID
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")) <> "" Then
            m_intProjectID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")), Integer)
        Else
            m_intProjectID = CInt(Session("intProjectID"))
        End If

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID")) <> "" Then
            m_ResourceID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID")), Integer)
        End If

        ' to solve the issue - When Date Range is given say 1-Jan to 31st May it still shows the Week 1-Jan to 7-Jan 
        ' after post back .
        If (Request.QueryString("Weekly") = "True" Or (Request.QueryString("Weekly") = "") And Request.QueryString("FromDate") = "" And Request.QueryString("ToDate") = "") Then
            If Request.QueryString("FromDate") = "" Or Request.QueryString("FromDate") Is Nothing Then
                If m_blnUseClientDateForDA = True Then
                    dtFromDate = CType(Session("ClientDate"), Date)
                Else
                    dtFromDate = Now()
                End If

            Else
                dtFromDate = CType(m_dtFromDate, Date)
            End If

            'm_dtFromDate = CommonFunctions.Dates.GetDate(CDate(dtFromDate.AddDays((dtFromDate).DayOfWeek * (-1I) + intFirstDay)))
            'm_dtToDate = CommonFunctions.Dates.GetDate(CDate(DateAdd("d", 6, CType(m_dtFromDate, Date))))

            '--- Get the StartingDayOfWeek
            If dtFromDate.ToString <> "" Then
                strSQLQuery = "EXEC usp_Get_WeekDates '" + FormatDateTime(dtFromDate, DateFormat.ShortDate).ToString + "'"
                drDates = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDates.Read Then
                    m_dtFromDate = CommonFunctions.Dates.GetDate(CType(drDates("StartDate"), Date))
                    m_dtToDate = CommonFunctions.Dates.GetDate(CDate(DateAdd("d", 6, CType(m_dtFromDate, Date))))
                End If
                CommonFunctions.Data.DisposeDataReader(drDates)
            End If
        End If

    End Sub

#End Region

#Region "Constants"

    '--- Constants for the Task Types
    Private Const TASK_TYPE_ASSIGNED As String = "O"
    Private Const TASK_TYPE_MPP As String = "M"
    Private Const TASK_TYPE_ISSUE As String = "B"
    Private Const TASK_TYPE_REVIEW As String = "R"

    '--- Constants for Mode
    Private Const MODE_LIST As String = "List"
    Private Const MODE_SAVE As String = "Save"

#End Region

#Region "Member Variables"

    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.
    Private m_objGlobal As WebPages.Template.IGlobal                    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights        'This variable is for access rights of page.
    Protected WithEvents frmTaskCostCategory As System.Web.UI.HtmlControls.HtmlForm

    Private strMenu As String                           'stores the static menu string.
    Private m_strTaskType As String                     'Stores the Task Type
    Protected m_dtFromDate As String                    'From Date
    Protected m_dtToDate As String                      'To Date
    Private m_intProjectID As Integer                   'Project ID
    Private m_ResourceID As Integer                     'ResourceID
    Private m_intCostCategory As Integer                   'Cost CategoryID
    Protected m_strWindowTitle As String                'Page Title
    Protected m_lngTagId As Long = 0                    'Tag ID
    Private m_strMode As String                         'Mode
    Private m_intParentTask_UID As Integer
    Private m_intCount As Integer
    Private m_intCount1 As Integer
    Private m_blnUseClientDateForDA As Boolean
    Private strCostCategoryDesc As String = ""

#End Region

#Region "General Functions"

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub UpdateTasks(ByVal strTaskIDs As String, Optional ByVal strCCArray As String = "")

        Dim strSQLQuery As String
        Dim strCostCategory As String
        Dim strSql As String
        Dim drCostCategory As IDataReader
        Dim strCC() As String
        Dim strTIDs() As String
        Dim intCtr As Integer

        If m_intCostCategory <> 0 Then
            strSql = "SELECT CostCategory FROM tbl_PM_CostCategory WHERE CostCategoryID = " + CType(m_intCostCategory, String)
            drCostCategory = CommonFunction.Data.GetDataReader(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If CommonFunctions.General.CheckIsNothing(drCostCategory) <> "" Then
                If drCostCategory.Read() Then
                    strCostCategory = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCostCategory("CostCategory"), "0"), "0"), String)
                End If
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drCostCategory)
        'Here the tasks in the table tbl_PM_ProjectTasks will get udpated
        'i.e Set the IsActiveFlag = 1
        If strTaskIDs <> "" And strCostCategory <> "" Then
            strSQLQuery = "EXEC usp_Upd_TaskCostCategory '" & Left(strTaskIDs, strTaskIDs.Length - 1) & "', '" & m_strTaskType & "', '" & strCostCategory & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
            Exit Sub
        End If

        If strCCArray <> "" Then
            strTIDs = Split(strTaskIDs, ",")
            strCC = Split(strCCArray, ",")
            Dim intCounter As Long
            If strTIDs.LongLength > strCC.LongLength Then
                intCounter = strCC.LongLength
            Else
                intCounter = strTIDs.LongLength
            End If
            For intCtr = LBound(strTIDs) To UBound(strTIDs)
                If intCounter > intCtr Then
                    If Trim(strTIDs(intCtr) & "") <> "" And Trim(strCC(intCtr) & "") <> "" Then
                        strSQLQuery = "EXEC usp_Upd_TaskCostCategory '" & strTIDs(intCtr) & "', '" & m_strTaskType & "', '" & strCC(intCtr) & "'"
                        CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
                    End If
                End If
            Next
        End If

    End Sub

#End Region

#Region "Functions & Procedures"

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                :
        ' Created               :
        ' Revisions             :
        '=====================================================================

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strGrid As String
        'PrachiK
        'Modified By PrachiK on 15 Feb 2005 for Issue ID=15509. 
        'Purpose: Do not allow user to save changes who is having just "View" Access
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            arrMenuList.Add("Save")
            arrMenuToolTipList.Add("Save")
            arrClientSideFunctionList.Add("Save_OnClick()")
        End If

        arrMenuList.Add("?")
        arrMenuToolTipList.Add("Help")
        arrClientSideFunctionList.Add("Help_OnClick('3110')")

        'Create the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)

    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        'Response.Write(PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        'Response.Write("<BR>")

    End Sub

    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(strReturn)
        End If
        objHeader = Nothing

    End Sub

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub


    Private Sub DisplaySelectionHeader()
        Dim blnIsChecked As Boolean
        Dim strSQLQuery As String
        Dim strSQLQuery1 As String
        Dim strSQLQuery2 As String
        Dim strControlValue As String = ""

        Dim objDynamicLink As WebPages.UI.cDynamicLink

        '--- Query for displaying the Projects in Project combo
        'Modified by ManishK on 12th Jan 06 
        'strSQLQuery = "EXEC usp_Sel_Project_For_DA_Active_InActive_Projects " + CType(Session("intUserID"), String) + ",NULL,NULL"
        strSQLQuery = "EXEC usp_sel_Projects_forTaskStatusManagement " + CType(Session("intUserID"), String)
        'End of Modified by ManishK on 12th Jan 06 
        strSQLQuery1 = "EXEC usp_Get_ProjectEmployees " + CType(Session("intProjectID"), String)

        strSQLQuery2 = "EXEC usp_Get_CostCategories " + CType(Session("intProjectID"), String)
        '--- Display the Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Task Cost Category Association", , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        '--- Display the Project combo, dates and option buttons for selection
        CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")

        '--- Project Combo
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td colspan=2>")
        CommonFunctions.General.WriteHTML("Select Project")
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQLQuery, 300, CType(m_intProjectID, String), "")

        '--- Resource Combo
        CommonFunctions.General.WriteHTML("<td colspan=2>")
        CommonFunctions.General.WriteHTML("Select Resource")
        CommonFunctions.General.WriteHTML("&nbsp;")
        '******************
        If MyBase.IsPostBack = True Then
            If Not MyBase.GetFormValue("cboResource") Is Nothing Then
                strControlValue = MyBase.GetFormValue("cboResource")
            Else
                strControlValue = ""
            End If
        End If

        '******************

        CommonFunctions.HTMLControls.DrawComboBox("cboResource", strSQLQuery1, 200, m_ResourceID.ToString, "", True)

        '--- Cost Category Combo
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td colspan=2>")
        CommonFunctions.General.WriteHTML("Cost Category To Map")
        CommonFunctions.General.WriteHTML("&nbsp;")
        '******************
        If MyBase.IsPostBack = True Then
            If Not MyBase.GetFormValue("cboCostCategory") Is Nothing Then
                strControlValue = MyBase.GetFormValue("cboCostCategory")
            Else
                strControlValue = ""
            End If
        End If
        '******************
        CommonFunctions.HTMLControls.DrawComboBox("cboCostCategory", strSQLQuery2, 200, strControlValue, "", True)

        'Date Filters
        CommonFunctions.General.WriteHTML("<td align='Left'>")
        CommonFunctions.General.WriteHTML("From Date")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_dtFromDate, , "frmPM_TaskCostCategory", returnHTML:=True, IsMandatory:=True))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='Left'>")
        CommonFunctions.General.WriteHTML("To Date")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_dtToDate, , "frmPM_TaskCostCategory", returnHTML:=True, ISmandatory:=True))
        CommonFunctions.General.WriteHTML("</td>")

        '--- Task Type filters
        CommonFunctions.General.WriteHTML("</tr><tr class='clsTREven'><td colspan=3>")

        If m_strTaskType = TASK_TYPE_ASSIGNED Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_ASSIGNED, , "")
        CommonFunctions.General.WriteHTML("Assigned Tasks")

        CommonFunctions.General.WriteHTML("&nbsp;")
        If m_strTaskType = TASK_TYPE_MPP Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_MPP, , "")
        CommonFunctions.General.WriteHTML("MPP Tasks")

        CommonFunctions.General.WriteHTML("&nbsp;")
        If m_strTaskType = TASK_TYPE_ISSUE Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_ISSUE, , "")
        CommonFunctions.General.WriteHTML("Issue Tasks")

        CommonFunctions.General.WriteHTML("&nbsp;")
        If m_strTaskType = TASK_TYPE_REVIEW Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_REVIEW, , "")
        CommonFunctions.General.WriteHTML("Review Tasks")
        CommonFunctions.General.WriteHTML("</td>")

        '--- Display the Show Link
        'Display the Show Link
        CommonFunctions.General.WriteHTML("<td align=center>")
        objDynamicLink = New WebPages.UI.cDynamicLink
        objDynamicLink.LinkName = "Show"
        objDynamicLink.Tooltip = "Show Tasks"
        objDynamicLink.FunctionName = "Show_OnClick()"
        objDynamicLink.ReturnHTML = True
        CommonFunctions.General.WriteHTML(" | <B>" + objDynamicLink.GetDynamicLink() + "</B> | ")
        objDynamicLink = Nothing
        CommonFunctions.General.WriteHTML("</td></tr></table>")
        CommonFunctions.General.WriteHTML("<BR>")

    End Sub

    Private Sub DisplayGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""


        strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksCostCategory " & CType(m_intProjectID, String) & ", '" & CType(m_dtFromDate, String) & "', '" & CType(m_dtToDate, String) & "','" & m_strTaskType & "', '" & m_ResourceID & "'"

        Dim arrActualColumns() As String = {"TaskName", "EmployeeName", "Role", "StartDate", "EndDate", "CostCategory", ""}
        Dim arrUserFriendlyColumn() As String = {"Task Name", "Resource Name", "Role", "Start Date", "End Date", _
                                                 "Cost Category", "Apply"}
        Dim arrstrTDStyle() As String = {"align='left' width=40%", "align='left' width=10%", "align='left' width=5%", _
                                         "align='left' width=5%", "align='center' width=5%"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Set the Advanced Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .EmptyValueReplacement = "&nbsp;"
            .SQL = strSQLQuery
            .DIVID = "divList"
            .DIVHeight = 400
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = 8
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Commented and Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting     
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 
        'MyBase.InitializeResources("AppResources.PM_TaskCostCategory", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

#Region "Grid Events"

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        Dim strName As String = ""
        Dim strAttributes As String = ""
        Dim strTxtName As String = ""
        Dim strNameCC As String = ""
        Dim strAttributesCC As String = ""
        Dim strTxtNameCC As String = ""
        Dim m_intTaskID As String = ""

        ''Added By ManishK on 12th Jan 06 To add Employee filter
        Dim m_intEmployeeID As String = ""
        ''End of Added By ManishK on 12th Jan 06 To add Employee filter



        Select Case Args.ColumnName
            Case "Cost Category"
                Cancel = True

                If m_strTaskType = TASK_TYPE_ASSIGNED Or m_strTaskType = TASK_TYPE_REVIEW Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CostCategory"), ""), String) <> "" Then
                        strAttributesCC = ""
                    Else
                        strAttributesCC = ""
                    End If
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer) = 0 Then
                        m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer)
                        m_intCount1 = 0
                        strNameCC = "txtCC" + CType(m_intParentTask_UID, String) + "_" + CType(m_intCount1, String)
                        strTxtName = "imgCC" + CType(m_intParentTask_UID, String) + "_" + CType(m_intCount1, String)
                        'Args.StringToBeInserted = "<td align='center' width=10%><input type='text' id='" + strNameCC + "' name='" + strNameCC + "' class='clsTextBoxReadOnly' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' " + strAttributesCC + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HasChildTasks"), "0"), String) + ")><input type=image name='" + strTxtNameCC + "' src=../../images/dblclick.gif onclick=javascript:GetCostCategory(" + CType(m_intParentTask_UID, String) + "," + CType(m_intCount1, String) + ") ></td>"
                        'Args.StringToBeInserted = "<td align='center' width=10%><input type='text' id='" + strNameCC + "' name='" + strNameCC + "' class='clsTextBoxReadOnly' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CostCategory"), ""), String).Trim + "' ><img Border=0 src = '../../images/dblclick.gif'  name='" + strTxtNameCC + "'  onclick=""JavaScript:GetCostCategory(" + CType(m_intParentTask_UID, String) + "," + CType(m_intCount1, String) + ")""  /></td>"
                        'Args.StringToBeInserted = "<td align='center' width=10%>CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableID", "txtDeliverableID", , 200, , CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader('CostCategory'), ''), String).Trim, , , True, True, , , , True))<img Border=0 src = '../../images/dblclick.gif'  name='" + strTxtNameCC + "'  onclick=""JavaScript:GetCostCategory(" + CType(m_intParentTask_UID, String) + "," + CType(m_intCount1, String) + ")""  /></td>"
                        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                        Args.StringToBeInserted = CommonFunctions.HTMLControls.DrawTextBox(strNameCC, strNameCC, , 200, , CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CostCategory"), ""), String).Trim, , , True, True, , , , True, EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                        Args.StringToBeInserted = "<TD>&nbsp;</TD><TD>&nbsp;</TD>"
                    Else
                        m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer)
                        m_intTaskID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String)

                        ''Added By ManishK on 12th Jan 06 To add Employee filter
                        m_intEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), "0"), String)
                        ''End of Added By ManishK on 12th Jan 06 To add Employee filter

                        m_intCount1 = m_intCount1 + 1
                        strNameCC = "txtCC" + CType(m_intParentTask_UID, String) + "_" + m_intTaskID
                        strTxtName = "imgCC" + CType(m_intParentTask_UID, String) + "_" + m_intTaskID
                        'Args.StringToBeInserted = "<td align='center' width=10%><input type='text' id='" + strNameCC + "' name='" + strNameCC + "' class='clsTextBoxReadOnly'  value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CostCategory"), ""), String).Trim + "' " + strAttributesCC + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HasChildTasks"), "0"), String) + ")><input type=image name='" + strTxtNameCC + "' src=../../images/dblclick.gif onclick=javascript:GetCostCategory(" + CType(m_intParentTask_UID, String) + "," + CType(m_intTaskID, String) + ") ></td>"
                        'Args.StringToBeInserted = "<td align='center' width=10%><input type='text' id='" + strNameCC + "' name='" + strNameCC + "' class='clsTextBoxReadOnly' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CostCategory"), "0"), String).Trim + "' ><img Border=0 src = '../../images/dblclick.gif'  name='" + strTxtNameCC + "'  onclick=""JavaScript:GetCostCategory(" + CType(m_intParentTask_UID, String) + "," + CType(m_intTaskID, String) + ")""  /></td>"
                        Args.StringToBeInserted = "<td align='center' width=10%>"
                        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                        Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox(strNameCC, strNameCC, , 200, , CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CostCategory"), ""), String).Trim, , , True, True, , , , True, EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                        Args.StringToBeInserted += "<img Border=0 src = '../../images/dblclick.gif'  name='" + strTxtNameCC + "'  onclick=""JavaScript:GetCostCategory(" + CType(m_intParentTask_UID, String) + "," + CType(m_intTaskID, String) + "," + CType(m_intEmployeeID, String) + ")""  /></td>"
                    End If
                Else

                    m_intTaskID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String)

                    ''Added By ManishK on 12th Jan 06 To add Employee filter
                    m_intEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), "0"), String)
                    ''End of Added By ManishK on 12th Jan 06 To add Employee filter

                    m_intCount1 = m_intCount1 + 1
                    strNameCC = "txtCC0_" + m_intTaskID
                    'Args.StringToBeInserted = "<td align='center' width=10%><input type='text' id='" + strNameCC + "' name='" + strNameCC + "' class='clsTextBoxReadOnly' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CostCategory"), ""), String).Trim + "' " + strAttributesCC + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HasChildTasks"), "0"), String) + ")><input type=image name='" + strTxtNameCC + "' src=../../images/dblclick.gif onclick=javascript:GetCostCategory(" + CType(m_intParentTask_UID, String) + "," + CType(m_intTaskID, String) + ") ></td>"
                    Args.StringToBeInserted = "<td align='center' width=10%>"
                    'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox(strNameCC, strNameCC, , 200, , CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CostCategory"), ""), String).Trim, , , True, True, , , , True, EnableHTMLEncode:=True)
                    'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    Args.StringToBeInserted += "<img Border=0 src = '../../images/dblclick.gif'  name='" + strTxtNameCC + "'  onclick=""JavaScript:GetCostCategory(" + CType(m_intParentTask_UID, String) + "," + CType(m_intTaskID, String) + "," + CType(m_intEmployeeID, String) + ")""  /></td>"
                End If

            Case "Apply"
                Cancel = True
                If m_strTaskType = TASK_TYPE_ASSIGNED Or m_strTaskType = TASK_TYPE_REVIEW Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Apply"), "0"), Boolean) = True Then
                        strAttributes = " disabled checked"
                    Else
                        strAttributes = ""
                    End If
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer) = 0 Then
                        m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer)
                        m_intCount = 0
                        strName = "chk" + CType(m_intParentTask_UID, String) + "_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Integer).ToString
                        strTxtName = "txt" + CType(m_intParentTask_UID, String) + "_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Integer).ToString
                        Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' " + strAttributes + " onclick='javascript:CheckChildTasks(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HasChildTasks"), "0"), String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Apply"), "0"), String) + "'></td>"
                        Args.StringToBeInserted = ""
                    Else
                        m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer)
                        m_intTaskID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String)
                        m_intCount = m_intCount + 1
                        strName = "chk" + CType(m_intParentTask_UID, String) + "_" + CType(m_intTaskID, String)
                        strTxtName = "txt" + CType(m_intParentTask_UID, String) + "_" + CType(m_intTaskID, String)
                        Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' " + strAttributes + " onclick='javascript:CheckTask(" + CType(m_intParentTask_UID, String) + "," + CType(m_intTaskID, String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Apply"), "0"), String) + "'></td>"
                    End If
                Else
                    m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer)
                    m_intTaskID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String)
                    m_intCount = m_intCount + 1
                    strName = "chk0_" + m_intTaskID
                    Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' onclick='javascript:CheckTask(0, " + CType(m_intTaskID, String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Apply"), "0"), String) + "'></td>"
                End If

            Case "Start Date", "End_Date"
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataFieldValue, ""), String) <> "" Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD align=left valign=top>" + CType(CommonFunctions.Dates.CGetDate(CType(Args.DataFieldValue, Date)), String) + "</TD>"
                End If
        End Select

    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint

        If m_strTaskType = TASK_TYPE_ASSIGNED Or m_strTaskType = TASK_TYPE_REVIEW Then
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer) = 0 Then
                m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Integer)
                Args.clsTR = "clsTRSectionHeader"
            End If
        End If

    End Sub

#End Region

End Class
