Imports CommonFunctions

Public Class PRO_ChecklistTemplate
    Inherits WebPages.Template.WhizTemplate

    Protected Const CONST_MODE_CHECKLIST_ADD As String = "ADD"
    Protected Const CONST_MODE_CHECKLIST_EDIT As String = "EDIT"
    Protected Const CONST_ACTION_SAVE As String = "SAVE"
    Protected Const CUSTOM_OPTIONS_CHECKBOX As String = "C"
    Protected Const CUSTOM_OPTIONS_RADIOBUTTONS As String = "O"

    Protected m_strWindowTitle As String
    Protected m_strMode As String
    Protected m_strMasterTagID As String
    Protected m_strFromWhere As String
    Protected m_strChecklistItemID As String
    Protected m_strChecklistSectionID As String
    Protected m_strChecklistID As String
    Private m_blnAddAccess As Boolean
    Private m_strAction As String
    Private m_strChecklistSectionName As String


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
    ' Created				:	Mar 11 2004
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
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccess As WebPage.Templates.AccessRights

        m_strMode = Request.QueryString("Mode") + ""
        m_strAction = Request.QueryString("Action") + ""
        m_strMasterTagID = Request.QueryString("MasterTagID") + ""
        m_strFromWhere = Request.QueryString("FromWhere") + ""
        m_strChecklistSectionID = Request.QueryString("CheckListSectionID") + ""
        m_strChecklistID = Request.QueryString("ChecklistID") + ""
        'If m_strChecklistID = "" Then m_strChecklistID = "0"
        If MyBase.GetFormValue("txtChecklistItemID") <> "" Then
            m_strChecklistItemID = MyBase.GetFormValue("txtChecklistItemID") + ""
        Else
            m_strChecklistItemID = Request.QueryString("CheckListItemID") + ""
        End If
        If m_strChecklistItemID = "" Then
            m_strMode = CONST_MODE_CHECKLIST_ADD
        Else
            m_strMode = CONST_MODE_CHECKLIST_EDIT
        End If

        ''TODO get from the query string
        'm_strChecklistSectionID = "43"
        'm_strChecklistID = "11"
        'm_strChecklistItemID = "184"
        'm_strMasterTagID = "1044"
        'm_strFromWhere = "PRO"

        'get the access settings for the user
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, , m_strFromWhere)
        objGlobal = MyBase.GlobalObject
        objAccess = New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add
        'm_blnDelAccess = objAccess.Delete
        'blnEditAccess = objAccess.Edit
        objAccess = Nothing

        Select Case m_strMode.ToUpper
            Case CONST_MODE_CHECKLIST_ADD, CONST_MODE_CHECKLIST_EDIT

                If m_strAction <> "" Then
                    Call performAction()
                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                If m_blnAddAccess = True Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
                End If
                arrMenu.Add(MyBase.GetResourceString("MENU_BACK")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP")) : arrClientSideFunctions.Add("Back_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('659')")

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

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                MyBase.InitializeResources("AppResources.PRO_ChecklistTemplate", "AppResources")

                strSQL = "usp_Sel_tbl_PRS_ChecklistSections_Draft " + m_strChecklistSectionID.Trim
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDR.Read Then
                    m_strChecklistSectionName = Data.CheckIsDBNull(objDR("ChecklistSectionName"), "").ToString + ""
                End If
                Data.DisposeDataReader(objDR)

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_CHECKLIST"), MyBase.GetResourceString("CAP_SECTION") + " : " + m_strChecklistSectionName.Trim)
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_CHECKLIST") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'write client side script to populate array with checklist names
                Dim i As Integer = 0
                General.WriteHTML("<Script language=javascript>")
                General.WriteHTML("var strChecklistItemsArray = new Array();")
                strSQL = "usp_Sel_tbl_PRS_ChecklistItems_Draft NULL," + m_strChecklistSectionID.Trim + "," + m_strChecklistID.Trim
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                While objDR.Read
                    If m_strChecklistItemID.Trim <> objDR("ChecklistItemID").ToString Then
                        General.WriteHTML("strChecklistItemsArray[" + i.ToString + "]='" + objDR("ChecklistItem").ToString.ToUpper + "';")
                        i += 1
                    End If
                End While
                Data.DisposeDataReader(objDR)
                General.WriteHTML("</Script>")

                Call plotControlsForChecklistDetails()

                'draw lower menu
                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)

        End Select
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PRO_ChecklistTemplate", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_CHECKLIST")
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotControlsForChecklistDetails
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page for the checklist template.
    ' Description			:	procedure plots the controls for the checklist template mode of the 
    '                           page. Here two tables are plotted which are dynamically made visible 
    '                           at client side.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 11 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotControlsForChecklistDetails()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strControlStyle As String
        Dim objLink As WebPage.UI.cDynamicLink
        Dim intRowCount As Integer
        Dim blnIsHidden As Boolean
        Dim blnIsChecked As Boolean
        '************************************
        Dim strOrderNumber As String = ""
        Dim strCheckListItem As String = ""
        Dim blnTemp As Boolean = False
        Dim blnAcceptComments As Boolean = False
        Dim blnUseStandardResponseFormat As Boolean = False
        Dim blnUseCustomResponse As Boolean = False
        Dim blnSingleSelection As Boolean = False
        Dim blnMultipleSelection As Boolean = False
        Dim blnIsCommentMandatory As Boolean = False
        Dim blnIsExpectedResponse As Boolean = False
        Dim strOption As String = ""
        Dim blnShowOption As Boolean = False
        Dim strStandardResponseID As String = ""
        Dim strResponseID As String = ""
        Dim strResponseCaption As String = ""
        Dim blnIsDisabled As Boolean = False
        Dim intCustomResponseID As Integer = 0
        Dim strCustomResponseFormat As String = ""
        '************************************

        'get the details of the checklist item
        If MyBase.GetFormValue("txtChecklistItemID") <> "" Then
            'get the details from the page controls as page is posted back
            strCheckListItem = MyBase.GetFormValue("txtChecklistItem") + ""
            strOrderNumber = MyBase.GetFormValue("txtOrderNumber") + ""
            If MyBase.GetFormValue("optUseStandardResponseFormat") = "1" Then
                blnUseStandardResponseFormat = True
            End If
            strCustomResponseFormat = MyBase.GetFormValue("optCustomResponseFormat")

            If MyBase.GetFormValue("chkAcceptComments") = "1" Then
                blnAcceptComments = True
            End If

        ElseIf m_strChecklistItemID <> "" Then
            'get the details from the database
            strSQL = "usp_Sel_tbl_PRS_ChecklistItems_Draft " + m_strChecklistItemID
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                m_strChecklistItemID = Data.CheckIsDBNull(objDr("ChecklistItemID"), "").ToString + ""
                strCheckListItem = Data.CheckIsDBNull(objDr("ChecklistItem"), "").ToString + ""
                strOrderNumber = Data.CheckIsDBNull(objDr("OrderNumber"), "").ToString + ""
                blnUseStandardResponseFormat = CType(Data.CheckIsDBNull(objDr("UseStandardResponseFormat"), "0"), Boolean)
                strCustomResponseFormat = Data.CheckIsDBNull(objDr("CustomResponseFormat"), "").ToString + ""
                blnAcceptComments = CType(Data.CheckIsDBNull(objDr("AcceptComments"), "0"), Boolean)
            End If
            Data.DisposeDataReader(objDr)

        Else
            'set the default values
            strOrderNumber = "1"
            strSQL = "usp_Sel_tbl_PRS_ChecklistItems_Draft_GetNextOrderNumber " + m_strChecklistSectionID.Trim
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                strOrderNumber = Data.CheckIsDBNull(objDr("OrderNumber"), "").ToString + ""
            End If
            Data.DisposeDataReader(objDr)

            blnUseStandardResponseFormat = True
            strCustomResponseFormat = CUSTOM_OPTIONS_RADIOBUTTONS
            blnAcceptComments = True

        End If
        blnTemp = blnAcceptComments

        objLink = New WebPage.UI.cDynamicLink
        objLink.ReturnHTML = True
        'plot the checklist item and order number textboxes
        General.WriteHTML("<Div id=DivList' width=100% height=90% style='overflow: none;'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 cellspacing=0>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'display checklist item
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='right' valign='top'>" + MyBase.GetResourceString("CAP_CHECKLIST_ITEM") + "</TD>")
        General.WriteHTML("<TD align='left'>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ' General.WriteHTML(HTMLControls.DrawTextBox("txtChecklistItemID", "txtChecklistItemID", , , , m_strChecklistItemID.Trim, , , , , , True, , True))
        'General.WriteHTML(HTMLControls.DrawTextArea("txtChecklistItem", "txtChecklistItem", , , , "frm_PRO_ChecklistTemplate", , , 300, 80, , strCheckListItem.Trim, , , , , , , , True, True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtChecklistItemID", "txtChecklistItemID", , , , m_strChecklistItemID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextArea("txtChecklistItem", "txtChecklistItem", , , , "frm_PRO_ChecklistTemplate", , , 300, 80, , strCheckListItem.Trim, , , , , , , , True, True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")
        'display order number
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_ORDER") + "</TD>")
        General.WriteHTML("<TD align='left'>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''General.WriteHTML(HTMLControls.DrawTextBox("txtOrderNumber", "txtOrderNumber", , 60, 3, strOrderNumber.ToString, "right", , , , , , , True, True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtOrderNumber", "txtOrderNumber", , 60, 3, strOrderNumber.ToString, "right", , , , , , , True, True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        'display configure section
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 cellspacing=0>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class='clsTRSectionHeader'>")
        General.WriteHTML("<TD align='left' colspan=2 >" + MyBase.GetResourceString("CAP_CONFIGURE") + "</TD>")
        General.WriteHTML("</TR>")

        'display accept comments checkbox
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left' colspan=2>")
        General.WriteHTML("&nbsp;&nbsp;" + HTMLControls.DrawCheckBox("chkAcceptComments", "chkAcceptComments", , blnAcceptComments, "1", , "onclick='javascript:chkAcceptComments_OnClick()'", True))
        General.WriteHTML("&nbsp;&nbsp;" + MyBase.GetResourceString("CAP_ACCEPT_COMMENTS"))
        General.WriteHTML("</TD>")

        'display use standard response
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left' width=50% >")
        General.WriteHTML(HTMLControls.DrawOptionButton("optUseStandardResponseFormat", "optStandardFormat", , blnUseStandardResponseFormat, "1", , "onclick='javascript:optStandardFormat_OnClick()'", True))
        General.WriteHTML("&nbsp;&nbsp;" + MyBase.GetResourceString("CAP_USE_STANDARD_RESPONSE"))
        General.WriteHTML("</TD>")
        'display use custom response
        General.WriteHTML("<TD align='left' width=50% >")
        General.WriteHTML(HTMLControls.DrawOptionButton("optUseStandardResponseFormat", "optCustomFormat", , Not blnUseStandardResponseFormat, "0", , "onclick='javascript:optCustomFormat_OnClick()'", True))
        General.WriteHTML("&nbsp;&nbsp;" + MyBase.GetResourceString("CAP_CUSTOMIZE_RESPONSE"))
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("</div>")
        General.WriteHTML("<BR>")

        'based on this flag some of the controls are made visile else hidden
        If blnUseStandardResponseFormat = True Then
            strControlStyle = "style='Display: block;'"
        Else
            strControlStyle = "style='Display: none;'"
        End If

        'display grid with controls for input values
        General.WriteHTML("<Div id='PageDiv' width=100% height=90% style='overflow: auto;'>")
        'plot the grid with controls to take input,
        'depending on the response setting selected, grid will be displayed.
        '********************************************************************************************************
        'plot grid for standard response setting input
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table id='tblStandardResponseFormat' name='tblStandardResponseFormat' class='clsTable' cellpadding=0 cellspacing=0 width=99.9% " + strControlStyle.Trim + " >")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_SHOW") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_OPTION") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_EXPECTED_RESPONSE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_COMMENT_MANDATORY") + "</TD>")
        General.WriteHTML("</TR>")

        intRowCount = 0
        strSQL = "usp_Sel_tbl_PRS_ChecklistItems_StandardResponses_Draft "
        If m_strChecklistItemID <> "" Then
            strSQL += m_strChecklistItemID
        End If
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDr.Read

            strStandardResponseID = Data.CheckIsDBNull(objDr("ID"), "").ToString + ""
            strResponseCaption = Data.CheckIsDBNull(objDr("Caption"), "").ToString + ""
            strOrderNumber = Data.CheckIsDBNull(objDr("SrNumber"), "0").ToString + ""
            blnShowOption = True
            blnIsExpectedResponse = False
            blnIsCommentMandatory = False
            If m_strChecklistItemID <> "" Then
                strResponseID = Data.CheckIsDBNull(objDr("ResponseID"), "").ToString + ""
                If strResponseID = "" Then
                    blnShowOption = False
                End If

                blnAcceptComments = CType(Data.CheckIsDBNull(objDr("AcceptComments"), "0"), Boolean)
                blnIsExpectedResponse = CType(Data.CheckIsDBNull(objDr("IsExpectedResponse"), "0"), Boolean)
                blnIsCommentMandatory = CType(Data.CheckIsDBNull(objDr("IsCommentMandatory"), "0"), Boolean)
            Else
                ' "Yes" will be the Expected Response by default.
                If strStandardResponseID = "1" Then
                    blnIsExpectedResponse = True
                End If
                ' Comments will be mandatory for the "No" option by default.
                If strStandardResponseID = "2" Then
                    blnIsCommentMandatory = True
                End If
            End If

            If intRowCount Mod 2 = 0 Then
                General.WriteHTML("<TR class='clsTROdd'>")
            Else
                General.WriteHTML("<TR class='clsTREven'>")
            End If

            'show option checkbox
            General.WriteHTML("<TD align='center'>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'General.WriteHTML(HTMLControls.DrawTextBox("txtStandardResponseID", "txtStandardResponseID", , , , strStandardResponseID.Trim, , , , , , True, , True))
            'General.WriteHTML(HTMLControls.DrawTextBox("txtStdResponseID" + strStandardResponseID, "txtStdResponseID", , , , strResponseID.Trim, , , , , , True, , True))
            'General.WriteHTML(HTMLControls.DrawTextBox("txtStdOrderNumber" + strStandardResponseID, "txtStdOrderNumber", , , , strOrderNumber.Trim, , , , , , True, , True))
            'General.WriteHTML(HTMLControls.DrawCheckBox("chkShowOption" + strStandardResponseID, "chkShowOption", , blnShowOption, strStandardResponseID.Trim, , "onclick='javascript:chkShowOption_OnClick(" + strStandardResponseID.Trim + ")'", True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtStandardResponseID", "txtStandardResponseID", , , , strStandardResponseID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtStdResponseID" + strStandardResponseID, "txtStdResponseID", , , , strResponseID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtStdOrderNumber" + strStandardResponseID, "txtStdOrderNumber", , , , strOrderNumber.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawCheckBox("chkShowOption" + strStandardResponseID, "chkShowOption", , blnShowOption, strStandardResponseID.Trim, , "onclick='javascript:chkShowOption_OnClick(" + strStandardResponseID.Trim + ")'", True))

            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align='left'>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''General.WriteHTML(HTMLControls.DrawTextBox("txtStdResponseCaption" + strStandardResponseID, "txtStdResponseCaption", , 300, 50, strResponseCaption, , , , True, , , , True, True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtStdResponseCaption" + strStandardResponseID, "txtStdResponseCaption", , 300, 50, strResponseCaption, , , , True, , , , True, True, EnableHTMLEncode:=True))
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align='center'>")
            blnIsDisabled = False
            blnIsChecked = False
            If blnShowOption = True Then
                If blnIsExpectedResponse = True Then
                    blnIsChecked = True
                End If
            Else
                blnIsDisabled = True
            End If
            General.WriteHTML(HTMLControls.DrawOptionButton("optStdIsExpectedResponse", "optStdIsExpectedResponse" + strStandardResponseID, , blnIsChecked, strStandardResponseID, blnIsDisabled, , True))
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align='center'>")
            blnIsDisabled = False
            blnIsChecked = False
            If blnShowOption = True And blnAcceptComments = True Then
                If blnIsCommentMandatory = True Then
                    blnIsChecked = True
                End If
            Else
                blnIsDisabled = True
            End If
            General.WriteHTML(HTMLControls.DrawCheckBox("chkStdIsCommentMandatory" + strStandardResponseID, "chkStdIsCommentMandatory", , blnIsChecked, strStandardResponseID.Trim, blnIsDisabled, , True))
            General.WriteHTML("</TD>")

            General.WriteHTML("</TR>")
            intRowCount += 1
        End While
        Data.DisposeDataReader(objDr)

        General.WriteHTML("</Table>")
        '********************************************************************************************************

        If blnUseStandardResponseFormat = False Then
            strControlStyle = "style='Display: block;'"
        Else
            strControlStyle = "style='Display: none;'"
        End If

        '********************************************************************************************************
        'this is template table use to create row for the custom setting table dynamically
        'clone of the trTemplate is created dynamically and appended dynamically.
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table id='tblTemplate' name='tblTemplate' class='clsTable' width=99.9% cellpadding=0 cellspacing=0 style='Display: none; visibility: hidden;' >")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class='clsTREven' id='trTemplate'>")

        General.WriteHTML("<TD align='left'>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'General.WriteHTML(HTMLControls.DrawTextBox("txtCustomResponseID", "txtCustomResponseID", , , , , , , , , , True, , True))
        'General.WriteHTML(HTMLControls.DrawTextBox("txtCusResponseID", "txtCusResponseID", , , , , , , , , , True, , True))
        'General.WriteHTML(HTMLControls.DrawTextBox("txtCusResponseCaption", "txtCusResponseCaption", , 200, 50, , , , , , , , , True, True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtCustomResponseID", "txtCustomResponseID", , , , , , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtCusResponseID", "txtCusResponseID", , , , , , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtCusResponseCaption", "txtCusResponseCaption", , 200, 50, , , , , , , , , True, True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        General.WriteHTML("</TD>")

        General.WriteHTML("<TD align='center'>")
        blnIsHidden = False
        If strCustomResponseFormat <> CUSTOM_OPTIONS_CHECKBOX Then
            blnIsHidden = True
        End If
        General.WriteHTML(HTMLControls.DrawCheckBox("chkCusIsExpectedResponse", "chkCusIsExpectedResponse", , , , , , True, , , , blnIsHidden))
        blnIsHidden = False
        If strCustomResponseFormat <> CUSTOM_OPTIONS_RADIOBUTTONS Then
            blnIsHidden = True
        End If
        General.WriteHTML(HTMLControls.DrawOptionButton("optCusIsExpectedResponse", "optCusIsExpectedResponse", , , , , , True, blnIsHidden))
        General.WriteHTML("</TD>")

        General.WriteHTML("<TD align='center'>")
        blnIsDisabled = False
        If blnTemp = False Then
            blnIsDisabled = True
        End If
        General.WriteHTML(HTMLControls.DrawCheckBox("chkCusIsCommentMandatory", "chkCusIsCommentMandatory", , , , blnIsDisabled, , True))
        General.WriteHTML("</TD>")

        General.WriteHTML("<TD align='left'>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''General.WriteHTML(HTMLControls.DrawTextBox("txtCusOrderNumber", "txtCusOrderNumber", , 30, 3, "&lt;CTR&gt;", "right", , , , , , , True, True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtCusOrderNumber", "txtCusOrderNumber", , 30, 3, "&lt;CTR&gt;", "right", , , , , , , True, True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        General.WriteHTML("</TD>")

        General.WriteHTML("<TD align='left'>")
        objLink.LinkStyle = ""
        objLink.LinkName = MyBase.GetResourceString("LINK_REMOVE_OPTION") + ""
        objLink.Tooltip = ""
        objLink.OtherProperties = "id='lnkDeleteOption'"
        objLink.FunctionName = "RemoveOption_OnClick(&lt;CTR&gt;)"
        General.WriteHTML(objLink.GetDynamicLink())
        General.WriteHTML("</TD>")

        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''General.WriteHTML(HTMLControls.DrawTextBox("txtDeletedCustomResponseOptions", "txtDeletedCustomResponseOptions", , , , , , , , , , True, , True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtDeletedCustomResponseOptions", "txtDeletedCustomResponseOptions", , , , , , , , , , True, , True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '********************************************************************************************************
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table id='tblCustomResponseFormat' name='tblCustomResponseFormat' class='clsTable' width=99.9% cellpadding=0 cellspacing=0  " + strControlStyle.Trim + ">")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class='clsTREven' >")
        If strCustomResponseFormat = CUSTOM_OPTIONS_RADIOBUTTONS Then
            blnSingleSelection = True
        Else
            blnSingleSelection = False
        End If
        'display single selection option button
        General.WriteHTML("<TD align='left' width=50% >")
        General.WriteHTML(HTMLControls.DrawOptionButton("optCustomResponseFormat", "optOptionButtons", , blnSingleSelection, CUSTOM_OPTIONS_RADIOBUTTONS, , "onclick='javascript:optOptionButtons_OnClick()'", True))
        General.WriteHTML("&nbsp;&nbsp;" + MyBase.GetResourceString("CAP_SINGLE_SELECTION"))
        General.WriteHTML("</TD>")
        'display multiple selection option button
        General.WriteHTML("<TD align='left' width=50% >")
        General.WriteHTML(HTMLControls.DrawOptionButton("optCustomResponseFormat", "optCheckBoxes", , Not blnSingleSelection, CUSTOM_OPTIONS_CHECKBOX, , "onclick='javascript:optCheckBoxes_OnClick()'", True))
        General.WriteHTML("&nbsp;&nbsp;" + MyBase.GetResourceString("CAP_MULTIPLE_SELECTION"))
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        'display add new option link only if custom response is selected, else make it hidden
        objLink.ReturnHTML = True
        objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
        objLink.LinkName = MyBase.GetResourceString("LINK_ADD_NEW_OPTION") + ""
        objLink.FunctionName = "AddNewOption_OnClick()"
        objLink.Tooltip = MyBase.GetResourceString("LINK_ADD_NEW_OPTION_TOOLTIP") + ""
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' colspan=2 > |" + objLink.GetDynamicLink() + " |</TD>")
        General.WriteHTML("</TR>")

        'plot the grid for the custom settings controls
        General.WriteHTML("<TR><TD colspan=2><BR>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table id='tblCustomOptions' name='tblCustomOptions' class='clsTable' cellpadding=0 cellspacing=0 width=99.9% >")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_OPTION") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_EXPECTED_RESPONSE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_COMMENT_MANDATORY") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_ORDER") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_REMOVE_OPTION") + "</TD>")
        General.WriteHTML("</TR>")

        intRowCount = 0
        intCustomResponseID = 1
        If m_strChecklistItemID <> "" And blnUseStandardResponseFormat = False Then

            strSQL = "usp_Sel_tbl_PRS_ChecklistItems_Responses_Draft NULL," + m_strChecklistItemID.Trim + ",'StandardResponseID IS NULL'"
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            While objDr.Read

                strResponseID = Data.CheckIsDBNull(objDr("ResponseID"), "").ToString + ""
                strResponseCaption = Data.CheckIsDBNull(objDr("ResponseCaption"), "").ToString + ""
                blnAcceptComments = CType(Data.CheckIsDBNull(objDr("AcceptComments"), "0"), Boolean)
                blnIsExpectedResponse = CType(Data.CheckIsDBNull(objDr("IsExpectedResponse"), "0"), Boolean)
                blnIsCommentMandatory = CType(Data.CheckIsDBNull(objDr("IsCommentMandatory"), "0"), Boolean)
                strOrderNumber = Data.CheckIsDBNull(objDr("OrderNumber"), "0").ToString + ""

                If intRowCount Mod 2 = 0 Then
                    General.WriteHTML("<TR class='clsTROdd' id='trOption" + intCustomResponseID.ToString + "' >")
                Else
                    General.WriteHTML("<TR class='clsTREven' id='trOption" + intCustomResponseID.ToString + "' >")
                End If

                General.WriteHTML("<TD align='left'>")
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                'General.WriteHTML(HTMLControls.DrawTextBox("txtCustomResponseID", "txtCustomResponseID", , , , intCustomResponseID.ToString, , , , , , True, , True))
                'General.WriteHTML(HTMLControls.DrawTextBox("txtCusResponseID" + intCustomResponseID.ToString, "txtCusResponseID", , , , strResponseID.Trim, , , , , , True, , True))
                'General.WriteHTML(HTMLControls.DrawTextBox("txtCusResponseCaption" + intCustomResponseID.ToString, "txtCusResponseCaption", , 200, 50, strResponseCaption, , , , , , , , True, True))
                General.WriteHTML(HTMLControls.DrawTextBox("txtCustomResponseID", "txtCustomResponseID", , , , intCustomResponseID.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                General.WriteHTML(HTMLControls.DrawTextBox("txtCusResponseID" + intCustomResponseID.ToString, "txtCusResponseID", , , , strResponseID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
                General.WriteHTML(HTMLControls.DrawTextBox("txtCusResponseCaption" + intCustomResponseID.ToString, "txtCusResponseCaption", , 200, 50, strResponseCaption, , , , , , , , True, True, EnableHTMLEncode:=True))
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                General.WriteHTML("</TD>")

                General.WriteHTML("<TD align='center'>")
                blnIsHidden = False
                If strCustomResponseFormat <> CUSTOM_OPTIONS_CHECKBOX Then
                    blnIsHidden = True
                End If
                General.WriteHTML(HTMLControls.DrawCheckBox("chkCusIsExpectedResponse" + intCustomResponseID.ToString, "chkCusIsExpectedResponse", , blnIsExpectedResponse, intCustomResponseID.ToString, , , True, , , , blnIsHidden))
                blnIsHidden = False
                If strCustomResponseFormat <> CUSTOM_OPTIONS_RADIOBUTTONS Then
                    blnIsHidden = True
                End If
                General.WriteHTML(HTMLControls.DrawOptionButton("optCusIsExpectedResponse", "optCusIsExpectedResponse" + intCustomResponseID.ToString, , blnIsExpectedResponse, intCustomResponseID.ToString, , , True, blnIsHidden))
                General.WriteHTML("</TD>")

                General.WriteHTML("<TD align='center'>")
                blnIsDisabled = False
                blnIsChecked = False
                If blnAcceptComments = True Then
                    If blnIsCommentMandatory = True Then
                        blnIsChecked = True
                    End If
                Else
                    blnIsDisabled = True
                End If
                General.WriteHTML(HTMLControls.DrawCheckBox("chkCusIsCommentMandatory" + intCustomResponseID.ToString, "chkCusIsCommentMandatory", , blnIsChecked, intCustomResponseID.ToString, blnIsDisabled, , True))
                General.WriteHTML("</TD>")

                General.WriteHTML("<TD align='left'>")
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                ''General.WriteHTML(HTMLControls.DrawTextBox("txtCusOrderNumber" + intCustomResponseID.ToString, "txtCusOrderNumber", , 30, 3, strOrderNumber.ToString, "right", , , , , , , True, True))
                General.WriteHTML(HTMLControls.DrawTextBox("txtCusOrderNumber" + intCustomResponseID.ToString, "txtCusOrderNumber", , 30, 3, strOrderNumber.ToString, "right", , , , , , , True, True, EnableHTMLEncode:=True))
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                General.WriteHTML("</TD>")

                General.WriteHTML("<TD align='left'>")
                objLink.LinkStyle = ""
                objLink.LinkName = MyBase.GetResourceString("LINK_REMOVE_OPTION") + ""
                objLink.Tooltip = MyBase.GetResourceString("LINK_REMOVE_OPTION") + ""
                objLink.FunctionName = "RemoveOption_OnClick(" + intCustomResponseID.ToString + ")"
                General.WriteHTML(objLink.GetDynamicLink())
                General.WriteHTML("</TD>")

                General.WriteHTML("</TR>")
                intCustomResponseID += 1
                intRowCount += 1
            End While
            Data.DisposeDataReader(objDr)
        End If
        objLink = Nothing
        General.WriteHTML("</Table>")
        General.WriteHTML("</TD></TR>")
        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")
        '********************************************************************************************************

        'write client side script to declare and initialize variables
        General.WriteHTML("<Script language=javascript>")
        General.WriteHTML("var intCustomResponseID=" + intCustomResponseID.ToString + ";")
        General.WriteHTML("var intCustomResponseCount=intCustomResponseID;")
        General.WriteHTML("</Script>")

    End Sub

    '=====================================================================
    ' Procedure Name		:	performAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data for the checklist item.
    ' Description			:	
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 16 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performAction()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim arrTemp() As String
        Dim strIDs As String
        Dim blnAcceptComments As Boolean
        Dim blnUseStandardResponseFormat As Boolean
        Dim strCustomResponseFormat As String
        Dim strStandardResponseID As String
        Dim blnShowOption As Boolean
        Dim strResponseID As String
        Dim strResponseCaption As String
        Dim blnIsExpectedResponse As Boolean
        Dim blnIsCommentMandatory As Boolean
        Dim strOrderNumber As String
        Dim strCustomResponseID As String

        ' Build Query to insert/update the checklist item record.
        strSQL = "Exec usp_Ins_tbl_PRS_ChecklistItems_Draft "

        ' The Checklist Item ID.
        If m_strChecklistItemID <> "" Then strSQL += m_strChecklistItemID.Trim Else strSQL += "NULL"

        ' Checklist Item.
        If MyBase.GetFormValue("txtChecklistItem") <> "" Then
            strSQL += ", '" + General.BuildQueryString(MyBase.GetFormValue("txtChecklistItem")) + "'"
        Else
            strSQL += ", NULL"
        End If

        ' Checklist ID
        If m_strChecklistID <> "" Then
            strSQL += ", " + m_strChecklistID
        Else
            strSQL += ", NULL"
        End If

        ' Checklist Section ID.
        If m_strChecklistSectionID <> "" Then strSQL += ", " + m_strChecklistSectionID Else strSQL += ", NULL"

        ' Order Number.
        If MyBase.GetFormValue("txtOrderNumber") <> "" Then
            strSQL += ", " + MyBase.FixString(MyBase.GetFormValue("txtOrderNumber"), 3, True, True)
        Else
            strSQL += ", NULL"
        End If
        ' Accept Comments?
        If MyBase.GetFormValue("chkAcceptComments") = "1" Then
            strSQL += ", 1"
            blnAcceptComments = True
        Else
            strSQL += ", 0"
        End If

        blnUseStandardResponseFormat = True
        strCustomResponseFormat = CUSTOM_OPTIONS_RADIOBUTTONS

        ' Use Standard response format.
        If MyBase.GetFormValue("optUseStandardResponseFormat") = "0" Then
            strSQL += ", 0 "
            blnUseStandardResponseFormat = False
        Else
            strSQL += ", 1 "
        End If
        ' Custom response format.
        If blnUseStandardResponseFormat = False And MyBase.GetFormValue("optCustomResponseFormat") = CUSTOM_OPTIONS_CHECKBOX Then
            strSQL += ", '" + CUSTOM_OPTIONS_CHECKBOX + "' "
            strCustomResponseFormat = CUSTOM_OPTIONS_CHECKBOX
        Else
            strSQL += ", 'O' "
        End If

        'Created By (for audit trail).				
        strSQL += ", '" + General.BuildQueryString(Session("strUserName").ToString) + "'"

        ' Insert the checklist item, and get the checklist item ID.	
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            m_strChecklistItemID = Data.CheckIsDBNull(objDr("ChecklistItemID"), "").ToString() + ""
        End If
        Data.DisposeDataReader(objDr)


        ' STORE DETAILS OF THE OPTIONS.
        '------------------------------
        ' Store standard options.
        If blnUseStandardResponseFormat = True Then

            strIDs = MyBase.GetFormValue("txtStandardResponseID") + ""
            If strIDs <> "" Then
                arrTemp = Split(strIDs, ",")
                Dim i As Integer
                For i = 0 To arrTemp.Length - 1
                    If arrTemp(i) <> "" Then
                        strStandardResponseID = arrTemp(i).Trim

                        ' Check if the option must be shown or no.
                        If MyBase.GetFormValue("chkShowOption" + strStandardResponseID) <> "" Then
                            blnShowOption = True
                        Else
                            blnShowOption = False
                        End If

                        strResponseID = MyBase.GetFormValue("txtStdResponseID" + strStandardResponseID) + ""

                        ' If the option must be shown, then...					
                        If blnShowOption = True Then

                            ' GET THE OPTION ATTRIBUTES INTO VARIABLES.
                            '------------------------------------------
                            strResponseCaption = MyBase.GetFormValue("txtStdResponseCaption" + strStandardResponseID)
                            If MyBase.GetFormValue("optStdIsExpectedResponse") = strStandardResponseID Then
                                blnIsExpectedResponse = True
                            Else
                                blnIsExpectedResponse = False
                            End If

                            If MyBase.GetFormValue("chkStdIsCommentMandatory" + strStandardResponseID) = strStandardResponseID Then
                                blnIsCommentMandatory = True
                            Else
                                blnIsCommentMandatory = False
                            End If
                            strOrderNumber = MyBase.GetFormValue("txtStdOrderNumber" + strStandardResponseID).ToString + ""

                            ' BUILD QUERY TO INSERT/UPDATE THE STANDARD OPTION.
                            '--------------------------------------------------				
                            strSQL = "Exec usp_Ins_tbl_PRS_ChecklistItems_Responses_Draft "
                            If strResponseID = "" Then strSQL += "NULL" Else strSQL += strResponseID

                            strSQL += ", " + m_strChecklistID
                            strSQL += ", " + m_strChecklistSectionID
                            strSQL += ", " + m_strChecklistItemID
                            strSQL += ", " + strStandardResponseID
                            'The response caption.
                            If strResponseCaption <> "" Then
                                strSQL += ", '" + General.BuildQueryString(strResponseCaption) + "'"
                            Else
                                strSQL += ", NULL"
                            End If
                            ' Is Expected Response?						
                            If blnIsExpectedResponse = True Then strSQL += ", 1" Else strSQL += ", 0"
                            ' Accept Comments?						
                            If blnAcceptComments = True Then strSQL += ", 1" Else strSQL += ", 0"
                            ' Is Comment Mandatory?
                            If blnIsCommentMandatory = True Then strSQL += ", 1" Else strSQL += ", 0"
                            ' Order Number of response option.
                            If strOrderNumber <> "" Then strSQL += ", " + strOrderNumber.Trim Else strSQL += ", NULL"
                            ' Created By (for audit trail).				
                            strSQL += ", '" + General.BuildQueryString(Session("strUserName").ToString) + "'"

                            Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                        Else
                            ' Else, if the option must NOT be shown, then...					
                            ' If the option was saved previously (i.e. if the checklist item is being edited), then...
                            If strResponseID <> "" Then
                                strSQL = "usp_Del_tbl_PRS_ChecklistItems_Responses_Draft " + strResponseID.Trim
                                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                            End If
                        End If
                    End If
                Next
                arrTemp = Nothing
            End If
        Else

            strIDs = MyBase.GetFormValue("txtCustomResponseID") + ""
            If strIDs <> "" Then
                arrTemp = Split(strIDs, ",")

                Dim j As Integer
                For j = 0 To arrTemp.Length - 1

                    If arrTemp(j) <> "" Then

                        strCustomResponseID = arrTemp(j).Trim

                        ' GET THE OPTION ATTRIBUTES INTO VARIABLES.
                        '------------------------------------------
                        ' PK value of the previously saved record.
                        strResponseID = MyBase.GetFormValue("txtCusResponseID" + strCustomResponseID)

                        'The response caption.
                        strResponseCaption = MyBase.GetFormValue("txtCusResponseCaption" + strCustomResponseID)
                        'Is Expected Response?
                        blnIsExpectedResponse = False
                        ' For checkbox options...
                        If strCustomResponseFormat = CUSTOM_OPTIONS_CHECKBOX Then

                            ' Check in the form control "chkCusIsExpectedResponse".
                            If MyBase.GetFormValue("chkCusIsExpectedResponse" + strCustomResponseID) = strCustomResponseID Then
                                blnIsExpectedResponse = True
                            End If
                            ' For radio options...
                        Else
                            ' Check in the form control "optCusIsExpectedResponse".
                            If MyBase.GetFormValue("optCusIsExpectedResponse") = strCustomResponseID Then
                                blnIsExpectedResponse = True
                            End If
                        End If

                        ' Is Comment mandatory?
                        If MyBase.GetFormValue("chkCusIsCommentMandatory" + strCustomResponseID) = strCustomResponseID Then
                            blnIsCommentMandatory = True
                        Else
                            blnIsCommentMandatory = False
                        End If

                        ' Order Number.				
                        strOrderNumber = MyBase.GetFormValue("txtCusOrderNumber" + strCustomResponseID).ToString + ""

                        ' BUILD QUERY TO INSERT/UPDATE CUSTOM RESPONSE OPTION.
                        '-----------------------------------------------------
                        strSQL = "Exec usp_Ins_tbl_PRS_ChecklistItems_Responses_Draft "
                        If strResponseID = "" Then
                            strSQL += "NULL"
                        Else
                            strSQL += strResponseID
                        End If
                        strSQL += ", " + m_strChecklistID
                        strSQL += ", " + m_strChecklistSectionID
                        strSQL += ", " + m_strChecklistItemID
                        ' Standard Response ID will be NULL.
                        strSQL += ", NULL"
                        ' Response Caption.
                        If strResponseCaption <> "" Then
                            strSQL += ", '" + General.BuildQueryString(strResponseCaption) + "'"
                        Else
                            strSQL += ", NULL"
                        End If
                        ' Is Expected Response?
                        If blnIsExpectedResponse = True Then strSQL += ", 1" Else strSQL += ", 0"
                        ' Accept Comments?
                        If blnAcceptComments = True Then strSQL += ", 1" Else strSQL += ", 0"
                        ' Is Comment Mandatory.
                        If blnIsCommentMandatory = True Then strSQL += ", 1" Else strSQL += ", 0"
                        ' Order Number.
                        If strOrderNumber <> "" Then strSQL += ", " + strOrderNumber.Trim Else strSQL += ", NULL"
                        ' Created By (for audit trail).				
                        strSQL += ", '" + General.BuildQueryString(Session("strUserName").ToString) + "'"

                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    End If
                Next

                ' If any of the custom options were previously saved, and removed later, then they must be deleted.		
                If MyBase.GetFormValue("txtDeletedCustomResponseOptions") <> "" Then
                    arrTemp = Split(MyBase.GetFormValue("txtDeletedCustomResponseOptions"), ",")
                    For j = 0 To arrTemp.Length - 1
                        If arrTemp(j) <> "" Then
                            ' Delete the custom response from the response table.
                            strSQL = "Exec usp_Del_tbl_PRS_ChecklistItems_Responses_Draft " + arrTemp(j)
                            Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                        End If
                    Next
                End If


            End If
        End If
    End Sub

End Class
