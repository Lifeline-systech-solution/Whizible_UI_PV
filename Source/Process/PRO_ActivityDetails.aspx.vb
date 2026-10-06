Imports CommonFunctions

Public Class PRO_ActivityDetails
    Inherits WebPages.Template.WhizTemplate

    Protected CONST_ACTION_SAVE As String = "SAVE"
    Private CONST_QUALITYRECORD As String = "AddQualityRecords"
    Private CONST_GUIDELINE As String = "AddGuidelines"
    Private CONST_CHECKLIST As String = "AddChecklists"
    Private CONST_TEMPLATE As String = "AddTemplates"

    Protected m_strWindowTitle As String
    Protected m_strMode As String
    Protected m_strActivityID As String
    Protected m_strProcessID As String
    Private m_strAction As String
    Private m_strSQL As String
    Private WithEvents objGrid As WebPage.Templates.GenericGrid
    Protected WithEvents frmActivityDetails As System.Web.UI.HtmlControls.HtmlForm
    Private m_strCheckboxCheckColName As String
    'Added By JayavantK, On - 7-Sep-2004
    Protected m_strPageNumber As String = ""
    Private m_strAllIds As String = ""
    Private m_strPrimaryKeyFieldName As String = ""
    'End Addition

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title based on the mode passed
        If Request.QueryString("Mode") <> "" Then
            Select Case Request.QueryString("Mode").ToUpper
                Case CONST_QUALITYRECORD.ToUpper
                    m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_QUALITY")
                Case CONST_GUIDELINE.ToUpper
                    m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_GUIDELINE")
                Case CONST_CHECKLIST.ToUpper
                    m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_CHECKLIST")
                Case CONST_TEMPLATE.ToUpper
                    m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_TEMPLATE")
            End Select
        End If
    End Sub
    Public Sub New()
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for send Email page.
        MyBase.InitializeResources("AppResources.PRO_ActivityDetails", "AppResources")
    End Sub

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
    ' Created				:	Feb 20 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter

        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode.Trim = "" Then m_strMode = CONST_TEMPLATE 'default mode of the page
        m_strAction = Request.QueryString("Action") + ""
        m_strActivityID = Request.QueryString("ActivityID") + ""
        m_strProcessID = Request.QueryString("ProcessID") + ""

        'Added By JayavantK, On 7-Sep-2004
        m_strPageNumber = CommonFunctions.General.CheckIsNothing(Request.QueryString("PageNumber"))
        m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
        If m_strPageNumber = "" Then
            m_strPageNumber = "-1"
        Else
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_AND, "&")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_HASH, "#")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")
        End If
        'End Addition

        If m_strActivityID <> "" And m_strProcessID <> "" Then

            If m_strAction <> "" Then
                'perform the action based on the action value
                Call performAction()
            End If

            'initialize the resource file for standard menu and create menu.
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

            Dim arrstrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrstrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrstrClientSideFunctions() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick('656')"}

            'initialize the resource file for HR_EmployeeSelection page.
            MyBase.InitializeResources("AppResources.PRO_ActivityDetails", "AppResources")

            'Added By JayavantK, On 7-Sep-2004
            Dim strPageAlphabets As String = ""
            Dim strQuery As String = ""

            m_strAllIds = ""
            'Build the Query for the Paging alphabets
            strQuery = BuildQueryForGridPaging()
            strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, strQuery, MyBase.GetResourceString("SELECT") & " ", , "Alphabet", True)
            If strPageAlphabets = "" Then m_strPageNumber = "-1"
            'End Addition

            strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, strPageAlphabets)
            'draw upper menu
            General.WriteHTML(strMenu)
            General.WriteHTML("<BR>")

            'draw page caption 
            WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"))
            General.WriteHTML("<BR>")

            ''draw page description
            'objHeader = New WebPage.Templates.HeaderFooter
            'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC") + ""
            'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
            'General.WriteHTML("<BR>")
            'objHeader = Nothing

            'plot the grid for the activity details
            Call plotActivityDetailsGrid()

            'plot the lower menu
            strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
            General.WriteHTML("<BR>")
            General.WriteHTML(strMenu)

            'Added By JayavantK On 7-Sep-2004   -- Hidden field to store the ids of all the records which are shown
            If m_strAllIds <> "" Then m_strAllIds = Left(m_strAllIds, m_strAllIds.Length() - 1)
            CommonFunctions.HTMLControls.DrawTextBox("txthidAllIds", "txthidAllIds", , , , m_strAllIds, IsHidden:=True)
            'End Addition
        Else
            General.WriteHTML("<Div id='DivList'></Div>")
        End If

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotActivityDetailsGrid
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the grid of the activity details for the given process id and activity id.
    ' Description			:	same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 20 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotActivityDetailsGrid()
        Dim strSql As String
        Dim strPrimaryKeyName As String
        Dim strFirstColName As String
        Dim strFirstColHeader As String
        Dim strSecondColHeader As String

        'create SQL and set the prmary key name and first column name depending on the mode
        Select Case m_strMode.ToUpper
            Case CONST_QUALITYRECORD.ToUpper
                m_strSQL = "usp_Sel_tbl_QualityRecords " + m_strActivityID.Trim
                strPrimaryKeyName = "QualityRecordId"
                strFirstColName = "QualityRecordName"
                strFirstColHeader = MyBase.GetResourceString("COL_QUALITY_NAME") + ""
                strSecondColHeader = MyBase.GetResourceString("COL_SELECT_QUALITY") + ""
                m_strCheckboxCheckColName = "AssociatedRecord"

            Case CONST_GUIDELINE.ToUpper
                m_strSQL = "usp_Sel_PRS_tbl_GuideLine " + m_strActivityID.Trim
                strPrimaryKeyName = "GuidelineID"
                strFirstColName = "Title"
                strFirstColHeader = MyBase.GetResourceString("COL_GUIDELINE_TITLE") + ""
                strSecondColHeader = MyBase.GetResourceString("COL_SELECT_GUIDELINE") + ""
                m_strCheckboxCheckColName = "AssociatedGuideline"

            Case CONST_CHECKLIST.ToUpper
                m_strSQL = "usp_Sel_PRS_tbl_CheckLists " + m_strActivityID.Trim
                'change By NileshD on 27 August 2004
                'strPrimaryKeyName = "CheckListID"
                strPrimaryKeyName = "QuestionnaireID"
                'change By NileshD on 27 August 2004
                'strFirstColName = "Title"
                strFirstColName = "QuestionnaireName"
                strFirstColHeader = MyBase.GetResourceString("COL_CHECKLIST_TITLE") + ""
                strSecondColHeader = MyBase.GetResourceString("COL_SELECT_CHK") + ""
                m_strCheckboxCheckColName = "AssociatedCheckList"

            Case CONST_TEMPLATE.ToUpper
                m_strSQL = "usp_Sel_PRS_tbl_Template " + m_strActivityID.Trim
                strPrimaryKeyName = "TemplateID"
                strFirstColName = "Name"
                strFirstColHeader = MyBase.GetResourceString("COL_TEMPLATE_TITLE") + ""
                strSecondColHeader = MyBase.GetResourceString("COL_SELECT_TEMPLATE") + ""
                m_strCheckboxCheckColName = "AssociatedTemplate"
        End Select

        'Added By JayavantK, On 7-Sep-2004
        m_strPrimaryKeyFieldName = strPrimaryKeyName
        m_strSQL += ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"
        'End Addition

        Dim arrColHeader() As String = {strFirstColHeader.Trim, strSecondColHeader.Trim}
        Dim arrAN() As String = {strFirstColName.Trim, ""}
        Dim arrCheckBox() As String = {"", "chkSelect"}
        Dim arrCheckBoxCheck() As String = {"", ""}
        Dim arrTDStyle() As String = {"align='left'", "align='center'"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        'objGrid.RowLinkArray = arrRowLink
        objGrid.CheckBoxIDArray = arrCheckBox
        objGrid.CheckboxCheckOnColumnArray = arrCheckBoxCheck
        objGrid.TDStyleArray = arrTDStyle
        objGrid.PrimaryKey = strPrimaryKeyName
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 400
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = 1
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = m_strSQL
        objGrid.UseSQL = MyBase.UseSQL
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHtml
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotActivityDetailsGrid
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the grid of the activity details for the given process id and activity id.
    ' Description			:	same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 20 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performAction()
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strSelectedID As String
        Dim arrID() As String
        Dim intCnt As Integer
        Dim strDocumentName As String

        'get the list of activity ids selected 
        strSelectedID = MyBase.GetFormValue("chkSelect") + ""
        'If strSelectedID <> "" Then
        arrID = Split(strSelectedID, ",")
        'End If

        'Added By JayavantK, On 7-Sep-2004
        m_strAllIds = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidAllIds"), "")
        'End Addition

        'update the database depending on the mode of the page.
        Select Case m_strMode.ToUpper
            Case CONST_QUALITYRECORD.ToUpper

                'Delete the existing record from tbl_PRS_Activity_Reference_Draft & tbl_PRS_Activity_QualityRecords
                strSQL = "usp_Del_PRS_Activity_ReferencesAndQualityRecords_Draft " + m_strActivityID.Trim + ",'Quality'"
                'Added By JayavantK, On 7-Sep-2004
                strSQL += ", '" + m_strAllIds + "' "
                'End Addition
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                'Set the status of the process as draft
                strSQL = "usp_Upd_UpdateProcessDraftStatus " + m_strProcessID.Trim
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                'insert the records in tbl_PRS_QualityRecords_Draft (Q for Quality records)
                For intCnt = 0 To arrID.Length - 1
                    If arrID(intCnt) <> "" Then
                        'Extract the document name of the selected docuement(Flag as Q "QualityRecords" and  passing document id  )
                        strSQL = "usp_Sel_Prs_DocumentName 'Q'," + arrID(intCnt).Trim
                        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                        If objDR.Read Then
                            '' START : Commented and Modified By ParagD on 27-Sept-2006
                            '' strDocumentName = Data.CheckIsDBNull(objDR("DocumentName"), "").ToString
                            strDocumentName = CommonFunction.General.BuildQueryString(Data.CheckIsDBNull(objDR("DocumentName"), "").ToString)
                            '' END : Commented and Modified By ParagD on 27-Sept-2006
                        End If
                        Data.DisposeDataReader(objDR)

                        strSQL = "usp_Ins_tbl_PRS_Activity_QualityRecord_Draft " + m_strActivityID.Trim + "," + m_strProcessID.Trim + "," + arrID(intCnt).Trim + ",'" + strDocumentName.Trim + "','D'"
                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                    End If
                Next

            Case CONST_GUIDELINE.ToUpper

                'Delete the existing record from tbl_PRS_Activity_Reference_Draft & tbl_PRS_Activity_QualityRecords
                strSQL = "usp_Del_PRS_Activity_ReferencesAndQualityRecords_Draft " + m_strActivityID.Trim + ",'Guidelines'"
                'Added By JayavantK, On 7-Sep-2004
                strSQL += ", '" + m_strAllIds + "' "
                'End Addition
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                'Set the status of the process as draft
                strSQL = "usp_Upd_UpdateProcessDraftStatus " + m_strProcessID.Trim
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                'insert the records in tbl_PRS_QualityRecords_Draft (Q for Quality records)
                For intCnt = 0 To arrID.Length - 1
                    If arrID(intCnt) <> "" Then
                        'Extract the document name of the selected docuement(Flag as G "GuideLine and  passing document id  )
                        strSQL = "usp_Sel_Prs_DocumentName 'G'," + arrID(intCnt).Trim
                        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                        If objDR.Read Then
                            '' START : Commented and Modified By ParagD on 27-Sept-2006
                            '' strDocumentName = Data.CheckIsDBNull(objDR("DocumentName"), "").ToString
                            strDocumentName = CommonFunction.General.BuildQueryString(Data.CheckIsDBNull(objDR("DocumentName"), "").ToString)
                            '' END : Commented and Modified By ParagD on 27-Sept-2006
                        End If
                        Data.DisposeDataReader(objDR)

                        strSQL = "usp_Ins_tbl_PRS_Activity_Reference_Draft " + m_strActivityID.Trim + "," + m_strProcessID.Trim + "," + arrID(intCnt).Trim + ",'Guidelines','" + strDocumentName.Trim + "','D'"
                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                    End If
                Next

            Case CONST_CHECKLIST.ToUpper

                'Delete the existing record from tbl_PRS_Activity_Reference_Draft & tbl_PRS_Activity_QualityRecords
                strSQL = "usp_Del_PRS_Activity_ReferencesAndQualityRecords_Draft " + m_strActivityID.Trim + ",'Checklists'"
                'Added By JayavantK, On 7-Sep-2004
                strSQL += ", '" + m_strAllIds + "' "
                'End Addition
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                'Set the status of the process as draft
                strSQL = "usp_Upd_UpdateProcessDraftStatus " + m_strProcessID.Trim
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                '--Insert the CheckLists (C for CheckList)
                For intCnt = 0 To arrID.Length - 1
                    If arrID(intCnt) <> "" Then
                        'Extract the document name of the selected docuement(Flag as C "CheckList" and  passing document id  )
                        strSQL = "usp_Sel_Prs_DocumentName 'C'," + arrID(intCnt).Trim
                        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                        If objDR.Read Then
                            '' START : Commented and Modified By ParagD on 27-Sept-2006
                            '' strDocumentName = Data.CheckIsDBNull(objDR("DocumentName"), "").ToString
                            strDocumentName = CommonFunction.General.BuildQueryString(Data.CheckIsDBNull(objDR("DocumentName"), "").ToString)
                            '' END : Commented and Modified By ParagD on 27-Sept-2006
                        End If
                        Data.DisposeDataReader(objDR)

                        strSQL = "usp_Ins_tbl_PRS_Activity_Reference_Draft " + m_strActivityID.Trim + "," + m_strProcessID.Trim + "," + arrID(intCnt).Trim + ",'Checklists','" + strDocumentName.Trim + "','D'"
                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                    End If
                Next

            Case CONST_TEMPLATE.ToUpper

                'Delete the existing record from tbl_PRS_Activity_Reference_Draft & tbl_PRS_Activity_QualityRecords
                strSQL = "usp_Del_PRS_Activity_ReferencesAndQualityRecords_Draft " + m_strActivityID.Trim + ",'Templates'"
                'Added By JayavantK, On 7-Sep-2004
                strSQL += ", '" + m_strAllIds + "' "
                'End Addition
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                'Set the status of the process as draft
                strSQL = "usp_Upd_UpdateProcessDraftStatus " + m_strProcessID.Trim
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                '--Insert the CheckLists (C for CheckList)
                For intCnt = 0 To arrID.Length - 1
                    If arrID(intCnt) <> "" Then
                        'Extract the document name of the selected docuement(Flag as C "CheckList" and  passing document id  )
                        strSQL = "usp_Sel_Prs_DocumentName 'T'," + arrID(intCnt).Trim
                        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                        If objDR.Read Then
                            '' START : Commented and Modified By ParagD on 27-Sept-2006
                            '' strDocumentName = Data.CheckIsDBNull(objDR("DocumentName"), "").ToString
                            strDocumentName = CommonFunction.General.BuildQueryString(Data.CheckIsDBNull(objDR("DocumentName"), "").ToString)
                            '' END : Commented and Modified By ParagD on 27-Sept-2006
                        End If
                        Data.DisposeDataReader(objDR)

                        strSQL = "usp_Ins_tbl_PRS_Activity_Reference_Draft " + m_strActivityID.Trim + "," + m_strProcessID.Trim + "," + arrID(intCnt).Trim + ",'Templates','" + strDocumentName.Trim + "','D'"
                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                    End If
                Next
        End Select

        ''write client side script to refresh parent window and close this window
        'General.WriteHTML("<Script language=javascript>")
        'General.WriteHTML("opener.location.reload();")
        'General.WriteHTML("window.close();")
        'General.WriteHTML("</Script>")
    End Sub

    Private Function BuildQueryForGridPaging() As String
        '=====================================================================
        ' Function Name		    :	BuildQueryForGridPaging
        ' Parameters Passed		:	None
        ' Returns				:	The Built string of sql query.
        ' Parameters Affected	:	None
        ' Purpose				:	Builds the Query to plot the Paging characters, depending upon the Mode.
        ' Description			:	same as above.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	JayavantK
        ' Created				:	Sep 07 2004
        ' Revisions				:	
        '=====================================================================
        Dim strSQLReturn As String = ""

        Select Case m_strMode.ToUpper
            Case CONST_QUALITYRECORD.ToUpper
                strSQLReturn = "usp_Sel_tbl_QualityRecords " + m_strActivityID.Trim

            Case CONST_GUIDELINE.ToUpper
                strSQLReturn = "usp_Sel_PRS_tbl_GuideLine " + m_strActivityID.Trim

            Case CONST_CHECKLIST.ToUpper
                strSQLReturn = "usp_Sel_PRS_tbl_CheckLists " + m_strActivityID.Trim

            Case CONST_TEMPLATE.ToUpper
                strSQLReturn = "usp_Sel_PRS_tbl_Template " + m_strActivityID.Trim
        End Select

        strSQLReturn += ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"
        strSQLReturn += ", 1"

        Return strSQLReturn
    End Function

    'here this event is used to check or uncheck the checkbox as database field contains value Yes or No
    'here value for second col is checked for each row and checkbox is made checked accordingly
    'Here secong col name is depending on the mode of the page os it is taken in variable while plotting the grid itself.
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 1 Then
            'Added By JayavantK, On-7-Sep-2004
            Dim lngID As Long = 0
            lngID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader(m_strPrimaryKeyFieldName), "0"), Long)
            m_strAllIds += lngID.ToString() + ","
            'End Addition
            If Args.DataReader(m_strCheckboxCheckColName.Trim).ToString.ToUpper = "YES" Then
                Args.IsCheckBoxChecked = True
            End If
        End If
    End Sub

End Class
