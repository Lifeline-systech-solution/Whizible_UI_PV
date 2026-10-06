Option Strict Off
'=====================================================================
' Module Name   :   Project Profit by Site Rates (Role / Resource)
' Purpose       :   To Display the Details of Site Rates (Role / Resource)
' Description   :   Same as above
' Dependencies  :   Resource file for the same
' Author        :   PrashantSJ
' Created       :   Nov 18, 2008
' Revisions     :
'=====================================================================
#Region " Imports "
Imports System.Text
#End Region
Public Class ProjectContractBy_Sites
    Inherits WebPage.Templates.WhizTemplate
#Region " Member variables "

    Protected m_SBHTML As StringBuilder
    Protected WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private cObjSectionTitle As WebPage.Templates.SectionTitle
    Protected WithEvents m_objGrid As WebPages.Template.AdvancedGrid
    Protected WithEvents m_objRateGrid As WebPages.Template.AdvancedGrid
    Protected WithEvents m_objRoleRateGrid As WebPages.Template.AdvancedGrid

    Protected strSQL As String = ""

    Protected m_strSQL As String = ""
    Protected drRate As IDataReader
    Protected m_strMode As String = ""
    Protected m_strRoleID As String = ""

    Protected m_strAction As String = ""

    Protected m_dsRoleRate As DataSet

    Protected blnIsRoleRateExits As Boolean
    Private m_strScript As New System.Text.StringBuilder
    Protected m_strComboboxHTML As String = ""


    Protected m_arrPrimaryKey() As String
    Protected m_strUserName As String = ""
    Protected m_lngProjectID As Long = 0
    Protected m_strRoleName As String = ""
    Protected m_strProjectStartDate As String = ""
    Protected m_strTabSection As String = ""
    Protected m_blnIsSingleSite As Boolean = False
    Protected strContractType As String = ""

    Protected blnIsExtrHrsBilling As Boolean = False
    Protected m_dblMinimumWorkingHrs As Double = 0.0

