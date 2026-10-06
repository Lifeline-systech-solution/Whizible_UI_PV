Public Class IB_ShowReport
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
    Protected m_strPageTitle As String
    Protected WithEvents m_oReport As DynamicReports.Report
    'Added by ShradhhaM on 15 March 2007 for FOURSOFT IssueID : 5189
    Private m_strReportFieldList As String
    'End of addition by ShradhhaM


    Private Const CONST_ERROR_LOG As String = "../../Attachments/Log/"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")

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

        Dim strFormat, strFileName As String
        Dim sExtension, sFilePath, sPath, strViewID As String

        strViewID = CType(Session("intViewID"), String)

        Dim objResult As Object

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
        sFilePath = CommonFunction.FileDirectory.GetUniqueFileName()

        sPath = Server.MapPath("../../Reports/") + sFilePath + sExtension
        strFileName = sFilePath + sExtension

        If CommonFunctions.General.CheckIsNothing(Session("IssueSQL")).Trim <> "" Then

            '-- Execute the SQL Query once to check if any data is returned 
            objResult = CommonFunctions.Data.GetDataScalar(Session("IssueSQL").ToString.Trim, MyBase.UseSQL)
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
                m_oReport = New DynamicReports.Report

                ' set the properties and generate the report
                With m_oReport
                    .ConnectionString = CommonFunctions.Application.ConnectionString
                    .FilePathName = sPath
                    .ErrorLogFilePathName = CommonFunctions.FileDirectory.CleanPath(Server.MapPath(CONST_ERROR_LOG))
                    .SQLSource = Session("IssueSQL").ToString.Trim
                    .Title = "Issue List"
                    .EmptyValueReplacement = "-"
                    .LogoPathName = Server.MapPath("../../images/customerlogo.gif")
                    .UseMSSQL = MyBase.UseSQL
                    .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                    'Modified by vidyak for PDF Higher Versions
                    .FontName = "Verdana"


                    'End Modified by vidyak for PDF Higher Versions
                    .CompanyName = CommonFunctions.Application.CompanyName
                End With

                'integrated by harshada d on 15092005 for EXCEL2
                '=========================================================================================
                'Code Added :                   PadmnabhA                   Thursday, July 14, 2005 9:27
                'Purpose    :   Query for Excel2 format is generated without image columns on IssuList page
                '               This query is used for Excel2 format.
                '========================================================================================= 
                If strFormat = "EXCEL" Then
                    m_oReport.SQLSource = Session("IssueSQLForExel2").ToString.Trim
                Else
                    Dim strSQL As String
                    strSQL = Session("IssueSQL").ToString.Trim
                    'strSQL = strSQL.Replace(",ReportedBy,CAST (ReportedDate AS VARCHAR) ReportedDate ", "")
                    strSQL = strSQL.Replace(",ReportedBy,CAST (ReportedDate AS VARCHAR)  ReportedDate ", "")
                    'Added By Usha Pandit On 31.03.2020 For not displaying IssueId multiple times in xml report
                    strSQL = strSQL.Replace("IssueID as IID,", "")
                    'End Of Added By Usha Pandit On 31.03.2020 For not displaying IssueId multiple times in xml report

                    m_oReport.SQLSource = strSQL

                    '",ReportedBy,CAST (ReportedDate AS VARCHAR) ReportedDate "
                    'm_oReport.SQLSource = m_oReport.SQLSource.Replace(",ReportedBy,CAST (ReportedDate AS VARCHAR) ReportedDate ", "")
                End If
                '=========================================================================================
                'Additon Ends :                 PadmnabhA                   Thursday, July 14, 2005 9:27
                '========================================================================================= 
                'Added by ShradhhaM on 15 March 2007 for FOURSOFT IssueID : 5189
                If Session("MyIssueMode") Is Nothing Then
                    m_strReportFieldList = GetViewFields()
                    'commented by dipali v on 11th nov 2021 for to get header as per view for all filter flag(eg.Myfilter,Flagged filter)
                    ' ElseIf Session("MyIssueMode").ToString <> "F" Then
                    'End of commented by dipali v on 11th nov 2021 for to get header as per view for all filter flag(eg.Myfilter,Flagged filter)


                Else
                    'commented by dipali v on 11th nov 2021 for to get header as per view for all filter flag(eg.Myfilter,Flagged filter)

                    'm_strReportFieldList = "IssueID,LastDiscussionThread"
                    m_strReportFieldList = GetViewFields()
                    'commented by dipali v on 11th nov 2021 for to get header as per view for all filter flag(eg.Myfilter,Flagged filter)


                End If
                'End of addition by ShradhhaM

                ' generate the report in requested format
                Select Case strFormat
                    Case "PDF" : m_oReport.GenerateReport(DynamicReports.Format.PDF)
                    Case "HTML" : m_oReport.GenerateReport(DynamicReports.Format.HTML)
                    Case "RTF" : m_oReport.GenerateReport(DynamicReports.Format.RTF)
                    Case "EXCEL" : m_oReport.GenerateReport(DynamicReports.Format.EXCEL)
                    Case "CSV" : m_oReport.GenerateReport(DynamicReports.Format.CSV)
                    Case "TEXT" : m_oReport.GenerateReport(DynamicReports.Format.TEXT)
                    Case "XML" : m_oReport.GenerateReport(DynamicReports.Format.XML)
                    Case Else : m_oReport.GenerateReport(DynamicReports.Format.PDF)
                End Select
                m_oReport = Nothing

                ' Showing the generated report in a new window		
                'Added and commneted by PrashantD on 21 Aug 2007 for WhizFrameWork SP8
                ''open window to show the output file of the report
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

            ' End Modification By NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 63 
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
        'Modified by by SandipL on 8 Feb 2006 to show current Project Name as right PageCaption
        Dim strProjectName As String
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectNameID " + CType(Session("IssueProject"), String), True), String)
        'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(Session("IssueProject"), String), True), String)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, strPageCaption, "Project: " + strProjectName, , True))
        Response.Write("<BR>")

        Response.Write("<DIV ID=divList Style='WIDTH:100%;OVERFLOW:auto'>")
        Response.Write("</DIV>")


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
        '-- BOTTOM MENU
        Response.Write("<BR>" + strMenu)

    End Sub


    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.IB_ShowReport", "AppResources")

    End Sub

    Private Sub m_oReport_Control_BeforePlot(ByRef Cancel As Boolean, ByRef Args As DynamicReports.WAF_Control) Handles m_oReport.Control_BeforePlot
        '-- We remove these Columns from the SQL Query as we do not want them in the Report
        'Modified By VidyaJ - Execel 2 issue - 
        If Args.DataField = "Attachments" Or Args.DataField = "DA" Or Args.DataField = "Discussions" Or Args.DataField = "DAPresent" Or Args.DataField = "Copy" Then
            Cancel = True
        End If
        ' Added By Rajanikant Apr 23,2004
        If Args.SectionName.Trim.ToUpper = "REPORTHEADER" Then
            If UCase(Trim(Args.ControlText & "")) = "GENERATED BY:" Then
                ' Showing the session username as generated by
                Args.ControlText = "Generated By: " & Session("strUserName").ToString
            End If
        End If
        ' End Addition Apr 23,2004
        'Integrated by SandipL SP8 to SP9
        'Added by PrashantD on 9 April 2007
        If Args.ControlType = "LABEL" Then
            If Args.ControlText.ToUpper = "PRODUCTVERSION" Then
                Args.ControlText = "Product"
            ElseIf Args.ControlText.ToUpper = "COMPONENT" Then
                Args.ControlText = "Module/Component"
            End If
        End If
        'End of addition by PrashantD on 9 April 2007
        'End Integration by SandipL
        'Added by ShradhhaM on 15 March 2007 for FOURSOFT IssueID : 5189
        If InStr(m_strReportFieldList, Args.DataField) = 0 Then
            Cancel = True
        End If

        'End of addition by ShradhhaM

    End Sub

    Private Sub m_oReport_Report_InitializeSettings(ByRef Args As DynamicReports.WAF_ReportSettings) Handles m_oReport.Report_InitializeSettings
        '-- we reduce the width of the report as we are preventing some columns from getting displayed in report
        Args.Width = Args.Width - 9
    End Sub

    Private Function GetViewFields() As String
        '=====================================================================
        ' Function Name         : GetViewFields()	
        ' Purpose               : Similar to GetViewName in IBIssueList.aspx.vb 
        ' Description           : To get fieldList of applied view, if any, by the user
        ' Parameters Passed     : None
        ' Returns               : string(fieldList of Applied View)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShradhhaM
        ' Created               : 15 March 2007
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim m_FieldList As String
        Dim strProjectID As String
        If Request.QueryString("ProjectID") <> "" Then
            strProjectID = Request.QueryString("ProjectID")
        Else
            Return ""
        End If

        If Session("intViewID").ToString = "" Then
            'if ViewId not available in Session, Check for default view for user, if any
            Dim drDefaultView As IDataReader
            strSQL = "Exec usp_Sel_tbl_IB_DefaultView " + Session("intUserID").ToString + ", " + strProjectID + ", '" & Session("LoginType").ToString + "'"
            drDefaultView = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drDefaultView.Read Then
                'Get field list for the view to be applied
                m_FieldList = CType(drDefaultView("Fields"), String)

                'Destroy DataReader
                CommonFunctions.Data.DisposeDataReader(drDefaultView)
            Else
                'If no default view created for user, show corporate view
                Dim drCorporateView As IDataReader
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'strSQL = "select * from tbl_PM_CompanyInformation"
                strSQL = "usp_sel_tbl_PM_CompanyInformation_IBDefaultView"
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                drCorporateView = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drCorporateView.Read Then

                    'Get field list for the view to be applied
                    m_FieldList = CType(drCorporateView("IBDefaultView"), String)

                    CommonFunctions.Data.DisposeDataReader(drCorporateView)
                End If
                CommonFunctions.Data.DisposeDataReader(drDefaultView)
            End If

        Else 'Execute the given view
            strSQL = "EXEC usp_Sel_tbl_IB_Project_Views NULL,NULL,NULL," & CType(Session("intViewID"), String)
            Dim drDefaultView As IDataReader
            drDefaultView = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drDefaultView.Read Then

                'Get field list for the view to be applied
                m_FieldList = CType(drDefaultView("Fields"), String)

                'Destroy DataReader
                CommonFunctions.Data.DisposeDataReader(drDefaultView)
            Else
                'If no default view created for user, show corporate view
                Dim drCorporateView As IDataReader
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'strSQL = "select IBDefaultView from tbl_PM_CompanyInformation"
                strSQL = "usp_sel_tbl_PM_CompanyInformation_IBDefaultView"
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                drCorporateView = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drCorporateView.Read Then

                    'Get field list for the view to be applied
                    m_FieldList = CType(drCorporateView("IBDefaultView"), String)
                End If
                CommonFunctions.Data.DisposeDataReader(drCorporateView)
            End If

        End If

        Return m_FieldList

    End Function
End Class
