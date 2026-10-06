Imports CommonFunctions

Public Class PM_QuantitativeObjectives
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
    Protected Const MODE_LIST As String = "List"
    Protected Const MODE_SHOW_REVISION As String = "ShowRevision"
    'aded by SachinR   On  18 May 2004
    Protected Const CONST_MODE_ADDMETRIC As String = "MetricAdd"
    Protected Const CONST_ACTION_ADD As String = "ADD"
    'adtion end

    Private Enum MenuIndex
        ADDNEW
        SAVE
        SAVE_WITH_REVISION
        CLOSE
        HELP
    End Enum
#End Region

#Region " Class scope Variables Declarations "
    Private m_strNbyA As String = ""
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private m_blnTotalPrinted As Boolean = False

    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(4) As String
    Private m_arrMenuTooltip(4) As String
    Private m_arrClientSideFunctions(4) As String

    Private m_strPageTitle As String = ""
    Protected m_lngTagId As Long = 0
    Protected m_strMode As String = ""
    Private m_strAction As String = ""
    Private m_lngProjectId As Long = 0
    Private m_intShowFLAG As Integer = 0
    Private m_lngPMIId As Long
    Private m_strCategory As String = ""
    Private m_intRowNumber As Integer = 0
    Protected m_PKToken As String = ""
    Protected m_QueryTagid As String = ""
    Protected m_QueryPKToken As String = ""


