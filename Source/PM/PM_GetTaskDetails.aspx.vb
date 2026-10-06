'******************************************************************
'           CSPL Code Header
' Project Name     :    PBNIT Enterprise Version
' Module Name      :    Get Task Details
' Purpose          :    This module is used to accept task details.
' Description      :    This module is used to accept task details. This page is called from Plan Deliverables
'                  :    page when user clicks the link "Task Notes and Details". This page does not write any
'                  :    data to database, instead, when user clicks "Save" on this page, this page writes all
'                  :    data in the hidden controls of the parent page (Plan Deliverables).
' Assumptions      :    <Assumptions>
' Dependencies     :    <Dependencies>
' Author           :    ShamkantD
' Reviewed         :    
' Tested           :    
' Created          :    September 2, 2004
' Revisions        :    
'******************************************************************
Imports System.Text
Public Class PM_PM_GetTaskDetails
    Inherits WebPages.Template.WhizTemplate

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

#Region " Constructor "
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_GetTaskDetails", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

#Region " Initialized Variables "
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private strQuery As String = ""
    Private m_arrControlDetails(7, 1) As Boolean

    Protected m_strWindowTitle As String = MyBase.GetResourceString("TITLE_TEMPLATE_TASKS")
    Protected m_strPageHeader As String = MyBase.GetResourceString("HEADING_PLAN_DELIVERABLE")
    Protected m_sbValidationScript As New StringBuilder("")
    Protected m_sbClientSideScript As New StringBuilder("")

    Protected m_lngTagID As Long = 0
    Protected m_lngProjectID As Long = 0
    Protected m_lngTaskID As Long = 0
    Protected m_strTaskName As String = ""
    Protected m_strTaskNotes As String = ""
    Protected m_lngProjectEstimationTypeID As Long = 0
    Protected m_lngPhaseID As Long = 0
    Protected m_lngModuleID As Long = 0
    Protected m_lngSubProjectID As Long = 0
    Protected m_lngMilestoneID As Long = 0
    Protected m_lngChangeRequestID As Long = 0
    Protected m_lngProjectFeatureID As Long = 0
    Protected m_strPriority As String = ""

    Private Enum ControlIndex
        CTRL_INDEX_TASKTYPE
        CTRL_INDEX_PHASE
        CTRL_INDEX_MODULE
        CTRL_INDEX_SUBPROJECT
        CTRL_INDEX_MILESTONE
        CTRL_INDEX_CHANGEREQUEST
        CTRL_INDEX_FEATURE
        CTRL_INDEX_ESTIMATIONTYPE
    End Enum
#End Region

#Region " Generic Functions "
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
        ' Author                : ShamkantD
        ' Created               : Aug 25, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function
    Private Sub WritePageLegend()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub
    Private Sub InitiateControlArray()
        Dim strQuery As String
        Dim drWork As IDataReader

        strQuery = "Exec usp_Sel_tbl_PRS_ProjectTypes NULL, " & m_lngProjectID.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 1) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowPhaseInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("PhaseMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowModuleInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ModuleMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowSubProjectInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("SubProjectMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowMilestoneInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("MilestoneMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowChangeRequestInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ChangeRequestMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowFeatureInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("FeatureMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowEstimationTypeInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("EstimationTypeMandatoryInAT"), "False"), Boolean)
            Else
                m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 1) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 0) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 0) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 1) = False
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
    End Sub
#End Region

