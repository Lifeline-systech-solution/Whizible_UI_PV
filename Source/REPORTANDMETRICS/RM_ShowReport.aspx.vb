Public Class RM_ShowReport
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
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting

    End Sub

#End Region
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected m_strReportDisclaimer As String = ""
    Protected m_strBUID As String
    Protected m_strOUID As String
    Protected m_strProjectID As String
    Protected m_strEmployeeID As String
    Protected m_strMode As String
    Protected m_strDateRangeID As String
    Protected m_intProjectReport As Integer
    Protected m_strDUID As String
    Protected m_ShowDeployableOnly As String
    Protected m_strSessionUserID As String
    Protected m_strLoginType As String = "E"
    Protected m_strLoginName As String = ""
    Private intRoleLevel As Integer
    Protected m_strProjectFilters As String = ""
    Protected intReportID As Long
    Private WithEvents oRpt As AdHocReports.Report.AdHocReport
    Protected m_intShowMessage As Integer = 0
    Protected m_strFileName As String
    Protected strFormat As String
    Protected strType As String
    'Addition done by SuchitraP on 16-Jan-2008
    'Purpose:To display report for Resource Utilization Filters
    Protected m_FromWhere As String
    Protected m_FilterID As String

    Protected m_lngQueryID As String
    Protected m_DateRangeID As String
    Protected m_ReportID As String
    Protected m_PKToken_FromDT As String

    'End of addition by SuchitraP


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        'Added by Shamkant S on 28-Jan-2016 to Generate and Validate Token
        If Not Request.QueryString("ResourceID") Is Nothing Then
            m_lngQueryID = CType(Request.QueryString("ResourceID"), String)
        Else
            m_lngQueryID = 0
        End If
        If Not Request.QueryString("ReportID") Is Nothing Then
            m_ReportID = CType(Request.QueryString("ReportID"), String)
        Else
            m_lngQueryID = 0
        End If
        If Not Request.QueryString("DateRangeID") Is Nothing Then
            m_DateRangeID = CType(Request.QueryString("DateRangeID"), String)
        Else
            m_DateRangeID = 0
        End If
        If Not Request.QueryString("PKToken") Is Nothing Then
            '  m_TokenKEY = CType(Request.QueryString("PKToken"), String)
            m_PKToken_FromDT = Trim(Request.QueryString("PKToken") & "")


        End If
        If m_PKToken_FromDT <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_ReportID, String) + CType(m_lngQueryID, String) + CType(m_DateRangeID, String) + "0" + "0", m_PKToken_FromDT) = False) Then

                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "ResourceID", CType(m_lngQueryID, String))
                'Token is Invalid now redirect to the Invalid Access Page

                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


            End If

        End If


        'End of addition by Shamkant S on 28-Jan-2016 to Generate and Validate Token
    End Sub
    'Addition by SuchitraP  on 10 Sep 2007
    Protected Sub WritePage()
        'User
        m_strSessionUserID = CType(Session("intUserID"), String)
        m_strLoginType = Session("LoginType").ToString
        m_strLoginName = Session("StrUserName").ToString

        'Report ID
        intReportID = CType(Request.QueryString("ReportID"), Long)
        strFormat = Request.QueryString("Format")

        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        'If middle level then apply filter for Projects
        If intRoleLevel = 2 Or m_strLoginType = "C" Then
            'Apply Role Access Filter for Project List
            m_strProjectFilters = ""
            Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            If strFilter <> "" Then
                m_strProjectFilters += strFilter
            End If

            Dim strRemove As String = "ProjectID IN"
            m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
            m_strProjectFilters = m_strProjectFilters.Replace("'", "")
            m_strProjectFilters = m_strProjectFilters.Replace("(", "")
            m_strProjectFilters = m_strProjectFilters.Replace(")", "")

        End If

        'BG
        If Not Request.QueryString("BUID") Is Nothing Then
            If Request.QueryString("BUID") <> "" Then
                m_strBUID = Request.QueryString("BUID")
            Else
                m_strBUID = "NULL"
            End If
        Else
            m_strBUID = "NULL"
        End If

        'OU
        If Not Request.QueryString("OUID") Is Nothing Then
            If Request.QueryString("OUID") <> "" Then
                m_strOUID = Request.QueryString("OUID")
            Else
                m_strOUID = "NULL"
            End If
        Else
            m_strOUID = "NULL"
        End If

        'Project ID
        If Not Request.QueryString("ProjectID") Is Nothing Then
            If Request.QueryString("ProjectID") <> "" Then
                m_strProjectID = Request.QueryString("ProjectID")
            Else
                m_strProjectID = "NULL"
            End If
        Else
            m_strProjectID = "NULL"
        End If

        'Employee ID
        If Not Request.QueryString("ResourceID") Is Nothing Then
            If Request.QueryString("ResourceID") <> "" Then
                m_strEmployeeID = Request.QueryString("ResourceID")
            Else
                m_strEmployeeID = "NULL"
            End If
        Else
            m_strEmployeeID = "NULL"
        End If

        'Mode
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                m_strMode = Request.QueryString("Mode")
            Else
                m_strMode = ""
            End If
        Else
            m_strMode = ""
        End If

        'Date Range
        If Not Request.QueryString("DateRangeID") Is Nothing Then
            If Request.QueryString("DateRangeID") <> "" Then
                m_strDateRangeID = Request.QueryString("DateRangeID")
            Else
                m_strDateRangeID = "3"
            End If
        Else
            m_strDateRangeID = "3"
        End If

        'Project Report
        If Not Request.QueryString("PROJECTREPORT") Is Nothing Then
            If Request.QueryString("PROJECTREPORT") <> "" Then
                m_intProjectReport = CType(Request.QueryString("PROJECTREPORT"), Integer)
            Else
                m_intProjectReport = 0
            End If
        Else
            m_intProjectReport = 0
        End If

        'DU
        If Not Request.QueryString("DUID") Is Nothing Then
            If Request.QueryString("DUID") <> "" Then
                m_strDUID = Request.QueryString("DUID")
            Else
                m_strDUID = "NULL"
            End If
        Else
            m_strDUID = "NULL"
        End If

        'Show Deployeble
        If Not Request.QueryString("ShowDeployableOnly") Is Nothing Then
            m_ShowDeployableOnly = Request.QueryString("ShowDeployableOnly").ToString()
        Else
            m_ShowDeployableOnly = "0"
        End If

        'Addition done by SuchitraP on 16-Jan-2008
        'Purpose:To display report for Resource Utilization Filters
        If Request.QueryString("FromWhere") Is Nothing OrElse Request.QueryString("FromWhere") = "" Then
            m_FromWhere = Request.Form("hidFromWhere")
            m_FilterID = Request.Form("hidFilterID")
        End If

        If Request.QueryString("FromWhere") = "Filter" Then
            m_FromWhere = Request.QueryString("FromWhere")
            m_FilterID = Request.QueryString("FilterID")
        End If

        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidFilterID' id='hidFilterID' value='" + m_FilterID + "'>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidFromWhere' id='hidFromWhere' value='" + m_FromWhere + "'>")

        'End of addition by SuchitraP


        Dim strMenu As String

        'Menu
        Dim arrMenu() As String = {"PDF", "HTML", "RTF", "EXCEL", "CSV", "TEXT", "XML", "Close", "?"}
        Dim arrMenuToolTip() As String = {"PDF OutPut", "HTML OutPut", "RTF OutPut", "EXCEL OutPut", "CSV OutPut", "TEXT OutPut", "XML OutPut", "Close", "Help"}
        Dim arrCSFunction() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", "ViewReport_OnClick('RTF')", "ViewReport_OnClick('EXCEL')", "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", "ViewReport_OnClick('XML')", "Close_OnClick()", "Help_OnClick('CRW_HELP_2038')"}
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)

        Response.Write(strMenu)
        Response.Write("<br>")

        Response.Write("<div style='OVERFLOW:auto; height:200' id='DivMain'></div>")
        Dim ViewReport As String
        ViewReport = Request.QueryString("ViewReport")

        If ViewReport = "1" Then
            If m_intProjectReport = 1 Then
                ShowReportForProject()
            Else
                ShowReportForResource()
            End If
        End If

        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        m_strReportDisclaimer = MyBase.GetResourceString("REPORT_DISCLAIMER") + ""
        'Reset the resources.
        'MyBase.InitializeResources(strBaseResourceName, strBaseResourceAssemblyName)
        Response.Write(m_strReportDisclaimer)
        Response.Write("<br>")

        Response.Write(strMenu)
        'End of Addition by SuchitraP  on 10 Sep 2007
    End Sub
    'Addition by SuchitraP  on 10 Sep 2007
    Private Sub ShowReportForProject()
        Dim strFilePath As String
        Dim strQuery As String
        Dim dr As IDataReader

        If intReportID = 2109 Then
            strQuery = "usp_Sel_ResourceUtilization_Monthly_Project " + m_strBUID + "," + m_strOUID + "," + m_strProjectID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",1" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_ShowDeployableOnly
        ElseIf intReportID = 2105 Then
            strQuery = "usp_Sel_ResourceUtilization_Monthly_Project " + m_strBUID + "," + m_strOUID + "," + m_strProjectID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",2" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_ShowDeployableOnly

        End If

        dr = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If dr.Read Then
            ' The reports are created in the "Reports" folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))

            ' get a unique file name
            m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim

            ' add extn to file name based on format requested
            Select Case UCase(Trim(strFormat))
                Case "PDF" : m_strFileName += ".pdf"
                Case "HTML" : m_strFileName += ".htm"
                Case "RTF" : m_strFileName += ".rtf"
                Case "EXCEL" : m_strFileName += ".xls"
                Case "CSV" : m_strFileName += ".csv"
                Case "TEXT" : m_strFileName += ".txt"
                Case "XML" : m_strFileName += ".xml"
                Case Else : m_strFileName += ".pdf"
            End Select

            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(intReportID, strQuery, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                .LCID = MyBase.CurrentThreadUICultureID
                .UseHashTables = True

                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName
                .GraphImageGenerationAbsolutePath = Server.MapPath("../../Images/")

                ' generate the report in requested format
                Select Case strFormat
                    Case "PDF" : .GenerateReport(AdHocReports.Format.PDF)
                    Case "HTML" : .GenerateReport(AdHocReports.Format.HTML)
                    Case "RTF" : .GenerateReport(AdHocReports.Format.RTF)
                    Case "EXCEL" : .GenerateReport(AdHocReports.Format.EXCEL)
                    Case "CSV" : .GenerateReport(AdHocReports.Format.CSV)
                    Case "TEXT" : .GenerateReport(AdHocReports.Format.TEXT)
                    Case "XML" : .GenerateReport(AdHocReports.Format.XML)
                    Case Else : .GenerateReport(AdHocReports.Format.PDF)
                End Select
            End With
            oRpt = Nothing

            m_strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(m_strFileName))
            Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + m_strFileName, True)

        Else
            m_intShowMessage = 1
        End If


        CommonFunctions.Data.DisposeDataReader(dr)
        'End of Addition by SuchitraP  on 10 Sep 2007
    End Sub
    'Addition by SuchitraP  on 10 Sep 2007
    Private Sub ShowReportForResource()
        Dim strFilePath As String
        Dim strQuery As String
        Dim dr As IDataReader

        If intReportID = 2110 Then
            strQuery = "usp_Sel_ResourceUtilization_Monthly " + m_strBUID + "," + m_strOUID + "," + m_strDUID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",1" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_ShowDeployableOnly
        ElseIf intReportID = 2106 Then
            strQuery = "usp_Sel_ResourceUtilization_Monthly " + m_strBUID + "," + m_strOUID + "," + m_strDUID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",2" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_ShowDeployableOnly
        ElseIf intReportID = 2126 Then
            strQuery = "usp_Sel_ResourceUtilization_Monthly_Filters " + m_strBUID + "," + m_strOUID + "," + m_strDUID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",1" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_FilterID + "," + m_ShowDeployableOnly
        ElseIf intReportID = 2124 Then
            strQuery = "usp_Sel_ResourceUtilization_Monthly_Filters " + m_strBUID + "," + m_strOUID + "," + m_strDUID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",2" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_FilterID + "," + m_ShowDeployableOnly
        End If

        dr = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If dr.Read Then
            ' The reports are created in the "Reports" folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))

            ' get a unique file name
            m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim

            ' add extn to file name based on format requested
            Select Case UCase(Trim(strFormat))
                Case "PDF" : m_strFileName += ".pdf"
                Case "HTML" : m_strFileName += ".htm"
                Case "RTF" : m_strFileName += ".rtf"
                Case "EXCEL" : m_strFileName += ".xls"
                Case "CSV" : m_strFileName += ".csv"
                Case "TEXT" : m_strFileName += ".txt"
                Case "XML" : m_strFileName += ".xml"
                Case Else : m_strFileName += ".pdf"
            End Select

            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(intReportID, strQuery, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                .LCID = MyBase.CurrentThreadUICultureID
                .UseHashTables = True
                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName
                .GraphImageGenerationAbsolutePath = Server.MapPath("../../Images/")

                ' generate the report in requested format
                Select Case strFormat
                    Case "PDF" : .GenerateReport(AdHocReports.Format.PDF)
                    Case "HTML" : .GenerateReport(AdHocReports.Format.HTML)
                    Case "RTF" : .GenerateReport(AdHocReports.Format.RTF)
                    Case "EXCEL" : .GenerateReport(AdHocReports.Format.EXCEL)
                    Case "CSV" : .GenerateReport(AdHocReports.Format.CSV)
                    Case "TEXT" : .GenerateReport(AdHocReports.Format.TEXT)
                    Case "XML" : .GenerateReport(AdHocReports.Format.XML)
                    Case Else : .GenerateReport(AdHocReports.Format.PDF)
                End Select
            End With
            oRpt = Nothing

            m_strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(m_strFileName))
            Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + m_strFileName, True)

        Else
            m_intShowMessage = 1
        End If


        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub
    'End of Addition by SuchitraP  on 10 Sep 2007


End Class
