Public Class IB_LayoutMaintenance
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmLayoutMaintenance As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Page Constants "
    Protected Const MODE_LAYOUTDETAILS As String = "LayoutDetails"
    Protected Const MODE_FIELDDETAILS As String = "FieldDetails"
    Protected Const ACTION_SAVE As String = "Save"
    Protected Const ACTION_SETASDEFAULT As String = "SetAsDefault"
    Protected Const MAXROW As Integer = 30
    Protected Const MAXCOLUMN As Integer = 3
    Private Const TREVEN_CLASS As String = "clsTREven"
    Private Const TRODD_CLASS As String = "clsTROdd"

    ''Commented and Added by Dhanashri S on 9 Dec 2015 for IssueID:2646
    'Private Enum MenuIndex
    '    SAVE
    '    SELECTALL
    '    SET_AS_DEFAULT
    '    BACK
    '    HELP
    'End Enum
    Private Enum MenuIndex
        SAVE
        SELECTALL
        CLEARALL
        SET_AS_DEFAULT
        BACK
        HELP
    End Enum
    ''End of Comment and Addition by Dhanashri S on 9 Dec 2015

#End Region

#Region " Class Scope Variables "
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu

    ''Commented and Added by Dhanashri S on 9 Dec 2015 for IssueID:2646 
    'Private m_arrMenuItem(4) As String
    'Private m_arrMenuTooltip(4) As String
    'Private m_arrClientSideFunctions(4) As String

    Private m_arrMenuItem(5) As String
    Private m_arrMenuTooltip(5) As String
    Private m_arrClientSideFunctions(5) As String
    ''End of Comment and Addition by Dhanashri S on 9 Dec 2015


    Private m_strNByA As String
    Protected m_strPageMode As String

    '--Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA
    'Changed TagID from 577 to 1028
    Protected m_intTagId As Integer = 1028
    Private m_strAction As String
    Private m_strPageTitle As String
    Private m_strHelpID As String
    Protected m_strPageNumber As String
    Protected m_lngFieldId As Long
    Protected m_lngLayoutId As Long
    'shraddha
    'Protected m_arr(100) As Long
    Private arrList As New ArrayList
    Public arrActualColumns() As String
    Public str As String
    'N/A Fields
    Dim m_arrNbyAFields() As String = {"SUMMARY", "DESCRIPTION", "KEYWORDS"}
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim lngDefaultLayoutId As Long
        Dim strQuery As String

        m_strNByA = MyBase.GetResourceString("NBYA")
        m_strPageTitle = MyBase.GetResourceString("TITLE")
        m_lngLayoutId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("LayoutID"), "0"), Long)  '2
        m_lngFieldId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("FieldID"), "0"), Long)
        m_strPageNumber = Request.QueryString("PageNumber")

        ' Decide the mode of display.
        If m_lngFieldId <> 0 Then
            m_strPageMode = MODE_FIELDDETAILS
            m_strHelpID = "IB_LAYOUT_FIELD_DETAILS"
        Else
            m_strPageMode = MODE_LAYOUTDETAILS
            m_strHelpID = "IB_LAYOUT_DETAILS"
        End If

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objGlobal.TagID = 1028
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        InitPageMenu()

        If Page.IsPostBack Then
            m_strAction = MyBase.GetFormValue("txthidAction_LayoutMaintenance")
            If m_strPageMode = MODE_FIELDDETAILS Then
                If m_strAction = ACTION_SAVE Then
                    SaveFieldDetails()
                End If
            ElseIf m_strPageMode = MODE_LAYOUTDETAILS Then
                If m_strAction = ACTION_SETASDEFAULT Then
                    lngDefaultLayoutId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("DefaultLayoutId"), "0"), Long)
                    If lngDefaultLayoutId <> 0 Then
                        strQuery = "Exec usp_Upd_tbl_IB_IssueEntry_Layout_Master_SetAsDefault " & lngDefaultLayoutId.ToString()
                        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                    End If
                End If

                If m_strAction = ACTION_SAVE Then
                    SaveLayoutDetails()
                End If
            End If
        End If
    End Sub

