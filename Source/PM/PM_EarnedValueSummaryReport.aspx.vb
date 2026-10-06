'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  PbNITE
' Module Name           :  PM_EarnedValueSummaryReport.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class PM_EarnedValueSummaryReport
    Inherits WebPages.Template.WhizTemplate
    Private WithEvents oRpt As AdHocReports.Report.AdHocReport
    Protected Const ACTION_VIEW_REPORT As String = "ViewReport"
    Protected m_lngReportID As Long = 0
    Protected m_lngMasterTagId As Long = 0
    Protected m_intProjectID As Integer = 0
    Protected m_strFileName As String = ""
    Protected m_strFromDate As String = ""
    Protected m_strToDate As String = ""
    Protected m_strID As String = "0"
    Protected m_StrType As String = "0"
    Protected m_intShowMessage As Integer = 0
    'Added by MahendraV On 10:37 AM 5/24/2007 for List of Reports modified for HTML Report Issue
    'Start_MV_5/24/2007
    Protected m_intOpenReportInSecurePage As Integer = 0
    'End_MV_5/24/2007

    ' Added by MahendraV On 10:58 AM 7/4/2007 for WhizibleSEM 7 
    ' The code changes required for the custom-report UI page 
    Protected m_strReportDisclaimer As String = ""
    ' End_MV_7/4/2007
#Region "ReportConstants"
    Protected Const EARNED_VALUE_SUMMARY_REPORT As Long = 1897
    Protected Const EARNED_VALUE_DETAILS_REPORT As Long = 1901
#End Region



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Member Variables"
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private strMenu As String
#End Region

