Public Class TimesheetReport
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : IB_ShowReport
    ' Purpose               : Used to call Reports
    ' Description           : Called from Issue Base List Page
    ' Parameters Passed     : 
    ' Returns               : 
    ' Parameters Affected   : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SuryabirD
    ' Created               : March 2nd, 2004
    ' Revisions             : 
    '=====================================================================
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmShowReport As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.       
        InitializeComponent()
    End Sub

#End Region
    Protected m_strPageTitle As String
    Protected WithEvents m_oReport As AdHocReports.Report.AdHocReport
    Protected m_intTimesheetID As String = "0"
    Protected m_ReportID As String = "0"
    Private Const CONST_ERROR_LOG As String = "../../Attachments/Log/"
    ' Added BY NitinVS on 4 July 2007 for WhizbleSEM 7 
    'Declare in the class level declaration.
    Protected m_strReportDisclaimer As String = ""
    'End addition NitinVS on 4 July 2007 for WhizbleSEM 7 
    'Added by ShraddhaM on 23,Aug 2007
    Protected strFromDate As DateTime
    Protected strToDate As DateTime
    Protected m_intTimesheetID_Query As String = "0"
    Protected blnIsDiable As Boolean
    Private width As Double
    Private dtFromDate As String
    Private dtToDate As String
    Protected DayDiff As Integer
    Protected strDateDiffQuery As String
    Private cntDayDiff As Integer
    Private cntDayCaptionDiff As Integer
    Private strFormat As String

    'End of Addition by ShraddhaM on  23,Aug 2007
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        'Commeted by ShraddhaM on 23,Aug 2007 for SP8 (Timesheet Report)
        'm_intTimesheetID = CommonFunction.General.CheckIsNothing(Request.QueryString("TimesheetID"), "0")
        'Added by PrashantD on 9 March 2007
        Dim dr As IDataReader
        Dim dtTSStartDate As Date
        Dim dtTSEndDate As Date
        Dim intdateDiff As Integer
        Dim strDateDiffQuery As String

        'Modified and Added by ShraddhaM on 23,Aug 2007 for SP8 (Timesheet Report)
        dtFromDate = Request.Form("FromDate")
        dtToDate = Request.Form("ToDate")
        If Not dtFromDate Is Nothing Or dtFromDate <> "" Then
            'DayDiff = CType(DateDiff(DateInterval.Day, CType(dtFromDate, Date), CType(dtToDate, Date)) + 2, Integer)

            'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            'strDateDiffQuery = "Select DateDiff(d,'" + dtFromDate + "','" + dtToDate + "')"
            strDateDiffQuery = "usp_sel_DateDiff '" + dtFromDate + "','" + dtToDate + "'"
            'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            DayDiff = CType(CommonFunctions.Data.GetDataScalar(strDateDiffQuery, MyBase.UseSQL), Integer) + 2
        End If

        If Request.QueryString("TimesheetID") Is Nothing Then
            m_intTimesheetID = Request.Form("cboTimesheet")
        Else
            m_intTimesheetID = Request.QueryString("TimesheetID")
        End If
        If m_intTimesheetID = "" Then
            m_intTimesheetID = "0"
        End If

        m_ReportID = CommonFunction.General.CheckIsNothing(Request.QueryString("ReportID"), "0")
        'strFromDate = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("FromDate"), ""), Date)
        'strToDate = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ToDate"), ""), Date)

        'End of modification and addition by ShraddhaM on 31, July 2007
        m_ReportID = "2107"
        CommonFunction.Data.DisposeDataReader(dr)
        'End of addition by PrashantD on 9 March 2007

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "EXPORT" Then
            'To handle the capturing Error and Generating report in the DLL code 
            'Put the code to generate the report in the procedure
            Call ShowReport()

        End If
    End Sub

    Private Sub ShowReport()
        '=====================================================================
        ' Procedure Name        : ShowReport
        ' Purpose               : Function used to generate the Report depending on the Chosen Format
        ' Description           : The Chosen Format is specified in Querystring
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Mar 02 ,2004   
        ' Revisions             :
        '=====================================================================

        Dim strFileName As String
        Dim sExtension, sFilePath, sPath As String
        Dim objResult As Object

        Dim drSQL As IDataReader
        Dim strQuery As String
        Dim strDateDiffQuery As String

        'Added by ShraddhaM on 31, July 2007 
        Dim strFromDate As String
        Dim strToDate As String
        strFromDate = Request.Form("FromDate")
        strToDate = Request.Form("ToDate")

        If m_intTimesheetID = "0" Then
            strQuery = "usp_CRW_Sel_tbl_PM_DailyActivity_TimesheetView NULL,'" + strFromDate + "','" + strToDate + "'," + HttpContext.Current.Session("intUserID").ToString()
        Else
            strQuery = "usp_CRW_Sel_tbl_PM_DailyActivity_TimesheetView " + m_intTimesheetID + ",'" + strFromDate + "','" + strToDate + "'," + HttpContext.Current.Session("intUserID").ToString()
        End If

        'End of adddition by ShraddhaM on 31, July 2007

        strFormat = CommonFunctions.General.CheckIsNothing(Request.QueryString("Format"), "PDF")

        ' Setting the extensions based on the required format
        Select Case strFormat
            Case "PDF"
                ' PDF Format
                sExtension = ".pdf"

            Case "HTML"
                ' HTML format
                sExtension = ".htm"

            Case "EXCEL"
                ' Excel Format
                sExtension = ".xls"

            Case "RTF"
                ' RTF Format
                sExtension = ".rtf"

            Case "CSV"
                ' CSV Format
                sExtension = ".csv"

            Case "TEXT"
                ' TEXT Format
                sExtension = ".txt"

            Case "XML"
                ' TEXT Format
                sExtension = ".xml"

            Case Else
                ' By Default show PDF format report
                strFormat = "PDF"
                sExtension = ".pdf"
        End Select

        ' Create a random and Unique file name
        sFilePath = CommonFunction.FileDirectory.GetUniqueFileName().Trim

        sPath = Server.MapPath("../../Reports/") + sFilePath + sExtension
        strFileName = sFilePath + sExtension

        If strQuery <> "" Then

            '-- Execute the SQL Query once to check if any data is returned 
            objResult = CommonFunctions.Data.GetDataScalar(strQuery.Trim, MyBase.UseSQL)
            If objResult Is Nothing Then

                '-- Alert user
                CommonFunctions.General.WriteHTML("<Script language=javascript>")
                CommonFunctions.General.WriteHTML("alert(""" + MyBase.GetResourceString("MSG_NO_ITEMS") + """); window.close();")
                CommonFunctions.General.WriteHTML("</Script>")

                m_oReport = Nothing
                objResult = Nothing
                Exit Sub
            End If
            objResult = Nothing


            ' Modified By NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 63 
            ' Added Error Handler 
            Try
                ' Create the report object
                m_oReport = New AdHocReports.Report.AdHocReport(CType(m_ReportID, Long), strQuery, CommonFunctions.Application.ConnectionString, sPath, CommonFunctions.FileDirectory.CleanPath(Server.MapPath(CONST_ERROR_LOG)))

                ' set the properties and generate the report
                With m_oReport

                    .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                    .LCID = MyBase.CurrentThreadUICultureID

                    .GraphImageGenerationAbsolutePath = Server.MapPath("../../Images/")

                    If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                        .UseHashTables = True
                    Else
                        .UseHashTables = False
                    End If
                    '.ConnectionString = CommonFunctions.Application.ConnectionString
                    '.FilePathName = sPath
                    '.ErrorLogFilePathName = CommonFunctions.FileDirectory.CleanPath(Server.MapPath(CONST_ERROR_LOG))
                    '.SQLSource = strQuery
                    '.Title = "TimeSheet"
                    .EmptyValueReplacement = "-"
                    '.LogoPathName = Server.MapPath("../../images/customerlogo.gif")
                    .UseMSSQL = MyBase.UseSQL
                    .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                    '.FontName = "Arial"
                    .CompanyName = CommonFunctions.Application.CompanyName

                End With

                ' generate the report in requested format
                Select Case strFormat
                    Case "PDF" : m_oReport.GenerateReport(AdHocReports.Format.PDF)
                    Case "HTML" : m_oReport.GenerateReport(AdHocReports.Format.HTML)
                    Case "RTF" : m_oReport.GenerateReport(AdHocReports.Format.RTF)
                    Case "EXCEL" : m_oReport.GenerateReport(AdHocReports.Format.EXCEL)
                    Case "CSV" : m_oReport.GenerateReport(AdHocReports.Format.CSV)
                    Case "TEXT" : m_oReport.GenerateReport(AdHocReports.Format.TEXT)
                    Case "XML" : m_oReport.GenerateReport(AdHocReports.Format.XML)
                    Case Else : m_oReport.GenerateReport(AdHocReports.Format.PDF)
                End Select
                m_oReport = Nothing



                'Added and commented by PrashantD on 21 Aug 2007 for WhizFrameWork SP8
                ' Showing the generated report in a new window		
                'open window to show the output file of the report
                'CommonFunctions.General.WriteHTML("<Script language=javascript>")
                'CommonFunctions.General.WriteHTML("window.open(""../CRW/CRW_ReportOutput.aspx?filename=" + strFileName + ""","""",""menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,width=500,height=500"");")
                'CommonFunctions.General.WriteHTML("</Script>")

                strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(strFileName))
                Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + strFileName, True)
                'End of addition by PrashantD on 21 Aug 2007
                ' Release the resources 
            Catch ex As Exception
                m_oReport = Nothing
            End Try

        End If

    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : PrepareMenu
        ' Purpose               : Function used to draw the Bottom menu..
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), MyBase.GetResourceString("MENU_HTML"), MyBase.GetResourceString("MENU_RTF"), MyBase.GetResourceString("MENU_EXCEL"), MyBase.GetResourceString("MENU_CSV"), MyBase.GetResourceString("MENU_TEXT"), MyBase.GetResourceString("MENU_XML"), MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), MyBase.GetResourceString("MENU_HTML_TOOLTIP"), MyBase.GetResourceString("MENU_RTF_TOOLTIP"), MyBase.GetResourceString("MENU_EXCEL_TOOLTIP"), MyBase.GetResourceString("MENU_CSV_TOOLTIP"), MyBase.GetResourceString("MENU_TEXT_TOOLTIP"), MyBase.GetResourceString("MENU_XML_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Export_OnClick('PDF')", "Export_OnClick('HTML')", "Export_OnClick('RTF')", "Export_OnClick('EXCEL')", "Export_OnClick('CSV')", "Export_OnClick('TEXT')", "Export_OnClick('XML')", "Close_OnClick()"}
        Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu

        MyBase.InitializeResources("AppResources.IB_ShowReport", "AppResources")
    End Function

    Public Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Function used to draw the main Page : Top/bottom Menus, Page Caption and div
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : March 1,2004   
        ' Revisions             :
        '=====================================================================
        Dim strMenu, strPageCaption As String


        '-- TOP MENU
        strMenu = DrawMenu()
        Response.Write(strMenu + "<BR>")

        '-- PAGE CAPTION
        strPageCaption = CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("PAGE_CAPTION"), "Issue List")
        Response.Write("<BR>")

        Response.Write("<DIV ID=divList Style='WIDTH:100%;HEIGHT:90%OVERFLOW:auto'>")
        'Added by ShraddhaM on 24,aug 2007
        'For Timesheet Report
        m_intTimesheetID_Query = Request.QueryString("TimesheetID")
        If m_intTimesheetID_Query = "" Or m_intTimesheetID_Query = "0" Or m_intTimesheetID_Query Is Nothing Then
            m_intTimesheetID_Query = Request.Form("hidTimesheetID")
        End If
        CommonFunctions.General.WriteHTML("<input type = hidden name = 'hidTimesheetID' value =" + m_intTimesheetID_Query + ">")
        'End of addition by ShraddhaM on 24,aug 2007

        DrawUI()

        Response.Write("</DIV>")

        'Added By NitinVS on 4 July 2007 for WhizibleSEM 7 
        ' To show the disclaimer
        Dim strBaseResourceName As String = MyBase.ResourceName
        Dim strBaseResourceAssemblyName As String = MyBase.ResourceAssemblyName
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        m_strReportDisclaimer = MyBase.GetResourceString("REPORT_DISCLAIMER") + ""
        'Reset the resources.
        MyBase.InitializeResources(strBaseResourceName, strBaseResourceAssemblyName)
        Response.Write(m_strReportDisclaimer)
        'End Addition By NitinVS on 4 July 2007 for WhizibleSEM 7 

        '-- BOTTOM MENU
        Response.Write("<BR>" + strMenu)

    End Sub
    Protected Sub DrawUI()
        'Added by PrashantD on 9 March 2007
        Dim strQuery As String
        Dim dr As IDataReader


        If Request.Form("cboTimesheet") Is Nothing Then
            blnIsDiable = True
        ElseIf Request.Form("cboTimesheet") <> "" Then
            blnIsDiable = True
        Else
            blnIsDiable = False
        End If

        If Request.QueryString("TimesheetID") Is Nothing Then
            m_intTimesheetID_Query = Request.Form("hidTimesheetID")
        Else
            m_intTimesheetID_Query = Request.QueryString("TimesheetID")
        End If

        ''Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'strQuery = "SELECT TimeSheetID FROM tbl_PM_ResourceTimesheet WHERE TimeSheetID = " + m_intTimesheetID_Query '
        strQuery = "usp_sel_tbl_PM_ResourceTimesheet_FromDateToDate " + m_intTimesheetID_Query
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query

        dr = CommonFunction.Data.GetDataReader(strQuery, True)
        While dr.Read()
            strFromDate = CType(dr("FromDate").ToString(), Date)
            strToDate = CType(dr("ToDate").ToString(), Date)
        End While
        CommonFunction.Data.DisposeDataReader(dr)
        CommonFunction.General.WriteHTML("")
        CommonFunction.General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 width=100%>")
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")

        CommonFunction.General.WriteHTML("<TD align=right>Timesheet ID")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboTimesheet", "select " + m_intTimesheetID_Query, , m_intTimesheetID, "Onchange=javascript:cboTimesheet_onChange()", True, )
        CommonFunction.General.WriteHTML("</TD>")

        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML("From Date")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD>")
        CommonFunction.HTMLControls.DrawDateControl("FromDate", "FromDate", , , CommonFunctions.Dates.GetDate(strFromDate), , "frmShowReport", IsDisabled:=blnIsDiable)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML("To Date")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD>")
        CommonFunction.HTMLControls.DrawDateControl("ToDate", "ToDate", , , CommonFunctions.Dates.GetDate(strToDate), , "frmShowReport", IsDisabled:=blnIsDiable)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")

      
        CommonFunction.General.WriteHTML("</TABLE>")
        'End of addition by PrashantD on 9 March 2007

    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.IB_ShowReport", "AppResources")

    End Sub

   
    'Added By ShraddhaM on 27,Aug 2007 to remove report fields which r not in given date range
    Private Sub m_oReport_Control_BeforePlot(ByRef Cancel As Boolean, ByRef Args As AdHocReports.WAF_Control) Handles m_oReport.Control_BeforePlot
        Dim Day As String
        Dim DayCaption As String
        If strFormat.ToUpper <> "EXCEL" Then
            cntDayDiff = DayDiff
            cntDayCaptionDiff = DayDiff

            While cntDayDiff <= 31

                Day = "Day" + CType(cntDayDiff, String)
                DayCaption = "Day" + CType(cntDayCaptionDiff, String) + "Caption"

                If Args.ControlName = Day Then
                    Cancel = True
                    cntDayDiff = cntDayDiff + 1
                ElseIf Args.ControlName = DayCaption Then
                    Cancel = True
                    cntDayCaptionDiff = cntDayCaptionDiff + 1
                Else
                    Exit While
                End If
            End While


            If Args.ControlName = "ActualWork" Or Args.ControlName = "NormalAMH" Then
                Args.LeftPosition = CType(width - 1.0, Single)
            End If

            If Args.ControlName = "<REPORT_COMPANYNAME>" Or Args.ControlName = "Label" Or Args.ControlName = "FromTo" Then
                Args.ControlWidth = width
            End If
        End If

    End Sub

    Private Sub m_oReport_Report_BeforePrint(ByRef Cancel As Boolean, ByRef Args As AdHocReports.WAF_Report) Handles m_oReport.Report_BeforePrint
        If strFormat.ToUpper <> "EXCEL" Then
            width = 3.0 + CType(DayDiff, Double)
            Args.Width = width
        End If
        
    End Sub
    'End of modification By ShraddhaM on 27,Aug 2007 to remove report fields which r not in given date range
End Class
