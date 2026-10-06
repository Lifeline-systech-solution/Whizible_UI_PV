'=====================================================================
' Module Name   :       HR_EnterpriseSkillInventory  

' Purpose       :       Report for EnterPrise Skills

' Description   :       Report for EnterPrise Skills

' Dependencies  :       None

' Author        :       DipaliS

' Created       :       March 22, 2004

' Revisions     :
'=====================================================================
Public Class HR_EnterpriseSkillInventory
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

    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_strFormat As String = ""
    Protected m_strExtention As String
    Protected m_strFileName As String
    Private m_strFilePath As String
    Private m_strToolIDs As String
    Private m_strLocationIDs As String
    Protected m_lngMasterTagID As Long
    Const REPORTID As Integer = 907
    'Added By DipaliS on 23 rd Aprl
    Private WithEvents m_objLocationGrid As New WebPages.Template.AdvancedGrid
    Private WithEvents m_objSkillGrid As New WebPages.Template.AdvancedGrid
    Private m_strSeperator As String = ","
    Private m_charSep() As Char = m_strSeperator.ToCharArray
    Private m_strArrToolIDs() As String
    Private m_strArrLocationIDs() As String
    'End of Addition
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
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity(false)
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Public Sub PageInit()

        'Get the Format for Report
        m_strFormat = Request.QueryString("Format")

        'Fill the Global Object
        GetGlobalObject()

        m_lngMasterTagID = m_objGlobal.TagID
        'integration by harshada d on 16092005 for issue id EXCEL2 266 
        ' added by Harshada D on 05-08-2005 for show /hide EXCEL option according to web.config setting .
        Dim strExcel As String
        Dim strMenu As String
        strExcel = CommonFunctions.General.GetApplicationKeySetting("WAF_CRW_FormatsToBeDisabled")
        'here if this key WAF_CRW_FormatsToBeDisabled contain value "EXCEL" then excel option is drawn . 
        '- removed option excel from  arrMenu,arrMenuToolTip ,arrClientSideFunction 
        'Display the static menu
        If strExcel = "EXCEL" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), _
                                      MyBase.GetResourceString("MENU_HTML"), _
                                      MyBase.GetResourceString("MENU_RTF"), _
                                      MyBase.GetResourceString("MENU_CSV"), _
                                      MyBase.GetResourceString("MENU_Text"), _
                                      MyBase.GetResourceString("MENU_XML"), _
                                      MyBase.GetResourceString("MENU_Help")}

            Dim arrClientSideFunctions() As String = {"PDF_OnClick()", "HTML_OnClick()", "RTF_OnClick()", _
                                            "CSV_OnClick()", "Text_OnClick()", "Xml_OnClick()", _
                                            "Help_OnClick('" & m_objGlobal.TagID & "' )"}

            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HTML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_CSV_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_Text_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_XML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_Help_TOOLTIP")}

            Dim objMenu As New WebPages.Template.StaticMenu
            strMenu = objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            objMenu = Nothing

        Else
            'end of integration by harshada d on 16092005 for issue id EXCEL2 266 
            'Display the static menu
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), _
                                      MyBase.GetResourceString("MENU_HTML"), _
                                      MyBase.GetResourceString("MENU_RTF"), _
                                      MyBase.GetResourceString("MENU_EXCEL"), _
                                      MyBase.GetResourceString("MENU_CSV"), _
                                      MyBase.GetResourceString("MENU_Text"), _
                                      MyBase.GetResourceString("MENU_XML"), _
                                      MyBase.GetResourceString("MENU_Help")}

            Dim arrClientSideFunctions() As String = {"PDF_OnClick()", "HTML_OnClick()", "RTF_OnClick()", _
                                            "EXCEL_OnClick()", "CSV_OnClick()", "Text_OnClick()", "Xml_OnClick()", _
                                            "Help_OnClick('" & m_objGlobal.TagID & "' )"}

            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HTML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_EXCEL_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_CSV_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_Text_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_XML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_Help_TOOLTIP")}

            Dim objMenu As New WebPages.Template.StaticMenu
            strMenu = objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            objMenu = Nothing
            ' integrated by harshada d on 16092005 for issue id EXCEL2 266 
        End If
        'end of integration by harshada d on 16092005 for issue id EXCEL2 266 

        Response.Write(strMenu)

        DrawPageCaption()

        Response.Write("<DIV ID='PageDiv' style='overflow:auto'>")

        'Get the selected Location and Tool
        m_strLocationIDs = Request.Form("chkLocation")
        m_strToolIDs = Request.Form("chkTool")


        If m_strLocationIDs <> "" Then
            m_strArrLocationIDs = m_strLocationIDs.Split(m_charSep)
        End If
        If m_strToolIDs <> "" Then
            m_strArrToolIDs = m_strToolIDs.Split(m_charSep)
        End If


        DrawLocations()

        DrawSkills()

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


        Response.Write("<BR>")

        'Draw Footer
        Dim objFooter As New WebPages.Template.HeaderFooter
        objFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_FOOTER
        objFooter.HeaderFooter = strMenu
        objFooter.DrawHeaderFooter()

        'Depending upon the file format set the extention
        If m_strFormat <> "" Then
            Select Case m_strFormat
                Case "1"
                    m_strExtention = ".pdf"
                Case "2"
                    m_strExtention = ".htm"
                Case "3"
                    m_strExtention = ".rtf"
                Case "4"
                    m_strExtention = ".xls"
                Case "5"
                    m_strExtention = ".csv"
                Case "6"
                    m_strExtention = ".txt"
                Case "7"
                    m_strExtention = ".xml"
            End Select


            ' call the function to generate the report
            GenerateTheReport(REPORTID)

        End If

    End Sub

    '=====================================================================
    ' Procedure Name        : GetGlobalObject()	
    ' Purpose               : Function To Fill Global Object
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 22, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub

    '=====================================================================
    ' Procedure Name        : DrawPageCaptions()	
    ' Purpose               : Function To Draw page captions
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 22, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub DrawPageCaption()
        Response.Write("<BR>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        Response.Write("<BR>")

        Dim objHeader As New WebPages.Template.HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        Dim strHeader As String = objHeader.DrawHeaderFooter(m_objGlobal, True) & ""
        Response.Write(strHeader)
        If strHeader.Trim <> "" Then Response.Write("<BR>")
        objHeader = Nothing

    End Sub
    '=====================================================================
    ' Procedure Name        : DrawLocations()	
    ' Purpose               : Function To Draw the grid for Locations
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 22, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub DrawLocations()
        ''Draw the Section Header
        Dim objSectionTitle As New WebPages.Template.SectionTitle
        Dim strGrid As String

        'Get From the resource file the Section Title
        MyBase.InitializeResources("AppResources.HR_ResourceSkills", "AppResources")

        Dim strSectionTitle As String = MyBase.GetResourceString("RES_SELECT_LOCATIONS")
        Dim strSectionTag As String = "divLocation"
        Dim strFunctionName As String = "ShowHide_divLocation"
        With objSectionTitle
            Response.Write(.GetSectionTitle(strSectionTitle, strSectionTag, strFunctionName))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        objSectionTitle = Nothing

        'Commented by DipaliS on 23 rd April 2004
        'Dim objGrid As New WebPages.Template.AdvancedGrid

        ' Modified By NitinVS on 1 Dec 2004 -- for Issue No 14108
        ' The Page Is Crashing after Changing the Resource File since the actual Column Name is 
        ' taken from resource file Which is causing the page to crash

        'Dim arrActualColumnArray() As String = {MyBase.GetResourceString("RES_LOCATION"), _
        '                                      MyBase.GetResourceString("RES_SELECT")}

        Dim arrActualColumnArray() As String = {"Location", ""}
        ' End Modification NitinVS 1 DEC 2004 for Issue No 14108

        Dim arrUserFriendlyArray() As String = {MyBase.GetResourceString("RES_LOCATION"), _
                                              MyBase.GetResourceString("RES_SELECT")}

        Dim arrCheckBoxIDArray() As String = {"", "chkLocation"}
        Dim arrCheck() As String = {"", "LocationID"}

        Dim arrTDStyle() As String = {"width=70%", "align=center width=30%"}


        m_objLocationGrid.ActualColumnArray = arrActualColumnArray
        m_objLocationGrid.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objLocationGrid.CheckBoxIDArray = arrCheckBoxIDArray
        m_objLocationGrid.DIVID = "divLocation"
        m_objLocationGrid.DIVStyle = "'overflow:auto;width:100%;height=0'"
        m_objLocationGrid.TDStyleArray = arrTDStyle

        m_objLocationGrid.UseSQL = MyBase.UseSQL
        m_objLocationGrid.SQL = "usp_Sel_PM_LocationList"
        m_objLocationGrid.PrimaryKey = "LocationID"
        m_objLocationGrid.NoOfDataColumns = 1
        m_objLocationGrid.returnHTML = True
        strGrid = m_objLocationGrid.DrawGrid()
        m_objLocationGrid = Nothing

        HttpContext.Current.Response.Write("<DIV Id=" + strSectionTag + ">")
        Response.Write(strGrid)
        HttpContext.Current.Response.Write("</DIV>")
    End Sub
    '=====================================================================
    ' Procedure Name        : DrawSkills()	
    ' Purpose               : Function To Draw the grid for Skills
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 22, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub DrawSkills()
        Response.Write("<BR>")

        ''Draw the Section Header
        Dim objSectionTitle As New WebPages.Template.SectionTitle

        Dim strSectionTitle As String = MyBase.GetResourceString("RES_SELECT_SKILLS")
        Dim strSectionTag As String = "divSkills"
        Dim strFunctionName As String = "ShowHide_divSkills"

        With objSectionTitle
            Response.Write(.GetSectionTitle(strSectionTitle, strSectionTag, strFunctionName))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        objSectionTitle = Nothing

        'Commented by DipaliS on 23 rd April 2004
        'Dim objGrid As New WebPages.Template.AdvancedGrid
        Dim arrActualColumnArray() As String = {"Description", _
                                              MyBase.GetResourceString("RES_SELECT")}

        Dim arrUserFriendlyArray() As String = {MyBase.GetResourceString("RES_SKILL"), _
                                              MyBase.GetResourceString("RES_SELECT")}

        Dim arrCheckBoxIDArray() As String = {"", "chkTool"}
        Dim arrCheckArray() As String = {"", "ToolID"}
        Dim arrTDStyle() As String = {"width=70%", "align=center width=30%"}
        Dim strGrid As String

        m_objSkillGrid.ActualColumnArray = arrActualColumnArray
        m_objSkillGrid.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objSkillGrid.CheckBoxIDArray = arrCheckBoxIDArray
        m_objSkillGrid.DIVID = "divSkills"
        m_objSkillGrid.DIVStyle = "'overflow:auto;width:100%;height=0'"
        m_objSkillGrid.TDStyleArray = arrTDStyle
        m_objSkillGrid.returnHTML = True
        m_objSkillGrid.UseSQL = MyBase.UseSQL
        m_objSkillGrid.SQL = "usp_Sel_tbl_PM_GetSkillsOfEmployee 0"
        m_objSkillGrid.PrimaryKey = "ToolID"
        m_objSkillGrid.NoOfDataColumns = 1
        strGrid = m_objSkillGrid.DrawGrid()
        m_objSkillGrid = Nothing

        HttpContext.Current.Response.Write("<DIV Id=" + strSectionTag + ">")
        Response.Write(strGrid)
        HttpContext.Current.Response.Write("</DIV>")
    End Sub
    '=====================================================================
    ' Procedure Name        : GenerateTheReport()	
    ' Purpose               : Function To generate the report
    ' Description           : same as above
    ' Parameters Passed     : ReportTagNumber
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 22, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GenerateTheReport(ByVal ReportTagNumber As Integer)

        'get unique fielename to create new output file with that name

        m_strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))

        ' get a unique file name

        m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim

        m_strFilePath = m_strFilePath.Trim + m_strFileName.Trim + m_strExtention.Trim
        'Added by MahendraV On 10:37 AM 5/24/2007 for List of Reports modified for HTML Report Issue
        'Start_MV_5/24/2007
       
        m_strFileName = m_strFileName.Trim + m_strExtention.Trim
        'End_MV_5/24/2007
        Dim strSQL As String

        'Depending upon the input parameteres set the sql

        If Len(Trim(m_strToolIDs)) = 0 And Len(Trim(m_strLocationIDs)) = 0 Then
            strSQL = "exec usp_rpt_Skill_Inventory"
        End If

        If Len(Trim(m_strToolIDs)) = 0 And Len(Trim(m_strLocationIDs)) > 0 Then
            strSQL = "exec usp_rpt_Skill_Inventory   null,'" & m_strLocationIDs & "'"
        End If

        If Len(Trim(m_strToolIDs)) > 0 And Len(Trim(m_strLocationIDs)) = 0 Then
            strSQL = "exec usp_rpt_Skill_Inventory    '" & m_strToolIDs & "'"
        End If

        If Len(Trim(m_strToolIDs)) > 0 And Len(Trim(m_strLocationIDs)) > 0 Then
            strSQL = "exec usp_rpt_Skill_Inventory    '" & m_strToolIDs & "','" & m_strLocationIDs & "'"
        End If

        'Changed the code for showing message if no data exists
        Dim datareader As IDataReader = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        Dim strMessage As String
        'If no data for report , show the message to user else generate the report

        If Not datareader.Read Then
            strMessage = "<script language=javascript>window.alert('" & MyBase.GetResourceString("RES_ERROR") & "'); window.close();</script>"
            Response.Write(strMessage)
        Else
            'Set necessary parameters for report
            Dim objReport As New AdHocReports.Report.AdHocReport(ReportTagNumber, strSQL, CommonFunctions.Application.ConnectionString, m_strFilePath, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
            With objReport
                .UseMSSQL = MyBase.UseSQL
                .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                .LCID = MyBase.CurrentThreadUICultureID
                If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                    .UseHashTables = True
                Else
                    .UseHashTables = False
                End If

                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName

            End With

            Select Case m_strFormat
                Case "1"
                    objReport.GenerateReport(AdHocReports.Format.PDF)
                Case "2"
                    objReport.GenerateReport(AdHocReports.Format.HTML)
                Case "3"
                    objReport.GenerateReport(AdHocReports.Format.RTF)
                Case "4"
                    objReport.GenerateReport(AdHocReports.Format.EXCEL)
                Case "5"
                    objReport.GenerateReport(AdHocReports.Format.CSV)
                Case "6"
                    objReport.GenerateReport(AdHocReports.Format.TEXT)
                Case "7"
                    objReport.GenerateReport(AdHocReports.Format.XML)
            End Select
            'Modify By MahendraV On 1:13 PM 5/24/2007 for List of Reports modified for HTML Report Issue
            ' Moved this code into the ASPX page 'function window_onload()'
            'Start_MV_5/24/2007
            'Show the Report
            'CommonFunctions.General.WriteHTML("<Script language=javascript>")

            'CommonFunctions.General.WriteHTML("window.open(""../CRW/CRW_ReportOutput.aspx?filename=" + m_strFileName.Trim + ""","""",""menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,width=500,height=500"")")

            'CommonFunctions.General.WriteHTML("</Script>")
            'End_MV_5/24/2007
            objReport = Nothing

            'Added by PrashantD on 21 Aug 2007 for WhizFrameWork SP8
            m_strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(m_strFileName))
            Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + m_strFileName, True)
            'End of addition by PrashantD on 21 Aug 2007

        End If

        CommonFunctions.Data.DisposeDataReader(datareader)

    End Sub
    'Code Added on 23 rd April 2004

