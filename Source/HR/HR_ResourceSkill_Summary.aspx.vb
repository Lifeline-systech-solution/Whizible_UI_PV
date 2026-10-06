#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class HR_ResourceSkill_Summary
    Inherits WebPages.Template.WhizTemplate

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
    Private WithEvents m_objMenu As New StaticMenu
    Private WithEvents m_objGrid As New GenericGrid
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_MasterTagID As Long
    Protected m_strShowMessage As String = ""
    'Added by MahendraV On 10:37 AM 5/24/2007 for List of Reports modified for HTML Report Issue
    'Start_MV_5/24/2007
    Protected strFileName As String
    Protected m_intOpenReportInSecurePage As Integer = 0
    'End_MV_5/24/2007

    ' Added by MahendraV On 9:27 AM 7/4/2007 for WhizibleSEM 7 
    ' The code changes required for the custom-report UI page 
    Protected m_strReportDisclaimer As String = ""
    ' End_MV_7/4/2007

#End Region

#Region "Functions & Procedures"

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : March 22, 2004
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_MasterTagID = m_objGlobal.TagID
    End Sub

    '====================================================================
    ' Procedure Name      : PageInit
    ' Parameters Passed   : None
    ' Returns             : None
    ' Parameters Affected : None
    ' Purpose             : To generate the UI for the report form & call from aspx page.
    ' Description         :         
    ' Assumptions         :
    ' Dependencies        :
    ' Author              : NileshD
    ' Created             : March 22, 2004
    ' Revisions           :
    '=====================================================================

    Public Sub PageInit()

        GetGlobalObject()

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        ' added by Harshada D on 05-08-2005 for show /hide EXCEL option according to web.config setting .
        Dim strExcel As String
        strExcel = CommonFunctions.General.GetApplicationKeySetting("WAF_CRW_FormatsToBeDisabled")
        'here if this key WAF_CRW_FormatsToBeDisabled contain value "EXCEL" then excel option is drawn . 
        '- removed option excel from  arrMenu,arrMenuToolTip ,arrClientSideFunction 
        Dim strMenu As String
        Dim strGrid As String
        If strExcel = "EXCEL" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), _
                                        MyBase.GetResourceString("MENU_HTML"), _
                                        MyBase.GetResourceString("MENU_RTF"), _
                                        MyBase.GetResourceString("MENU_CSV"), _
                                        MyBase.GetResourceString("MENU_Text"), _
                                        MyBase.GetResourceString("MENU_XML"), _
                                        MyBase.GetResourceString("MENU_Help")}

            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_HTML_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_CSV_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_Text_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_XML_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_Help_TOOLTIP")}

            Dim arrClientSideFunction() As String = {"PDF_Onclick()", "HTML_Onclick()", _
                                                     "RTF_Onclick()", _
                                                     "CSV_Onclick()", "Text_Onclick()", _
                                                     "XML_Onclick()", "Help_OnClick('" & m_objGlobal.TagID & "')"}
            'cerate the static menu.
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)
        Else
            ' end of addition by harshada d on 05-08-2005
            ' end of itegration by harshada d on 16092005 for issue id 266
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), _
                                        MyBase.GetResourceString("MENU_HTML"), _
                                        MyBase.GetResourceString("MENU_RTF"), _
                                        MyBase.GetResourceString("MENU_EXCEL"), _
                                        MyBase.GetResourceString("MENU_CSV"), _
                                        MyBase.GetResourceString("MENU_Text"), _
                                        MyBase.GetResourceString("MENU_XML"), _
                                        MyBase.GetResourceString("MENU_Help")}

            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_HTML_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_EXCEL_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_CSV_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_Text_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_XML_TOOLTIP"), _
                                                MyBase.GetResourceString("MENU_Help_TOOLTIP")}

            Dim arrClientSideFunction() As String = {"PDF_Onclick()", "HTML_Onclick()", _
                                                     "RTF_Onclick()", "Excel_Onclick()", _
                                                     "CSV_Onclick()", "Text_Onclick()", _
                                                     "XML_Onclick()", "Help_OnClick('" & m_objGlobal.TagID & "')"}

            'code commented by harshada d on 05082005 for Excel2

            'Dim strMenu As String
            'Dim strGrid As String

            ' end of commentation by harshada d 

            'cerate the static menu.
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)
            ' integrated by harshada d for  issue id 266
            ' added by harshada d on 16092005 for EXCEL2
        End If
        ' end of addition by harshada d on 05-08-2005 for EXCEL2
        ' end of integration by harshada d on 16092005 for  issue id 266

        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        Response.Write(PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        Response.Write("<BR>")

        'create the Header
        MyBase.InitializeResources("AppResources.HR_ResourceSkills", "AppResources")

        Dim objHeader As HeaderFooter
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeader.DrawHeaderFooter(m_objGlobal)
        objHeader = Nothing

        Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")

        'Plot the Grid

        Dim arrUFN() As String = {GetResourceString("RES_SKILL"), GetResourceString("RES_SELECT")}
        Dim arrAN() As String = {"Description", ""}
        Dim arrCheckBox() As String = {"", "chkSelect"}
        Dim arrTDStyle() As String = {"align=Left", "align=center"}

        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        With m_objGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrUFN
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrTDStyle
            .BooleanFalseHTML = "False"
            .BooleanTrueHTML = "True"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = "Exec usp_Sel_tbl_PM_GetSkillsOfEmployee 0"
            .NoOfDataColumns = 1
            .DIVHeight = 0
            .UseSQL = True
            .PrimaryKey = "ToolID"
            .ColNameToolTipOnEachRow = True
            .DrawGrid()
        End With

        HttpContext.Current.Response.Write("</DIV>")
        Response.Write("<BR>")

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

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)

        m_objGlobal = Nothing
        m_objAccessRights = Nothing
    End Sub