#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim strQuery As String = ""
        'Put user code to initialize the page here
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        InitPageMenu()
        ''Addded by Nilesh g on 1/2/2016 for URL issue
        m_lngTagId = m_objGlobal.TagID
        m_lngProjectId = m_objGlobal.ProjectID
        m_strMode = Request.QueryString("Mode") & ""
        If Trim(Request.QueryString("PKToken") & "") <> "" Then
            m_QueryPKToken = Request.QueryString("PKToken")
        End If
        If Trim(Request.QueryString("MasterTagId") & "") <> "" Then
            m_QueryTagid = Request.QueryString("MasterTagId")
        End If
        ''Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        'If (m_QueryPKToken <> "") Then
        If (m_QueryTagid <> "" And m_strMode = "MetricAdd") Then
            ''If (m_QueryPKToken = "" Or CommonFunctions.Security.Token.ValidateToken(CType(m_QueryTagid, String) + "0" + "0", m_QueryPKToken) = False) Then
            If (((m_QueryPKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(m_QueryTagid, String) + "0" + "0", m_QueryPKToken) = False)) Then
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End of Addition by Dhanashri S on 11 Aug 2016
        ''enddded by Nilesh g on 1/2/2016 for URL issue
        If m_strMode = "" Then m_strMode = MODE_LIST

        m_strAction = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txthidAction"))

        If m_strMode = MODE_LIST Then
            m_strPageTitle = MyBase.GetResourceString("QUANTITATIVE_OBJECTIVES")

            'Get value of PMI Id
            strQuery = "EXEC usp_Sel_GetPMIID " & m_lngProjectId.ToString()
            m_lngPMIId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)

            If m_strAction = ACTION_SAVE Then
                Save_TaskAttributes()
            End If
        ElseIf m_strMode = MODE_SHOW_REVISION Then
            m_strPageTitle = MyBase.GetResourceString("SAVE_WITH_REVISIONS")
        Else
            m_strPageTitle = MyBase.GetResourceString("PAGE_CAPTION_ADD_METRIC")
        End If
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_QuantitativeObjectives", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PM_QunatativeObjectives : " & UserInput & " " & Cause
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

    Public Sub WritePage()
        Dim strQuery As String = ""
        Dim strValue As String = ""
        Dim strMenu As String
        m_PKToken = CommonFunctions.Security.Token.GetToken(CType(m_lngTagId, String) + "0" + "0")
        'modified by SachinR    on 18 May 2004
        Select Case (m_strMode)
            Case CONST_MODE_ADDMETRIC

                'update the data based on the action
                If m_strAction = CONST_ACTION_ADD Then
                    Call AddMetricToProject()
                End If

                Dim arrMenu As System.Collections.ArrayList
                Dim arrMenuToolTip As System.Collections.ArrayList
                Dim arrClientSideFunctions As System.Collections.ArrayList

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                'if page is in edit mode then only show send mail menu
                arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("SaveMetric_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('QUANTITATIVE')")

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

                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                MyBase.InitializeResources("AppResources.PM_QuantitativeObjectives", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_ADD_METRIC"))
                General.WriteHTML("<BR>")

                'plot the grid to show the list of metrics
                Call plotMetricsList()

                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)
                'modification end
            Case Else

                If m_strMode = MODE_LIST Then
                    'Get Show Flag
                    strQuery = "EXEC usp_Sel_ProjectType 2," & m_lngProjectId.ToString()
                    If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)) = "" Then
                        m_intShowFLAG = 1
                    Else
                        m_intShowFLAG = 0
                    End If

                    'Get Objective Value
                    strValue = GetObjective_Value()

                    strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
                Else
                    strMenu = WriteMenu_ModalWindow()
                End If
                'Display the Menu
                CommonFunctions.General.WriteHTML(strMenu)
                CommonFunctions.General.WriteHTML("<br>")

                If m_strMode = MODE_LIST Then
                    'Display Page Caption
                    CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
                    CommonFunctions.General.WriteHTML("<br>")

                    If m_lngPMIId = 0 Or m_intShowFLAG = 1 Then
                        CommonFunctions.General.WriteHTML("<div id=divList style='OVERFLOW: auto; HEIGHT: 100%'>")
                        CommonFunctions.General.WriteHTML("<TABLE cellSpacing=0 width='99.9%' class='clsTable'>")
                        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD width='65%' align='center'>")
                        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NO_ITEMS"))
                        CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")
                        CommonFunctions.General.WriteHTML("</div>")
                    Else
                        'Display Text area
                        CommonFunctions.General.WriteHTML("<TABLE cellSpacing=0 width='99.9%' class='clsTable'>")
                        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>")
                        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("STRATEGY_TO_ACHIEVE_QUANTATIVE_OBJECTIVES"))
                        CommonFunctions.General.WriteHTML("</TD></TR>")
                        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>")
                        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtObjective", "txtObjective", widthInPixel:=750, heightInPixel:=52, maxlength:=20, value:=strValue, returnHTML:=True))
                        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtObjective", "txtObjective", widthInPixel:=750, heightInPixel:=52, maxLength:=20, value:=strValue, returnHTML:=True, EnableHTMLEncode:=True))
                        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")

                        CommonFunctions.General.WriteHTML("<BR>")
                        'Display Page Body
                        Display_ObjectivesList()
                    End If
                ElseIf m_strMode = MODE_SHOW_REVISION Then
                    'Display Text area
                    CommonFunctions.General.WriteHTML("<div id=divList style='OVERFLOW: auto; HEIGHT: 100%'>")
                    CommonFunctions.General.WriteHTML("<BR>")
                    CommonFunctions.General.WriteHTML("<TABLE cellSpacing=0 width='99.9%' class='clsTable'>")
                    CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD valign='top'>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("REASON_FOR_REVISION"))
                    CommonFunctions.General.WriteHTML("</TD><TD>")
                    'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtRevision", "txtRevision", widthInPixel:=441, heightInPixel:=70, maxlength:=1000, value:=strValue, returnHTML:=True))
                    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtRevision", "txtRevision", widthInPixel:=441, heightInPixel:=70, maxLength:=1000, value:=strValue, returnHTML:=True, EnableHTMLEncode:=True))
                    'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")
                    CommonFunctions.General.WriteHTML("<BR>")
                    CommonFunctions.General.WriteHTML("</div>")
                End If

                'Display Menu at Footer
                CommonFunctions.General.WriteHTML(strMenu)

        End Select


        'Hidden Controls
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidAction", "txthidAction", , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidData", "txthidData", , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidRowCount", "txthidRowCount", , , , m_intRowNumber.ToString(), , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
    End Sub

    Private Function GetObjective_Value() As String
        Dim strQuery As String = ""
        Dim drWork As IDataReader
        Dim lngMetricId As Long = 0
        Dim strValue As String = ""

        strQuery = "EXEC usp_Sel_PMI_Information " & m_lngPMIId.ToString() & "," & m_lngProjectId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                lngMetricId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("MetricID"), "0"), Long)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        strQuery = "EXEC usp_Sel_PMI_Metric_ProjectValue " & m_lngPMIId.ToString() & "," & m_lngProjectId.ToString()
        strQuery &= "," & lngMetricId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                strValue = CommonFunctions.Data.CheckIsDBNull(drWork.Item("Objective"), "").ToString()
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        Return strValue
    End Function

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'modified by SachinR    On 18 May 2004
        m_arrMenuItem(MenuIndex.ADDNEW) = MyBase.GetResourceString("MENU_ADDNEW")
        m_arrMenuTooltip(MenuIndex.ADDNEW) = MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ADDNEW) = "AddNew_OnClick()"
        'modification end

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.SAVE_WITH_REVISION) = MyBase.GetResourceString("MENU_SAVE_WITH_REVISION")
        m_arrMenuTooltip(MenuIndex.SAVE_WITH_REVISION) = MyBase.GetResourceString("MENU_SAVE_WITH_REVISION_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE_WITH_REVISION) = "SaveRevision_OnClick()"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('QUANTITATIVE')"

        MyBase.InitializeResources("AppResources.PM_QuantitativeObjectives", "AppResources")
    End Sub

    Private Sub Display_ObjectivesList()
        Dim strQuery As String = ""
        Dim intTotalColumns As Integer = 4
        Dim arrActualColumns(intTotalColumns - 1) As String
        Dim arrUserFriendlyColumn(intTotalColumns - 1) As String
        Dim arrTDStyle(intTotalColumns - 1) As String
        Dim arrGroup() As String = {"1"}
        Dim intIndex As Integer = 0
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Initialize the Required arrays for the advanced grid
        arrUserFriendlyColumn(intIndex) = ""
        arrActualColumns(intIndex) = "CategoryName"
        arrTDStyle(intIndex) = "width='0%'"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("GOALS")
        arrActualColumns(intIndex) = "Name"
        arrTDStyle(intIndex) = "width='50%'"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("NORMS")
        arrActualColumns(intIndex) = ""
        arrTDStyle(intIndex) = "align='left' width='25%'"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("TARGET_SET_FOR_PROJECT")
        arrActualColumns(intIndex) = ""
        arrTDStyle(intIndex) = "align='left' width='25%'"
        intIndex += 1

        strQuery = "EXEC usp_Sel_PMI_Information " & m_lngPMIId.ToString() & "," & m_lngProjectId.ToString()

        'Set the Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .GroupOnColumn = arrGroup
            .PrimaryKey = "Name"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            .DIVHeight = 240
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intTotalColumns
            .returnHTML = True
            .ColNameToolTipOnEachRow = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub Save_TaskAttributes()
        Dim strQuery As String = ""
        Dim strData As String = ""
        Dim intRowCount As Integer = 0
        Dim strNorms As String = ""
        Dim strMetricId As String = ""
        Dim strObjective As String = ""
        Dim intCount As Integer = 0

        strObjective = MyBase.FixString(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtObjective")), 2000, False, False)
        strObjective = CommonFunctions.General.UnBuildQueryString(strObjective.Trim())
        strData = MyBase.FixString(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidData")), 1000, False, False)
        strData = CommonFunctions.General.UnBuildQueryString(strData.Trim())

        If strData <> "" Then
            strQuery = "EXEC usp_ins_Save_Revisions 2," & m_lngProjectId.ToString()
            strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
            strQuery &= ",'" & CommonFunctions.General.BuildQueryString(strData) & "'"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If
        intRowCount = CType(MyBase.FixString(MyBase.GetFormValue("txthidRowCount"), 0, False, False), Integer)
        For intCount = 1 To intRowCount
            strNorms = MyBase.GetFormValue("txtNorms" & intCount)
            'Addtion By PrachiK on 26 Feb 2005 for Issue ID. 16260
            'Purpose: For a particular Metric , Enter a value as '+96' in the field 'Target set for this project',The page crashes.
            Dim intPos As Integer
            If strNorms = "" Then
                strNorms = "0"
            Else
                Dim intLength As Integer
                intLength = Len(strNorms)   ' Returns length
                intPos = InStr(1, strNorms, "+", CompareMethod.Text)
                If intPos >= 1 Then
                    strNorms = Right(strNorms, intLength - 1) ' string 
                End If


                'Addtion ended
                End If
                strMetricId = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidMetric" & intCount))
                If strMetricId = "" Then strMetricId = "0"

                'strQuery = "EXEC usp_ins_Quantitative_Objectives " & m_lngPMIId.ToString() & ", " & m_lngProjectId.ToString()
                'strQuery &= "," & strMetricId & "," & strNorms
                'strQuery &= ",'" & CommonFunctions.General.BuildQueryString(strObjective) & "'"


                'modified by SachinR    On 19 May 2004
                strQuery = "EXEC usp_ins_Quantitative_Objectives_NewMetric " + m_lngPMIId.ToString() + ", " + m_lngProjectId.ToString()
                strQuery += "," + strMetricId + "," + strNorms
                strQuery += ",'" + CommonFunctions.General.BuildQueryString(strObjective) + "'"
                'modification end
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        Next
    End Sub

    Private Function WriteMenu_ModalWindow() As String
        Dim strMenu As String = ""

        strMenu &= "<Table class=clsTable cellspacing=0 cellpadding=0 width='99.9%'>"
        strMenu &= "<TR class=clsTRMenu><TD align=Right>"
        strMenu &= "&nbsp;|&nbsp;"
        strMenu &= "<A class='Menu' style='' HREF=# onclick=""" & m_arrClientSideFunctions(MenuIndex.SAVE) & """ "
        strMenu &= "Title=" & m_arrMenuTooltip(MenuIndex.SAVE) & " >" & m_arrMenuItem(MenuIndex.SAVE) & "</A>"
        strMenu &= "&nbsp;|&nbsp;"
        strMenu &= "<A class='Menu' style='' HREF=# onclick=""" & m_arrClientSideFunctions(MenuIndex.CLOSE) & """ "
        strMenu &= "Title=" & m_arrMenuTooltip(MenuIndex.CLOSE) & " >" & m_arrMenuItem(MenuIndex.CLOSE) & "</A>"
        strMenu &= "&nbsp;|&nbsp;"
        strMenu &= "<A class='Menu' style='' HREF=# onclick=""" & m_arrClientSideFunctions(MenuIndex.HELP) & """ "
        strMenu &= "Title=" & m_arrMenuTooltip(MenuIndex.HELP) & " >" & m_arrMenuItem(MenuIndex.HELP) & "</A>"
        strMenu &= "&nbsp;|&nbsp;"
        strMenu &= "</TD></TR></TABLE>"

        Return strMenu

    End Function

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If m_strMode = MODE_LIST Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.CLOSE) Then Cancel = True
            If m_objAccessRights.Add = False And m_objAccessRights.Edit = False Then
                If m_intShowFLAG <> 1 Then
                    If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Then Cancel = True
                    If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE_WITH_REVISION) Then Cancel = True
                End If
            End If
        ElseIf m_strMode = MODE_SHOW_REVISION Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE_WITH_REVISION) Then Cancel = True
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strQuery As String = ""
        Dim drWork As IDataReader
        Dim strAbove As String = ""
        Dim strBelow As String = ""
        Dim strValue As String = ""

        If Args.ColIndex = 2 Or Args.ColIndex = 3 Then
            strQuery = "EXEC usp_Sel_PMI_Metric_ProjectValue_ForGrid " + m_lngProjectId.ToString()
            strQuery &= "," & CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("MetricID"), "0").ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    strValue = CommonFunctions.Data.CheckIsDBNull(drWork.Item("ProjectValue"), "").ToString()
                    strValue = CommonFunctions.General.UnBuildQueryString(strValue)
                    If strValue = "0" Then strValue = ""
                    strAbove = CommonFunctions.Data.CheckIsDBNull(drWork.Item("Above"), "").ToString()
                    strAbove = CommonFunctions.General.UnBuildQueryString(strAbove)
                    strBelow = CommonFunctions.Data.CheckIsDBNull(drWork.Item("Below"), "").ToString()
                    strBelow = CommonFunctions.General.UnBuildQueryString(strBelow)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)

            If Args.ColIndex = 2 Then
                If m_strCategory <> Args.DataReader.Item("CategoryName").ToString() Then
                    m_strCategory = Args.DataReader.Item("CategoryName").ToString()
                    Args.StringToBeInserted = "<TD align=left width='25%' title='" + Args.ColumnName + "'>"
                    Args.StringToBeInserted &= FormatNumber(strBelow, 4) & " - " & FormatNumber(strAbove, 4)
                    Args.StringToBeInserted &= " " & CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("UnitName"), "").ToString() & "</TD>"
                    Cancel = True
                Else
                    m_strCategory = Args.DataReader.Item("CategoryName").ToString()
                    Args.StringToBeInserted = "<TD align=left width='25%' title='" + Args.ColumnName + "'>"
                    Args.StringToBeInserted &= FormatNumber(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Below"), "").ToString(), 4)
                    Args.StringToBeInserted &= " - " & FormatNumber(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Above"), "").ToString(), 4)
                    Args.StringToBeInserted &= " " & CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("UnitName"), "").ToString()
                    Args.StringToBeInserted &= "</TD>"
                    Cancel = True
                End If
            ElseIf Args.ColIndex = 3 Then
                Args.StringToBeInserted = "<TD align=left width='25%' title='" + Args.ColumnName + "'>"
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txtNorms" & m_intRowNumber.ToString(), "txtNorms" & m_intRowNumber.ToString(), , 44, 10, strValue, "Right", returnHTML:=True, EnableHTMLEncode:=True)
                Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txthidMetric" & m_intRowNumber.ToString(), "txthidMetric" & m_intRowNumber.ToString(), value:=CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("MetricID"), "").ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                Args.StringToBeInserted &= " " & CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("UnitName"), "").ToString()
                Args.StringToBeInserted &= "</TD>"
                Cancel = True
            End If
        End If
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
        End If
    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        m_intRowNumber += 1
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotMetricsList
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw the grid for the list of metrtics which are not added the project.
    ' Description			:	This procedure will the grid for the metrics which are not added to the grid.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	May 18 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotMetricsList()
        Dim objGrid As WebPage.Templates.GenericGrid
        Dim strSQL As String

        Dim arrColHeader() As String = {MyBase.GetResourceString("COL_METRICS"), MyBase.GetResourceString("COL_SELECT")}
        Dim arrAN() As String = {"Name", ""}
        Dim arrCheckBox() As String = {"", "chkSelect"}
        Dim arrTDStyle() As String = {"align=left", "align=center"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = "usp_sel_tbl_PRS_MetricMaster_ForProject " + m_lngProjectId.ToString

        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid
        With objGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            '.RowLinkArray = arrRowLink
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "MetricID"
            .DIVID = "DivList"
            .DIVHeight = 300
            .DIVStyle = "overflow: auto"
            .NoOfDataColumns = 1
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .EmptyValueReplacement = "-"
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        'intRowCount = m_objGrid.NoOfRows
        objGrid = Nothing
    End Sub

    '=====================================================================
    ' Procedure Name		:	AddMetricToProject
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data for adding the metric to the project.
    ' Description			:	This procedure will update the tbl_PRS_Quantitative_Objectives table
    '                           for adding new record to it for the selected metricID and projectID
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	May 18 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub AddMetricToProject()
        Dim strSQL As String
        Dim strMetricIDList As String
        Dim arrMetricID() As String

        If m_strAction = CONST_ACTION_ADD Then

            'get the IDs of selected metrics
            strMetricIDList = MyBase.GetFormValue("chkSelect") + ""

            If strMetricIDList <> "" Then
                Dim i As Integer
                arrMetricID = strMetricIDList.Split(","c)
                For i = 0 To arrMetricID.Length - 1
                    If arrMetricID(i) <> "" Then
                        'insert new record for the metric and project
                        strSQL = "usp_ins_tbl_PRS_Quantitative_Objectives_AddMetric " + m_lngProjectId.ToString + "," + arrMetricID(i).Trim
                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                    End If
                Next

                'refresh parent page
                General.WriteHTML("<Script language=javascript>")
                General.WriteHTML("opener.location.href=opener.location.href;")
                General.WriteHTML("</Script>")

            End If

        End If
    End Sub

End Class
