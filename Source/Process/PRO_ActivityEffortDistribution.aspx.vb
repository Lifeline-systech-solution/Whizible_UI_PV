Imports CommonFunctions

Public Class PRO_ActivityEffortDistribution
    Inherits WebPages.Template.WhizTemplate

    Protected Const CONST_ACTION_SAVE As String = "Save"


    Public m_strAction As String
    Protected m_strWindowTitle As String
    Private m_strUniqueID As String
    Private m_strTemplateID As String
    Private m_strPhaseTaskID As String
    Private m_dblTemplateEffort As Double
    Private m_dblPhaseTaskEffort As Double
    Private m_blnPercentEffortDistribution As Boolean
    Private m_strPhaseTaskName As String
    Private m_blnPhaseTaskMandatory As Boolean


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
    ' Created				:	Jul 28 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strSQL As String
        Dim objDr As IDataReader

        m_strAction = Request.QueryString("Action")
        If Request.QueryString("UniqueID") <> "" Then
            m_strUniqueID = Request.QueryString("UniqueID") + ""
        Else
            m_strUniqueID = MyBase.GetFormValue("txtUniqueID") + ""
        End If

        'get the templateID, PhaseTaskID and effort details 
        If IsPostBack Then
            m_strPhaseTaskName = MyBase.GetFormValue("txtPhaseTaskName") + ""
            m_strTemplateID = MyBase.GetFormValue("txtTemplateID") + ""
            m_strPhaseTaskID = MyBase.GetFormValue("txtPhaseTaskID") + ""
            m_dblPhaseTaskEffort = CType(MyBase.GetFormValue("txtPhaseTaskEffort"), Double)
            m_dblTemplateEffort = CType(MyBase.GetFormValue("txtTemplateEffort"), Double)
            m_blnPercentEffortDistribution = CType(MyBase.GetFormValue("txtPercentEffortDistribution"), Boolean)
            m_blnPhaseTaskMandatory = CType(MyBase.GetFormValue("txtPhaseTaskMandatory"), Boolean)
        Else
            strSQL = "usp_Sel_PRS_PhaseTask_Template_Details " + m_strUniqueID.Trim
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                m_strPhaseTaskName = Data.CheckIsDBNull(objDr("PhaseTaskName"), "").ToString
                m_strTemplateID = Data.CheckIsDBNull(objDr("TemplateID"), "").ToString
                m_strPhaseTaskID = Data.CheckIsDBNull(objDr("PhaseTaskID"), "").ToString
                m_dblPhaseTaskEffort = CType(Data.CheckIsDBNull(objDr("PhaseTaskEffort"), "0"), Double)
                m_dblTemplateEffort = CType(Data.CheckIsDBNull(objDr("TemplateEffort"), "0"), Double)
                m_blnPercentEffortDistribution = CType(Data.CheckIsDBNull(objDr("PercentageEffortDistribution"), "0"), Boolean)
                m_blnPhaseTaskMandatory = CType(Data.CheckIsDBNull(objDr("IsMandatory"), "0"), Boolean)
            End If
            Data.DisposeDataReader(objDr)

        End If

        If m_strPhaseTaskID <> "" And m_strTemplateID <> "" Then

            'if save action given then update data
            If m_strAction <> "" Then
                Call performAction()
            End If

            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            arrMenu = New System.Collections.ArrayList
            arrMenuToolTip = New System.Collections.ArrayList
            arrClientSideFunctions = New System.Collections.ArrayList

            arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
            arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
            arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('ActivityEffortDistribution')")

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

            MyBase.InitializeResources("AppResources.PRO_ActivityEffortDistribution", "AppResources")
            'draw page caption 
            WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"))
            General.WriteHTML("<BR>")

            Call plotActivityGrid()

            General.WriteHTML("<BR>")
            General.WriteHTML(strMenu)
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'strore all values in the hidden controls
            'General.WriteHTML(HTMLControls.DrawTextBox("txtUniqueID", "txtUniqueID", , , , m_strUniqueID.Trim, , , , , , True, , True))
            'General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskName", "txtPhaseTaskName", , , , m_strPhaseTaskName.Trim, , , , , , True, , True))
            'General.WriteHTML(HTMLControls.DrawTextBox("txtTemplateID", "txtTemplateID", , , , m_strTemplateID.Trim, , , , , , True, , True))
            'General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskID", "txtPhaseTaskID", , , , m_strPhaseTaskID.Trim, , , , , , True, , True))
            'General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskEffort", "txtPhaseTaskEffort", , , , m_dblPhaseTaskEffort.ToString, , , , , , True, , True))
            'General.WriteHTML(HTMLControls.DrawTextBox("txtTemplateEffort", "txtTemplateEffort", , , , m_dblTemplateEffort.ToString, , , , , , True, , True))
            'If m_blnPercentEffortDistribution = True Then
            '    General.WriteHTML(HTMLControls.DrawTextBox("txtPercentEffortDistribution", "txtPercentEffortDistribution", , , , "1", , , , , , True, , True))
            'Else
            '    General.WriteHTML(HTMLControls.DrawTextBox("txtPercentEffortDistribution", "txtPercentEffortDistribution", , , , "0", , , , , , True, , True))
            'End If
            'If m_blnPhaseTaskMandatory = True Then
            '    General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskMandatory", "txtPhaseTaskMandatory", , , , "1", , , , , , True, , True))
            'Else
            '    General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskMandatory", "txtPhaseTaskMandatory", , , , "0", , , , , , True, , True))
            'End If
            General.WriteHTML(HTMLControls.DrawTextBox("txtUniqueID", "txtUniqueID", , , , m_strUniqueID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskName", "txtPhaseTaskName", , , , m_strPhaseTaskName.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtTemplateID", "txtTemplateID", , , , m_strTemplateID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskID", "txtPhaseTaskID", , , , m_strPhaseTaskID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskEffort", "txtPhaseTaskEffort", , , , m_dblPhaseTaskEffort.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtTemplateEffort", "txtTemplateEffort", , , , m_dblTemplateEffort.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            If m_blnPercentEffortDistribution = True Then
                General.WriteHTML(HTMLControls.DrawTextBox("txtPercentEffortDistribution", "txtPercentEffortDistribution", , , , "1", , , , , , True, , True, EnableHTMLEncode:=True))
            Else
                General.WriteHTML(HTMLControls.DrawTextBox("txtPercentEffortDistribution", "txtPercentEffortDistribution", , , , "0", , , , , , True, , True, EnableHTMLEncode:=True))
            End If
            If m_blnPhaseTaskMandatory = True Then
                General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskMandatory", "txtPhaseTaskMandatory", , , , "1", , , , , , True, , True, EnableHTMLEncode:=True))
            Else
                General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskMandatory", "txtPhaseTaskMandatory", , , , "0", , , , , , True, , True, EnableHTMLEncode:=True))
            End If
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        End If

    End Sub

    Public Sub New()
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PRO_ActivityEffortDistribution", "AppResources")
        'MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE")
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotActivityGrid
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot list of activities with controls
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	28 Jul 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotActivityGrid()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim intRowCount As Integer
        Dim blnIsEnabled As Boolean
        Dim blnIsSelected As Boolean
        Dim blnIsMandatory As Boolean
        Dim strEffort As String
        Dim strDuration As String
        Dim strActivityID As String
        Dim strPhaseTaskTemplateID As String
        Dim strActivityName As String

        'display phase task name and effort
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table class='clsTable' cellpadding=0 cellspacing=0 width=99.9%>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align=left width=50% ><B>" + MyBase.GetResourceString("CAP_PHASETASK") + " : </B>" + m_strPhaseTaskName.Trim + "</TD>")
        General.WriteHTML("<TD align=left width=50% ><B>" + MyBase.GetResourceString("CAP_PHASETASK_EFFORT") + " : </B>" + m_dblPhaseTaskEffort.ToString + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        'plot grid for activity list
        General.WriteHTML("<Div id='PageDiv' width=100% height=90% style='overflow:auto'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table class='clsTable' cellpadding=0 cellspacing=0 width=99.9% >")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_ORDER") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_ACTIVITY") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_SELECT") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_MANDATORY") + "</TD>")
        'If m_blnPercentEffortDistribution = True Then
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_EFFORT_PERC") + "</TD>")
        'Else
        '    General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_EFFORT_HRS") + "</TD>")
        'End If
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_DURATION") + "</TD>")
        General.WriteHTML("</TR>")

        intRowCount = 0
        strSQL = "usp_sel_ActivitiesForPhaseTask_ForEffortDistribution " + m_strUniqueID.Trim
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDr.Read
            intRowCount += 1
            blnIsEnabled = False
            blnIsSelected = False
            blnIsMandatory = False
            strActivityID = Data.CheckIsDBNull(objDr("ActivityID"), "").ToString
            strActivityName = Data.CheckIsDBNull(objDr("Title"), "").ToString
            strPhaseTaskTemplateID = ""
            strEffort = ""
            strDuration = ""

            'if activity is already selected, then show checked checkbox and other values
            If IsDBNull(objDr("PhaseTaskTemplateID")) = False Then
                strPhaseTaskTemplateID = Data.CheckIsDBNull(objDr("PhaseTaskTemplateID"), "").ToString
                blnIsSelected = True
                strEffort = Data.CheckIsDBNull(objDr("ActivityEffort"), "0").ToString
                strDuration = Data.CheckIsDBNull(objDr("ActivityDuration"), "0").ToString
                If m_blnPhaseTaskMandatory = True Then
                    blnIsEnabled = True
                    blnIsMandatory = CType(Data.CheckIsDBNull(objDr("IsMandatory"), "0"), Boolean)
                End If
            End If

            If intRowCount Mod 2 = 0 Then
                General.WriteHTML("<TR class='clsTREven'>")
            Else
                General.WriteHTML("<TR class='clsTROdd'>")
            End If

            General.WriteHTML("<TD align='center' >")
            General.WriteHTML(Data.CheckIsDBNull(objDr("ActivityOrderNumber"), "").ToString)
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align='left' >")
            General.WriteHTML(strActivityName.Trim)
            General.WriteHTML("</TD>")

            'Modified by SachinR    on 15 Oct 2004
            'Purpose    Moved this column this(third) position from the last position
            General.WriteHTML("<TD align='center' >")
            General.WriteHTML(HTMLControls.DrawCheckBox("chkSelect" + intRowCount.ToString, "chkSelect" + intRowCount.ToString, , blnIsSelected, strActivityID.Trim, , "onclick='javascript:Select_OnClick(" + intRowCount.ToString + ")'", True))
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align='center' >")
            General.WriteHTML(HTMLControls.DrawCheckBox("chkMandatory" + intRowCount.ToString, "chkMandatory" + intRowCount.ToString, , blnIsMandatory, strActivityID.Trim, Not blnIsEnabled, , True))
            General.WriteHTML("</TD>")
            'modification end

            General.WriteHTML("<TD align='left' >")
            ''General.WriteHTML(HTMLControls.DrawTextBox("txtEffort" + intRowCount.ToString, "txtEffort" + intRowCount.ToString, , 50, 10, strEffort.Trim, "right", , Not blnIsSelected, , , , , True, True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtEffort" + intRowCount.ToString, "txtEffort" + intRowCount.ToString, , 50, 10, strEffort.Trim, "right", , Not blnIsSelected, , , , , True, True, EnableHTMLEncode:=True))
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align='left' >")
            ''General.WriteHTML(HTMLControls.DrawTextBox("txtDuration" + intRowCount.ToString, "txtDuration" + intRowCount.ToString, , 100, 10, strDuration.Trim, "right", , Not blnIsSelected, , , , , True, True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtDuration" + intRowCount.ToString, "txtDuration" + intRowCount.ToString, , 100, 10, strDuration.Trim, "right", , Not blnIsSelected, , , , , True, True, EnableHTMLEncode:=True))
            General.WriteHTML("</TD>")

            'plot hidden controls
            ''General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskTemplateID" + intRowCount.ToString, "txtPhaseTaskTemplateID" + intRowCount.ToString, , , , strPhaseTaskTemplateID.Trim, , , , , , True, , True))
            ''General.WriteHTML(HTMLControls.DrawTextBox("txtActivityID" + intRowCount.ToString, "txtActivityID" + intRowCount.ToString, , , , strActivityID.Trim, , , , , , True, , True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskTemplateID" + intRowCount.ToString, "txtPhaseTaskTemplateID" + intRowCount.ToString, , , , strPhaseTaskTemplateID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtActivityID" + intRowCount.ToString, "txtActivityID" + intRowCount.ToString, , , , strActivityID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML("</TR>")
        End While
        Data.DisposeDataReader(objDr)

        If intRowCount = 0 Then
            General.WriteHTML("<TR class='clsTROdd'>")
            General.WriteHTML("<TD align='center'>" + MyBase.GetResourceString("MSG_NORECORD") + "</TD>")
            General.WriteHTML("</TR>")
        End If
        General.WriteHTML("</Table>")
        'store row count in hidden control
        ''General.WriteHTML(HTMLControls.DrawTextBox("txtRowCount", "txtRowCount", , , , intRowCount.ToString, , , , , , True, , True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtRowCount", "txtRowCount", , , , intRowCount.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML("</Div>")

    End Sub

    '=====================================================================
    ' Procedure Name		:	performAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data for phasetask template activity effort
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	28 Jul 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performAction()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim intRowCount As Integer
        Dim blnIsSelected As Boolean
        Dim blnIsMandatory As Boolean
        Dim strEffort As String
        Dim strDuration As String
        Dim strActivityID As String
        Dim strPhaseTaskTemplateID As String

        ' Added By NitinVS on 21 Feb 2005
        Dim StrSqlQuery As String
        Dim TotalActivityDuration As Double
        ' End Addition By NitinVS on 21 Feb 2005 

        'get the total row count
        intRowCount = CType(General.CheckIsNothing(GetFormValue("txtRowCount"), "0"), Integer)

        Dim i As Integer
        For i = 1 To intRowCount
            If MyBase.GetFormValue("chkSelect" + i.ToString) <> "" Then

                strPhaseTaskTemplateID = MyBase.GetFormValue("txtPhaseTaskTemplateID" + i.ToString) + ""
                strActivityID = MyBase.GetFormValue("txtActivityID" + i.ToString) + ""
                strDuration = MyBase.GetFormValue("txtDuration" + i.ToString) + ""
                strEffort = MyBase.GetFormValue("txtEffort" + i.ToString) + ""
                blnIsMandatory = False
                If MyBase.GetFormValue("chkMandatory" + i.ToString) <> "" Then
                    blnIsMandatory = True
                End If

                strSQL = "usp_Ins_tbl_PRS_PhaseTask_TemplateActivityEffort "
                strSQL += m_strUniqueID.Trim
                strSQL += "," + strActivityID.Trim
                strSQL += "," + strEffort.Trim
                strSQL += "," + strDuration.Trim
                If blnIsMandatory = True Then
                    strSQL += ",1"
                Else
                    strSQL += ",0"
                End If
                'if activity previously selected, then pass phaseTaskTemplateID
                'so record will be updated in the SP, else inserted
                If strPhaseTaskTemplateID <> "" Then
                    strSQL += "," + strPhaseTaskTemplateID.Trim
                End If
                'update data
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                ' Added By NitinVS on 21 Feb 2005 
                ' To Update the Duration of the Phase task = Sum of Duration of all task 

                If strDuration.Trim <> "" Then
                    TotalActivityDuration = TotalActivityDuration + CType(strDuration.Trim, Double)
                End If

                ' End Addition by NitinVS on 21 Feb 2005 

            Else
                If MyBase.GetFormValue("txtPhaseTaskTemplateID" + i.ToString) <> "" Then
                    'if record was previously selected and now unselected then delete record
                    strPhaseTaskTemplateID = MyBase.GetFormValue("txtPhaseTaskTemplateID" + i.ToString) + ""
                    strSQL = "usp_del_tbl_PRS_PhaseTask_TemplateActivityEffort " + strPhaseTaskTemplateID.Trim
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                End If
            End If
        Next

        ' Added By NitinVS on 21 Feb 2005 
        ' To Update the Duration of the Phase task = Sum of Duration of all task 

        If TotalActivityDuration >= 0 Then
            StrSqlQuery = "Update tbl_PRS_PhaseTask_Template_Effort "
            StrSqlQuery += " SET TaskDuration = " + TotalActivityDuration.ToString
            StrSqlQuery += " WHERE UniqueID = " + m_strUniqueID.Trim

            CommonFunction.Data.InsertOrUpdateData(StrSqlQuery, MyBase.UseSQL)

        End If

        'End Addition By NitinVS on 21 Feb 2005 

    End Sub
End Class