#Region "Functions and Sub-Procedures"

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   NitinVS
        ' Created               :   31-Mar-2005
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()

        Dim objPageLegent As PageLegends
        Dim arrLegentImage() As String = {CommonFunctions.HTMLControls.DrawMandatoryImage(, True)}
        Dim arrLegent() As String = {"Mandatory"}
        Dim strAction As String
        Dim strSQL As String

        'Check if user wants to view the report or not
        strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))

        Dim oAccessFilter As New WebPage.Filters.cRoleLevelAccessFilter(HttpContext.Current.Session("strUserName").ToString, CType(HttpContext.Current.Session("intPostID"), Long), CType(HttpContext.Current.Session("intUserID"), Long), HttpContext.Current.Session("LoginType").ToString, CType(HttpContext.Current.Session("intLoginID"), Long), CType(HttpContext.Current.Session("intRoleLevel"), Integer), CType(HttpContext.Current.Session("IsCustomerCreated"), Boolean))
        Dim strProjectIDWhereClause As String
        oAccessFilter.UseSQL = MyBase.UseSQL
        oAccessFilter.AccessParameter = "ProjectID"
        strProjectIDWhereClause = oAccessFilter.GetRoleLevelAccessFilter()
        If strProjectIDWhereClause.Trim() = "" Then strProjectIDWhereClause = "(1=1)"

        'Get values from query string 
        strSQL = ""
        m_lngMasterTagId = CType(Request.QueryString("MasterTagID"), Long)
        m_lngReportID = CType(Request.QueryString("ReportID"), Long)
        m_intProjectID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), HttpContext.Current.Session("intProjectID").ToString), Integer)
        m_strFromDate = CommonFunction.General.CheckIsNothing(Request.QueryString("FromDate"), "")
        m_strToDate = CommonFunction.General.CheckIsNothing(Request.QueryString("ToDate"), "")
        m_strID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("strID"), "0"), String)
        m_StrType = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("strType"), "0"), String)

        If strAction <> ACTION_VIEW_REPORT Then

            'Draw Menu
            DrawMenu()
            CommonFunctions.General.WriteHTML(strMenu)
            CommonFunctions.General.WriteHTML("<BR>")

            'Show Mandatory image
            Response.Write(objPageLegent.DrawPageLegends(Nothing, arrLegentImage, arrLegent))

            'Display the page caption.
            DrawPageCaption()

            'Display the Header if exist. 
            DrawHeader()
        End If

        ' Initialise the Resource file 
        DrawReportUI()

        ' Added by MahendraV On 10:58 AM 7/4/2007 for WhizibleSEM 7 
        ' The code changes required for the custom-report UI page 
        ' Start_MV_7/4/2007
        Dim strBaseResourceName As String = MyBase.ResourceName
        Dim strBaseResourceAssemblyName As String = MyBase.ResourceAssemblyName
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        m_strReportDisclaimer = MyBase.GetResourceString("REPORT_DISCLAIMER") + ""
        If strAction <> ACTION_VIEW_REPORT Then

            'Reset the resources.
            MyBase.InitializeResources(strBaseResourceName, strBaseResourceAssemblyName)
            Response.Write("<BR>" + m_strReportDisclaimer)
            ' End_MV_7/4/2007

            'Display the Menu at bottom
            CommonFunctions.General.WriteHTML("<BR>")
            CommonFunctions.General.WriteHTML(strMenu)

        End If

        ' Clear Memory 
        DisposeObjects()


    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS
        ' Created               :  31-Mar-2005
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NitinVS
        ' Created               : 31-Mar-2005
        ' Revisions             :
        '=====================================================================
        ' integrated by harshada d on 16092005 for issue id : 266
        ' added by Harshada D on 05-08-2005 for show /hide EXCEL option according to web.config setting .
        Dim strExcel As String
        strExcel = CommonFunctions.General.GetApplicationKeySetting("WAF_CRW_FormatsToBeDisabled")
        ' end of addition by harshada d
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        ' added by Harshada D on 05-08-2005 for show /hide EXCEL option according to web.config setting .
        'here if this key WAF_CRW_FormatsToBeDisabled contain value "EXCEL" then excel option is drawn . 
        '- removed option excel from  arrMenu,arrMenuToolTip ,arrClientSideFunction 
        If strExcel = "EXCEL" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), _
                               MyBase.GetResourceString("MENU_HTML"), _
                               MyBase.GetResourceString("MENU_RTF"), _
                               MyBase.GetResourceString("MENU_CSV"), _
                               MyBase.GetResourceString("MENU_Text"), _
                               MyBase.GetResourceString("MENU_XML"), _
                               "Configuration", _
                               MyBase.GetResourceString("MENU_HELP")}
            'MyBase.GetResourceString("MENU_CONFIGURE"), _

            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HTML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_CSV_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_Text_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_XML_TOOLTIP"), _
                                              "Configuration", _
                                              MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            'MyBase.GetResourceString("MENU_CONFIGURE_TOOLTIP"), _

            Dim arrClientSideFunction() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", _
                                              "ViewReport_OnClick('RTF')", "ViewReport_OnClick('EXCEL')", _
                                               "ViewReport_OnClick('CSV')", _
                                              "ViewReport_OnClick('XML')", "Configure_OnClick(" & m_lngReportID.ToString & ")", "Help_OnClick(" & m_lngMasterTagId.ToString() & ")"}
            'cerate the static menu.
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)
        Else
            ' end of modification by harshada d on 05 - 08- 2005
            ' end of integration by harshada d for issue id 266 on 16092005

            MyBase.InitializeResources("Resources.StandardMenu", "Resources")
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), _
                               MyBase.GetResourceString("MENU_HTML"), _
                               MyBase.GetResourceString("MENU_RTF"), _
                               MyBase.GetResourceString("MENU_EXCEL"), _
                               MyBase.GetResourceString("MENU_CSV"), _
                               MyBase.GetResourceString("MENU_Text"), _
                               MyBase.GetResourceString("MENU_XML"), _
                               "Configuration", _
                               MyBase.GetResourceString("MENU_HELP")}
            'MyBase.GetResourceString("MENU_CONFIGURE"), _

            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HTML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_EXCEL_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_CSV_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_Text_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_XML_TOOLTIP"), _
                                              "Configuration", _
                                              MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            'MyBase.GetResourceString("MENU_CONFIGURE_TOOLTIP"), _

            Dim arrClientSideFunction() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", _
                                              "ViewReport_OnClick('RTF')", "ViewReport_OnClick('EXCEL')", _
                                              "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", _
                                              "ViewReport_OnClick('XML')", "Configure_OnClick(" & m_lngReportID.ToString & ")", "Help_OnClick(" & m_lngMasterTagId.ToString() & ")"}
            'cerate the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)
        End If

    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NitinVS
        ' Created               : 31-Mar-2005
        ' Revisions             :
        '=====================================================================

        Response.Write(PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        Response.Write("<BR>")

    End Sub

    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NitinVS
        ' Created               : 31-Mar-2005
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(strReturn)
        End If
        objHeader = Nothing

    End Sub

    Private Sub DisposeObjects()
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub

    Private Sub DrawReportUI()
        '====================================================================
        ' Procedure Name        :   DrawReportUI
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This Procedure will Plot the UI As Per the ReportID Passed.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   NitinVS
        ' Created               :   31 Mar 2005 
        ' Revisions             :   
        '=====================================================================

        Dim strSQL As String
        Dim strProjectName As String
        Dim objSection As WebPages.Template.SectionTitle
        Dim strTitle As String
        Dim strFilterValue As String
        Dim strAction As String

        Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
        CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 width='99.9%' class='clsTable'>")

        If m_lngReportID = EARNED_VALUE_SUMMARY_REPORT Or m_lngReportID = EARNED_VALUE_DETAILS_REPORT Then

            ' Initialise Resource File 
            MyBase.InitializeResources("AppResources.PM_EarnedValueReport", "AppResources")

            'Project Name 
            strSQL = " SELECT ProjectName FROM tbl_PM_Project WHERE ProjectID = " + m_intProjectID.ToString
            strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), "")

            objSection = New WebPages.Template.SectionTitle
            strTitle = MyBase.GetResourceString("PAGE_HEADER")
            strTitle = strTitle.Replace("[PROJECTNAME]", strProjectName)
            strTitle = strTitle.Replace("[FROMDATE]", CommonFunctions.Dates.CGetDate(CType(m_strFromDate, Date)))
            strTitle = strTitle.Replace("[TODATE]", CommonFunctions.Dates.CGetDate(CType(m_strToDate, Date)))

            ' Selected Parameter

            If m_strID <> "0" Then
                strFilterValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_sel_EarnedValueFilterValue " + m_strID + " , " + m_StrType, MyBase.UseSQL), "")

                If strFilterValue <> "" Then
                    strTitle = strTitle.Replace("[PARAMETER]", strFilterValue)
                Else
                    strTitle = strTitle.Replace("[PARAMETER]", " ")
                End If
            Else
                strTitle = strTitle.Replace("[PARAMETER]", " ")
            End If
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align=left>")
            Response.Write(objSection.GetSectionTitle(strTitle, "", ""))
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")


            'Check if user wants to view the report or not
            strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))

            If strAction = ACTION_VIEW_REPORT Then

                If m_lngReportID = EARNED_VALUE_SUMMARY_REPORT Then
                    strSQL = "EXEC usp_crw_EarnedvalueAnalysisSummaryReport "
                ElseIf m_lngReportID = EARNED_VALUE_DETAILS_REPORT Then
                    strSQL = "EXEC usp_crw_EarnedvalueAnalysisDetailsReport "
                End If

                If m_intProjectID <> 0 Then
                    strSQL += m_intProjectID.ToString
                Else
                    strSQL += " 0 "
                End If

                If m_strFromDate <> "" Then
                    'Start_JG_7960_13-Dec-2006
                    'strSQL += " , '" + m_strFromDate + "' "
                    strSQL += " , '" + m_strFromDate + "' "
                    'End_JG_7960_13-Dec-2006
                Else
                    'Start_JG_7960_13-Dec-2006
                    'strSQL += " , '" + Now.Today.ToString + "' "
                    strSQL += " ,'" + Now.Today.ToString + "' "
                    'End_JG_7960_13-Dec-2006
                End If

                If m_strToDate <> "" Then
                    'Start_JG_7960_13-Dec-2006
                    'strSQL += " , '" + m_strToDate + "'"
                    strSQL += " ,'" + m_strToDate + "'"
                    'End_JG_7960_13-Dec-2006
                Else
                    'Start_JG_7960_13-Dec-2006
                    'strSQL += " , '" + Now.Today.ToString + "' "
                    strSQL += " , '" + Now.Today.ToString + "' "
                    'End_JG_7960_13-Dec-2006
                End If

                If m_strID <> "0" Then
                    ' If no filter is selected even then show Project Wise Details 
                    strSQL += " , " + m_strID
                    If m_StrType <> "" Then
                        strSQL += " , " + m_StrType
                    Else
                        strSQL += " , Null "
                    End If
                Else
                    strSQL += "   , Null , 0 "
                End If


                ShowReport(m_intProjectID, strSQL, m_lngReportID)

            End If

            ElseIf m_lngReportID = EARNED_VALUE_DETAILS_REPORT Then

        End If

        CommonFunctions.General.WriteHTML("</TABLE>")

        CommonFunctions.General.WriteHTML("</DIV>")


    End Sub

    Private Sub ShowReport(ByVal ProjectID As Long, ByVal StrSql As String, ByVal lngReportID As Long)
        '=====================================================================
        ' Procedure Name        : ShowReport
        ' Purpose               : To generate the report 
        ' Description           : The report is generated and file is opened
        '                         from window_onload() event
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFucntions.dll,AdHocReports.dll
        ' Author                : NitinVS
        ' Created               : 31-Mar-2005
        ' Revisions             :
        '=====================================================================
        Dim strFormat As String
        Dim ObjDR As IDataReader
        Dim strFilePath As String
        Dim intFileType As Integer
        Dim objEmptyValueReader As IDataReader
        Dim strEmptyValue As String

        'get Empty value replacement string for this report
        Select Case UCase(Trim(strFormat))
            Case "PDF" : intFileType = 1
            Case "HTML" : intFileType = 2
            Case "EXCEL" : intFileType = 3
            Case "RTF" : intFileType = 4
            Case "CSV" : intFileType = 6
            Case "TEXT" : intFileType = 5
            Case "XML" : intFileType = 5
            Case Else : intFileType = 3
        End Select
        'get empty value replacement value for particular report type
        objEmptyValueReader = CommonFunctions.Data.GetDataReader("usp_sel_v_tbl_CRW_Report_EmptyValueReplacement " + m_lngReportID.ToString() + "," + intFileType.ToString, MyBase.UseSQL)
        If objEmptyValueReader.Read Then
            strEmptyValue = objEmptyValueReader("ReplacementString").ToString()
        End If
        CommonFunction.Data.DisposeDataReader(objEmptyValueReader)
        strFormat = Request.QueryString("format").ToString
        'Query for getting report o/p

        ObjDR = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If ObjDR.Read Then

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
            oRpt = New AdHocReports.Report.AdHocReport(lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                .LCID = MyBase.CurrentThreadUICultureID
                If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                    .UseHashTables = True
                Else
                    .UseHashTables = False
                End If
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
            'Added by PrashantD on 21 Aug 2007 for WhizFrameWork SP8
            m_strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(m_strFileName))
            Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + m_strFileName, True)
            'End of addition by PrashantD on 21 Aug 2007
        Else
            ' set the flag here to show the message that there is no data
            ' at the client side
            m_intShowMessage = 1
        End If
        CommonFunctions.Data.DisposeDataReader(ObjDR)

        
    End Sub
#End Region

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If Args.LinkName.ToUpper = "CONFIGURATION" Then
            If m_objAccessRights.Edit = False Then
                Cancel = True
            End If
        End If
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by MahendraV On 10:37 AM 5/24/2007 for List of Reports modified for HTML Report Issue
        'Start_MV_5/24/2007
        If UCase(Trim(Request.QueryString("Format") & "")) = "HTML" Then

            If Not CommonFunctions.General.GetApplicationKeySetting("WAF_OpenReportsInSecurePage") Is Nothing Then
                If CType(CommonFunctions.General.GetApplicationKeySetting("WAF_OpenReportsInSecurePage"), Boolean) Then

                    m_intOpenReportInSecurePage = 1

                End If

            End If

        End If
        'End_MV_5/24/2007
    End Sub
End Class
