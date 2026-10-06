'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  PbNITE
' Module Name           :  PM_ScheduleList.aspx
' Purpose               :  To display the list of Schedule and tasks associated with it
' Description           :  
' Dependencies          :  None
' Author                :  RajkumarM
' Reviewed              :  
' Tested                :  
' Created               :  12th Sep 2004
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

Public Class PM_ScheduleList
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name 	        : ScheduleList.asp	
    ' Purpose				: To display the list of Schedule and tasks associated with it
    ' Description			: To display the list of Schedule and tasks associated with it
    ' Assumptions			: The stored procedures, and tables are present.
    ' Dependencies			: CommonFunctions.asp	
    ' Author				: RajkumarM
    ' Created				: 13th Sept 2004	
    ' Revisions				:	
    '=====================================================================

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

#End Region

  #Region "PageEvents"
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        If IsPostBack Then
            m_intDeliveriableTypeID = CommonFunctions.General.CheckIsNothing(Request.Form("cboDeliveriable"), "")
            m_intDept = CommonFunctions.General.CheckIsNothing(Request.Form("cboDepartment"), "")
            m_intSystemID = CommonFunctions.General.CheckIsNothing(Request.Form("cboSystem"), "")
            m_intResourceID = CommonFunctions.General.CheckIsNothing(Request.Form("cboResource"), "")
            m_intGroupID = CommonFunctions.General.CheckIsNothing(Request.Form("cboGroup"), "")
            m_intPackageID = CommonFunctions.General.CheckIsNothing(Request.Form("cboPackage"), "")
        Else
            m_intDeliveriableTypeID = ""
            m_intDept = ""
            m_intSystemID = ""
            m_intResourceID = ""
            m_intGroupID = ""
            m_intPackageID = ""
        End If

        Initialize()
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

    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.

    Private strMenu As String                           'stores the static menu string.
    Private m_intProjectID As Integer                   'Project ID
    Protected m_strWindowTitle As String                'Page Title
    Protected m_intDeliveriableTypeID, m_intDept, m_intSystemID, m_intResourceID, m_intGroupID, m_intPackageID As String

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
        ' Author                :   RajkumarM
        ' Created               :   12th Sep 2004
        ' Revisions             :   
        '=====================================================================

        '######### Page Code starts here

        'This will initialize all the global objects.

        Call GetGlobalObject()
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table class='clsBorderTable' height='520' cellSpacing='0' cellPadding='0' width='99.9%' align='center' border='0'><tbody><tr><td vAlign='top' height='320'>")

        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'Display the page caption.
        DrawPageCaption()
        'Display the Header if exist. 
        DrawHeader()

        '--- Display filters for selection
        DisplaySelectionHeader()

        '--- Display Grid with tasks 
        DisplayGrid()

        HttpContext.Current.Response.Write("</DIV>")

        'Display the Menu at the Bottom
        'CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        'CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("</td></tr></table>")
        DisposeObjects()
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
        ' Author                :  RajkumarM
        ' Created               :  12th Sep 2004
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub
    Private Sub Initialize()
        Dim strSQLQuery As String

        m_strWindowTitle = MyBase.GetResourceString("HEADING_WBS")

        '--- ProjectID
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")) <> "" Then
            m_intProjectID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")), Integer)
        Else
            m_intProjectID = CInt(Session("intProjectID"))
        End If

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
        ' Author                : RajkumarM
        ' Created               : 12th Sep 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strGrid As String

        arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick(2187)")

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
        ' Author                : RajkumarM
        ' Created               : 12th Sep 2004
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

    Private Sub DisplaySelectionHeader()

        '====================================================================
        ' Procedure Name        :   DisplaySelectionHeader
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw selection Header
        ' Description           :   This procedure is used to draw combos for selection criteria.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   RajkumarM
        ' Created               :   12th Sep 2004
        ' Revisions             :   Added comments for removing combo box of
        '                           1. Knowledge area and
        '                           2. Group
        ' Revised By            :   Swapnil Ranjankar
        ' Revised On            :   29th Oct 2004
        '=====================================================================

        Dim strSQLQuery As String
        Dim objDynamicLink As WebPages.UI.cDynamicLink
        Dim intDeliverableTypeID As Integer
        Dim intDept As Integer
        Dim drFieldLabels As IDataReader
        Dim strlblprjSystem As String
        Dim strlblprjComponent As String
        Dim strlblprjSite As String


        strSQLQuery = "SELECT FieldName, Label FROM tbl_CNF_ConfigFieldName "
        drFieldLabels = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        While drFieldLabels.Read()
            Select Case CType(drFieldLabels("FieldName"), String)
                Case "Project Site"
                    strlblprjSite = Trim(CType(drFieldLabels("Label"), String))
                Case "Work Package"
                    strlblprjComponent = Trim(CType(drFieldLabels("Label"), String))
                Case "System"
                    strlblprjSystem = Trim(CType(drFieldLabels("Label"), String))
            End Select
        End While

        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        CommonFunction.Data.DisposeDataReader(drFieldLabels)
        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        '--- Display the Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("HEADING_WBS"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        '--- Display the Project combo, dates and option buttons for selection
        CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")

        '--- Deliverable Combo
        strSQLQuery = "EXEC usp_sel_tbl_pm_schedules " + CType(Session("intProjectID"), String)
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='Left'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_DELIVERABLE"))
        CommonFunctions.General.WriteHTML("</td><td>")
        CommonFunctions.HTMLControls.DrawComboBox("cboDeliveriable", strSQLQuery, 150, CType(m_intDeliveriableTypeID, String), "", True)
        CommonFunctions.General.WriteHTML("</td>")

        '-- Department Combo
        strSQLQuery = "EXEC usp_Sel_tbl_PM_ProjectDepartments " + CType(Session("intProjectID"), String)
        CommonFunctions.General.WriteHTML("<td align='Left'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_DEPARTMENT"))
        CommonFunctions.General.WriteHTML("</td><td>")
        CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", strSQLQuery, 150, CType(m_intDept, String), "", True)
        CommonFunctions.General.WriteHTML("</td><td></td>")

        'Start of comments by SwapnilR 
        '-- Project System
        'strSQLQuery = "usp_Sel_tbl_PM_ProjectSystems " + CType(Session("intProjectID"), String)
        'CommonFunctions.General.WriteHTML("<td align='Left' width='25%'>")
        'CommonFunctions.General.WriteHTML(strlblprjSystem)
        ''CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_DEPARTMENT"))
        'CommonFunctions.General.WriteHTML("</td><td>")
        'CommonFunctions.HTMLControls.DrawComboBox("cboSystem", strSQLQuery, 150, CType(m_intSystemID, String), "", True)
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td>&nbsp;</td>")
        'End of comments by SwapnilR

        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        ' Added parameter for AllowDeferredTaskCreation
        '--- Resource Combo
        strSQLQuery = "EXEC usp_Sel_TeamMembers_TaskAssignment " + CType(Session("intProjectID"), String)
        strSQLQuery += ", null , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, 1, 0).ToString()
        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='Left'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_RESOURCE"))
        CommonFunctions.General.WriteHTML("</td><td>")
        CommonFunctions.HTMLControls.DrawComboBox("cboResource", strSQLQuery, 150, CType(m_intResourceID, String), "", True)
        CommonFunctions.General.WriteHTML("</td>")

        'Start of comments by SwapnilR
        ''-- Group Combo
        'strSQLQuery = "EXEC usp_Sel_PM_GroupList "
        'CommonFunctions.General.WriteHTML("<td align='Left'>")
        'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_GROUP"))
        'CommonFunctions.General.WriteHTML("</td><td>")
        'CommonFunctions.HTMLControls.DrawComboBox("cboGroup", strSQLQuery, 150, CType(m_intGroupID, String), "", True)
        'CommonFunctions.General.WriteHTML("</td>")
        'End of comments by SwapnilR

        '-- Project Packages Combo

        'Modified By NitinVS on 28 Mar 2005 for PBNITE SP2 IssueId = 16975 
        ' The Project parameter is passed to the SP 
        'strSQLQuery = "EXEC usp_sel_tbl_pm_projectpackages "
        strSQLQuery = "EXEC usp_sel_tbl_pm_projectpackages " + CType(Session("intProjectID"), String)
        ' End Modification By NitinVS on 28 Mar 2005 for PBNITE SP2 IssueId = 16975 

        CommonFunctions.General.WriteHTML("<td align='Left' >")
        CommonFunctions.General.WriteHTML(strlblprjComponent)
        'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_GROUP"))
        CommonFunctions.General.WriteHTML("</td><td>")
        CommonFunctions.HTMLControls.DrawComboBox("cboPackage", strSQLQuery, 150, CType(m_intPackageID, String), "", True)
        CommonFunctions.General.WriteHTML("</td>")

        '--- Display the Show Link
        'Display the Show Link
        CommonFunctions.General.WriteHTML("<td align=center>")
        objDynamicLink = New WebPages.UI.cDynamicLink
        objDynamicLink.LinkName = MyBase.GetResourceString("LABEL_SHOW")
        objDynamicLink.Tooltip = MyBase.GetResourceString("LABEL_SHOW_TOOLTIP")
        objDynamicLink.FunctionName = "Show_OnClick()"
        objDynamicLink.ReturnHTML = True
        CommonFunctions.General.WriteHTML(" | <B>" + objDynamicLink.GetDynamicLink() + "</B> | ")
        objDynamicLink = Nothing
        CommonFunctions.General.WriteHTML("</td></tr></table>")
        'CommonFunctions.General.WriteHTML("<BR>")

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

    Private Sub DisplayGrid()


        '====================================================================
        ' Procedure Name        :   DisplayGrid
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw grid
        ' Description           :   This procedure is used to draw grid on the page.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   RajkumarM
        ' Created               :   12th Sep 2004
        ' Revisions             :   
        '=====================================================================

        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""
        Dim strTaskName, strType, strResource, strStartDate, strEndDate, strActualStartDate, strActualEnddate As String
        Dim intWork, intPercentComplete, intActualWork As Double
        Dim blnTaskComplete As Boolean
        Dim strQuery, strColor As String
        Dim drGetWBSDeliveriables, drTask, drSubTask As IDataReader

        If m_intDeliveriableTypeID = "" Then
            strQuery = m_intProjectID & ",Null"
        Else
            strQuery = m_intProjectID & ",  " & m_intDeliveriableTypeID
        End If

        If m_intDept = "" Then
            strQuery = strQuery & " , Null "
        Else
            strQuery = strQuery & "," & m_intDept
        End If
        If m_intSystemID = "" Then
            strQuery = strQuery & " , Null "
        Else
            strQuery = strQuery & "," & m_intSystemID
        End If
        If m_intResourceID = "" Then
            strQuery = strQuery & " , Null "
        Else
            strQuery = strQuery & "," & m_intResourceID
        End If
        If m_intGroupID = "" Then
            strQuery = strQuery & " , Null "
        Else
            strQuery = strQuery & "," & m_intGroupID
        End If

        strQuery = strQuery & " , Null "
        If m_intPackageID = "" Then
            strQuery = strQuery & " , Null "
        Else
            strQuery = strQuery & "," & m_intPackageID
        End If

        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table CellSpacing=0 Border=0 width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class=clsTREven>	")
        CommonFunctions.General.WriteHTML("<td width='4%' align=left>" + MyBase.GetResourceString("LEGEND") + "</td>")
        CommonFunctions.General.WriteHTML("<td width='3%' align=left>" + MyBase.GetResourceString("LEGEND_OVERDUE_TASKS") + "</td>")
        CommonFunctions.General.WriteHTML("<td width='1%' bgcolor=red>")
        CommonFunctions.General.WriteHTML("<td width='4%' align=left>&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("LEGEND_COMPLETED_TASKS") + "</td>")
        CommonFunctions.General.WriteHTML("<td width='1%' bgcolor=green>")
        CommonFunctions.General.WriteHTML("<td width='4%' align=left>&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("LEGEND_TASKS_NOT_STARTED") + "</td>")
        CommonFunctions.General.WriteHTML("<td width='1%' bgcolor=blue>")
        CommonFunctions.General.WriteHTML("<td width='4%' align=left>&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("LEGEND_IN_PROGRESS_TASKS") + "</td>")
        CommonFunctions.General.WriteHTML("<td width='1%' bgcolor=black>")
        CommonFunctions.General.WriteHTML("</td>&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")

        Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto; Height=66%'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table cellSpacing='1' cellPadding='0' width='99.9%' align='center' border='0'>")
        CommonFunctions.General.WriteHTML("<tbody>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='clsTDHeader' align='center' width='27%' wrap>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GRID_DELIVERABLE_TASK"))
        CommonFunctions.General.WriteHTML("</td><td class='clsTDHeader' align='center' width='10%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GRID_TYPE"))
        CommonFunctions.General.WriteHTML("</td><td class='clsTDHeader' align='center' width='20%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GRID_RESOURCE"))
        CommonFunctions.General.WriteHTML("</td><td class='clsTDHeader' align='center' width='10%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GRID_WORK_HRS"))
        CommonFunctions.General.WriteHTML("</td><td class='clsTDHeader' align='center' width='13%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GRID_START_DATE"))
        CommonFunctions.General.WriteHTML("</td><td class='clsTDHeader' align='center' width='13%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GRID_END_DATE"))
        CommonFunctions.General.WriteHTML("</td><td class='clsTDHeader' align='center' width='7%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GRID_PERCENTAGE_COMPLETE"))
        CommonFunctions.General.WriteHTML("</td></tr>")

        Dim iRowLoop, intDelTypeID, intDelID As Integer
        Dim intdrTaskRecordCount As Integer

        ' Get List of deliverables
        strSQLQuery = "EXEC usp_Sel_tbl_PM_WBSDeliveriables " & strQuery
        drGetWBSDeliveriables = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        iRowLoop = 0
        While drGetWBSDeliveriables.Read()
            intDelTypeID = CType(drGetWBSDeliveriables("DeliverableTypeID"), Integer)
            intDelID = CType(drGetWBSDeliveriables("UniqueID"), Integer)
            strTaskName = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("TaskName"), ""), String)
            strType = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("Type"), ""), String)
            strResource = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("Resource"), ""), String)
            strStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("StartDate"), ""), String)
            strEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("EndDate"), ""), String)
            intWork = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("WorkHours"), "0"), Double)
            intActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("ActualWork"), "0"), Double)

            If strStartDate <> "" Then
                strStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strStartDate))
            End If

            If strEndDate <> "" Then
                strEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(strEndDate))
            End If

            drTask = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_WBSTasks  " & strQuery & "," & intDelTypeID & "," & intDelID, MyBase.UseSQL)

            intdrTaskRecordCount = 0
            While drTask.Read()
                intdrTaskRecordCount = intdrTaskRecordCount + 1
            End While
            CommonFunctions.Data.DisposeDataReader(drTask)


            drTask = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_WBSTasks  " & strQuery & "," & intDelTypeID & "," & intDelID, MyBase.UseSQL)
            CommonFunctions.General.WriteHTML("<tr>")

            If intdrTaskRecordCount > 0 Then

                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=left width='27%' wrap>")
                CommonFunctions.General.WriteHTML("<a href='javascript:DisplayDeliverableDetails(" & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("DeliverableTypeID"), ""), String))
                CommonFunctions.General.WriteHTML("," & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("UniqueID"), ""), String) & ")'>")
                CommonFunctions.General.WriteHTML("<img ID='imgAttachments" & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("DeliverableTypeID"), ""), String) & "U" & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("UniqueID"), ""), String) & "'")
                CommonFunctions.General.WriteHTML("src='..\..\images\Plus.gif' border='0' alt='View Task Details' align='left' WIDTH='10' HEIGHT='10'> </a>")
                'CommonFunctions.General.WriteHTML("<A href='#' onclick='javascript:EditDeliverableTasks(" & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("DeliverableTypeID"), ""), String) & "," & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("UniqueID"), ""), String) & ")'></A>")
                CommonFunctions.General.WriteHTML(strTaskName & "</td>")
            Else
                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=left width=27%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
                CommonFunctions.General.WriteHTML(strTaskName & "</td>")
            End If

            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=left width=10%>")
            CommonFunctions.General.WriteHTML(strType & "</td>")

            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=left width=20%>")
            CommonFunctions.General.WriteHTML(strResource & "</td>")

            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=right width=10%>")
            CommonFunctions.General.WriteHTML(intWork & "<br>" & intActualWork & "</td>")

            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=right width=13%>")
            CommonFunctions.General.WriteHTML(strStartDate & "</td>")

            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=right width=13%>")
            CommonFunctions.General.WriteHTML(strEndDate & "</td>")

            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=7%></td>")

            CommonFunctions.General.WriteHTML("</tr>")

            If intdrTaskRecordCount > 0 Then

                CommonFunctions.General.WriteHTML("<tr id='tblTask" & intDelTypeID & "U" & intDelID & "' style='display:none'>")

                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' colspan='8'>")
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                CommonFunctions.General.WriteHTML("<table cellSpacing='1' cellPadding='0' width='99.9%' border='0'>")
                CommonFunctions.General.WriteHTML("<tbody>")

                While drTask.Read()
                    strTaskName = CType(CommonFunctions.Data.CheckIsDBNull(drTask("TaskName"), ""), String)
                    strType = CType(CommonFunctions.Data.CheckIsDBNull(drTask("Type"), ""), String)
                    strResource = CType(CommonFunctions.Data.CheckIsDBNull(drTask("Resource"), ""), String)
                    strStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("StartDate"), ""), String)
                    strEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("EndDate"), ""), String)
                    strActualStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualStartDate"), ""), String)
                    strActualEnddate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualEndDate"), ""), String)
                    intWork = CType(CommonFunctions.Data.CheckIsDBNull(drTask("WorkHours"), "0"), Double)
                    intActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualWork"), "0"), Double)
                    intPercentComplete = CType(CommonFunctions.Data.CheckIsDBNull(drTask("PercentComplete"), "0"), Integer)
                    blnTaskComplete = CType(CommonFunctions.Data.CheckIsDBNull(drTask("IsTaskComplete"), "0"), Boolean)

                    If strStartDate <> "" Then
                        strStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strStartDate))
                    End If

                    If strEndDate <> "" Then
                        strEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(strEndDate))
                    End If

                    If strActualStartDate <> "" Then
                        strActualStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strActualStartDate))
                    End If

                    If strActualEnddate <> "" Then
                        strActualEnddate = CommonFunctions.Dates.CGetDate(Date.Parse(strActualEnddate))
                    End If


                    drSubTask = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_WBSTasks  " & strQuery & "," & intDelTypeID & "," & intDelID & ",0," & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer), MyBase.UseSQL)

                    intdrTaskRecordCount = 0
                    While drSubTask.Read()
                        intdrTaskRecordCount = intdrTaskRecordCount + 1
                    End While

                    CommonFunctions.Data.DisposeDataReader(drSubTask)

                    drSubTask = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_WBSTasks  " & strQuery & "," & intDelTypeID & "," & intDelID & ",0," & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer), MyBase.UseSQL)

                    If blnTaskComplete = True Then
                        strColor = "green"
                    ElseIf strActualStartDate = "" Then
                        strColor = "blue"
                        'Modified BY NitinVS on 29 Mar 2005 for PBNITE SP2 
                        ' The Page Crashes When the End Date is null 

                    ElseIf CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTask("EndDate"), ""), "") <> "" Then
                        If (DateDiff(DateInterval.Day, CType(CommonFunction.Data.CheckIsDBNull(drTask("EndDate"), ""), DateTime), Today()) > 0) Then
                            strColor = "red"
                        Else
                            strColor = "black"
                        End If
                    Else
                        strColor = "black"
                    End If
                    ' End Modification By NitinVS on 29 Mar 2005 for PBNITE SP2

                    CommonFunctions.General.WriteHTML("<tr><td class='clstdodd' width=5% align=right></td>")

                    If intdrTaskRecordCount > 0 Then
                        CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=left width=22% ><a href='javascript:DisplayTaskDetails(" & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer) & ")'>")
                        CommonFunctions.General.WriteHTML("<img ID='imgAttachments" & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer) & "' src='..\..\images\Plus.gif' border='0' alt='View Resource Task Details' align='left' WIDTH='10' HEIGHT='10'></a>")
                        CommonFunctions.General.WriteHTML("<font color=" & strColor & ">" & strTaskName & "</font></td>")

                    Else
                        CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=left width=22% ><font color=" & strColor & ">" & strTaskName & "</font></td>")
                    End If

                    CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=10% align=left><font color=" & strColor & ">" & strType & "</font></td>")
                    CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=20% align=left><font color=" & strColor & ">" & strResource & "</font></td>")
                    CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=10% align=right><font color=" & strColor & ">" & intWork & "<BR>" & intActualWork & "</font></td>")
                    CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=13% align=right><font color=" & strColor & ">" & strStartDate & "<BR>" & strActualStartDate & "</font></td>")
                    CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=13% align=right><font color=" & strColor & ">" & strEndDate & "<BR>" & strActualEnddate & "</font></td>")
                    CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=7% align=right><font color=" & strColor & ">" & intPercentComplete & "</font></td>")
                    CommonFunctions.General.WriteHTML("</tr>")

                    If intdrTaskRecordCount > 0 Then
                        CommonFunctions.General.WriteHTML("<tr id='tblSubTask" & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer) & "' style='display:none' >")
                        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                        CommonFunctions.General.WriteHTML("<td class='clsTDOdd' colspan='8'><table cellSpacing='1' cellPadding='0' width='99.9%' border='0'><tbody>")

                        While drSubTask.Read

                            strTaskName = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("TaskName"), ""), String)
                            strType = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("Type"), ""), String)
                            strResource = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("Resource"), ""), String)
                            strStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("StartDate"), ""), String)
                            strEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("EndDate"), ""), String)
                            strActualStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("ActualStartDate"), ""), String)
                            strActualEnddate = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("ActualEndDate"), ""), String)
                            intWork = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("WorkHours"), "0"), Double)
                            intActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("ActualWork"), "0"), Double)
                            blnTaskComplete = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("IsTaskComplete"), "0"), Boolean)

                            If strStartDate <> "" Then
                                strStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strStartDate))
                            End If

                            If strEndDate <> "" Then
                                strEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(strEndDate))
                            End If

                            If strActualStartDate <> "" Then
                                strActualStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strActualStartDate))
                            End If
                            If strActualEnddate <> "" Then
                                strActualEnddate = CommonFunctions.Dates.CGetDate(Date.Parse(strActualEnddate))
                            End If

                            intPercentComplete = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("PercentComplete"), "0"), Integer)

                            If blnTaskComplete = True Then
                                strColor = "green"
                            ElseIf strActualStartDate = "" Then
                                strColor = "blue"
                                'Modified BY NitinVS on 29 Mar 2005 for PBNITE SP2 
                                ' The Page Crashes When the End Date is null 

                            ElseIf CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTask("EndDate"), ""), "") <> "" Then
                                If (DateDiff(DateInterval.Day, CType(CommonFunction.Data.CheckIsDBNull(drTask("EndDate"), ""), DateTime), Today()) > 0) Then
                                    strColor = "red"
                                Else
                                    strColor = "black"
                                End If
                            Else
                                strColor = "black"
                            End If
                            ' End Modification By NitinVS on 29 Mar 2005 for PBNITE SP2
                            CommonFunctions.General.WriteHTML("<tr>")
                            CommonFunctions.General.WriteHTML("<td class='clstdodd' width=7% align=right></td>")
                            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=20% align=left><font color=" & strColor & ">" & strTaskName & "</font></td>")
                            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=10% align=left><font color=" & strColor & ">" & strType & "</font></td>")
                            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=20% align=left><font color=" & strColor & ">" & strResource & "</font></td>")

                            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=10% align=right><font color=" & strColor & ">" & intWork & "<BR>" & intActualWork & "</font></td>")
                            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=13% align=right><font color=" & strColor & ">" & strStartDate & "<BR>" & strActualStartDate & "</font></td>")
                            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=13% align=right><font color=" & strColor & ">" & strEndDate & "<BR>" & strActualEnddate & "</font></td>")
                            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=7% align=right><font color=" & strColor & ">" & intPercentComplete & "</font></td>")
                            CommonFunctions.General.WriteHTML("</tr>")
                        End While

                        CommonFunctions.General.WriteHTML("</tbody></table></td></tr>")
                    End If
                    CommonFunction.Data.DisposeDataReader(drSubTask)
                End While
                CommonFunctions.General.WriteHTML("</tbody></table></td></tr>")
            End If

            CommonFunctions.Data.DisposeDataReader(drTask)
            CommonFunctions.Data.DisposeDataReader(drSubTask)
        End While
        CommonFunction.Data.DisposeDataReader(drGetWBSDeliveriables)
        CommonFunctions.General.WriteHTML("</tbody></table>")
    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("AppResources.PM_ScheduleList", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region
End Class
