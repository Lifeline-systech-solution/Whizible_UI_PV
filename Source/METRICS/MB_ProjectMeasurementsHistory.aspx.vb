Option Strict On
'Imports Whizible

'**************************************************************************************************
'**  Name : MB_ProjectMeasurementsHistory.aspx                                                   **
'**  Purpose: Custom Page for ADD/UPDATE of measurement details    (WhiziblePPM)                 **
'**  Created By: Sandeep Aparajit.                                                               **
'**  Created On: 26 Sept,2005.                                                                   **
'**                                                                                              **
'**************************************************************************************************



#Region "IMPORTS"
Imports WebPages
Imports WebPages.Template
Imports WebPages.UI
Imports CommonFunctions
Imports System.Data
Imports System.Data.SqlClient
#End Region

Public Class MB_ProjectMeasurementsHistory
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

#Region "GLOBAL  VARIABLES"
    ' String variable used for storing the ID's of dynamically plotted text controls
    Dim strTextControls As String
    Dim m_strDate As String
    Dim m_ProjectID As Long
    Dim intCounter As Integer = 1
    Dim m_intPracticeID As Integer
    Dim m_intProjectID As Integer
    Private WithEvents m_cObjPageCaption As WebPage.Templates.PageCaption
    WithEvents objGrid As New WebPages.Template.GenericGrid
    Protected intIsDateGreaterthanToday As Integer
#End Region

#Region "Page Load"
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Page Load code here..
    End Sub
#End Region

#Region "INITIALIZE"
    '**************************************************************************************************
    '**  Purpose: INIT METHOD FOR STARTING THE SYSTEM. CODE CALLED FROM FORM TAG                     **
    '**************************************************************************************************
    Sub Initialize()


        '=====================================================================
        ' Procedure Name        :	Initialize
        ' Purpose               :	Initializes the page.
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SandeepA
        ' Created               :	Nov 13, 2005 
        ' Revisions             :
        '=====================================================================

        '**************************************************************************************************
        '**  Purpose: DISPLAY GRID DEPENDING ON ACTION                                                   **
        '**************************************************************************************************
        If Request("Action") Is Nothing Or Request("Action") = "Grid" Then
            ShowGrid()
        End If
        ''**************************************************************************************************
        ''**  Purpose: CALL ADD PAGE ON CLICK OF ADD BUTTON                                               **
        ''**************************************************************************************************
        If Request("Action") = "ADD" Then
            Add()
        End If
        ''**************************************************************************************************
        ''**  Purpose: SAVE/UPDATE THE DATA                                                                      **
        ''**************************************************************************************************
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"), "NULL") = "Save" Then
            Save("Save")
        End If
    End Sub
#End Region