#Region " Page Load Functions "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strWindowTitle = MyBase.GetResourceString("TITLE_TASK_DETAILS")
        m_strPageHeader = MyBase.GetResourceString("HEADING_TASK_DETAILS")

        m_lngTagID = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagID")), Long)
        m_lngProjectID = CType("0" & CommonFunctions.General.CheckIsNothing(Session("intProjectID")), Long)

        m_strTaskName = CommonFunction.General.CheckIsNothing(Request.QueryString("PhaseTaskName"), "").Trim
        m_lngTaskID = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("PhaseTaskID")), Long)

        m_lngProjectEstimationTypeID = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("EstimationTypeID")), Long)
        m_strPriority = CType("" & CommonFunctions.General.CheckIsNothing(Request.QueryString("Priority")), String)

        m_lngPhaseID = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("PhaseID")), Long)
        m_lngModuleID = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("ModuleID")), Long)
        m_lngSubProjectID = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("SubProjectID")), Long)
        m_lngMilestoneID = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("MilestoneID")), Long)
        m_lngChangeRequestID = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("ChangeRequestID")), Long)
        m_lngProjectFeatureID = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("FeatureID")), Long)

        InitiateControlArray()
    End Sub
    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : September, 2004
        ' Revisions             :
        '=====================================================================

        '---------------------------------------------------------------------
        ' DRAW PAGE
        '---------------------------------------------------------------------
        DrawMenu(False)

        WritePageLegend()

        ShowPageHeader()

        DrawGrid()

        ShowPageFooter()

        DrawMenu(False)
        '---------------------------------------------------------------------
        ' END - DRAW PAGE
        '---------------------------------------------------------------------
    End Sub
#End Region

