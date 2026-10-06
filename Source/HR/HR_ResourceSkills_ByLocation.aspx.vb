#Region "Imports"
Imports System.Text.RegularExpressions
Imports WebPages.Template
Imports WebPages.Security
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports AdHocReports.Report
#End Region

Public Class HR_ResourceSkills_ByLocation
    Inherits WhizTemplate

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
    Protected m_lngTagId As Long
    Protected m_strShowMessage As String = ""
    Protected m_strFileName As String
    Private m_strReportHeader As String
    Private WithEvents m_objLocationGrid As New GenericGrid
    Private WithEvents m_objSkillGrid As New GenericGrid
    Private WithEvents m_objStaticMenu As New StaticMenu
    Const REPORTID As Integer = 903
    'Added by MahendraV On 10:37 AM 5/24/2007 for List of Reports modified for HTML Report Issue
    'Start_MV_5/24/2007
    Protected m_intOpenReportInSecurePage As Integer = 0
    'End_MV_5/24/2007

    ' Added by MahendraV On 9:27 AM 7/4/2007 for WhizibleSEM 7 
    ' The code changes required for the custom-report UI page 
    Protected m_strReportDisclaimer As String = ""
    ' End_MV_7/4/2007

#End Region

    Public Sub New()
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        Dim strQuery As String
        Dim strFilePath As String
        Dim strExtension As String
        Dim lngProjectID As Long
        Dim objReport As AdHocReports.Report.AdHocReport

        MyBase.InitializeResources("AppResources.HR_ResourceSkills", "AppResources")

        ''Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Of Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 

        If IsPostBack Then

            'We will get the check box selections in the form of comma-separated strings.
            Dim strLocChecks As String = Request.Form("chkSelectLoc")
            Dim strSkillChecks As String = Request.Form("chkSelectSkill")


            If strLocChecks = "" OrElse strSkillChecks = "" Then
                m_strShowMessage = "window.alert('" & MyBase.GetResourceString("RES_INCOMPLETE_INPUT") & "'); window.close();"
                Exit Sub
            ElseIf strLocChecks = "" AndAlso strSkillChecks = "" Then
                strQuery = "exec usp_CRW_ResourceAvailability_By_Location"
            Else
                strQuery = "exec usp_CRW_ResourceAvailability_By_Location '" & strLocChecks & "','" & strSkillChecks & "'"
            End If

            Dim datareader As IDataReader = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

            'Raise a message if the stored procedure fetched no results.
            If Not datareader.Read Then
                m_strShowMessage = "window.alert('" & MyBase.GetResourceString("RES_ERROR") & "'); window.close();"
            Else
                'We build the report name starting from here.
                m_strFileName = FileDirectory.GetUniqueFileName.Trim
                strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))

                Select Case Request.QueryString("ReportType").ToUpper
                    Case "PDF"
                        strExtension = ".pdf"
                    Case "HTML"
                        strExtension = ".html"
                    Case "EXCEL"
                        strExtension = ".xls"
                    Case "RTF"
                        strExtension = ".rtf"
                    Case "CSV"
                        strExtension = ".csv"
                    Case "TEXT"
                        strExtension = ".txt"
                    Case "XML"
                        strExtension = ".xml"
                End Select
                m_strFileName &= strExtension

                If Request.QueryString("ReportType").ToUpper = "HTML" Then
                    strFilePath = Server.MapPath("../../Reports/") + m_strFileName.Trim
                Else
                    strFilePath = Server.MapPath("../../Reports/") + m_strFileName.Trim
                End If

                strFilePath = strFilePath.Trim

                'Here we set the various properties of the Report object.
                objReport = New AdHocReports.Report.AdHocReport(REPORTID, strQuery, _
                        CommonFunctions.Application.ConnectionString, strFilePath, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
                With objReport
                    .CompanyName = CommonFunctions.Application.CompanyName
                    .UseMSSQL = MyBase.UseSQL
                    .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                    .LCID = MyBase.CurrentThreadUICultureID
                    .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                    If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                        .UseHashTables = True
                    Else
                        .UseHashTables = False
                    End If

                End With

                'Here we generate the actual report depending on the type selected by the user.
                Select Case Request.QueryString("ReportType").ToUpper
                    Case "PDF" : objReport.GenerateReport(AdHocReports.Format.PDF)
                    Case "HTML" : objReport.GenerateReport(AdHocReports.Format.HTML)
                    Case "RTF" : objReport.GenerateReport(AdHocReports.Format.RTF)
                    Case "EXCEL" : objReport.GenerateReport(AdHocReports.Format.EXCEL)
                    Case "CSV" : objReport.GenerateReport(AdHocReports.Format.CSV)
                    Case "TEXT" : objReport.GenerateReport(AdHocReports.Format.TEXT)
                    Case "XML" : objReport.GenerateReport(AdHocReports.Format.XML)
                    Case Else : objReport.GenerateReport(AdHocReports.Format.PDF)
                End Select
                objReport = Nothing
                'Modify By MahendraV On 1:13 PM 5/24/2007 for List of Reports modified for HTML Report Issue
                ' Moved this code into the ASPX page 'function window_onload()'
                'Start_MV_5/24/2007
                'General.WriteHTML("<Script language=javascript>")
                'General.WriteHTML("window.open(""../CRW/CRW_ReportOutput.aspx?filename=" + m_strFileName.Trim + ""","""",""menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,width=500,height=500"")")
                'General.WriteHTML("</Script>")
                'End_MV_5/24/2007
                'Added by PrashantD on 21 Aug 2007 for WhizFrameWork SP8
                m_strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(m_strFileName))
                Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + m_strFileName, True)
                'End of addition by PrashantD on 21 Aug 2007
            End If
            CommonFunction.Data.DisposeDataReader(datareader)
        End If

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