#Region "Plot Grid"
    Sub ShowGrid()

        '=====================================================================
        ' Procedure Name        :	ShowGrid
        ' Purpose               :	Plot the Main page Grid and Filters
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SandeepA
        ' Created               :	Nov 13, 2005 
        ' Revisions             :
        '=====================================================================

        '====================================================================================================
        ' Practice and Project Filter combo change
        '====================================================================================================
        'Check the QueryString for the mode and values to display
        'For Practice Combo.(Filter)
        'If (Request.QueryString("Practice")) = "PracticeChange" Then
        '    If (Request.QueryString("cboPractice")) = "" Then
        '        m_intPracticeID = 0
        '    Else
        '        m_intPracticeID = CInt(Request.QueryString("cboPractice"))
        '    End If
        '    Session("Practice") = m_intPracticeID
        '    m_intProjectID = 0
        'End If
        ''For Project Combo.(Filter)
        'If (Request.QueryString("Project")) = "ProjectChange" Then
        '    m_intPracticeID = CInt(Session("Practice"))
        '    If (Request.QueryString("cboProject")) = "" Then
        '        m_intProjectID = 0
        '    Else
        '        m_intProjectID = CInt(Request.QueryString("cboProject"))
        '    End If
        '    Session("Project") = m_intProjectID
        'End If
        'If Session("Practice") Is Nothing And Session("Project") Is Nothing Then
        '    m_intPracticeID = 0
        '    m_intProjectID = 0
        'Else
        '    m_intPracticeID = CInt(Session("Practice"))
        '    m_intProjectID = CInt(Session("Project"))
        'End If
        m_intProjectID = CInt(Session("intProjectID"))

        '====================================================================================================
        ' ADD and HELP(?) Link Plot
        '====================================================================================================
        Dim objHeaderFooter As New WebPage.Templates.HeaderFooter
        Dim objHeaderFooter1 As New WebPage.Templates.HeaderFooter
        Dim objStaticMenu As New WebPages.Template.StaticMenu
        Dim arrmenuNames() As String = {MyBase.GetResourceString("MENU_ADD"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrmenuFunctions() As String = {"Add_Clk()", "Help()"}
        Dim arrLinkToolTip() As String = {MyBase.GetResourceString("MENU_ADD_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

        objStaticMenu.DrawMenu(arrmenuNames, arrmenuFunctions, arrLinkToolTip, False)

        'CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto;width:100%;height:525px;'>")
        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto;width:100%;'>")

        '====================================================================================================
        'Filters Combobox plot. for Practice and Project
        '====================================================================================================
        'Response.Write("<BR>")
        'Response.Write("<Table class='clsTable' align='center' cellpadding=0 cellspacing=0 width='100%'>")
        'Response.Write("<tr class=clsTRPageHeader align='center'> ")
        'Response.Write("<td align='Left'>")
        'Response.Write(MyBase.GetResourceString("CBO_PRACTICE"))
        'CommonFunction.HTMLControls.DrawComboBox("cboPractice", "usp_sel_tbl_PRS_ProjectTypes_For_cbo", 300, m_intPracticeID.ToString, "Onchange=cboPracticeChange(cboPractice)", True, , , , , , )
        'Response.Write("</td>")
        'Response.Write("<td align='Left'>")
        'Response.Write(MyBase.GetResourceString("CBO_PROJECT"))
        'CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_sel_tbl_PM_Project_For_MeasurementHistory " & m_intPracticeID, 300, m_intProjectID.ToString, "Onchange=cboProjectChange(cboProject)", True, , , , , , )
        'Response.Write("</td>")
        'Response.Write("</tr>")
        'Response.Write("</table>")
        'Response.Write("<BR>")
        '====================================================================================================
        'Display Header
        '====================================================================================================
        Response.Write("<Table class='clsTable' align='center' cellpadding=0 cellspacing=0 width='100%' height:'100%';>")
        Response.Write("<tr class='clsTRPageCaption'>")
        Response.Write("<td align='Left'>")
        Response.Write(MyBase.GetResourceString("PAGE_CAPTION"))
        Response.Write("</td>")
        Response.Write("</tr>")
        Response.Write("</Table>")
        Response.Write("<br>")
        '====================================================================================================
        'Display Grid for Measurements History 
        '====================================================================================================

        Dim strSQL As String
        Dim strSortBy As String
        Dim strSortOrder As String
        Dim arrTDStyle() As String = {"align=left", "align=left"}
        Dim arrUserFriendly() As String = {MyBase.GetResourceString("COL_PROJECT_NAME"), MyBase.GetResourceString("COL_SNAPSHOT_DATE")}
        Dim strLinkArray() As String = {"", "Project_OnClick(ProjectID,SnapShotDate)"}
        Dim arrActualValues() As String = {"ProjectName", "SnapshotDate"}
        Dim arrGroupColumn() As String = {"ProjectName"}
        Dim arrExpanded() As String = {"SnapshotDate"}
        Dim dtDTime As Date
        Dim strSNDate As String
        strSQL = "Usp_GetDate_For_Measurement " & Session("intProjectID").ToString
        dtDTime = CDate(CommonFunctions.Data.GetDataScalar(strSQL, True))
        'm_strDate = strDateTime 'Set Global Date variable
        'If snap shot date is greater that today's date then redirect to CL page
        strSNDate = dtDTime.ToString("yyyy-MM-dd")
        strSQL = "usp_Check_SnapshotDate '" & strSNDate & "'"
        intIsDateGreaterthanToday = CInt(CommonFunctions.Data.GetDataScalar(strSQL, True))

        '====================================================================================================
        'Purpose: FOR Grid SQL and Sorting                                                            
        '====================================================================================================
        If Request.QueryString("SortOrder") <> "" Then
            strSortOrder = Request.QueryString("SortOrder")
        Else
            strSortOrder = "ASC"
        End If
        'Only Project names can be sorted since the grouping is on ProjectName
        strSQL = "usp_sel_tbl_PRS_Measurements_History_For_Grid " & m_intPracticeID & "," & m_intProjectID & ",'" & strSortOrder & "'"

        '====================================================================================================
        'Configuring Grid Properties
        '====================================================================================================
        ''''Added By Vaijat K On 06/10/2015
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''''End Added By Vaijat K On 06/10/2015
        With objGrid
            .GroupOnColumn = arrGroupColumn
            .RowLinkArray = strLinkArray
            .ActualColumnArray = arrActualValues
            .UserFriendlyColumnArray = arrUserFriendly
            .TDStyleArray = arrTDStyle
            '.PrimaryKey = "MeasurementsHistoryID"
            .DIVID = "PageGridDiv" 'PageDiv"   '"" '
            '.DIVHeight = 325
            .SortBy = "ProjectName" ' strSortBy
            .SortOrder = strSortOrder
            .ClientSideSortFunctionName = "Sort_OnClick"
            .DIVStyle = "Overflow:auto;width:100%;height:100%;" '"overflow: scroll"
            .NoOfDataColumns = 2
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = True 'False ' 
            .BooleanFalseHTML = "NO"  '|false | <img src='../../images/cross.gif'>
            .BooleanTrueHTML = "YES" ' true ' <img src='../../images/check.gif'>
            .EmptyValueReplacement = " - "
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            ''''Added By Vaijat K On 06/10/2015
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''''End Added By Vaijat K On 06/10/2015
            'plot the grid 
            Response.Write(objGrid.DrawGrid())
        End With

        '====================================================================================================
        'Plot Menu at bottom
        '====================================================================================================
        CommonFunctions.General.WriteHTML("</DIV>")
        objStaticMenu.DrawMenu(arrmenuNames, arrmenuFunctions, arrLinkToolTip, False)

        Dim strFreq As String
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        'strFreq = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT ISNULL(MetricFrequencyID,'') FROM tbl_MET_ProjectAttributes WHERE PRojectID=" + HttpContext.Current.Session("intProjectID").ToString, True), "")
        strFreq = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_MET_ProjectAttributes_MetricFrequency " + HttpContext.Current.Session("intProjectID").ToString, True), "")
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFreq", "txtFreq", , , , strFreq, , , , , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFreq", "txtFreq", , , , strFreq, , , , , , True, , True, EnableHTMLEncode:=True))
        ''''End Added By Vaijat K On 06/10/2015
    End Sub
    'Event handled to remove the Sorting from SnaoShotDate Column of the Grid
    Private Sub objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "SNAPSHOTDATE" Then
            Args.ApplySorting = False
        End If
    End Sub
    'Protected Sub objGrid_After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles objGrid.
    '    Dim strFreq As String
    '    strFreq = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT ISNULL(MetricFrequencyID,'') FROM tbl_MET_ProjectAttributes WHERE PRojectID=" + HttpContext.Current.Session("intProjectID").ToString, True), "")
    '    CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFreq", "txtFreq", , , , strFreq, , , , , , True, , True))
    'End Sub
#End Region

#Region "ADD"

    Sub Add()
        '=====================================================================
        ' Procedure Name        :	Add
        ' Purpose               :	Handles the ADD/EDIT mode page
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SandeepA
        ' Created               :	Nov 13, 2005 
        ' Revisions             :
        '=====================================================================


        Dim strProjectID As String
        Dim strMode As String
        Dim strFrequency As String
        Dim strCboChange As String
        Dim strIsProjectCompleted As String
        Dim strProjectName As String
        Dim blnUseSQl As Boolean
        Dim strSQL As String
        ' Dim intIsDateGreaterthanToday As Integer
        Dim FromWhere As String
        Dim arrmenuNames(2) As String
        Dim arrmenuFunctions(2) As String
        Dim arrLinkToolTip(2) As String
        Dim strDateTime As String
        Dim strSnapshotdate As String
        Dim dtDateTime As Date
        Dim strShowDateTime As String
        Dim objHeaderFooter As New WebPage.Templates.HeaderFooter
        Dim objHeaderFooter1 As New WebPage.Templates.HeaderFooter
        Dim objStaticMenu As New WebPages.Template.StaticMenu


        'Check if the page is called from Update Metric
        FromWhere = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "NULL"))
        If FromWhere = "UPDATEMETRIC" Then
            arrmenuNames(0) = MyBase.GetResourceString("MENU_SAVE") '"Save"
            arrmenuNames(1) = MyBase.GetResourceString("MENU_CLOSE") '"Close"
            arrmenuNames(2) = MyBase.GetResourceString("MENU_HELP") '"?"
            arrmenuFunctions(0) = "Save_UpdateMetric_OnClick()"
            arrmenuFunctions(1) = "Close_OnClick()"
            arrmenuFunctions(2) = "Help()"
            arrLinkToolTip(0) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP") '"Save"
            arrLinkToolTip(1) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP") '"Close"
            arrLinkToolTip(2) = MyBase.GetResourceString("MENU_HELP_TOOLTIP") '"Help"
        Else
            arrmenuNames(0) = MyBase.GetResourceString("MENU_SAVE") '"Save"
            arrmenuNames(1) = MyBase.GetResourceString("MENU_BACK") '"Back"
            arrmenuNames(2) = MyBase.GetResourceString("MENU_HELP")  '"?"
            arrmenuFunctions(0) = "Save_OnClick()"
            arrmenuFunctions(1) = "Back_OnClick()"
            arrmenuFunctions(2) = "Help()"
            arrLinkToolTip(0) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP") '"Save"
            arrLinkToolTip(1) = MyBase.GetResourceString("MENU_BACK_TOOLTIP") '"Back"
            arrLinkToolTip(2) = MyBase.GetResourceString("MENU_HELP_TOOLTIP") '"Help"
        End If

        m_intProjectID = CInt(Session("Project"))
        blnUseSQl = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        '================================================================================================
        'Check for UniqueID- To check whether it is : Edit mode or ADD_NEW Mode
        'strProjectID = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("UniqueID"), ""))
        strProjectID = Session("intProjectID").ToString
        If strProjectID = "" Then
            strProjectID = "0"
        End If
        m_ProjectID = CLng(strProjectID)

        'Check whether the Project Combo has been changes
        strCboChange = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("CboChange"), "FALSE"))
        strMode = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "EDIT"))
        Session("MODE") = strMode
        '----------------------------------------------------------------------------------------------------
        'If the Project is Completed Or the SnapShotDate is greater than Todays date then
        'dont allow the user to enter the data into the system.
        If Request.QueryString("ProjectStatus") = "Completed" Then
            Response.Write("<script> alert(""" & MyBase.GetResourceString("PROJECT_COMPLETED_ALERT") & """) </script>")
        End If
        If Request.QueryString("Date") = "GreaterThanToday" Then
            Response.Write("<script> alert(""" & MyBase.GetResourceString("FUTURE_DATE_ENTRIES_ALERT") & """) </script>")
        End If
        '----------------------------------------------------------------------------------------------------

        'If Mode is ADD_NEW and the Project is Closed then Redirect to ADD Page
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        ' strSQL = "If exists(Select 1 from tbl_PM_Project where ProjectID=" & strProjectID & " and DateDiff(dd,ActualEndDate,Getdate())>=0) Select 1 Else Select 0"
        strSQL = "usp_sel_tbl_PM_Project_Diff " + strProjectID
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        strIsProjectCompleted = CStr(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQl))
        If strIsProjectCompleted = "1" And strProjectID = "0" Then
            Response.Redirect("../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=ADD&ProjectStatus=Completed&Mode=ADD_NEW")
        End If


        '================================================================================================
        'To Calculate Date
        '================================================================================================

        If strProjectID <> "0" Then
            If strMode.ToUpper = "ADD_NEW" Then
                'In ADD_NEW Mode when a Project is Selected Next Date should appear i.e.
                strSQL = "Usp_GetDate_For_Measurement " & strProjectID
                dtDateTime = CDate(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQl))
                m_strDate = strDateTime 'Set Global Date variable
                'If snap shot date is greater that today's date then redirect to CL page
                strSnapshotdate = dtDateTime.ToString("yyyy-MM-dd")
                strSQL = "usp_Check_SnapshotDate '" & strSnapshotdate & "'"
                intIsDateGreaterthanToday = CInt(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQl))
                If intIsDateGreaterthanToday = 0 Then
                    Response.Redirect("../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=ADD&Date=GreaterThanToday&Mode=ADD_NEW")
                End If

            Else
                'In EDIT_MODE the last SnapShotDate should appear.
                strDateTime = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("SnapShotDate"), "0"))
                If strDateTime <> "0" Then
                    dtDateTime = CDate(strDateTime)
                End If
            End If
        End If
        'Convert DateTime to readable format i.e. 27-Feb-1982
        strShowDateTime = dtDateTime.ToString("dd-MMM-yyyy")

        '================================================================================================
        'To Plot the Menu
        '================================================================================================
        m_cObjPageCaption = New WebPage.Templates.PageCaption
        Response.Write(objStaticMenu.DrawMenu(arrmenuNames, arrmenuFunctions, arrLinkToolTip))
        Response.Write("<BR>")

        '================================================================================================
        'To Plot the Page Caption
        '================================================================================================
        Response.Write("<Table class=class='clsTable' align='center' cellpadding=0 cellspacing=0 width='100%'>")
        Response.Write("<tr class=clsTRPageCaption align='center'> ")
        Response.Write("<td  align='Left'>")
        Response.Write(MyBase.GetResourceString("PAGE_CAPTION"))
        Response.Write("</td>")
        Response.Write("</tr>")
        Response.Write("</Table>")
        Response.Write("</br>")

        '================================================================================================
        'To Plot the ProjectName Combo and SnapShotDate DateControl
        '================================================================================================
        Response.Write("<Table class='clsTable' align='center' cellpadding=0 cellspacing=0 width='100%'>")
        Response.Write("<tr class=clsTREven align='center'> ")
        Response.Write("<td align='right'>")
        Response.Write(MyBase.GetResourceString("CBO_PROJECT"))
        Response.Write("</td>")
        Response.Write("<td align='Left'>")

        If strMode.ToUpper = "ADD_NEW" Then
            'Mode is ADD_NEW
            'If FromWhere = "UPDATEMETRIC" Then
            CommonFunctions.HTMLControls.DrawComboBox("cboProjectName", "usp_sel_tbl_PM_Project_For_MeasurementHistory ", 300, strProjectID, "disabled onchange=Project_OnChange(cboProjectName) disabled", True, , , True, , , )       '"onchange=Project_OnChange(cboProjectName)" ::m_ProjectID.ToString
            'Else
            '    CommonFunctions.HTMLControls.DrawComboBox("cboProjectName", "usp_sel_tbl_PM_Project_For_MeasurementHistory ", 300, strProjectID, " onchange=Project_OnChange(cboProjectName)", True, , , True, , , )       '"onchange=Project_OnChange(cboProjectName)" ::m_ProjectID.ToString
            'End If 
        Else
            'Show readonly Combo box in Edit Mode.
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            ' strSQL = "If exists (Select ProjectName from tbl_PM_Project where ProjectID=" & strProjectID & ") Select ProjectName from tbl_PM_Project where ProjectID=" & strProjectID & " else Select 0"
            strSQL = "usp_sel_tbl_PM_Project_select " + strProjectID
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        strProjectName = CStr(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQl))
        CommonFunctions.HTMLControls.DrawComboBox("cboProjectName", "usp_sel_tbl_PM_Project_For_MeasurementHistory ", 300, m_ProjectID.ToString, "disabled onchange=Project_OnChange(cboProjectName)", True, , , True, , , )       '"onchange=Project_OnChange(cboProjectName)" ::m_ProjectID.ToString
        End If

        Response.Write("</td>")
        'Response.Write("</tr>")
        '-------------------------------------------------------------------------------------------------
        'Response.Write("<tr  class=clsTREven align='center'>")
        Response.Write("<td align='right'>")
        Response.Write(MyBase.GetResourceString("SNAPSHOTDATE"))
        Response.Write("</td>")
        Response.Write("<td align='left'>")
        CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , 80, strShowDateTime, , , , , , True, True, , , )
        Response.Write("</td>")
        Response.Write("</tr>")
        '-------------------------------------------------------------------------------------------------
        Response.Write("<tr align='center'>")
        Response.Write("<td align='right'>")
        Response.Write("")
        Response.Write("</td>")
        Response.Write("<td align='left'>")
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''CommonFunction.HTMLControls.DrawTextBox("txtSave", "txtSave", , , , strProjectID.ToString, , , , , , True, "onchange= Save(txtSave)")
        CommonFunction.HTMLControls.DrawTextBox("txtSave", "txtSave", , , , strProjectID.ToString, , , , , , True, "onchange= Save(txtSave)", EnableHTMLEncode:=True)
        ''''Commented And Added By Vaijat K On 06/10/2015
        Response.Write("</td>")
        Response.Write("</tr>")
        '-------------------------------------------------------------------------------------------------
        Response.Write("</Table>")
        Response.Write("</br>")
        '-------------------------------------------------------------------------------------------------

        '====================================================================================================
        ' To plot the grid
        '====================================================================================================
        Dim arrTDStyle() As String = {"align=left", "align=left", "align=left"}
        Dim arrUserFriendly() As String = {MyBase.GetResourceString("COL_MEASUREMENTS"), MyBase.GetResourceString("COL_GUIDELINES"), MyBase.GetResourceString("COL_VALUE")}
        Dim strLinkArray() As String = {"", "", ""}
        Dim arrActualValues() As String = {"UserFriendlyName", "Guidelines", "FunctionValue"}

        If strMode.ToUpper = "ADD_NEW" Then
            strSQL = "usp_sel_tbl_PRS_Measurements_For_MB_ProjectMeasureentsHistory " & strProjectID
        Else
            strSQL = "usp_sel_tbl_PRS_Measurements_For_MB_ProjectMeasureentsHistory " & strProjectID & ",'" & strDateTime & "'"
        End If

        '====================================================================================================
        'Configuring Grid Properties
        '====================================================================================================
        ''''Added By Vaijat K On 06/10/2015
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''''End Added By Vaijat K On 06/10/2015

        With objGrid
            .RowLinkArray = strLinkArray
            .ActualColumnArray = arrActualValues
            .UserFriendlyColumnArray = arrUserFriendly
            .TDStyleArray = arrTDStyle
            '.PrimaryKey = "MeasurementsHistoryID"
            .DIVID = "DivList" 'PageDiv"   '"" '
            '.DIVHeight = 100%
            .SortBy = ""
            .SortOrder = ""
            .DIVStyle = "Overflow:auto;width:100%;height:100%;"
            .NoOfDataColumns = 3
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False  ' 
            .BooleanFalseHTML = "NO"  '|false | <img src='../../images/cross.gif'>
            .BooleanTrueHTML = "YES" ' true ' <img src='../../images/check.gif'>
            .EmptyValueReplacement = " - "
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL

            ''''Added By Vaijat K On 06/10/2015
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''''End Added By Vaijat K On 06/10/2015

            'plot the grid 
            .DrawGrid()
        End With

        '===================================================================================================
        'Hidden TextBox contains the Array of Controls plotted on the commonpage, for validation .
        'This Array is populated in the BeforeDataRowTDPrint Event.
        '===================================================================================================
        Response.Write("<table><tr><td>")
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''CommonFunctions.HTMLControls.DrawTextBox("txtTextControls", "txtTextControls", , , , strTextControls, , , , , , True)
        CommonFunctions.HTMLControls.DrawTextBox("txtTextControls", "txtTextControls", , , , strTextControls, , , , , , True, EnableHTMLEncode:=True)
        ''''End Added By Vaijat K On 06/10/2015
        Response.Write("</td></tr></table>")
        '====================================================================================================
        '====================================================================================================
        'Plot Menu at bottom
        '====================================================================================================
        Response.Write(objStaticMenu.DrawMenu(arrmenuNames, arrmenuFunctions, arrLinkToolTip))
        '====================================================================================================

    End Sub
#End Region

#Region "Save"
    Sub Save(ByVal strAction As String)
        '=====================================================================
        ' Procedure Name        :	Save
        ' Purpose               :	Handles the SAVE/UPDATE of data
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SandeepA
        ' Created               :	Nov 13, 2005 
        ' Revisions             :
        '=====================================================================

        Dim lngMeasurementsHistoryID As Long
        Dim lngProjectID As Long
        Dim strProjectID As String
        Dim strSQL As String
        Dim strMode As String
        Dim blnUseSQl As Boolean
        Dim dblFunctionValue As Double
        Dim drReader As IDataReader
        Dim intResult As Integer
        Dim strSnapShotDate As String

        blnUseSQl = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        'If the mode is ADD_NEW then txtSave will hae value as 0 else it will have the ProjectID to be updated
        'lngProjectID = CLng(MyBase.GetFormValue("txtSave"))
        lngProjectID = CType(Session("intProjectID"), Long)
        strMode = CStr(CommonFunctions.General.CheckIsNothing((Session("MODE")), "ADD_NEW"))

        If strMode = "EDIT" Then 'lngProjectID <> 0 Then
            '====================================================================================================
            'Update : The Mode is EDIT_MODE
            '====================================================================================================
            strSnapShotDate = MyBase.GetFormValue("txtDate")
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            ' strSQL = "Select MeasurementsHistoryID from tbl_PRS_Measurements_History where ProjectID=" & lngProjectID & " and DateDiff(dd,SnapShotDate,'" & strSnapShotDate & "')=0"
            strSQL = "usp_sel_tbl_PRS_Measurements_History_PMH " & lngProjectID & ",'" & strSnapShotDate & "'"
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            drReader = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQl)
            While drReader.Read()
                'For ProjectID get  MeasurementHistoryID
                lngMeasurementsHistoryID = CLng(CommonFunctions.Data.CheckIsDBNull(drReader.Item("MeasurementsHistoryID"), "0"))
                'The name and id of textboxes in the grid are the primary key of the data row
                'which is same as the MeasurementsHistoryID, so get the value using MeasurementsHistoryID
                dblFunctionValue = CDbl(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request(lngMeasurementsHistoryID.ToString), "0"))
                strSQL = "usp_upd_tbl_PRS_Measurements_History  " & dblFunctionValue & "," & lngMeasurementsHistoryID
                'Update table set FunctionValue for the corresponding MeasurementHistoryID
                CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQl)
            End While
            CommonFunctions.Data.DisposeDataReader(drReader)
        Else
            '====================================================================================================
            'Insert : The Mode is ADD_NEW
            '====================================================================================================
            Dim strDate As String
            intCounter = 1
            'strProjectID = MyBase.GetFormValue("cboProjectName")
            strProjectID = Session("intProjectID").ToString
            strDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtDate"), Date.Now.ToString)
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strSQL = "Select MeasurementCode from tbl_PRS_Measurements Where MeasurementID IN (Select MeasurementID from tbl_MET_Project_Measurements where ProjectID=" & strProjectID & " and IsEditable=1) Order By MeasurementCode ASC"
            strSQL = "usp_sel_tbl_PRS_Measurements_MeasurementCode " + strProjectID
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            drReader = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQl)
            While drReader.Read()
                dblFunctionValue = CDbl(CommonFunctions.General.CheckIsNothing((MyBase.GetFormValue(intCounter.ToString)), "0"))
                strSQL = "usp_ins_tbl_PRS_Measurements_History  '" & drReader.Item("MeasurementCode").ToString & "'," & strProjectID & ",'" & strDate & "'," & dblFunctionValue   'REPLACE(CONVERT(VARCHAR(12),getDate(),102),'.','-')
                CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQl)
                intCounter += 1
            End While
            CommonFunctions.Data.DisposeDataReader(drReader)
        End If

        '====================================================================================================
        'Redirect to CommonList i.e. Action=Grid
        '====================================================================================================
        Response.Redirect("../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=Grid&UniqueID=" & lngProjectID & "&SnapShotDate=" & strSnapShotDate & "")
        '====================================================================================================

    End Sub
#End Region

#Region "Grid Events"
    '====================================================================================================
    'objGrid :DataRowTD_BeforePrint Event to dynamically plot the textboxes for functionvalues.
    'The Name and ID's of the textboxes are same as the PrimaryKey of that row.
    '====================================================================================================
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        :	objGrid_DataRowTD_BeforePrint
        ' Purpose               :	Handles DataRowTD_BeforePrint Event
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SandeepA
        ' Created               :	Nov 13, 2005 
        ' Revisions             :
        '=====================================================================

        'To Plot the textboxes in the Function Values column
        Dim lngProjectID As Long
        Dim strMode As String


        If UCase(Args.DataField) = "FUNCTIONVALUE" Then
            'lngProjectID = CLng(MyBase.GetFormValue("txtSave"))
            lngProjectID = CLng(CommonFunctions.General.CheckIsNothing((HttpContext.Current.Request.QueryString("UniqueID")), "0"))
            strMode = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "EDIT"))

            If strMode.ToUpper = "EDIT" Then
                Dim dblFunctionValue As Double
                Dim strDrawTextBox As String
                Dim lngMeasurementsHistoryID As Long
                Dim strIsEditable As String
                Dim strMeasurementCode As String
                Dim strSQL As String

                Cancel = True
                lngMeasurementsHistoryID = CLng(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MeasurementsHistoryID"), "0"))
                dblFunctionValue = CDbl(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FunctionValue"), "0"))
                'strIsEditable = CStr(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsEditable"), "False"))
                strMeasurementCode = CStr(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MeasurementCode"), "NULL"))
                'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
                'strSQL = "If Exists(Select 1 from tbl_MET_Project_Measurements where ProjectID=" & lngProjectID & " and IsEditable=1 and MeasurementID IN (Select MEasurementID from tbl_PRS_Measurements where MeasurementCode='" & strMeasurementCode & "')) (Select 1 from tbl_MET_Project_Measurements where ProjectID=" & lngProjectID & " and  IsEditable=1 and MeasurementID IN (Select MeasurementID from tbl_PRS_Measurements where MeasurementCode='" & strMeasurementCode & "')) Else Select 0 "
                strSQL = "usp_sel_tbl_MET_Project_Measurements_Measurement" & lngProjectID & "," & strMeasurementCode & "'"

                'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
                strIsEditable = CStr(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "0"))

                strDrawTextBox = "<TD align=""Left"" align=""top""><table><tr><td>"
                If strIsEditable = "1" Then
                    ''''Commented And Added By Vaijat K On 06/10/2015
                    '''strDrawTextBox = strDrawTextBox + CommonFunctions.HTMLControls.DrawTextBox(lngMeasurementsHistoryID.ToString, lngMeasurementsHistoryID.ToString, , 40, 5, dblFunctionValue.ToString, "Right", , , , , , , True)
                    strDrawTextBox = strDrawTextBox + CommonFunctions.HTMLControls.DrawTextBox(lngMeasurementsHistoryID.ToString, lngMeasurementsHistoryID.ToString, , 40, 5, dblFunctionValue.ToString, "Right", , , , , , , True, EnableHTMLEncode:=True)
                    ''''End Added By Vaijat K On 06/10/2015
                Else
                    ''''Commented And Added By Vaijat K On 06/10/2015
                    '''strDrawTextBox = strDrawTextBox + CommonFunctions.HTMLControls.DrawTextBox(lngMeasurementsHistoryID.ToString, lngMeasurementsHistoryID.ToString, , 40, 5, dblFunctionValue.ToString, "Right", , True, , , , , True)
                    strDrawTextBox = strDrawTextBox + CommonFunctions.HTMLControls.DrawTextBox(lngMeasurementsHistoryID.ToString, lngMeasurementsHistoryID.ToString, , 40, 5, dblFunctionValue.ToString, "Right", , True, , , , , True, EnableHTMLEncode:=True)
                    ''''End Added By Vaijat K On 06/10/2015
                End If
                strDrawTextBox = strDrawTextBox + "</td></tr></table></TD>"
                Args.StringToBeInserted = strDrawTextBox
                strTextControls = strTextControls + lngMeasurementsHistoryID.ToString + ","
            Else
                If UCase(Args.DataField) = "FUNCTIONVALUE" And strMode.ToUpper = "ADD_NEW" Then
                    Dim dblFunctionValue As Double
                    Dim strDrawTextBox As String
                    Dim lngMeasurementsHistoryID As Long
                    Dim strIsEditable As String
                    Dim strMeasurementCode As String
                    Dim strSQL As String

                    Cancel = True
                    strMeasurementCode = CStr(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MeasurementCode"), "NULL"))
                    strSQL = "If Exists(Select 1 from tbl_MET_Project_Measurements where ProjectID=" & lngProjectID & " and IsEditable=1 and MeasurementID IN (Select MEasurementID from tbl_PRS_Measurements where MeasurementCode='" & strMeasurementCode & "')) (Select 1 from tbl_MET_Project_Measurements where ProjectID=" & lngProjectID & " and  IsEditable=1 and MeasurementID IN (Select MeasurementID from tbl_PRS_Measurements where MeasurementCode='" & strMeasurementCode & "')) Else Select 0 "
                    strIsEditable = CStr(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "0"))
                    strDrawTextBox = "<TD align=""Left"" align=""top""><table><tr><td>"
                    If strIsEditable = "1" Then
                        ''''Commented And Added By Vaijat K On 06/10/2015
                        '''strDrawTextBox = strDrawTextBox + CommonFunctions.HTMLControls.DrawTextBox(intCounter.ToString, intCounter.ToString, , 40, 5, dblFunctionValue.ToString, "Right", , , , , , , True)
                        strDrawTextBox = strDrawTextBox + CommonFunctions.HTMLControls.DrawTextBox(intCounter.ToString, intCounter.ToString, , 40, 5, dblFunctionValue.ToString, "Right", , , , , , , True, EnableHTMLEncode:=True)
                        ''''End Added By Vaijat K On 06/10/2015
                    Else
                        ''''Commented And Added By Vaijat K On 06/10/2015
                        '''strDrawTextBox = strDrawTextBox + CommonFunctions.HTMLControls.DrawTextBox(intCounter.ToString, intCounter.ToString, , 40, 5, dblFunctionValue.ToString, "Right", , , True, "WhiteSmoke", , , True)
                        strDrawTextBox = strDrawTextBox + CommonFunctions.HTMLControls.DrawTextBox(intCounter.ToString, intCounter.ToString, , 40, 5, dblFunctionValue.ToString, "Right", , , True, "WhiteSmoke", , , True, EnableHTMLEncode:=True)
                        ''''End Added By Vaijat K On 06/10/2015
                    End If
                    strDrawTextBox = strDrawTextBox + "</td></tr></table></TD>"
                    Args.StringToBeInserted = strDrawTextBox
                    strTextControls = strTextControls + intCounter.ToString + ","
                    intCounter += 1
                End If
            End If
        End If
    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        MyBase.ApplySecurity(True)
    End Sub
#End Region

End Class