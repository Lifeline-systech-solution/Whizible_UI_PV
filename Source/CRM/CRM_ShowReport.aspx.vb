Public Class CRM_ShowReport
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
    Protected m_strPageTitle As String
    Protected m_Title As String
    Protected m_strPageCaption As String
    Protected m_LoginType As String
    Protected m_ShowProduct As String
    Protected WithEvents m_Report As DynamicReports.Report
    ' Added by MahendraV On 9:27 AM 7/4/2007 for WhizibleSEM 7 
    ' The code changes required for the custom-report UI page 
    Protected m_strReportDisclaimer As String = ""
    ' End_MV_7/4/2007


    Private Const CONST_ERROR_LOG As String = "../../Attachments/Log/"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_LoginType = Session("LoginType").ToString
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("eDB"), "0") = "1" Then
            m_Title = "e-Dashboard"
        Else
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("mode"), "") = "SR" Then
                m_Title = "Submitted Requests"
            ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("mode"), "") = "AR" Then
                m_Title = "Assigned Requests"
            Else
                m_Title = "My e-Dashboard"
            End If
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Title"), "") <> "" Then
            m_Title = CommonFunctions.General.CheckIsNothing(Request.QueryString("Title"), "")
        End If


    End Sub

    Private Sub ShowReport()


        Dim strFormat, strFileName As String
        Dim sExtension, sFilePath, sPath As String

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

        If CommonFunctions.General.CheckIsNothing(Session("HelpDeskSQL")).Trim <> "" Then


            If CType(Session("HelpDeskROWS"), Long) = 0 Then

                CommonFunctions.General.WriteHTML("<Script language=javascript>")
                CommonFunctions.General.WriteHTML("alert(""" + MyBase.GetResourceString("MSG_NO_ITEMS") + """); window.close();")
                CommonFunctions.General.WriteHTML("</Script>")

                m_Report = Nothing
                objResult = Nothing
                Exit Sub
            End If


            Try
                ' Create the report object
                m_Report = New DynamicReports.Report

                ' set the properties and generate the report
                With m_Report
                    .ConnectionString = CommonFunctions.Application.ConnectionString
                    .FilePathName = sPath
                    .ErrorLogFilePathName = CommonFunctions.FileDirectory.CleanPath(Server.MapPath(CONST_ERROR_LOG))
                    .SQLSource = Session("HelpDeskSQL").ToString.Trim
                    .Title = m_strPageCaption
                    .EmptyValueReplacement = "-"
                    .LogoPathName = Server.MapPath("../../images/customerlogo.gif")
                    .UseMSSQL = MyBase.UseSQL
                    .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                    .FontName = "Arial"
                    .CompanyName = CommonFunctions.Application.CompanyName
                End With


                'If strFormat = "EXCEL" Then
                'm_Report.SQLSource = Session("IssueSQLForExel2").ToString.Trim
                'Else
                m_Report.SQLSource = Session("HelpDeskSQL").ToString.Trim
                'm_Report.SQLSource = Session("IssueSQL").ToString.Trim
                'End If
                '=========================================================================================
                'Additon Ends :                 PadmnabhA                   Thursday, July 14, 2005 9:27
                '========================================================================================= 


                ' generate the report in requested format
                Select Case strFormat
                    Case "PDF" : m_Report.GenerateReport(DynamicReports.Format.PDF)
                    Case "HTML" : m_Report.GenerateReport(DynamicReports.Format.HTML)
                    Case "RTF" : m_Report.GenerateReport(DynamicReports.Format.RTF)
                    Case "EXCEL" : m_Report.GenerateReport(DynamicReports.Format.EXCEL)
                    Case "CSV" : m_Report.GenerateReport(DynamicReports.Format.CSV)
                    Case "TEXT" : m_Report.GenerateReport(DynamicReports.Format.TEXT)
                    Case "XML" : m_Report.GenerateReport(DynamicReports.Format.XML)
                    Case Else : m_Report.GenerateReport(DynamicReports.Format.PDF)
                End Select
                m_Report = Nothing

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
                m_Report = Nothing
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
        MyBase.InitializeResources("AppResources.IB_ShowReport", "AppResources")
        Return strMenu


    End Function

    Public Sub DrawPage()

        Dim strMenu, strModule As String
        Dim dr As IDataReader



        dr = CommonFunctions.Data.GetDataReader("Select ModuleName From tbl_PM_SystemModules where ShortName = 'CRM'", MyBase.UseSQL)
        If dr.Read Then
            strModule = CType(dr("ModuleName"), String)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        m_ShowProduct = CType(CommonFunctions.Data.GetDataScalar("SELECT IsNull(EnableProductExecution,0) As Show FROM  tbl_PM_companyinformation ", MyBase.UseSQL), String)

        strMenu = DrawMenu()
        Response.Write(strMenu + "<BR>")

        'Modifed BY NitinVS on 4 July 2007 WhizibleSEM 7 
        ' To display approprite title 
        '-- PAGE CAPTION

        'm_strPageCaption = CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("PAGE_CAPTION"), strModule + " " + m_Title)
        m_strPageCaption = strModule + " " + m_Title
        ' End Modification BY NitinVS on 4 July 2007 WhizibleSEM 7 

        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, m_strPageCaption, , , True))

        Response.Write("<BR>")

        Response.Write("<DIV ID=divList Style='WIDTH:100%;OVERFLOW:auto'>")
        Response.Write("</DIV>")


        ' Added by MahendraV On 9:27 AM 7/4/2007 for WhizibleSEM 7 
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

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "EXPORT" Then
            Call ShowReport()
        End If
    End Sub


    Public Sub New()
        ''MyBase.ApplySecurity()
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("AppResources.IB_ShowReport", "AppResources")

    End Sub

    Private Sub m_Report_Report_InitializeSettings(ByRef Args As DynamicReports.WAF_ReportSettings) Handles m_Report.Report_InitializeSettings
        Select Case m_Title
            Case "e-Dashboard"
                If m_ShowProduct = "False" Then
                    'Comment and Modification by SuchitraP on 9-Apr-2009 
                    'Purpose : To adjust the width of report
                    'Args.Width = Args.Width - 36
                    'Args.Width = Args.Width - 53
                    Args.Width = Args.Width - 42
                Else
                    'Args.Width = Args.Width - 30
                    'Args.Width = Args.Width - 48
                    Args.Width = Args.Width - 36
                End If

            Case "My e-Dashboard"
                'Args.Width = Args.Width - 25
                Args.Width = Args.Width - 27

            Case "Submitted Requests"
                If m_ShowProduct = "False" Or m_LoginType = "E" Then
                    'Args.Width = Args.Width - 27
                    Args.Width = Args.Width - 30
                Else
                    'Args.Width = Args.Width - 20
                    Args.Width = Args.Width - 32
                End If

            Case "Assigned Requests"
                If m_ShowProduct = "False" Then
                    'Args.Width = Args.Width - 25
                    Args.Width = Args.Width - 34
                Else
                    'Args.Width = Args.Width - 20
                    Args.Width = Args.Width - 33
                    'End of comment and modification by SuchitraP on 9-Apr-2009 
                End If

        End Select
    End Sub

    Private Sub m_Report_Control_BeforePlot(ByRef Cancel As Boolean, ByRef Args As DynamicReports.WAF_Control) Handles m_Report.Control_BeforePlot
        Select Case m_Title
            Case "e-Dashboard"
                If Args.DataField = "Attachments" Or Args.DataField = "Description" Or Args.DataField = "Discussions" Or Args.DataField = "StatusID" Or Args.DataField = "FunctionID" Or Args.DataField = "PriorityID" Or Args.DataField = "NoOfAttachments" Or Args.DataField = "NoOfDiscussions" Or Args.DataField = "NoOfIssues" Or Args.DataField = "IsDiscussionViewed" Or Args.DataField = "TaskID" Or Args.DataField = "TaskAssignedToUserName" Or Args.DataField = "IssueCount" Or Args.DataField = "FlagDateStatus" Or Args.DataField = "FlagTo" Then
                    Cancel = True
                End If
                If Args.DataField = "Product" Or Args.DataField = "Component" Then
                    If m_ShowProduct = "False" Then
                        Cancel = True
                    End If
                End If

            Case "My e-Dashboard"
                If Args.DataField = "Attachments" Or Args.DataField = "Description" Or Args.DataField = "Discussions" Or Args.DataField = "StatusID" Or Args.DataField = "FunctionID" Or Args.DataField = "PriorityID" Or Args.DataField = "NoOfAttachments" Or Args.DataField = "NoOfDiscussions" Or Args.DataField = "NoOfIssues" Or Args.DataField = "IsDiscussionViewed" Or Args.DataField = "TaskID" Or Args.DataField = "TaskAssignedToUserName" Or Args.DataField = "IssueCount" Or Args.DataField = "FlagDateStatus" Or Args.DataField = "FlagTo" Then
                    Cancel = True
                End If


            Case "Submitted Requests"

                If Args.DataField = "Attachments" Or Args.DataField = "Description" Or Args.DataField = "Discussions" Or Args.DataField = "StatusID" Or Args.DataField = "PriorityID" Or Args.DataField = "NoOfAttachments" Or Args.DataField = "NoOfDiscussions" Or Args.DataField = "IsDiscussionViewed" Or Args.DataField = "IssueID" Then
                    Cancel = True
                End If
                If Args.DataField = "Product" Or Args.DataField = "Component" Then
                    If m_LoginType = "E" Or m_ShowProduct = "False" Then
                        Cancel = True
                    End If
                End If
                'Added by VarunA on 10-July-2007 Whizible 7.0 Development and Release
                'Purpose : Not to show value of ExpectedResolvedDate and AssignTo to Customer
                If Args.DataField = "ExpectedResolvedDate" Or Args.DataField = "AssignTo" Then
                    If m_LoginType = "C" Then
                        Cancel = True
                    End If
                End If
                'End By VarunA on 10-July-2007

            Case "Assigned Requests"

                If Args.DataField = "Attachments" Or Args.DataField = "Description" Or Args.DataField = "Discussions" Or Args.DataField = "StatusID" Or Args.DataField = "PriorityID" Or Args.DataField = "NoOfAttachments" Or Args.DataField = "NoOfDiscussions" Or Args.DataField = "IsDiscussionViewed" Or Args.DataField = "IssueID" Then
                    Cancel = True
                End If
                If Args.DataField = "Product" Or Args.DataField = "Component" Then
                    If m_ShowProduct = "False" Then
                        Cancel = True
                    End If
                End If

        End Select

        If Args.SectionName.Trim.ToUpper = "REPORTHEADER" Then
            If UCase(Trim(Args.ControlText & "")) = "GENERATED BY:" Then
                Args.ControlText = "Generated By: " & Session("strUserName").ToString
            End If
        End If

        'Modified By NitinVS on 5 July 2007 for WhizibleSEM 7 
        ' Exp. Date of resolution and assignto should not be shown to customer
        Select Case Args.ControlText
            Case "QueryID"
                Args.ControlText = "Request ID "
            Case "SubmittedDate"
                Args.ControlText = "Requested ON"
            Case "ExpectedResolvedDate"
                If Session("LoginType").ToString() = "C" Then
                    Cancel = True
                End If
                Args.ControlText = "Exp. Date of Resolution"
            Case "RequestType"
                Args.ControlText = "Request Type"
            Case "SubRequestType"
                Args.ControlText = "Sub Request Type"
            Case "CustomerName"
                Args.ControlText = "Requestor Name"
            Case "CustomerID"
                Args.ControlText = "Requestor"
            Case "Component"
                Args.ControlText = "Module/Component"
            Case "LastDiscussionThread"
                Args.ControlText = "Last Discussion"
            Case "LastIssue"
                Args.ControlText = "Last Issue"
            Case "AssignTo"
                If Session("LoginType").ToString() = "C" Then
                    Cancel = True
                End If
        End Select
        'End Modification By NitinVS on 5 July 2007 for WhizibleSEM 7 

        'Addition by SuchitraP on 9-Apr-2009 
        'Purpose: To remove newly added like AssignToID,TotalTimeSpent etc fields from report
        If Args.ControlText = "Last Issue" Or Args.ControlText = "LastIssueStatus" Or Args.ControlText = "LastIssueProject" Or Args.ControlText = "Assign Issue" Or Args.ControlText = "Reject" Or Args.ControlText = "AssignTask" Or Args.ControlText = "AssignToID" Or Args.ControlText = "TotalTimeSpent" Or Args.ControlText = "TodaysTotalTimeSpent" Or Args.ControlText = "AssignToName" Or Args.ControlText = "IsHRMOrDeptHead" Or Args.ControlText = "LastUpdatedDate" Then
            Cancel = True
        End If

        If Args.DataField = "LastIssue" Or Args.DataField = "LastIssueStatus" Or Args.DataField = "LastIssueProject" Or Args.DataField = "Assign Issue" Or Args.DataField = "Reject" Or Args.DataField = "AssignTask" Or Args.DataField = "AssignToID" Or Args.DataField = "TotalTimeSpent" Or Args.DataField = "TodaysTotalTimeSpent" Or Args.DataField = "AssignToName" Or Args.DataField = "IsHRMOrDeptHead" Or Args.DataField = "LastUpdatedDate" Then
            Cancel = True
        End If
        'End of addition by SuchitraP on 9-Apr-2009
    End Sub

End Class