#End Region
    Protected Enum SectionIndex
        Master
        Settings
        SiteDetails
        RateDetails
    End Enum
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
        'Put user code to initialize the page here
        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.

    End Sub
    Protected Sub PageInit()
        '====================================================================
        ' Procedure Name    :      PageInit
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To init page details
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)

        GetGlobalObject()

        GetTagAccessRights()

        InitializeVariables()

        If m_strTabSection <> "" Then
            PerformAction()
        End If

        GetDatabaseValues()

        DrawHiddenFields()

        ''''Master 
        DrawMenu(SectionIndex.Master)
        GetPageLegend()

        DrawPageCaption()

        Response.Write("<div Id=divPage Style='OVERFLOW:auto; WIDTH:100%;'>")


        DrawMasterSection(SectionIndex.Master)

        Response.Write("<br>")
        DrawEngagementDetails()
        Response.Write("<br>")
        '''''Settings
        DrawMasterSection(SectionIndex.Settings)
        Response.Write("<br>")
        DrawMenu(SectionIndex.Settings)
        Response.Write("<br>")
        DrawSettings()

        '''Site Details
        Response.Write("<br>")
        DrawMasterSection(SectionIndex.SiteDetails)
        Response.Write("<br>")
        DrawMenu(SectionIndex.SiteDetails)
        Response.Write("<br>")
        DrawSiteDetails()
        ''Rate Details
        Response.Write("<br>")

        DrawResourceRateGrid()
        
        Response.Write("<br>")
        Response.Write("<br>")

        DrawRoleRateGrid()

        'Response.Write("<br>")

        Response.Write("</div>")

        DrawInfoNote()

        DisposeDataSetObjects()



    End Sub
    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name    :      DrawPageCaption
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw Page caption.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder

        
        m_SBHTML.Append(WebPages.Template.PageCaption.GetPageCaptions(, "Commercial Details", , , True))
        m_SBHTML.Append("<br>")
        Response.Write(m_SBHTML.ToString)

        m_SBHTML = Nothing

    End Sub
    Private Function DrawMiniSections(Optional ByVal FromSub As String = "") As StringBuilder
        Dim sbHTML_Section As New StringBuilder

        cObjSectionTitle = New WebPage.Templates.SectionTitle

        With cObjSectionTitle

            If strContractType = "2" Or strContractType = "5" Or strContractType = "6" Then
                sbHTML_Section.Append(.GetSectionTitle("Resource Rate Details", "divDRRSection", "HideShowDRRSection", , , , , , , , , , , ) & vbCrLf)
            ElseIf FromSub = "" Then
                sbHTML_Section.Append(.GetSectionTitle("Manage Resource Roles", "divDRRSection", "HideShowDRRSection", , , , , , , , , , , ) & vbCrLf)
            End If

            If FromSub <> "" Then
                sbHTML_Section.Append(.GetSectionTitle("Role Rate Details", "divRRSection", "HideShowRRSection", , , , , , , , , , , ) & vbCrLf)
            End If

            sbHTML_Section.Append("<SCRIPT Language=javascript>" & vbCrLf)
            sbHTML_Section.Append(.ClientsideScript & vbCrLf)
            sbHTML_Section.Append("</SCRIPT>" & vbCrLf)
        End With

        DrawMiniSections = sbHTML_Section

        cObjSectionTitle = Nothing
        sbHTML_Section = Nothing

    End Function
    Private Sub DrawResourceRateGrid()
        '====================================================================
        ' Procedure Name    :      DrawResourceOrRoleRateGrid
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw Resource or Role details
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Dec 29, 2008
        ' Revisions         :
        '=====================================================================
        Dim strCaption As String = "Rate Change"
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        m_SBHTML = New StringBuilder
        m_SBHTML.Append(DrawMiniSections().ToString)

        m_SBHTML.Append("<br>")
        m_objRateGrid = New WebPages.Template.AdvancedGrid

        strSQL = "usp_Sel_f_tbl_PM_EmployeeBillingInfo " & m_objGlobal.ProjectID.ToString & "," & IIf(m_blnIsSingleSite, "1", "0")

        If strContractType <> "2" And strContractType <> "5" And strContractType <> "6" Then
            strCaption = "Change Role To"
        End If

        Dim arrstrUserFriendlyList() As String = {"Site", "Resource ", "Role", "Effective From Date ", "Normal Rate", "Extra Rate", "Holiday Rate", strCaption}
        Dim arrstrActualList() As String = {"Name", "EmployeeName", "RoleDescription", "StartDate", "NormalRate", "ExtraRate", "HolidayRate", strCaption}
        Dim arrstrLinkNames() As String = {"", "", "", "", "", "", "", "RateChange_OnClick(FromWhich,EmployeeBillingInfoID,EmployeeID)"}
        Dim arrGrouponColumn() As String = {"1", "", "", "", "", "", "", ""}
        Dim arrTDStyle() As String = {"", "", "", "", "", "", "", "style='text-align:left;'"}

        m_SBHTML.Append("<div Id=divDRRSection Style='OVERFLOW:auto; WIDTH:100%;'>")

        With m_objRateGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .RowLinkArray = arrstrLinkNames
            .GroupOnColumn = arrGrouponColumn
            .SQL = strSQL
            .DIVID = "divDRRSection"
            .EmptyValueReplacement = ""
            .NoOfDataColumns = arrstrActualList.Length - 1
            .UseSQL = MyBase.UseSQL
            .DIVStyle = "overflow:auto;width:99.99%;"
            .DIVHeight = 0
            .ColNameToolTipOnEachRow = True
            '  .StaticHeaderStyle = STATIC_HEADER_STYLE.DEFAULT
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            m_SBHTML.Append(.DrawGrid())
        End With

        m_SBHTML.Append("</div>")

        Response.Write(m_SBHTML.ToString)
        m_objRateGrid = Nothing
        m_SBHTML = Nothing
    End Sub
    Private Sub DrawRoleRateGrid()
        '====================================================================
        ' Procedure Name    :      DrawRoleRateGrid
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw Role Rate details
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Dec 29, 2008
        ' Revisions         :
        '=====================================================================
        If strContractType = "2" Or strContractType = "5" Or strContractType = "6" Then
            Exit Sub
        End If

        Dim strCaption As String = "Rate Change"
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        m_SBHTML = New StringBuilder
        m_SBHTML.Append(DrawMiniSections("Role").ToString)

        m_SBHTML.Append("<br>")
        m_objRoleRateGrid = New WebPages.Template.AdvancedGrid

        strSQL = "usp_Sel_v_tbl_PM_SiteRoleRates " & m_objGlobal.ProjectID.ToString & "," & IIf(m_blnIsSingleSite, "1", "0")


        Dim arrstrUserFriendlyList() As String = {"Site", "Role", "Effective From Date ", "Normal Rate", "Extra Rate", "Holiday Rate", "Define Rates"}
        Dim arrstrActualList() As String = {"Name", "RoleDescription", "StartDate", "NormalRate", "ExtraRate", "HolidayRate", "Define Rates"}
        Dim arrstrLinkNames() As String = {"", "", "", "", "", "", "RateChange_OnClick(FromWhich,SiteRoleRateID,RoleID)"}
        Dim arrGrouponColumn() As String = {"1", "", "", "", "", "", ""}
        Dim arrTDStyle() As String = {"", "", "", "", "", "", "style='text-align:left;'"}

        m_SBHTML.Append("<div Id=divRRSection Style='OVERFLOW:auto; WIDTH:100%;'>")

        With m_objRoleRateGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .RowLinkArray = arrstrLinkNames
            .GroupOnColumn = arrGrouponColumn
            .SQL = strSQL
            .DIVID = "divRRSection"
            .EmptyValueReplacement = ""
            .NoOfDataColumns = arrstrActualList.Length - 1
            .UseSQL = MyBase.UseSQL
            .DIVStyle = "overflow:auto;width:99.99%;"
            .DIVHeight = 0
            .ColNameToolTipOnEachRow = True
            ' .StaticHeaderStyle = STATIC_HEADER_STYLE.DEFAULT
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            m_SBHTML.Append(.DrawGrid())
        End With

        m_SBHTML.Append("</div>")

        Response.Write(m_SBHTML.ToString)
        m_objRoleRateGrid = Nothing
        m_SBHTML = Nothing
    End Sub
    Private Sub GetPageLegend()
        Dim strLegend As String
        'Legend
        Dim objLegend As WebPages.Template.PageLegends
        objLegend = New WebPages.Template.PageLegends
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        strLegend = objLegend.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True)
        objLegend = Nothing
        Response.Write(strLegend)
    End Sub
    Private Sub DrawSiteDetails()
        '====================================================================
        ' Procedure Name    :      DrawSiteDetails
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw Site details
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Nov 28, 2008
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder

        Dim strProjectSiteID As String = ""
        Dim intRow As Integer = 0
        Dim strClass As String = ""

        strSQL = "usp_Sel_DefaultProjectSite " & m_objGlobal.ProjectID.ToString & "," & IIf(m_blnIsSingleSite, "1", "0")
        drRate = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        With m_SBHTML
            .Append("<DIV Id=divSite Style=""OVERFLOW:auto; WIDTH:100%;"">" + vbCrLf)
            .Append("<TABLE id='tblSite' CellSpacing=0 class='clsTable' width='99.9%'>" + vbCrLf)
            .Append("<TR class='clsTRBody'></TD></TR>" + vbCrLf)
            '.Append("<tr class='clsTRColumnHeader'>" + vbCrLf)
            '.Append("<td  align='center'><b>" + vbCrLf)
            '.Append("Site" + vbCrLf)
            '.Append("</b></td>")

            '.Append("<td  align='center'><b>" + vbCrLf)
            '.Append("Rate Method" + vbCrLf)
            '.Append("</b></td>" + vbCrLf)

            '.Append("<td  align='center'><b>" + vbCrLf)
            '.Append("Working Days In Week" + vbCrLf)
            '.Append("</b></td>" + vbCrLf)

            '.Append("<td  align='center'><b>" + vbCrLf)
            '.Append("Working Hours In Day" + vbCrLf)
            '.Append("</b></td>" + vbCrLf)

            '.Append("<td  align='center'><b>" + vbCrLf)
            '.Append("Extra Cap Hours In Day " + vbCrLf)
            '.Append("</b></td>" + vbCrLf)

            '.Append("<td  align='center'><b>" + vbCrLf)
            '.Append("Show History" + vbCrLf)
            '.Append("</b></td>" + vbCrLf)

            '.Append("<td  align='center'><b>" + vbCrLf)
            '.Append("Role Rates" + vbCrLf)
            '.Append("</b></td>" + vbCrLf)

            '.Append("<td  align='center'><b>" + vbCrLf)
            '.Append("Resource Rates" + vbCrLf)
            '.Append("</b></td>" + vbCrLf)

            '.Append("</tr>" + vbCrLf)

            While drRate.Read
                strProjectSiteID = Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRate("ProjectSiteID"), ""))
                Dim PKToken As String = CommonFunctions.Security.Token.GetToken(strProjectSiteID + m_objGlobal.UserID.ToString + "0" + CommonFunction.Constants.APP_TAG_PROJECTSITES.ToString)
                intRow += 1
                If intRow <> 1 Then
                    .Append("<TR class='clsTRBody'>" + vbCrLf)
                    .Append("<TD title='' valign=top colspan='6'>" + vbCrLf)
                    .Append("<hr/>")
                    .Append("</TD>")
                    .Append("</TR>")
                End If
                '''Name & Rate Method
                .Append("<TR class='clsTRBody'>" + vbCrLf)
                .Append("<TD title='' valign=top align=right>" + vbCrLf)
                .Append("Name" + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("<TD valign=top title='' colspan='1'  >&nbsp;" + vbCrLf)
                .Append("<a title='Name' href='javascript:SiteName_OnClick(" + strProjectSiteID + ",""" + PKToken + """)'>" + CommonFunction.Data.CheckIsDBNull(drRate("Name"), "").ToString + "</a>" + vbCrLf)
                .Append("</TD>")
                .Append("<TD title='' valign=top align=right>" + vbCrLf)
                .Append("Rate Method" + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("<TD valign=top title='' colspan='3'  >&nbsp;" + vbCrLf)
                .Append(CommonFunction.HTMLControls.DrawComboBox("RateMethod" + strProjectSiteID, "usp_Sel_RateMethods " + m_objGlobal.ProjectID.ToString, 150, CommonFunction.Data.CheckIsDBNull(drRate("RateMethod"), "").ToString, "onchange='javascript:ReteMethod_OnChange(this)'", , True, , True) + vbCrLf)
                .Append("&nbsp;&nbsp;<a title='History' href='javascript:History_OnClick(" + strProjectSiteID + "," + m_objGlobal.ProjectID.ToString + ")'><Img Border=0 src='../../Images/cssImages/Link images/ShowHistory.gif'></img></a></TD>")
                .Append("</TR>")

                '''WorkHrs & WeekDays
                .Append("<TR class='clsTRBody'>" + vbCrLf)
                .Append("<TD title='' valign=top align=right>" + vbCrLf)
                .Append("Working Hours Per Day" + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("<TD valign=top title='' colspan='1'  >&nbsp;" + vbCrLf)
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                .Append(CommonFunction.HTMLControls.DrawTextBox("WorkHrs" + strProjectSiteID, "WorkHrs" + strProjectSiteID, , 50, , CommonFunction.Data.CheckIsDBNull(drRate("WorkHrs"), "0.0").ToString, "right", , , , , , , True, True, EnableHTMLEncode:=True) + vbCrLf)
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                .Append("</TD>")
                .Append("<TD title='' valign=top align=right>" + vbCrLf)
                .Append("Working Days Per Week" + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("<TD valign=top title='' colspan='3'  >&nbsp;" + vbCrLf)
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                .Append(CommonFunction.HTMLControls.DrawTextBox("WeekDays" + strProjectSiteID, "WeekDays" + strProjectSiteID, , 50, , CommonFunction.Data.CheckIsDBNull(drRate("WeekDays"), "0.0").ToString, "right", , , , , , , True, True, EnableHTMLEncode:=True) + vbCrLf)
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                .Append("</TD>")
                .Append("</TR>")
                '''ExtraHr & IsOffShore
                .Append("<TR class='clsTRBody'>" + vbCrLf)
                If strContractType <> "5" Or (blnIsExtrHrsBilling And strContractType = "5") Then
                    .Append("<TD title='' valign=top align=right>" + vbCrLf)
                    .Append("Extra Hour(s) Cap Per Day" + vbCrLf)
                    .Append("</TD>" + vbCrLf)
                    .Append("<TD valign=top title='' colspan='1'  >&nbsp;" + vbCrLf)
                    'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    .Append(CommonFunction.HTMLControls.DrawTextBox("ExtraHoursCap" + strProjectSiteID, "ExtraHoursCap" + strProjectSiteID, , 50, , CType(CommonFunction.Data.CheckIsDBNull(drRate("ExtraHoursCap"), ""), String), "right", , , , , , , True, EnableHTMLEncode:=True) + vbCrLf)
                    'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    .Append("</TD>")

                    .Append("<TD>&nbsp;")
                    .Append("</td>")
                End If
                .Append("<TD colspan='3'>&nbsp;")
                If Not m_blnIsSingleSite And (strContractType = "2" Or strContractType = "5" Or strContractType = "7") Then
                    .Append("<a title='Name' href='javascript:SiteRate_OnClick(" + strProjectSiteID + ")'>Define Site Role Rate </a>" + vbCrLf)
                End If
                .Append("</td>")
                .Append("</tr>")

                .Append(CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , True, strProjectSiteID, , , True, , , , True) + vbCrLf)
            End While

            .Append("</TABLE>" + vbCrLf)
            .Append("</DIV>")
        End With
        CommonFunction.Data.DisposeDataReader(drRate)


        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Private Sub DrawSettings()
        '====================================================================
        ' Procedure Name    :      DrawSettings
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw engagement settings
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Nov 28, 2008
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder

        strSQL = "usp_Sel_tbl_PM_WorkOrderRateContract " & m_objGlobal.ProjectID.ToString
        drRate = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        m_SBHTML.Append("<DIV Id=divSetting Style=""OVERFLOW:auto; WIDTH:100%;"">" + vbCrLf)
        m_SBHTML.Append("<TABLE id='tblSetting' CellSpacing=0 class='clsTable' width='99.9%'>" + vbCrLf)
        m_SBHTML.Append("<TR class='clsTRBody'></TD></TR>" + vbCrLf)
        If drRate.Read Then
            strContractType = Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRate("ContractType"), ""))
            m_blnIsSingleSite = CType(CommonFunction.Data.CheckIsDBNull(drRate("IsSingleSiteBilling"), "0"), Boolean)

            blnIsExtrHrsBilling = CBool(CommonFunction.Data.CheckIsDBNull(drRate("IsExtraHrsBilling"), "0"))

            m_SBHTML.Append("<TR class='clsTRBody'>" + vbCrLf)
            m_SBHTML.Append("<TD title='' valign=top align=right width='50%'>" + vbCrLf)
            m_SBHTML.Append("Project Execution From" + vbCrLf)
            m_SBHTML.Append("</TD>" + vbCrLf)
            m_SBHTML.Append("<TD valign=top title=''>&nbsp;" + vbCrLf)
            'm_SBHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("IsSingleSiteBilling", "IsSingleSiteBilling", , CBool(CommonFunction.Data.CheckIsDBNull(drRate("IsSingleSiteBilling"), "0")), "1", , , True) + vbCrLf)
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("IsSingleSiteBilling", "IsSingleSiteBilling", , IIf(CBool(CommonFunction.Data.CheckIsDBNull(drRate("IsSingleSiteBilling"), "0")), True, False), "1", , , True) + vbCrLf)
            m_SBHTML.Append("&nbsp;Single Site&nbsp;")
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("IsSingleSiteBilling", "IsSingleSiteBilling", , IIf(CBool(CommonFunction.Data.CheckIsDBNull(drRate("IsSingleSiteBilling"), "0")), False, True), "0", , , True) + vbCrLf)
            m_SBHTML.Append("&nbsp;Multiple Sites</TD>")
            m_SBHTML.Append("</TR>")

            If strContractType = "7" Or strContractType = "6" Then
                m_SBHTML.Append("<TR class='clsTRBody'>" + vbCrLf)
                m_SBHTML.Append("<TD title='' valign=top align=right width='50%'>" + vbCrLf)
                m_SBHTML.Append("CAP Amount" + vbCrLf)
                m_SBHTML.Append("</TD>" + vbCrLf)
                m_SBHTML.Append("<TD valign=top title=''  >&nbsp;" + vbCrLf)
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CeilingAmount", "CeilingAmount", , 100, 20, CommonFunction.Data.CheckIsDBNull(drRate("CeilingAmount"), "0.0").ToString, "right", , , , , , , True, True, EnableHTMLEncode:=True) + vbCrLf)
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                m_SBHTML.Append("&nbsp;" + Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRate("CurrencySymbol"), "")))
                m_SBHTML.Append("</TD>")
                m_SBHTML.Append("</TR>")
            End If
            If strContractType = "5" Then
                ''CAP Hours
                If Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRate("CAPHours"), "0.0")) <> "0" Then
                    m_dblMinimumWorkingHrs = CType(CommonFunction.Data.CheckIsDBNull(drRate("CAPHours"), "0.0"), Double)
                End If

                m_SBHTML.Append("<TR class='clsTRBody'>" + vbCrLf)
                m_SBHTML.Append("<TD title='' valign=top align=right width='50%'>" + vbCrLf)
                m_SBHTML.Append("Minimum Chargable Hour(s) in Month" + vbCrLf)
                m_SBHTML.Append("</TD>" + vbCrLf)
                m_SBHTML.Append("<TD valign=top title=''  >&nbsp;" + vbCrLf)
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CAPHours", "CAPHours", , 75, , m_dblMinimumWorkingHrs.ToString, "right", , , , , , , True, True, EnableHTMLEncode:=True) + vbCrLf)
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                m_SBHTML.Append("</TD>")
                m_SBHTML.Append("</TR>")
                ''CAP Days
                'm_SBHTML.Append("<TR class='clsTRBody'>" + vbCrLf)
                'm_SBHTML.Append("<TD title='' valign=top align=right width='50%'>" + vbCrLf)
                'm_SBHTML.Append("Minimum Day(s)" + vbCrLf)
                'm_SBHTML.Append("</TD>" + vbCrLf)
                'm_SBHTML.Append("<TD valign=top title=''  >&nbsp;" + vbCrLf)
                'm_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CAPDays", "CAPDays", , 75, , CommonFunction.Data.CheckIsDBNull(drRate("CAPDays"), "0.0").ToString, "right", , , , , , , True, True) + vbCrLf)
                'm_SBHTML.Append("</TD>")
                'm_SBHTML.Append("</TR>")
                '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                ''IsProRata Enabled

                m_SBHTML.Append("<TR class='clsTRBody'>" + vbCrLf)
                m_SBHTML.Append("<TD title='' valign=top align=right width='50%'> " + vbCrLf)
                m_SBHTML.Append("Is Prorata calculation required to bill minimum work hours ?" + vbCrLf)
                m_SBHTML.Append("</TD>" + vbCrLf)
                m_SBHTML.Append("<TD valign=top title='' >&nbsp;" + vbCrLf)
                m_SBHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("IsProRataEnabled", "IsProRataEnabled", , CBool(CommonFunction.Data.CheckIsDBNull(drRate("IsProRataEnabled"), "0")), "1", , , True) + vbCrLf)
                'm_SBHTML.Append("&nbsp;&nbsp; [ Are you going to bill extra hour/day(s) ? ]")
                m_SBHTML.Append("</TD>")
                m_SBHTML.Append("</TR>")
                ''''''''''''''''''''''''''''''''''''''''''''''''''


                m_SBHTML.Append("<TR class='clsTRBody'>" + vbCrLf)
                m_SBHTML.Append("<TD title='' valign=top align=right width='50%'> " + vbCrLf)
                m_SBHTML.Append("Are you going to bill extra hour(s) ?" + vbCrLf)
                m_SBHTML.Append("</TD>" + vbCrLf)
                m_SBHTML.Append("<TD valign=top title='' >&nbsp;" + vbCrLf)
                m_SBHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("IsExtraHrsBilling", "IsExtraHrsBilling", , CBool(CommonFunction.Data.CheckIsDBNull(drRate("IsExtraHrsBilling"), "0")), "1", , , True) + vbCrLf)
                'm_SBHTML.Append("&nbsp;&nbsp; [ Are you going to bill extra hour/day(s) ? ]")
                m_SBHTML.Append("</TD>")
                m_SBHTML.Append("</TR>")

            End If

        End If
        m_SBHTML.Append("</TABLE>" + vbCrLf)
        m_SBHTML.Append("</DIV>")
        Response.Write(m_SBHTML.ToString)
        CommonFunction.Data.DisposeDataReader(drRate)
        m_SBHTML = Nothing
    End Sub
    Private Sub DrawEngagementDetails()
        '====================================================================
        ' Procedure Name    :      DrawEngagementDetails
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw engagement master details
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Nov 27, 2008
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder
        m_objGrid = New WebPages.Template.AdvancedGrid

        strSQL = "usp_Sel_ProjectContractDetails " & m_objGlobal.ProjectID.ToString
        drRate = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        With m_SBHTML
            .Append("<DIV Id=divProject Style=""OVERFLOW:auto; WIDTH:100%;"">" + vbCrLf)
            .Append("<TABLE id='tblProject' CellSpacing=0 class='clsTable' width='99.9%'>" + vbCrLf)
            .Append("<TR class='clsTRBody'></TD></TR>" + vbCrLf)
            
            If drRate.Read Then

                .Append("<TR class='clsTRBody'>" + vbCrLf)
                .Append("<TD title='' valign=top align=right>" + vbCrLf)
                .Append("Project Name :" + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("<TD valign=top title='' colspan='1'  >&nbsp;" + vbCrLf)
                .Append(CommonFunction.Data.CheckIsDBNull(drRate("ProjectName"), "").ToString + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("</TR>" + vbCrLf)

                .Append("<TR class='clsTRBody'>" + vbCrLf)
                .Append("<TD title='' valign=top align=right>" + vbCrLf)
                .Append("Start Date :" + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("<TD valign=top title='' colspan='1'  >&nbsp;" + vbCrLf)
                .Append(CommonFunction.Dates.CGetDate(CType(CommonFunction.Data.CheckIsDBNull(drRate("ExpectedStartDate"), "").ToString, Date)) + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("</TR>" + vbCrLf)

                .Append("<TR class='clsTRBody'>" + vbCrLf)
                .Append("<TD title='' valign=top align=right>" + vbCrLf)
                .Append("End Date :" + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("<TD valign=top title='' colspan='1'  >&nbsp;" + vbCrLf)
                .Append(CommonFunction.Dates.CGetDate(CType(CommonFunction.Data.CheckIsDBNull(drRate("ExpectedEndDate"), "").ToString, Date)) + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("</TR>" + vbCrLf)

                .Append("<TR class='clsTRBody'>" + vbCrLf)
                .Append("<TD title='' valign=top align=right>" + vbCrLf)
                .Append("Commercial Type :" + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("<TD valign=top title='' colspan='1'  >&nbsp;" + vbCrLf)
                .Append(CommonFunction.Data.CheckIsDBNull(drRate("NodeLabel"), "").ToString + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("</TR>" + vbCrLf)

                .Append("<TR class='clsTRBody'>" + vbCrLf)
                .Append("<TD title='' valign=top align=right>" + vbCrLf)
                .Append("Project Value :" + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("<TD valign=top title='' colspan='1'  >&nbsp;" + vbCrLf)
                .Append(CommonFunction.Data.CheckIsDBNull(drRate("ContractValue"), "").ToString + vbCrLf)
                .Append("</TD>" + vbCrLf)
                .Append("</TR>")


                m_dblMinimumWorkingHrs = CommonFunction.Application.DaysPerPersonMonth * CType(CommonFunction.Data.CheckIsDBNull(drRate("OUWorkingHrs"), "0"), Double)


            End If

            .Append("</TABLE>" + vbCrLf)
            .Append("</DIV>")
        End With

        CommonFunction.Data.DisposeDataReader(drRate)

        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    'Private Sub DrawRateDetails()
    '    '====================================================================
    '    ' Procedure Name    :      DrawRateDetails
    '    ' Parameters Passed :      None
    '    ' Returns           :      None 
    '    ' Parameters Affected :    None
    '    ' Purpose           :      To draw engagement rate details
    '    ' Description       :      Same as purpose.
    '    ' Assumptions       :      None 
    '    ' Dependencies      :      None  
    '    ' Author            :      PrashantSJ
    '    ' Created           :      Nov 28, 2008
    '    ' Revisions         :
    '    '=====================================================================
    '    m_SBHTML = New StringBuilder


    '    m_SBHTML.Append("<DIV Id=divRate Style=""OVERFLOW:auto; WIDTH:100%;"">" + vbCrLf)
    '    m_SBHTML.Append("<TABLE id='tblRate' CellSpacing=0 class='clsTable' width='99.9%'>" + vbCrLf)
    '    m_SBHTML.Append("<TR class='clsTRBody'></TD></TR>" + vbCrLf)

    '    If strContractType <> "5" And strContractType <> "2" And strContractType <> "6" Then
    '        m_SBHTML.Append("<TR class='clsTRBody'><TD></TD>" + vbCrLf)
    '        m_SBHTML.Append("<TD title='' valign=top align=left>#&nbsp;<a href='javascript:Rate_OnClick(""Role"")'>" + vbCrLf)
    '        m_SBHTML.Append("Role Rates" + vbCrLf)
    '        m_SBHTML.Append("</a></TD>" + vbCrLf)
    '        m_SBHTML.Append("</TR>")
    '    End If

    '    m_SBHTML.Append("<TR class='clsTRBody'><TD></TD>" + vbCrLf)
    '    m_SBHTML.Append("<TD title='' valign=top align=left>#&nbsp;<a href='javascript:Rate_OnClick(""Resource"")'>" + vbCrLf)
    '    m_SBHTML.Append("Resource Rates" + vbCrLf)
    '    m_SBHTML.Append("</a></TD>" + vbCrLf)
    '    m_SBHTML.Append("</TR>")

    '    m_SBHTML.Append("</TABLE>" + vbCrLf)
    '    m_SBHTML.Append("</DIV>")
    '    Response.Write(m_SBHTML.ToString)
    '    CommonFunction.Data.DisposeDataReader(drRate)
    '    m_SBHTML = Nothing
    'End Sub
    Private Sub DisposeDataSetObjects()
        '====================================================================
        ' Procedure Name    :      DisposeDataSetObjects
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To dispose Dataset objects
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Nov 18, 2008
        ' Revisions         :
        '=====================================================================
        m_dsRoleRate = Nothing

    End Sub
    Protected Sub InitializeVariables()
        '====================================================================
        ' Procedure Name    :      InitializeVariables
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To init page varaibles
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================


        m_strAction = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), ""), String)

        m_strTabSection = Convert.ToString(CommonFunction.General.CheckIsNothing(Request.QueryString("TabSection"), ""))


    End Sub
    Protected Sub GetDatabaseValues()
        '====================================================================
        ' Procedure Name         :      GetDatabaseValues
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To get BOM Master details from Database.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        Dim m_strScript As New StringBuilder("")
        m_strScript.Append("<script language=""javascript"">")
        m_strScript.Append("var arrName=new Array();")
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT Name FROM tbl_PM_ProjectSites WHERE ProjectID=" + m_objGlobal.ProjectID.ToString + " AND IsOffShore=0 "
        strSQL = "usp_sel_tbl_PM_ProjectSites_Sites " + m_objGlobal.ProjectID.ToString

        drRate = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query

       
        If drRate.Read Then
            m_strScript.Append("arrName.push('" + CommonFunction.Data.CheckIsDBNull(drRate("Name")) + "');")
        End If
        CommonFunction.Data.DisposeDataReader(drRate)
        m_strScript.Append("</script>")
        Response.Write(m_strScript.ToString)

    End Sub
    Protected Sub DrawHiddenFields()
        '====================================================================
        ' Procedure Name    :      DrawHiddenFields
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw Hidden data fields.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================

        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtRoleID", "txtRoleID", , , , m_strRoleID, , , , , , True, , True))
        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtItems", "txtItems", , , , , IsHidden:=True, returnHTML:=True))
        'Response.Write(CommonFunctions.HTMLControls.DrawDateControl("dtProjectStartDate", "dtProjectStartDate", , , m_strProjectStartDate, , "frmRoleRate", , , , , , , True, , , , True))
        'Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cmbSiteCurrency", "usp_sel_ProjectSiteCurrency" + " " + m_lngProjectID.ToString, , , , True, True, , , , True))
    End Sub
    Protected Sub PerformAction()
        m_SBHTML = New StringBuilder("")

        Select Case CLng(m_strTabSection)
            Case SectionIndex.Settings
                m_SBHTML.Append("usp_Upd_ProjectContractMaster " + vbCrLf)
                m_SBHTML.Append(m_objGlobal.ProjectID.ToString)
                m_SBHTML.Append("," + Convert.ToString(IIf(CBool(CommonFunction.General.CheckIsNothing(Request.Form("IsExtraHrsBilling"), "0")), "1", "0")) + vbCrLf)
                m_SBHTML.Append("," + Convert.ToString(IIf(CBool(CommonFunction.General.CheckIsNothing(Request.Form("IsSingleSiteBilling"), "0")), "1", "0")) + vbCrLf)
                If Convert.ToString(CommonFunction.General.CheckIsNothing(Request.Form("CeilingAmount"), "")) <> "" Then
                    m_SBHTML.Append("," + Convert.ToString(Request.Form("CeilingAmount")) + vbCrLf)
                Else
                    m_SBHTML.Append(",NULL" + vbCrLf)
                End If
                If Convert.ToString(CommonFunction.General.CheckIsNothing(Request.Form("CAPHours"), "")) <> "" Then
                    m_SBHTML.Append("," + Convert.ToString(Request.Form("CAPHours")) + vbCrLf)
                Else
                    m_SBHTML.Append(",NULL" + vbCrLf)
                End If
                If Convert.ToString(CommonFunction.General.CheckIsNothing(Request.Form("CAPDays"), "")) <> "" Then
                    m_SBHTML.Append("," + Convert.ToString(Request.Form("CAPDays")) + vbCrLf)
                Else
                    m_SBHTML.Append(",NULL" + vbCrLf)
                End If

                m_SBHTML.Append("," + Convert.ToString(IIf(CBool(CommonFunction.General.CheckIsNothing(Request.Form("IsProRataEnabled"), "0")), "1", "0")) + vbCrLf)

                m_SBHTML.Append(",N'" + m_objGlobal.UserName + "'" + vbCrLf)

                CommonFunction.Data.InsertOrUpdateData(m_SBHTML.ToString, MyBase.UseSQL)
            Case SectionIndex.SiteDetails
                Dim strChkList As String = CommonFunction.General.CheckIsNothing(Request.Form("chkSelect"))
                If strChkList <> "" Then
                    Dim arrSiteIDs() As String = strChkList.Split(","c)

                    For i As Integer = 0 To arrSiteIDs.Length - 1
                        m_SBHTML.Append("usp_Upd_ProjectSiteMaster " + vbCrLf)
                        m_SBHTML.Append(m_objGlobal.ProjectID.ToString + vbCrLf)
                        m_SBHTML.Append("," + arrSiteIDs(i) + vbCrLf)
                        'm_SBHTML.Append(",N'" + CommonFunction.General.CheckIsNothing(Request.Form("Name"), "") + "'" + vbCrLf)
                        m_SBHTML.Append("," + CommonFunction.General.CheckIsNothing(Request.Form("RateMethod" + arrSiteIDs(i)), "") + vbCrLf)
                        'm_SBHTML.Append("," + CommonFunction.General.CheckIsNothing(Request.Form("CurrencyID"), "") + vbCrLf)
                        'm_SBHTML.Append("," + CommonFunction.General.CheckIsNothing(Request.Form("StartingDayOfWeek"), "") + vbCrLf)
                        m_SBHTML.Append("," + CommonFunction.General.CheckIsNothing(Request.Form("WorkHrs" + arrSiteIDs(i)), "0.0") + vbCrLf)
                        m_SBHTML.Append("," + CommonFunction.General.CheckIsNothing(Request.Form("WeekDays" + arrSiteIDs(i)), "0.0") + vbCrLf)

                        If Convert.ToString(CommonFunction.General.CheckIsNothing(Request.Form("ExtraHoursCap" + arrSiteIDs(i)), "")) <> "" Then
                            m_SBHTML.Append("," + Convert.ToString(Request.Form("ExtraHoursCap" + arrSiteIDs(i))) + vbCrLf)
                        Else
                            m_SBHTML.Append(",NULL" + vbCrLf)
                        End If

                        m_SBHTML.Append(",N'" + m_objGlobal.UserName + "'" + vbCrLf)
                        CommonFunction.Data.InsertOrUpdateData(m_SBHTML.ToString, MyBase.UseSQL)
                        m_SBHTML.Remove(0, m_SBHTML.Length)
                    Next

                End If
        End Select


        m_SBHTML = Nothing
    End Sub
    Protected Sub DrawMenu(ByVal ISectionIndex As Integer)
        '====================================================================
        ' Procedure Name    :      DrawMenu
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw menu  details.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        m_SBHTML = New StringBuilder


        Select Case ISectionIndex
            Case SectionIndex.Settings
                ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/Save.gif'>&nbsp;Save")
                ArrMenuToolTipsList.Add("Save")
                ArrClientSideFunctionsList.Add("Save_OnClick(" + ISectionIndex.ToString + ")")

                'Commented and Added by Dhanashri S on 4 Nov 2015
                'ArrMenuCaptionsList.Add("<img src='../../Images/KM.jpg' border='0'  />")
                ArrMenuCaptionsList.Add("<img src='../../Images/KM.jpg' border='0' style ='height:22px;'/>")
                ''End of Comment and Addition by Dhanashri S on 4 Nov 2015
                ArrMenuToolTipsList.Add("Note")
                ArrClientSideFunctionsList.Add("ShowInfoNote(event)")

            Case SectionIndex.SiteDetails

                ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/Save.gif'>&nbsp;Save")
                ArrMenuToolTipsList.Add("Save")
                ArrClientSideFunctionsList.Add("Save_OnClick(" + ISectionIndex.ToString + ")")

                If Not m_blnIsSingleSite Then
                    ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/add.gif'>&nbsp;Add Site")
                    ArrMenuToolTipsList.Add("Add Site")
                    ArrClientSideFunctionsList.Add("Add_OnClick(" + ISectionIndex.ToString + ")")
                End If

                'If strContractType = "3" Or strContractType = "7" Then
                '    ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/config.gif'>&nbsp;Define Role Rates")
                '    ArrMenuToolTipsList.Add("Role Rates")
                '    ArrClientSideFunctionsList.Add("Rate_OnClick('Role'," + IIf(m_blnIsSingleSite, "1", "0") + ")")
                'Else
                '    ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/config.gif'>&nbsp;Define Resource Rates")
                '    ArrMenuToolTipsList.Add("Resource Rates")
                '    ArrClientSideFunctionsList.Add("Rate_OnClick('Resource'," + IIf(m_blnIsSingleSite, "1", "0") + ")")
                'End If


            Case SectionIndex.Master
                ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>&nbsp;Close")
                ArrMenuToolTipsList.Add("Close")
                ArrClientSideFunctionsList.Add("Close_OnClick()")

                ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>&nbsp;")
                ArrMenuToolTipsList.Add("Help")
                ArrClientSideFunctionsList.Add("Help_OnClick('" + CommonFunction.Constants.APP_TAG_PROFIT_SITEROLE_RATE.ToString + "')")
        End Select

        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        m_objMenu = New WebPage.Templates.StaticMenu
        m_SBHTML.Append(m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True))

        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Protected Sub DrawMasterSection(ByVal ISectionIndex As Integer)
        '====================================================================
        ' Procedure Name    :      DrawMasterSection
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw MasterSections details.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder

        'Dim strCaption As String = CType(ISectionIndex + 1, String) + ".&nbsp;"
        Dim strCaption As String = "Step " + CType(ISectionIndex, String) + ":&nbsp;"

        Select Case ISectionIndex
            Case SectionIndex.Master
                strCaption = "&nbsp;"
                strCaption += " Project Details"
            Case SectionIndex.Settings
                strCaption += " Site Setting"
            Case SectionIndex.SiteDetails
                strCaption += " Manage Billing Rates"
            Case SectionIndex.RateDetails
                strCaption += " Configure Rates"
        End Select
        'm_SBHTML.Append(WebPages.Template.PageCaption.GetPageCaptions(, strCaption, , , True))

        m_SBHTML.Append("<TABLE id='tblMasterSection' CellSpacing=0 class='clsTable' width='99.9%'>" + vbCrLf)
        'm_SBHTML.Append("<TR class='clsTRBody'></TD></TR>" + vbCrLf)
        m_SBHTML.Append("<TR class='clsTRGroupHeader'>" + vbCrLf)
        m_SBHTML.Append("<TD valign=top>" + vbCrLf)
        m_SBHTML.Append("<b>" + strCaption + "</b>" + vbCrLf)
        m_SBHTML.Append("</TD>" + vbCrLf)
        m_SBHTML.Append("</TR>" + vbCrLf)
        m_SBHTML.Append("</TABLE>" + vbCrLf)


        Response.Write(m_SBHTML.ToString)

        m_SBHTML = Nothing

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
    ' Created               : July 29, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub
    '=====================================================================
    ' Procedure Name        : GetTagAccessRights()	
    ' Purpose               : Function To Get access rights for selected TAG
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : PrashantSJ
    ' Created               : July 3, 2007
    ' Revisions             :
    '=====================================================================
    Private Sub GetTagAccessRights()
        m_objGlobal.TagID = CommonFunction.Constants.APP_TAG_PROFIT_SITEROLE_RATE
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub
    Protected Sub DrawInfoNote()
        '=====================================================================
        ' Procedure Name        : DrawInfoNote()	
        ' Purpose               : This function is to draw the Project profitability checklist note.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : Aug 4,2009
        ' Revisions             :
        '=====================================================================
        Dim sbHTML As New StringBuilder("")

        Dim strNote As String = ""

        strNote = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_InformativieNote " + m_objGlobal.ProjectID.ToString + ",'CD'", MyBase.UseSQL)))

        sbHTML.Append("<div Id=divCQ class='clsInfoNote' Style='OVERFLOW:auto;width:400px;height:250px;display:none;'>")
        sbHTML.Append("<table id=tblCQ cellpadding=0 cellspacing=0 class='clsTable' >")


        sbHTML.Append("<tr class='clsTRNote'  >")
        sbHTML.Append("<td  align='left' width='20%' colspan='2'>")
        sbHTML.Append("&nbsp;<i>Note : </i></td>")
        sbHTML.Append("<td  width='80%'  style='align:right;text-align:right;' >")
        sbHTML.Append("<a href='javascript:CloseNote_OnClick()' title='Close Note' ><img src='../../Images/Home/Close.gif' border='0' /></a>")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")

        sbHTML.Append("<tr  class='clsTRNote' >")
        sbHTML.Append("<td  align='left' width='5%' align='left' valign='top' >")

        ''Commented and Added by Dhanashri S on 4 Nov 2015
        'sbHTML.Append("<img src='../../Images/KM.jpg' border='0' valign='top' /></td>")
        sbHTML.Append("<img src='../../Images/KM.jpg' border='0' valign='top' style ='height:22px;'/></td>")
        ''End of Comment and Addition by Dhanashri  Son 4 Nov 2015

        sbHTML.Append("<td  width='95%' align='left' >")
        'sbHTML.Append("While generation of project profitability snapshots you have to verify few corporate and project setup for calculation of <i>cost</i> and <i>revenue</i>")
        sbHTML.Append(strNote)
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")

        'sbHTML.Append("<tr  class='clsTRNote' >")
        'sbHTML.Append("<td  align='left' >")
        'sbHTML.Append("&nbsp;&nbsp;</td>")
        'sbHTML.Append("<td  align='left' >")
        'sbHTML.Append("1. Cost")
        'sbHTML.Append("</td>")
        'sbHTML.Append("</tr>")


        sbHTML.Append("</table>")
        sbHTML.Append("</div>")

        sbHTML.Append("</br>")


        Response.Write(sbHTML.ToString)
        sbHTML = Nothing
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()

    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "NAME" Then
            Dim strProjectSiteID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectSiteID"), "0")
            Dim PKToken As String = CommonFunctions.Security.Token.GetToken(strProjectSiteID + m_objGlobal.UserID.ToString + "0" + CommonFunction.Constants.APP_TAG_PROJECTSITES.ToString)
            Cancel = True
            Args.StringToBeInserted = "<TD><A href='javascript:SiteName_OnClick(" + strProjectSiteID + ",""" + PKToken + """)' >" + CommonFunction.Data.CheckIsDBNull(Args.DataReader("Name")) + " </A></TD>"
        End If

    End Sub

    Private Sub m_objRateGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objRateGrid.ColumnHeaderTD_BeforePrint
        If m_blnIsSingleSite = True Then
            If Args.DataField.ToUpper = "NAME" Then
                Cancel = True
            End If
        End If
        If strContractType <> "2" And strContractType <> "5" And strContractType <> "6" Then
            Select Case Args.DataField.ToUpper
                Case "NORMALRATE", "EXTRARATE", "HOLIDAYRATE"
                    Cancel = True
            End Select

        End If
        If (strContractType = "5" And Not blnIsExtrHrsBilling) Then
            Select Case Args.DataField.ToUpper
                Case "EXTRARATE", "HOLIDAYRATE"
                    Cancel = True
            End Select

        End If

        If Args.ColIndex = 7 Then
            Args.TDStyle = "style='text-align:left;'"
        End If
    End Sub

    Private Sub m_objRateGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objRateGrid.DataRowTD_BeforePrint
        If m_blnIsSingleSite = True Then
            If Args.DataField.ToUpper = "NAME" Then
                Cancel = True
            End If
        End If
        If strContractType <> "2" And strContractType <> "5" And strContractType <> "6" Then
            Select Case Args.DataField.ToUpper
                Case "NORMALRATE", "EXTRARATE", "HOLIDAYRATE"
                    Cancel = True
            End Select
        End If
        If (strContractType = "5" And Not blnIsExtrHrsBilling) Then
            Select Case Args.DataField.ToUpper
                Case "EXTRARATE", "HOLIDAYRATE"
                    Cancel = True
            End Select

        End If
    End Sub

    Private Sub m_objRoleRateGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objRoleRateGrid.ColumnHeaderTD_BeforePrint
        If m_blnIsSingleSite = True Then
            If Args.DataField.ToUpper = "NAME" Then
                Cancel = True
            End If
        End If
        If (strContractType = "5" And Not blnIsExtrHrsBilling) Then
            Select Case Args.DataField.ToUpper
                Case "EXTRARATE", "HOLIDAYRATE"
                    Cancel = True
            End Select

        End If
    End Sub

    Private Sub m_objRoleRateGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objRoleRateGrid.DataRowTD_BeforePrint
        If m_blnIsSingleSite = True Then
            If Args.DataField.ToUpper = "NAME" Then
                Cancel = True
            End If
        End If
        If (strContractType = "5" And Not blnIsExtrHrsBilling) Then
            Select Case Args.DataField.ToUpper
                Case "EXTRARATE", "HOLIDAYRATE"
                    Cancel = True
            End Select

        End If
    End Sub
    ''Added by Yogesh J on 28-Mar-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod>
    Public Shared Function RateChange_OnClick(EmployeeID As String) As String

        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of addition by Yogesh J on 28-Mar-2016 for to generate and validate Token		
End Class
