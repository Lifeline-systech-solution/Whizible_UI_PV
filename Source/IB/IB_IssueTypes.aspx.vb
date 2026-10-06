Public Class IB_IssueTypes
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

#Region " Constants to be used "
    'Page Help Id
    Const HELP_ID As Integer = 538
    'Page Modes
    Const MODE_LIST As String = "List"
    Const MODE_STATUS As String = "Status"
    Const MODE_SUBTYPE As String = "Subtype"
    Const MODE_REVIEWTYPE As String = "Review Types"
    Const MODE_ISSUETYPE As String = "Issue Type"
    Const MODE_EDIT As String = "Edit"
    Const MODE_ADD As String = "Add"
    'Actions on the Page
    Const ACTION_SAVE As String = "Save"
    Const ACTION_SETASDEFAULT As String = "Set As Default"
    Const ACTION_DELETE As String = "Delete"
    Const ACTION_APPLY_PROECT_TYPES As String = "Apply Project Types"
    Const ACTION_CHANGE_CORPORATE_TYPE As String = "Change Corporate Type"
    Const COLOR_DEFAULT_ISSUE_TYPE As String = "Blue"
#End Region

#Region " Class Scope Variables "
    Private m_intHelpId As Integer
    Private m_intProjectId As Integer
    Private m_strAction As String
    Private m_strMode As String
    Private m_strPageNumber As String
    Private m_strSortBy As String
    Private m_strSortOrder As String

    Private m_intIssueTypeId As Integer

    'Access rights
    Private m_blnAddRight As Boolean
    Private m_blnDeleteRight As Boolean
    Private m_blnEditRight As Boolean
    Private m_blnViewRight As Boolean
    Private m_blnNodeRight As Boolean
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load


        'Put user code to initialize the page here
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtSortField")) <> "" Then
            m_strSortBy = MyBase.GetFormValue("txtSortField").Trim
            m_strSortOrder = MyBase.GetFormValue("txtSortOrder").Trim
        Else
            m_strSortBy = "Type"
            m_strSortOrder = "ASC"
        End If
        m_intHelpId = HELP_ID

        m_blnAddRight = False
        m_blnDeleteRight = False
        m_blnEditRight = False
        m_blnViewRight = False

        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboCustomerProjects")) <> "" Then
            m_intProjectId = CType(MyBase.GetFormValue("cboCustomerProjects"), Integer)
        Else
            m_intProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intProjectID")), Integer)
            GetAccessRights()
        End If

        m_strPageNumber = CommonFunctions.General.CheckIsNothing(Request.QueryString("PageNumber")).ToString
        m_intIssueTypeId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("IssueTypeID"), "0"), Integer)
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).ToString
        If m_strMode = "" Then
            m_strMode = MODE_LIST
        End If

        m_strAction = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidAction_IssueType"))
        If (m_strAction = ACTION_APPLY_PROECT_TYPES) Then
            ApplyProjectTypes()
        End If
        If m_strMode = MODE_EDIT Or m_strMode = MODE_ADD Then
            If m_strAction = ACTION_SAVE Or m_strAction = ACTION_SETASDEFAULT Then

            End If
        End If
        If m_strMode = MODE_LIST And m_strAction = ACTION_DELETE Then
            Delete_IssueType()
        End If
    End Sub

