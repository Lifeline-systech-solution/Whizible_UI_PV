Public Class CLCP_ExportData
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Class	Name	        :	CLCP_ExportData
    ' Purpose				:	The export the CLCP data into a report format (R.No. WAF2_PB_15)
    ' Description			:	The page will list export options and export the data
    '                           in the required format.
    ' Assumptions			:	The SQL to be used will be set in the session variable
    ' Dependencies			:	DynamicReports.dll, TagID in querystring
    ' Author				:	Rajanikant Khethawatt
    ' Created				:	Nov 03,2004 
    ' Revisions				:	
    ' Req. No.              :   WAF2_PB_15
    '=====================================================================
    Protected m_strFileName As String
    Protected m_bytShowMessage As Integer = 0
    Protected m_strQueryStringParameters As String = ""

    Private WithEvents Report As DynamicReports.Report
    Private m_objUIControlTagMaster As CommonEngines.HashTables.UIControlTagMaster()
    Private m_objSubUIControlTagMaster As CommonEngines.HashTables.UIControlTagMaster()
    Private m_lngParentTagID As Long = 0
    Private m_strTitle As String = ""

    Private Const NO_DATA_PRESENT As Byte = 1
    Private Const NO_SQL_PRESENT As Byte = 2
    Private Const NO_ID_PRESENT As Byte = 3
    Private Const NO_MATCH_FOUND As Byte = 4
    ''Added by Dhanashri S on 29 Oct 2015

    'WAF3_PB_42 April 10, 2007 UmeshJ START
    Private m_blnIsDropdownMenuEnabled As Boolean
    Protected m_intDivFillFactor As Short
    'WAF3_PB_42 April 10, 2007 UmeshJ END

    ''End of Addition by Dhanashri S on 29 Oct 2015 
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

    Private Sub OnPageLoad(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ' Req. No.              :   WAF2_PB_15
        Dim strSQL As String = ""
        Dim strExportIdentifier As String = ""
        Dim lngTagID As Long


        If Not Request.QueryString("ParentTagID") Is Nothing Then
            m_lngParentTagID = CType(Request.QueryString("ParentTagID"), Long)
        End If
        If m_lngParentTagID <> 0 Then
            ' parent tagid is 0 for master pages 
            lngTagID = CType(Request.QueryString("TagID"), Long)
        Else
            lngTagID = CType(Request.QueryString("TagID"), Long)
        End If

        ' check for session variables
        If Not Session("CLCP_ExportSQL") Is Nothing Then
            strSQL = CType(Session("CLCP_ExportSQL"), String)
        Else
            m_bytShowMessage = NO_SQL_PRESENT
        End If

        If Not Session("CLCP_ExportID") Is Nothing Then
            strExportIdentifier = CType(Session("CLCP_ExportID"), String)
        Else
            m_bytShowMessage = NO_ID_PRESENT
        End If

        ' check for validity of requested tag and session SQL
        If Not IsExportSQLValid(lngTagID, m_lngParentTagID, strExportIdentifier) Then
            m_bytShowMessage = NO_MATCH_FOUND
        End If

        m_strQueryStringParameters = "TagID=" & lngTagID.ToString & "&ParentTagID=" & m_lngParentTagID.ToString

        If m_lngParentTagID <> 0 Then
            m_strTitle = GetSubTagTitle(m_lngParentTagID, lngTagID)
        Else
            m_strTitle = GetTagTitle(lngTagID)
        End If

        If UCase(Trim(Request.QueryString("Mode") & "") & "") = "EXPORT" Then
            ' load the hash tables (will be used in report events to replace captions)
            LoadHashTables(m_lngParentTagID, lngTagID)
            ' generate the report
            GenerateReport(strSQL, m_strTitle)
        End If
        ''Added by Dhanashri S on 29 Oct 2015

        'WAF3_PB_42 April 06, 2007 UmeshJ START
        If CommonFunctions.General.GetFrameworkSettings("GEN_ACTION_NAVIGATION_DROPDOWNMENU", "Enabled") = False Then
            m_blnIsDropdownMenuEnabled = False
            m_intDivFillFactor = 40 'Used in window onload and on resize
        Else
            m_blnIsDropdownMenuEnabled = True
            m_intDivFillFactor = 10 'Used in window onload and on resize
        End If
        'WAF3_PB_42 April 06, 2007 UmeshJ END

        ''End of Addition by Dhanashri S on 29 Oct 2015

    End Sub

    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()
        ' Purpose               : To write the page 
        ' Description           : The procedure plots the page and is called from .aspx
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Nov 03,2004
        ' Revisions             :
        ' Req. No.              : WAF2_PB_15
        '=====================================================================
        Dim strMenu As String

        strMenu = WriteMenu()

        With Response
            ' the menu
            .Write(strMenu)
            .Write("<BR>")
            ' Page Title caption
            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, m_strTitle) + vbCrLf)
            .Write("<BR>")
            .Write("<DIV id=divList style='overflow:auto;width:100%;Height:200;'>")
            .Write("<TABLE Class=clsTable Width='99.9%' cellpadding=1 cellspacing=1>" & vbCrLf)
            .Write("<TR class=clsTROdd>")
            .Write("<TD></TD></TR>" & vbCrLf)
            .Write("</TABLE>")
            .Write("</DIV>")

            ''Added by Dhanashri S on 29 Oct 2015
            If m_blnIsDropdownMenuEnabled = False Then
                ''End of Addition by Dhanashri S on 29 Oct 2015
            .Write("<BR>")
                .Write(strMenu)
                ''Added by Dhanashri S on 29 Oct 2015
            End If
            ''End of Addition by Dhanashri S on 29 Oct 2015

        End With

    End Sub

    Private Function WriteMenu() As String
        '=====================================================================
        ' Procedure Name        : WriteMenu()
        ' Purpose               : To write the menu for the page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : string of menu links
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Nov 03,2004
        ' Revisions             :
        ' Req. No.              : WAF2_PB_15
        '=====================================================================

        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), MyBase.GetResourceString("MENU_HTML"), MyBase.GetResourceString("MENU_RTF"), _
                                           MyBase.GetResourceString("MENU_EXCEL"), MyBase.GetResourceString("MENU_CSV"), MyBase.GetResourceString("MENU_Text"), MyBase.GetResourceString("MENU_XML"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), MyBase.GetResourceString("MENU_HTML_TOOLTIP"), MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_EXCEL_TOOLTIP"), MyBase.GetResourceString("MENU_CSV_TOOLTIP"), MyBase.GetResourceString("MENU_Text_TOOLTIP"), MyBase.GetResourceString("MENU_XML_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        Dim arrCSFunctions() As String = {"export_onclick('PDF')", "export_onclick('HTML')", "export_onclick('RTF')", "export_onclick('EXCEL')", "export_onclick('CSV')", "export_onclick('TEXT')", "export_onclick('XML')", "Close_OnClick()", "Help_OnClick('CLCP_EXPORTDATA')"}

        ''Commented and Added by Dhanashri S on 29 Oct 2015
        'Return WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunctions, arrMenuToolTip)
        'WAF3_PB_42 April 16, 2006 UmeshJ START
        Dim strMenu As String
        If m_blnIsDropdownMenuEnabled = False Then
            strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunctions, arrMenuToolTip)
        Else
            Dim arrSeparator() As Boolean = {False, False, False, False, False, False, True, True, False}
            strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunctions, arrMenuToolTip, True, "", "", Nothing, WebPages.Template.StaticMenu.DynamicAction_NavigationSchema.DROPDOWN, 100, arrSeparator)
            arrSeparator = Nothing
        End If
        arrMenu = Nothing : arrMenuToolTip = Nothing : arrCSFunctions = Nothing
        WriteMenu = strMenu
        'WAF3_PB_42 April 16, 2006 UmeshJ END
        ''End of Comment and Addition by Dhanashri S on 29 Oct 2015

    End Function

    Private Sub GenerateReport(ByVal SQL As String, ByVal Title As String)
        '=====================================================================
        ' Procedure Name        : GenerateReport()
        ' Purpose               : To generate the report for the Tag/Sub Tag
        ' Description           : 
        ' Parameters Passed     : SQL, Title of the report
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : DynamicReports.dll
        ' Author                : Rajanikant Khethawatt
        ' Created               : Nov 03,2004
        ' Revisions             :
        ' Req. No.              : WAF2_PB_15
        '=====================================================================
        Dim strFormat As String = ""
        Dim strFilePath As String = ""
        Dim dr As IDataReader

        ''Commented and Added by Dhanashri S on 29 Oct 2015

        'strFormat = UCase(Trim(Request.QueryString("Format") & "") & "")
        ' ***********************************************************************************
        ' Modified Apr 13,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************
        strFormat = HttpUtility.HtmlEncode(UCase(Trim(Request.QueryString("Format") & "") & ""))

        ''End of Comment and Addition by Dhanashri S on 29 Oct 2015

        Report = New DynamicReports.Report


        dr = CommonFunctions.Data.GetDataReader(SQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), CommonFunctions.Application.ConnectionString)
        If dr.Read Then
            ' The reports are created in the "Reports" folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))
            ' get a unique file name
            m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim
            ' add extn to file name based on format requested
            Select Case strFormat
                Case "PDF" : m_strFileName += ".pdf"
                Case "HTML" : m_strFileName += ".htm"
                Case "RTF" : m_strFileName += ".rtf"
                Case "EXCEL" : m_strFileName += ".xls"
                Case "CSV" : m_strFileName += ".csv"
                Case "TEXT" : m_strFileName += ".txt"
                Case "XML" : m_strFileName += ".xml"
                Case Else : m_strFileName += ".pdf"
            End Select

            With Report
                .CompanyName = CommonFunctions.Application.CompanyName
                .ConnectionString = CommonFunctions.Application.ConnectionString
                .DateFormat = CInt(CommonFunctions.Application.DateFormatID)
                .EmptyValueReplacement = "<Not Specified>"
                .ErrorLogFilePathName = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/"))
                .FilePathName = Trim(strFilePath & "") & m_strFileName
                .FontName = "Arial"
                .LogoPathName = Server.MapPath("../../Images/") & "CustomerLogo.gif"

                ' Set the tag/sub-tag specific SQL and Title
                .SQLSource = SQL
                .Title = Title

                .UseMSSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

                Select Case strFormat
                    Case "PDF" : .GenerateReport(DynamicReports.Format.PDF)
                    Case "HTML" : .GenerateReport(DynamicReports.Format.HTML)
                    Case "RTF" : .GenerateReport(DynamicReports.Format.RTF)
                    Case "EXCEL" : .GenerateReport(DynamicReports.Format.EXCEL)
                    Case "CSV" : .GenerateReport(DynamicReports.Format.CSV)
                    Case "TEXT" : .GenerateReport(DynamicReports.Format.TEXT)
                    Case "XML" : .GenerateReport(DynamicReports.Format.XML)
                    Case Else : .GenerateReport(DynamicReports.Format.PDF)
                End Select
            End With

        Else
            ' no data present..show the msg to the user
            m_bytShowMessage = NO_DATA_PRESENT
        End If

        CommonFunctions.Data.DisposeDataReader(dr)
        Report = Nothing

    End Sub

    Private Function GetTagTitle(ByVal TagID As Long) As String
        '=====================================================================
        ' Procedure Name        : GetTagTitle()
        ' Purpose               : To get the title of the sub tag
        ' Description           : 
        ' Parameters Passed     : Tag ID
        ' Returns               : Tag description as string 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Nov 04,2004
        ' Revisions             :
        ' Req. No.              : WAF2_PB_15
        '=====================================================================
        Dim objUITagMaster As CommonEngines.HashTables.UITagMaster

        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = MyBase.CurrentThreadUICultureID Then
            objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(TagID)
        Else
            objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterCultureObject(Trim(TagID.ToString & "") & MyBase.CurrentThreadUICultureID.ToString)
            If objUITagMaster Is Nothing Then
                objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(TagID)
            End If
        End If
        GetTagTitle = ""
        If Not objUITagMaster Is Nothing Then
            GetTagTitle = objUITagMaster.TagDescription
        End If
        objUITagMaster = Nothing
    End Function

    Private Sub LoadHashTables(ByVal ParentTagID As Long, ByVal TagID As Long)
        '=====================================================================
        ' Procedure Name        : LoadHashTables()
        ' Purpose               : To load the hash table for passed tag/sub tag
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Nov 04,2004
        ' Revisions             :
        ' Req. No.              : WAF2_PB_15
        '=====================================================================
        If ParentTagID = 0 Then
            ' we will load the hash table for Tag which will be used in report event to replace headers 
            If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = MyBase.CurrentThreadUICultureID Then
                m_objUIControlTagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableControlTagMasterCLObject(TagID)
            Else
                m_objUIControlTagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableControlTagMasterCLObject(Trim(TagID.ToString & "") & MyBase.CurrentThreadUICultureID.ToString)
                If m_objUIControlTagMaster Is Nothing Then
                    m_objUIControlTagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableControlTagMasterCLObject(TagID)
                End If
            End If
        Else
            ' Sub Tag  
            If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = MyBase.CurrentThreadUICultureID Then
                m_objSubUIControlTagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubControlTagMasterCPObject(TagID)
            Else
                m_objSubUIControlTagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubControlTagMasterCPObject(Trim(TagID.ToString & "") & MyBase.CurrentThreadUICultureID.ToString)
                If m_objSubUIControlTagMaster Is Nothing Then
                    m_objSubUIControlTagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubControlTagMasterCPObject(TagID)
                End If
            End If
        End If
    End Sub

    Private Function GetSubTagTitle(ByVal TagID As Long, ByVal SubTagID As Long) As String
        '=====================================================================
        ' Procedure Name        : GetSubTagTitle()
        ' Purpose               : To get the title of the sub tag
        ' Description           : 
        ' Parameters Passed     : Sub Tag ID
        ' Returns               : Sub tag description
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Nov 04,2004
        ' Revisions             :
        ' Req. No.              :   WAF2_PB_15
        '=====================================================================
        Dim objSubTagMasterHashTable() As CommonEngines.HashTables.SubUITagMaster

        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = MyBase.CurrentThreadUICultureID Then
            objSubTagMasterHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(TagID)
        Else
            objSubTagMasterHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(TagID.ToString + MyBase.CurrentThreadUICultureID.ToString)
            If objSubTagMasterHashTable Is Nothing Then
                objSubTagMasterHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(TagID)
            End If
        End If
        GetSubTagTitle = ""
        If objSubTagMasterHashTable Is Nothing Then Return ""

        Dim intIndex As Integer = 0
        Dim intLastIndex As Integer = objSubTagMasterHashTable.Length - 1
        For intIndex = 0 To intLastIndex
            If SubTagID = objSubTagMasterHashTable(intIndex).SubTagID Then
                GetSubTagTitle = objSubTagMasterHashTable(intIndex).TagDescription
            End If
        Next
        objSubTagMasterHashTable = Nothing
    End Function

    Private Function IsExportSQLValid(ByVal TagID As Long, ByVal ParentTagID As Long, ByVal ExportIdentifier As String) As Boolean
        '=====================================================================
        ' Procedure Name        : IsExportSQLValid()
        ' Purpose               : To check if export sql is valid for passed export id
        ' Description           : same as above
        ' Parameters Passed     : TagID, ParentTagID, Export identifier string
        ' Returns               : "true" if valid
        ' Parameters Affected   : 
        ' Assumptions           : The ParentTagID and TagID are passed in format <ParentTagID>»<TagID>
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Nov 04,2004
        ' Revisions             :
        ' Req. No.              : WAF2_PB_15
        '=====================================================================
        Dim strParentTagID As String
        Dim strTagID As String
        Dim arr() As String = {}

        If Trim(ExportIdentifier & "") = "" Then Return False

        arr = Split(ExportIdentifier, "»")
        strParentTagID = arr(0)
        strTagID = arr(1)

        If CType(strParentTagID, Long) = ParentTagID And CType(strTagID, Long) = TagID Then
            Return True
        Else
            Return False
        End If

    End Function

    Public Sub New()
        'MyBase.ApplySecurity(False, 2)
        MyBase.ApplySecurity(True)
    End Sub

    Protected Overrides Sub Finalize()
        m_objUIControlTagMaster = Nothing
        m_objSubUIControlTagMaster = Nothing
        m_lngParentTagID = Nothing
        m_bytShowMessage = Nothing
        m_strFileName = Nothing
        m_strQueryStringParameters = Nothing
        m_strTitle = Nothing
        MyBase.Finalize()
    End Sub

