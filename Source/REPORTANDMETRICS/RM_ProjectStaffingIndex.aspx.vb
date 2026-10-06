'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  PbNITE
' Module Name           :  RM_ProjectStaffingIndex.aspx
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

Public Class RM_ProjectStaffingIndex
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
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Dim m_strOUID As String = "NULL"
    Dim m_strBUID As String = "NULL"
    Dim m_strProjectID As String = "NULL"
    Dim m_strChangedCombo As String = ""
    Dim m_strMode As String = ""
    Dim m_lngMasterTagId As String
    Protected m_lngReportID As String = "2116"
    Protected m_strFileName As String = ""
    Private WithEvents oRpt As AdHocReports.Report.AdHocReport
    Protected m_intShowMessage As Integer = 0

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
        ' Author                :   PrakashR
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()
        Call SetVariables()
        Response.Write(GenerateMenu())
        Call GeneratePageCaption()
        Call DisplayPageDetails()
        Response.Write(GenerateMenu())
        If Request.QueryString("Mode") = "GenerateReport" Then
            Call ShowReport()
        End If
    End Sub

    Private Sub SetVariables()
        '====================================================================
        ' Procedure Name        :   SetVariables
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To Initialize BGID, OUID, ProjectID for dropdown
        ' Description           :   To Initialize BGID, OUID, ProjectID for dropdown
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   KapilGK
        ' Created On            :   12-Nov-2007
        ' Revisions             :   
        '=====================================================================
        Dim strSQL As String
        Dim drBGInfo As IDataReader
        Dim blnIsValueSet As Boolean
        Dim strtempBGID As String
        Dim drProjectInfo As IDataReader
        Dim drOUInfo As IDataReader

        If Not Request.QueryString("From") Is Nothing Then
            Select Case Request.QueryString("From").ToString.ToUpper
                Case "CBOBU"
                    m_strChangedCombo = "cboBU"
                Case "CBOOU"
                    m_strChangedCombo = "cboOU"
                Case "CBOPROJECT"
                    m_strChangedCombo = "cboProject"
                Case Else
                    m_strChangedCombo = ""
            End Select
        End If

        If m_strChangedCombo.ToUpper = "CBOBU" Then
            If Not MyBase.GetFormValue("cboBU") Is Nothing Then
                If MyBase.GetFormValue("cboBU") <> "" Then
                    m_strBUID = MyBase.GetFormValue("cboBU")
                End If
            End If
            If m_strBUID.ToUpper <> "NULL" And m_strBUID <> "" Then
                drOUInfo = CommonFunction.Data.GetDataReader("Exec usp_Sel_GetOrganizationUnit_PSI " + m_strBUID, True)
                If drOUInfo.Read Then
                    m_strOUID = CommonFunctions.Data.CheckIsDBNull(drOUInfo("LocationID"), "").ToString
                    If drOUInfo.Read Then
                        m_strOUID = "NULL"
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drOUInfo)
                drProjectInfo = CommonFunction.Data.GetDataReader("Exec usp_Sel_GetProjectNameList " + m_strBUID + "," + m_strOUID + "," + HttpContext.Current.Session("intUserID").ToString, True)
                If drProjectInfo.Read Then
                    m_strProjectID = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("ProjectID"), "").ToString
                    If drProjectInfo.Read Then
                        m_strProjectID = "NULL"
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drProjectInfo)
            Else
                m_strOUID = "NULL"
                m_strProjectID = "NULL"
            End If
        End If

        If m_strChangedCombo.ToUpper = "CBOOU" Then
            If Not MyBase.GetFormValue("cboBU") Is Nothing Then
                If MyBase.GetFormValue("cboBU") <> "" Then
                    m_strBUID = MyBase.GetFormValue("cboBU")
                End If
            End If
            If Not MyBase.GetFormValue("cboOU") Is Nothing Then
                If MyBase.GetFormValue("cboOU") <> "" Then
                    m_strOUID = MyBase.GetFormValue("cboOU")
                End If
            End If
            If m_strOUID.ToUpper <> "NULL" And m_strOUID <> "" Then
                If m_strBUID.ToUpper = "NULL" Or m_strBUID.ToUpper = "" Then
                    drBGInfo = CommonFunction.Data.GetDataReader("Exec usp_Sel_GetBusinessGroups  " + m_strOUID, True)
                    If drBGInfo.Read Then
                        m_strBUID = CommonFunctions.Data.CheckIsDBNull(drBGInfo("BusinessGroupID"), "").ToString
                        If drBGInfo.Read Then
                            m_strBUID = "NULL"
                        End If
                    End If
                    CommonFunction.Data.DisposeDataReader(drBGInfo)
                End If
                drProjectInfo = CommonFunction.Data.GetDataReader("Exec usp_Sel_GetProjectNameList " + m_strBUID + "," + m_strOUID + "," + HttpContext.Current.Session("intUserID").ToString, True)
                If drProjectInfo.Read Then
                    m_strProjectID = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("ProjectID"), "").ToString
                    If drProjectInfo.Read Then
                        m_strProjectID = "NULL"
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drProjectInfo)
            End If
        End If

        If m_strChangedCombo.ToUpper = "CBOPROJECT" Then
            If Not MyBase.GetFormValue("cboBU") Is Nothing Then
                If MyBase.GetFormValue("cboBU") <> "" Then
                    m_strBUID = MyBase.GetFormValue("cboBU")
                End If
            End If
            If Not MyBase.GetFormValue("cboOU") Is Nothing Then
                If MyBase.GetFormValue("cboOU") <> "" Then
                    m_strOUID = MyBase.GetFormValue("cboOU")
                End If
            End If
            If Not MyBase.GetFormValue("cboProject") Is Nothing Then
                If MyBase.GetFormValue("cboProject") <> "" Then
                    m_strProjectID = MyBase.GetFormValue("cboProject")
                End If
            End If
            If m_strProjectID.ToUpper <> "NULL" And m_strProjectID <> "" Then
                drProjectInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + m_strProjectID, MyBase.UseSQL)
                If drProjectInfo.Read Then
                    m_strBUID = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("BusinessGroupID"), "").ToString
                    m_strOUID = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("LocationID"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drProjectInfo)
            End If
        End If
    End Sub

    Private Sub SetVariables_OLD()
        Dim strSQL As String
        Dim drProjectInfo As IDataReader
        Dim drOUInfo As IDataReader
        m_lngMasterTagId = ""
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                m_strMode = Request.QueryString("Mode")
            End If
        End If

        If Not Request.QueryString("ObjectID") Is Nothing AndAlso Request.QueryString("ObjectID") <> "" Then
            m_strChangedCombo = Request.QueryString("ObjectID")
        End If

        'Get Business Unit ID
        If Not MyBase.GetFormValue("cboBU") Is Nothing Then
            If MyBase.GetFormValue("cboBU") <> "" Then
                m_strBUID = MyBase.GetFormValue("cboBU")
            End If
        End If

        If Not (m_strChangedCombo = "cboBU" And m_strBUID = "NULL") Then

            'Get Organization Unit ID
            If Not MyBase.GetFormValue("cboOU") Is Nothing Then
                If MyBase.GetFormValue("cboOU") <> "" Then
                    m_strOUID = MyBase.GetFormValue("cboOU")

                    'Added by MedhaS on 30 April 2007  for Weserve
                    drOUInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_OrganisationUnit " + m_strOUID, MyBase.UseSQL)
                    If drOUInfo.Read Then
                        m_strBUID = CommonFunctions.Data.CheckIsDBNull(drOUInfo("BusinessGroupID"), "").ToString
                        '  m_strOUID = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("LocationID"), "").ToString
                    End If
                    CommonFunctions.Data.DisposeDataReader(drOUInfo)
                    'End Addition By MedhaS on 30 April 2007  for Weserve
                End If
            End If
        End If


        If (Not (m_strChangedCombo = "cboBU" And m_strBUID = "NULL")) And (Not (m_strChangedCombo = "cboOU" And m_strOUID = "NULL")) Then

            If Not MyBase.GetFormValue("cboProject") Is Nothing Then
                If MyBase.GetFormValue("cboProject") <> "" Then
                    m_strProjectID = MyBase.GetFormValue("cboProject")

                    'GET OU and BU of selected Project
                    '-- Get Project Name
                    drProjectInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + m_strProjectID, MyBase.UseSQL)
                    If drProjectInfo.Read Then
                        m_strBUID = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("BusinessGroupID"), "").ToString
                        m_strOUID = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("LocationID"), "").ToString
                    End If
                    CommonFunctions.Data.DisposeDataReader(drProjectInfo)
                End If
            End If
        End If




    End Sub
    Private Sub GeneratePageCaption()
        '=====================================================================
        ' Procedure Name        : GeneratePageCaption()	
        ' Purpose               : to generate page caption
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 04, 2004
        ' Revisions             :
        '=====================================================================
        Response.Write("<BR>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Project Staffing Index", , , True))
        Response.Write("<BR><BR>")
    End Sub
    Private Function GenerateMenu() As String
        '=====================================================================
        ' function Name         : GenerateTopMenu()	
        ' Purpose               : To generate top menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 06, 2004
        ' Revisions             :
        '=====================================================================


        'Dim arrMenuNames() As String = {"Save", "Close"}
        'Dim arrMenuFunction() As String = {"onClick_Save()", "onClick_Close()"}
        'Dim arrToolTop() As String = {"Save", "Close"}
        'Return WebPage.Templates.StaticMenu.DrawMenu(arrMenuNames, arrMenuFunction, arrToolTop, True) + "<BR>"

        'Response.Write("<br>")
        'm_lngMasterTagId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagID"), "0"), Long)
        m_lngMasterTagId = "2116"

        Dim objMenu As New WebPages.Template.StaticMenu
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), _
                                           MyBase.GetResourceString("MENU_HTML"), _
                                           MyBase.GetResourceString("MENU_RTF"), _
                                           MyBase.GetResourceString("MENU_EXCEL"), _
                                           MyBase.GetResourceString("MENU_CSV"), _
                                           MyBase.GetResourceString("MENU_Text"), _
                                           MyBase.GetResourceString("MENU_XML"), _
                                           MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_HTML_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_EXCEL_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_CSV_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_Text_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_XML_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrCSFunctions() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", _
                                          "ViewReport_OnClick('RTF')", "ViewReport_OnClick('EXCEL')", _
                                          "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", _
                                          "ViewReport_OnClick('XML')", "Help_OnClick(" & m_lngMasterTagId.ToString() & ")"}

        ' return the menu string
        Return WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunctions, arrMenuToolTip, True) + "<BR>"

        ' clean up


    End Function
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
        ' Author                :  PrakashR
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub
    Private Sub DisplayPageDetails()
        Dim strHTML As String
        Dim strCase As String
        Dim strPossibleCauses As String
        Dim strPossibleSolutions As String
        Dim objSection As WebPages.Template.SectionTitle
        Dim strTitle As String
        Dim strProjectName As String
        Dim drInfo As IDataReader
        Dim strBusinessGroup As String
        Dim strOrganizationUnit As String
        Dim strEmployeeName As String
        ' Modified by NitinVS on 9 Sep 2005 for WhizibleSEM SP4 IssueID 182 
        Dim strDeliveryUnit As String = ""
        Dim strDateRange As String = ""
        ' End Modification by NitinVS on 9 Sep 2005 for WhizibleSEM SP4 IssueID 182 
        '   If m_strMode.ToUpper = "GENERATE" Or m_strMode.ToUpper = "DISPLAYDETAILS" Or m_strMode.ToUpper = "DISPLAYSUMMARYDETAILS" Then   'Removed: Or m_strMode.ToUpper = "RELATEDDATA"
        'Main Div
        Dim strUserID As String = CType(m_objGlobal.UserID, String)


        Dim strSQL As String
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:420px'>")
        CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='100%'  class=clsTable><TR class=clsTREven " + ">")
        '  CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:600px'>")
        ' CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='100%'  class=clsTable><TR class=clsTRPageHeader " + ">")

        'Display Business Unit Combo
        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>Business Groups</TD>")
        CommonFunctions.General.WriteHTML("<TD align=left >")
        strSQL = "usp_Sel_GetBusinessGroups  " + m_strOUID + "," + m_strProjectID
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboBU", strSQL, 250, m_strBUID, "" + " Langugage=JavaScript OnChange=Filter_change('cboBU')", True, True, , True))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        'Display Organization Unit Combo
        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>Organization Unit</TD>")
        CommonFunctions.General.WriteHTML("<TD align=left >")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_Sel_GetOrganizationUnit_PSI  " + m_strBUID + "," + m_strProjectID, 250, m_strOUID, "" + " Langugage=JavaScript OnChange=Filter_change('cboOU')", True, True, , False))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        'Display Project combo
        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>Project</TD>")
        CommonFunctions.General.WriteHTML("<TD align=left >")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_GetProjectNameList " + m_strBUID + "," + m_strOUID + "," + strUserID, 250, m_strProjectID, "" + " Langugage=JavaScript OnChange=Filter_change('cboProject')", True, True, , False))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</Table></DIV>")
        'End Modification By NitinVS on 9 sep 2005 for WhizibleSEM SP4 IssueID 182 
        CommonFunctions.General.WriteHTML("<BR><BR>")

    End Sub
    Private Sub ShowReport()
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
        ' Author                : NiranjanK
        ' Created               : March 02,2005
        ' Revisions             :
        '=====================================================================
        Dim strFormat As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strFilePath As String
        Dim intFileType As Integer
        Dim objEmptyValueReader As IDataReader
        Dim strEmptyValue As String

        'get Empty value replacement string for this report
        strFormat = Request.QueryString("format").ToString
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
        'strFormat = Request.QueryString("format").ToString
        'strFormat = "HTML"
        'Query for getting report o/p
        strSQL = "EXEC usp_CRW_ProjectStaffingIndexToDate " + m_strBUID + "," + m_strOUID + "," + m_strProjectID
        objDR = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
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
                Case Else : m_strFileName += ".xls"
            End Select
            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(CType(m_lngReportID, Long), strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                .LCID = MyBase.CurrentThreadUICultureID
                If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                    .UseHashTables = True
                Else
                    .UseHashTables = False
                End If
                .EmptyValueReplacement = strEmptyValue
                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName
                .GraphImageGenerationAbsolutePath = Server.MapPath("../../Images/")
                ' generate the report in requested format
                Select Case UCase(Trim(strFormat))
                    Case "PDF" : .GenerateReport(AdHocReports.Format.PDF)
                    Case "HTML" : .GenerateReport(AdHocReports.Format.HTML)
                    Case "RTF" : .GenerateReport(AdHocReports.Format.RTF)
                    Case "EXCEL" : .GenerateReport(AdHocReports.Format.EXCEL)
                    Case "CSV" : .GenerateReport(AdHocReports.Format.CSV)
                    Case "TEXT" : .GenerateReport(AdHocReports.Format.TEXT)
                    Case "XML" : .GenerateReport(AdHocReports.Format.XML)
                    Case Else : .GenerateReport(AdHocReports.Format.EXCEL)
                End Select
            End With
            oRpt = Nothing
        Else
            m_intShowMessage = 1
        End If
        CommonFunctions.Data.DisposeDataReader(objDR)
    End Sub
#End Region

    Public Sub New()
        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
End Class