#Region " Plot the Menu "
    Private Sub DrawMenu(Optional ByVal blnShowPaging As Boolean = True)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : September 02, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String

        m_objMenu = New WebPages.Template.StaticMenu

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        arrClientSideFunctionList.Add("Save_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('" & m_lngTagID & "')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
    End Sub
#End Region

#Region "Show Page Header"
    Private Sub ShowPageHeader()
        '=====================================================================
        ' Procedure Name        : ShowPageHeader()	
        ' Purpose               : Draw HTML for page header part
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : August 26, 2004
        ' Revisions             :
        '=====================================================================
        'Plot the page header
        'CommonFunction.General.PlotPageHeadTag(m_strPageHeader)
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<TABLE class=clsTABLE width='99.9%'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRPageCaption'><TD>" & m_strPageHeader & "</TD></TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")

        CommonFunctions.General.WriteHTML("<br><DIV id='DivMain' style='Overflow:auto;width:100%;Height:100%'>")
    End Sub
#End Region

#Region " Grid Plotting "
    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()	
        ' Purpose               : Plots the grid on the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : Aug 25,20004
        ' Revisions             :
        '=====================================================================
        Dim sbHTML As New StringBuilder("")
        Dim intColumnNumber As Integer

        CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellpadding=0 cellspacing=0 width=""99.9%"" style=""WIDTH: 100%"">")
        ' Task Name.
        sbHTML.Append("<TR class='clsTREven'><TD align=right valign=top>")
        sbHTML.Append(MyBase.GetResourceString("CAP_TASK_NAME"))
        sbHTML.Append("</TD><TD colspan=3>")
        sbHTML.Append(m_strTaskName)
        'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , 375, 255, m_strTaskName, IsReadOnly:=True, returnHTML:=True, IsMandatory:=True))
        sbHTML.Append("</TD></TR>")

        ' Task Notes.
        sbHTML.Append("<TR class='clsTREven'><TD align=right valign=top>")
        sbHTML.Append(MyBase.GetResourceString("CAP_TASK_NOTES"))
        sbHTML.Append("</TD><TD colspan=3>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", MyBase.GetResourceString("CAP_TASK_NOTES_DIALOG"), , , "frmTaskDetails", , , 375, 70, 2000, value:=m_strTaskNotes, returnHTML:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", MyBase.GetResourceString("CAP_TASK_NOTES_DIALOG"), , , "frmTaskDetails", , , 375, 70, 2000, value:=m_strTaskNotes, returnHTML:=True, EnableHTMLEncode:=True))
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        sbHTML.Append("</TD></TR>")

        ' Priority.
        sbHTML.Append("<TR class='clsTREven'><TD align=right valign=top>")
        sbHTML.Append(MyBase.GetResourceString("CAP_PRIORITY"))
        sbHTML.Append("</TD><TD valign=top>")
        strQuery = "EXEC usp_Sel_tbl_IB_Priorities"
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strQuery, 150, m_strPriority, , True, returnAsHTML:=True, IsMandatory:=True))

        ' Build the client side validation script. 
        m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskDetails','cboPriority');" & vbCrLf)
        m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_PRIORITY") & """))")
        m_sbValidationScript.Append("	return false;" & vbCrLf)

        ' Increment the column number. 
        intColumnNumber = (intColumnNumber + 1) Mod 2

        'ESTIMATION TYPE
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("CAP_ESTIMATION_TYPE"))
            sbHTML.Append("</TD><TD valign=top>")
            strQuery = "Exec usp_Sel_tbl_PM_Project_EstimationTypes NULL, " & m_lngProjectID.ToString()
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProjectEstimationTypeID", strQuery, 250, m_lngProjectEstimationTypeID.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 1)))

            If m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 1) = True Then
                ' Build the client side validation script. 
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskDetails','cboProjectEstimationTypeID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_ESTIMATION_TYPE") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If


        ' PHASE.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("CAP_PHASE"))
            sbHTML.Append("</TD><TD valign=top>")
            strQuery = "Exec usp_PRS_GetProjectPhasesForSQA " & m_lngProjectID.ToString()
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPhaseID", strQuery, 250, m_lngPhaseID.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 1)))

            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskDetails','cboPhaseID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_PHASE") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If

        ' MODULE.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("CAP_MODULE"))
            sbHTML.Append("</TD><TD valign=top>")
            strQuery = "Exec usp_Sel_tbl_PM_Module " & m_lngProjectID.ToString() & ", NULL, 'A'"
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModuleID", strQuery, 250, m_lngModuleID.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 1)))

            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskDetails','cboModuleID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_MODULE") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If

        ' SUB PROJECT.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("CAP_SUB_PROJECT"))
            sbHTML.Append("</TD><TD valign=top>")
            strQuery = "Exec usp_Sel_tbl_PM_SubProject " & m_lngProjectID.ToString() & ", NULL, 'T'"
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubProjectID", strQuery, 250, m_lngSubProjectID.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 1)))

            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskDetails','cboSubProjectID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_SUBPROJECT") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If

        ' MILESTONE.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("CAP_MILESTONE"))
            sbHTML.Append("</TD><TD valign=top>")
            strQuery = "Exec usp_Sel_tbl_PM_Milestones " & m_lngProjectID.ToString() & ", 'T'"
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboMilestoneID", strQuery, 250, m_lngMilestoneID.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 1)))

            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskDetails','cboMilestoneID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_MILESTONE") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If

        ' CHANGE REQUEST.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("CAP_CHANGE_REQUEST"))
            sbHTML.Append("</TD><TD valign=top>")
            strQuery = "Exec usp_Sel_tbl_PM_ChangeRequest_Master " & m_lngProjectID.ToString()
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequestID", strQuery, 250, m_lngChangeRequestID.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 1)))

            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskDetails','cboChangeRequestID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_CHANGE_REQUEST") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If

        ' FEATURE.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("CAP_FEATURE"))
            sbHTML.Append("</TD><TD valign=top>")
            strQuery = "Exec usp_Sel_tbl_PM_Project_Features NULL, " & m_lngProjectID.ToString()
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProjectFeatureID", strQuery, 250, m_lngProjectFeatureID.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 1)))

            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskDetails','cboProjectFeatureID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_FEATURE") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If

        If intColumnNumber = 1 Then
            sbHTML.Append("<TD colspan=2></TD></TR>")
        End If


        sbHTML.Append("</TR>")
        sbHTML.Append("</TABLE>")

        CommonFunctions.General.WriteHTML(sbHTML.ToString())
    End Sub
#End Region

#Region "Show Page Footer"
    Private Sub ShowPageFooter()
        '=====================================================================
        ' Procedure Name        : ShowPageFooter()	
        ' Purpose               : Draw HTML for page footer part
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : August 26, 2004
        ' Revisions             :
        '=====================================================================
        CommonFunction.General.WriteHTML("</div>")
    End Sub
#End Region

End Class