#Region "Functions and Sub-Routines"

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
        ' Author                :   PrakashR
        ' Created               :   March 22, 2004
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()
        Call DrawMenu()

        MyBase.InitializeResources("AppResources.HR_ResourceSkills", "AppResources")

        WriteHTML("<BR>")
        WriteHTML(PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        WriteHTML("<BR>")

        WriteHTML("<DIV id='PageDiv' style='width:100%;overflow:auto;'>")

        Dim objLocSection As New SectionTitle
        Dim strSectionTitle As String = MyBase.GetResourceString("RES_SELECT_LOCATIONS")
        WriteHTML(objLocSection.GetSectionTitle(strSectionTitle, "divLocation", "ShowHide_Location"))
        WriteHTML(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
        WriteHTML(objLocSection.ClientsideScript())
        WriteHTML(vbCrLf + "</SCRIPT>" + vbCrLf)

        Dim arrUserFriendlyNames() As String = {MyBase.GetResourceString("RES_LOCATION"), MyBase.GetResourceString("RES_SELECT")}
        Dim arrActualNames() As String = {"Location", ""}
        Dim arrCheckBox() As String = {"", "chkSelectLoc"}
        Dim arrAlignment() As String = {"align='left' width='70%'", "align='Center'  width='30%'"}
        Dim strGridHTML As String

        'Here we set the various properties of the Generic Grid.
        With m_objLocationGrid
            .ActualColumnArray = arrActualNames
            .CheckBoxIDArray = arrCheckBox
            .UserFriendlyColumnArray = arrUserFriendlyNames
            .TDStyleArray = arrAlignment
            .NoOfDataColumns = 1
            .DIVHeight = 0
            .ColNameToolTipOnEachRow = True
            .SQL = "Exec usp_Sel_PM_LocationList"
            'For associating a primary key with the check boxes for deletion
            .PrimaryKey = "LocationID"
            .returnHTML = True
            .UseSQL = True
            strGridHTML = .DrawGrid
        End With
        m_objLocationGrid = Nothing

        WriteHTML("<DIV Id='divLocation' style='overflow:auto;'>")
        WriteHTML(strGridHTML)
        WriteHTML("</DIV>")

        WriteHTML("<BR>")

        Dim objSkillSection As New SectionTitle
        strSectionTitle = MyBase.GetResourceString("RES_SELECT_SKILLS")
        WriteHTML(objSkillSection.GetSectionTitle(strSectionTitle, "divSkills", "ShowHide_Skills"))
        WriteHTML(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
        WriteHTML(objSkillSection.ClientsideScript())
        WriteHTML(vbCrLf + "</SCRIPT>" + vbCrLf)

        Dim arrUserFriendlySkillNames() As String = {MyBase.GetResourceString("RES_SKILL"), MyBase.GetResourceString("RES_SELECT")}
        Dim arrActualSkillNames() As String = {"Description", ""}
        Dim arrSkillCheckBox() As String = {"", "chkSelectSkill"}

        m_objSkillGrid = New GenericGrid

        With m_objSkillGrid
            .ActualColumnArray = arrActualSkillNames
            .CheckBoxIDArray = arrSkillCheckBox
            .UserFriendlyColumnArray = arrUserFriendlySkillNames
            .TDStyleArray = arrAlignment
            .DIVHeight = 0
            .DIVStyle = ""

            .NoOfDataColumns = 1
            .ColNameToolTipOnEachRow = True
            .SQL = "Exec usp_Sel_tbl_PM_GetSkillsOfEmployee 0"
            'For associating a primary key with the check boxes for deletion
            .PrimaryKey = "ToolID"
            .returnHTML = True
            .UseSQL = True
            strGridHTML = .DrawGrid
        End With
        m_objSkillGrid = Nothing
        WriteHTML("<DIV Id='divSkills' style='overflow:auto;'>")
        WriteHTML(strGridHTML)
        WriteHTML("</DIV>")
        WriteHTML("</DIV>")

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

        WriteHTML("<BR>")
        Call DrawMenu()
    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : True or false
        ' Parameters Affected   : None
        ' Purpose               :
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : PrakashR
        ' Created               : March 22, 2004
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
        ' Procedure Name        :  DrawMenu
        ' Parameters Passed     :  None 
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  Initialization of the menu
        ' Description           :  This function renders the menu for report generation in various formats
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  March 22, 2004
        ' Revisions             : 
        '=====================================================================
        Dim strMenu As String
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        ' integrated by harshada d on 16092005 for EXCEL2 issue id 266
        ' added by Harshada D on 05-08-2005 for show /hide EXCEL option according to web.config setting .
        Dim strExcel As String
        strExcel = CommonFunctions.General.GetApplicationKeySetting("WAF_CRW_FormatsToBeDisabled")
        'here if this key WAF_CRW_FormatsToBeDisabled contain value "EXCEL" then excel option is drawn . 
        '- removed option excel from  arrMenu,arrMenuToolTip ,arrClientSideFunction 
        If strExcel = "EXCEL" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), MyBase.GetResourceString("MENU_HTML"), _
                                       MyBase.GetResourceString("MENU_RTF"), _
                                       MyBase.GetResourceString("MENU_CSV"), MyBase.GetResourceString("MENU_TEXT"), _
                                       MyBase.GetResourceString("MENU_XML"), MyBase.GetResourceString("MENU_HELP")}

            Dim arrMenuTooltip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HTML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_CSV_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_TEXT_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_XML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

            Dim arrClientSideFunctions() As String = {"PDF_OnClick()", _
                                                      "HTML_OnClick()", _
                                                      "RTF_OnClick()", _
                                                      "CSV_OnClick()", _
                                                      "Text_OnClick()", _
                                                      "XML_OnClick()", _
                                                      "Help_OnClick('" & m_lngTagId & "')"}

            m_objStaticMenu = New StaticMenu
            strMenu = m_objStaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuTooltip, True)
        Else
            ' end of modification by harshada D . on 05 -08-2005
            'end of integration by harshada d on 16092005 for issue id 266
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), MyBase.GetResourceString("MENU_HTML"), _
                                       MyBase.GetResourceString("MENU_RTF"), MyBase.GetResourceString("MENU_EXCEL"), _
                                       MyBase.GetResourceString("MENU_CSV"), MyBase.GetResourceString("MENU_TEXT"), _
                                       MyBase.GetResourceString("MENU_XML"), MyBase.GetResourceString("MENU_HELP")}

            Dim arrMenuTooltip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HTML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_EXCEL_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_CSV_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_TEXT_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_XML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

            Dim arrClientSideFunctions() As String = {"PDF_OnClick()", _
                                                      "HTML_OnClick()", _
                                                      "RTF_OnClick()", _
                                                      "Excel_OnClick()", _
                                                      "CSV_OnClick()", _
                                                      "Text_OnClick()", _
                                                      "XML_OnClick()", _
                                                      "Help_OnClick('" & m_lngTagId & "')"}

            m_objStaticMenu = New StaticMenu
            strMenu = m_objStaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuTooltip, True)
            'integrated by harshada d on 16092005 for issue id 266
            '  modified by harshada D . on 05 -08-2005
        End If
        ' end of modification by harshada D . on 05 -08-2005
        'end of integration by harshada d on 16092005 for issue id 266
        WriteHTML(strMenu)
    End Sub
