#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class CheckListResponses
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Page Name 	        :	CheckListResponses
    ' Purpose				:	To allow user to input check list responses (Process verification module)
    ' Description			:	same
    ' Assumptions		:	
    ' Dependencies		:	
    ' Author				    :	Padmnabh Anturkar
    ' Created				:	
    ' Revisions				:	
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

#Region "Member Variables"
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.

    Private m_strUniqueID, _
                m_strSDLCID, _
                m_strCheckListID, _
                m_strChecklistName, _
                m_strProcessID As String

    Private m_strMode, m_strAction As String
    Private m_intResponseID As Integer
    Private m_intUniqueID As Integer
#End Region

#Region "ProjectByNet Template Generated Code"

    Private Sub GetGlobalObject()
        '===============================================================================
        ' Procedure Name  :	GetGlobalObject
        ' Purpose   			:	Golbal Object
        ' Parameters			:	None
        ' Affected params	:	None
        ' Returns               :	same
        ' Dependencies		:	
        ' Description          :	
        ' Author				    :	[Auto generated Code From ProjectByNet Template] - Added By Padmnabh Anturkar 
        ' Created				:	March, 17  2006
        ' Revisions				:	
        '===============================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub

    Private Sub DrawMenu()
        '===============================================================================
        ' Procedure Name  :	DrawMenu
        ' Purpose   			:	Draws the menu
        ' Parameters			:	None
        ' Affected params	:	None
        ' Returns               :	same
        ' Dependencies		:	
        ' Description          :	
        ' Author				    :	[Auto generated Code From ProjectByNet Template] - Added By Padmnabh Anturkar 
        ' Created				:	March, 17  2006
        ' Revisions				:	1. Padmnabh A
        '                                    Added array defination for menu names, tool tip and client side function
        '===============================================================================
        'Dim arrMenu() As String = {"Save", "Back"}
        'Dim arrMenuToolTip() As String = {"Save", "Back"}
        'Dim arrClientSideFunction() As String = {"save_OnClick('" + m_strMode + "')", "back_OnClick()"}
        'cerate the static menu.
        'strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)

        Dim arrMenu As New ArrayList
        Dim arrMenuToolTip As New ArrayList
        Dim arrClientSideFunction As New ArrayList
        If m_strMode.ToUpper = "ADDNEW" Then
            arrMenu.Add("Save")
            arrMenuToolTip.Add("Save")
            arrClientSideFunction.Add("save_OnClick()")
        End If
        arrMenu.Add("Back")
        arrMenuToolTip.Add("Back")
        arrClientSideFunction.Add("back_OnClick()")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenu), GetArray(arrClientSideFunction), GetArray(arrMenuToolTip), True)

    End Sub
    Private Sub DrawHeader()
        '===============================================================================
        ' Procedure Name  :	DrawHeader
        ' Purpose   			:	Draws the page Header thr' global object
        ' Parameters			:	None
        ' Affected params	:	None
        ' Returns               :	same
        ' Dependencies		:	
        ' Description          :	
        ' Author				    :	[Auto generated Code From ProjectByNet Template] - Added By Padmnabh Anturkar 
        ' Created				:	March, 17  2006
        ' Revisions				:	
        '===============================================================================
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
        '===============================================================================
        ' Procedure Name  :	DisposeObjects
        ' Purpose   			:	Dispose all objects
        ' Parameters			:	None
        ' Affected params	:	None
        ' Returns               :	same
        ' Dependencies		:	
        ' Description          :	
        ' Author				    :	[Auto generated Code From ProjectByNet Template] - Added By Padmnabh Anturkar 
        ' Created				:	March, 17  2006
        ' Revisions				:	
        '===============================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing
    End Sub

#End Region

