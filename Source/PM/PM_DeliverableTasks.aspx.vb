Imports CommonFunctions

Public Class PM_DeliverableTasks
    Inherits WebPages.Template.WhizTemplate

    Private Const MODE_VOID As String = "VOID"
    Private Const MODE_ONHOLD As String = "ONHOLD"
    Private Const MODE_UNONHOLD As String = "UNONHOLD"
    Private Const MODE_UNVOID As String = "UNVOID"

    Protected m_strWindowTitle As String
    Protected m_strMode As String
    Protected m_intDeliverableID As Integer = 0
    Private m_intProjectID As Integer = 0
    Private m_strAction As String


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()

        'set the window title
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_CAPTION") + ""
    End Sub

#End Region

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML body tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	29 Oct 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim strSQL As String

        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = MODE_VOID
        m_strAction = Request.QueryString("Action") + ""
        If Request.QueryString("DeliverableID") <> "" Then
            m_intDeliverableID = CType(Request.QueryString("DeliverableID"), Integer)
        End If
        If General.CheckIsNothing(Session("intProjectID"), "") <> "" Then
            m_intProjectID = CType(Session("intProjectID"), Integer)
        End If

        'update tasks to make then Un Void or On OnHold based on the mode if action is given 
        If m_strAction = "Save" Then
            'Modified by ShamkantD on 11 Dec 2004
            'As per discussion with SatchitS, the functionality of Voiding selective tasks or 
            'putting selective tasks on Hold in this page is being deactiavated.
            'Commented by ShamkantD
            'perfomAction()
            'End of modification - ShamkantD on 11 Dec 2004
        End If

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        'Modified by ShamkantD on 11 Dec 2004
        'As per discussion with SatchitS, the functionality of Voiding selective tasks or 
        'putting selective tasks on Hold in this page is being deactiavated.
        'Commented by ShamkantD
        'If UCase(m_strMode) = MODE_UNVOID Or UCase(m_strMode) = MODE_UNONHOLD Then
        '    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
        'End If
        'End of modification - ShamkantD on 11 Dec 2004

        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('')")

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

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.PM_DeliverableTasks", "AppResources")

        'draw page caption 
        WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"))
        General.WriteHTML("<BR>")

        'display msg related with Void or On Hold
        General.WriteHTML("<Table class='clsTable' cellpading=0 cellspacing=0 width=99.9%>")
        General.WriteHTML("<TR class='clsTREven'>")
        If m_strMode.ToUpper = MODE_ONHOLD Then
            General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("MSG_ONHOLD") + "</TD>")
        ElseIf m_strMode.ToUpper = MODE_UNVOID Then
            General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("MSG_UNVOID") + "</TD>")
        ElseIf m_strMode.ToUpper = MODE_UNONHOLD Then
            General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("MSG_UNONHOLD") + "</TD>")
        Else
            General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("MSG_VOID") + "</TD>")
        End If
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        General.WriteHTML("<div id='PageDiv' style='overflow:auto;' width=100% >")
        plotTaskDetails()
        General.WriteHTML("</div>")

        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)

    End Sub

    Public Sub New()
        MyBase.ApplySecurity()
        MyBase.InitializeResources("AppResources.PM_DeliverableTasks", "AppResources")
    End Sub


    '=====================================================================
    ' Procedure Name		:	plotTaskDetails
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the list of parent tasks and child tasks for the deliverable and 
    '                           currnet project
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	29 Oct 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotTaskDetails()
        Dim strSQL As String
        Dim objDrParentTask As IDataReader
        Dim objDrChildTask As IDataReader
        Dim strTaskName As String
        Dim strResourceName As String
        Dim strStartDate As String
        Dim strEndDate As String
        Dim strActualStartDate As String
        Dim strActualEndDate As String
        Dim strWork As String
        Dim strActualWork As String
        Dim strIsComplete As String
        Dim strParentTaskID As String
        Dim strTaskID As String
        Dim intRowNo As Integer
        Dim blnVoid As Boolean
        Dim blnOnHold As Boolean

        'plot grid column headers
        General.WriteHTML("<Table class='clsTable' cellpadding=0 cellspacing=0 width=99.9% >")
        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_TASK_NAME") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_RESOURCE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_START_DATE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_END_DATE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_ACTUAL_START_DATE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_ACTUAL_END_DATE") + "</TD>")
        General.WriteHTML("<TD align='right'>" + MyBase.GetResourceString("COL_WORK") + "</TD>")
        General.WriteHTML("<TD align='right'>" + MyBase.GetResourceString("COL_ACTUAL_WORK") + "</TD>")
        General.WriteHTML("<TD align='center'>" + MyBase.GetResourceString("COL_COMPLETE") + "</TD>")
        'this page is called for unOnHold and UnVoid the tasks, so only in 
        'that mode display column with checkbox

        'Modified by ShamkantD on 11 Dec 2004
        'As per discussion with SatchitS, the functionality of Voiding selective tasks or 
        'putting selective tasks on Hold in this page is being deactiavated.
        'Commented by ShamkantD
        'If UCase(m_strMode) = MODE_UNVOID Then
        '    General.WriteHTML("<TD align='center'>" + MyBase.GetResourceString("COL_VOID") + "</TD>")
        'ElseIf UCase(m_strMode) = MODE_UNONHOLD Then
        '    General.WriteHTML("<TD align='center'>" + MyBase.GetResourceString("COL_ONHOLD") + "</TD>")
        'End If
        'End of modification - ShamkantD on 11 Dec 2004

        General.WriteHTML("</TR>")

        strSQL = "usp_Sel_tbl_PM_ProjectTasks_DeliverableTasks " + m_intProjectID.ToString + "," + m_intDeliverableID.ToString
        objDrParentTask = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDrParentTask.Read

            strParentTaskID = Data.CheckIsDBNull(objDrParentTask("TaskID"), "").ToString + ""
            strTaskName = Data.CheckIsDBNull(objDrParentTask("TaskName"), "").ToString + ""
            'Modified By VidyaJ - IssueID - 315 - SP4
            ' strStartDate = Data.CheckIsDBNull(objDrParentTask("StartDate"), "").ToString + ""
            ' strEndDate = Data.CheckIsDBNull(objDrParentTask("EndDate"), "").ToString + ""
            strStartDate = CStr(Data.CheckIsDBNull(objDrParentTask("StartDate"), ""))
            strEndDate = CStr(Data.CheckIsDBNull(objDrParentTask("EndDate"), ""))

            strWork = Data.CheckIsDBNull(objDrParentTask("Work"), "").ToString + ""
            blnVoid = DirectCast(Data.CheckIsDBNull(objDrParentTask("IsActive"), "0"), Boolean)
            blnOnHold = DirectCast(Data.CheckIsDBNull(objDrParentTask("TaskOnHold"), "0"), Boolean)

            strActualStartDate = ""
            strActualEndDate = ""
            strActualWork = ""
            strResourceName = ""

            'Added by MrugajaB on 18th July 2006 for WhizibleSEM SP7
            strActualStartDate = CStr(Data.CheckIsDBNull(objDrParentTask("ActualStartDate"), ""))
            strActualEndDate = CStr(Data.CheckIsDBNull(objDrParentTask("ActualEndDate"), ""))
            strActualWork = Data.CheckIsDBNull(objDrParentTask("ActualWork"), "").ToString + ""
            'End Addition

            If CType(Data.CheckIsDBNull(objDrParentTask("IsTaskComplete"), "0"), Boolean) = True Then
                strIsComplete = MyBase.GetResourceString("YES")
            Else
                strIsComplete = MyBase.GetResourceString("NO")
            End If

            'display parent task as group header
            General.WriteHTML("<TR class='clsTRGroupHeader'>")
            General.WriteHTML("<TD align='left'>" + strTaskName.Trim + "</TD>")
            General.WriteHTML("<TD align='left'>" + strResourceName.Trim + "</TD>")
            General.WriteHTML("<TD align='left'>" + strStartDate.Trim + "</TD>")
            General.WriteHTML("<TD align='left'>" + strEndDate.Trim + "</TD>")
            General.WriteHTML("<TD align='left'>" + strActualStartDate.Trim + "</TD>")
            General.WriteHTML("<TD align='left'>" + strActualEndDate.Trim + "</TD>")
            General.WriteHTML("<TD align='right'>" + strWork.Trim + "</TD>")
            General.WriteHTML("<TD align='right'>" + strActualWork.Trim + "</TD>")
            General.WriteHTML("<TD align='center'>" + strIsComplete.Trim + "</TD>")
            'strActualStartDate = ""
            'strActualEndDate = ""

            'strActualWork = ""
            'Modified by ShamkantD on 11 Dec 2004
            'As per discussion with SatchitS, the functionality of Voiding selective tasks or 
            'putting selective tasks on Hold in this page is being deactiavated.
            'Commented by ShamkantD
            'If UCase(m_strMode) = MODE_UNVOID Or UCase(m_strMode) = MODE_UNONHOLD Then
            '    General.WriteHTML("<TD align='center'>")
            '    General.WriteHTML(HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , (blnVoid Or blnOnHold), strParentTaskID, , , True))
            '    General.WriteHTML("</TD>")
            'End If
            'End of modification - ShamkantD on 11 Dec 2004

            General.WriteHTML("</TR>")

            'plot the child tasks for the parent task
            intRowNo = 0
            strSQL = "usp_Sel_tbl_PM_ProjectTasks_DeliverableTasks " + m_intProjectID.ToString + "," + m_intDeliverableID.ToString + "," + strParentTaskID.Trim
            objDrChildTask = Data.GetDataReader(strSQL, MyBase.UseSQL)
            While objDrChildTask.Read
                strTaskID = Data.CheckIsDBNull(objDrChildTask("TaskID"), "").ToString + ""
                strTaskName = Data.CheckIsDBNull(objDrChildTask("TaskName"), "").ToString + ""
                strResourceName = Data.CheckIsDBNull(objDrChildTask("EmployeeName"), "").ToString + ""

                'Modified By VidyaJ - IssueID - 315 - SP4
                'strStartDate = Data.CheckIsDBNull(objDrChildTask("StartDate"), "").ToString + ""
                'strEndDate = Data.CheckIsDBNull(objDrChildTask("EndDate"), "").ToString + ""
                'strActualStartDate = Data.CheckIsDBNull(objDrChildTask("ActualStartDate"), "").ToString + ""
                'strActualEndDate = Data.CheckIsDBNull(objDrChildTask("ActualEndDate"), "").ToString + ""

                strStartDate = CStr(Data.CheckIsDBNull(objDrChildTask("StartDate"), ""))
                strEndDate = CStr(Data.CheckIsDBNull(objDrChildTask("EndDate"), ""))
                strActualStartDate = CStr(Data.CheckIsDBNull(objDrChildTask("ActualStartDate"), ""))
                strActualEndDate = CStr(Data.CheckIsDBNull(objDrChildTask("ActualEndDate"), ""))
                'End Of Modifications - SP4    

                strWork = Data.CheckIsDBNull(objDrChildTask("Work"), "").ToString + ""
                strActualWork = Data.CheckIsDBNull(objDrChildTask("ActualWork"), "").ToString + ""
                blnVoid = DirectCast(Data.CheckIsDBNull(objDrChildTask("IsActive"), "0"), Boolean)
                blnOnHold = DirectCast(Data.CheckIsDBNull(objDrChildTask("TaskOnHold"), "0"), Boolean)
                If CType(Data.CheckIsDBNull(objDrChildTask("IsTaskComplete"), "0"), Boolean) = True Then
                    strIsComplete = MyBase.GetResourceString("YES")
                Else
                    strIsComplete = MyBase.GetResourceString("NO")
                End If

                'display parent task as group header
                If intRowNo Mod 2 = 0 Then
                    General.WriteHTML("<TR class='clsTREven'>")
                Else
                    General.WriteHTML("<TR class='clsTROdd'>")
                End If

                General.WriteHTML("<TD align='left'>" + strTaskName.Trim + "</TD>")
                General.WriteHTML("<TD align='left'>" + strResourceName.Trim + "</TD>")
                General.WriteHTML("<TD align='left'>" + strStartDate.Trim + "</TD>")
                General.WriteHTML("<TD align='left'>" + strEndDate.Trim + "</TD>")
                General.WriteHTML("<TD align='left'>" + strActualStartDate.Trim + "</TD>")
                General.WriteHTML("<TD align='left'>" + strActualEndDate.Trim + "</TD>")
                General.WriteHTML("<TD align='right'>" + strWork.Trim + "</TD>")
                General.WriteHTML("<TD align='right'>" + strActualWork.Trim + "</TD>")
                General.WriteHTML("<TD align='center'>" + strIsComplete.Trim + "</TD>")
                'Modified by ShamkantD on 11 Dec 2004
                'As per discussion with SatchitS, the functionality of Voiding selective tasks or 
                'putting selective tasks on Hold in this page is being deactiavated.
                'Commented by ShamkantD
                'If UCase(m_strMode) = MODE_UNVOID Or UCase(m_strMode) = MODE_UNONHOLD Then
                '    General.WriteHTML("<TD align='center'>")
                '    General.WriteHTML(HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , (blnVoid Or blnOnHold), strTaskID, , , True))
                '    General.WriteHTML("</TD>")
                'End If
                'End of modification - ShamkantD on 11 Dec 2004

                General.WriteHTML("</TR>")

            End While
            Data.DisposeDataReader(objDrChildTask)

        End While
        Data.DisposeDataReader(objDrParentTask)

        General.WriteHTML("</Table>")

    End Sub

    '=====================================================================
    ' Procedure Name		:	perfomAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To Update the deliverable related tasks to make them UnVoid or UnOnHold
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	30 Oct 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub perfomAction()
        Dim strSQL As String
        Dim strTaskIDList() As String
        Dim strTaskID As String

        strTaskID = MyBase.GetFormValue("chkSelect") + ""
        If strTaskID <> "" Then
            strTaskIDList = strTaskID.Split(","c)

            If UCase(m_strMode) = MODE_UNONHOLD Then
                'Remove the Void for the selected tasks
                For Each strTaskID In strTaskIDList
                    If strTaskID <> "" Then
                        strSQL = "usp_Upd_tbl_PM_ProjectTasks_UnOnHold " + strTaskID.Trim
                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                    End If
                Next
            Else
                'Remove the On Hold for the selected tasks
                For Each strTaskID In strTaskIDList
                    If strTaskID <> "" Then
                        strSQL = "usp_Upd_tbl_PM_ProjectTasks_UnVoid " + strTaskID.Trim
                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                    End If
                Next
            End If

        End If
    End Sub

End Class