#Region " Common Functions or Procedures to the Page / Class (Irrespective of the Mode) "
    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Public Sub WritePage()
        If m_strPageMode = MODE_LAYOUTDETAILS Then
            WritePage_LayoutDetail_Mode()
        ElseIf m_strPageMode = MODE_FIELDDETAILS Then
            WritePage_FieldDetail_Mode()
        End If

        'Write Hidden Fields

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidAction_LayoutMaintenance", "txthidAction_LayoutMaintenance", , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
    End Sub

    Private Function InitPageMenu() As String
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        'Dim arrMenuList As New System.Collections.ArrayList
        'Dim arrEventList As New System.Collections.ArrayList
        'Dim arrMenuToolTipList As New ArrayList

       

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_OnClick()"



        m_arrMenuItem(MenuIndex.SELECTALL) = MyBase.GetResourceString("MENU_SELECTALL")
        m_arrMenuTooltip(MenuIndex.SELECTALL) = MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")


        'if navigator.appName == 'Netscape'
        'End If
        'Modified by ShraddhaM on Date 05 Jully,2006 for WhizibleSEM Issue ID.4168

        'arrMenuList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
        'arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
        'arrEventList.Add("SelectAll_OnClick('frmLayoutMaintenance','chkLayoutSrNo')")


        m_arrClientSideFunctions(MenuIndex.SELECTALL) = "SelectAll_OnClick('frmLayoutMaintenance','chkLayoutSrNo')"

        ''Added by Dhanashri S on 9 Dec 2015 for IssueID:2646
        m_arrMenuItem(MenuIndex.CLEARALL) = "Clear All"
        m_arrMenuTooltip(MenuIndex.CLEARALL) = "Clear All"
        m_arrClientSideFunctions(MenuIndex.CLEARALL) = "ClearAll_OnClick('frmLayoutMaintenance','chkLayoutSrNo')"
        ''End of Addition by Dhanashri S on 9 Dec 


        m_arrMenuItem(MenuIndex.SET_AS_DEFAULT) = MyBase.GetResourceString("MENU_IB_SETASDEFAULT")
        m_arrMenuTooltip(MenuIndex.SET_AS_DEFAULT) = MyBase.GetResourceString("MENU_IB_SETASDEFAULT_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SET_AS_DEFAULT) = ""

        m_arrMenuItem(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK")
        m_arrMenuTooltip(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.BACK) = "Back_OnClick('" & m_strPageMode & "')"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('" & m_strHelpID & "')"

        MyBase.InitializeResources("AppResources.IB_LayoutMaintenance", "AppResources")
    End Function

    Private Sub WriteLegends()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String

        arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub

    Private Function IsFieldPresentInArray(ByVal arrSearchIn() As String, ByVal strToSearch As String) As Boolean
        Dim iCnt As Integer
        For iCnt = 0 To arrSearchIn.Length - 1
            If arrSearchIn(iCnt).ToUpper() = strToSearch.ToUpper() Then
                Return True
            End If
        Next
        Return False
    End Function

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.IB_LayoutMaintenance", "AppResources")
    End Sub
    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "IB_LayoutMaintenance: " & UserInput & " " & Cause
        Throw ex
    End Sub
    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

#End Region

#Region " Functions or Procedures Specific to Selected / New Layout Details "
    Public Sub WritePage_LayoutDetail_Mode()
        Dim strMenu As String
        Dim strLayoutName As String
        Dim drLayoutDetails As IDataReader

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)

        'Display Legends
        WriteLegends()

        'Display Page Caption
        CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, m_strPageTitle, , , True))

        'Get Layout Name
        drLayoutDetails = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueEntry_Layout_Master " & m_lngLayoutId, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drLayoutDetails, "") <> "" Then
            If drLayoutDetails.Read() Then
                strLayoutName = drLayoutDetails.Item("LayoutName").ToString()
                strLayoutName = CommonFunctions.General.UnBuildQueryString(strLayoutName)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drLayoutDetails)
        CommonFunctions.General.WriteHTML("<br>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing='0' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='Right' valign='top' style='width:40%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LAYOUTNAME") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td><td>")

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtLayoutName", "txtLayoutName", , 350, 50, strLayoutName, , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td></tr></table>")
        CommonFunctions.General.WriteHTML("<br><br>")

        'Display Layout Details List
        WriteLayoutDetailsList()

        'Display Menu
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Sub WriteLayoutDetailsList()
        Dim objLink As New WebPages.UI.cDynamicLink
        Dim strTRClass As String = TRODD_CLASS

        'Fields 
        Dim lngUniqueId As Long
        Dim blnMandatory As Boolean
        Dim strFieldName As String
        Dim strUFName As String
        Dim intRowNo As Integer
        Dim intColumnNo As Integer
        Dim blnUsed As Boolean
        Dim blnActive As Boolean
        Dim lngLayoutSrNo As Long

        Dim strQuery As String
        Dim drLayoutDetailsList As IDataReader
        Dim blnMandatoryFields As Boolean

        Dim strTempName As String
        Dim strTemp As String
        Dim blnLayoutField_Active As Boolean
        Dim intCheckboxCount As Integer

        intCheckboxCount = 0
        strQuery = "Exec usp_Sel_tbl_IB_DataDictionary NULL, " & m_lngLayoutId
        drLayoutDetailsList = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drLayoutDetailsList, "") <> "" Then
            'Table Header
            ' CommonFunctions.General.WriteHTML("<div class=outerDiv>")
            CommonFunctions.General.WriteHTML("<div id='divList' style='overflow:auto;width:100%;'>") ' style='overflow:auto;width:100%;'
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            'Commented and Added By Bharat Tekade on 1st-Apr-2016 to freeze column header and to display row lines
            'CommonFunctions.General.WriteHTML("<table cellspacing=0 cellpadding=0 class='clsTable' width='99.9%'>")
            ''Commented and added by Nilesh g on 5/12/2016 Purpose: Issue Solving
            '' CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing=0 cellpadding=0 class='clsGridTable' style='table-layout:fixed;' width='99.9%'>") 'cellspacing=0 cellpadding=0 class='clsGridTable' width='99.9%'
            If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") = "ADD_NEW" Then
                CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing=0 cellpadding=0 class='clsGridTable' width='99.9%'>") 'cellspacing=0 cellpadding=0 class='clsGridTable' width='99.9%'
                CommonFunctions.General.WriteHTML("<thead  class='clsTRColumnHeader align='Center' style='position:absolute;display:inline-table;width:97.5%;'>") 'class='clsTRColumnHeader'
                CommonFunctions.General.WriteHTML("<tr><th style='border:none !important;' >")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FIELDNAME"))
                'CommonFunctions.General.WriteHTML("<div>" & MyBase.GetResourceString("FIELDNAME") & "</div>")
                CommonFunctions.General.WriteHTML("</th>")
                If m_lngLayoutId > 0 Then
                    CommonFunctions.General.WriteHTML("<th>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ROWNO"))
                    'CommonFunctions.General.WriteHTML("<div>" & MyBase.GetResourceString("ROWNO") & "</div>")
                    CommonFunctions.General.WriteHTML("</th><th>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COLUMNNO"))
                    'CommonFunctions.General.WriteHTML("<div>" & MyBase.GetResourceString("COLUMNNO") & "</div>")
                    CommonFunctions.General.WriteHTML("</th>")
                End If
                If m_objAccessRights.Add = True Then
                    CommonFunctions.General.WriteHTML("<th>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ADD"))
                    'CommonFunctions.General.WriteHTML("<div>" & MyBase.GetResourceString("ADD") & "</div>")
                    CommonFunctions.General.WriteHTML("</th>")
                End If
                CommonFunctions.General.WriteHTML("</tr>")
                CommonFunctions.General.WriteHTML("</thead>")
                CommonFunctions.General.WriteHTML("<tbody>")

            Else
                ''end of Commented and added by Nilesh g on 5/12/2016 Purpose: Issue Solving
                CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing=0 cellpadding=0 class='clsGridTable' style='table-layout:fixed;' width='99.9%'>")
                'CommonFunctions.General.WriteHTML("<tr class='clsTRColumnHeader' align='Center'><td>")
                'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FIELDNAME"))
                'CommonFunctions.General.WriteHTML("</td>")
                'If m_lngLayoutId > 0 Then
                '    CommonFunctions.General.WriteHTML("<td>")
                '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ROWNO"))
                '    CommonFunctions.General.WriteHTML("</td><td>")
                '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COLUMNNO"))
                '    CommonFunctions.General.WriteHTML("</td>")
                'End If
                'If m_objAccessRights.Add = True Then
                '    CommonFunctions.General.WriteHTML("<td>")
                '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ADD"))
                '    CommonFunctions.General.WriteHTML("</td>")
                'End If
                'CommonFunctions.General.WriteHTML("</tr>")


                CommonFunctions.General.WriteHTML("<thead  class='clsTRColumnHeader align='Center' style='position:absolute;display:inline-table;width:97.5%;'>") 'class='clsTRColumnHeader'
                CommonFunctions.General.WriteHTML("<tr><th style='width:25%;' >")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FIELDNAME"))
                'CommonFunctions.General.WriteHTML("<div>" & MyBase.GetResourceString("FIELDNAME") & "</div>")
                CommonFunctions.General.WriteHTML("</th>")
                If m_lngLayoutId > 0 Then
                    CommonFunctions.General.WriteHTML("<th style='width:25%;' >")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ROWNO"))
                    'CommonFunctions.General.WriteHTML("<div>" & MyBase.GetResourceString("ROWNO") & "</div>")
                    CommonFunctions.General.WriteHTML("</th><th  style='width:25%;'>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COLUMNNO"))
                    'CommonFunctions.General.WriteHTML("<div>" & MyBase.GetResourceString("COLUMNNO") & "</div>")
                    CommonFunctions.General.WriteHTML("</th>")
                End If
                If m_objAccessRights.Add = True Then
                    CommonFunctions.General.WriteHTML("<th style='width:25%;'>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ADD"))
                    'CommonFunctions.General.WriteHTML("<div>" & MyBase.GetResourceString("ADD") & "</div>")
                    CommonFunctions.General.WriteHTML("</th>")
                End If
                CommonFunctions.General.WriteHTML("</tr>")
                CommonFunctions.General.WriteHTML("</thead>")
                CommonFunctions.General.WriteHTML("<tbody>")
            End If
            'End of Commented and Added By Bharat Tekade on 1st-Apr-2016 to freeze column header and to display row lines

            'Table Details Rows
            CommonFunctions.General.WriteHTML("<tr class='clsTROdd' align='Left'><td colspan='4'><b>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MANDATORYFIELDS"))
            CommonFunctions.General.WriteHTML("</b></td></tr>")
            blnMandatoryFields = True
            'shraddha
            'Dim intCnt As Integer
            'Dim i As Integer
            'i = 0
            'Dim arrList As New ArrayList

            'str = "'"
            While drLayoutDetailsList.Read()
                If strTRClass = TREVEN_CLASS Then
                    strTRClass = TRODD_CLASS
                Else
                    strTRClass = TREVEN_CLASS
                End If
                'Get Field values from DateReader
                lngUniqueId = CType(CommonFunctions.Data.CheckIsDBNull(drLayoutDetailsList.Item("UniqueID"), "0"), Long)


                'shraddha

                str = str & lngUniqueId.ToString & ","

                arrList.Add(CStr(lngUniqueId))

                'm_arr(i) = lngUniqueId

                'CommonFunctions.General.WriteHTML("<script language=javascript>")
                'CommonFunctions.General.WriteHTML("alert('hello');")
                'CommonFunctions.General.WriteHTML("</script>")

                blnMandatory = CType(CommonFunctions.Data.CheckIsDBNull(drLayoutDetailsList.Item("Mandatory"), "False"), Boolean)
                strUFName = drLayoutDetailsList.Item("UserFriendlyName").ToString()
                strUFName = CommonFunctions.General.UnBuildQueryString(strUFName)
                strFieldName = drLayoutDetailsList.Item("FieldName").ToString()
                strFieldName = CommonFunctions.General.UnBuildQueryString(strFieldName)
                intRowNo = CType(CommonFunctions.Data.CheckIsDBNull(drLayoutDetailsList.Item("RowNumber"), "0"), Integer)
                intColumnNo = CType(CommonFunctions.Data.CheckIsDBNull(drLayoutDetailsList.Item("ColumnNumber"), "0"), Integer)
                blnUsed = CType(CommonFunctions.Data.CheckIsDBNull(drLayoutDetailsList.Item("Used"), "False"), Boolean)
                blnActive = CType(CommonFunctions.Data.CheckIsDBNull(drLayoutDetailsList.Item("Active"), "False"), Boolean)
                lngLayoutSrNo = CType(CommonFunctions.Data.CheckIsDBNull(drLayoutDetailsList.Item("LayoutSrNo"), "0"), Long)

                If blnMandatoryFields = True And blnMandatory = False Then
                    CommonFunctions.General.WriteHTML("<tr class='" & strTRClass & "' align='Left'><td colspan='4'><b>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPTIONALFIELDS"))
                    CommonFunctions.General.WriteHTML("</b></td></tr>")
                    blnMandatoryFields = False
                    If strTRClass = TREVEN_CLASS Then
                        strTRClass = TRODD_CLASS
                    Else
                        strTRClass = TREVEN_CLASS
                    End If
                End If

                'Column 1
                CommonFunctions.General.WriteHTML("<tr class='" & strTRClass & "'><td>")
                If m_objAccessRights.Edit = True And blnUsed = True And blnActive = True Then
                    objLink.FunctionName = "LinkName_OnClick(" & lngUniqueId & ")"
                    objLink.LinkName = CommonFunctions.General.FormatString(strUFName)
                    objLink.ReturnHTML = True
                    ''Added By Vaijat K ON 27/11/2015
                    objLink.LinkStyle = "font-size: 12px !important"
                    CommonFunctions.General.WriteHTML(objLink.GetDynamicLink())
                Else
                    CommonFunctions.General.WriteHTML(CommonFunctions.General.FormatString(strUFName))
                End If
                CommonFunctions.General.WriteHTML("</td>")

                If m_lngLayoutId > 0 Then
                    CommonFunctions.General.WriteHTML("<td align='Center'>")
                    'Column 2
                    If m_objAccessRights.Edit = True And blnUsed = True And blnActive = True Then
                        If IsFieldPresentInArray(m_arrNbyAFields, strFieldName) = False Then
                            'shraddha
                            strTempName = "txtRowNumber_" & lngUniqueId.ToString

                            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                            'Commented And Added By Vaijat K ON 01/12/2015 issue id-2044
                            'CommonFunctions.HTMLControls.DrawTextBox(strTempName, "txtRowNumber", , 35, 2, intRowNo.ToString(), "Right", , , , , , , , True, EnableHTMLEncode:=True)
                            CommonFunctions.HTMLControls.DrawTextBox(strTempName, "txtRowNumber", , 35, 2, intRowNo.ToString(), "Right", "height:20px", , , , , , , True, EnableHTMLEncode:=True)
                            CommonFunctions.HTMLControls.DrawTextBox("txthidFieldCaption", "txthidFieldCaption", , , , strUFName, , , , , , True, EnableHTMLEncode:=True)
                            'End Added By Vaijat K ON 01/12/2015 issue id-2044
                            'ended by Yogesh J for HTML encoding Date:06/10/15
                        Else
                            CommonFunctions.General.WriteHTML(m_strNByA)
                        End If
                    Else
                        CommonFunctions.General.WriteHTML(m_strNByA)
                    End If
                    CommonFunctions.General.WriteHTML("</td><td align='Center'>")

                    'Column 3
                    If m_objAccessRights.Edit = True And blnUsed = True And blnActive = True Then
                        If IsFieldPresentInArray(m_arrNbyAFields, strFieldName) = False Then
                            strTempName = "txtColumnNumber_" & lngUniqueId.ToString
                            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                            'Commented And Added By Vaijat K ON 01/12/2015 issue id-2044
                            'CommonFunctions.HTMLControls.DrawTextBox(strTempName, "txtColumnNumber", , 35, 1, intColumnNo.ToString(), "Right", , , , , , , , True, EnableHTMLEncode:=True)
                            CommonFunctions.HTMLControls.DrawTextBox(strTempName, "txtColumnNumber", , 35, 1, intColumnNo.ToString(), "Right", "height:20px", , , , , , , True, EnableHTMLEncode:=True)
                            'End Added By Vaijat K ON 01/12/2015 issue id-2044
                            'ended by Yogesh J for HTML encoding Date:06/10/15
                        Else
                            CommonFunctions.General.WriteHTML(m_strNByA)
                        End If
                    Else
                        CommonFunctions.General.WriteHTML(m_strNByA)
                    End If
                    CommonFunctions.General.WriteHTML("</td>")
                End If

                If m_objAccessRights.Add = True Then
                    'Column 4
                    blnLayoutField_Active = False
                    If blnMandatory = True Or (blnUsed = True And blnActive = True) Then
                        blnLayoutField_Active = True
                    End If
                    CommonFunctions.General.WriteHTML("<td align='Center'>")
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    CommonFunctions.HTMLControls.DrawTextBox("txthidFieldId", "txthidFieldId", , , , lngUniqueId.ToString(), , , , , , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    strTempName = "txthidActive_" & lngUniqueId.ToString()
                    If blnLayoutField_Active = True Then
                        strTemp = "1"
                    Else
                        strTemp = "0"
                    End If
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15

                    ''Commented and Added by Dhanashri S on 9 Dec 2015 IssueID:2646
                    ''CommonFunctions.HTMLControls.DrawTextBox(strTempName, "txthidActive", , , , strTemp, , , , , , True, EnableHTMLEncode:=True)
                    CommonFunctions.HTMLControls.DrawTextBox(strTempName, strTempName, , , , strTemp, , , , , , True, EnableHTMLEncode:=True)
                    ''End of Comment and Addition by Dhanashri S on 9 Dec 2015

                    'ended by Yogesh J for HTML encoding Date:06/10/15


                    strTempName = "chkLayoutSrNo_" & lngUniqueId.ToString
                    ''CommonFunctions.HTMLControls.DrawCheckBox(strTempName, "chkLayoutSrNo", , blnLayoutField_Active, lngLayoutSrNo.ToString(), blnMandatory, "onclick='javascript:CheckField(this, " & lngUniqueId.ToString() & ")'")

                    ''Commented and Added by Dhanashri S on 9 Dec 2015 IssueID:2646
                    ''CommonFunctions.HTMLControls.DrawCheckBox("chkLayoutSrNo_" & lngUniqueId.ToString, "chkLayoutSrNo", , blnLayoutField_Active, lngLayoutSrNo.ToString(), blnMandatory, "onclick='javascript:CheckField(this, " & lngUniqueId.ToString() & ")'")
                    CommonFunctions.HTMLControls.DrawCheckBox("chkLayoutSrNo", "chkLayoutSrNo_" & lngUniqueId.ToString, , blnLayoutField_Active, lngLayoutSrNo.ToString(), blnMandatory, "onclick='javascript:CheckField(this, " & lngUniqueId.ToString() & ")'")
                    ''End of Comment and Addition by Dhanashri S on 9 Dec 2015


                    intCheckboxCount += 1
                    CommonFunctions.General.WriteHTML("</td>")
                End If
                CommonFunctions.General.WriteHTML("</tr>")
                'shraddha
                ''i = i + 1
            End While
            ReDim arrActualColumns(arrList.Count - 1)
            'arrActualColumns.Length = arrList.Count - 1
            'arrActualColumns = arrActualColumns(arrList.Count - 1)
            arrList.ToArray.CopyTo(arrActualColumns, 0)
            CommonFunctions.General.WriteHTML("</tbody>")
            CommonFunctions.General.WriteHTML("</table></div>")
            'CommonFunctions.General.WriteHTML("</div>")
            CommonFunctions.Data.DisposeDataReader(drLayoutDetailsList)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15

            CommonFunctions.HTMLControls.DrawTextBox("txthidCheckBoxCount", "txthidCheckBoxCount", , , , intCheckboxCount.ToString(), , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
    End Sub

    Private Sub SaveLayoutDetails()
        Dim strQuery As String
        Dim strLayoutName As String
        Dim arrFieldIds() As String
        Dim strFieldId As String
        Dim strRowNumber As String
        Dim strColumnNumber As String
        Dim strActive As String
        Dim strLayoutSrNo As String
        Dim intCtr As Integer

        strQuery = "Exec usp_Ins_tbl_IB_IssueEntry_Layout_Master "
        If m_lngLayoutId > 0 Then
            strQuery &= m_lngLayoutId.ToString()
        Else
            strQuery &= "NULL "
        End If

        strLayoutName = MyBase.FixString(MyBase.GetFormValue("txtLayoutName"), 50, False, True)
        strLayoutName = CommonFunctions.General.UnBuildQueryString(strLayoutName)
        If strLayoutName <> "" Then
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strLayoutName) & "' "
        Else
            strQuery &= ", NULL"
        End If

        'Added by SonalD on 17th March 2009 for IssueId 29220
        'Purpose: to check duplication for LayoutName
        Dim strSql1 As String
        Dim inrFlag As Integer = 0

        strSql1 = "usp_sel_tbl_IB_IssueEntry_Layout_Master_Flag '" + CommonFunctions.General.BuildQueryString(strLayoutName) + "'," + m_lngLayoutId.ToString
        inrFlag = CType(CommonFunctions.Data.GetDataScalar(strSql1, MyBase.UseSQL), Integer)
        If inrFlag = 1 Then
            CommonFunctions.General.WriteHTML("<script language=javascript>")
            CommonFunctions.General.WriteHTML("alert('Layout Name already exists');")
            CommonFunctions.General.WriteHTML("</script>")
        End If
        '
        If inrFlag = 0 Then
            'End of additon by SonalD on 17th March 2009

            m_lngLayoutId = CType(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), Integer)

            arrFieldIds = MyBase.FixString(MyBase.GetFormValue("txthidFieldId"), 0, False, False).Split(CType(",", Char))
            For intCtr = 0 To arrFieldIds.Length - 1
                strQuery = "Exec usp_Ins_tbl_IB_IssueEntry_Layout_Details "
                strFieldId = arrFieldIds(intCtr)
                ''Commented and Added by Dhanashri S on 13 Oct 2015
                ''strLayoutSrNo = MyBase.FixString(MyBase.GetFormValue("chkLayoutSrNo_" & strFieldId), 0, True, True)
                strLayoutSrNo = MyBase.GetFormValue("chkLayoutSrNo_" & strFieldId)
                strActive = MyBase.FixString(MyBase.GetFormValue("txthidActive_" & strFieldId), 0, True, True)
                ''strRowNumber = MyBase.FixString(MyBase.GetFormValue("txtRowNumber_" & strFieldId), 0, True, True)
                strRowNumber = MyBase.GetFormValue("txtRowNumber_" & strFieldId)
                ''strColumnNumber = MyBase.FixString(MyBase.GetFormValue("txtColumnNumber_" & strFieldId), 0, True, True)
                strColumnNumber = MyBase.GetFormValue("txtColumnNumber_" & strFieldId)
                ''End of Comment and Addition by Dhanashri S on 13 Oct 2015 
                If strLayoutSrNo <> "" Then
                    strQuery &= strLayoutSrNo
                Else
                    strQuery &= " NULL"
                End If
                strQuery &= ", " & m_lngLayoutId.ToString()
                strQuery &= ", " & strFieldId
                strQuery &= ", " & strActive
                If strRowNumber <> "" Then
                    strQuery &= ", " & strRowNumber
                Else
                    strQuery &= ", NULL"
                End If
                If strColumnNumber <> "" Then
                    strQuery &= ", " & strColumnNumber
                Else
                    strQuery &= ", NULL"
                End If
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            Next
            'Added by SonalD on 17th March 2009
        End If
        'End of additon by SonalD on 17th March 2009

    End Sub
