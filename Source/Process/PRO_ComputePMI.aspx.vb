Public Class PRO_ComputePMI
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : PRO_ComputePMI
    ' Purpose               : Compute the PMI 
    ' Description           : 
    ' Parameters Passed     : 
    ' Assumptions           : AppResources.PRO_ComputePMI.resx Resource file exists
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SuryabirD
    ' Created               : Mar 8th, 2004
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
    Private Const STR_STATUS_ACTIVE As String = "Active"
    Private Const STR_STATUS_INACTIVE As String = "Inactive"
    Private m_objGlobal As WebPages.Template.IGlobal
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private WithEvents m_objVerticalGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMetricGrid As New WebPages.Template.GenericGrid

    Private m_dblMetricAvgValue, m_dblMetricMaxValue, m_dblMetricMinValue As Double
    Private m_dblMetricStdDeviation, m_dblDerivedUCL, m_dblDerivedLCL As Double

    Protected m_strSigma As String
    Protected m_lngPMIID As Long
    Protected m_strPageTitle As String

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        Dim strQuery, strMetricID As String

        '---------------Added by AbhijeetD on 23rd April 2004--------------------
        'Store the MasterTagID inside a hidden control
        CommonFunction.HTMLControls.DrawTextBox("intMasterTagID", "intMasterTagID", , , , Request.QueryString("MasterTagID"), , , , , , True)
        '---------------------------End Addition--------------------------------

        m_lngPMIID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("PMIID"), "0"), Long)
        
        m_strSigma = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optSigma"), "2").Trim
        Call CreateGlobalObject()
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")

        '-- IF MODE IS "SETNEW" we set the New UCL and LCL
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("MODE")).Trim.ToUpper = "SETNEW" Then
            strMetricID = CommonFunctions.General.CheckIsNothing(Request.QueryString("METRICID"))

            'Code Commented By DipaliS
            'strQuery = "EXEC usp_PRS_SetUCLAndLCL " + m_lngPMIID.ToString + "," + strMetricID + "," + m_strSigma

            'Code Added By DipaliS -27 May 2004
            Dim strTxtIDLCL As String
            Dim strTxtIDUCL As String
            strTxtIDLCL = "txtDvdLCL" + strMetricID
            strTxtIDUCL = "txtDvdUCL" + strMetricID

            'Modified By NitinVS on 10 Apr 2007 for WhizibleSEM SP 8 Reression Issue 12698 
            ' to remove crash if +6.0  is passed as LCL or UCL
            strQuery = "EXEC usp_PRS_SetUCLAndLCLFromDerived " + m_lngPMIID.ToString + "," + strMetricID + ",'" + _
                        CommonFunctions.General.BuildQueryString(MyBase.GetFormValue(strTxtIDLCL)) + "','" + CommonFunction.General.BuildQueryString(MyBase.GetFormValue(strTxtIDUCL)) + "' "
            'End Modified By NitinVS on 10 Apr 2007 for WhizibleSEM SP 8 Reression Issue 12698 
            'End of Addition


            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If
    End Sub

    Protected Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Main function to plot the Controls on the page
        ' Description           : Called from within the Form from within the <Form> Tag
        ' Parameters Passed     : N/A
        ' Returns               : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : SuryabirD
        ' Created               : Monday, 08 March, 2004
        '=====================================================================
        Dim strMenu As String
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter

        '-- Display Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<BR>")

        '-- Display Caption
        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        Response.Write("<BR>")

        '-- Display header
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing

        Response.Write("<DIV ID='DivList' Style='WIDTH:100%;OVERFLOW:auto;'>")

        Call DisplayHeaderGrid()
        Response.Write("<BR>")
        Call DisplayPMI_Statistics()
        Call DisplayMetric_Grid()

        Response.Write("</DIV>")

        '-- Display Footer
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing

        Response.Write("<BR>" + strMenu)
        m_objGlobal = Nothing

    End Sub

    Private Sub DisplayHeaderGrid()
        '=====================================================================
        ' Procedure Name        : DisplayHeaderGrid
        ' Purpose               : Header for the selected PMI
        ' Description           : Displays the header Vertical grid containing details of the selected PMI
        ' Parameters Passed     : N/A
        ' Returns               : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : SuryabirD
        ' Created               : Tues, 09 March, 2004
        '=====================================================================

        Dim strSQL As String
        Dim arrstrActualList() As String = {"Name", "ShortName", "Description", "Notes", "ActiveWord"}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("PMI_NAME"), MyBase.GetResourceString("PMI_SHORTNAME"), MyBase.GetResourceString("PMI_DESC"), MyBase.GetResourceString("PMI_NOTES"), MyBase.GetResourceString("PMI_ACTIVE")}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        strSQL = "Exec usp_Sel_tbl_PRS_PMIMaster " + m_lngPMIID.ToString + ",NULL"

        With m_objVerticalGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .VerticalDisplay = True
            .SQL = strSQL
            .DIVHeight = 0
            .UseSQL = MyBase.UseSQL
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .DrawGrid()
        End With
        m_objVerticalGrid = Nothing

    End Sub

    Private Sub DisplayPMI_Statistics()
        '=====================================================================
        ' Procedure Name        : DisplayPMI_Statistics
        ' Purpose               : Display PMI Statistics 
        ' Description           : The 2nd table in the Page; Also this fn. shows the Option buttons
        '                         (1 Sigma, 2 Sigma, 3 Sigma)
        ' Parameters Passed     : N/A
        ' Returns               : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : SuryabirD
        ' Created               : Tues, 09 March, 2004
        '=====================================================================

        Dim strQuery As String
        Dim drPMI As IDataReader
        Dim intNumberProjectsPast As Integer = 0
        Dim intNumberProjectsCurrent As Integer = 0

        strQuery = "Exec usp_PRS_GetProjectCountOfPMI " + m_lngPMIID.ToString
        drPMI = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If drPMI.Read Then
            intNumberProjectsPast = CType(CommonFunctions.Data.CheckIsDBNull(drPMI("NumberOfPastProjects"), "0"), Integer)
            intNumberProjectsCurrent = CType(CommonFunctions.Data.CheckIsDBNull(drPMI("NumberOfCurrentProjects"), "0"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drPMI)

        'Displaying information about the count of the Projects executed in the past and currently being executed	
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TR class=clsTROdd><TD align = left  colspan = 2><B>" + MyBase.GetResourceString("PMI_STATISTICS") + "</B></TD></TR>")

        Response.Write("<TR class=clsTROdd><TD align = left >" + MyBase.GetResourceString("NUM_PROJECTS") + "</TD>")
        Response.Write("<TD align = left >" + intNumberProjectsPast.ToString + "</TD></TR>")
        Response.Write("<TR class=clsTROdd><TD align = left >" + MyBase.GetResourceString("NUM_CURR_PROJECTS") + "</TD>")
        Response.Write("<TD align = left >" + intNumberProjectsCurrent.ToString + "</TD></TR>")
        Response.Write("</TABLE></BR>")

        '--Option Buttons
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TR><TD align=right><FONT Face = Verdana SIZE = 1>" + MyBase.GetResourceString("CRITERIA") + "</FONT></TD><TD align=left>")

        '================ Option buttons for 1 Sigma, 2 Sigma, 3 Sigma ============================
        ' By default we have 2 Sigma
        Dim strTempSigma As String

        '--1 sigma
        If m_strSigma = "1" Then strTempSigma = " Checked " Else strTempSigma = ""
        CommonFunctions.HTMLControls.DrawOptionButton("optSigma", "opt1Sigma", , , "1", , strTempSigma + " OnClick='javascript:SetOption()'")
        strTempSigma = MyBase.GetResourceString("ONE_SIGMA")
        Response.Write("<FONT Face = Verdana SIZE = 1>" + strTempSigma + "</FONT>&nbsp;&nbsp;")

        '-- 2 Sigma
        If m_strSigma = "2" Then strTempSigma = " Checked " Else strTempSigma = ""
        CommonFunctions.HTMLControls.DrawOptionButton("optSigma", "opt2Sigma", , , "2", , strTempSigma + " OnClick='javascript:SetOption()'")
        strTempSigma = MyBase.GetResourceString("TWO_SIGMA")
        Response.Write("<FONT Face = Verdana SIZE = 1>" + strTempSigma + "</FONT>&nbsp;&nbsp;")

        '-- 3 Sigma
        If m_strSigma = "3" Then strTempSigma = " Checked " Else strTempSigma = ""
        CommonFunctions.HTMLControls.DrawOptionButton("optSigma", "opt3Sigma", , , "3", , strTempSigma + " OnClick='javascript:SetOption()'")
        strTempSigma = MyBase.GetResourceString("THREE_SIGMA")
        Response.Write("<FONT Face = Verdana SIZE = 1>" + strTempSigma + "</FONT>&nbsp;&nbsp;")

        '-- Display correct formulae for 1,2,3 Sigma
        Response.Write("<TD align=left> <FONT Face = Verdana SIZE = 1> [Derived LCL = Average - " + m_strSigma + " * Standard Deviation]<BR>[Derived UCL = Average + " + m_strSigma + " * Standard Deviation]</FONT></TD></TR></TABLE>")

    End Sub

    Private Sub DisplayMetric_Grid()
        '=====================================================================
        ' Procedure Name        : DisplayMetric_Grid
        ' Purpose               : Display the detailed Metric Grid
        ' Description           : Values of Average Value, Standard Deviation, Minimum Value, Maximum Value,
        '                         Derived LCL, Derived UCL  are Calculated from SP at Row Level Events
        ' Parameters Passed     : N/A
        ' Returns               : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : SuryabirD
        ' Created               : Tues, 09 March, 2004
        '=====================================================================

        Dim strSQL As String
        Dim arrstrActualList() As String = {"CategoryName", "MetricName", "", "", "", "", "", "", "Minimum", "Maximum", "UnitName", "Active", "Minimum", "Maximum"}
        Dim arrstrUserFriendlyList() As String = {"", MyBase.GetResourceString("GRD_METRIC"), MyBase.GetResourceString("GRD_AVG_VALUE"), _
            MyBase.GetResourceString("GRD_STD_DEV"), MyBase.GetResourceString("GRD_MIN_VALUE"), MyBase.GetResourceString("GRD_MAX_VALUE"), _
            MyBase.GetResourceString("GRD_DER_LCL"), MyBase.GetResourceString("GRD_DER_UCL"), MyBase.GetResourceString("GRD_LCL"), _
            MyBase.GetResourceString("GRD_UCL"), MyBase.GetResourceString("GRD_UNITS"), MyBase.GetResourceString("GRD_STATUS"), MyBase.GetResourceString("GRD_SET"), "Graph"}
        Dim arrstrRowLink() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "SetLCLandUCL(MetricID)", "ShowGraph(MetricID)"}
        'MetricDetails(MetricID)

        Dim arrstrTDStyle() As String = {"", "{}Title='[Remarks]'", "", "", "", "", "", "", "", "", "", "", "", ""}
        Dim arrstrGroupByColumn() As String = {"1"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        strSQL = "Exec usp_Sel_PRS_GetMetricListOfPMI " + m_lngPMIID.ToString + ",NULL,'DSP'"

        With m_objMetricGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .GroupOnColumn = arrstrGroupByColumn
            .RowLinkArray = arrstrRowLink
            .TDStyleArray = arrstrTDStyle
            .SQL = strSQL
            .DIVHeight = 0
            .UseSQL = MyBase.UseSQL
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .DrawGrid()
        End With
        m_objMetricGrid = Nothing

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

        MyBase.InitializeResources("AppResources.PRO_ComputePMI", "AppResources")

        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_HELP")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

        Dim arrMenu() As String = {"Back", "Help"}
        Dim arrMenuToolTip() As String = {"Back", "Help"}


        Dim arrClientSideFunctions() As String = {"Back_OnClick()", "Help_OnClick('1052')"}

            Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)


        m_objMenu = Nothing

            Return strMenu




    End Function

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

        'destroy global and AccessRights objects
        objAccess = Nothing

    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for PRO_ProjectTypeConfiguration page.
        MyBase.InitializeResources("AppResources.PRO_ComputePMI", "AppResources")
    End Sub

    Private Sub m_objVerticalGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objVerticalGrid.DataRowTD_BeforePrint
        Args.Alignment = "Left"
        If Args.ColIndex = 0 Then
            Args.TDStyle = "Width = '15%'"
        End If

        ''-- Display 1 as Active
        'If Args.ColIndex = 4 Then
        '    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Active"), "True"), Boolean) Then
        '        Args.StringToBeInserted = "<TD Align=Left>Active</TD>"
        '    Else
        '        Args.StringToBeInserted = "<TD Align=Left>Inactive</TD>"
        '    End If
        '    Cancel = True
        'End If


    End Sub

    Private Sub m_objVerticalGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objVerticalGrid.ColumnHeaderTD_BeforePrint

        If Args.ColIndex = 0 Then
            Args.TDStyle = "Width = '15%'"
        End If

    End Sub

    Private Sub m_objMetricGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objMetricGrid.DataRowTD_BeforePrint
        Dim strHTML, strStatus As String

        Select Case Args.ColIndex
            Case 2        '-- Average Value
                strHTML = "<TD Align=Right nowrap>" + FormatNumber(m_dblMetricAvgValue.ToString, 2) + "</TD>"
                Args.StringToBeInserted = strHTML
                Cancel = True

            Case 3        '-- Standard Deviation
                strHTML = "<TD Align=Right nowrap>" + FormatNumber(m_dblMetricStdDeviation.ToString, 2) + "</TD>"
                Args.StringToBeInserted = strHTML
                Cancel = True

            Case 4        '-- Minimum Value
                strHTML = "<TD Align=Right nowrap>" + FormatNumber(m_dblMetricMinValue.ToString, 2) + "</TD>"
                Args.StringToBeInserted = strHTML
                Cancel = True

            Case 5        '-- Maximum Value
                strHTML = "<TD Align=Right nowrap>" + FormatNumber(m_dblMetricMaxValue.ToString, 2) + "</TD>"
                Args.StringToBeInserted = strHTML
                Cancel = True

            Case 6        '-- Derived LCL Value
                'Code Commented By DipaliS - 27 May 2004
                'strHTML = "<TD Align=Right nowrap>" + FormatNumber(m_dblDerivedLCL.ToString, 2) + "</TD>"


                'Code Added By DipaliS - 27 May 2004
                Dim strTextBox As String
                Dim strID As String
                strID = "txtDvdLCL" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MetricID")).ToString
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                ''strTextBox = CommonFunctions.HTMLControls.DrawTextBox(strID, strID, , 50, 8, FormatNumber(m_dblDerivedLCL.ToString, 2, , , TriState.False).ToString, "right", , , , , , , True, True)
                strTextBox = CommonFunctions.HTMLControls.DrawTextBox(strID, strID, , 50, 8, FormatNumber(m_dblDerivedLCL.ToString, 2, , , TriState.False).ToString, "right", , , , , , , True, True, EnableHTMLEncode:=True)
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                strHTML = "<TD Align=Right nowrap>" + strTextBox + "</TD>"
                'End of Addition

                Args.StringToBeInserted = strHTML
                Cancel = True

            Case 7        '-- Derived UCL Value
                'Code Commented By DipaliS - 27 May 2004
                ' strHTML = "<TD Align=Right nowrap>" + FormatNumber(m_dblDerivedUCL.ToString, 2) + "</TD>"

                'Code Added By DipaliS - 27 May 2004
                Dim strTextBox As String
                Dim strID As String
                strID = "txtDvdUCL" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MetricID")).ToString
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                ''strTextBox = CommonFunctions.HTMLControls.DrawTextBox(strID, strID, , 50, 8, FormatNumber(m_dblDerivedUCL.ToString, 2, , , TriState.False).ToString, "right", , , , , , , True, True)
                strTextBox = CommonFunctions.HTMLControls.DrawTextBox(strID, strID, , 50, 8, FormatNumber(m_dblDerivedUCL.ToString, 2, , , TriState.False).ToString, "right", , , , , , , True, True, EnableHTMLEncode:=True)
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                strHTML = "<TD Align=Right nowrap>" + strTextBox + "</TD>"
                'End of Addition

                Args.StringToBeInserted = strHTML
                Cancel = True

            Case 8, 9, 10
                'strHTML = "<TD Align=Right>" + FormatNumber(m_dblDerivedUCL.ToString, 2) + "</TD>"
                Args.TDStyle = " vAlign=middle Align=center"

            Case 11
                Args.TDStyle = " vAlign=middle Align=center"
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Active"), "False"), Boolean) Then
                    strStatus = "Active"
                Else
                    strStatus = "Inactive"
                End If
                strHTML = "<TD Align=center >" + strStatus + "</TD>"
                Args.StringToBeInserted = strHTML
                Cancel = True

            Case 12
                strHTML = "<TD Align=center >" + "<A Href='javascript:SetLCLandUCL(" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MetricID")).ToString + ")'>" + "Set</A></TD>"
                Args.StringToBeInserted = strHTML
                Cancel = True

            Case 13
                strHTML = "<TD Align=center>" + "<A Href='javascript:ShowGraph(" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MetricID")).ToString + ")'>" + "Show Graph</A></TD>"
                Args.StringToBeInserted = strHTML
                Cancel = True

            Case Else
        End Select

    End Sub

    Private Sub m_objMetricGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objMetricGrid.DataRowTR_BeforePrint
        '-- At each Data Row we calculate these 6 Values for that Metric
        '-- Values of Average Value, Standard Deviation, Minimum Value, Maximum Value,
        '-- Derived LCL, Derived UCL  
        Dim strQuery, strHTML As String
        Dim lngMetricID As Long
        Dim drPMINames As IDataReader

        lngMetricID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MetricID"), "0"), Long)
        If m_strSigma = "" Then
            strQuery = "Exec usp_PDB_GetAverageValueOfMetric " + m_lngPMIID.ToString + "," + lngMetricID.ToString
        Else
            strQuery = "Exec usp_PDB_GetAverageValueOfMetric " + m_lngPMIID.ToString + "," + lngMetricID.ToString + "," + m_strSigma
        End If

        drPMINames = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drPMINames.Read Then
            'if the recordset is not at EOF then reading the Average value
            m_dblMetricAvgValue = CType(CommonFunction.Data.CheckIsDBNull(drPMINames("AverageValue"), "0"), Double)
            m_dblMetricMaxValue = CType(CommonFunction.Data.CheckIsDBNull(drPMINames("MaximumValue"), "0"), Double)
            m_dblMetricMinValue = CType(CommonFunction.Data.CheckIsDBNull(drPMINames("MinimumValue"), "0"), Double)
            m_dblMetricStdDeviation = CType(CommonFunction.Data.CheckIsDBNull(drPMINames("StandardDeviation"), "0"), Double)
            m_dblDerivedUCL = CType(CommonFunction.Data.CheckIsDBNull(drPMINames("DerivedUCL"), "0"), Double)
            m_dblDerivedLCL = CType(CommonFunction.Data.CheckIsDBNull(drPMINames("DerivedLCL"), "0"), Double)
        End If

        CommonFunctions.Data.DisposeDataReader(drPMINames)

    End Sub

    Private Sub m_objMetricGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objMetricGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
        End If

    End Sub
    ''Added by Yogesh J on 10-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod>
    Public Shared Function GenrateURLToken_ShowGraph_OnClick(PMIID As String, EmployeeID As String, METRICID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            ''Added by Sanyogeeta R  on 12-Aug-2016 for to generate and validate Token		
            'm_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(PMIID, String) + CType(METRICID, String) + "0" + "0")
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(PMIID, String) + CType(EmployeeID, String) + "0" + "0" + CType(METRICID, String))
            ''End Added And Commented by Sanyogeeta R  on 12-Aug-2016 for to generate and validate Token

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of addition by Yogesh J on 10-Feb-2016
End Class
