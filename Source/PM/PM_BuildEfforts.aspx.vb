Public Class PM_BuildEfforts
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : PM_BuildEfforts
    ' Purpose               : Build Efforts for a project
    ' Description           : Build Efforts
    ' Parameters Passed     : Accepting the build effrots for the different complexity
    ' Assumptions           : AppResources.PM_BuildEfforts.resx Resource file exists
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SuryabirD
    ' Created               : Mar 5th, 2004
    ' Revisions             : 
    '=====================================================================

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
    Private m_objGlobal As WebPages.Template.IGlobal
    '-- Object for Plotting Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    '-- Object for Plotting Complexity grid
    Private WithEvents m_objComplexityGrid As WebPages.Template.GenericGrid
    '-- For Plotting Effort Distribution List
    Private WithEvents m_objEffortGrid As WebPages.Template.GenericGrid

    Private m_blnAddAccess, m_blnDeleteAccess, m_blnEditAccess As Boolean
    Private m_lngTotalEffort, m_lngNoOfUnits, m_lngTotalEffortPerUnit As Double
    Protected m_lngNoOfRows As Long = 0
    Protected m_strPageTitle As String

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

        Call CreateGlobalObject()

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("MODE"), "").Trim.ToUpper = "SAVE" Then
            Call SaveBuildEfforts()
        End If

    End Sub

    Private Sub SaveBuildEfforts()
        '-- To save the Build Effort records 
        Dim intCount As Integer = 0
        Dim dblNumberOfUnits, dblBuildEfforts As Double
        Dim strSQL As String

        Do While intCount < CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtCount"), "0"), Integer)
            strSQL = ""

            'Query which saves all the build efforts in the table
            dblNumberOfUnits = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtNoOfUnits" + intCount.ToString), "0"), Double)

            dblBuildEfforts = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtBuildEfforts" + intCount.ToString), "0"), Double)

            strSQL = "EXEC usp_upd_BuildEfforts " + dblNumberOfUnits.ToString + "," + dblBuildEfforts.ToString + "," + m_objGlobal.ProjectID.ToString + "," + CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("hdComplexityID" + intCount.ToString), "0")
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            intCount = intCount + 1
        Loop

    End Sub

    Public Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Main function to plot the Controls on the page
        ' Description           : Called from within the Form from within the <Form> Tag
        ' Parameters Passed     : N/A
        ' Returns               : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : SuryabirD
        ' Created               : Friday, 05 March, 2004
        '=====================================================================
        Dim strMenu As String
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter

        '-- Display Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<BR>")

        '-- Display Caption
        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_TITLE"), , , True))
        Response.Write("<BR>")

        '-- Display header
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing

        Response.Write("<DIV ID='DivList' Style='WIDTH:100%;OVERFLOW:auto;'>")
        'WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("COMPLEXITY_CAPTION"))

        Dim objComplexity As New WebPages.Template.SectionTitle
        With objComplexity
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("COMPLEXITY_CAPTION"), "DivComplexity", "ShowHideOtherInfo"))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With
        objComplexity = Nothing
        Response.Write("<DIV ID='DivComplexity' Style='WIDTH:100%;OVERFLOW:auto;'>")
        Call ComplexityDefinition_Grid()
        Response.Write("</DIV>")

        Response.Write("<BR>")

        'WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("EFFORT_DIST_CAPTION"))
        Dim objEffDist As New WebPages.Template.SectionTitle
        With objEffDist
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("EFFORT_DIST_CAPTION"), "DivEffDist", "ShowHideEffortInfo"))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With
        objEffDist = Nothing

        Response.Write("<DIV ID='DivEffDist' Style='WIDTH:100%;OVERFLOW:auto;'>")
        Call EffortDistribution_Grid()
        Response.Write("</DIV>")

        Response.Write("</DIV>")

        '-- Display Footer
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing

        Response.Write("<BR>" + strMenu)

        '-- Release Memory
        m_objComplexityGrid = Nothing
        m_objMenu = Nothing
        m_objGlobal = Nothing

    End Sub

    Private Sub ComplexityDefinition_Grid()
        '=====================================================================
        ' Procedure Name        : ComplexityDefinition_Grid
        ' Purpose               : Plots the Complexity Definition Grid
        ' Description           : The plotting of textboxes is handled in the Events of 'm_objComplexityGrid'
        ' Parameters Passed     : N/A
        ' Returns               : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : SuryabirD
        ' Created               : Friday, 05 March, 2004
        '=====================================================================
        Dim strSQL As String
        Dim arrstrActualList() As String = {"Complexity", "NumberOfUnits", "BuildEfforts", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("COMPLEXITY"), MyBase.GetResourceString("NO_UNITS"), MyBase.GetResourceString("BUILD_EFFORT"), MyBase.GetResourceString("TOTAL_BUILD")}
        Dim arrSummaryFunctions() As String = {",SUM,SUM,SUM"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = "EXEC usp_sel_GetBuildEffort_Data " + m_objGlobal.ProjectID.ToString
        m_objComplexityGrid = New WebPages.Template.GenericGrid

        With m_objComplexityGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .ColNameToolTipOnEachRow = True
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .ShowSummaryFunctions = True
            .SummaryFunctions = arrSummaryFunctions
            .SQL = strSQL
            .DIVHeight = 0
            '.DIVStyle = "WIDTH:100%;OVERFLOW:auto;"
            .UseSQL = MyBase.UseSQL
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_lngNoOfRows = m_objComplexityGrid.NoOfRows

        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtCount", "txtCount", , , , m_lngNoOfRows.ToString, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        m_objComplexityGrid = Nothing

    End Sub

    Private Sub EffortDistribution_Grid()
        '=====================================================================
        ' Procedure Name        : ComplexityDefinition_Grid
        ' Purpose               : Plots the Complexity Definition Grid
        ' Description           : The plotting of textboxes is handled in the Events of 'm_objComplexityGrid'
        ' Parameters Passed     : N/A
        ' Returns               : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : SuryabirD
        ' Created               : Friday, 05 March, 2004
        '=====================================================================
        Dim strSQL As String

        Dim arrstrActualList() As String = {"Phase", "PlannedResources", "PercentEfforts", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("GRID_PHASE"), MyBase.GetResourceString("GRID_PEAK_SIZE"), MyBase.GetResourceString("GRID_PERC"), MyBase.GetResourceString("GRID_EFFORTS")}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = "EXEC usp_Sel_Phase_Information " + m_objGlobal.ProjectID.ToString

        m_objEffortGrid = New WebPages.Template.GenericGrid
        With m_objEffortGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .ColNameToolTipOnEachRow = True
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .SQL = strSQL
            .DIVHeight = 0
            '.DIVStyle = "WIDTH:100%;OVERFLOW:auto;"
            .UseSQL = MyBase.UseSQL
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        m_objEffortGrid = Nothing

    End Sub

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Function Name         : CreateGlobalObject
        ' Purpose               : Creates the Global Object for accessing TagID, FrowWhere etc.
        ' Description           : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Feb 16, 2004
        ' Revisions             : 
        '=====================================================================

        'Global object
        Dim objAccess As New WebPage.Templates.AccessRights

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject

        objAccess.GetAccess(m_objGlobal)

        m_blnAddAccess = objAccess.Add          'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete    'If User has Delete Access
        m_blnEditAccess = objAccess.Edit        'If user has Edit Access

        'destroy global and AccessRights objects
        objAccess = Nothing

    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Help_OnClick('BUILD_EFF')"}

        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.PM_BuildEfforts", "AppResources")
        Return strMenu

    End Function

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for PRO_ProjectTypeConfiguration page.
        MyBase.InitializeResources("AppResources.PM_BuildEfforts", "AppResources")
    End Sub

    Private Sub m_objComplexityGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objComplexityGrid.DataRowTD_BeforePrint
        Dim strHTMLString As String
        Dim lngBuildTotal As Double

        '-- Number Of Units Text box
        If Args.ColIndex = 1 Then
            'modified by SonalD on 24th Dec 2008 ,FormatNumbar function not applied for the value of textboxes
            'Purpose:for IssueID 26170
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTMLString = CommonFunctions.HTMLControls.DrawTextBox("txtNoOfUnits" + (Args.NoOfRowsPrinted).ToString, "txtNoOfUnits" + (Args.NoOfRowsPrinted).ToString, , 50, 10, CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NumberOfUnits"), "0").ToString, "Right", , , , , , , True, EnableHTMLEncode:=True)
            'End of modification by SonalD on 24th Dec 2008
            strHTMLString = strHTMLString + CommonFunctions.HTMLControls.DrawTextBox("hdComplexityID" + (Args.NoOfRowsPrinted).ToString, "hdComplexityID" + (Args.NoOfRowsPrinted).ToString, , , , CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ComplexityID"), "0").ToString, , , , , , True, , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            m_lngNoOfUnits = m_lngNoOfUnits + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NumberOfUnits"), "0"), Double)
            Args.StringToBeInserted = "<TD Align=Right title='" + Args.ColumnName.Trim + "'>" + strHTMLString + "</TD>"
            Cancel = True
        End If

        '-- Build Efforts Text box
        If Args.ColIndex = 2 Then
            'modified by SonalD on 24th Dec 2008 ,FormatNumbar function not applied for the value of textboxes
            'Purpose:for IssueID 26170
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTMLString = CommonFunctions.HTMLControls.DrawTextBox("txtBuildEfforts" + (Args.NoOfRowsPrinted).ToString, "txtBuildEfforts" + (Args.NoOfRowsPrinted).ToString, , 50, 10, CommonFunctions.Data.CheckIsDBNull(Args.DataReader("BuildEfforts"), "0").ToString, "Right", , , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'End of modification by SonalD on 24th Dec 2008
            m_lngTotalEffortPerUnit = m_lngTotalEffortPerUnit + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("BuildEfforts"), "0"), Double)
            Args.StringToBeInserted = "<TD Align=Right title='" + Args.ColumnName.Trim + "'>" + strHTMLString + "</TD>"
            Cancel = True
        End If

        '-- Total Build Effort: No of Units * Build Effort
        If Args.ColIndex = 3 Then
            lngBuildTotal = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NumberOfUnits"), "0"), Double) * CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("BuildEfforts"), "0"), Double)
            Args.StringToBeInserted = "<TD align=right title='" + Args.ColumnName.Trim + "'>" + FormatNumber(lngBuildTotal.ToString, 2) + "</TD>"
            Args.Alignment = "Right"
            m_lngTotalEffort = m_lngTotalEffort + lngBuildTotal
            Cancel = True
        End If

    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

        ''-- SAVE Link
        'If Args.MenuColIndex = 0 Then
        '    If Not (m_blnAddAccess Or m_blnEditAccess) Then
        '        Cancel = True
        '    End If
        'End If
    End Sub

    Private Sub m_objEffortGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objEffortGrid.DataRowTD_BeforePrint
        Dim dblTemp As Double

        If Args.ColIndex = 3 Then
            dblTemp = (m_lngTotalEffort * CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PercentEfforts"), "0"), Double)) / 100.0
            Args.StringToBeInserted = "<TD Align=Right title='" + Args.ColumnName.Trim + "'>" + FormatNumber(dblTemp.ToString, 2) + "</TD>"
            Cancel = True
        End If
    End Sub

    Private Sub m_objComplexityGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objComplexityGrid.SummaryFunctionsTD_BeforePrint

        '-- Total No. of Units
        If Args.ColIndex = 0 Then

            Args.StringToBeInserted = "<TD Align=Right>Total</TD>"
        End If

        If Args.ColIndex = 1 Then

            Args.StringToBeInserted = "<TD Align=Right>" + FormatNumber(CType(m_lngNoOfUnits, Double).ToString, 2) + "</TD>"
        End If

        '-- Total Build Effort/Unit
        If Args.ColIndex = 2 Then

            Args.StringToBeInserted = "<TD Align=Right>" + FormatNumber(CType(m_lngTotalEffortPerUnit, Double).ToString, 2) + "</TD>"
        End If

        '-- Total Build Effort
        If Args.ColIndex = 3 Then

            Args.StringToBeInserted = "<TD Align=Right>" + FormatNumber(CType(m_lngTotalEffort, Double).ToString, 2) + "</TD>"
        End If

        Cancel = True

    End Sub

    Private Sub m_objEffortGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objEffortGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 3 Then
            Args.Alignment = "Right"
        End If
    End Sub

    Private Sub m_objComplexityGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objComplexityGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 2 Or Args.ColIndex = 3 Then
            Args.Alignment = "Right"
        End If
    End Sub
End Class
