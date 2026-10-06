'******************************************************************
'           CSPL Code Header
' Project Name     :    Whizible Enterprise Version
' Module Name      :    Generic Workflow - Checklist 
' Purpose          :    This module is used for getting the checklist items for a generic workflow.
' Description      :    This page is called from within project,milestone,module etc. tab. 
' Assumptions      :    None
' Dependencies     :    None
' Author           :    ShamkantD
' Reviewed         :    
' Tested           :    
' Created          :    May  22, 2008
' Revisions        :    
'******************************************************************
Imports System.Text

Public Class DM_Workflow_ChecklistResponses
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
        ' Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.DM_Workflow_ChecklistResponses", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
        m_objDS = Nothing
    End Sub
#End Region

#Region " Initialized Variables "
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private strQuery As String = ""

    Protected m_sbClientSideScript As New StringBuilder("")
    Protected m_lngUniqueID As Long = 0

    Protected m_intChecklistID As Long = 0
    Protected m_lngMasterTagId As Long = 0
    Protected m_strlblCheckList As String = GetCheckListLabelName()
    Protected m_intCReviewTypeId As Long = 0
    Protected m_strAction As String = ""
    Protected m_intMappedToReviewIssue As Integer
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Protected drWD As IDataReader
    Protected m_strWorkflowPKvalue As String = ""
    Protected m_strRequestStageID As String = ""
    Protected m_strMode As String = ""
    Protected sbHTML As StringBuilder
    Protected m_strRespondedBy As String = ""
    Protected m_StageID As String = ""
    Protected m_objDS As DataSet
    Protected txtSQLQuery As System.Text.StringBuilder
    Protected m_strContextType As String = "P"
    Protected m_strRequestStage As String = ""

#End Region