#Region " Functions / Procedures Common to all Modes "
    Protected Sub WritePageHead()
        Dim strPageTitle As String

        Select Case m_strMode
            Case MODE_LIST
                strPageTitle = MyBase.GetResourceString("ISSUETYPES")
            Case MODE_STATUS
                strPageTitle = MyBase.GetResourceString("STATUSDETAILS")
            Case MODE_SUBTYPE
                strPageTitle = MyBase.GetResourceString("SUBTYPEDETAILS")
            Case MODE_REVIEWTYPE
                strPageTitle = MyBase.GetResourceString("REVIEWTYPES")
            Case Else
                strPageTitle = MyBase.GetResourceString("ISSUETYPES")
        End Select
        CommonFunction.General.PlotPageHeadTag(strPageTitle)
    End Sub

    Protected Sub WritePage()
        If m_strMode = MODE_LIST Then
            WritePage_IssueTypeList()
            'Else
            '    WritePage_ViewDetails()
        End If

        'Hidden Fields

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidAction_IssueTypes", "txthidAction_IssueTypes", , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtSortField", "txtSortField", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtSortOrder", "txtSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
    End Sub

    Private Function WritePageMenu() As String
        Dim intMenuCount As Integer
        If m_strMode = MODE_LIST Then
            intMenuCount = 4
            If m_blnAddRight = False Then intMenuCount = intMenuCount - 1
            If m_blnDeleteRight = False Then intMenuCount = intMenuCount - 2
            'ElseIf m_strMode = MODE_ADD And m_intProjectViewId = 0 Then
            '    intMenuCount = 4
            'ElseIf m_strMode = MODE_EDIT And m_intProjectViewId > 0 Then
            '    intMenuCount = 5
        End If

        Dim strMenu As String
        Dim intIndex As Integer = 0
        Dim arrMenuItem(intMenuCount - 1) As String
        Dim arrMenuTooltip(intMenuCount - 1) As String
        Dim arrClientSideFunctions(intMenuCount - 1) As String

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        If m_strMode = MODE_LIST Then
            If m_blnAddRight = True Then
                arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_ADDNEW")
                arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP")
                arrClientSideFunctions(intIndex) = "AddNew_OnClick()"
                intIndex = intIndex + 1
            End If
            If m_blnDeleteRight = True Then
                arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_DELETE")
                arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_DELETE_TOOLTIP")
                arrClientSideFunctions(intIndex) = "Delete_OnClick()"
                intIndex = intIndex + 1

                arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_SELECTALL")
                arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")
                arrClientSideFunctions(intIndex) = "SelectAll_OnClick()"
                intIndex = intIndex + 1
            End If
        End If

        arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_HELP")
        arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        arrClientSideFunctions(intIndex) = "Help_OnClick('" & m_intHelpId & "')"
        intIndex = intIndex + 1

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenuItem, arrClientSideFunctions, arrMenuTooltip, True)
        Return strMenu
    End Function

    Private Sub WritePageLegend()
        Dim intLegendCount As Integer
        If m_strMode = MODE_LIST Then
            intLegendCount = 2
            'Else
            '    intLegendCount = 1
        End If
        Dim arrLegends(intLegendCount - 1) As String
        Dim arrLegendImg(intLegendCount - 1) As String

        If m_strMode = MODE_LIST Then
            arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("BLUECOLORINDICATESETTINGS")
            arrLegendImg(0) = ""
            arrLegends(1) = "&nbsp;" & MyBase.GetResourceString("STATUSFORTASKCOMPLETE")
            arrLegendImg(1) = ""

            'Else
            '    arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("PREFIXINDICATES")
            '    arrLegendImg(0) = ""
            '    arrLegends(1) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
            '    arrLegendImg(1) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        End If
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub

    Private Sub GetAccessRights()
        Dim drAccessRights As IDataReader
        Dim strQuery As String
        Dim intPostId As Integer
        Dim intUserId As Integer
        Dim strLoginType As String

        intPostId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intPostID"), "0"), Integer)
        intUserId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intUserID"), "0"), Integer)
        strLoginType = CommonFunctions.General.CheckIsNothing(Session.Item("LoginType")).ToString

        strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " & m_intHelpId & "," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & m_intProjectId.ToString
        drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
            drAccessRights.Read()
            m_blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
            m_blnDeleteRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("D"), "False"), Boolean)
            m_blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)
            m_blnViewRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("V"), "False"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(drAccessRights)
    End Sub

    Private Sub ApplyProjectTypes()
        Dim strQuery As String
        Dim intcboCustProject As Integer

        intcboCustProject = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboCustomerProjects"), "0"), Integer)
        strQuery = "Exec usp_Upd_IB_ImportProjectTypes " & m_intProjectId & ", " & intcboCustProject.ToString
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        GetAccessRights()
        m_intProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intProjectID")), Integer)
    End Sub

    Private Function GetPageHeader(ByVal intTagId As Integer) As String
        Dim strQuery As String
        Dim strHTML As String = ""
        Dim strPageHeader As String
        Dim drPageHeader As IDataReader

        strQuery = "usp_Sel_tbl_UI_TagMaster_PageHeaderFooter " & intTagId & ",'LIST_HEADER'"
        drPageHeader = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drPageHeader) <> "" Then
            drPageHeader.Read()
            strPageHeader = CommonFunctions.Data.CheckIsDBNull(drPageHeader.Item("PageHeader")).ToString()
            If strPageHeader <> "" Then
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                strHTML = "<TABLE CellSpacing=0 class=clsTable width='99.9%'><TR><TD valign=top class = clsTDOdd>"
                strHTML &= strPageHeader & "</TD></TR></TABLE>"
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drPageHeader)
        Return strHTML
    End Function
