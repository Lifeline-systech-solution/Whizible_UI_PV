'=====================================================================
' Project Name          :  WhizibleSEM 
' Module Name           :  PM_DeliverableTracking.aspx
' Purpose               :  To display the list of Schedule(Deliverables)
' Dependencies          :  Tables and USP's used in this Page.
' Author                :  SandeepA
' Reviewed              :  
' Created               :  23 Nov,2005
'=====================================================================
Option Strict On

'Import References
#Region "Imports"
Imports CommonFunctions
Imports System
Imports System.Data
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class PM_DeliverableTracking
    Inherits WebPages.Template.WhizTemplate

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
        '=====================================================================
        ' Procedure Name        :	Page_Load
        ' Purpose               :	Initializes teh global object
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SandeepA
        ' Created               :	23 Nov,2005
        ' Revisions             :
        '=====================================================================


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
            m_strDate = CommonFunctions.General.CheckIsNothing(Request.Form("dtDate"), "")
        Else
            m_intDeliveriableTypeID = ""
            m_intDept = ""
            m_intSystemID = ""
            m_intResourceID = ""
            m_intGroupID = ""
            m_intPackageID = ""
            m_strDate = ""
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
    'Global Variables Declared
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.
    Private strMenu As String                           'stores the static menu string.
    Private m_intProjectID As Integer                   'Project ID
    Protected m_strWindowTitle As String                'Page Title
    Protected m_intDeliveriableTypeID, m_intDept, m_intSystemID, m_intResourceID, m_intGroupID, m_intPackageID As String
    Protected m_strDate As String
    Protected iRowLoop As Integer

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
        ' Author                : SandeepA
        ' Created               : 23 Nov,2005
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
        ' Author                :   SandeepA
        ' Created               :   23 Nov,2005
        ' Revisions             :   
        '=====================================================================

        '######### Page Code starts here

        'This will initialize all the global objects.

        Call GetGlobalObject()

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
        CommonFunctions.General.WriteHTML("</td></tr></table>")
        CommonFunctions.General.WriteHTML(strMenu)
        'Display the Menu at the Bottom


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
        ' Author                :  SandeepA
        ' Created               :  23 Nov,2005
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        :	Initialize
        ' Purpose               :	Initializes the Page
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SandeepA
        ' Created               :	23 Nov,2005
        ' Revisions             :
        '=====================================================================

        Dim strSQLQuery As String

        'Get Window Title
        m_strWindowTitle = MyBase.GetResourceString("HEADING_WBS")

        '--- Get ProjectID
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
        ' Author                : SandeepA
        ' Created               : 23 Nov,2005
        ' Revisions             :
        '=====================================================================

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strGrid As String

        'Get the Menu from Resource File
        arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick(3097)")

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
        ' Author                : SandeepA
        ' Created               : 23 Nov,2005
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
        ' Author                : SandeepA
        ' Created               : 23 Nov,2005
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        'Initialize HeaderFooter ssObject
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
        ' Purpose               :   To draw selection Header (i.e. Filters)
        ' Description           :   This procedure is used to draw combos for selection criteria.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   SandeepA
        ' Created               :   23 nov,2005
        ' Revisions             :   
        ' Revised By            :   
        ' Revised On            :   
        '=====================================================================

        Dim strSQLQuery As String
        Dim objDynamicLink As WebPages.UI.cDynamicLink
        Dim intDeliverableTypeID As Integer
        Dim intDept As Integer
        Dim drFieldLabels As IDataReader
        Dim strlblprjSystem As String
        Dim strlblprjComponent As String
        Dim strlblprjSite As String


        'Get the Field name from tbl_CNF_ConfigFieldName

        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQLQuery = "SELECT FieldName, Label FROM tbl_CNF_ConfigFieldName "
        strSQLQuery = "usp_sel_tbl_CNF_ConfigFieldName_FieldName_Label"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

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

        '--- Deliverable Combo (Row-1)
        strSQLQuery = "EXEC usp_sel_tbl_pm_schedules " + CType(Session("intProjectID"), String)
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='Left'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_DELIVERABLE"))
        CommonFunctions.General.WriteHTML("</td><td>")
        CommonFunctions.HTMLControls.DrawComboBox("cboDeliveriable", strSQLQuery, 150, CType(m_intDeliveriableTypeID, String), "onChange=""cboChange()""", True)
        CommonFunctions.General.WriteHTML("</td>")

        'Modified by MrugajaB on 6th March 2006 for Issue ID.708
        'Purpose:Department combo is made hidden as it is not required
        '-- Department Combo (Row-1)
        strSQLQuery = "EXEC usp_Sel_tbl_PM_ProjectDepartments " + CType(Session("intProjectID"), String)
        CommonFunctions.General.WriteHTML("<td align='Left' style='display:none'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_DEPARTMENT"))
        CommonFunctions.General.WriteHTML("</td><td style='display:none'>")
        CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", strSQLQuery, 150, CType(m_intDept, String), "onChange=""cboChange()""", True)
        CommonFunctions.General.WriteHTML("</td><td></td>")
        'End Modification

        '--- Resource Combo (Row-2)
        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        ' Added parameter for AllowDeferredTaskCreation
        strSQLQuery = "EXEC usp_Sel_TeamMembers_TaskAssignment " + CType(Session("intProjectID"), String)
        strSQLQuery += ", null , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, 1, 0).ToString()
        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        'CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='Left'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_RESOURCE"))
        CommonFunctions.General.WriteHTML("</td><td>")
        CommonFunctions.HTMLControls.DrawComboBox("cboResource", strSQLQuery, 150, CType(m_intResourceID, String), "onChange=""cboChange()""", True)
        CommonFunctions.General.WriteHTML("</td>")

        'Modified by MrugajaB on 6th March 2006 for Issue ID.708
        'Purpose:Package combo is made hidden as it is not required
        '--- Package Combo (Row-2)
        strSQLQuery = "EXEC usp_sel_tbl_pm_projectpackages " + CType(Session("intProjectID"), String)
        CommonFunctions.General.WriteHTML("<td align='Left' style='display:none'>")
        CommonFunctions.General.WriteHTML(strlblprjComponent)
        CommonFunctions.General.WriteHTML("</td><td style='display:none'>")
        CommonFunctions.HTMLControls.DrawComboBox("cboPackage", strSQLQuery, 150, CType(m_intPackageID, String), "onChange=""cboChange()""", True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr></table>")
        'End Modification


        '---Date Control (Row-3)
        CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='Left'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_DATE"))
        CommonFunction.General.WriteHTML("&nbsp;&nbsp;")
        CommonFunctions.HTMLControls.DrawDateControl("dtDate", "dtDate", , , m_strDate, , "frmPM_DeliverableTracking", , , , , , , , , , )
        CommonFunctions.General.WriteHTML("</td><td colspan=1></td></tr>")


        '--- Display the Show Link (Row-3)
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        'Legend for Date Control (Row-3)
        CommonFunctions.General.WriteHTML("<td align='Left' wrap>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE_DATE"))
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td align=center>")
        objDynamicLink = New WebPages.UI.cDynamicLink
        objDynamicLink.LinkName = MyBase.GetResourceString("LABEL_SHOW")
        objDynamicLink.Tooltip = MyBase.GetResourceString("LABEL_SHOW_TOOLTIP")
        objDynamicLink.FunctionName = "Show_OnClick()"
        objDynamicLink.ReturnHTML = True
        CommonFunctions.General.WriteHTML(" | <B>" + objDynamicLink.GetDynamicLink() + "</B> | ")
        objDynamicLink = Nothing
        CommonFunctions.General.WriteHTML("</td></tr></table>")
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
        ' Author                : SandeepA
        ' Created               : 23 Nov,2005
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
        ' Author                :   SandeepA
        ' Created               :   23 Nov,2005
        ' Revisions             :   
        '=====================================================================

        Dim strSQLQuery As String = ""
        Dim strSQLTaskQuery As String
        Dim strWhereClause As String = ""
        Dim strTaskName, strType, strResource, strStartDate, strEndDate, strActualStartDate, strActualEnddate As String
	'integrated by harshada d
	'ADDED BY AMITJ FOR FLEXCEL ISSUEID 2520
        Dim strStartDate1, strEndDate1, strActualStartDate1, strActualEnddate1 As String
        'END OFADDITION
        'end integration

        'Added & Commented By Dipali V On 15th July 2020 isssues id 25505
        'Dim intWork, intPercentComplete, intActualWork As Double
        Dim intWork, intActualWork As String
        Dim intPercentComplete As Double
        'End of Added & Commented By Dipali V On 15th July 2020 isssues id 25505
        Dim blnTaskComplete As Boolean
        Dim strQuery, strColor As String
        Dim drGetWBSDeliveriables, drTask, drSubTask As IDataReader
        Dim intdrTaskRecordCount As Integer

        '--- Build the Parameter List which is to be used for the USP
        '-- Deliverable ID
        If m_intDeliveriableTypeID = "" Then
            strQuery = m_intProjectID & ",Null"
        Else
            strQuery = m_intProjectID & ",  " & m_intDeliveriableTypeID
        End If
        '--- DeptID
        If m_intDept = "" Then
            strQuery = strQuery & " , Null "
        Else
            strQuery = strQuery & "," & m_intDept
        End If
        '--- SystemID
        If m_intSystemID = "" Then
            strQuery = strQuery & " , Null "
        Else
            strQuery = strQuery & "," & m_intSystemID
        End If
        '--- ResourceID
        If m_intResourceID = "" Then
            strQuery = strQuery & " , Null "
        Else
            strQuery = strQuery & "," & m_intResourceID
        End If
        '--- GroupID
        If m_intGroupID = "" Then
            strQuery = strQuery & " , Null "
        Else
            strQuery = strQuery & "," & m_intGroupID
        End If

        'For SiteID
        strQuery = strQuery & " , Null "
        '--- PackageID
        If m_intPackageID = "" Then
            strQuery = strQuery & " , Null "
        Else
            strQuery = strQuery & "," & m_intPackageID
        End If

        '--- for Task Query
        strSQLTaskQuery = strQuery

        '--- Date
        If m_strDate = "" Then
            strQuery = strQuery & ",Null "
        Else
            strQuery = strQuery & ",'" & m_strDate & "'"
        End If

        CommonFunctions.General.WriteHTML("<table CellSpacing=0 Border=0 width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class=clsTREven>	")
        CommonFunctions.General.WriteHTML("<td width='4%' align=left>" + MyBase.GetResourceString("LEGEND") + "</td>")
        CommonFunctions.General.WriteHTML("<td width='1%' bgcolor=Brown>")
        CommonFunctions.General.WriteHTML("<td width='4%' align=left>&nbsp;" + MyBase.GetResourceString("LEGEND_VOID_TASKS") + "</td>")
        CommonFunctions.General.WriteHTML("<td width='1%' bgcolor=blue>")
        CommonFunctions.General.WriteHTML("<td width='4%' align=left>&nbsp;" + MyBase.GetResourceString("LEGEND_TASKS_NOT_STARTED") + "</td>")
        CommonFunctions.General.WriteHTML("<td width='1%' bgcolor=green>")
        CommonFunctions.General.WriteHTML("<td width='4%' align=left>&nbsp;" + MyBase.GetResourceString("LEGEND_COMPLETED_TASKS") + "</td>")
        CommonFunctions.General.WriteHTML("<td width='1%' bgcolor=red>")
        CommonFunctions.General.WriteHTML("<td width='4%' align=left>" + MyBase.GetResourceString("LEGEND_OVERDUE_TASKS") + "</td>")
        CommonFunctions.General.WriteHTML("<td width='1%' bgcolor=black>")
        CommonFunctions.General.WriteHTML("<td width='4%' align=left>&nbsp;" + MyBase.GetResourceString("LEGEND_IN_PROGRESS_TASKS") + "</td>")
        CommonFunctions.General.WriteHTML("</td>&nbsp;")
        
        'Added Void / InActive Caption Tasks
        
        'Additon complete
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")

        '--- Draw the Grid Column Header 
        CommonFunctions.General.WriteHTML("<table cellSpacing='1' cellPadding='0' width='99.9%' align='center' border='0'>")
        CommonFunctions.General.WriteHTML("<tbody>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='clsTDHeader' align='center' width='27%' wrap>")
        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("GRID_DELIVERABLE_TASK") & "</b>")
        CommonFunctions.General.WriteHTML("</td><td class='clsTDHeader' align='center' width='10%'>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("GRID_TYPE") & "</b></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDHeader' align='center' width='20%'>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("GRID_RESOURCE") & "</B>")
        CommonFunctions.General.WriteHTML("</td><td class='clsTDHeader' align='center' width='10%'>")
        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("GRID_WORK_HRS") & "</b>")
        CommonFunctions.General.WriteHTML("</td><td class='clsTDHeader' align='center' width='13%'>")
        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("GRID_START_DATE") & "</B>")
        CommonFunctions.General.WriteHTML("</td><td class='clsTDHeader' align='center' width='13%'>")
        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("GRID_END_DATE") & "</b>")
        CommonFunctions.General.WriteHTML("</td><td class='clsTDHeader' align='center' width='7%'>")
        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("GRID_PERCENTAGE_COMPLETE") & "</b>")
        CommonFunctions.General.WriteHTML("</td></tr>")
        CommonFunctions.General.WriteHTML("</tbody></table>")

        '--- Plot the Grid
        Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto;'>")
        CommonFunctions.General.WriteHTML("<table id='Deliverables' name=='Deliverables' cellSpacing='1' cellPadding='0' width='99.9%' align='center' border='0' >")
        CommonFunctions.General.WriteHTML("<tbody>")

        Dim intDelTypeID, intDelID As Integer

        ' Get List of deliverables
        strSQLQuery = "EXEC usp_Sel_tbl_PM_WBSDeliveriables " & strQuery
        drGetWBSDeliveriables = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        iRowLoop = 0
        '--- Draw row's of the Grid
        While drGetWBSDeliveriables.Read()
            iRowLoop += 1
            intDelTypeID = CType(drGetWBSDeliveriables("DeliverableTypeID"), Integer)
            intDelID = CType(drGetWBSDeliveriables("UniqueID"), Integer)
            strTaskName = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("TaskName"), ""), String)
            strType = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("Type"), ""), String)
            strResource = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("Resource"), ""), String)
            strStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("StartDate"), ""), String)
 			'Added By Amit J For Flexcel IssueId 2520
            strStartDate1 = strStartDate
            'End of Addition
            strEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("EndDate"), ""), String)
			'integrated by harshada d 
			'Added By Amit J For Flexcel IssueId 2520
            strEndDate1 = strEndDate
            'End of Addition
            'end of integration
            'Added & Commented By Dipali V On 15th July 2020 isssues id 25505
            'intWork = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("WorkHours"), "0"), Double)
            'intActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("ActualWork"), "0"), Double)
            intWork = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("WorkHours"), ""), String)
            intActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("ActualWork"), ""), String)
            'End of Added & Commented By Dipali V On 15th July 2020 isssues id 25505
            'Code Added to get actual start and date of the deliverable 
            strActualStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("ActualStartDate"), ""), String)
			'integrated by harshada d
			'Added By Amit J For Flexcel IssueId 2520
            strActualStartDate1 = strActualStartDate
            'End of Addition
			'end of integration
            strActualEnddate = CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("ActualEndDate"), ""), String)
			'integrated by harshada d
			'Added By Amit J For Flexcel IssueId 2520
            strActualEnddate1 = strActualEnddate
            'End of Addition
				'end of integration
            'Addition ends

            If strStartDate <> "" Then
                '' START    : Integrated by ParagD on 14-Aug-2006 for whizible SP 7.2 
                '' Purpose  : Flexcel Issue ID 2520

                'Commented and Added By Amit J For Flexcel IssueId 2520
                'Change In input date format from mm/dd/yyyy format to any other format- page displays error.
                'strStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strStartDate))
                strStartDate = CommonFunctions.Dates.GetDate(Date.Parse(strStartDate))
                'End of Addition

                '' END      : Integrated by ParagD on 14-Aug-2006 for whizible SP 7.2
            End If

            If strEndDate <> "" Then
                '' START    : Integrated by ParagD on 14-Aug-2006 for whizible SP 7.2 
                'Commented and Added By Amit J For Flexcel IssueId 2520
                'strEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(strEndDate))
                strEndDate = CommonFunctions.Dates.GetDate(Date.Parse(strEndDate))
                'End of addition
                '' END    : Integrated by ParagD on 14-Aug-2006 for whizible SP 7.2
            End If

            '--- Get Deliverable COLOR
            If CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("void"), ""), String) = "1" Then
                strColor = "Brown"
            ElseIf strActualStartDate = "" Then
                strColor = "blue"
            ElseIf strActualEnddate <> "" Then
                strColor = "green"
            ElseIf CommonFunction.General.CheckIsNothing(strEndDate, "") <> "" Then
                If (DateDiff(DateInterval.Day, CType(strEndDate, DateTime), Today()) > 0) Then
                    strColor = "red"
                Else
                    strColor = "black"
                End If
            Else
                strColor = "black"
            End If


            If strActualStartDate <> "" Then
                'strActualStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strActualStartDate))
                strActualStartDate = CommonFunctions.Dates.GetDate(Date.Parse(strActualStartDate))
            End If

            If strActualEnddate <> "" Then
                'strActualEnddate = CommonFunctions.Dates.CGetDate(Date.Parse(strActualEnddate))
                strActualEnddate = CommonFunctions.Dates.GetDate(Date.Parse(strActualEnddate))
            End If


            drTask = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_WBSTasks  " & strSQLTaskQuery & "," & intDelTypeID & "," & intDelID, MyBase.UseSQL)
            intdrTaskRecordCount = 0
            While drTask.Read()
                intdrTaskRecordCount = intdrTaskRecordCount + 1
            End While
            CommonFunctions.Data.DisposeDataReader(drTask)
            'Added by SandeepA on 28 Nov,2005 for IssueID-708
            drTask = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_WBSTasks  " & strSQLTaskQuery & "," & intDelTypeID & "," & intDelID, MyBase.UseSQL)
			'integrated by harshada d
			'Added By Amit J For Flexcel IssueId 2520
            'Change In input date format from mm/dd/yyyy format to any other format- page displays error.
            If strActualStartDate <> "" Then
                strActualStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strActualStartDate1))
            End If

            If strActualEnddate <> "" Then
                strActualEnddate = CommonFunctions.Dates.CGetDate(Date.Parse(strActualEnddate1))
            End If

            If strStartDate <> "" Then
                strStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strStartDate1))
            End If

            If strEndDate <> "" Then
                strEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(strEndDate1))
            End If
            'End of Addition By AmitJ
			'end of itengration
			'=======================================================================================================
            CommonFunctions.General.WriteHTML("<tr id=TR" & iRowLoop & ">")
            '---------------------------------------------------------------------------------------------
            If intdrTaskRecordCount > 0 Then

                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=left width='27%' wrap>")
                CommonFunction.General.WriteHTML("<font color=" & strColor & ">")
                CommonFunctions.General.WriteHTML("<a href='javascript:DisplayDeliverableDetails(" & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("DeliverableTypeID"), ""), String))
                CommonFunctions.General.WriteHTML("," & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("UniqueID"), ""), String) & "," & iRowLoop & " )'>")
                CommonFunctions.General.WriteHTML("<img ID='imgAttachments" & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("DeliverableTypeID"), ""), String) & "U" & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("UniqueID"), ""), String) & "'")
                CommonFunctions.General.WriteHTML("src='..\..\images\Plus.gif' border='0' alt='View Task Details' align='left' WIDTH='10' HEIGHT='10'> </a>")
                'CommonFunctions.General.WriteHTML("<A href='#' onclick='javascript:EditDeliverableTasks(" & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("DeliverableTypeID"), ""), String) & "," & CType(CommonFunctions.Data.CheckIsDBNull(drGetWBSDeliveriables("UniqueID"), ""), String) & ")'></A>")
                CommonFunctions.General.WriteHTML("&nbsp;&nbsp;" & strTaskName & "</font></td>")
            Else
                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=left width=27%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
                CommonFunction.General.WriteHTML("<font color=" & strColor & ">")
                CommonFunctions.General.WriteHTML(strTaskName & "</font></td>")
            End If
            '---------------------------------------------------------------------------------------------
            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=Right width=10%>")
            CommonFunction.General.WriteHTML("<font color=" & strColor & ">")
            CommonFunctions.General.WriteHTML(strType & "</font></td>")
            '---------------------------------------------------------------------------------------------
            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=Right width=20%>")
            CommonFunction.General.WriteHTML("<font color=" & strColor & ">")
            CommonFunctions.General.WriteHTML(strResource & "</font></td>")
            '---------------------------------------------------------------------------------------------
            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=Right width=10%>")
            CommonFunction.General.WriteHTML("<font color=" & strColor & ">")
            CommonFunctions.General.WriteHTML(intWork & "<br>" & intActualWork & "</font></td>")
            '---------------------------------------------------------------------------------------------
            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=right width=13%>")
            CommonFunction.General.WriteHTML("<font color=" & strColor & ">")
            CommonFunctions.General.WriteHTML(strStartDate & "<BR>" & strActualStartDate & "</font></td>")

            '---------------------------------------------------------------------------------------------
            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align=right width=13%>")
            CommonFunction.General.WriteHTML("<font color=" & strColor & ">")
            CommonFunctions.General.WriteHTML(strEndDate & "<BR>" & strActualEnddate & "</font></td>")
            '---------------------------------------------------------------------------------------------
            CommonFunctions.General.WriteHTML("<td class='clsTDOdd' width=7%></td>")
            '---------------------------------------------------------------------------------------------
            CommonFunctions.General.WriteHTML("</tr>")
            iRowLoop += 1
            CommonFunctions.General.WriteHTML("<tr id=TR" & iRowLoop & " style='display:none'>")
            CommonFunction.General.WriteHTML("<td colspan=7 id=TD" & iRowLoop & "></td>")
            CommonFunctions.General.WriteHTML("</tr>")
            '=======================================================================================================
            CommonFunctions.Data.DisposeDataReader(drTask)
            CommonFunctions.Data.DisposeDataReader(drSubTask)

        End While
        'If No Records are present then show 'No items to show in this view'
        If iRowLoop = 0 Then
            CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunction.General.WriteHTML("<td align='middle'>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("NO_ITEMS"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")
        End If
        'Close the table
        CommonFunctions.General.WriteHTML("</tbody></table>")
        HttpContext.Current.Response.Write("</DIV>")
        CommonFunction.Data.DisposeDataReader(drGetWBSDeliveriables)
    End Sub

    Protected Sub XMLHTTP_PopulateTaskTable()
        '====================================================================
        ' Procedure Name        :   XMLHTTP_PopulateTaskTable
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To populate the TASK table
        ' Description           :   This procedure is used to populate the Task Table
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   SandeepA
        ' Created               :   29 Nov,2005
        ' Revisions             :   
        '=====================================================================


        Dim strFromWhere As String
        Dim intRowNo As Integer

        strFromWhere = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")
        intRowNo = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Row"), "0"))

        '--- If 'SUBTASK - XMLHTTP' call then call function XMLHTTP_PopulateSubTaskTable()
        If strFromWhere = "SUBTASK_XMLHTTP" Then
            Call XMLHTTP_PopulateSubTaskTable()
        End If

        '--- If the PostBack is for XMLHTTP Request - For Tasks
        If strFromWhere = "XMLHTTP" Then
            '--- Declare Local variables
            Dim strSQL As String
            Dim intTaskRows As Integer
            Dim intdrTaskRecordCount As Integer
            Dim dsDataSet As New DataSet
            Dim strXML As String
            Dim strDeliverableTypeID As String
            Dim strDeliverableID As String
            Dim strQuery As String
            Dim drTask As IDataReader
            Dim strWhereClause As String = ""
            Dim strTaskName, strType, strResource, strStartDate, strEndDate, strActualStartDate, strActualEnddate As String
            'Added & Commented By Dipali V On 15th July 2020 isssues id 25505
            'Dim intWork, intPercentComplete, intActualWork As Double
            Dim intWork, intActualWork As String
            Dim intPercentComplete As Double
            'End of Added & Commented By Dipali V On 15th July 2020 isssues id 25505
            Dim blnTaskComplete As Boolean
            Dim strColor As String
            Dim drGetWBSDeliveriables, drSubTask As IDataReader

            '--- Initialize variables
            m_intDeliveriableTypeID = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboDeliverable"), "")
            m_intDept = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboDepartment"), "")
            m_intSystemID = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboSystem"), "")
            m_intResourceID = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboResource"), "")
            m_intGroupID = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboGroup"), "")
            m_intPackageID = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboPackage"), "")
            m_strDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("dtDate"), "")

            '--- Build the Parameter List which is to be used for the USP
            '-- Deliverable ID
            If m_intDeliveriableTypeID = "" Then
                strQuery = m_intProjectID & ",Null"
            Else
                strQuery = m_intProjectID & ",  " & m_intDeliveriableTypeID
            End If
            '--- DeptID
            If m_intDept = "" Then
                strQuery = strQuery & " , Null "
            Else
                strQuery = strQuery & "," & m_intDept
            End If
            '--- SystemID
            If m_intSystemID = "" Then
                strQuery = strQuery & " , Null "
            Else
                strQuery = strQuery & "," & m_intSystemID
            End If
            '--- ResourceID
            If m_intResourceID = "" Then
                strQuery = strQuery & " , Null "
            Else
                strQuery = strQuery & "," & m_intResourceID
            End If
            '--- GroupID
            If m_intGroupID = "" Then
                strQuery = strQuery & " , Null "
            Else
                strQuery = strQuery & "," & m_intGroupID
            End If

            'For SiteID
            strQuery = strQuery & " , Null "
            '--- PackageID
            If m_intPackageID = "" Then
                strQuery = strQuery & " , Null "
            Else
                strQuery = strQuery & "," & m_intPackageID
            End If

            '--- Get the DeliverableTypeID,DeliverableID from QueryString
            strDeliverableID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DeliverableID"), "0"))
            strDeliverableTypeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DeliverableTypeID"), "0"))
            drTask = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_WBSTasks  " & strQuery & "," & strDeliverableTypeID & "," & strDeliverableID, MyBase.UseSQL)

            '--- The Task Table is saved as s string strXML
            strXML = strXML + "<table id='Tasks' name=='Tasks' cellSpacing='1' cellPadding='0' width='100%' align='center' border='0' >"

            '--- Initialize row count
            intTaskRows = 0

            '--- Start building the Task Table
            While drTask.Read()

                intTaskRows += 1
                strTaskName = CType(CommonFunctions.Data.CheckIsDBNull(drTask("TaskName"), ""), String)
                strType = CType(CommonFunctions.Data.CheckIsDBNull(drTask("Type"), ""), String)
                strResource = CType(CommonFunctions.Data.CheckIsDBNull(drTask("Resource"), ""), String)
                strStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("StartDate"), ""), String)
                strEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("EndDate"), ""), String)
                strActualStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualStartDate"), ""), String)
                strActualEnddate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualEndDate"), ""), String)

                'Added & Commented By Dipali V On 15th July 2020 isssues id 25505
                'intWork = CType(CommonFunctions.Data.CheckIsDBNull(drTask("WorkHours"), "0"), Double)
                'intActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualWork"), "0"), Double)

                intWork = CType(CommonFunctions.Data.CheckIsDBNull(drTask("WorkHours"), ""), String)
                intActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualWork"), ""), String)

                'End of Added & Commented By Dipali V On 15th July 2020 isssues id 25505
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

                drSubTask = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_WBSTasks  " & strQuery & "," & strDeliverableTypeID & "," & strDeliverableID & ",0," & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer), MyBase.UseSQL)

                intdrTaskRecordCount = 0
                While drSubTask.Read()
                    intdrTaskRecordCount = intdrTaskRecordCount + 1
                End While

                CommonFunctions.Data.DisposeDataReader(drSubTask)

                'Commneted By NitinVS on 1 OCT 2009 unused call for datareader
                'drSubTask = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_WBSTasks  " & strQuery & "," & strDeliverableTypeID & "," & strDeliverableID & ",0," & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer), MyBase.UseSQL)
                'End Comment by NitinVS on 1 oct 2009
                'Commented and added by Chetan M on 11 Nov 2020 for get green colour to completed task
                'If CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTask("IsActive"), ""), "0"), Boolean) = False Then
                If CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTask("IsActive"), ""), "0"), Boolean) = False And blnTaskComplete = False Then
                        'End of commented and added by Chetan M on 11 Nov 2020 for get green colour to completed task
                        strColor = "Brown"
                    ElseIf strActualStartDate = "" Then
                        strColor = "blue"
                    ElseIf blnTaskComplete = True Then
                        strColor = "green"
                    ElseIf CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTask("EndDate"), ""), "") <> "" Then
                        If (DateDiff(DateInterval.Day, CType(CommonFunction.Data.CheckIsDBNull(drTask("EndDate"), ""), DateTime), Today()) > 0) Then
                            strColor = "red"
                        Else
                            strColor = "black"
                        End If
                    Else
                        strColor = "black"
                End If


                strXML = strXML + "<tr id=""TasksTR""" & intTaskRows & "-" & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer) & ">"
                strXML = strXML + "<td class='clstdodd' width=5% align=right></td>"
                '--- If Tasks has SubTasks the Show the '+' image and add the call to Javascript fn DisplayTaskDetails
                If intdrTaskRecordCount > 0 Then
                    strXML = strXML + "<td class='clsTDOdd' align=left width=22% ><a href='javascript:DisplayTaskDetails(" & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer) & "," & strDeliverableTypeID & "," & strDeliverableID & "," & intTaskRows & ")'>"
                    strXML = strXML + "<img align='center' ID='imgAttachments" & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer) & "' src='..\..\images\Plus.gif' border='0' alt='View Resource Task Details'  WIDTH='10' HEIGHT='10'></a>"
                    strXML = strXML + "<font color=" & strColor & ">&nbsp;" & strTaskName & "</font></td>"
                Else
                    strXML = strXML + "<td class='clsTDOdd' align=left width=22% ><font color=" & strColor & ">" & strTaskName & "</font></td>"
                End If

                strXML = strXML + "<td class='clsTDOdd' width=10% align=center><font color=" & strColor & ">" & strType & "</font></td>"
                strXML = strXML + "<td class='clsTDOdd' width=20% align=center><font color=" & strColor & ">" & strResource & "</font></td>"
                strXML = strXML + "<td class='clsTDOdd' width=10% align=right><font color=" & strColor & ">" & intWork & "<BR>" & intActualWork & "</font></td>"
                strXML = strXML + "<td class='clsTDOdd' width=13% align=right><font color=" & strColor & ">" & strStartDate & "<BR>" & strActualStartDate & "</font></td>"
                strXML = strXML + "<td class='clsTDOdd' width=13% align=right><font color=" & strColor & ">" & strEndDate & "<BR>" & strActualEnddate & "</font></td>"
                strXML = strXML + "<td class='clsTDOdd' width=7% align=right><font color=" & strColor & ">" & intPercentComplete & "</font></td>"
                strXML = strXML + "</tr>"
                '---Increament the Row count
                intTaskRows += 1
                '--- Add a blank row, so that the SubTask Table can be inserted in this blank row
                strXML = strXML + "<tr  id=TasksTR" & intTaskRows & "-" & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer) & "  style='display:none'>"
                strXML = strXML + "<td colspan=8 id=TasksTD" & intTaskRows & "-" & CType(CommonFunctions.Data.CheckIsDBNull(drTask("UniqueID"), ""), Integer) & "></td>"
                strXML = strXML + "</tr>"

            End While

            strXML = strXML + "</table>"
            '--- Clear the old HTTP Response object
            Response.Clear()
            '--- Send the table as response to the XMLHTTP Object on clientside
            Response.Write(strXML)
            CommonFunction.Data.DisposeDataReader(drTask)
        End If

    End Sub

    Protected Sub XMLHTTP_PopulateSubTaskTable()

        '====================================================================
        ' Procedure Name        :   XMLHTTP_PopulateSubTaskTable
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To populate the SUBTASK table
        ' Description           :   This procedure is used to populate the SubTask Table
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   SandeepA
        ' Created               :   29 Nov,2005
        ' Revisions             :   
        '=====================================================================


        Dim strFromWhere As String
        Dim intRowNo As Integer

        strFromWhere = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")
        intRowNo = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Row"), "0"))

        '--- For SubTask table creation
        If strFromWhere = "SUBTASK_XMLHTTP" Then

            Dim strSQL As String
            Dim intTaskRows As Integer
            Dim intdrTaskRecordCount As Integer
            Dim dsDataSet As New DataSet
            Dim strXML As String
            Dim strDeliverableTypeID As String
            Dim strDeliverableID, strTaskID As String
            Dim strQuery As String
            Dim drTask As IDataReader
            Dim strWhereClause As String = ""
            Dim strTaskName, strType, strResource, strStartDate, strEndDate, strActualStartDate, strActualEnddate As String
            'Added & Commented By Dipali V On 15th July 2020 isssues id 25505
            'Dim intWork, intPercentComplete, intActualWork As Double
            Dim intWork, intActualWork As String
            Dim intPercentComplete As Double
            'End of Added & Commented By Dipali V On 15th July 2020 isssues id 25505
            Dim blnTaskComplete As Boolean
            Dim strColor As String
            Dim drGetWBSDeliveriables, drSubTask As IDataReader

            '--- Initialize varialbes
            m_intDeliveriableTypeID = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboDeliverable"), "")
            m_intDept = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboDepartment"), "")
            m_intSystemID = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboSystem"), "")
            m_intResourceID = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboResource"), "")
            m_intGroupID = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboGroup"), "")
            m_intPackageID = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboPackage"), "")
            m_strDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("dtDate"), "")


            '--- Build the Parameter List which is to be used for the USP
            '-- Deliverable ID
            If m_intDeliveriableTypeID = "" Then
                strQuery = m_intProjectID & ",Null"
            Else
                strQuery = m_intProjectID & ",  " & m_intDeliveriableTypeID
            End If
            '--- DeptID
            If m_intDept = "" Then
                strQuery = strQuery & " , Null "
            Else
                strQuery = strQuery & "," & m_intDept
            End If
            '--- SystemID
            If m_intSystemID = "" Then
                strQuery = strQuery & " , Null "
            Else
                strQuery = strQuery & "," & m_intSystemID
            End If
            '--- ResourceID
            If m_intResourceID = "" Then
                strQuery = strQuery & " , Null "
            Else
                strQuery = strQuery & "," & m_intResourceID
            End If
            '--- GroupID
            If m_intGroupID = "" Then
                strQuery = strQuery & " , Null "
            Else
                strQuery = strQuery & "," & m_intGroupID
            End If

            'For SiteID
            strQuery = strQuery & " , Null "
            '--- PackageID
            If m_intPackageID = "" Then
                strQuery = strQuery & " , Null "
            Else
                strQuery = strQuery & "," & m_intPackageID
            End If

            '--- Get the DeliverableTypeID,DeliverableID,TaskID from the QueryString
            strDeliverableID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DeliverableID"), "0"))
            strDeliverableTypeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DeliverableTypeID"), "0"))
            strTaskID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TaskID"), "0"))
            '---Get the SubTask reader
            drSubTask = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_WBSTasks  " & strQuery & "," & strDeliverableTypeID & "," & strDeliverableID & ",0," & strTaskID, MyBase.UseSQL)
            intdrTaskRecordCount = 0
            While drSubTask.Read()
                intdrTaskRecordCount = intdrTaskRecordCount + 1
            End While
            CommonFunctions.Data.DisposeDataReader(drSubTask)

            drSubTask = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_WBSTasks  " & strQuery & "," & strDeliverableTypeID & "," & strDeliverableID & ",0," & strTaskID, MyBase.UseSQL)

            If intdrTaskRecordCount > 0 Then
                '--- Start creating table
                strXML = strXML + "<table id='Tasks' name=='Tasks' cellSpacing='1' cellPadding='0' width='100%' align='center' border='0' >"

                While drSubTask.Read

                    strTaskName = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("TaskName"), ""), String)
                    strType = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("Type"), ""), String)
                    strResource = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("Resource"), ""), String)
                    strStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("StartDate"), ""), String)
                    strEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("EndDate"), ""), String)
                    strActualStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("ActualStartDate"), ""), String)
                    strActualEnddate = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("ActualEndDate"), ""), String)
                    'intWork = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("WorkHours"), "0"), Double)
                    'intActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("ActualWork"), "0"), Double)

                    intWork = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("WorkHours"), ""), String)
                    intActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drSubTask("ActualWork"), ""), String)
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

                    '--- Check for COLOR of the SubTask
                    ' commented and added by Chetan M on 11 Nov 2020 for get green colour to completed task
                    'If CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drSubTask("IsActive"), ""), "0"), Boolean) = False Then
                    If CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drSubTask("IsActive"), ""), "0"), Boolean) = False And blnTaskComplete = False Then
                        'End of commented and added by Chetan M on 11 Nov 2020 for get green colour to completed task
                        strColor = "Brown"
                    ElseIf strActualStartDate = "" Then
                        strColor = "blue"
                    ElseIf blnTaskComplete = True Then
                        strColor = "green"
                    ElseIf CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drSubTask("EndDate"), ""), "") <> "" Then
                        If (DateDiff(DateInterval.Day, CType(CommonFunction.Data.CheckIsDBNull(drSubTask("EndDate"), ""), DateTime), Today()) > 0) Then
                            strColor = "red"
                        Else
                            strColor = "black"
                        End If
                    Else
                        strColor = "black"
                    End If

                    strXML = strXML + "<tr>"
                    strXML = strXML + "<td class='clsTDOdd' width=7% align=left ></td>"
                    strXML = strXML + "<td class='clsTDOdd' width=20% align=left ><font color=" & strColor & ">" & strTaskName & "</font></td>"
                    strXML = strXML + "<td class='clsTDOdd' width=10% align=center ><font color=" & strColor & ">" & strType & "</font></td>"
                    strXML = strXML + "<td class='clsTDOdd' width=20% align=center><font color=" & strColor & ">" & strResource & "</font></td>"
                    strXML = strXML + "<td class='clsTDOdd' width=10% align=right><font color=" & strColor & ">" & intWork & "<BR>" & intActualWork & "</font></td>"
                    strXML = strXML + "<td class='clsTDOdd' width=13% align=right><font color=" & strColor & ">" & strStartDate & "<BR>" & strActualStartDate & "</font></td>"
                    strXML = strXML + "<td class='clsTDOdd' width=13% align=right><font color=" & strColor & ">" & strEndDate & "<BR>" & strActualEnddate & "</font></td>"
                    strXML = strXML + "<td class='clsTDOdd' width=7% align=right><font color=" & strColor & ">" & intPercentComplete & "</font></td>"
                    strXML = strXML + "</tr>"
                End While

                strXML = strXML + "</table>"
            End If

            CommonFunctions.Data.DisposeDataReader(drSubTask)
            '--- Clear the old HTTP Response Object.
            Response.Clear()
            Response.Write(strXML)
        End If

    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        '====================================================================
        ' Procedure Name        :   New (Constructor)
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To Apply Security and Initialize Resources
        ' Description           :   same as above 
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   SandeepA
        ' Created               :   23 Nov,2005
        ' Revisions             :   
        '=====================================================================
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_DeliverableTracking", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        '====================================================================
        ' Procedure Name        :   New (Destructor)
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   Calls Base Class Destructor
        ' Description           :   same as above 
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   SandeepA
        ' Created               :   23 Nov,2005
        ' Revisions             :   
        '=====================================================================
        MyBase.Finalize()
    End Sub
#End Region
End Class

