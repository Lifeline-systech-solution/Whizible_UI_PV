Option Strict Off
Public Class IB_SLAMailConfiguration
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmSLAConfigureMails As System.Web.UI.HtmlControls.HtmlForm

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
    Protected m_strProjectSLADetailID As String = ""
    Protected m_strAlert As String = ""
    Private m_strAlertBefore As String = ""
    Private m_strAlertBeforeUnit As String = ""
    Protected m_strNorm As String
    Protected m_strNormUnit As String

    Protected m_strProjectIssueType As String = ""
    'Private m_strProjectIssueStatus As String = ""
    Private m_lngProjectSLADetailId As Long = 0
    Private m_strMailToEmployeeIdList As String = ","
    Private m_strMailCcToEmployeeIdList As String = ","
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        InitPageMenu()
        m_lngProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intProjectID"), "0"), Long)

        m_strNbyA = CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("NBYA"))
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))
        m_strProjectSLADetailID = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectSLADetailID"))
        m_strAlert = CommonFunctions.General.CheckIsNothing(Request.QueryString("From"))
        m_strPageNumber = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidPageNumber"))
        m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
        If m_strAlert = "Alert" Then
            m_strPageTitle = CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("PAGE_TITLE_ALERT"))
        Else
            m_strPageTitle = CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("PAGE_TITLE_ESCALATION"))
        End If
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
        MyBase.InitializeResources("AppResources.IB_SLAMailConfiguration", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "IB_SLAMailConfiguration : " & UserInput & " " & Cause
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
        ' Author                : 
        ' Created               : 
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

        MyBase.InitializeResources("AppResources.IB_SLAMailConfiguration", "AppResources")
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Public Sub WritePage()
        Dim strMenu As String = ""
        Dim strPageCaption As String = ""
        Dim strQuery As String = ""
        Dim strPageAlphbets As String = ""
        'Display the Menu
        'strQuery = "Exec usp_Sel_tbl_PM_Employee_SLAEscalation_Paging  " & m_lngProjectId.ToString() & ", NULL, NULL, NULL"

        ' strQuery = "Exec usp_Sel_Project_EmployeeList_Paging  " & m_lngProjectId.ToString() & ", NULL, NULL, NULL"
        'strPageAlphbets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, strQuery, MyBase.GetResourceString("SELECT"), , "PageAlphabets", True)

        'strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, False, strPageAlphbets)
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, False, )

        'WebPages.Template.PageCaption.GetPageCaptions(Nothing, strPageAlphbets, strMenu)
        'WebPages.Template.PageCaption.GetPageCaptions(, strPageAlphabets, strMenu)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<Br>")

        'Display the Page Caption
        'commented by tone
        'strPageCaption = MyBase.GetResourceString("ISSUE_TYPE") & ": " & Server.HtmlEncode(m_strProjectIssueType)
        'Code Added by PradipK to add Norm name in Page Caption.
        Dim strNormName As String
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strNormName = CommonFunction.Data.GetDataScalar("select IsNULL(SLADetail,'')  from tbl_PM_ProjectSLADetails where ProjectSLADetailID='" + m_strProjectSLADetailID + "'", True)
        strNormName = CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_ProjectSLADetails '" + m_strProjectSLADetailID + "'", True)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'End Addition By PradipK
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, m_strPageTitle, "Norm :" + strNormName, , True))
        CommonFunctions.General.WriteHTML("<br>")
        Display_ResourceList()
        GetNormDetails()

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<Br>")
        CommonFunctions.General.WriteHTML(strMenu)

        'Put the Hidden field controls
        If m_strAlert = "Alert" Then
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidProjectSLANorm", "txthidProjectSLANorm", value:=m_strNorm, IsHidden:=True, EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txthidProjectNormUnit", "txthidProjectNormUnit", value:=m_strNormUnit, IsHidden:=True, EnableHTMLEncode:=True)
        End If
        CommonFunctions.HTMLControls.DrawTextBox("txthidMailToEmployeeIDList", "txthidMailToEmployeeIDList", value:=m_strMailToEmployeeIdList, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidMailCCToEmployeeIDList", "txthidMailCCToEmployeeIDList", value:=m_strMailCcToEmployeeIdList, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidPageNumber", "txthidPageNumber", value:=m_strPageNumber, IsHidden:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        ''''''''code for alert
        Dim drAlertConfigure As IDataReader
        ''''''''End of code for Alert
        Dim strQuery As String = ""
        Dim strPageAlphbets As String = ""
        Dim arrActualColumns() As String = {"UserName", "EmailID", "Role", "", ""}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("RESOURCE"), _
                                                 MyBase.GetResourceString("EMAIL_ID"), _
                                                 MyBase.GetResourceString("ROLE"), _
                                                 MyBase.GetResourceString("TO"), _
                                                 MyBase.GetResourceString("CC")}
        Dim arrCheckboxId() As String = {"", "", "", "chkMailToEmployeeID", "chkMailCCToEmployeeID"}
        Dim arrstrTDStyle() As String = {"align='left'", "align='left'", "align='left'", "align='center' width='40'", "align='center' width='40'"}
        'tone comment Dim arrGroupOnColumn() As String = {"1"}
        '''commnet for Alert by tone
        If m_strAlert = "Alert" Then

            strQuery = "Exec usp_Sel_tbl_PM_SLAAlert_Configure "
            strQuery &= "'" & CommonFunctions.General.BuildQueryString(m_strProjectSLADetailID) & "'"
            drAlertConfigure = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drAlertConfigure) <> "" Then
                If drAlertConfigure.Read() Then
                    m_strProjectSLADetailID = CType(CommonFunctions.Data.CheckIsDBNull(drAlertConfigure.Item("ProjectSLADetailID"), "0"), String)
                    m_strAlertBefore = CommonFunctions.General.CheckIsNothing(drAlertConfigure.Item("AlertBefore")).Trim()
                    m_strAlertBefore = CommonFunctions.General.UnBuildQueryString(m_strAlertBefore)
                    m_strAlertBeforeUnit = CommonFunctions.General.CheckIsNothing(drAlertConfigure.Item("AlertBeforeUnit")).Trim()
                    m_strAlertBeforeUnit = CommonFunctions.General.UnBuildQueryString(m_strAlertBeforeUnit)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drAlertConfigure)
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td ><font size=2>" & "Alert Before" & "</font></td>")
            CommonFunctions.General.WriteHTML("<td>")

            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtAlertBefore", "txtAlertBefore", "clsTextBox", 50, 5, m_strAlertBefore.ToString(), "Right", , , , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td >&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp<font size=2>" & "Alert Before Unit" & "</font></td>")
            CommonFunctions.General.WriteHTML("<td>")
            'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            'CommonFunctions.HTMLControls.DrawComboBox("cboAlertBeforeUnit", "SELECT 'Days' UNION SELECT 'Hours'", , m_strAlertBeforeUnit.ToString(), , True, False, "clsComboBox", True)
            CommonFunctions.HTMLControls.DrawComboBox("cboAlertBeforeUnit", "usp_sel_Days_Hours", , m_strAlertBeforeUnit.ToString(), , True, False, "clsComboBox", True)
            'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            CommonFunctions.General.WriteHTML("</td></tr>")
            CommonFunctions.General.WriteHTML("<tr><td rowspan=2>&nbsp</td></tr>")
            CommonFunctions.General.WriteHTML("<br>")
        End If
        '''End of comment for Alert
        'CommonFunctions.General.WriteHTML("<br>")
        'CommonFunctions.General.WriteHTML("<trclass='clsTREven'><td class='clsTDOdd'><font size=2>")
        'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECT_RESOURCE_FOR_NOTIFICATION"))
        'CommonFunctions.General.WriteHTML("</font></td></tr>")

        ''Display the Paging Letters
        ''strQuery = "Exec usp_sel_tbl_PM_Employee_SLAEscalation_Paging " & m_lngProjectId.ToString() & ", NULL, NULL, NULL"
        ''strPageAlphbets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, strQuery, MyBase.GetResourceString("SELECT"), , "PageAlphabets", True)
        ''CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, strPageAlphbets, "", , True))
        ''CommonFunctions.General.WriteHTML("<br>")

        'strQuery = "Exec usp_Sel_Project_EmployeeList  " & m_lngProjectId.ToString()
        'strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"
        'With m_objResourceGrid
        '    .UserFriendlyColumnArray = arrUserFriendlyColumn
        '    .ActualColumnArray = arrActualColumns
        '    .CheckBoxIDArray = arrCheckboxId
        '    .EmptyValueReplacement = "&nbsp;"
        '    .PrimaryKey = "EmployeeID"
        '    .SQL = strQuery
        '    .UseSQL = MyBase.UseSQL
        '    .DIVID = "divListResources"
        '    .DIVStyle = "overflow:auto;width:100%;"
        '    .NoOfDataColumns = 3
        '    .TDStyleArray = arrstrTDStyle
        '    .ColNameToolTipOnEachRow = True
        '    .returnHTML = True
        '    CommonFunctions.General.WriteHTML(.DrawGrid())
        'End With
    End Sub
    ''''''''''''''''''''commented by tonejoseph
    Private Sub GetMailConfigurationDetails()
        Dim strQuery As String = ""
        Dim drMailConfiguration As IDataReader

        ' When this page is called for the first time, retrieve the values from the QueryString/RecordSet.
        If Page.IsPostBack = False Then
            '''''''''Added for Alert by tone
            m_strAlert = CommonFunctions.General.CheckIsNothing(Request.QueryString("From")).Trim()
            m_strAlert = CommonFunctions.General.UnBuildQueryString(m_strAlert)
            '''''''''''End of Addition for alert by tone
            m_strProjectSLADetailID = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectSLADetailID")).Trim()
            m_strProjectSLADetailID = CommonFunctions.General.UnBuildQueryString(m_strProjectSLADetailID)
            ''''Added for Alert
            If m_strAlert = "Escalation" Then
                ''''End of Addition for alert
                strQuery = "Exec usp_Sel_tbl_PM_SLAEscalation_MailsConfigure "
                strQuery &= "'" & CommonFunctions.General.BuildQueryString(m_strProjectSLADetailID) & "'"
                drMailConfiguration = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drMailConfiguration) <> "" Then
                    If drMailConfiguration.Read() Then
                        m_strProjectSLADetailID = CType(CommonFunctions.Data.CheckIsDBNull(drMailConfiguration.Item("ProjectSLADetailID"), "0"), String)
                        m_strMailToEmployeeIdList = CommonFunctions.General.CheckIsNothing(drMailConfiguration.Item("EscalateTo")).Trim()
                        m_strMailToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailToEmployeeIdList)
                        m_strMailCcToEmployeeIdList = CommonFunctions.General.CheckIsNothing(drMailConfiguration.Item("EscalateCCTo")).Trim()
                        m_strMailCcToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailCcToEmployeeIdList)
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drMailConfiguration)
                m_strPageNumber = "-1"
                ''''code Added for Alert
            ElseIf m_strAlert = "Alert" Then
                strQuery = "Exec usp_Sel_tbl_PM_SLAAlert_Configure "
                strQuery &= "'" & CommonFunctions.General.BuildQueryString(m_strProjectSLADetailID) & "'"
                drMailConfiguration = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drMailConfiguration) <> "" Then
                    If drMailConfiguration.Read() Then
                        m_strProjectSLADetailID = CType(CommonFunctions.Data.CheckIsDBNull(drMailConfiguration.Item("ProjectSLADetailID"), "0"), String)
                        m_strMailToEmployeeIdList = CommonFunctions.General.CheckIsNothing(drMailConfiguration.Item("AlertTo")).Trim()
                        m_strMailToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailToEmployeeIdList)
                        m_strMailCcToEmployeeIdList = CommonFunctions.General.CheckIsNothing(drMailConfiguration.Item("AlertCCTo")).Trim()
                        m_strMailCcToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailCcToEmployeeIdList)
                        m_strAlertBefore = CommonFunctions.General.CheckIsNothing(drMailConfiguration.Item("AlertBefore")).Trim()
                        m_strAlertBefore = CommonFunctions.General.UnBuildQueryString(m_strAlertBefore)
                        m_strAlertBeforeUnit = CommonFunctions.General.CheckIsNothing(drMailConfiguration.Item("AlertBeforeUnit")).Trim()
                        m_strAlertBeforeUnit = CommonFunctions.General.UnBuildQueryString(m_strAlertBeforeUnit)
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drMailConfiguration)
                m_strPageNumber = "-1"
            End If
            '''''''End of code Addition for Alert
        Else
            ''''Added for Alert
            If m_strAlert = "Escalation" Then
                ''''End of Addition for alert
                m_strMailToEmployeeIdList = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidMailToEmployeeIDList")).Trim()
                m_strMailToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailToEmployeeIdList)
                m_strMailCcToEmployeeIdList = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidMailCCToEmployeeIDList")).Trim()
                m_strMailCcToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailCcToEmployeeIdList)
                'Get the Page Number
                m_strPageNumber = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidPageNumber")).Trim()
                m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
                ''''''''Added for Alert
            ElseIf m_strAlert = "Alert" Then
                m_strMailToEmployeeIdList = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidMailToEmployeeIDList")).Trim()
                m_strMailToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailToEmployeeIdList)
                m_strMailCcToEmployeeIdList = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidMailCCToEmployeeIDList")).Trim()
                m_strMailCcToEmployeeIdList = CommonFunctions.General.UnBuildQueryString(m_strMailCcToEmployeeIdList)
                m_strAlertBefore = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtAlertBefore")).Trim()
                m_strAlertBefore = CommonFunctions.General.UnBuildQueryString(m_strAlertBefore)
                m_strAlertBeforeUnit = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtAlertBeforeUnit")).Trim()
                m_strAlertBeforeUnit = CommonFunctions.General.UnBuildQueryString(m_strAlertBeforeUnit)
                'Get the Page Number
                m_strPageNumber = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidPageNumber")).Trim()
                m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
                ''''End of Addition for Alert
            End If
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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        If m_strAlert = "Escalation" Then
            Dim strQuery As String = ""
            Dim intCtr As Integer = 0

            strQuery = "Exec usp_Ins_tbl_PM_SLAEscalation " '& m_lngProjectId.ToString()
            ' Provide the Project Issue Type.
            strQuery &= "'" & CommonFunctions.General.BuildQueryString(m_strProjectSLADetailID) & "'"

            m_strMailToEmployeeIdList = Left(m_strMailToEmployeeIdList, 2000)
            If Right(m_strMailToEmployeeIdList, 1) <> "," Then
                m_strMailToEmployeeIdList = Left(m_strMailToEmployeeIdList, InStrRev(m_strMailToEmployeeIdList, ","))
            End If
            ' Provide the To: list.
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strMailToEmployeeIdList) & "' "

            ' Trim the Cc: List.
            m_strMailCcToEmployeeIdList = Left(m_strMailCcToEmployeeIdList, 4000)
            If Right(m_strMailCcToEmployeeIdList, 1) <> "," Then
                m_strMailCcToEmployeeIdList = Left(m_strMailCcToEmployeeIdList, InStrRev(m_strMailCcToEmployeeIdList, ","))
            End If
            ' Provide the Cc: list.
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strMailCcToEmployeeIdList) & "' "

            ' Save the configuration details.
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        ElseIf m_strAlert = "Alert" Then
            Dim strQuery As String = ""
            Dim intCtr As Integer = 0

            strQuery = "Exec usp_Ins_tbl_PM_SLAAlert " '& m_lngProjectId.ToString()
            ' Provide the Project Issue Type.
            strQuery &= "'" & CommonFunctions.General.BuildQueryString(m_strProjectSLADetailID) & "'"

            m_strMailToEmployeeIdList = Left(m_strMailToEmployeeIdList, 2000)
            If Right(m_strMailToEmployeeIdList, 1) <> "," Then
                m_strMailToEmployeeIdList = Left(m_strMailToEmployeeIdList, InStrRev(m_strMailToEmployeeIdList, ","))
            End If
            ' Provide the To: list.
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strMailToEmployeeIdList) & "' "

            ' Trim the Cc: List.
            m_strMailCcToEmployeeIdList = Left(m_strMailCcToEmployeeIdList, 4000)
            If Right(m_strMailCcToEmployeeIdList, 1) <> "," Then
                m_strMailCcToEmployeeIdList = Left(m_strMailCcToEmployeeIdList, InStrRev(m_strMailCcToEmployeeIdList, ","))
            End If
            ' Provide the Cc: list.
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strMailCcToEmployeeIdList) & "' "
            m_strAlertBefore = MyBase.GetFormValue("txtAlertBefore")
            m_strAlertBefore = CommonFunctions.General.UnBuildQueryString(m_strAlertBefore)
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strAlertBefore) & "' "
            m_strAlertBeforeUnit = MyBase.GetFormValue("cboAlertBeforeUnit")
            m_strAlertBeforeUnit = CommonFunctions.General.UnBuildQueryString(m_strAlertBeforeUnit)
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strAlertBeforeUnit) & "' "
            ' Save the configuration details.
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim blnMailTo As Boolean = False
        Dim blnMailCCTo As Boolean = False
        Dim strEmployeeId As String = ""
        If m_strAlert = "Escalation" Then
            If Args.ColIndex = 3 Or Args.ColIndex = 4 Then
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
                    If Args.ColIndex = 3 Then
                        Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkMailToEmployeeID", "chkMailToEmployeeID_" & strEmployeeId, , blnMailTo, strEmployeeId, blnMailCCTo, "onclick=""javascript:chkMailToList_OnClick('" & strEmployeeId & "')""", True)
                    Else
                        Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkMailCCToEmployeeID", "chkMailCCToEmployeeID_" & strEmployeeId, , blnMailCCTo, strEmployeeId, blnMailTo, "onclick=""javascript:chkMailCCToList_OnClick('" & strEmployeeId & "')""", True)
                    End If
                End If
                Args.StringToBeInserted &= "</TD>"
                Cancel = True
            End If
        ElseIf m_strAlert = "Alert" Then
            If Args.ColIndex = 3 Or Args.ColIndex = 4 Then
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
                    If Args.ColIndex = 3 Then
                        Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkMailToEmployeeID", "chkMailToEmployeeID_" & strEmployeeId, , blnMailTo, strEmployeeId, blnMailCCTo, "onclick=""javascript:chkMailToList_OnClick('" & strEmployeeId & "')""", True)
                    Else
                        Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkMailCCToEmployeeID", "chkMailCCToEmployeeID_" & strEmployeeId, , blnMailCCTo, strEmployeeId, blnMailTo, "onclick=""javascript:chkMailCCToList_OnClick('" & strEmployeeId & "')""", True)
                    End If
                End If
                Args.StringToBeInserted &= "</TD>"
                Cancel = True
            End If
        End If
    End Sub

    'Private Sub m_objResourceGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objResourceGrid.ColumnHeaderTD_BeforePrint
    '    If Args.ColIndex = 0 Then
    '        Args.ColumnName = ""
    '    End If
    'End Sub
    Private Sub GetNormDetails()
        Dim strQuery As String = ""
        Dim drNormDetails As IDataReader
        m_strAlert = CommonFunctions.General.CheckIsNothing(Request.QueryString("From")).Trim()
        m_strAlert = CommonFunctions.General.UnBuildQueryString(m_strAlert)
        '''''''''''End of Addition for alert by tone
        m_strProjectSLADetailID = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectSLADetailID")).Trim()
        m_strProjectSLADetailID = CommonFunctions.General.UnBuildQueryString(m_strProjectSLADetailID)
        ''''Added for Alert
        If m_strAlert = "Alert" Then
            ''''End of Addition for alert
            strQuery = "Exec usp_sel_tbl_PM_ProjectSLADetails_GetNorms"
            strQuery &= "'" & CommonFunctions.General.BuildQueryString(m_strProjectSLADetailID) & "'"
            drNormDetails = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drNormDetails) <> "" Then
                If drNormDetails.Read() Then
                    m_strNorm = CType(CommonFunctions.General.CheckIsNothing(drNormDetails.Item("NORM")), String)
                    m_strNorm = CommonFunctions.General.UnBuildQueryString(m_strNorm)
                    m_strNormUnit = CommonFunctions.General.CheckIsNothing(drNormDetails.Item("UNIT")).Trim()
                    m_strNormUnit = CommonFunctions.General.UnBuildQueryString(m_strNormUnit)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drNormDetails)
        End If
    End Sub
End Class
