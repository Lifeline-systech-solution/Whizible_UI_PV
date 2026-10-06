Public Class PM_UpdateEmployeeSkills
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
    Protected Const MODE_UPDATE_SKILLS As String = "UpdateSkills"
    Protected Const MODE_RELEASE As String = "Release"

    Private Enum MenuIndex
        SAVE
        UPDATE_SKILLS_AND_RELEASE_RESOURCES
        CLOSE
        HELP
    End Enum
#End Region

#Region " Class scope Variables Declarations "
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    
    Private m_arrMenuItem(3) As String
    Private m_arrMenuTooltip(3) As String
    Private m_arrClientSideFunctions(3) As String

    Protected m_strClientSideScript As String = ""

    Protected m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_lngTagId As Long = 0
    Private m_lngProjectId As Long = 0
    Private m_strPageTitle As String = ""
    Private m_strStartDate As String = ""
    Private m_intYearsToBeShown As Integer = 0
    Private m_intMonthsToBeShown As Integer = 0
    Private m_lngEmployeeId As Long = 0
    Private m_strUserName As String = ""
    Private m_strEmployeeName As String = ""
    Private m_strRoleDescription As String = ""

    Private m_intTotalDays As Integer = 0
    Private m_intEmployeeYears As Integer = 0
    Private m_intEmployeeMonths As Integer = 0
    Private m_intEmployeeDays As Integer = 0
    Protected m_lngProjectEmployeeRoleId As Long = 0
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        InitPageMenu()

        m_lngProjectId = m_objGlobal.ProjectID
        m_lngTagId = m_objGlobal.TagID
        m_strPageTitle = MyBase.GetResourceString("UPDATE_SKILLS")
        m_lngProjectEmployeeRoleId = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectEmployeeRoleID")), Long)
        m_strMode = "" & CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        If m_strMode = "" Then m_strMode = MODE_RELEASE
        m_strAction = "" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidAction"))
        If m_strAction = ACTION_SAVE Then
            m_strClientSideScript = ""
            UpdateSkills()
            If m_strMode = MODE_RELEASE Then
                ReleaseResource()
            End If
            m_strClientSideScript &= "window.close();"
        End If
   End Sub

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()        
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.PM_UpdateEmployeeSkills", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PM_UpdateEmployeeSkills : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.UPDATE_SKILLS_AND_RELEASE_RESOURCES) = MyBase.GetResourceString("MENU_PM_UPDATE_SKILLS_AND_RELEASE_RES")
        m_arrMenuTooltip(MenuIndex.UPDATE_SKILLS_AND_RELEASE_RESOURCES) = MyBase.GetResourceString("MENU_PM_UPDATE_SKILLS_AND_RELEASE_RES_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.UPDATE_SKILLS_AND_RELEASE_RESOURCES) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('USFRS')"

        MyBase.InitializeResources("AppResources.PM_UpdateEmployeeSkills", "AppResources")
    End Sub

    Public Sub WritePage()
        Dim drWork As IDataReader
        Dim strQuery As String = ""
        Dim blnHasEmpRecord As Boolean = False
        Dim blnHasSkills As Boolean = False
        Dim objHeader As New WebPages.Template.HeaderFooter

        Dim strMenu As String
        Dim strCaption As String = ""
        Dim strResourceCaption As String = ""

        'Get the Related Information
        GetProjectDetails()

        strQuery = "Exec usp_Sel_GetProjectEmployeeWorkPeriod " & m_lngProjectId.ToString()
        strQuery &= ", " & m_lngProjectEmployeeRoleId
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                blnHasEmpRecord = True
                m_lngEmployeeId = CType("0" & CommonFunctions.Data.CheckIsDBNull(drWork.Item("EmployeeID")).ToString(), Long)
                'Modified and Added by PrashantD on 9 May 2007 for CleanUp Activity
                m_strUserName = CommonFunctions.Data.CheckIsDBNull(drWork.Item("UserName1")).ToString()
                m_strUserName = CommonFunctions.General.UnBuildQueryString(m_strUserName)
                m_strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drWork.Item("EmployeeName")).ToString()
                m_strRoleDescription = CommonFunctions.Data.CheckIsDBNull(drWork.Item("RoleDescription")).ToString()
                'End of addition by PrashantD on 9 May 2007 for CleanUp Activity
                m_intTotalDays = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("TotalDays"), "0").ToString(), Integer)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        strQuery = "Exec usp_Sel_tbl_PM_ProjectTools " & m_lngProjectId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                blnHasSkills = True
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        GetYearsMonthsAndDays()
        If m_intEmployeeDays > 0 Then
            m_intEmployeeMonths = m_intEmployeeMonths + 1
        End If

        If m_intEmployeeMonths >= 12 Then
            m_intEmployeeYears = m_intEmployeeYears + 1
        End If

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunctions.HTMLControls.DrawTextBox("txthidEmployeeId", "txthidEmployeeId", , , , m_lngEmployeeId.ToString(), , , , , , True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015 

        'Actual Page View
        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<br>")

        If blnHasEmpRecord = True And blnHasSkills = True Then
            'Display Page Caption
            'Modified and Added by PrashantD on 9 May 2007 for CleanUp Activity
            'strCaption = MyBase.GetResourceString("UPDATE_SKILLS") & " [" & Server.HtmlEncode(m_strUserName) & "]"
            strCaption = MyBase.GetResourceString("UPDATE_SKILLS")
            strResourceCaption = MyBase.GetResourceString("CAP_USER_RESOURCE_NAME") + " : " + Server.HtmlEncode(m_strUserName) + " - " + m_strEmployeeName + "[" + m_strRoleDescription + "]"
            'End of addition by PrashantD on 9 May 2007 for CleanUp Activity

            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, strCaption, strResourceCaption, , True))
            CommonFunctions.General.WriteHTML("<br>")

            If m_strMode = MODE_RELEASE Then
                'Display the Page Header
                objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER
                objHeader.HeaderFooter = MyBase.GetResourceString("RELEASEPAGE_HEADER")
                CommonFunctions.General.WriteHTML(objHeader.DrawHeaderFooter(Nothing, True))
                objHeader = Nothing
                CommonFunctions.General.WriteHTML("<br>")
            End If

            'Display page body
            Display_Skills()
        Else
            Display_NoRecords(blnHasEmpRecord, blnHasSkills)
            CommonFunctions.General.WriteHTML("<br>")
        End If

        'Display Menu at Footer
        CommonFunctions.General.WriteHTML(strMenu)

        'Hidden Controls
        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunctions.HTMLControls.DrawTextBox("txthidAction", "txthidAction", , , , , , , , , , True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015
    End Sub

    Private Sub GetProjectDetails()
        Dim drWork As IDataReader
        Dim strQuery As String = ""
        Dim lngTempUsed As Long = 0

        m_intYearsToBeShown = 0
        m_intMonthsToBeShown = 0

        strQuery = "Exec usp_Sel_tbl_PM_Project_ActualStartDate " & m_lngProjectId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_strStartDate = CommonFunctions.Data.CheckIsDBNull(drWork.Item("ActualStartDate")).ToString()
                If ("" & m_strStartDate).Trim() <> "" Then
                    lngTempUsed = DateDiff(DateInterval.Month, CType(m_strStartDate, Date), Now)
                    m_intYearsToBeShown = CType(lngTempUsed / 12, Integer)
                    If lngTempUsed >= 11 Then
                        m_intYearsToBeShown += 1
                    End If
                    If m_intYearsToBeShown = 0 Then
                        lngTempUsed = DateDiff(DateInterval.Day, CType(m_strStartDate, Date), Now())
                        m_intMonthsToBeShown = CType(lngTempUsed / 30, Integer)

                        If m_intMonthsToBeShown < 11 Then
                            m_intMonthsToBeShown += 1
                        End If

                    Else
                        m_intMonthsToBeShown = 11
                    End If
                End If
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
    End Sub

    Private Sub Display_NoRecords(ByVal blnHasEmpRecord As Boolean, ByVal blnHasSkills As Boolean)
        CommonFunctions.General.WriteHTML("<DIV id=divList style='overflow:auto;width:100%'>")
        CommonFunctions.General.WriteHTML("<TABLE class=clsTable width='99.9%'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD align='center'><BR>")
        If blnHasEmpRecord = False Then
            CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("NO_RESOURCES_ASSIGNED") & "</B>")
            m_strClientSideScript = "alert('" & MyBase.GetResourceString("ADD_RESOURCES") & "');" & vbCrLf
            m_strClientSideScript &= "window.close();"
            'm_strClientSideScript &= "window.location.href = '../PM/ProjectResources.asp?FromWhere=PM&MasterTagID=" & m_lngTagId.ToString() & "'"
        ElseIf blnHasSkills = False Then
            CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("NO_DEVELOPMENT_TOOL_ASSIGNED") & "</B><BR>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("IF_TOOLS_USED"))
            m_strClientSideScript = "alert('" & MyBase.GetResourceString("ADD_TOOLS") & "');" & vbCrLf
            m_strClientSideScript &= "window.close();"
            'm_strClientSideScript &= "window.location.href = '../General/CommonList.asp?FromWhere=PM&MasterTagID=35'"
        End If
        CommonFunctions.General.WriteHTML("</TD></TR></TABLE></DIV>")
    End Sub

    Private Sub GetProjectExperienceDetails(ByVal lngEmployeeId As Long, ByVal lngToolId As Long)
        Dim strQuery As String
        Dim drWork As IDataReader

        strQuery = "Exec usp_Sel_tbl_PM_EmployeeSkillMatrix_Detail " & m_lngProjectId.ToString()
        strQuery &= ", " & lngEmployeeId.ToString()
        strQuery &= ", " & lngToolId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_intEmployeeYears = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("YearsOfExperience"), "0").ToString(), Integer)
                m_intEmployeeMonths = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("MonthsOfExperience"), "0").ToString(), Integer)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
    End Sub

    Private Sub GetYearsMonthsAndDays()
        Dim intDays As Integer

        intDays = m_intTotalDays
        m_intEmployeeYears = CType(intDays / 365, Integer)
        intDays = intDays Mod 365

        If intDays = 365 Then
            m_intEmployeeMonths = 12
            m_intEmployeeDays = 0
        ElseIf intDays >= 334 Then
            m_intEmployeeMonths = 11
            m_intEmployeeDays = intDays - 334
        ElseIf intDays >= 304 Then
            m_intEmployeeMonths = 10
            m_intEmployeeDays = intDays - 304
        ElseIf intDays >= 273 Then
            m_intEmployeeMonths = 9
            m_intEmployeeDays = intDays - 273
        ElseIf intDays >= 243 Then
            m_intEmployeeMonths = 8
            m_intEmployeeDays = intDays - 243
        ElseIf intDays >= 212 Then
            m_intEmployeeMonths = 7
            m_intEmployeeDays = intDays - 212
        ElseIf intDays >= 181 Then
            m_intEmployeeMonths = 6
            m_intEmployeeDays = intDays - 181
        ElseIf intDays >= 151 Then
            m_intEmployeeMonths = 5
            m_intEmployeeDays = intDays - 151
        ElseIf intDays >= 120 Then
            m_intEmployeeMonths = 4
            m_intEmployeeDays = intDays - 120
        ElseIf intDays >= 90 Then
            m_intEmployeeMonths = 3
            m_intEmployeeDays = intDays - 90
        ElseIf intDays >= 59 Then
            m_intEmployeeMonths = 2
            m_intEmployeeDays = intDays - 59
        ElseIf intDays >= 31 Then
            m_intEmployeeMonths = 1
            m_intEmployeeDays = intDays - 31
        Else
            m_intEmployeeMonths = 0
            m_intEmployeeDays = intDays
        End If
    End Sub

    Private Sub Display_Skills()
        'Grid Related Variables
        Dim intTotalColumns As Integer = 2
        Dim arrActualColumns(intTotalColumns - 1) As String
        Dim arrUserFriendlyColumn(intTotalColumns - 1) As String
        Dim arrTDStyle(intTotalColumns - 1) As String
        Dim intIndex As Integer = 0

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        'Display the List of the Skills
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("SKILL")
        arrActualColumns(intIndex) = "Description"
        arrTDStyle(intIndex) = "align=left"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("EXPERIENCE")
        arrActualColumns(intIndex) = "ToolID"
        arrTDStyle(intIndex) = "align='center'"
        intIndex += 1

        'Set the Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "ToolID"
            .SQL = "Exec usp_Sel_tbl_PM_ProjectTools " & m_lngProjectId.ToString()
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intTotalColumns
            .returnHTML = True
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub UpdateSkills()
        Dim strQuery As String = ""
        Dim strToolIds As String = ""
        Dim arrToolId() As String
        Dim intCnt As Integer = 0
        Dim intYrs As Integer = 0
        Dim intMnths As Integer = 0

        m_lngEmployeeId = CType("0" & MyBase.FixString(MyBase.GetFormValue("txthidEmployeeId"), 0, True, True), Long)
        strToolIds = "" & MyBase.FixString(MyBase.GetFormValue("txthidToolId"), 0, False, False)
        If strToolIds.Trim() <> "" Then
            arrToolId = strToolIds.Split(CType(",", Char))
            For intCnt = 0 To arrToolId.Length - 1
                intYrs = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboYRow_" & arrToolId(intCnt).ToString()), 0, True, False), Integer)
                intMnths = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboMRow_" & arrToolId(intCnt).ToString()), 0, True, False), Integer)
                strQuery = "Exec usp_Ins_tbl_PM_EmployeeSkillMatrix_Detail " & m_lngProjectId.ToString()
                strQuery &= ", " & m_lngEmployeeId.ToString()
                strQuery &= ", " & arrToolId(intCnt).ToString()
                strQuery &= ", " & intYrs.ToString()
                strQuery &= ", " & intMnths.ToString() & ",0"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            Next
        End If
    End Sub

    Private Sub ReleaseResource()
        Dim strQuery As String = ""
        Dim drEmail As IDataReader
        Dim blnSendEMail As Boolean = False
        Dim blnShowPopup As Boolean = False
        Dim strToEmailID As String = ""
        Dim strCCToEmailID As String = ""
        Dim strFromEmailID As String = ""
        Dim strSubject As String = ""
        Dim strEmailMessage As String = ""

        strQuery = "Exec usp_Upd_tbl_PM_ProjectEmployeeRole '" & m_lngProjectEmployeeRoleId.ToString()
        strQuery &= "', '" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        'Send Emails to all the Released resources
        strQuery = "usp_Sel_tbl_PM_EmailMessages 16"
        drEmail = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
            If drEmail.Read() Then
                blnSendEMail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmail)
        If blnSendEMail = True Then
            If blnShowPopup = True Then
                m_strClientSideScript &= "window.open('../General/SendEmail.aspx?MessageID=16&ProjectEmployeeRoleId=" & m_lngProjectEmployeeRoleId.ToString() & "', '', 'resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');" & vbCrLf
            Else
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_16(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_lngProjectEmployeeRoleId.ToString())
                CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
            End If
        End If
    End Sub

