Imports System.Text
Public Class RT_TimesheetApproval
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

#Region " Variables Declaration"
    '---   Private variables   ---
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private m_intUserID As Integer
    Private m_intFilterEmployeeID As String
    Private m_strFilterStatusCode As String
    Private m_strFilterDateID As String
    Private m_strFilterLast As String
    Private m_sortby As String
    Private m_sortorder As String
    Private m_blnVerify As Boolean
    Private m_intTotalRecord As Integer = 0

    '---   Protected Variables   ---
    Protected m_strWindowTitle As String

    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
    Protected m_strToken As String
    Protected m_strTokenForApproveLink As String
    Protected s_ParentTagID As Long = 0
    Protected lngUserId As Long
    Protected m_TagTimesheetApproval As Long = CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET
    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197

    'Start_AJ_16-Oct-2006
    'Addition by SnehalV 2nd Nov 2006 for WhizibleSEM SP8 integration
    Public m_strTSIDs As String = ""
    Public m_strTSIDsWithToken As String = ""
    'End of Addition by SnehalV
    'End_AJ

#End Region

#Region " Constructor "
    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.RT_TimesheetApproval", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

#Region " Menu"
    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : 03/08/2005
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList
        Dim arrMenuToolTipsList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strMenu As String                           'Used to store the Menu List as HTML
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'Dim strSQLQuery As String = "SELECT * FROM tbl_PM_ResourceTimeSheetStatus WHERE ApproverID = " + CType(Session("intUserID"), String)
        Dim strSQLQuery As String = "usp_tbl_PM_ResourceTimeSheetStatus_ApproverID " + CType(Session("intUserID"), String)
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        Dim drTimesheet As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If drTimesheet.Read Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_APPROVE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_APPROVE_TOOLTIP"))
            arrClientSideFunctionList.Add("Approve_OnClick('" & CStr(IIf(m_sortby = "", "EmployeeName", m_sortby)) & "','" & CStr(IIf(m_sortby = "", "ASC", m_sortorder)) & "')")
            ' arrClientSideFunctionList.Add("Approve_OnClick()")
        End If
        CommonFunctions.Data.DisposeDataReader(drTimesheet)

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SELECT_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("SelectAll_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_CLEAR_ALL"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_CLEAR_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("ClearAll_OnClick()")


        arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("ShowHelp()")

        m_objMenu = New WebPages.Template.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

#End Region

#Region " Grid"
    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawTimesheetGrid()	
        ' Purpose               : Plots the grid displaying timesheets of employee
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 02/08/2005
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        Dim strTempEmployeeID As String, strTempStatusCode As String, strTempDateID As String, strTempLastID As String
        Dim strTempsortby As String, strTempsortorder As String

        '----------To store the column Headings(user friendly name)-------
        Dim arrColumnHeadingList() As String = {MyBase.GetResourceString("STATUS") _
                                                , MyBase.GetResourceString("EMPLOYEE_NAME") _
                                                , MyBase.GetResourceString("FROM_DATE") _
                                                , MyBase.GetResourceString("TO_DATE") _
                                                , MyBase.GetResourceString("ATUAL_WORK") _
                                                , MyBase.GetResourceString("VERIFY")}

        '---------Atual column name  -------------------------------------
        Dim arrActualColumnNames() As String = {"StatusDescription" _
                                                , "EmployeeName" _
                                                , "FromDate" _
                                                , "ToDate" _
                                                , "TotalAMH", ""}
        '-----------------------------------------------------------------
        Dim arrCheckBoxId() As String = {"", "", "", "", "", "chkApprove"}
        '---------To store the link details while clicking on Links in grid---
        Dim arrColRowLinks() As String = {"" _
                                            , "Employee_OnClick(TimesheetID,EmployeeID,StatusCode)" _
                                            , "" _
                                            , "" _
                                            , "", ""}
        '-----------------------------------------------------------------
        Dim arrTDStyle() As String = {"align=left" _
                                            , "align=left" _
                                            , "align=left" _
                                            , "align=left" _
                                            , "align=right" _
                                            , "align=center"}
        '-----------------------------------------------------------------
        'Dim sbFooterHTML As New System.Text.StringBuilder("")
        '-----------------------------------------------------------------
        strTempEmployeeID = CStr(IIf(m_intFilterEmployeeID = "", "NULL", m_intFilterEmployeeID))
        strTempStatusCode = CStr(IIf(m_strFilterStatusCode = "", "NULL", m_strFilterStatusCode))
        strTempsortby = CStr(IIf(m_sortby = "", "EmployeeName", m_sortby))
        strTempsortorder = CStr(IIf(m_sortorder = "", "ASC", m_sortorder))
        strTempDateID = CStr(IIf(m_strFilterDateID = "", "NULL", m_strFilterDateID))
        strTempLastID = CStr(IIf(m_strFilterLast = "", "NULL", m_strFilterLast))
        '-----------------------------------------------------------------
        'strQuery = "usp_sel_v_tbl_PM_ResourceTimesheetForVerification"
        strQuery = "usp_sel_tbl_PM_ResourceTimesheet_Approval " & m_intUserID & "," & strTempEmployeeID & "," & strTempStatusCode & ",'" & strTempsortby & "','" & strTempsortorder & "', " & strTempDateID & ", " & strTempLastID

        ''Commented and Added by Dhanashri S on 7 Dec 2015 For IssueID : 2030
        ''CommonFunctions.General.WriteHTML("<DIV id='DivList' style='Overflow:auto;width:100%;Height:345'>")
        CommonFunctions.General.WriteHTML("<DIV id='DivList' style='Overflow:auto;width:100%>")
        ''End of Comment and Addition by Dhanashri S on 7 Dec 2015

        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With m_objGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .CheckBoxIDArray = arrCheckBoxId
            .RowLinkArray = arrColRowLinks
            .NoOfDataColumns = 5
            .ClientSideSortFunctionName = "Sort_OnClick" ' without param. and brackets
            .TDStyleArray = arrTDStyle
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            ''.DIVHeight = 0
            .SQL = strQuery
            .SortBy = strTempsortby
            .SortOrder = strTempsortorder
            .UseSQL = True
            .PrimaryKey = "TimesheetID"
            '.FooterHTML = sbFooterHTML.ToString
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGrid = Nothing
        CommonFunctions.General.WriteHTML("</DIV>")

        'Start_AJ_16-Oct-2006
        'Addition by SnehalV 2nd Nov 2006 for WhizibleSEM SP8 integration
        Session("TSIDs") = m_strTSIDs
        Session("TSIDsWithToken") = m_strTSIDsWithToken
        'End of addition by SnehalV
        'End_AJ_16-Oct-2006

    End Sub

    Private Sub DrawPageCaption()
        'WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("LEFT_CAPTION"), MyBase.GetResourceString("MIDDLE_CAPTION"), MyBase.GetResourceString("RIGHT_CAPTION"))
        WebPages.Template.PageCaption.GetPageCaptions(, "Timesheet Approval", , )
    End Sub
#End Region

#Region " Filters"
    Private Sub DisplayFilters()
        '=====================================================================
        ' Procedure Name        : DisplayFilters()	
        ' Purpose               : To Draw Filters
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : 02/08/2005
        ' Revisions             : 1.0  
        '=====================================================================
        Dim sbHTML As New StringBuilder("")
        Dim strTempHTML As String = ""
        Dim strQuery As String = ""
        Dim strTempUserID As String, strTempEmployeeID As String, strTempStatusCode As String
        Dim strTempDateID As String, strTempLastID As String
        strTempUserID = CStr(m_intUserID)
        strTempEmployeeID = CStr(IIf(m_intFilterEmployeeID = "", "0", m_intFilterEmployeeID))
        strTempStatusCode = CStr(IIf(m_strFilterStatusCode = "", "0", m_strFilterStatusCode))
        strTempDateID = CStr(IIf(m_strFilterDateID = "", "0", m_strFilterDateID))
        strTempLastID = CStr(IIf(m_strFilterLast = "", "0", m_strFilterLast))
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        sbHTML.Append("<TABLE Class=clsTable Width='99.9%' cellpadding=0 cellspacing=0>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        sbHTML.Append("<TR class='clsTREven'>")

        sbHTML.Append("<TD valign='Top' align='right'>")             '-----Td start 
        sbHTML.Append(MyBase.GetResourceString("FILTER_STATUS"))
        sbHTML.Append("</TD>")                                      '-----Td end
        sbHTML.Append("<TD valign='Top' align='Left'>")             '-----Td start 

        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strQuery = "Select StatusCode,StatusDescription From tbl_PM_TimeSheet_Status Where StatusCode <> 'N'"
        strQuery = "usp_tbl_PM_TimeSheet_Status_StatusCode "
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        strTempHTML = CommonFunctions.HTMLControls.DrawComboBox("cboFilter_Status", strQuery, 200, strTempStatusCode, "onchange=Filter_OnClick()", True, True)
        sbHTML.Append(strTempHTML)
        sbHTML.Append("</TD>")                                      '-----Td start

        sbHTML.Append("<TD valign='Top' align='right'>")             '-----Td start 
        sbHTML.Append(MyBase.GetResourceString("FILTER_EMPLOYEE"))
        sbHTML.Append("</TD>")                                      '-----Td end
        sbHTML.Append("<TD valign='Top' align='Left'>")             '-----Td start 
        strQuery = "EXEC usp_Sel_tbl_PM_ResourceTimesheetForVerification_Filters " & strTempUserID & ", Employee"
        strTempHTML = CommonFunctions.HTMLControls.DrawComboBox("cboFilter_EmployeeID", strQuery, 200, strTempEmployeeID, "onchange=Filter_OnClick()", True, True)
        sbHTML.Append(strTempHTML)
        sbHTML.Append("</TD>") '-----Td start

        sbHTML.Append("</TR>")

        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD valign='Top' align='right'>")             '-----Td start 
        sbHTML.Append(MyBase.GetResourceString("FILTER_DATE"))
        sbHTML.Append("</TD>")                                      '-----Td end
        sbHTML.Append("<TD valign='Top' align='Left'>")             '-----Td start 
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strQuery = "SELECT * FROM tbl_CRW_DATERANGES"
        strQuery = "usp_tbl_CRW_DATERANGES"
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query

        strTempHTML = CommonFunctions.HTMLControls.DrawComboBox("cboFilter_Date", strQuery, 200, strTempDateID, "onchange=Filter_OnClick()", True, True)
        sbHTML.Append(strTempHTML)
        sbHTML.Append("</TD>") '-----Td start

        sbHTML.Append("<TD valign='Top' align='right'>")             '-----Td start 
        sbHTML.Append(MyBase.GetResourceString("FILTER_LAST"))
        sbHTML.Append("</TD>")                                      '-----Td end
        sbHTML.Append("<TD valign='Top' align='Left'>")             '-----Td start 
        strQuery = "EXEC usp_sel_GetBottomRecords "
        strTempHTML = CommonFunctions.HTMLControls.DrawComboBox("cboFilter_Last", strQuery, 200, strTempLastID, "onchange=Filter_OnClick()", True, True)
        sbHTML.Append(strTempHTML)
        sbHTML.Append("</TD>") '-----Td start

        sbHTML.Append("</TR>")

        sbHTML.Append("</TABLE>")
        CommonFunctions.General.WriteHTML(sbHTML.ToString())

    End Sub
#End Region

#Region "Page Load Functions"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Use Resources Solution
        m_strWindowTitle = MyBase.GetResourceString("PAGE_TITLE")
    End Sub

    Private Sub Page_Draw()
        '=====================================================================
        ' Procedure Name        : Page_Draw()	
        ' Purpose               : ITo draw page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : 02/08/2005
        ' Revisions             : 1.0  
        '=====================================================================
        '------Draw upper menu -------------
        DrawMenu()
        CommonFunctions.General.WriteHTML("<BR>")
        ''Commented and Added by Dhanashri S on 7 Dec 2015 For Issue ID:2030
        ''CommonFunctions.General.WriteHTML("<DIV id='DivMain' name='DivMain' style='Overflow:auto;height:99.99%;width:99.99%;'>")
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' name='DivMain' style='Overflow:auto;width:99.99%;'>")
        ''End of Comment and addition by Dhanashri S on 7 Dec 2015
        '------Draw filter -------------
        DisplayFilters()
        CommonFunctions.General.WriteHTML("<BR>")
        '------Diaplay page heading -------------
        DrawPageCaption()
        CommonFunctions.General.WriteHTML("<BR>")
        '------Draw grid -------------------
        DrawGrid()
        CommonFunctions.General.WriteHTML("<BR>")
        '------print totalno of records----------
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE Class=clsTable Width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TD valign='Top' align='right'>")
        CommonFunctions.General.WriteHTML("Total Records :" & CStr(m_intTotalRecord))
        CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")
        '----------------------------------------
        CommonFunctions.General.WriteHTML("</DIV>")
        '------Draw lower menu--------------
        DrawMenu()
    End Sub

    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : InitVariables()	
        ' Purpose               : Initialize Page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : 02/08/2005
        ' Revisions             : 1.0  
        '=====================================================================

        '-------------------
        InitVariables()
        '-------------------
        DBProcess()
        '-------------------
        Page_Draw()
    End Sub

    Private Sub InitVariables()
        '=====================================================================
        ' Procedure Name        : InitVariables()	
        ' Purpose               : To Initialize
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : 02/08/2005
        ' Revisions             :
        '=====================================================================
        Dim strSQRY As String
        Dim drFilterValues As IDataReader
        m_intUserID = CType(Session("intUserID"), Integer)
        If Page.IsPostBack Then
            'saving filter values to the table
            strSQRY = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & CType(Session("intLoginType"), Integer) & "'," & m_intUserID & ", " & CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET & ", 1, 'StatusCode', 'Status' , 'F', " & CStr(IIf(CType(MyBase.GetFormValue("cboFilter_Status"), String) <> "", "'" & CType(MyBase.GetFormValue("cboFilter_Status"), String) & "'", "Null")) & ", NULL"
            CommonFunctions.Data.InsertOrUpdateData(strSQRY, True)
            strSQRY = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & CType(Session("intLoginType"), Integer) & "'," & m_intUserID & ",  " & CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET & ", 2, 'EmployeeID', 'Employee', 'F', " & CStr(IIf(CType(MyBase.GetFormValue("cboFilter_EmployeeID"), String) <> "", "'" & CType(MyBase.GetFormValue("cboFilter_EmployeeID"), String) & "'", "Null")) & ", NULL "
            CommonFunctions.Data.InsertOrUpdateData(strSQRY, True)
            strSQRY = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & CType(Session("intLoginType"), Integer) & "'," & m_intUserID & ",  " & CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET & ", 3, 'DateID', 'Date', 'F', " & CStr(IIf(CType(MyBase.GetFormValue("cboFilter_Date"), String) <> "", "'" & CType(MyBase.GetFormValue("cboFilter_Date"), String) & "'", "Null")) & ", NULL "
            CommonFunctions.Data.InsertOrUpdateData(strSQRY, True)
            strSQRY = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & CType(Session("intLoginType"), Integer) & "'," & m_intUserID & ",  " & CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET & ", 4, 'LastID', 'Last', 'F', " & CStr(IIf(CType(MyBase.GetFormValue("cboFilter_Last"), String) <> "", "'" & CType(MyBase.GetFormValue("cboFilter_Last"), String) & "'", "Null")) & ", NULL "
            CommonFunctions.Data.InsertOrUpdateData(strSQRY, True)
            strSQRY = "Exec usp_Ins_tbl_UI_UserPreferences  " & m_intUserID & ",'" & CType(Session("intLoginType"), Integer) & "','SORTBY','" & CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET & "','" & CType(Request("sortby"), String) & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQRY, True)
            strSQRY = "Exec usp_Ins_tbl_UI_UserPreferences  " & m_intUserID & ",'" & CType(Session("intLoginType"), Integer) & "','SORTORDER','" & CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET & "','" & CType(Request("sortorder"), String) & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQRY, True)
        End If
        If Not Page.IsPostBack Then
            strSQRY = "Exec usp_Sel_tbl_UI_EmployeeFilterSettings_FieldDetails_TimesheetApproval " & m_intUserID & ", " & CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET & ",2,'" & CType(Session("intLoginType"), Integer) & "'"
            m_intFilterEmployeeID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQRY, True)))
            strSQRY = "Exec usp_Sel_tbl_UI_EmployeeFilterSettings_FieldDetails_TimesheetApproval " & m_intUserID & ", " & CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET & ",1,'" & CType(Session("intLoginType"), Integer) & "'"
            m_strFilterStatusCode = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQRY, True)))
            strSQRY = "Exec usp_Sel_tbl_UI_EmployeeFilterSettings_FieldDetails_TimesheetApproval " & m_intUserID & ", " & CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET & ",3,'" & CType(Session("intLoginType"), Integer) & "'"
            m_strFilterDateID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQRY, True)))
            strSQRY = "Exec usp_Sel_tbl_UI_EmployeeFilterSettings_FieldDetails_TimesheetApproval " & m_intUserID & ", " & CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET & ",4,'" & CType(Session("intLoginType"), Integer) & "'"
            m_strFilterLast = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQRY, True)))

            strSQRY = "Exec usp_Sel_tbl_UI_UserPreferences " & m_intUserID & ",'" & CType(Session("intLoginType"), Integer) & "',null,'" & CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET & "'"
            drFilterValues = CommonFunctions.Data.GetDataReader(strSQRY, True)
            While drFilterValues.Read
                If CStr(drFilterValues("Identifier")).ToUpper = "SORTBY" Then
                    m_sortby = CStr(drFilterValues("Value"))
                ElseIf CStr(drFilterValues("Identifier")).ToUpper = "SORTORDER" Then
                    m_sortorder = CStr(drFilterValues("Value"))
                End If
            End While

        Else
            m_intFilterEmployeeID = CType(MyBase.GetFormValue("cboFilter_EmployeeID"), String)
            m_strFilterStatusCode = CType(MyBase.GetFormValue("cboFilter_Status"), String)
            m_strFilterDateID = CType(MyBase.GetFormValue("cboFilter_Date"), String)
            m_strFilterLast = CType(MyBase.GetFormValue("cboFilter_Last"), String)

            m_sortby = CType(Request("sortby"), String)
            m_sortorder = CType(Request("sortorder"), String)
        End If
        If CStr(Request.QueryString("Verify")) <> "" Then
            m_blnVerify = CType(Request.QueryString("Verify"), Boolean)
        Else
            m_blnVerify = False
        End If

        '' START : Added By ParagD On 18-Sept-2006
        m_strTokenForApproveLink = CommonFunctions.Security.Token.GetToken("0" + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagTimesheetApproval, String))
        '' END : Added By ParagD On 18-Sept-2006

    End Sub

