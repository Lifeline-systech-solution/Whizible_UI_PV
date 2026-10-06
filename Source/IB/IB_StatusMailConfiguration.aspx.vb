Public Class IB_StatusMailConfiguration
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

#Region " Constants Used in the Class "
    Protected Const ACTION_SAVE As String = "Save"

    Private Enum MenuIndex
        SAVE
        CLOSE
        HELP
    End Enum
#End Region

#Region " Class scope Variables Declarations "
    Private WithEvents m_objStatusGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objResourceGrid As New WebPages.Template.GenericGrid
    'Menu
    Private m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(2) As String
    Private m_arrMenuTooltip(2) As String
    Private m_arrClientSideFunctions(2) As String

    Private m_strPageTitle As String = ""
    Private m_strNbyA As String = ""
    Protected m_strAction As String = ""
    Private m_strPageNumber As String = ""
    Private m_lngProjectId As Long = 0
    Protected m_strProjectIssueType As String = ""
    Private m_strProjectIssueStatus As String = ""
    Private m_lngProjectIssueTypeMailId As Long = 0
    Private m_strMailToEmployeeIdList As String = ","
    Private m_strMailCcToEmployeeIdList As String = ","
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        InitPageMenu()
        m_lngProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intProjectID"), "0"), Long)
        m_strPageTitle = CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("PAGE_TITLE"))
        m_strNbyA = CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("NBYA"))
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))
        m_strPageNumber = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidPageNumber"))
        m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
        If m_strPageNumber = "" Then m_strPageNumber = "-1"
        GetMailConfigurationDetails()

        If m_strAction = ACTION_SAVE Then
            SaveMailConfiguration()
        End If
    End Sub

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.IB_StatusMailConfiguration", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "IB_StatusMailConfiguration : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objStatusGrid = Nothing
        m_objResourceGrid = Nothing
        m_objMenu = Nothing
    End Sub

    Private Sub InitPageMenu()
        '=====================================================================
        ' Procedure Name        : InitPageMenu
        ' Purpose               : This procedure Initiats the arrays required to display the Menu items.
        ' Description           :                 
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Jayavant
        ' Created               : 8-Mar-2004
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('IB_MAIL_CONFIGURATION')"

        MyBase.InitializeResources("AppResources.IB_StatusMailConfiguration", "AppResources")
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Public Sub WritePage()
        Dim strMenu As String = ""
        Dim strPageCaption As String = ""

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<Br>")

        'Display the Page Caption
        strPageCaption = MyBase.GetResourceString("ISSUE_TYPE") & ": " & Server.HtmlEncode(m_strProjectIssueType)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, m_strPageTitle, strPageCaption, , True))
        CommonFunctions.General.WriteHTML("<br>")

        'Display the Status and Resource Lists
        If m_strProjectIssueStatus <> "" Then
            Display_StatusList()
            CommonFunctions.General.WriteHTML("<br>")
        End If
        Display_ResourceList()

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<Br>")
        CommonFunctions.General.WriteHTML(strMenu)

        'Put the Hidden field controls

        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidProjectIssueType", "txthidProjectIssueType", value:=m_strProjectIssueType, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidProjectIssueStatus", "txthidProjectIssueStatus", value:=m_strProjectIssueStatus, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidMailToEmployeeIDList", "txthidMailToEmployeeIDList", value:=m_strMailToEmployeeIdList, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidMailCCToEmployeeIDList", "txthidMailCCToEmployeeIDList", value:=m_strMailCcToEmployeeIdList, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidPageNumber", "txthidPageNumber", value:=m_strPageNumber, IsHidden:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
    End Sub

    Private Sub Display_StatusList()
        '=====================================================================
        ' Procedure Name        : Display_StatusList
        ' Purpose               : This procedure displayes the list of project type status.
        ' Description           : To display the List, Generic Grid is used.                  
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Jayavant
        ' Created               : 9-Mar-2004
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String = ""
        Dim arrActualColumns() As String = {"Status", "ProjectTypeStatusID"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("STATUS"), MyBase.GetResourceString("SEND")}
        Dim arrCheckboxId() As String = {"", "chkIssueStatus"}
        Dim arrRowLink() As String = {"ConfigureMails_OnClick('Status')", ""}
        Dim arrstrTDStyle() As String = {"align='left'", "align='center' width='50'"}

        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECT_STATUS_VALUES_FOR_NOTIFICATION"))
        strQuery = "Exec usp_Sel_tbl_IB_Project_Type_Status " & m_lngProjectId.ToString()
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strProjectIssueType) & "'"
        With m_objStatusGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckboxId
            .RowLinkArray = arrRowLink
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "ProjectTypeStatusID"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divListStatus"
            .DIVHeight = 120
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = 1
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub Display_ResourceList()
        '=====================================================================
        ' Procedure Name        : Display_ResourceList
        ' Purpose               : This procedure displayes the list of Resources for the Project.
        ' Description           : To display the List, Generic Grid is used.
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Jayavant
        ' Created               : 9-Mar-2004
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String = ""
        Dim strPageAlphbets As String = ""
        Dim arrActualColumns() As String = {"ResourceType", "UserName", "EmailID", "Role", "", ""}
        Dim arrUserFriendlyColumn() As String = {"", MyBase.GetResourceString("RESOURCE"), _
                                                 MyBase.GetResourceString("EMAIL_ID"), _
                                                 MyBase.GetResourceString("ROLE"), _
                                                 MyBase.GetResourceString("TO"), _
                                                 MyBase.GetResourceString("CC")}
        Dim arrCheckboxId() As String = {"", "", "", "", "chkMailToEmployeeID", "chkMailCCToEmployeeID"}
        Dim arrstrTDStyle() As String = {"", "align='left'", "align='left'", "align='left'", "align='center' width='40'", "align='center' width='40'"}
        Dim arrGroupOnColumn() As String = {"1"}

        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECT_RESOURCE_FOR_NOTIFICATION"))

        'Display the Paging Letters
        strQuery = "Exec usp_Sel_tbl_IB_IssueBaseMails_EmployeeList_Paging " & m_lngProjectId.ToString() & ", NULL, NULL, NULL"
        strPageAlphbets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, strQuery, MyBase.GetResourceString("SELECT"), , "PageAlphabets", True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, strPageAlphbets, "", , True))
        CommonFunctions.General.WriteHTML("<br>")

        strQuery = "Exec usp_Sel_tbl_IB_IssueBaseMails_EmployeeList " & m_lngProjectId.ToString()
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"
        With m_objResourceGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckboxId
            .GroupOnColumn = arrGroupOnColumn
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "EmployeeID"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divListResources"
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = 4
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub GetMailConfigurationDetails()
        '=====================================================================
        ' Procedure Name        : GetMailConfigurationDetails
        ' Purpose               : This procedure Get the Issue Type and configured list details.
        ' Description           : If the Page is submitted to itself then get details from Form cntrols, else
        '                           get the details from database.                                
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Jayavant
        ' Created               : 9-Mar-2004
        ' Revisions             :
        '=====================================================================

        Dim strQuery As String = ""
        Dim strQuery1 As String = ""
        Dim drMailConfiguration As IDataReader
        '''''''''''''''''''''''''''''''''''''''''''''''Added By Dipali V On 27th Sep 2021 For Sonata BST Issue
        Dim drStatus As IDataReader
        Dim Used As String = ""
        m_strProjectIssueType = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectIssueType")).Trim()
        If m_strProjectIssueType <> "" Then
            m_strProjectIssueType = CommonFunctions.General.UnBuildQueryString(m_strProjectIssueType)
        Else
            m_strProjectIssueType = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidProjectIssueType")).Trim()
            m_strProjectIssueType = CommonFunctions.General.UnBuildQueryString(m_strProjectIssueType)
        End If

        strQuery1 = "usp_Sel_tbl_IB_Project_Type_Status " + m_lngProjectId.ToString() + ",'" + m_strProjectIssueType + "'"
        drStatus = CommonFunctions.Data.GetDataReader(strQuery1, MyBase.UseSQL)
        Dim IsStatusExixts As String = ""
        If CommonFunctions.General.CheckIsNothing(drStatus) <> "" Then
            'If drStatus.Read() Then
            Do While drStatus.Read
                m_strProjectIssueStatus = CommonFunctions.General.CheckIsNothing(drStatus.Item("Status")).Trim()
                Used = CommonFunctions.General.CheckIsNothing(drStatus.Item("Used")).Trim()
                If IsStatusExixts = "" Then
                    If Used = 1 Then
                        IsStatusExixts = 1
                        m_strProjectIssueStatus = m_strProjectIssueStatus
                    Else
                        m_strProjectIssueStatus = ""
                    End If
                End If

            Loop
        End If
        '''''''''''''''''''''''''''''''''''''''''''''''End of Added By Dipali V On 27th Sep 2021 For Sonata BST Issue
        ' When this page is called for the first time, retrieve the values from the QueryString/RecordSet.
        If Page.IsPostBack = False Then
            ' Get the Issue Type for which the mail is being configured.
            m_strProjectIssueType = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectIssueType")).Trim()
            m_strProjectIssueType = CommonFunctions.General.UnBuildQueryString(m_strProjectIssueType)
            ' Get the Issue Status for which the mail is being configured.
            '''''''''''''''''''''''''''''''''''''''''''''''Added By Dipali V On 27th Sep 2021 For Sonata BST Issue
            If m_strProjectIssueStatus = "" Then
                m_strProjectIssueStatus = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectIssueStatus")).Trim()
                m_strProjectIssueStatus = CommonFunctions.General.UnBuildQueryString(m_strProjectIssueStatus)
            End If
            '''''''''''''''''''''''''''''''''''''''''''''''End of Added By Dipali V On 27th Sep 2021 For Sonata BST Issue


            strQuery = "Exec usp_Sel_tbl_IB_IssueBaseMails NULL, " & m_lngProjectId.ToString()
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strProjectIssueType) & "'"
            If m_strProjectIssueStatus <> "" Then
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strProjectIssueStatus) & "'"
            End If
            drMailConfiguration = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drMailConfiguration) <> "" Then
                If drMailConfiguration.Read() Then
                    m_lngProjectIssueTypeMailId = CType(CommonFunctions.Data.CheckIsDBNull(drMailConfiguration.Item("ProjectIssueTypeMailID"), "0"), Long)
                    m_strMailToEmployeeIdList = CommonFunctions.General.CheckIsNothing(drMailConfiguration.Item("MailToEmployeeIDList")).Trim()
                    m_strMailToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailToEmployeeIdList)
                    m_strMailCcToEmployeeIdList = CommonFunctions.General.CheckIsNothing(drMailConfiguration.Item("MailCCToEmployeeIDList")).Trim()
                    m_strMailCcToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailCcToEmployeeIdList)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drMailConfiguration)
            m_strPageNumber = "-1"
        Else
            ' Get the Issue Type for which the mail is being configured.
            m_strProjectIssueType = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidProjectIssueType")).Trim()
            m_strProjectIssueType = CommonFunctions.General.UnBuildQueryString(m_strProjectIssueType)
            ' Get the Issue Status for which the mail is being configured.
            m_strProjectIssueStatus = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidProjectIssueStatus")).Trim()
            m_strProjectIssueStatus = CommonFunctions.General.UnBuildQueryString(m_strProjectIssueStatus)
            ' Get the previously configured employee ID list.
            m_strMailToEmployeeIdList = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidMailToEmployeeIDList")).Trim()
            m_strMailToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailToEmployeeIdList)
            m_strMailCcToEmployeeIdList = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidMailCCToEmployeeIDList")).Trim()
            m_strMailCcToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailCcToEmployeeIdList)
            'Get the Page Number
            m_strPageNumber = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidPageNumber")).Trim()
            m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
        End If
    End Sub

    Private Sub SaveMailConfiguration()
        '=====================================================================
        ' Procedure Name        : SaveMailConfiguration
        ' Purpose               : This procedure Save the mail configurations in the database.
        ' Description           :                      
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Jayavant
        ' Created               : 9-Mar-2004
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String = ""
        Dim intCtr As Integer = 0
        Dim strProjectTypeStatusIds As String = ""
        'Added By Dipali V On 24th Sep 2021 For Status ID 
        Dim SelectedIssuesstatus As String = ""
        'End of Added By Dipali V On 24th Sep 2021 For Status ID 
        Dim arrSelectedIssuesstatus() As String
        Dim arrProjectTypeStatusId() As String
        Dim strChecked_ProjectTypeStatusId As String = ""

        strProjectTypeStatusIds = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidProjectTypeStatusID"))
        If strProjectTypeStatusIds <> "" Then
            strChecked_ProjectTypeStatusId = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkIssueStatus"))
            arrProjectTypeStatusId = strProjectTypeStatusIds.Split(CType(",", Char))
            ' For each Status value of the selected Type, set/reset the "Send Mail" flag.		
            For intCtr = 0 To arrProjectTypeStatusId.Length - 1
                If InStr("," & strChecked_ProjectTypeStatusId, arrProjectTypeStatusId(intCtr), CompareMethod.Text) > 0 Then
                    'Added By Dipali V On 24th Sep 2021 For Status ID 
                    If SelectedIssuesstatus <> "" Then
                        SelectedIssuesstatus += "," + arrProjectTypeStatusId(intCtr)
                    Else
                        SelectedIssuesstatus = arrProjectTypeStatusId(intCtr)
                    End If
                    'End of Added By Dipali V On 24th Sep 2021 For Status ID 
                    strQuery = "Exec usp_Upd_tbl_IB_Project_Type_Status_SendMailStatus " & arrProjectTypeStatusId(intCtr) & ", 1"
                Else
                    strQuery = "Exec usp_Upd_tbl_IB_Project_Type_Status_SendMailStatus " & arrProjectTypeStatusId(intCtr) & ", 0"
                End If
                ' Update the "Send Mail" status.
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            Next
        End If
        'Added By Dipali V On 24th Sep 2021 For Status ID 
        Dim NewSelectedIssuesstatus As String() = SelectedIssuesstatus.Split(New Char() {","c})
        For intCtr = 0 To NewSelectedIssuesstatus.Length - 1
            Dim Status As String = ""
            'If m_strProjectIssueStatus = "" Then
            m_strProjectIssueStatus = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_Whizible2_tbl_IB_Project_Type_Status_ForMail " + NewSelectedIssuesstatus(intCtr), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
            'Else
            '    m_strProjectIssueStatus = m_strProjectIssueStatus
            'End If
            strQuery = "Exec usp_Ins_tbl_IB_IssueBaseMails " & m_lngProjectId.ToString()
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strProjectIssueType) & "'"
            If m_strProjectIssueStatus <> "" Then
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strProjectIssueStatus) & "' "
            Else
                strQuery &= ", NULL "
            End If

            m_strMailToEmployeeIdList = Left(m_strMailToEmployeeIdList, 2000)
            If Right(m_strMailToEmployeeIdList, 1) <> "," Then
                m_strMailToEmployeeIdList = Left(m_strMailToEmployeeIdList, InStrRev(m_strMailToEmployeeIdList, ","))
            End If

            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strMailToEmployeeIdList) & "' "


            m_strMailCcToEmployeeIdList = Left(m_strMailCcToEmployeeIdList, 4000)
            If Right(m_strMailCcToEmployeeIdList, 1) <> "," Then
                m_strMailCcToEmployeeIdList = Left(m_strMailCcToEmployeeIdList, InStrRev(m_strMailCcToEmployeeIdList, ","))
            End If

            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strMailCcToEmployeeIdList) & "' "
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        Next
        'End of Added By Dipali V On 24th Sep 2021 For Status ID 


    End Sub

    Private Sub m_objStatusGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objStatusGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objStatusGrid_DataRowTD_BeforePrint
        ' Purpose               : This is the Event Handler for the Status grid. 
        ' Description           : Event Handled is "DataRowTD_BeforePrint"
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Jayavant
        ' Created               : 9-Mar-2004
        ' Revisions             :
        '=====================================================================
        Dim lngProjectTypeStatusId As Long = 0
        Dim strProjectTypeStatusIds As String = ""

        If Args.ColIndex = 0 Then
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("SendMail"), "False"), Boolean) = False Then
                Args.EnableLink = False
            End If

        ElseIf Args.ColIndex = 1 Then
            lngProjectTypeStatusId = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ProjectTypeStatusID"), "0"), Long)
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            Args.StringToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txthidProjectTypeStatusID", "txthidProjectTypeStatusID", value:=lngProjectTypeStatusId.ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
            If Page.IsPostBack = False Then
                ' If the mail configuration had been done earlier, then...
                If m_lngProjectIssueTypeMailId > 0 Then
                    ' Check or uncheck the status value depending on the recordset contents.
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("SendMail"), "False"), Boolean) = True Then
                        Args.IsCheckBoxChecked = True
                    End If
                Else
                    ' Check all the status values by default.
                    Args.IsCheckBoxChecked = True
                End If
            Else
                strProjectTypeStatusIds = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkIssueStatus"))
                If strProjectTypeStatusIds <> "" Then
                    strProjectTypeStatusIds = "," + strProjectTypeStatusIds + ","
                    If InStr(strProjectTypeStatusIds, "," & lngProjectTypeStatusId.ToString() & ",", CompareMethod.Text) > 0 Then
                        Args.IsCheckBoxChecked = True
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub m_objResourceGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objResourceGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objResourceGrid_DataRowTD_BeforePrint
        ' Purpose               : This is the Event Handler for the Resource grid. 
        ' Description           : Event Handled is "DataRowTD_BeforePrint"
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Jayavant
        ' Created               : 9-Mar-2004
        ' Revisions             :
        '=====================================================================
        Dim blnMailTo As Boolean = False
        Dim blnMailCCTo As Boolean = False
        Dim strEmployeeId As String = ""


        If Args.ColIndex = 0 Then
            Select Case Args.DataFieldValue.ToString().Trim().ToUpper()
                Case "C"
                    Args.DataFieldValue = MyBase.GetResourceString("CUSTOMER")
                Case "CC"
                    Args.DataFieldValue = MyBase.GetResourceString("CUSTOMER_CONTACTS")
                Case "CE"
                    Args.DataFieldValue = MyBase.GetResourceString("ORGANIZATION_CONTACTS")
                Case Else
                    Args.DataFieldValue = MyBase.GetResourceString("PROJECT_RESOURCES")
            End Select

        ElseIf Args.ColIndex = 4 Or Args.ColIndex = 5 Then
            If InStr("," & m_strMailToEmployeeIdList, "," & Trim(CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("EmployeeID"))) & ",", CompareMethod.Text) <> 0 Then
                blnMailTo = True
            ElseIf InStr("," & m_strMailCcToEmployeeIdList, "," & Trim(CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("EmployeeID"))) & ",", CompareMethod.Text) <> 0 Then
                blnMailCCTo = True
            End If
            'Get the Employee Id
            strEmployeeId = CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("EmployeeID"))
            Args.StringToBeInserted = "<TD align='center'>"
            If CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("EmailID")) = "" Then
                Args.StringToBeInserted &= m_strNbyA
            Else
                If blnMailTo = True Then
                    Args.IsCheckBoxChecked = True
                ElseIf blnMailCCTo = True Then
                    Args.IsCheckBoxDisabled = True
                End If
                If Args.ColIndex = 4 Then
                    Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkMailToEmployeeID", "chkMailToEmployeeID_" & strEmployeeId, , blnMailTo, strEmployeeId, blnMailCCTo, "onclick=""javascript:chkMailToList_OnClick('" & strEmployeeId & "')""", True)
                Else
                    Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkMailCCToEmployeeID", "chkMailCCToEmployeeID_" & strEmployeeId, , blnMailCCTo, strEmployeeId, blnMailTo, "onclick=""javascript:chkMailCCToList_OnClick('" & strEmployeeId & "')""", True)
                End If
            End If
            Args.StringToBeInserted &= "</TD>"
            Cancel = True
        End If
    End Sub

    Private Sub m_objResourceGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objResourceGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
        End If
    End Sub
End Class