#Region "Functions"
    '====================================================================
    ' Procedure Name        :   ExistsInArray
    ' Parameters Passed     :   IDArray,ID
    ' Returns               :   Boolean
    ' Parameters Affected   :   None
    ' Purpose               :   Checks whether given ID is in IDArray
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                : DipaliS
    ' Created               : April 23, 2004
    ' Revisions :
    '=====================================================================
    Private Function ExistsInArray(ByVal IDArray As String(), ByVal ID As String) As Boolean
        Dim intCount As Integer
        Dim blnResult As Boolean
        'If the ID exits in given IDArray, return true
        For intCount = 0 To IDArray.Length - 1
            If Trim(IDArray(intCount).ToLower) = Trim(ID.ToLower) Then
                blnResult = True
            End If
        Next
        Return blnResult
    End Function
#End Region

    Private Sub m_objLocationGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objLocationGrid.DataRowTD_BeforePrint
        'If the ID exists in the String for Location , then check the checkbox
        If Args.ColIndex = 1 Then
            If Not (m_strArrLocationIDs Is Nothing) Then
                If ExistsInArray(m_strArrLocationIDs, CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("LocationID")), String)) Then
                    Args.IsCheckBoxChecked = True
                End If
            End If
        End If
    End Sub

    Private Sub m_objSkillGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSkillGrid.DataRowTD_BeforePrint
        'If the ID exists in the String for Skills  , then check the checkbox
        If Args.ColIndex = 1 Then
            If Not (m_strArrToolIDs Is Nothing) Then
                If ExistsInArray(m_strArrToolIDs, CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("ToolID")), String)) Then
                    Args.IsCheckBoxChecked = True
                End If
            End If
        End If
    End Sub
    'end of Addition

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