#End Region

#Region "Events"

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        Dim strFilePath As String
        '        Dim strFileName As String
        Dim strFormat As String
        Dim strSQL As String
        Dim strHTML As String
        Dim drReport As IDataReader
        Dim objRpt As AdHocReports.Report.AdHocReport

        ''Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Of Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 

        If IsPostBack Then
            If Not Request.QueryString("ReportType") Is Nothing Then
                strFormat = Request.QueryString("ReportType").ToString.Trim.ToUpper

                'call the sp according to the how many checkbox checked.
                If Request.Form("chkSelect") <> "" Then
                    strSQL = "exec usp_CRW_ResourceAvailability_By_Skill    Null,'" & Request.Form("chkSelect") & "'"
                Else
                    strSQL = "exec usp_CRW_ResourceAvailability_By_Skill"
                End If

                drReport = GetDataReader(strSQL, True)
                If drReport.Read Then

                    ' The reports are created in the "Reports" folder
                    strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))
                    ' get a unique file name
                    strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim

                    ' add extn to file name based on format requested
                    Select Case strFormat
                        Case "PDF" : strFileName += ".pdf"
                        Case "HTML" : strFileName += ".htm"
                        Case "RTF" : strFileName += ".rtf"
                        Case "EXCEL" : strFileName += ".xls"
                        Case "CSV" : strFileName += ".csv"
                        Case "TEXT" : strFileName += ".txt"
                        Case "XML" : strFileName += ".xml"
                        Case Else : strFileName += ".pdf"
                    End Select

                    ' create object of Adhoc reports.
                    objRpt = New AdHocReports.Report.AdHocReport(902, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + strFileName, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
                    With objRpt
                        .UseMSSQL = True
                        .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                        .LCID = MyBase.CurrentThreadUICultureID
                        If GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                            .UseHashTables = True
                        Else
                            .UseHashTables = False
                        End If
                        .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                        .CompanyName = CommonFunctions.Application.CompanyName

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
                    'Modify By MahendraV On 1:13 PM 5/24/2007 for List of Reports modified for HTML Report Issue
                    ' Moved this code into the ASPX page 'function window_onload()'
                    'Start_MV_5/24/2007
                    'open window to show the output file of the report
                    'strHTML = "<Script language=""javascript"">"
                    'strHTML &= "window.open(""../CRW/CRW_ReportOutput.aspx?filename=" + strFileName.Trim + ""","""",""menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,width=500,height=500"")"
                    'strHTML &= "</Script>"
                    'WriteHTML(strHTML)
                    'End_MV_5/24/2007

                    objRpt = Nothing
                    'Added by PrashantD on 21 Aug 2007 for WhizFrameWork SP8
                    strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(strFileName))
                    Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + strFileName, True)
                    'End of addition by PrashantD on 21 Aug 2007
                Else
                    m_strShowMessage = "window.alert('" & MyBase.GetResourceString("RES_ERROR") & "'); window.close();"
                End If
                DisposeDataReader(drReport)
            End If
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

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
    Public Sub New()
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim lngSkillID As Long
        Dim strskillIDs As String
        If IsPostBack Then
            If Args.ColIndex = 1 Then
                'this code will persist the check box state.
                lngSkillID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ToolID"), "0"), Long)
                strskillIDs = MyBase.GetFormValue("chkSelect").ToString
                If InStr("," & strskillIDs & ",", "," & lngSkillID.ToString & ",") > 0 Then
                    Args.IsCheckBoxChecked = True
                End If
            End If
        End If
    End Sub
#End Region

    
End Class