#Region " Generic Functions "
    Private Function GetCheckListLabelName() As String
        '=====================================================================
        ' Procedure Name        : GetCheckListLabelName()	
        ' Purpose               : Function to get the caption for Checklist
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : ShamkantD
        ' Created               : September 13, 2004
        ' Revisions             : None
        '=====================================================================
        Dim drFieldLabels As IDataReader
        Dim strlblCheckList As String = ""
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "SELECT * FROM tbl_CNF_ConfigFieldName "
        strQuery = "usp_Sel_tbl_CNF_ConfigFieldName "
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        drFieldLabels = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        While drFieldLabels.Read
            Select Case CType(CommonFunction.Data.CheckIsDBNull(drFieldLabels("FieldName"), ""), String)
                Case "CheckList"
                    strlblCheckList = CType(CommonFunction.Data.CheckIsDBNull(drFieldLabels("Label"), ""), String)
            End Select
        End While
        CommonFunction.Data.DisposeDataReader(drFieldLabels)

        Return strlblCheckList.ToString().Trim()
    End Function
    Private Function GetChecklistDetails() As Boolean
        '=====================================================================
        ' Procedure Name        : GetReviewDetails()	
        ' Purpose               : Function to get the review details
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : ShamkantD
        ' Created               : September 13, 2004
        ' Revisions             : None
        '=====================================================================
        Dim drChecklistDetails As IDataReader

        strQuery = "usp_Get_WorkflowStageChecklist " & m_lngUniqueID.ToString & "," & m_lngMasterTagId.ToString
        drChecklistDetails = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If drChecklistDetails.Read Then
            m_intChecklistID = CType(CommonFunction.Data.CheckIsDBNull(drChecklistDetails("ChecklistID"), "0"), Long)
            
        End If

        CommonFunction.Data.DisposeDataReader(drChecklistDetails)

        Return True
    End Function
    Private Sub SaveChecklistResponses()
       
        Dim intRadioButtons As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnRadioButtonsCount"), "")
        Dim intCheckBoxes As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnCheckBoxesCount"), "")
        Dim intDelCheckboxresponses As Integer = 0
        Dim blnRadioSelected As Boolean = False
        Dim blnCheckboxSelected As Boolean = False
        Dim intCtr As Integer = 0
        Dim intCtr2 As Integer = 0
        Dim intQuestionnaireQuestionID As Integer = 0
        Dim intNegativeResponseId As Integer = 0
        Dim intResponseId As Integer
        Dim strComments As String = ""

        For intCtr = 0 To Request.Form.GetValues("hdnQuestionnaireQuestionID").Length - 1
            strQuery = ""
            intQuestionnaireQuestionID = CType(Left(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnQuestionnaireQuestionID")(intCtr), "0"), Len(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnQuestionnaireQuestionID")(intCtr), "  ")) - 1), Integer)

            If CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnNegativeResponseId")(intCtr), "") <> "" Then
                intNegativeResponseId = CType(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnNegativeResponseId")(intCtr), "0"), Integer)
            Else
                intNegativeResponseId = 0
            End If

            strComments = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtAComments" + CStr(intQuestionnaireQuestionID)), ""), String)

            If Right(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnQuestionnaireQuestionID")(intCtr), " "), 1) = "R" Then
                intResponseId = CType(CommonFunction.General.CheckIsNothing(Request.Form("optOption" & intQuestionnaireQuestionID), "0"), Integer)

                'INSERT THE CHECK POINT IF ITS NOT AN ISSUE
                If intResponseId <> 0 Then
                    blnRadioSelected = True
                    If intCtr = 0 And intDelCheckboxresponses = 0 Then
                        intDelCheckboxresponses = 1
                    Else
                        intDelCheckboxresponses = 0
                    End If
                    'Modified By VidyaJ - IssueID 11580
                    strQuery = "Exec usp_Ins_Upd_tbl_IM_WorflowChecklistResponses " & m_strWorkflowPKvalue.ToString() & ",N'" + m_strContextType + "'," & intQuestionnaireQuestionID.ToString()
                    strQuery &= "," & intResponseId.ToString() & ",N'" & CommonFunction.General.BuildQueryString(strComments) & "'," & m_strRequestStageID & ",N'" & CommonFunction.General.CheckIsNothing(Session("strUserName"), "").ToString() & "'," & intNegativeResponseId.ToString()
                    strQuery &= "," & intDelCheckboxresponses.ToString()
                    CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                End If
            End If

            If Right(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnQuestionnaireQuestionID")(intCtr), " "), 1) = "C" Then
                If Not IsNothing(Request.Form.GetValues("chkOption" & Left(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnQuestionnaireQuestionID")(intCtr), "0"), Len(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnQuestionnaireQuestionID")(intCtr), "  ")) - 1))) Then
                    For intCtr2 = 0 To Request.Form.GetValues("chkOption" & Left(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnQuestionnaireQuestionID")(intCtr), "0"), Len(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnQuestionnaireQuestionID")(intCtr), "  ")) - 1)).Length - 1
                        blnCheckboxSelected = True
                        If intCtr2 = 0 And intCtr = 0 And intDelCheckboxresponses = 0 Then
                            intDelCheckboxresponses = 1
                        Else
                            intDelCheckboxresponses = 0
                        End If

                        intResponseId = CType(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("chkOption" & Left(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnQuestionnaireQuestionID")(intCtr), "0"), Len(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnQuestionnaireQuestionID")(intCtr), "  ")) - 1))(intCtr2), "0"), Integer)
                        intNegativeResponseId = -1

                        'INSERT THE CHECK POINT IF ITS NOT AN ISSUE
                        If intResponseId <> 0 Then
                            strQuery = "Exec usp_Ins_Upd_tbl_IM_WorflowChecklistResponses " & m_strWorkflowPKvalue & ",N'" + m_strContextType + "'," & intQuestionnaireQuestionID.ToString()
                            strQuery &= "," & intResponseId.ToString() & ",N'" & CommonFunction.General.BuildQueryString(strComments) & "'," & m_strRequestStageID & ",N'" & CommonFunction.General.CheckIsNothing(Session("strUserName"), "").ToString() & "'," & intNegativeResponseId.ToString()
                            strQuery &= "," & intDelCheckboxresponses.ToString()

                            CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                        End If
                    Next
                End If
            End If

            'If (Not blnRadioSelected) And (Not blnCheckboxSelected) Then
            '    strQuery = "DELETE  FROM tbl_IM_WorflowChecklistResponses WHERE ContextId = " & m_strWorkflowPKvalue & " and ContextType = N'" + m_strContextType + "' "
            '    strQuery &= " and RespondedBy = N'" & CommonFunction.General.CheckIsNothing(Session("strUserName"), "").ToString() & "' and UniqueId Is Null and ResponseId Is Not Null"
            '    CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL)
            'End If

        Next


        'Added by DipaliS
        Dim strScript As String = ""
        strScript += "<SCRIPT language=javascript>" + vbCrLf
        'Modified by VidyaJ - Security Changes - IssueID - 6197
        'Dim strToken As String
        'strToken = CommonFunctions.Security.Token.GetToken(m_lngMasterTagId.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "2191")
        strScript += "window.close();"


        strScript += "</SCRIPT>"
        Response.Write(strScript)
        'End addition by DipaliS

    End Sub
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
        ' Created               : Sep 15, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String

        Dim drReviewStatus As IDataReader
        Dim strQuery As String

        Dim m_strReviewStatus As String = ""
        m_objMenu = New WebPages.Template.StaticMenu
        Dim blnIsResponseExists As Boolean = False

        If m_strRespondedBy <> "" And m_strRequestStageID <> "" Then
            If m_objDS.Tables(0).Select("RespondedBy='" + m_strRespondedBy + "' AND UniqueID=" + m_strRequestStageID).Length > 0 Then
                blnIsResponseExists = True
            End If
        End If

        If m_strMode.ToUpper.Trim <> "VIEW" Then
            If m_strRespondedBy.ToUpper.Trim = CommonFunction.General.CheckIsNothing(Session("strUserName"), "").ToUpper.Trim Then
                If Not blnIsResponseExists Then
                    arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
                    arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
                    arrClientSideFunctionList.Add("Save_OnClick()")
                End If
            End If
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
            arrClientSideFunctionList.Add("Back_OnClick()")
        End If

        If m_strMode.ToUpper.Trim = "VIEW" Then


            If Not blnIsResponseExists Then
                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ADD"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ADD_TOOLTIP"))
                arrClientSideFunctionList.Add("Add_OnClick()")
            End If

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
            arrClientSideFunctionList.Add("Close_OnClick()")

        End If

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('PW')")
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu + "<BR>")
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