#Region "Functions & Procedures"

    Public Sub PageInit()
        '===============================================================================
        ' Procedure Name  :	PageInit
        ' Purpose   			:	Initialize page
        ' Parameters			:	None
        ' Affected params	:	None
        ' Returns               :	same
        ' Dependencies		:	
        ' Description          :	
        ' Author				    :	Padmnabh Anturkar 
        ' Created				:	March, 17  2006
        ' Revisions				:	
        '===============================================================================
        ' Initialize parameters used on the page
        InitParams()

        'if Action is save then save Checklist Responses
        If m_strAction.ToUpper = "SAVE" Then
            SaveResponses()
        End If

        'This will initialize all the global objects.
        GetGlobalObject()

        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Header if exist. 
        DrawHeader()

        'Hidden variables - Checklist Id, Sdlc Id, Process Id
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'CommonFunctions.HTMLControls.DrawTextBox("checklist", "checklist", , , , m_strCheckListID, , , , , , True)
        'CommonFunctions.HTMLControls.DrawTextBox("sdlc", "sdlc", , , , m_strSDLCID, , , , , , True)
        'CommonFunctions.HTMLControls.DrawTextBox("Process", "Process", , , , m_strProcessID, , , , , , True)
        CommonFunctions.HTMLControls.DrawTextBox("checklist", "checklist", , , , m_strCheckListID, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("sdlc", "sdlc", , , , m_strSDLCID, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("Process", "Process", , , , m_strProcessID, , , , , , True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        CommonFunctions.General.WriteHTML("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
        CommonFunctions.General.WriteHTML("<table id='tblChecklistItems' class='clstable' width='99.99%' ><tr class='clsTREven'><td>")
        CommonFunctions.General.WriteHTML("Check List Item : </td><td>")
        CommonFunctions.HTMLControls.DrawComboBox("cboCheckList", "usp_sel_sdlc_applicableChecklist " + m_strSDLCID, 300, m_strCheckListID, "OnChange = Checklist_OnChange()", True)
        CommonFunctions.General.WriteHTML("</td><tr></table>")

        If Not Request.QueryString("CheckListID") Is Nothing Then
            drawCheckList()
        End If

        HttpContext.Current.Response.Write("</DIV>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        DisposeObjects()
    End Sub

    Private Sub InitParams()
        '===============================================================================
        ' Procedure Name  :	InitParams
        ' Purpose   			:	Initialize all parameters (query string, session) used on the page.
        ' Parameters			:	None
        ' Affected params	:	None
        ' Returns               :	same
        ' Dependencies		:	
        ' Description          :	
        ' Author				    :	Padmnabh Anturkar 
        ' Created				:	March, 17  2006
        ' Revisions				:	
        '===============================================================================
        If Not Request.QueryString("UniqueID") Is Nothing Then
            m_strUniqueID = Request.QueryString("UniqueID")
        Else
            m_strUniqueID = ""
        End If

        If Not Request.QueryString("SDLCID") Is Nothing Then
            m_strSDLCID = Request.QueryString("SDLCID")
        Else
            m_strSDLCID = ""
        End If
        If Not Request.QueryString("CheckListID") Is Nothing Then
            m_strCheckListID = Request.QueryString("CheckListID")
        Else
            m_strCheckListID = ""
        End If
        If Not Request.QueryString("ProcessID") Is Nothing Then
            m_strProcessID = Request.QueryString("ProcessID")
        Else
            m_strProcessID = ""
        End If

        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode")
        Else
            m_strMode = "AddNew"
        End If

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action")
        Else
            m_strAction = ""
        End If

        If Not Request.QueryString("ChecklistName") Is Nothing Then
            m_strChecklistName = Request.QueryString("ChecklistName")
        Else
            m_strChecklistName = ""
        End If
    End Sub
    Private Sub drawCheckList()
        '===============================================================================
        ' Procedure Name  :	drawCheckList
        ' Purpose   			:	Draw the check list 
        ' Parameters			:	None
        ' Affected params	:	None
        ' Returns               :	same
        ' Dependencies		:	
        ' Description          :	
        ' Author				    :	Padmnabh Anturkar 
        ' Created				:	March, 17  2006
        ' Revisions				:	
        '===============================================================================

        'Variables Declaration
        Dim strHtml As New System.Text.StringBuilder
        Dim drChecklistItems As IDataReader
        Dim intLoopCounter, intSerialCounter As Integer
        Dim strTRClass As String
        Dim lngCheckListItemID As Long = 0
        Dim strTempDescription As String

        'Depending on mode parameters passes to database procedure changes
        If m_strMode.ToUpper = "ADDNEW" Then
            drChecklistItems = CommonFunctions.Data.GetDataReader("usp_sel_SDLC_CheckListItems " + m_strCheckListID + ", 0 ", MyBase.UseSQL)
        ElseIf m_strMode.ToUpper = "EDIT" Then
            drChecklistItems = CommonFunctions.Data.GetDataReader("usp_sel_SDLC_CheckListItems " + m_strUniqueID + ", 1 ", MyBase.UseSQL)
        End If

        With strHtml
            .Append("<table id='Questions' width='99.99%' class='clsGridTable', cellpadding = '0' cellspacing = '1'>")
            .Append("<tr class='clstrColumnHeader'>")
            .Append("<td width='60%'> Checklist Item </td>")
            .Append("<td width='40%'> Response </td>")
            .Append("</tr>")
            intLoopCounter = 1
            intSerialCounter = 0
            While drChecklistItems.Read
                If strTempDescription <> CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("CheckListItemGroupName"), "0"), String) Then
                    strTempDescription = CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("CheckListItemGroupName"), "0"), String)
                    If intLoopCounter <> 1 Then
                        .Append("</td></tr>")
                    End If
                    .Append("<tr class='clsTRSectionHeader'>")
                    .Append("<td colspan='2'>" + drChecklistItems.Item("CheckListItemGroupName").ToString)
                    .Append("</td></tr>")
                End If
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                '.Append(CommonFunctions.HTMLControls.DrawTextBox("hidChecklistItemId" + intLoopCounter.ToString, "hidChecklistItemId" + intLoopCounter.ToString, , , , CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("CheckListItemID"), "0"), String), , , , , , True, , True))
                '.Append(CommonFunctions.HTMLControls.DrawTextBox("hidChecklistItemName" + intLoopCounter.ToString, "hidChecklistItemName" + intLoopCounter.ToString, , , , drChecklistItems.Item("ChecklistItemName").ToString, , , , , , True, , True))
                '.Append(CommonFunction.HTMLControls.DrawTextBox("hidItemGroupName" + intLoopCounter.ToString, "CheckListItemGroupName" + intLoopCounter.ToString, , , , drChecklistItems.Item("CheckListItemGroupName").ToString, , , , , , True, , True))
                '.Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseId" + intLoopCounter.ToString, "hidResponseId" + intLoopCounter.ToString, , , , CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseID"), "0"), String), , , , , , True, , True))
                '.Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseDescription" + intLoopCounter.ToString, "hidResponseDescription" + intLoopCounter.ToString, , , , CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), "0"), String), , , , , , True, , True))
                .Append(CommonFunctions.HTMLControls.DrawTextBox("hidChecklistItemId" + intLoopCounter.ToString, "hidChecklistItemId" + intLoopCounter.ToString, , , , CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("CheckListItemID"), "0"), String), , , , , , True, , True, EnableHTMLEncode:=True))
                .Append(CommonFunctions.HTMLControls.DrawTextBox("hidChecklistItemName" + intLoopCounter.ToString, "hidChecklistItemName" + intLoopCounter.ToString, , , , drChecklistItems.Item("ChecklistItemName").ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                .Append(CommonFunction.HTMLControls.DrawTextBox("hidItemGroupName" + intLoopCounter.ToString, "CheckListItemGroupName" + intLoopCounter.ToString, , , , drChecklistItems.Item("CheckListItemGroupName").ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseId" + intLoopCounter.ToString, "hidResponseId" + intLoopCounter.ToString, , , , CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseID"), "0"), String), , , , , , True, , True, EnableHTMLEncode:=True))
                .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseDescription" + intLoopCounter.ToString, "hidResponseDescription" + intLoopCounter.ToString, , , , CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), "0"), String), , , , , , True, , True, EnableHTMLEncode:=True))
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                If lngCheckListItemID <> CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("CheckListItemID"), "0"), Long) Then
                    intSerialCounter += 1
                    lngCheckListItemID = CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("CheckListItemID"), "0"), Long)

                    If intLoopCounter Mod 2 = 0 Then
                        strTRClass = "clsTREven"
                    Else
                        strTRClass = "clsTROdd"
                    End If

                    .Append("<tr class='" + strTRClass + "'>")
                    .Append("<td width='60%'> ")
                    .Append(drChecklistItems.Item("ChecklistItemName").ToString + "</td>")
                    .Append("<td width='40%'> ")
                    'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                    '.Append(CommonFunctions.HTMLControls.DrawTextBox("hidCheclistItemResponse" + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("CheckListItemID"), "0"), String), "hidCheclistItemResponse" + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("CheckListItemID"), "0"), String), , , , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), String) = "0", "0", intLoopCounter.ToString), String), , , , , , True, , True))
                    .Append(CommonFunctions.HTMLControls.DrawTextBox("hidCheclistItemResponse" + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("CheckListItemID"), "0"), String), "hidCheclistItemResponse" + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("CheckListItemID"), "0"), String), , , , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), String) = "0", "0", intLoopCounter.ToString), String), , , , , , True, , True, EnableHTMLEncode:=True))
                    'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                    If CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("SingleSelection"), "False"), Boolean) = True Then
                        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                        '    .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "1", , , , , , True))
                        '    .Append(CommonFunctions.HTMLControls.DrawOptionButton("opt" + lngCheckListItemID.ToString, "opt" + lngCheckListItemID.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), , , "OnClick='opt_OnClick(" + lngCheckListItemID.ToString + ", " + intLoopCounter.ToString + " )' ", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                        'ElseIf CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("MultipleSelection"), "False"), Boolean) = True Then
                        '    .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "2", , , , , , True))
                        '    .Append(CommonFunction.HTMLControls.DrawCheckBox("chk" + intLoopCounter.ToString, "chk" + intLoopCounter.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseID"), "0"), String), , "OnClick=chk_OnClick(" + intLoopCounter.ToString + ")", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                        'ElseIf CBool(CommonFunction.Data.CheckIsDBNull(drChecklistItems("SingleSelectionWithCheckBox"), "False")) = True Then
                        '    .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "3", , , , , , True))
                        '    .Append(CommonFunction.HTMLControls.DrawCheckBox("chk" + intLoopCounter.ToString, "chk" + intLoopCounter.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseID"), "0"), String), , "OnClick=chk_OnClick(" + intLoopCounter.ToString + ")", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                        'End If
                        .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "1", , , , , , True, EnableHTMLEncode:=True))
                        .Append(CommonFunctions.HTMLControls.DrawOptionButton("opt" + lngCheckListItemID.ToString, "opt" + lngCheckListItemID.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), , , "OnClick='opt_OnClick(" + lngCheckListItemID.ToString + ", " + intLoopCounter.ToString + " )' ", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                    ElseIf CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("MultipleSelection"), "False"), Boolean) = True Then
                        .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "2", , , , , , True, EnableHTMLEncode:=True))
                        .Append(CommonFunction.HTMLControls.DrawCheckBox("chk" + intLoopCounter.ToString, "chk" + intLoopCounter.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseID"), "0"), String), , "OnClick=chk_OnClick(" + intLoopCounter.ToString + ")", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                    ElseIf CBool(CommonFunction.Data.CheckIsDBNull(drChecklistItems("SingleSelectionWithCheckBox"), "False")) = True Then
                        .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "3", , , , , , True, EnableHTMLEncode:=True))
                        .Append(CommonFunction.HTMLControls.DrawCheckBox("chk" + intLoopCounter.ToString, "chk" + intLoopCounter.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseID"), "0"), String), , "OnClick=chk_OnClick(" + intLoopCounter.ToString + ")", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                    End If
                    'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                Else

                    If CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("SingleSelection"), "False"), Boolean) = True Then
                        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                        '    .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "1", , , , , , True))
                        '    .Append(CommonFunctions.HTMLControls.DrawOptionButton("opt" + lngCheckListItemID.ToString, "opt" + lngCheckListItemID.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), , , "OnClick='opt_OnClick(" + lngCheckListItemID.ToString + ", " + intLoopCounter.ToString + ")' ", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                        'ElseIf CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("MultipleSelection"), "False"), Boolean) = True Then
                        '    .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "2", , , , , , True))
                        '    .Append(CommonFunction.HTMLControls.DrawCheckBox("chk" + intLoopCounter.ToString, "chk" + intLoopCounter.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseID"), "0"), String), , "OnClick=chk_OnClick(" + intLoopCounter.ToString + ")", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                        'ElseIf CBool(CommonFunction.Data.CheckIsDBNull(drChecklistItems("SingleSelectionWithCheckBox"), "False")) = True Then
                        '    .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "3", , , , , , True))
                        '    .Append(CommonFunction.HTMLControls.DrawCheckBox("chk" + intLoopCounter.ToString, "chk" + intLoopCounter.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseID"), "0"), String), , "OnClick=chk_OnClick(" + intLoopCounter.ToString + ")", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                        'End If
                        .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "1", , , , , , True, EnableHTMLEncode:=True))
                        .Append(CommonFunctions.HTMLControls.DrawOptionButton("opt" + lngCheckListItemID.ToString, "opt" + lngCheckListItemID.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), , , "OnClick='opt_OnClick(" + lngCheckListItemID.ToString + ", " + intLoopCounter.ToString + ")' ", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                    ElseIf CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("MultipleSelection"), "False"), Boolean) = True Then
                        .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "2", , , , , , True, EnableHTMLEncode:=True))
                        .Append(CommonFunction.HTMLControls.DrawCheckBox("chk" + intLoopCounter.ToString, "chk" + intLoopCounter.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseID"), "0"), String), , "OnClick=chk_OnClick(" + intLoopCounter.ToString + ")", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                    ElseIf CBool(CommonFunction.Data.CheckIsDBNull(drChecklistItems("SingleSelectionWithCheckBox"), "False")) = True Then
                        .Append(CommonFunctions.HTMLControls.DrawTextBox("hidResponseType" + intLoopCounter.ToString, "hidResponseType" + intLoopCounter.ToString, , , , "3", , , , , , True, EnableHTMLEncode:=True))
                        .Append(CommonFunction.HTMLControls.DrawCheckBox("chk" + intLoopCounter.ToString, "chk" + intLoopCounter.ToString, , CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("Response"), "0"), Integer) = 0, False, True), Boolean), CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseID"), "0"), String), , "OnClick=chk_OnClick(" + intLoopCounter.ToString + ")", True) + CType(CommonFunction.Data.CheckIsDBNull(drChecklistItems("ResponseDescription"), ""), String))
                    End If
                    'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                End If
                intLoopCounter += 1
            End While
            .Append("</td><tr></table>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''.Append(CommonFunctions.HTMLControls.DrawTextBox("ChecklistResponseCount", "ChecklistResponseCount", , , , intLoopCounter.ToString, , , , , , True, , True))
            .Append(CommonFunctions.HTMLControls.DrawTextBox("ChecklistResponseCount", "ChecklistResponseCount", , , , intLoopCounter.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        End With
        Response.Write(strHtml)
        CommonFunctions.Data.DisposeDataReader(drChecklistItems)
    End Sub
    Private Sub SaveResponses()
        '===============================================================================
        ' Procedure Name  :	SaveResponses
        ' Purpose   			:	Save the responses
        ' Parameters			:	None
        ' Affected params	:	None
        ' Returns               :	same
        ' Dependencies		:	
        ' Description          :	
        ' Author				    :	Padmnabh Anturkar 
        ' Created				:	March, 17  2006
        ' Revisions				:	
        '===============================================================================
        Dim intChecklistResponseCount As Integer = CType(Request.Form.Item("ChecklistResponseCount"), Integer) - 1
        Dim intloopCounter As Integer

        Dim strConnectionString As String = CommonFunction.Application.ConnectionString
        Dim objConn As New System.Data.SqlClient.SqlConnection(strConnectionString)
        objConn.Open()

        ' Instance of a DataAdapter for master and details table
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        ' Dim daChecklistMaster As New System.Data.SqlClient.SqlDataAdapter("Select * From tbl_PV_Project_Checklists", objConn)
        Dim daChecklistMaster As New System.Data.SqlClient.SqlDataAdapter("usp_sel_Col_tbl_PV_Project_Checklists", objConn)
        ' Dim daChecklistDetails As New System.Data.SqlClient.SqlDataAdapter("Select * From tbl_PV_Project_Checklists_Responses", objConn)
        Dim daChecklistDetails As New System.Data.SqlClient.SqlDataAdapter("usp_sel_tbl_PV_Project_Checklists_Responses", objConn)
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query




        'Data set 
        Dim dsChecklists As New DataSet("tbl_PV_Project_Checklists")
        Dim dsChecklistResponses As New DataSet("tbl_PV_Project_Checklists_Responses")

        daChecklistMaster.FillSchema(dsChecklists, SchemaType.Source, "tbl_PV_Project_Checklists")
        daChecklistDetails.FillSchema(dsChecklistResponses, SchemaType.Source, "tbl_PV_Project_Checklists_Responses")

        If m_strMode.ToUpper = "ADDNEW" Then
            Dim lngRevision, lngResponseUniqueID As Long
            Dim tbl_Checklists, tbl_Checklists_Responses As DataTable
            tbl_Checklists = dsChecklists.Tables("tbl_PV_Project_Checklists")
            tbl_Checklists_Responses = dsChecklistResponses.Tables("tbl_PV_Project_Checklists_Responses")

            Dim drCheckLists, drResponses As DataRow
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            ' lngRevision = CType(CommonFunctions.Data.GetDataScalar("SELECT CASE WHEN COUNT(UniqueID) > 0 THEN MAX(Revision) ELSE 0 END FROM tbl_PV_Project_Checklists WHERE Checklistid = " + m_strCheckListID, MyBase.UseSQL), Integer)
            lngRevision = CType(CommonFunctions.Data.GetDataScalar("usp_sel_case_tbl_PV_Project_Checklists " + m_strCheckListID, MyBase.UseSQL), Integer)
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            lngRevision += 1

            drCheckLists = tbl_Checklists.NewRow()
            'Master
            drCheckLists("CheckListID") = m_strCheckListID
            drCheckLists("ProjectID") = Session.Item("intProjectID")
            drCheckLists("ProcessID") = m_strProcessID
            drCheckLists("SDLCID") = m_strSDLCID
            drCheckLists("Title") = m_strChecklistName
            drCheckLists("Revision") = lngRevision
            drCheckLists("CreatedBy") = Session.Item("strUserName")
            drCheckLists("CreatedDate") = Date.Now

            tbl_Checklists.Rows.Add(drCheckLists)

            Dim objCmdBuilder_Master As New System.Data.SqlClient.SqlCommandBuilder(daChecklistMaster)
            daChecklistMaster.Update(dsChecklists.Tables("tbl_PV_Project_Checklists"))

            objCmdBuilder_Master.Dispose()
            objCmdBuilder_Master = Nothing

            For intloopCounter = 1 To intChecklistResponseCount
                drResponses = tbl_Checklists_Responses.NewRow()

                'Detail Columns
                'drResponses("ResponseUniqueID") = 0
                drResponses("CheckList") = m_strCheckListID
                drResponses("CheckListItemGroupName") = CommonFunction.General.CheckIsNothing(Request.Form.Item("hidItemGroupName" + intloopCounter.ToString), "")
                drResponses("ChecklistItemId") = CommonFunction.General.CheckIsNothing(Request.Form.Item("hidChecklistItemId" + intloopCounter.ToString), "0")
                drResponses("ChecklistItemName") = CommonFunction.General.CheckIsNothing(Request.Form.Item("hidChecklistItemName" + intloopCounter.ToString), "")
                drResponses("ResponseID") = CommonFunction.General.CheckIsNothing(Request.Form.Item("hidResponseId" + intloopCounter.ToString), "0")
                drResponses("ResponseDescription") = CommonFunction.General.CheckIsNothing(Request.Form.Item("hidResponseDescription" + intloopCounter.ToString), "")
                drResponses("RevisionNo") = lngRevision

                ' Response
                If CommonFunction.General.CheckIsNothing(Request.Form.Item("hidResponseType" + intloopCounter.ToString), "") <> "" Then
                    Select Case Request.Form.Item("hidResponseType" + intloopCounter.ToString)
                        Case "1"
                            If CommonFunction.General.CheckIsNothing(Request.Form.Item("hidCheclistItemResponse" + Request.Form.Item("hidChecklistItemId" + intloopCounter.ToString)), "0") = intloopCounter.ToString Then
                                drResponses("Response") = "1"
                            Else
                                drResponses("Response") = "0"
                            End If
                        Case "2"
                            If CommonFunction.General.CheckIsNothing(Request.Form.Item("chk" + intloopCounter.ToString), "0") = intloopCounter.ToString Then
                                drResponses("Response") = "1"
                            Else
                                drResponses("Response") = "0"
                            End If
                        Case "3"
                            If CommonFunction.General.CheckIsNothing(Request.Form.Item("chk" + intloopCounter.ToString), "0") = intloopCounter.ToString Then
                                drResponses("Response") = "1"
                            Else
                                drResponses("Response") = "0"
                            End If
                    End Select
                End If

                'Pass that new object into the Add method of the DataTable.Rows collection.
                tbl_Checklists_Responses.Rows.Add(drResponses)
            Next

        ElseIf m_strMode.ToUpper = "EDIT" Then
            'Dim tbl_Checklists_Responses As DataTable
            'Dim drResponses As DataRow

            'tbl_Checklists_Responses = dsChecklistResponses.Tables("tbl_PV_Project_Checklists_Responses")

            'drResponses = tbl_Checklists_Responses.Rows.Find(m_strUniqueID)

            'For intloopCounter = 1 To intChecklistResponseCount

            'Next

            'drResponses.EndEdit()

        End If

        Dim objCmdBuilder_Details As New System.Data.SqlClient.SqlCommandBuilder(daChecklistDetails)
        daChecklistDetails.Update(dsChecklistResponses, "tbl_PV_Project_Checklists_Responses")
        objCmdBuilder_Details.Dispose()
        objCmdBuilder_Details = Nothing

        objConn.Close()
        objConn = Nothing

        Response.Redirect("../PV/PM_Checklist_CommonList.aspx?FromWhere=PM&MasterTagID=3607&SDLCID=" + m_strSDLCID + "&ProcessID=" + m_strProcessID)

    End Sub
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
        ' Created               : Sep 15, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function

#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.

        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

End Class