#Region "Report Events"
    Private Sub OnReportControlBeforePlot(ByRef Cancel As Boolean, ByRef Args As DynamicReports.WAF_Control) Handles Report.Control_BeforePlot
        Dim objUIControlTagMaster As CommonEngines.HashTables.UIControlTagMaster
        Dim objSubControlTagMaster As CommonEngines.HashTables.UIControlTagMaster

        If UCase(Trim(Args.SectionName & "")) = "REPORTHEADER" Then
            ' Showing the session username as generated by
            If UCase(Trim(Args.ControlText & "")) = "GENERATED BY:" Then
                Args.ControlText = "Generated By: " & Session("strUserName").ToString
            End If
            ' hiding the legend "** No Access"
            If UCase(Trim(Args.ControlText & "")) = "(** NO ACCESS)" Then
                Args.ControlText = ""
            End If
        End If

        ' change the page captions here
        If UCase(Trim(Args.SectionName & "")) = "PAGEHEADER" Then
            If m_lngParentTagID = 0 Then
                ' replace the field name in page header with respective "caption" in cotrol tag master for the tag
                For Each objUIControlTagMaster In m_objUIControlTagMaster
                    If UCase(Trim(Args.ControlText & "")) = UCase(Trim(objUIControlTagMaster.ControlName & "")) Then
                        Args.ControlText = objUIControlTagMaster.ControlCaption
                        Exit For
                    End If
                Next
            Else
                ' sub tag captions replacement
                For Each objSubControlTagMaster In m_objSubUIControlTagMaster
                    If UCase(Trim(Args.ControlText & "")) = UCase(Trim(objSubControlTagMaster.ControlName & "")) Then
                        Args.ControlText = objSubControlTagMaster.ControlCaption
                        Exit For
                    End If
                Next
            End If
        End If
    End Sub
#End Region


End Class