#Region " Page Load Functions "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    End Sub
    Public Sub InitVariables()
        '=====================================================================
        ' Procedure Name        : InitVariables()	
        ' Purpose               : To initialize page specifiec variables.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none.
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : May 24, 2008
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.ParentTagID = 32
        m_objAccessRights.TagID = 2094
        m_objAccessRights.GetAccess()


        If Not HttpContext.Current.Request.Form("txtUniqueID") Is Nothing Then
            m_lngUniqueID = CType("0" & CommonFunctions.General.CheckIsNothing(Request.Form("txtUniqueID")), Long)
        Else
            m_lngUniqueID = CType("0" & CommonFunctions.General.CheckIsNothing(Request("UniqueID")), Long)
        End If

        If Not HttpContext.Current.Request.Form("txtTagID") Is Nothing Then
            m_lngMasterTagId = CType("0" & CommonFunctions.General.CheckIsNothing(Request.Form("txtTagID")), Long)
        Else
            m_lngMasterTagId = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagID")), Long)
        End If


        If Not HttpContext.Current.Request.Form("txtMode") Is Nothing Then
            m_strMode = CType("" & CommonFunctions.General.CheckIsNothing(Request.Form("txtMode")), String)
        Else
            m_strMode = CType("" & CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")), String)
        End If

        Select Case m_lngMasterTagId
            Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                m_strContextType = "P"
            Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS
                m_strContextType = "M"
            Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT
                m_strContextType = "C"
            Case CommonFunction.Constants.APP_TAG_MODULES
                m_strContextType = "MO"
            Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                m_strContextType = "D"
            Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS
                m_strContextType = "S"
        End Select

        m_strAction = CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), "").ToString()
        m_strRespondedBy = CommonFunction.General.CheckIsNothing(Request.QueryString("RespondedBy"), "").ToString()
        m_StageID = CommonFunction.General.CheckIsNothing(Request.QueryString("RequestStageID"), "").ToString()
        'Get Review Details
        GetChecklistDetails()

        If Not Request.QueryString("CheckListID") Is Nothing Then
            m_intChecklistID = CType(Request.QueryString("CheckListID"), Long)
        End If

        DrawHiddenFields()

        strQuery = "usp_get_WorkflowDetails " & m_lngUniqueID.ToString & "," & m_lngMasterTagId.ToString
        drWD = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drWD.Read Then
            m_strWorkflowPKvalue = CStr(CommonFunction.Data.CheckIsDBNull(drWD("PrimaryKey")))
            m_strRequestStageID = CStr(CommonFunction.Data.CheckIsDBNull(drWD("RequestStageID")))
            m_strRequestStage = CStr(CommonFunction.Data.CheckIsDBNull(drWD("RequestStage")))
        End If
        CommonFunction.Data.DisposeDataReader(drWD)
        ''''''26TH May 2008
        If m_StageID = "" Then
            m_StageID = m_strRequestStageID
        End If

        If m_strRespondedBy = "" Then
            m_strRespondedBy = CommonFunction.General.CheckIsNothing(Session("strUserName"), "")
        End If
        ''''''
        txtSQLQuery = New System.Text.StringBuilder
        txtSQLQuery.Append("usp_Sel_Stagewise_Checklist ")
        txtSQLQuery.Append(m_strWorkflowPKvalue)
        txtSQLQuery.Append(",'" + m_strContextType + "'")

        m_objDS = CommonFunction.Data.GetDataSet(txtSQLQuery.ToString, "CheckList", , , MyBase.UseSQL)

        txtSQLQuery = Nothing

    End Sub
    Public Sub DrawHiddenFields()
        '=====================================================================
        ' Procedure Name        : DrawHiddenFields()	
        ' Purpose               : To draw hidden varaible which will required between postback.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none.
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : May 24, 2008
        ' Revisions             :
        '=====================================================================
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtUniqueID", "txtUniqueID", , , , m_lngUniqueID, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtTagID", "txtTagID", , , , m_lngMasterTagId, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding

    End Sub
    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : ShamkantD
        ' Created               : September 10, 2004
        ' Revisions             : None
        '=====================================================================
        InitVariables()

        If m_strAction.ToUpper = "SAVE" Then
            SaveChecklistResponses()
        End If

        DrawMenu(False)

        Response.Write("<div id=DivMain style=""width:100%;overflow:auto;height:100%"">")
        If m_strMode.ToUpper.Trim = "VIEW" Then
            DrawPageHeader()
            DrawListView()
        Else
            DrawPage()
        End If
        Response.Write("</div>")

        DrawMenu(False)

    End Sub
#End Region