#End Region

#Region " Functions or Procedures Specific to Selected Field Details "
    Private Sub WritePage_FieldDetail_Mode()
        Dim strMenu As String = ""
        Dim strRightCaption As String = ""
        Dim strLayoutName As String = ""

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)

        'Display Legends
        WriteLegends()

        'Display Page Caption
        strLayoutName = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtLayoutName"))
        strRightCaption = MyBase.GetResourceString("LAYOUTNAME") & " : " & Server.HtmlEncode(strLayoutName)
        CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, m_strPageTitle, strRightCaption, , True))
        CommonFunctions.General.WriteHTML("<br>")

        'Display the Page Body
        WriteFieldDetails()

        'Display Page menu at bottom
        CommonFunctions.General.WriteHTML(strMenu)

        'Hiddene control to store the Layout name and the Compulsory fields
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtLayoutName", "txtLayoutName", , , , strLayoutName, , , , , , True, , False, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
    End Sub

    Private Sub WriteFieldDetails()
        Dim strQuery As String
        Dim drFieldDetails As IDataReader
        Dim blnFieldMandatory As Boolean = False      'Used to make the Mandatory field disabled in the Page
        Dim blnFieldCompulsory As Boolean = False

        'Fields
        Dim strFieldName As String
        Dim strFieldCaption As String
        Dim blnMandatory As Boolean
        Dim blnReadOnlyInAddMode As Boolean
        Dim blnReadOnlyInEditMode As Boolean
        Dim blnShowInAddMode As Boolean
        Dim blnShowInEditMode As Boolean
        Dim intRowNumber As Integer
        Dim intColumnNumber As Integer

        ''Added BY Nikhil Adkar 
        Dim blnMandatoryInAdd As Boolean
        Dim blnMandatoryInEdit As Boolean
        ''End of Added BY Nikhil Adkar

        'Compulsory Fields
        'Code commented By DipaliS 1 July 2004 And Added the Following
        'Dim arrCompulsoryFields() As String = {"SUMMARY", "DESCRIPTION", "TYPE", "STATUS", "SUBTYPE", "REPORTEDBY", "REPORTEDDATE"}
        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Reported Time Feature
        'Date   :   1 July 2004
        'Requirement No.:IB_PBN_ENT_04
        'Addition   :   Added field Reported Time in the array of compulsory fields
        Dim arrCompulsoryFields() As String = {"SUMMARY", "DESCRIPTION", "TYPE", "STATUS", "SUBTYPE", "REPORTEDBY", "REPORTEDDATE", "REPORTEDTIME"}
        '********End Addition*******
        'Mandatory Fields
        'Code commented By DipaliS 1 July 2004 And Added the Following
        'Dim arrMandatoryFields() As String = {"SUMMARY", "DESCRIPTION", "TYPE", "STATUS", "REPORTEDBY", "REPORTEDDATE"}
        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Reported Time Feature
        'Date   :   1 July 2004
        'Requirement No.:IB_PBN_ENT_04
        'Addition   :   Added field Reported Time in the array of mandatory fields
        Dim arrMandatoryFields() As String = {"SUMMARY", "DESCRIPTION", "TYPE", "STATUS", "REPORTEDBY", "REPORTEDDATE", "REPORTEDTIME"}
        '********End Addition*******


        strQuery = "Exec usp_Sel_tbl_IB_IssueEntry_Layout_Details NULL, " & m_lngLayoutId & ", " & m_lngFieldId
        drFieldDetails = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drFieldDetails) <> "" Then
            If drFieldDetails.Read() Then
                strFieldName = drFieldDetails.Item("FieldName").ToString()
                strFieldName = CommonFunctions.General.UnBuildQueryString(strFieldName)
                strFieldCaption = drFieldDetails.Item("UserFriendlyName").ToString()
                strFieldCaption = CommonFunctions.General.UnBuildQueryString(strFieldCaption)
                blnMandatory = CType(CommonFunctions.Data.CheckIsDBNull(drFieldDetails.Item("Mandatory"), "False"), Boolean)
                blnReadOnlyInAddMode = CType(CommonFunctions.Data.CheckIsDBNull(drFieldDetails.Item("ReadOnlyInAddMode"), "False"), Boolean)
                blnReadOnlyInEditMode = CType(CommonFunctions.Data.CheckIsDBNull(drFieldDetails.Item("ReadOnlyInEditMode"), "False"), Boolean)
                blnShowInAddMode = CType(CommonFunctions.Data.CheckIsDBNull(drFieldDetails.Item("ShowInAddMode"), "False"), Boolean)
                blnShowInEditMode = CType(CommonFunctions.Data.CheckIsDBNull(drFieldDetails.Item("ShowInEditMode"), "False"), Boolean)
                intRowNumber = CType(CommonFunctions.Data.CheckIsDBNull(drFieldDetails.Item("RowNumber"), "0"), Integer)
                intColumnNumber = CType(CommonFunctions.Data.CheckIsDBNull(drFieldDetails.Item("ColumnNumber"), "0"), Integer)
                blnMandatoryInAdd = CType(CommonFunctions.Data.CheckIsDBNull(drFieldDetails.Item("MandatoryInAdd"), "False"), Boolean)
                blnMandatoryInEdit = CType(CommonFunctions.Data.CheckIsDBNull(drFieldDetails.Item("MandatoryInEdit"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drFieldDetails)

        CommonFunctions.General.WriteHTML("<div id='divList' style='overflow:auto;width:100%;'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing='0' width='99.9%'>")

        'Row 1
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'> <td align='right' width='40%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FIELDNAME") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td><td align='left'>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtFieldName", "txtFieldName", , , , strFieldCaption, , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidFieldId", "txthidFieldId", , , , m_lngFieldId.ToString(), , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td></tr>")

        'Row 2
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'> <td align='right' width='40%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ROWNO") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td><td align='left'>")
        If IsFieldPresentInArray(m_arrNbyAFields, strFieldName) = False Then
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtRowNumber", "txtRowNumber", , 35, 2, intRowNumber.ToString(), "right", , , , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            CommonFunctions.General.WriteHTML(m_strNByA)
        End If
        CommonFunctions.General.WriteHTML("</td></tr>")

        'Row 3
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'> <td align='right' width='40%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COLUMNNO") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td><td align='left'>")
        If IsFieldPresentInArray(m_arrNbyAFields, strFieldName) = False Then
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtColumnNumber", "txtColumnNumber", , 35, 2, intColumnNumber.ToString(), "right", , , , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            CommonFunctions.General.WriteHTML(m_strNByA)
        End If
        CommonFunctions.General.WriteHTML("</td></tr>")

        'Row 4
        ''Commented BY Nikhil Adkar on 21-Dec-2022 for removing common Mandatory check box
        'CommonFunctions.General.WriteHTML("<tr class='clsTREven'> <td align='right' width='40%'>")
        'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MANDATORY") & "&nbsp;")
        'CommonFunctions.General.WriteHTML("</td><td align='left'>")
        'If IsFieldPresentInArray(arrMandatoryFields, strFieldName) Then
        '    blnFieldMandatory = True
        '    blnMandatory = True
        'End If
        '' For KeyWords the Mandatory checkbox must be unchecked and disabled.						
        'If strFieldName = "Keywords" Then
        '    blnFieldMandatory = True
        '    blnMandatory = False
        'End If
        'CommonFunctions.HTMLControls.DrawCheckBox("chkMandatory", "chkMandatory", , blnMandatory, "1", blnFieldMandatory, "OnClick='chkMandatory_OnClick()'")
        ''Commented and added by Yogesh J for HTML encoding Date:06/10/15
        'CommonFunctions.HTMLControls.DrawTextBox("txthidMandatory", "txthidMandatory", , , , , , , , , , True, EnableHTMLEncode:=True)
        ''ended by Yogesh J for HTML encoding Date:06/10/15
        'CommonFunctions.General.WriteHTML("</td></tr>")
        ''End of Commented BY Nikhil Adkar on 21-Dec-2022
        CommonFunctions.General.WriteHTML("</table><br>")

        If IsFieldPresentInArray(arrCompulsoryFields, strFieldName) Then
            blnFieldCompulsory = True
            blnShowInAddMode = True
            blnShowInEditMode = True
        End If
        If IsFieldPresentInArray(arrMandatoryFields, strFieldName) Then

            blnFieldMandatory = True
            blnMandatory = True
        End If
        'Add New Mode 
        CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("ADDNEWMODE"), , , True))
        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing='0' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' width='20%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHOW"))
        CommonFunctions.General.WriteHTML("</td><td>")
        CommonFunctions.HTMLControls.DrawCheckBox("chkShowInAddMode", "chkShowInAddMode", , blnShowInAddMode, "1", blnFieldCompulsory, "OnClick= 'chkShowInAddMode_onclick()'")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidShowInAddMode", "txthidShowInAddMode", , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td><td width='30%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("EDITABLE"))
        CommonFunctions.HTMLControls.DrawCheckBox("chkReadOnlyInAddMode", "chkReadOnlyInAddMode", , Not blnReadOnlyInAddMode, "1", Not blnShowInAddMode)
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidReadOnlyInAddMode", "txthidReadOnlyInAddMode", , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td>")
        ''Added By Nikhi Adkar on 21-Dec-2022 for Adding seperate Mandatory Check box for Add Mode
        CommonFunctions.General.WriteHTML("<td width='30%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MANDATORY") & "&nbsp;")
        CommonFunctions.HTMLControls.DrawCheckBox("chkMandatoryAdd", "chkMandatoryAdd",, blnMandatoryInAdd,, blnFieldMandatory, "OnClick='chkMandatoryAdd_OnClick()'")
        CommonFunctions.HTMLControls.DrawTextBox("txthidMandatoryInAddMode", "txthidMandatoryInAddMode", , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.General.WriteHTML("</td>")
        ''End Of Added By Nikhil A on 21-Dec-2022 
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("<br>")

        'Edit Mode 
        CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("EDITMODE"), , , True))
        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing='0' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' width='20%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHOW"))
        CommonFunctions.General.WriteHTML("</td><td>")
        CommonFunctions.HTMLControls.DrawCheckBox("chkShowInEditMode", "chkShowInEditMode", , blnShowInEditMode, "1", blnFieldCompulsory, "OnClick= 'chkShowInEditMode_onclick()'")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidShowInEditMode", "txthidShowInEditMode", , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td><td width='30%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("EDITABLE"))
        CommonFunctions.HTMLControls.DrawCheckBox("chkReadOnlyInEditMode", "chkReadOnlyInEditMode", , Not blnReadOnlyInEditMode, "1", Not blnShowInEditMode)
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidReadOnlyInEditMode", "txthidReadOnlyInEditMode", , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td>")
        ''Added By Nikhi Adkar on 21-Dec-2022 for Adding seperate Mandatory Check box for Add Mode
        CommonFunctions.General.WriteHTML("<td width='30%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MANDATORY") & "&nbsp;")
        CommonFunctions.HTMLControls.DrawCheckBox("chkMandatoryEdit", "chkMandatoryEdit",, blnMandatoryInEdit,, blnFieldMandatory, "OnClick='chkMandatoryEdit_OnClick()'")
        CommonFunctions.HTMLControls.DrawTextBox("txthidMandatoryInEditMode", "txthidMandatoryInEditMode", , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.General.WriteHTML("</td>")
        ''End Of Added By Nikhil A on 21-Dec-2022 
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML("</div>")

        'Hiddene control, Used to store true/false if field is compulsory or not.
        'This control is used to disabled or enabled the show checkbox in Add mode when chkMandatory is checked or unchecked
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidIsCompulsoryField", "txthidIsCompulsoryField", , , , IsFieldPresentInArray(arrCompulsoryFields, strFieldName).ToString(), , , , , , True, , False, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
    End Sub

    Private Sub SaveFieldDetails()
        Dim strQuery As String
        Dim intRowNumber As Integer
        Dim intColumnNumber As Integer

        strQuery = "Exec usp_Upd_tbl_IB_IssueEntry_Layout_Details NULL"
        strQuery &= ", " & m_lngLayoutId.ToString()
        strQuery &= ", " & m_lngFieldId.ToString()

        intRowNumber = CType("0" & MyBase.FixString(MyBase.GetFormValue("txtRowNumber"), 0, True, False), Integer)
        If intRowNumber > 0 Then
            strQuery &= ", " & intRowNumber.ToString()
        Else
            strQuery &= ", 0"
        End If
        intColumnNumber = CType("0" & MyBase.FixString(MyBase.GetFormValue("txtColumnNumber"), 0, True, False), Integer)
        If intColumnNumber > 0 Then
            strQuery &= ", " & intColumnNumber.ToString()
        Else
            strQuery &= ", 0"
        End If

        strQuery &= ", " & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidShowInAddMode"), "0")
        strQuery &= ", " & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidReadOnlyInAddMode"), "0")
        strQuery &= ", " & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidShowInEditMode"), "0")
        strQuery &= ", " & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidReadOnlyInEditMode"), "0")
        ''strQuery &= ", " & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidMandatory"), "0")
        strQuery &= ", 0"
        strQuery &= ", " & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidMandatoryInAddMode"), "0")
        strQuery &= ", " & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidMandatoryInEditMode"), "0")


        strQuery &= ", 1"

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    End Sub

    Public Function GenerateLayoutArray() As String
        Dim strScript As String
        Dim drRows As IDataReader
        Dim strQuery As String
        Dim intRow As Integer
        Dim intCol As Integer
        Dim strFieldName As String
        Dim intCnt As Integer

        'add by PrashantD on 27,Nov 2007 for IssueID=15219
        Dim strJSArrayScript As String
        Dim intMaxRowNumber As Integer = 0
        'end add PrashantD

        strQuery = "Exec usp_Sel_tbl_IB_DataDictionary NULL, " & m_lngLayoutId.ToString()
        drRows = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drRows) <> "" Then
            'comment PrashantD on 27,Nov 2007 for IssueID=15219
            'strScript = "var iCnt, arrLayout = new Array(" & MAXROW & ");" & vbCrLf
            'For intCnt = 0 To MAXROW - 1
            '    strScript &= "arrLayout[" & intCnt & "]= new Array(" & MAXCOLUMN & ");" & vbCrLf
            'Next
            'end of comment PrashantD
            'add by PrashantD on 27,Nov 2007 for IssueID=15219
            'Purpose:To remove JS Error when saved the data by putting row number as 30 as tried to save the same from the edit mode
            strScript = ""
            'end of addition by PrashantD
            While drRows.Read()
                intRow = CType(CommonFunctions.Data.CheckIsDBNull(drRows.Item("RowNumber"), "-1"), Integer)
                intCol = CType(CommonFunctions.Data.CheckIsDBNull(drRows.Item("ColumnNumber"), "-1"), Integer)
                strFieldName = drRows.Item("UserFriendlyName").ToString()
                strFieldName = CommonFunctions.General.UnBuildQueryString(strFieldName)
                If intRow <> -1 And intCol <> -1 Then
                    strScript &= "arrLayout[" & intRow.ToString() & "][" & intCol.ToString() & "]= '" & strFieldName & "';" & vbCrLf
                End If
                'add by PrashantD on 27,Nov 2007 for IssueID=15219
                If intMaxRowNumber < intRow Then
                    intMaxRowNumber = intRow
                End If
                'end of add
            End While
            'add by PrashantD on 27,Nov 2007 for IssueID=15219
            If intMaxRowNumber < MAXROW Then
                intMaxRowNumber = MAXROW
            End If
            strJSArrayScript = "var iCnt, arrLayout = new Array(" & intMaxRowNumber + 2 & ");" & vbCrLf
            For intCnt = 0 To intMaxRowNumber + 1
                strJSArrayScript &= "arrLayout[" & intCnt & "]= new Array(" & MAXCOLUMN & ");" & vbCrLf
            Next
            strScript = strJSArrayScript + strScript
            'End PrashantD
        End If
        CommonFunctions.Data.DisposeDataReader(drRows)
        Return strScript
    End Function