#End Region

#Region " DataBase Functions"

    Private Sub DBProcess()
        '=====================================================================
        ' Procedure Name        : DBProcess()	
        ' Purpose               : To Approve timesheet
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : 02/08/2005
        ' Revisions             :
        '=====================================================================
        If m_blnVerify = True Then
            Dim intVerifiedBy As Integer
            Dim intCount As Integer
            Dim intCtr As Integer
            Dim intTimesheetID As Integer
            Dim intDailyActivityID As Integer

            Dim drVerify As IDataReader
            Dim drResourceTimesheetstatus As IDataReader
            Dim m_drTimesheet As IDataReader
            Dim m_drActivites As IDataReader

            Dim strVerifiedActivities As String
            Dim strSQLQuery As String
            Dim strRemarks As String
            Dim intVerified As Integer
            Dim dtVerificationDate As String

            Dim arrVerifiedActivities As String()
            Dim arrVerifiedActivitiesLength As Integer

            Dim strFromDate As String
            Dim strToDate As String
            Dim dblTotalExtraAMH As Double
            Dim dblTotalAMH As Double

            'Variables for sending E-mail
            Dim drEmailMessage As IDataReader
            Dim drResource As IDataReader
            Dim blnSendEmail As Boolean
            Dim blnShowPopup As Boolean
            Dim strOnloadClientScript As String
            Dim strFromEmailID As String
            Dim strToEmailID As String
            Dim strCCToEmailID As String
            Dim strSubject As String
            Dim strEmailMessage As String
            Dim strMessage As String
            Dim strResourceID As String

            dtVerificationDate = CType(Now(), String)

            intVerifiedBy = CType(Session("intUserID"), Integer)

            strVerifiedActivities = CType(MyBase.GetFormValue("chkApprove"), String)
            If strVerifiedActivities <> "" Then
                arrVerifiedActivities = Split(strVerifiedActivities, ",")
            End If

            If Not IsNothing(arrVerifiedActivities) Then
                arrVerifiedActivitiesLength = arrVerifiedActivities.Length
            Else
                arrVerifiedActivitiesLength = 0
            End If

            For intCount = 0 To arrVerifiedActivitiesLength - 1
                intTimesheetID = CType(arrVerifiedActivities(intCount), Integer)

                '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                '' m_strToken = Request.QueryString("PKToken") & ""
                If (CommonFunctions.Security.Token.ValidateToken("0" + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagTimesheetApproval, String), m_strTokenForApproveLink) = True) Then
                    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197

                    strSQLQuery = "usp_Sel_ResourceTimesheetDADetails " & intTimesheetID & "," & CType(Session("intUserID"), String)

                    m_drTimesheet = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    'Get Activity record details for the resource timesheet
                    Do While m_drTimesheet.Read()
                        ' RajkumarM 6th Oct 2008
                        If CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("IsDisabled"), "0"), Integer) = "0" Then
                            ' RajkumarM 6th Oct 2008
                            strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("FromDate"), CType(Now(), String)), String)
                            strToDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("ToDate"), CType(Now(), String)), String)
                            intDailyActivityID = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0"), Integer)
                            intVerified = 1
                            strRemarks = ""

                            '--- Execute sp to update verification details to Daily Activity Table
                            strSQLQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intDailyActivityID, String) + "," + CType(intVerified, String)
                            strSQLQuery = strSQLQuery + "," + CType(intVerifiedBy, String) + ",'" + CType(dtVerificationDate, String) + "','" + strRemarks + "'"

                            'm_drActivites = 
                            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            ' RajkumarM 6th Oct 2008
                        End If
                        ' RajkumarM 6th Oct 2008
                    Loop
                    CommonFunction.Data.DisposeDataReader(m_drTimesheet)
                    'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                    strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " & intTimesheetID & "," & CType(intVerifiedBy, String) & "," & "'V'"

                    drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    CommonFunctions.Data.DisposeDataReader(drVerify)


                    'If Resource TimeSheet are verified then change the status to 'verified' 
                    strSQLQuery = "Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus " & CType(intTimesheetID, String)
                    drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    If drVerify.Read = False Then
                        strSQLQuery = "Exec usp_Upd_ResouceTimesheetStatus " & CType(intTimesheetID, String) & ",'V'"
                        drResourceTimesheetstatus = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        CommonFunctions.Data.DisposeDataReader(drResourceTimesheetstatus)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drVerify)

                    'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
                    'strSQLQuery = "SELECT EmployeeID FROM tbl_PM_ResourceTimesheet WHERE TimesheetID = " & intTimesheetID
                    strSQLQuery = "usp_tbl_PM_ResourceTimesheet_EmployeeID " & intTimesheetID
                    'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
                    drResource = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drResource.Read Then
                        strResourceID = CType(drResource("EmployeeID"), String)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drResource)

                    strSQLQuery = "usp_Sel_tbl_PM_EmailMessages 427"
                    drEmailMessage = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    If drEmailMessage.Read Then
                        blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                        blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drEmailMessage)

                    ' Check if the mail has to be sent.
                    If blnSendEmail = True Then
                        ' Check if a popup message has to be shown.
                        If blnShowPopup = True Then
                            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                            CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=435&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(strResourceID, String) + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                            ' Else, if the mail has to be sent silently, then...
                        Else

                            'TO DO: SEND EMAIL MESSAGE WITH CC
                            'CommonFunction.EmailMessages.PMMessages. CRMMessages.GetEmailMessage_45(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intVerifiedBy, m_strEmployeeID)
                            ''Commented and added by Nilesh G on 25/11/2016 Purpose:Email Crash 
                            '' CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strMessage, intVerifiedBy, CType(Request.QueryString("EmployeeID"), Integer), CType(strFromDate, Date), CType(strToDate, Date))
                            CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strMessage, intVerifiedBy, strResourceID, CType(strFromDate, Date), CType(strToDate, Date))
                            Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage)
                        End If
                    End If

                    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                Else
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Timesheet Approval", m_TagTimesheetApproval, 0, "Timesheet ID", CType(intTimesheetID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
                '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
            Next
        End If
    End Sub

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
        ' Author                : HarshK
        ' Created               : 02/08/2005
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
#End Region

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strStatus As String
        'Start_AJ_16-Oct-2006
        'Addition by SnehalV 2nd Nov 2006 for WhizibleSEM SP8 integration
        Dim m_strTempToken As String = ""
        'End of addition by SnehalV
        'End_AJ_16-Oct-2006
        strStatus = CType(Args.DataReader.Item("statuscode"), String)
        If Args.ColumnName.ToUpper = "EMPLOYEE NAME" Then
            If strStatus = "N" Or strStatus = "J" Then
                Args.StringToBeInserted = "<TD Align='Left'> " + CType(Args.DataReader.Item("EmployeeName"), String) + "</TD>"
            Else
                'Start_AJ_16-Oct-2006
                'Addition by SnehalV 2nd Nov 2006 for WhizibleSEM SP8 integration
                m_strTempToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("TimesheetID"), String) + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagTimesheetApproval, String))
                m_strTSIDs += Args.DataReader("TimesheetID").ToString + ","
                m_strTSIDsWithToken += Args.DataReader("TimesheetID").ToString + "+" + Args.DataReader("EmployeeID").ToString + "+" + Args.DataReader("StatusCode").ToString + "+" + m_strTempToken + "#"
                'End of addition by SnehalV
                'End_AJ_16-Oct-2006

                '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                m_strToken = ""
                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("TimesheetID"), String) + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagTimesheetApproval, String))
                ''Args.StringToBeInserted = "<TD Align='Left'> <a href=../RT/RT_VerifyResourceTimesheetDetails.aspx?TimesheetID=" + CType(Args.DataReader.Item("TimesheetID"), String) + "&EmployeeID=" + CType(Args.DataReader.Item("EmployeeID"), String) + "&TimesheetStatus=" + CType(strStatus, String) + ">" + CType(Args.DataReader.Item("EmployeeName"), String) + " </a> </TD>"
                ''cOMMENTED AND ADDED BY nIESH G ON 9/8/2016 PURPOSE : PAGE CRASH
                ''Args.StringToBeInserted = "<TD Align='Left'> <a href=../RT/RT_VerifyResourceTimesheetDetails.aspx?TimesheetID=" + CType(Args.DataReader.Item("TimesheetID"), String) + "&EmployeeID=" + CType(Args.DataReader.Item("EmployeeID"), String) + "&TimesheetStatus=" + CType(strStatus, String) + "&PKToken=" + m_strToken + "&TagID=" + CType(m_TagTimesheetApproval, String) + ">" + CType(Args.DataReader.Item("EmployeeName"), String) + " </A> </TD>"
                Args.StringToBeInserted = "<TD Align='Left'> <a href=../RT/RT_VerifyResourceTimesheetDetails.aspx?TimesheetID=" + CType(Args.DataReader.Item("TimesheetID"), String) + "&EmployeeID=" + CType(Args.DataReader.Item("EmployeeID"), String) + "&TimesheetStatus=" + CType(strStatus, String) + "&PKToken=" + m_strToken + "&TagID=" + CType(m_TagTimesheetApproval, String) + ">" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("EmployeeName"), ""), String) + " </A> </TD>"
                '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
            End If
            Cancel = True
        End If

        '''' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
        ''If Args.ColIndex = 0 Then
        ''    m_strTokenForApproveLink = CommonFunctions.Security.Token.GetToken("0" + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagTimesheetApproval, String))
        ''End If
        '''' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197

        If Args.ColumnName.ToUpper = MyBase.GetResourceString("VERIFY").ToUpper Then
            strStatus = CType(Args.DataReader("StatusCode"), String)
            Select Case strStatus
                Case "V", "J", "N"
                    Args.IsCheckBoxDisabled = True
            End Select
            m_intTotalRecord = m_intTotalRecord + 1
        End If

    End Sub
End Class