#Region " Event Handler for Menu / Grid Objects "
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If m_strMode = MODE_UPDATE_SKILLS Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.UPDATE_SKILLS_AND_RELEASE_RESOURCES) Then Cancel = True
        ElseIf m_strMode = MODE_RELEASE Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Then Cancel = True
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim lngToolId As Long = 0

        lngToolId = CType("0" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ToolID")).ToString(), Long)
        Select Case Args.ColIndex
            Case 0
                '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                Args.StringToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txthidToolId", "txthidToolId", , , , lngToolId.ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                '''End of Modification by Dhanashri S on 7 Oct 2015

            Case 1
                Dim intCtr As Integer

                GetProjectExperienceDetails(m_lngEmployeeId, lngToolId)

                Args.StringToBeInserted = "<TD align=center noWrap>"
                If m_intYearsToBeShown > 0 Then
                    Args.StringToBeInserted &= "<SELECT name='cboYRow_" & lngToolId.ToString() & "' class=clsCombobox>"
                    For intCtr = 0 To m_intYearsToBeShown
                        Args.StringToBeInserted &= "<OPTION value='" & intCtr & "'"
                        If m_intEmployeeYears = intCtr Then Args.StringToBeInserted &= "selected"
                        Args.StringToBeInserted &= ">" & intCtr & "</OPTION>"
                    Next
                    Args.StringToBeInserted &= "</SELECT>"
                    Args.StringToBeInserted &= "&nbsp;" & MyBase.GetResourceString("YEARS") & "&nbsp;"
                End If
                If m_intMonthsToBeShown > 0 Then
                    Args.StringToBeInserted &= "<SELECT name='cboMRow_" & lngToolId.ToString() & "' class=clsCombobox>"
                    For intCtr = 0 To m_intMonthsToBeShown
                        Args.StringToBeInserted &= "<OPTION value='" & intCtr & "'"
                        If m_intEmployeeMonths = intCtr Then Args.StringToBeInserted &= "selected"
                        Args.StringToBeInserted &= ">" & intCtr & "</OPTION>"
                    Next
                    Args.StringToBeInserted &= "</SELECT>"
                    Args.StringToBeInserted &= "&nbsp;" & MyBase.GetResourceString("MONTHS") & "&nbsp;"
                End If
                Args.StringToBeInserted &= "</TD>"
                Cancel = True
        End Select
    End Sub
#End Region

End Class