#End Region

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If Args.LinkName = m_arrMenuItem(MenuIndex.SET_AS_DEFAULT) Then
            Args.FunctionName = "SetDefault_OnClick(" & m_lngLayoutId & ")"
        End If
        ' Modified by MahendraV on 6:13 PM 8/14/2007
        ' If there is no access then save link will be displayed 
        ' Start_MV_8/14/2007
        If Args.LinkName = "Save" And (m_objAccessRights.Add = False Or _
                                        m_objAccessRights.Delete = False Or _
                                        m_objAccessRights.Edit = False Or _
                                        m_objAccessRights.View = False) Then
            Cancel = True
        End If
        If (Args.LinkName = "Add" And m_objAccessRights.Add = False) Or _
           ((Args.LinkName = "Delete" Or Args.LinkName = "Select All") And m_objAccessRights.Delete = False) Then
            Cancel = True
        End If
        ' End_MV_8/14/2007
        If m_strPageMode <> MODE_LAYOUTDETAILS Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.SELECTALL) Or
                Args.LinkName = m_arrMenuItem(MenuIndex.SET_AS_DEFAULT) Or
                 Args.LinkName = m_arrMenuItem(MenuIndex.CLEARALL) Then
                Cancel = True
            End If
        Else
            If m_lngLayoutId = 0 And Args.LinkName = m_arrMenuItem(MenuIndex.SET_AS_DEFAULT) Then
                Cancel = True
            End If
        End If

    End Sub
End Class
