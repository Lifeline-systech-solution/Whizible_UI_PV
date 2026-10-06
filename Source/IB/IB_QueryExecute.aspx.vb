Imports CommonFunctions

Public Class IB_QueryExecute
    Inherits WebPages.Template.WhizTemplate

    Protected CONST_SHOW_MENU As String = "SHOW"
    Protected CONST_ACTION_EXECUTE As String = "EXEC"
    Protected m_strMode As String
    Protected m_strWindowTitle As String
    Private m_strAction As String
    Private m_strFormat As String
    Private m_strQueryIDList As String
    ' Added by MahendraV On 10:58 AM 7/4/2007 for WhizibleSEM 7 
    ' The code changes required for the custom-report UI page 
    Protected m_strReportDisclaimer As String = ""
    ' End_MV_7/4/2007

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_QUERY_EXEC")
    End Sub
    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.IB_QueryBuilder", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 6 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim objHeader As WebPage.Templates.HeaderFooter

        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_SHOW_MENU 'default mode 
        m_strAction = Request.QueryString("Action") + ""
        m_strQueryIDList = Request.QueryString("QueryIDList") + ""
        If m_strQueryIDList = "" Then m_strQueryIDList = MyBase.GetFormValue("txtQueryID") + ""
        m_strFormat = Request.QueryString("Format") + ""

        Select Case m_strMode

            Case CONST_SHOW_MENU

                If m_strAction <> "" Then
                    Call GenerateReport(m_strFormat)
                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList
                'integration by Harshada D on 16092005 for excel2 issueid 266
                ' added by Harshada D on 05-08-2005 for show /hide EXCEL option according to web.config setting .
                Dim strExcel As String
                strExcel = CommonFunctions.General.GetApplicationKeySetting("WAF_CRW_FormatsToBeDisabled")
                'here if this key WAF_CRW_FormatsToBeDisabled contain value "EXCEL" then excel option is drawn . 
                '- removed option excel from  arrMenu,arrMenuToolTip ,arrClientSideFunction 
                If strExcel = "EXCEL" Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_PDF")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_PDF_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('PDF')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_HTML")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HTML_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('HTML')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_RTF")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_RTF_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('RTF')")
                    'arrMenu.Add(MyBase.GetResourceString("MENU_EXCEL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_EXCEL_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('Excel')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_CSV")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CSV_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('CSV')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_TEXT")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_TEXT_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('Text')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('IB_QB_QUERY_RESULT')")
                Else
                    ' end of addition by Harshada D on 05-08-2005 for show /hide EXCEL option according to web.config setting .
                    ' end of integration by Harshada D on 16092005 for excel2 issueid 266

                    arrMenu.Add(MyBase.GetResourceString("MENU_PDF")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_PDF_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('PDF')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_HTML")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HTML_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('HTML')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_RTF")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_RTF_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('RTF')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_EXCEL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_EXCEL_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('Excel')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_CSV")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CSV_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('CSV')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_TEXT")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_TEXT_TOOLTIP")) : arrClientSideFunctions.Add("Menu_OnClick('Text')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('IB_QB_QUERY_RESULT')")
                    'integration by Harshada D on 16092005 for excel2 issueid 266
                    ' added by harshada d on 05082005 for EXCEL2
                End If
                ' end of addition by Harshada D on 05-08-2005 for show /hide EXCEL option according to web.config setting .
                ' end of integration by Harshada D on 16092005 for excel2 issueid 266
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
                'draw upper menu
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                'initialize the resource file for SDLC_Process page.
                MyBase.InitializeResources("AppResources.IB_QueryBuilder", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_QUERY_EXEC"))
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_QUERY_EXEC") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                General.WriteHTML("<Div id='DivList' width=100% height=90% ></Div>")

                'keep the query id list in the hidden text box
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                General.WriteHTML(HTMLControls.DrawTextBox("txtQueryID", "txtQueryID", , , , m_strQueryIDList.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:06/10/15
            Case Else
                    General.WriteHTML("<Div id='DivList' width=100% height=90%></Div>")
        End Select
        ' Added by MahendraV On 10:58 AM 7/4/2007 for WhizibleSEM 7 
        ' The code changes required for the custom-report UI page 
        ' Start_MV_7/4/2007
        Dim strBaseResourceName As String = MyBase.ResourceName
        Dim strBaseResourceAssemblyName As String = MyBase.ResourceAssemblyName
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        m_strReportDisclaimer = MyBase.GetResourceString("REPORT_DISCLAIMER") + ""

        'Reset the resources.
        MyBase.InitializeResources(strBaseResourceName, strBaseResourceAssemblyName)
        Response.Write("<BR>" + m_strReportDisclaimer)
        ' End_MV_7/4/2007
        'draw lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)

    End Sub

    '=====================================================================
    ' Procedure Name		:	GenerateReport
    ' Parameters Passed		:	strFormat - String
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To execute the queries selected and display result in the given format
    ' Description			:	This procedure will execute the query(s) by passing queryID's to the Sp.
    '                           For execution and building the output here object of AdhocReports class is
    '                           used.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 6 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub GenerateReport(ByVal strFormat As String)
        Dim strExtension As String
        Dim lngProjectID As Long
        Dim strSQL As String
        Dim strFilePath As String
        Dim strFileName As String
        Dim objReport As DynamicReports.Report

        'lngProjectID = CType(Session("intProjectID"), Long)
        lngProjectID = CType(Session("IssueProject"), Long)

        'if list has any single quote at the end then remove it
        If m_strQueryIDList.EndsWith(",") = True Then m_strQueryIDList = m_strQueryIDList.TrimEnd(","c)

        'create the sql to execute the selected query(s), Here queryID are passed to SP
        'and Sp executes the query(s)
        strSQL = "EXEC usp_Sel_tbl_IB_Query_ExecuteQuery " + lngProjectID.ToString + ",'" + m_strQueryIDList.Trim + "'"

        'set the extension for the report output file based on the format
        Select Case strFormat.ToUpper
            Case "PDF"
                strExtension = ".pdf"
            Case "HTML"
                strExtension = ".html"
            Case "CSV"
                strExtension = ".csv"
            Case "RTF"
                strExtension = ".rtf"
            Case "TEXT"
                strExtension = ".txt"
            Case "EXCEL"
                strExtension = ".xls"
            Case Else
        End Select

        'get unique fielename to create new output file with that name
        strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))
        ' get a unique file name
        strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim

        'if it is HTML format then no need for extension, else extension is required
        'If strFormat.ToUpper <> "HTML" Then
        strFileName += strExtension.Trim
        'End If

        strFilePath = strFilePath.Trim + strFileName.Trim

        ' create object of Adhoc reports and execute the SP to get the output of the query 
        objReport = New DynamicReports.Report
        objReport.UseMSSQL = MyBase.UseSQL
        objReport.DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
        objReport.CompanyName = CommonFunctions.Application.CompanyName
        objReport.ConnectionString = CommonFunctions.Application.ConnectionString
        objReport.EmptyValueReplacement = "-"
        objReport.FilePathName = strFilePath
        objReport.FontName = "Arial"
        objReport.SQLSource = strSQL
        objReport.LogoPathName = Server.MapPath("../../images/customerlogo.gif")

        ' generate the report in requested format
        'Modified By VidyaJ - For IssueID - 503 - Sp4
        Select Case strFormat.ToUpper
            Case "PDF" : objReport.GenerateReport(DynamicReports.Format.PDF)
            Case "HTML" : objReport.GenerateReport(DynamicReports.Format.HTML)
            Case "RTF" : objReport.GenerateReport(DynamicReports.Format.RTF)
            Case "EXCEL" : objReport.GenerateReport(DynamicReports.Format.EXCEL)
            Case "CSV" : objReport.GenerateReport(DynamicReports.Format.CSV)
            Case "TEXT" : objReport.GenerateReport(DynamicReports.Format.TEXT)
            Case "XML" : objReport.GenerateReport(DynamicReports.Format.XML)
            Case Else : objReport.GenerateReport(DynamicReports.Format.PDF)
        End Select
        objReport = Nothing

        strFilePath = "../../Reports/" + strFileName.Trim
        'Added and commneted by PrashantD on 21 Aug 2007 for WhizFrameWork SP8
        ''open window to show the output file of the report
        'General.WriteHTML("<Script language=javascript>")
        'General.WriteHTML("window.open('../CRW/CRW_ReportOutput.aspx?filename=" + strFileName.Trim + "','','menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,width=500,height=500');")
        'General.WriteHTML("</Script>")
        strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(strFileName))
        Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + strFileName, True)
        'End of addition by PrashantD on 21 Aug 2007
    End Sub

End Class
