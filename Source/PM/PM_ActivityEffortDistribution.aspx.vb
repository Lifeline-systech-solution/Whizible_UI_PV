Imports CommonFunctions

Public Class PM_ActivityEffortDistribution
    Inherits WebPages.Template.WhizTemplate

    Protected Const CONST_ACTION_SAVE As String = "SAVE"

    Public m_strAction As String
    Protected m_strWindowTitle As String
    Private m_strUniqueID As String
    Private m_strProjectID As String
    Private m_strTemplateID As String
    Private m_strPhaseTaskID As String
    Private m_dblTemplateEffort As Double
    Private m_dblPhaseTaskEffort As Double
    Private m_strPhaseTaskName As String
    Private m_strTemplateName As String
    Private m_blnPhaseTaskMandatory As Boolean
    Private m_blnCopiedTamplate As Boolean


    'Code added By VidyaJ - Security Issue - 6197
    Protected m_strToken As String



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
    ' Created				:	07 Nov 2004
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
        '-- Code added by Nilesh
        Dim drCopyTemplate As IDataReader

        m_blnCopiedTamplate = False
        '--- Addition ends.

        m_strAction = Request.QueryString("Action")
        m_strProjectID = CommonFunction.General.CheckIsNothing(Session("intProjectID"), "").ToString
        m_strTemplateID = Request.QueryString("TemplateID") + ""
        If m_strTemplateID = "" Then m_strTemplateID = MyBase.GetFormValue("txtTemplateID") + ""
        m_strPhaseTaskID = Request.QueryString("PhaseTaskID") + ""
        If m_strPhaseTaskID = "" Then m_strPhaseTaskID = MyBase.GetFormValue("txtPhaseTaskID") + ""

        '--- Code added by Nilesh

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQL = "Select IsCopyTemplate from tbl_PM_Project_PhaseTask_Template "
        'strSQL = strSQL & " Where projectphasetasktemplateid = " & m_strTemplateID
        strSQL = "usp_sel_tbl_PM_Project_PhaseTask_Template_IsCopyTemplate " & m_strTemplateID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


        drCopyTemplate = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drCopyTemplate.Read Then
            m_blnCopiedTamplate = CType(Data.CheckIsDBNull(drCopyTemplate("IsCopyTemplate"), "0"), Boolean)
        End If
        Data.DisposeDataReader(drCopyTemplate)
        '--- Addition ends.

        'get the templateID, PhaseTaskID and effort details 
        If IsPostBack Then
            m_strPhaseTaskName = MyBase.GetFormValue("txtPhaseTaskName") + ""
            m_dblPhaseTaskEffort = CType(MyBase.GetFormValue("txtPhaseTaskEffort"), Double)
            'm_dblTemplateEffort = CType(MyBase.GetFormValue("txtTemplateEffort"), Double)
            m_blnPhaseTaskMandatory = CType(MyBase.GetFormValue("txtPhaseTaskMandatory"), Boolean)
            m_strTemplateName = MyBase.GetFormValue("txtTemplateName") + ""
        Else
            strSQL = "usp_Sel_GetTemplateAndPhaseTaskDetails " + m_strProjectID.Trim + "," + m_strTemplateID.Trim + "," + m_strPhaseTaskID
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                m_strPhaseTaskName = Data.CheckIsDBNull(objDr("PhaseTaskName"), "").ToString
                m_dblPhaseTaskEffort = CType(Data.CheckIsDBNull(objDr("Effort"), "0"), Double)
                'm_dblTemplateEffort = CType(Data.CheckIsDBNull(objDr("TemplateEffort"), "0"), Double)
                m_blnPhaseTaskMandatory = CType(Data.CheckIsDBNull(objDr("IsMandatory"), "0"), Boolean)
                m_strTemplateName = Data.CheckIsDBNull(objDr("TemplateName"), "").ToString
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
            arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('PM_ACTIVITYEFFORT_DISTRIBUTION')")

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

            MyBase.InitializeResources("AppResources.PM_ActivityEffortDistribution", "AppResources")
            'draw page caption 
            WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), MyBase.GetResourceString("CAP_TEMPLATE") + " : " + m_strTemplateName)
            General.WriteHTML("<BR>")

            Call plotActivityGrid()

            General.WriteHTML("<BR>")
            General.WriteHTML(strMenu)

            'strore all values in the hidden controls
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskName", "txtPhaseTaskName", , , , m_strPhaseTaskName.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtTemplateID", "txtTemplateID", , , , m_strTemplateID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskID", "txtPhaseTaskID", , , , m_strPhaseTaskID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskEffort", "txtPhaseTaskEffort", , , , m_dblPhaseTaskEffort.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            'General.WriteHTML(HTMLControls.DrawTextBox("txtTemplateEffort", "txtTemplateEffort", , , , m_dblTemplateEffort.ToString, , , , , , True, , True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtTemplateName", "txtTemplateName", , , , m_strTemplateName, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            If m_blnPhaseTaskMandatory = True Then
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskMandatory", "txtPhaseTaskMandatory", , , , "1", , , , , , True, , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                General.WriteHTML(HTMLControls.DrawTextBox("txtPhaseTaskMandatory", "txtPhaseTaskMandatory", , , , "0", , , , , , True, , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
        End If

    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_ActivityEffortDistribution", "AppResources")
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
    ' Created				:	07 Nov 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotActivityGrid()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim intRowCount As Integer
        Dim blnIsMandatory As Boolean, blnIsSelected As Boolean
        Dim strEffort As String
        Dim strDuration As String
        Dim strActivityName As String
        Dim strProjectPhaseTaskActivityID As String
        Dim strProjectPhaseTaskTemplateID As String

        'Added By ParagD on 14-Oct-2005
        'MASCON Issue 21432 
        Dim strActivityID As String
        'End Of Addition By ParagD on 14-Oct-2005

        'display phase task name and effort
        General.WriteHTML("<Table class='clsTable' cellpadding=0 cellspacing=0 width=99.9%>")
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align=left width=50% ><B>" + MyBase.GetResourceString("TASK") + " : </B>" + m_strPhaseTaskName.Trim + "</TD>")
        General.WriteHTML("<TD align=left width=50% ><B>" + MyBase.GetResourceString("TASK_EFFORT") + " : </B>" + m_dblPhaseTaskEffort.ToString + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        'plot grid for activity list
        General.WriteHTML("<Div id='PageDiv' width=100% height=90% style='overflow:auto'>")
        General.WriteHTML("<Table class='clsTable' cellpadding=0 cellspacing=0 width=99.9% >")

        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_ORDER") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_ACTIVITY") + "</TD>")
        If m_blnCopiedTamplate Then
            General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_SELECT") + "</TD>")
        End If
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_MANDATORY") + "</TD>")
        'If m_blnPercentEffortDistribution = True Then
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_EFFORT") + "</TD>")
        'Else
        '    General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_EFFORT_HRS") + "</TD>")
        'End If
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_DURATION") + "</TD>")
        General.WriteHTML("</TR>")

        intRowCount = 0
        strSQL = "usp_Sel_GetProjectTemplateActivityEffort " + m_strProjectID + "," + m_strTemplateID + "," + m_strPhaseTaskID
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDr.Read
            intRowCount += 1
            blnIsMandatory = False
            blnIsSelected = False

            strActivityName = Data.CheckIsDBNull(objDr("Title"), "").ToString
            blnIsMandatory = CType(Data.CheckIsDBNull(objDr("IsMandatory"), "0"), Boolean)
            '-- Code added by Nilesh on 91 May 2005
            If CType(objDr("Selected"), Boolean) = True Then
                blnIsSelected = True
            End If
            '--- Addition ends.

            'Added By ParagD on 14-Oct-2005
            'MASCON Issue 21432 
            strActivityID = Data.CheckIsDBNull(objDr("ActivityID"), "").ToString
            If m_blnPhaseTaskMandatory = False Then
                blnIsMandatory = False
            End If
            'End Of Addition By ParagD on 14-Oct-2005    

            strEffort = Data.CheckIsDBNull(objDr("Effort"), "").ToString
            strDuration = Data.CheckIsDBNull(objDr("EffortDuration"), "").ToString
            strProjectPhaseTaskActivityID = Data.CheckIsDBNull(objDr("ProjectPhaseTaskActivityID_PK"), "").ToString
            strProjectPhaseTaskTemplateID = Data.CheckIsDBNull(objDr("ProjectPhaseTaskTemplateID"), "").ToString

            If intRowCount Mod 2 = 0 Then
                General.WriteHTML("<TR class='clsTREven'>")
            Else
                General.WriteHTML("<TR class='clsTROdd'>")
            End If

            General.WriteHTML("<TD align='center' >")
            General.WriteHTML(Data.CheckIsDBNull(objDr("ActivityOrderNumber"), "").ToString)
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align='left' >")

            'Coded Added By VidyaJ - Security Issue - 6197    
            m_strToken = CommonFunctions.Security.Token.GetToken(strProjectPhaseTaskActivityID + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "2178")

            General.WriteHTML("<A href=javascript:Activity_OnClick('" + strProjectPhaseTaskActivityID.Trim + "','" + m_strToken + "')>" + strActivityName.Trim + "</A>")
            General.WriteHTML("</TD>")
            '--- Code added by NileshJ on 18 May 2005
            If m_blnCopiedTamplate Then
                General.WriteHTML("<TD align='center' >")
                General.WriteHTML(HTMLControls.DrawCheckBox("chkSelect" + intRowCount.ToString, "chkSelect" + intRowCount.ToString, , blnIsSelected, , , "onclick='javascript:Select_OnClick(" + intRowCount.ToString + ")'", True))
                General.WriteHTML("</TD>")
            End If
            '--- Addition ends.

            If m_blnCopiedTamplate Then
                General.WriteHTML("<TD align='center' >")
                '' Commented and added by ParagD On 14-Oct-2005
                '' MASCON Issue 21432 
                '' General.WriteHTML(HTMLControls.DrawCheckBox("chkMandatory" + intRowCount.ToString, "chkMandatory" + intRowCount.ToString, , blnIsMandatory, , True, , True))
                General.WriteHTML(HTMLControls.DrawCheckBox("chkMandatory" + intRowCount.ToString, "chkMandatory" + intRowCount.ToString, , blnIsMandatory, strActivityID.Trim, False, , True))
                'End Of Addition By ParagD on 14-Oct-2005
                General.WriteHTML("</TD>")
            Else
            General.WriteHTML("<TD align='center' >")
                '' Commented and added by ParagD On 14-Oct-2005
                '' MASCON Issue 21432 
                '' General.WriteHTML(HTMLControls.DrawCheckBox("chkMandatory" + intRowCount.ToString, "chkMandatory" + intRowCount.ToString, , blnIsMandatory, , True, , True))
                General.WriteHTML(HTMLControls.DrawCheckBox("chkMandatory" + intRowCount.ToString, "chkMandatory" + intRowCount.ToString, , blnIsMandatory, strActivityID.Trim, True, , True))
                'End Of Addition By ParagD on 14-Oct-2005
            General.WriteHTML("</TD>")
            End If


            General.WriteHTML("<TD align='left' >")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtEffort" + intRowCount.ToString, "txtEffort" + intRowCount.ToString, , 50, 10, strEffort.Trim, "right", , , , , , , True, True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align='left' >")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtDuration" + intRowCount.ToString, "txtDuration" + intRowCount.ToString, , 50, 10, strDuration.Trim, "right", , , , , , , True, True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML("</TD>")

            'plot hidden controls
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtProjectPhaseTaskTemplateID" + intRowCount.ToString, "txtProjectPhaseTaskTemplateID" + intRowCount.ToString, , , , strProjectPhaseTaskTemplateID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

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
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txtRowCount", "txtRowCount", , , , intRowCount.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
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
    ' Created				:	07 Nov 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performAction()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim intRowCount As Integer
        Dim strEffort As String
        Dim strDuration As String
        Dim strProjectPhaseTaskTemplateID As String

        ' Added By NitinVS on 21 Feb 2005
        Dim StrSqlQuery As String
        Dim TotalActivityDuration As Double
        Dim intPhaseTaskID As Integer
        Dim intTemplateID As Integer
        Dim strSelected As String
        ' End Addition By NitinVS on 21 Feb 2005 

        'Added By ParagD on 14-Oct-2005
        'MASCON Issue 21432 
        Dim blnIsMandatory As Boolean
        'End Of Addition By ParagD on 14-Oct-2005    

        'get the total row count
        intRowCount = CType(General.CheckIsNothing(GetFormValue("txtRowCount"), "0"), Integer)

        Dim i As Integer
        For i = 1 To intRowCount

            strProjectPhaseTaskTemplateID = MyBase.GetFormValue("txtProjectPhaseTaskTemplateID" + i.ToString) + ""
            If Not Request.Form("chkSelect" + i.ToString) Is Nothing Or m_blnCopiedTamplate = False Then
                strDuration = Trim(MyBase.GetFormValue("txtDuration" + i.ToString) + "")
                strEffort = Trim(MyBase.GetFormValue("txtEffort" + i.ToString) + "")
                strSelected = "1"

                strSQL = "usp_Upd_tbl_PM_Project_PhaseTask_TemplateActivityEffort "
                strSQL += strProjectPhaseTaskTemplateID.Trim
                strSQL += "," + strEffort
                strSQL += "," + strDuration

                TotalActivityDuration = TotalActivityDuration + CType(strDuration.Trim, Double)
            Else
                strSelected = "0"
                strSQL = "usp_Upd_tbl_PM_Project_PhaseTask_TemplateActivityEffort "
                strSQL += strProjectPhaseTaskTemplateID.Trim
            End If

            'update data
            Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            '' Commented and added By ParagD on 14-Oct-2005
            '' MASCON Issue 21432 

            ''--- Code added by Nilesh on 19 May
            ''--- Updated selected flag for the given project phase task ID.
            'strSQL = " Update tbl_PM_Project_PhaseTask_TemplateActivityEffort Set Selected = " & strSelected
            'strSQL = strSQL & " WHere ProjectPhaseTaskTemplateID = " & strProjectPhaseTaskTemplateID

           
            If MyBase.GetFormValue("chkMandatory" + i.ToString) <> "" Then
                blnIsMandatory = True
            End If

            '--- Code added by Nilesh on 19 May
            '--- Updated selected flag for the given project phase task ID.
            If blnIsMandatory = True Then
                strSQL = " Update tbl_PM_Project_PhaseTask_TemplateActivityEffort Set Selected = " & strSelected & ",IsMandatory = 1 "
            strSQL = strSQL & " WHere ProjectPhaseTaskTemplateID = " & strProjectPhaseTaskTemplateID
            Else
                strSQL = " Update tbl_PM_Project_PhaseTask_TemplateActivityEffort Set Selected = " & strSelected & ",IsMandatory = 0 "
                strSQL = strSQL & " WHere ProjectPhaseTaskTemplateID = " & strProjectPhaseTaskTemplateID
            End If
            'End Of Addition By ParagD on 14-Oct-2005

            'update data
            Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        Next

        ' Added By NitinVS on 21 Feb 2005 
        ' To Update the Duration of the Phase task = Sum of Duration of all task 

        If TotalActivityDuration >= 0 Then

            StrSqlQuery = "Update tbl_PM_Project_PhaseTask_Template_Effort "
            StrSqlQuery += " SET TaskDuration = " + TotalActivityDuration.ToString
            StrSqlQuery += " WHERE  TemplateID = " + m_strTemplateID
            StrSqlQuery += " AND PhaseTaskID = " + m_strPhaseTaskID

            CommonFunction.Data.InsertOrUpdateData(StrSqlQuery, MyBase.UseSQL)

        End If

        'End Addition By NitinVS on 21 Feb 2005 

    End Sub


End Class