#End Region


    '------------------Added by PrakashR on April 23, 2004--------------------
    Private Sub m_objLocationGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objLocationGrid.DataRowTD_BeforePrint
        'We are handling this event to persist the state of the checkboxes in the Location Grid after a postback.
        If Page.IsPostBack AndAlso Args.ColIndex = 1 AndAlso Request.Form("chkSelectLoc") <> "" Then
            Dim regex As New Regex(",")
            Dim parts() As String = regex.Split(Request.Form("chkSelectLoc"))
            Dim part As String
            For Each part In parts
                If Args.DataReader(0).ToString = part Then
                    Args.IsCheckBoxChecked = True
                    Exit For
                End If
            Next
        End If
    End Sub

    Private Sub m_objSkillGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSkillGrid.DataRowTD_BeforePrint
        'We are handling this event to persist the state of the checkboxes in the Skills Grid after a postback.
        If Page.IsPostBack AndAlso Args.ColIndex = 1 AndAlso Request.Form("chkSelectSkill") <> "" Then
            Dim regex As New Regex(",")
            Dim parts() As String = regex.Split(Request.Form("chkSelectSkill"))
            Dim part As String
            For Each part In parts
                If Args.DataReader(0).ToString = part Then
                    Args.IsCheckBoxChecked = True
                    Exit For
                End If
            Next
        End If
    End Sub
    '-------------End of Addition made by PrakashR on April 23, 2004----------

End Class