#Region " Draw Page "
    Private Sub DrawPageHeader()
        '=====================================================================
        ' Procedure Name        : DrawPageHeader()	
        ' Purpose               : Draw HTML for Page header.  
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : May 27, 2008
        ' Revisions             :
        '=====================================================================
        sbHTML = New StringBuilder("")
        sbHTML.Append("</br>")
        sbHTML.Append(WebPages.Template.PageCaption.GetPageCaptions(, GetCheckListLabelName(), , , True).ToString)
        sbHTML.Append("</br>")
        Response.Write(sbHTML.ToString)
        sbHTML = Nothing
    End Sub
    Private Sub DrawListView()
        '=====================================================================
        ' Procedure Name        : DrawListView()	
        ' Purpose               : Draw HTML for List view.  
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : May 26, 2008
        ' Revisions             :
        '=====================================================================
        sbHTML = New StringBuilder("")


        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList
        Dim arrActualColumnNames As New ArrayList
        Dim arrGroupColumnNames As New ArrayList

        Dim arrWidthArray() As String = {"align=left", "align=center", "align=center", "align=center"}
        'To store the link details while clicking on Links in grid
        Dim arrColRowLinks() As String = {"", "", "Checklist_OnClick(RespondedBy,UniqueID,QuestionnaireID)", ""}

        Dim arrIgnoreHTMLEncode() As String = {"0"}




        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_STAGE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_RESPONDEDDATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_CHECKLIST"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_RESPONDEDBY"))


        arrActualColumnNames.Add("RequestStage")
        arrActualColumnNames.Add("ResponseDate")
        arrActualColumnNames.Add("QuestionnaireName")
        arrActualColumnNames.Add("RespondedBy")

        arrGroupColumnNames.Add("1")
        arrGroupColumnNames.Add("")
        arrGroupColumnNames.Add("")
        arrGroupColumnNames.Add("")

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .GroupOnColumn = GetArray(arrGroupColumnNames)
            .NoOfDataColumns = arrActualColumnNames.Count
            .TDStyleArray = arrWidthArray
            .RowLinkArray = arrColRowLinks
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 275
            .DIVStyle = "overflow:auto"
            '.SQL = strSQLQuery
            .GridDataTable = m_objDS.Tables(0)
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            sbHTML.Append(.DrawGrid())

        End With
        Response.Write(sbHTML.ToString)
        ' Clear Memory
        m_objGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        arrColRowLinks = Nothing

        sbHTML = Nothing

    End Sub
    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : ShowPageHeader()	
        ' Purpose               : Draw HTML for page 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : May 24, 2008
        ' Revisions             :
        '=====================================================================
        sbHTML = New StringBuilder("")
        Dim drQuestionlist As IDataReader

        Dim drDummy As IDataReader
        Dim strIssueType As String = ""
        Dim strIssueCorpStatus As String = ""
        Dim strIssueStatus As String = ""
        Dim strIssueSubType As String
        Dim strIssueCorpSubType As String
        Dim strIssueSeverity As String = ""
        Dim strIssueCorpSeverity As String = ""
        Dim intCounter As Integer = 0
        Dim intSrNo As Integer = 0
        Dim lngPrevSectionId As Long = 0
        Dim lngNextSectionId As Long = 0
        Dim intRadioButtons As Integer = 0
        Dim intCheckBoxes As Integer = 0

        Dim lngTempQuestionID As Long = 0
        Dim lngReviewStatisticsId As Long = 0


        Dim strRadioChecked As String = ""
        Dim strCheckboxSelected As String = ""
        Dim strRadioDisabled As String = ""
        Dim strRowClass As String = ""
        Dim strQuestionnaire As String = ""
        Dim strHiddenValuesId As String = ""
        Dim strRadioOrCheck As String = ""
        Dim strCheckListItemName As String = ""
        Dim strQuestionWithOption As String = ""
        Dim strReviewer As String = ""
        Dim blnMappedToReviewIssue As String = ""
        Dim strHiddenValuesNegative As String = ""
        Dim strHiddenValuesName As String = ""
        Dim strSingleSelectionWtCheckBox As String = ""

        Dim blnFirstQ As Boolean = False
        Dim blnComment As Boolean = False
        Dim strBtnName As String = ""
        Dim lngQuestionOptionID As Long = 0
        Dim strChecklistShortName As String = ""
        Dim intChecklistItemCount As Integer = 0
        Dim strHTMDescription As String = ""
        Dim intRecordCount As Integer = 0
        Dim intCurrentCount As Integer = 0
        Dim strHTMComments As String = ""

        strQuery = "Exec usp_tbl_IM_GetWorkflowChecklistItems  " & m_intChecklistID.ToString()
        strQuery &= "," & m_strWorkflowPKvalue.ToString() & ",N'" + m_strContextType + "'"

        If m_strMode.ToUpper.Trim = "EDIT" And m_strRespondedBy <> "" Then
            strQuery &= ",N'" & CommonFunction.General.BuildQueryString(m_strRespondedBy) & "'"
        Else
            strQuery &= ",NULL"
        End If
        If m_strMode.ToUpper.Trim = "EDIT" And m_StageID <> "" Then
            strQuery &= "," & m_StageID
        Else
            strQuery &= ",NULL"
        End If
        '=========================================================
        ' DISPLAYING CHECKLIST
        '=========================================================
        drQuestionlist = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        ' Get the record count
        While drQuestionlist.Read
            intRecordCount += 1
        End While

        CommonFunction.Data.DisposeDataReader(drQuestionlist)

        drQuestionlist = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        'sbHTML.Append("<div id=DivMain style=""width:100%;overflow:auto;height:100%"">")

        sbHTML.Append("<TABLE class=clsGridTable cellspacing=0 cellpadding=0 width='99.9%'>")

        intSrNo = 0
        lngPrevSectionId = 0
        lngNextSectionId = 0
        intRadioButtons = 0
        intCheckBoxes = 0

        blnFirstQ = True

        While drQuestionlist.Read
            intCurrentCount += 1
            If intCounter = 0 Then
                strChecklistShortName = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireName"), ""), String)
                sbHTML.Append("<TR class=clsTRPageCaption>")
                sbHTML.Append("<TD width=25%  style='border:thin' align=""left"">")
                sbHTML.Append(m_strlblCheckList & " : " & strChecklistShortName)

                'This hidden textbox is used when Save link is clicked and page is refreshed
                sbHTML.Append("<Input Type=Hidden Name=txtSaveFlag id=txtSaveFlag value=""0"">")
                'Changed to check .Please revert back REMEMBER......
                'sbHTML.Append("<Input Type=Text Name=txtSaveFlag id=txtSaveFlag value=""0"">")

                sbHTML.Append("</TD>")
                sbHTML.Append("<TD width=25%  style='border:thin' align=""right"">")
                sbHTML.Append(MyBase.GetResourceString("COL_STAGE") + " : " + CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("RequestStage"), m_strRequestStage), String))
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")

                sbHTML.Append("<TR class=clsTREven>")
                sbHTML.Append("<TD align=""right"" colspan=2>")
                sbHTML.Append("(Note : Responses in bold characters represent negative responses.)")
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")
                sbHTML.Append("</TABLE><BR>")

                sbHTML.Append("<TABLE class=clsGridTable  cellspacing=1 cellpadding=1 width='99.9%' id=tblChecklist>")
                sbHTML.Append("<TR class=clsTRColumnHeader>")
                sbHTML.Append("<TD align=""center"" nowrap width=""10%"">")
                sbHTML.Append("Sr.No.")
                sbHTML.Append("</TD>")
                sbHTML.Append("<TD nowrap>")
                sbHTML.Append(m_strlblCheckList & " Item")
                sbHTML.Append("</TD>")
              
                sbHTML.Append("<TD width = 40% align = left>&nbsp;&nbsp;Responses</TD>")
                sbHTML.Append("<TD align=center width=""10%"">Comments</TD>")
                sbHTML.Append("</TR>")

                ''Commented by PrashantSJ on 24th May 2008
                lngTempQuestionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireQuestionID"), "0"), Long)
                ''End of addition by PrashantSJ on 24th May 2008

            End If


            '--- Check for the question ID
            intCounter = intCounter + 1
            strRadioChecked = ""
            strCheckboxSelected = ""
            strRadioDisabled = ""



            If lngTempQuestionID <> CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireQuestionID"), "0"), Long) Then
                intSrNo += 1

                If intSrNo Mod 2 = 0 Then
                    strRowClass = "clsTREven"
                Else
                    strRowClass = "clsTROdd"
                End If

                '''''''''''''''''
                ' lngTempQuestionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireQuestionID"), "0"), Long)
                ''''''''''''''''''''''
                'lngNextSectionId = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CaytegoryID"), "0"), Long)

                '--Display the section for checklist items
                If lngNextSectionId <> lngPrevSectionId Then
                    strQuestionnaire &= "<TR class=clsTRGroupHeader>"
                    strQuestionnaire &= "<TD style='border:thin' align=""left"" COLSPAN=4>"
                    strQuestionnaire &= strHTMDescription ''CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Description"), ""), String)
                    strQuestionnaire &= "</TD>"
                    strQuestionnaire &= "</TR>"
                    lngPrevSectionId = lngNextSectionId
                    'strRowClass = "clsTROdd"
                    intCounter = 1
                End If

                '--- Display the questions and options in the table.		
                strQuestionnaire &= "<TR class=" & strRowClass & ">"


                strQuestionnaire &= "<Input Type=Hidden Name=hdnQuestionnaireQuestionID value=" & strHiddenValuesId & strRadioOrCheck & ">"
                strQuestionnaire &= "<Input Type=Hidden Name=hdnNegativeResponseId value=" & strHiddenValuesNegative & ">"
                strQuestionnaire &= "<Input Type=Hidden Name=hdnChecklistItemName value=" & strHiddenValuesName & ">"
                strQuestionnaire &= "<TD align=center><b>" & intSrNo & "</b></TD>"

                strQuestionnaire &= "<TD align=left>" & strCheckListItemName & "</TD>"


                '  strQuestionnaire &= "<TD width = 20%></TD>"


                strQuestionnaire &= "<TD align=left>" & strQuestionWithOption & "</TD>"



                'If blnComment = True Then
                'strQuestionnaire &= "<a href=""javascript:EnterComments_OnClick(" & strHiddenValuesId & "," & lngReviewStatisticsId & ",'" & strReviewer & "','" & blnMappedToReviewIssue & "') "">Enter</a>"
                'End If

                'Commented and Added By Bharat T on 3rd-Dec-2015 for Workflow approval zoom image alignment
                'strQuestionnaire &= "<TD width = 20%>"
                strQuestionnaire &= "<TD width = 20% style='white-space:nowrap;'>"
                'End of Commented and Added By Bharat T on 3rd-Dec-2015 for Workflow approval zoom image alignment
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'strQuestionnaire &= CommonFunction.HTMLControls.DrawTextArea("txtAComments" + CStr(lngTempQuestionID), "txtAComments" + CStr(lngTempQuestionID), "Comments", , , "frmWorkflowChecklist", , , 200, 70, 200, strHTMComments, , , , , , , , True)
                strQuestionnaire &= CommonFunction.HTMLControls.DrawTextArea("txtAComments" + CStr(lngTempQuestionID), "txtAComments" + CStr(lngTempQuestionID), "Comments", , , "frmWorkflowChecklist", , , 200, 70, 200, strHTMComments, , , , , , , , True, EnableHTMLEncode:=True)
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                strQuestionnaire &= "</TD>"

                lngTempQuestionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireQuestionID"), "0"), Long)

                'Displaying the options for the above question with respect to the
                '-Parameters assigned for the question for eg. Question type-Single selection,
                '-multiple selection etc.

                strCheckListItemName = ""
                strQuestionWithOption = ""
                strSingleSelectionWtCheckBox = ""

                strHiddenValuesId = ""
                strHiddenValuesName = ""
                strHiddenValuesNegative = ""

                blnComment = False
                strQuestionnaire &= "</TR>"
                '--- Generate the string for questions and options
                '--- Generate the string for Question and its realated option with the respective control
                '--- (option btn / check box)
                strCheckListItemName = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CheckListItemName"), ""), String)
                blnComment = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ShowComment"), "False"), Boolean)

                '--- Append the Option to the question
                strHiddenValuesId = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireQuestionID"), ""), String)
                strHiddenValuesName = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CheckListItemName"), ""), String)

                If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) = True Then
                    strHiddenValuesNegative = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String)
                End If

                If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("SingleSelection"), "False"), Boolean) = True Then
                    intRadioButtons = intRadioButtons + 1
                    '--- Set the radio button to the option.
                    '												If drQuestionlist.Fields("QuestionnaireOptionID").value = drQuestionlist.Fields("ResponseID").value Then
                    If InStr(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Responses"), ""), String), "," & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String) & ",") > 0 Then
                        strRadioChecked = " Checked "
                    End If

                    If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("UniqueId"), ""), String) <> "0" Then
                        strRadioDisabled = " Disabled "
                    End If


                    strBtnName = "optOption" & lngTempQuestionID
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), "0"), Long)
                    strQuestionWithOption &= "&nbsp;<INPUT id=" & strBtnName & _
                    " name=" & strBtnName & " type=radio class=clsOptionButton value=""" & lngQuestionOptionID & """" & strRadioChecked & " " & strRadioDisabled & _
                    " >"

                    '--- Set option description
                    If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) = True Then
                        strQuestionWithOption &= "<B>" & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String) & "</b>"
                    Else
                        strQuestionWithOption &= CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String)
                    End If

                    strBtnName = ""
                    lngQuestionOptionID = 0

                ElseIf CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("MultipleSelection"), "False"), Boolean) = True Then
                    intCheckBoxes += 1

                    If InStr(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Responses"), ""), String), "," & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String) & ",") > 0 Then
                        strCheckboxSelected = " Checked "
                    End If

                    '--- Set the check boxes to the option.
                    strBtnName = "chkOption" & lngTempQuestionID.ToString()
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), "0"), Long)
                    strQuestionWithOption &= "&nbsp;<INPUT id=" & strBtnName & _
                    " name=" & strBtnName & " type=checkbox class=clsCheckBox value=""" & lngQuestionOptionID & """ " & strCheckboxSelected & _
                    " >"

                    '--- Set option description
                    'If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) = True Then
                    'strQuestionWithOption &= "<B>" & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String) & "</b>"
                    'Else
                    strQuestionWithOption &= CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String)
                    'End If

                    strBtnName = ""
                    lngQuestionOptionID = 0

                ElseIf CBool(CommonFunction.Data.CheckIsDBNull(drQuestionlist("SingleSelectionWithCheckBox"), "False")) = True Then
                    strQuestionWithOption = ""
                    strBtnName = "chkOption" & lngTempQuestionID
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireQuestionID"), "0"), Long)
                    strSingleSelectionWtCheckBox = "&nbsp;<INPUT id=" & strBtnName & " name=" & strBtnName & " type=checkbox class=clsCheckBox value=""" & lngQuestionOptionID & """" & " >"
                    strBtnName = ""
                    lngQuestionOptionID = 0
                End If
                '''''''''''
                '''''''''''''''
            Else
                lngNextSectionId = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CaytegoryID"), "0"), Long)
                '''''''''''''''PrashantSJ
                strHTMDescription = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Description"), ""), String)
                strHTMComments = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Comments"), ""), String)
                '''''''''''''''PrashantSJ
                '--- Generate the string for questions and options
                '--- Generate the string for Question and its realated option with the respective control
                '--- (option btn / check box)
                strCheckListItemName = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CheckListItemName"), ""), String)
                blnComment = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ShowComment"), "False"), Boolean)

                '--- Append the Option to the question
                strHiddenValuesId = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireQuestionID"), ""), String)
                strHiddenValuesName = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CheckListItemName"), ""), String) & ""
                If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) = True Then
                    strHiddenValuesNegative = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String)
                End If

                If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("SingleSelection"), "False"), Boolean) = True Then
                    strRadioOrCheck = "R"
                    If intRadioButtons = 0 Then
                        intRadioButtons = 1
                    End If
                    '												If drQuestionlist.Fields("QuestionnaireOptionID").value = drQuestionlist.Fields("ResponseID").value Then
                    If InStr(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Responses"), ""), String), "," & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String) & ",") > 0 Then
                        strRadioChecked = " Checked "
                    End If

                    If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("UniqueId"), ""), String) <> "0" Then
                        strRadioDisabled = " Disabled "
                    End If

                    '--- Set the radio button to the option.
                    strBtnName = "optOption" & lngTempQuestionID
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), "0"), Long)
                    strQuestionWithOption &= "&nbsp;<INPUT id=" & strBtnName & _
                    " name=" & strBtnName & " type=radio class=clsOptionButton value=""" & lngQuestionOptionID & """" & strRadioChecked & " " & strRadioDisabled & _
                    " >"

                    '--- Set option description
                    If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) Then
                        strQuestionWithOption &= "<B>" & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String) & "</b>"
                    Else
                        strQuestionWithOption &= CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String)
                    End If

                    strBtnName = ""
                    lngQuestionOptionID = 0
                ElseIf CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("MultipleSelection"), "False"), Boolean) = True Then
                    '--- Set the check boxes to the option.
                    strRadioOrCheck = "C"
                    If intCheckBoxes = 0 Then
                        intCheckBoxes = intCheckBoxes + 1
                    End If

                    If InStr(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Responses"), ""), String), "," & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String) & ",") > 0 Then
                        strCheckboxSelected = " Checked "
                    End If

                    strBtnName = "chkOption" & lngTempQuestionID
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), "0"), Long)
                    strQuestionWithOption &= "&nbsp;<INPUT id=" & strBtnName & _
                        " name=" & strBtnName & " type=checkbox class=clsCheckBox value=""" & lngQuestionOptionID & """ " & strCheckboxSelected & _
                        " >"

                    '--- Set option description
                    'If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) = True Then
                    'strQuestionWithOption &= "<B>" & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String) & "</b>"
                    'Else
                    strQuestionWithOption &= CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String)
                    ' End If

                    strBtnName = ""
                    lngQuestionOptionID = 0

                ElseIf CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("SingleSelectionWithCheckBox"), "False"), Boolean) = True Then
                    strQuestionWithOption = ""
                    strBtnName = "chkOption" & lngTempQuestionID
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), "0"), Long)
                    strSingleSelectionWtCheckBox = "&nbsp;<INPUT id=" & strBtnName & " name=" & strBtnName & " type=checkbox class=clsCheckBox value=""" & lngQuestionOptionID & """" & " >"
                    strBtnName = ""
                    lngQuestionOptionID = 0
                End If

            End If
            'Process the last Record
            If intCurrentCount = intRecordCount Then
                'intCounter = intCounter + 1
                intSrNo = intSrNo + 1

                If intSrNo Mod 2 = 0 Then
                    'strRowClass = "clsTDEven"
                    strRowClass = "clsTREven"
                Else
                    'strRowClass = "clsTDOdd"
                    strRowClass = "clsTROdd"
                End If

                '--Display the section for checklist items
                If lngNextSectionId <> lngPrevSectionId Then
                    strQuestionnaire &= "<TR class=clsTRGroupHeader>"
                    strQuestionnaire &= "<TD style='border:thin' align=""left"" COLSPAN=4>"
                    strQuestionnaire &= CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Description"), ""), String)
                    strQuestionnaire &= "</TD>"
                    strQuestionnaire &= "</TR>"
                    lngPrevSectionId = lngNextSectionId
                    'strRowClass = "clsTDOdd"
                    'strRowClass = "clsTROdd"
                    intCounter = 1
                End If

                strQuestionnaire &= "<TR class=" & strRowClass & ">"

                strQuestionnaire &= "<Input Type=Hidden Name=hdnQuestionnaireQuestionID value=" & strHiddenValuesId & strRadioOrCheck & ">"
                strQuestionnaire &= "<Input Type=Hidden Name=hdnNegativeResponseId value=" & strHiddenValuesNegative & ">"
                strQuestionnaire &= "<Input Type=Hidden Name=hdnChecklistItemName value=" & strHiddenValuesName & ">"

                '--- Display Column Sr. No.
                strQuestionnaire &= "<TD align=center><b>" & intSrNo & "</b></TD>"
                'Code Commented by Noble  K 15th Jan 2005
                'strQuestionnaire &= "<TD align=center>" & "</TD>"

                '--- Display column for Question and its option
                strQuestionnaire &= "<TD align=left>" & strCheckListItemName & "</TD>"


                'Code Added by Noble K on 15th Jan 2005 to insert a blank cell
                'strQuestionnaire &= "<TD width = 20%></TD>"
                'Code Addition by Noble K 15th Jan 2005 Ends

                strQuestionnaire &= "<TD align=left>" & strQuestionWithOption & "</TD>"
                'Commented And Added By Chakshuta H on 3rd-Nov-2015 Purpose::QA issue fixing
                'strQuestionnaire &= "<TD align=Center>"
                'Commented and Added By Bharat T on 3rd-Dec-2015 for Workflow approval zoom image alignment
                'strQuestionnaire &= "<TD align=right>"
                strQuestionnaire &= "<TD align=right style='white-space:nowrap;'>"
                'End of Commented and Added By Bharat T on 3rd-Dec-2015 for Workflow approval zoom image alignment
                'End Of Comment And Addition By Chakshuta H on 3rd-Nov-2015 Purpose::QA issue fixing

                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'strQuestionnaire &= CommonFunction.HTMLControls.DrawTextArea("txtAComments" + CStr(lngTempQuestionID), "txtAComments" + CStr(lngTempQuestionID), "Comments", , , "frmWorkflowChecklist", , , 200, 70, 200, strHTMComments, , , , , , , , True)
                strQuestionnaire &= CommonFunction.HTMLControls.DrawTextArea("txtAComments" + CStr(lngTempQuestionID), "txtAComments" + CStr(lngTempQuestionID), "Comments", , , "frmWorkflowChecklist", , , 200, 70, 200, strHTMComments, , , , , , , , True, EnableHTMLEncode:=True)
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'If blnComment = True Then
                'strQuestionnaire &= "<a href=""javascript:EnterComments_OnClick(" & strHiddenValuesId & "," & lngReviewStatisticsId & ",'" & strReviewer & "','" & blnMappedToReviewIssue & "') "">Enter</a>"
                'End If

                strQuestionnaire &= "&nbsp;</TD>"

                strCheckListItemName = ""
                strQuestionWithOption = ""
                strSingleSelectionWtCheckBox = ""
                strQuestionnaire &= "</TR>"

            End If
            '--- Display the comment box under the question options
        End While

        CommonFunction.Data.DisposeDataReader(drQuestionlist)

        If intRecordCount > 0 Then
            ''--- Display the questions and options in the table.
            sbHTML.Append(strQuestionnaire)

            intChecklistItemCount = intRecordCount
            sbHTML.Append("<Input Type=Hidden ID=""hdnChecklistItemCount"" Name=hdnChecklistItemCount value=""" & intChecklistItemCount & """>")
            sbHTML.Append("<Input Type=Hidden ID=""hdnRadioButtonsCount"" Name=hdnRadioButtonsCount value=""" & intRadioButtons & """>")
            sbHTML.Append("<Input Type=Hidden ID=""hdnCheckBoxesCount"" Name=hdnCheckBoxesCount value=""" & intCheckBoxes & """>")
        Else
            intChecklistItemCount = 0
            sbHTML.Append("<TABLE class=clsGridTable cellspacing=1 cellpadding=1 width='99.9%' id=tblChecklist>")
            sbHTML.Append("<TR class=clsTRColumnHeader>")
            'sbHTML.Append("<TD align=""center"" nowrap width=""10%"">")
            'sbHTML.Append("Sr")
            'sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=""left"" nowrap>")
            sbHTML.Append(m_strlblCheckList & " Item")
            sbHTML.Append("</TD>")

            sbHTML.Append("<TD width = 20%>&nbsp;</TD>")
            sbHTML.Append("<TD width = 40% align = left>&nbsp;&nbsp;Responses</TD>")
            sbHTML.Append("</TR>")

            sbHTML.Append("<TR class=clsTROdd>")
            sbHTML.Append("<TD align=center colspan=4>There are no items to show in this view.</td>")
            sbHTML.Append("</TR>")
        End If

        sbHTML.Append("</TABLE>")
        sbHTML.Append("<BR><BR>")
        ''sbHTML.Append("</div>")

        CommonFunctions.General.WriteHTML(sbHTML.ToString())
        sbHTML = Nothing
    End Sub
#End Region
#Region "Grid Events"
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper.Trim = "RESPONSEDATE" Then
            Args.ReplacementValue = CommonFunction.Dates.CGetDate(CDate(Args.DataFieldValue))
        End If
    End Sub
#End Region
End Class