#End Region

#Region " Functions / Procedures Speific to List Mode "
    Private Sub WritePage_IssueTypeList()
        Dim strMenu As String
        Dim strQuery As String
        Dim strPageAlphabets As String
        Dim drWork As IDataReader
        Dim intCustomerId As Integer
        Dim objHref As New WebPages.UI.cDynamicLink

        strQuery = "Exec usp_Sel_tbl_IB_Project_Sub_Type " & m_intProjectId & ", 'T'"
        strPageAlphabets = WebPages.Template.Paging.DrawPaging("", strQuery, "Select ", , "Type", True)

        'Display Menu
        strMenu = WritePageMenu()

        WebPages.Template.PageCaption.GetPageCaptions(, strPageAlphabets, strMenu)

        MyBase.InitializeResources("AppResources.IB_IssueTypes", "AppResources")

        'Write Page Legends and Page Caption
        WritePageLegend()

        CommonFunctions.General.WriteHTML(GetPageHeader(m_intHelpId))

        CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("ISSUETYPES"), , , True))
        CommonFunctions.General.WriteHTML("<br>")

        ' The customer projects will not be shown if there are any issues entered against the Task.
        intCustomerId = 0
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strQuery = "SELECT TOP 1 IssueID FROM tbl_IB_Issue WHERE ProjectID = " & CommonFunctions.General.CheckIsNothing(Session.Item("intProjectID"), "0").ToString
        strQuery = "usp_sel_tbl_IB_Issue_IssueID1 " & CommonFunctions.General.CheckIsNothing(Session.Item("intProjectID"), "0").ToString
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If (drWork.Read()) Then
                CommonFunctions.Data.DisposeDataReader(drWork)
                drWork = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_Project " & m_intProjectId, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                    If (drWork.Read()) Then
                        intCustomerId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("CustomerID"), "0"), Integer)
                    End If
                End If
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
        If intCustomerId > 0 Then
            strQuery = "Exec usp_Sel_PM_CustomerProjects " & intCustomerId & ", " & CommonFunctions.General.CheckIsNothing(Session.Item("intProjectID"), "0").ToString
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                CommonFunctions.General.WriteHTML("<table class='clsTable' width='99.9%' cellspacing='0'><tr class='clsTROdd'>")
                CommonFunctions.General.WriteHTML("<td nowrap align='left' valign='top'>")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHOWTYPESOFPROJECT"))
                CommonFunctions.General.WriteHTML("</td>")
                CommonFunctions.General.WriteHTML("<td nowrap align='left' valign='top'>")
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboCustomerProjects", strQuery, , m_intProjectId.ToString))
                CommonFunctions.General.WriteHTML("</td>")
                If m_intProjectId <> CType(Session.Item("intProjectID"), Integer) Then
                    CommonFunctions.General.WriteHTML("<td nowrap align='right' valign='top'>")
                    objHref.FunctionName = "ApplyProjectTypes_OnClick()"
                    objHref.LinkName = MyBase.GetResourceString("APPLYTYPESTOCURRENTPROJECT")
                    objHref.ReturnHTML = True
                    CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
                    CommonFunctions.General.WriteHTML("</td>")
                End If
                CommonFunctions.General.WriteHTML("</tr></table>")
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
        End If
        'Display List of Issue Types
        WriteList_IssueType()

        'Display Menu at footer
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Sub WriteList_IssueType()
        Dim strTemp As String
        Dim strImageName As String
        Dim strColumnName As String
        Dim strSortOrder As String
        Dim objHref As New WebPages.UI.cDynamicLink

        CommonFunctions.General.WriteHTML("<div id='divList' style='OVERFLOW: auto; WIDTH: 100%'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table class='clsTable' width='99.9%' cellspacing='0'>")

        'Display Column Headers
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        'Column -1
        strColumnName = "Type"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        strTemp &= MyBase.GetResourceString("TYPE")
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td class='clsTDEven' noWrap valign='top'>-&gt;</td>")

        'Column -2
        strColumnName = "CorporateType"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        strTemp &= MyBase.GetResourceString("CORPORATETYPE")
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td>")

        'Column -3
        strColumnName = "Status"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        strTemp &= MyBase.GetResourceString("STATUS")
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td class='clsTDEven' noWrap valign='top'>-&gt;</td>")

        'Column -4
        strColumnName = "CorporateStatus"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        strTemp &= MyBase.GetResourceString("CORPORATESTATUS")
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td>")

        'Column -5
        strColumnName = "SubType"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        strTemp &= MyBase.GetResourceString("SUBTYPE")
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td class='clsTDEven' noWrap valign='top'>-&gt;</td>")

        'Column -6
        strColumnName = "CorporateSubType"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        strTemp &= MyBase.GetResourceString("CORPORATESUBTYPE")
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td>")

        'Column -7
        If m_blnDeleteRight = True Then
            CommonFunctions.General.WriteHTML("<td align='center'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DELETE"))
            CommonFunctions.General.WriteHTML("</td>")
        End If
        CommonFunctions.General.WriteHTML("</tr>")

        'Display the data rows
        DisplayRow_IssueType()

        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")
    End Sub

    Private Sub DisplayRow_IssueType()
        Dim strQuery As String
        Dim drRow As IDataReader
        Dim strDefaulType As String
        Dim strColor As String
        Dim objHref As New WebPages.UI.cDynamicLink
        Dim blnDisabled As Boolean = False
        'Data Fields
        Dim strType As String
        Dim strCorporateType As String
        Dim strUsed As String

        strQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'T', " & m_intProjectId.ToString
        drRow = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drRow) <> "" Then
            If drRow.Read() Then strDefaulType = CommonFunctions.Data.CheckIsDBNull(drRow.Item("Type")).ToString
        End If
        CommonFunctions.Data.DisposeDataReader(drRow)

        strQuery = "Exec usp_Sel_tbl_IB_Project_Sub_Type " & m_intProjectId & ", 'T', NULL, NULL, NULL, '" & m_strPageNumber & "'"
        If UCase(m_strSortBy) = "TYPE" Or UCase(m_strSortBy) = "CORPORATETYPE" Then
            strQuery &= ", '" & m_strSortBy & " " & m_strSortOrder & "'"
        End If
        drRow = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drRow) <> "" Then
            While (drRow.Read())
                strType = CommonFunctions.Data.CheckIsDBNull(drRow.Item("Type")).ToString
                strCorporateType = CommonFunctions.Data.CheckIsDBNull(drRow.Item("CorporateType")).ToString
                strUsed = CommonFunctions.Data.CheckIsDBNull(drRow.Item("Used")).ToString
                If strDefaulType.ToUpper = strType.ToUpper Then
                    strColor = COLOR_DEFAULT_ISSUE_TYPE
                Else
                    strColor = ""
                End If
                CommonFunctions.General.WriteHTML("<tr class='clsTROdd'>")

                CommonFunctions.General.WriteHTML("<td>")
                If m_blnEditRight = True Then
                    objHref.FunctionName = "Type_OnClick('" & strType & "')"
                    objHref.LinkName = "<FONT color=" & strColor & ">" & strType & "</FONT>"
                    objHref.ReturnHTML = True
                    CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
                Else
                    CommonFunctions.General.WriteHTML("<FONT color=" & strColor & ">" & strType & "</FONT>")
                End If
                CommonFunctions.General.WriteHTML("</td>")

                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' noWrap>")
                CommonFunctions.General.WriteHTML("<FONT color=" & strColor & ">-&gt;</FONT></td>")

                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' noWrap>")
                CommonFunctions.General.WriteHTML("<FONT color=" & strColor & ">" & strCorporateType & "</FONT></td>")

                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' colspan=6>")
                objHref.FunctionName = "ConfigureMails_OnClick('" & strType & "')"
                objHref.LinkName = MyBase.GetResourceString("CONFIGUREMAILS")
                objHref.ReturnHTML = True
                CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
                CommonFunctions.General.WriteHTML("</td>")

                If m_blnDeleteRight Then
                    CommonFunctions.General.WriteHTML("<td class='clsTDOdd' align='center'>")
                    If strUsed = "1" Then
                        blnDisabled = True
                    Else
                        blnDisabled = False
                    End If
                    CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , strType, blnDisabled)
                    CommonFunctions.General.WriteHTML("</td>")
                End If
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                CommonFunctions.HTMLControls.DrawTextBox("txthidTypeUsed", "txthidTypeUsed", , , , strUsed, , , , , , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
                CommonFunctions.General.WriteHTML("</tr>")

                ' Display Details of Sub Type and Sub Status
                DisplaySubDetails_IssueType(strType)
            End While
        Else
            CommonFunctions.General.WriteHTML("<tr class='clsTROdd'><td align='center' colspan='10>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOITEMSTOSHOW"))
            CommonFunctions.General.WriteHTML("</td>/tr>")
        End If
        CommonFunctions.Data.DisposeDataReader(drRow)
    End Sub

    Private Sub DisplaySubDetails_IssueType(ByVal strType As String)
        Dim strTemp As String
        Dim objHref As New WebPages.UI.cDynamicLink
        Dim strQuery As String
        Dim drSubType As IDataReader
        Dim drStatus As IDataReader
        Dim strDefaultSubtype As String
        Dim strDefaultStatus As String
        Dim strStatusColor As String
        Dim strSubTypeColor As String
        'Data Fields
        Dim strStatus As String
        Dim intProjectTypeStatusId As Integer
        Dim blnSetTaskCompleteStatus As Boolean
        Dim strCorporateStatus As String
        Dim strSubType As String
        Dim strCorporateSubType As String
        Dim intSubTypeId As Integer

        strQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'ST', " & m_intProjectId & ", '" & strType & "'"
        drStatus = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drStatus) <> "" Then
            If drStatus.Read() Then strDefaultStatus = CommonFunctions.Data.CheckIsDBNull(drStatus.Item("Status")).ToString
        End If
        CommonFunctions.Data.DisposeDataReader(drStatus)

        strQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'S', " & m_intProjectId & ", '" & strType & "'"
        drSubType = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drSubType) <> "" Then
            If drSubType.Read() Then strDefaultSubtype = CommonFunctions.Data.CheckIsDBNull(drSubType.Item("SubType")).ToString
        End If
        CommonFunctions.Data.DisposeDataReader(drSubType)

        strQuery = "Exec usp_Sel_tbl_IB_Project_Type_Status " & m_intProjectId & ", '" & strType & "'"
        drStatus = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        strQuery = "Exec usp_Sel_tbl_IB_Project_Sub_Type " & m_intProjectId & ", 'S', '" & strType & "'"
        drSubType = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If CommonFunctions.General.CheckIsNothing(drStatus) <> "" And CommonFunctions.General.CheckIsNothing(drSubType) <> "" Then
            While (drStatus.Read() And drSubType.Read())
                strStatus = CommonFunctions.Data.CheckIsDBNull(drStatus.Item("Status")).ToString
                intProjectTypeStatusId = CType(CommonFunctions.Data.CheckIsDBNull(drStatus.Item("ProjectTypeStatusID"), "0"), Integer)
                blnSetTaskCompleteStatus = CType(CommonFunctions.Data.CheckIsDBNull(drStatus.Item("SetTaskCompleteStatus"), "False"), Boolean)
                strCorporateStatus = CommonFunctions.Data.CheckIsDBNull(drStatus.Item("CorporateStatus")).ToString

                intSubTypeId = CType(CommonFunctions.Data.CheckIsDBNull(drSubType.Item("SubTypeID"), "0"), Integer)
                strSubType = CommonFunctions.Data.CheckIsDBNull(drSubType.Item("SubType")).ToString
                strCorporateSubType = CommonFunctions.Data.CheckIsDBNull(drSubType.Item("CorporateSubType")).ToString

                strStatusColor = ""
                If strDefaultStatus.ToUpper = strStatus Then
                    strStatusColor = COLOR_DEFAULT_ISSUE_TYPE
                End If
                strSubTypeColor = ""
                If strDefaultSubtype.ToUpper = strSubType Then
                    strSubTypeColor = COLOR_DEFAULT_ISSUE_TYPE
                End If
                CommonFunctions.General.WriteHTML("<tr class='clsTROdd'><td colspan='3'></td>")
                'Status Details
                strTemp = "<FONT color=" & strStatusColor & ">" & strStatus
                If blnSetTaskCompleteStatus = True Then strTemp &= " @"
                strTemp &= "</FONT>"
                If m_blnEditRight = True Then
                    objHref.FunctionName = "Status_OnClick(" & intProjectTypeStatusId.ToString & ")"
                    objHref.LinkName = strTemp
                    objHref.ReturnHTML = True
                    CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
                Else
                    CommonFunctions.General.WriteHTML(strTemp)
                End If
                CommonFunctions.General.WriteHTML("</td>")

                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' noWrap>")
                CommonFunctions.General.WriteHTML("<FONT color=" & strStatusColor & ">-&gt;</FONT></td>")

                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' noWrap>")
                CommonFunctions.General.WriteHTML("<FONT color=" & strStatusColor & ">" & strCorporateStatus & "</FONT></td>")

                'Sub Type Details
                strTemp = "<FONT color=" & strSubTypeColor & ">" & strSubType & "</FONT>"
                If m_blnEditRight = True Then
                    objHref.FunctionName = "SubType_OnClick(" & intSubTypeId.ToString & ")"
                    objHref.LinkName = strTemp
                    objHref.ReturnHTML = True
                    CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
                Else
                    CommonFunctions.General.WriteHTML(strTemp)
                End If
                CommonFunctions.General.WriteHTML("</td>")

                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' noWrap>")
                CommonFunctions.General.WriteHTML("<FONT color=" & strSubTypeColor & ">-&gt;</FONT></td>")

                CommonFunctions.General.WriteHTML("<td class='clsTDOdd' noWrap>")
                CommonFunctions.General.WriteHTML("<FONT color=" & strSubType & ">" & strCorporateSubType & "</FONT></td>")
                CommonFunctions.General.WriteHTML("</tr>")
            End While
            CommonFunctions.General.WriteHTML("<tr class='clsTROdd'><td colspan='10'><hr style='color:#99CCFF' size='1pt'></td></tr>")
        End If
        CommonFunctions.Data.DisposeDataReader(drStatus)
        CommonFunctions.Data.DisposeDataReader(drSubType)
    End Sub

    Private Function GetImageToShow(ByVal strColumn As String, ByVal strSortOrder As String) As String
        Dim strImageName As String = ""
        If strColumn = m_strSortBy Then
            If strSortOrder.ToUpper = "ASC" Then
                strImageName = "../../images/sort_down.gif"
            Else
                strImageName = "../../images/sort_up.gif"
            End If
        Else
            strImageName = "../../images/sortby.gif"
        End If
        Return strImageName
    End Function

    Private Sub Delete_IssueType()
        Dim strQuery As String
        Dim strDeleteIds As String
        Dim arrId() As String
        Dim intCnt As Integer

        strDeleteIds = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkDelete"))
        If strDeleteIds.Length > 0 Then
            arrId = strDeleteIds.Split(CType(",", Char))
            For intCnt = 0 To arrId.Length - 1
                strQuery = "Exec usp_Del_tbl_IB_Project_Type_SubType_Status 'T'," & m_intProjectId.ToString & ", '" & CommonFunctions.General.BuildQueryString(arrId(intCnt)) & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            Next
        End If
    End Sub
#End Region

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.IB_IssueTypes", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "IB_IssueTypes : " & UserInput & " " & Cause
        Throw ex
    End Sub
End Class
