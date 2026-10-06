Public Class CompanyInformation
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

    Private strMenu As String
    Private m_strMode As String = ""

    Private m_strCompanyName As String = ""
    Private m_strcompanyShortName As String = ""
    Private m_strAddress As String = ""
    Private m_strCity As String = ""
    Private m_strState As String = ""
    Private m_strCountry As String = ""
    Private m_strZip As String = ""
    Private m_strEmail As String = ""
    Private m_intDateFormat As Integer
    Private m_intFileSize As Integer
    Private m_strStartdate As String = ""
    Private m_strEndDate As String = ""
    Private m_intUsers As Integer
    Private m_intWeekDays As Integer
    Private m_intHoursInDay As Integer
    Private m_strProductVersion As String = ""

    Public Sub PageInit()

        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : main procedure to build page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 18, 2004
        ' Revisions             :
        '=====================================================================

        Call SetVariables()

        If m_strMode.ToUpper = "SAVE" Then
            Call SaveInformation()
            Response.Redirect("../../Default.aspx")
        End If

        strMenu = GenerateMenu()
        Response.Write(strMenu)

        MyBase.InitializeResources("AppResources.CompanyInformation", "AppResources")

        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {CommonFunction.HTMLControls.DrawMandatoryImage(, True)}
        CommonFunction.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGECAPTION"), , , True))
        Response.Write("<BR>")

        Response.Write("<DIV ID='PageDiv' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
        Call PlotControls()
        Response.Write("</DIV>")

        Response.Write("<BR>" + strMenu)
    End Sub ' Main procedure to build page

    Private Sub SaveInformation()

        '=====================================================================
        ' Procedure Name        : SaveInformation()	
        ' Purpose               : Save company information
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 18, 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As New System.Text.StringBuilder("")
        strSQL.Append("EXEC usp_upd_tbl_PM_CompanyInformation ")
        strSQL.Append("@CompanyName = '" + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtCompanyName"), "") + "', ")
        strSQL.Append("@ShortCompanyName = '" + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtCompanyShortName"), "") + "', ")
        strSQL.Append("@Address = '" + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtAddress"), "") + "', ")
        strSQL.Append("@City  = '" + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtCity"), "") + "', ")
        strSQL.Append("@Country  = '" + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtCountry"), "") + "', ")
        strSQL.Append("@State  = '" + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtState"), "") + "', ")
        strSQL.Append("@ZipCode  = '" + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtZip"), "") + "', ")
        strSQL.Append("@Email  = '" + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtEmail"), "") + "', ")
        strSQL.Append("@FinancialYearStart = '" + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtStartDate"), "") + "', ")
        strSQL.Append("@FinancialYearEnd = '" + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtEndDate"), "") + "', ")
        strSQL.Append("@NoOfUsers = " + m_intUsers.ToString + ", ")
        strSQL.Append("@ProductVersion = '" + m_strProductVersion + "', ")
        strSQL.Append("@WeekDays = " + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtWeekDays"), "") + ", ")
        strSQL.Append("@DateFormatID = " + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("cboDateformat"), "") + ", ")
        strSQL.Append("@HoursPerDay = " + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtHours"), ""))

        CommonFunction.Data.InsertOrUpdateData(strSQL.ToString, MyBase.UseSQL)
        strSQL = Nothing

        ' Added by NitinVS on 13 Aug 2007 for WhiziblSEM 7.0 
        'Reload Application Settings
        Call CommonFunctions.General.GetCorporateSettings(True)
        Call CommonFunction.General.LoadCompanyApplicationSettings()
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_PROJECT_SETTINGS)
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_CUSTOMER_MASTER)
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.TAG_ROLE_MAINTENANCE)
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_TAB_PRODUCT_REPORTS)
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_CORPORATE_SETTINGS)

        'End Addition by NitinVS on 13 Aug 2007 for WhiziblSEM 7.0 
    End Sub 'Save company information

    Public Sub New()
        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : constructor for tha page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 18, 2004
        ' Revisions             :
        '=====================================================================

        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.CompanyInformation", "AppResources")
    End Sub ' Constructor for the page

    Private Sub SetVariables()

        '=====================================================================
        ' Procedure Name        : SetVariables()	
        ' Purpose               : Set the variables being used in this page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 18, 2004
        ' Revisions             :
        '=====================================================================


        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                m_strMode = Request.QueryString("Mode").ToString
            End If
        End If

        Dim drCompanyInfo As IDataReader
        drCompanyInfo = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Companyinformation", MyBase.UseSQL)

        If Not drCompanyInfo.Read Then
            CommonFunction.Data.DisposeDataReader(drCompanyInfo)
            Exit Sub
        End If
        m_strCompanyName = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("CompanyName"), "").ToString
        m_strcompanyShortName = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("ShortCompanyName"), "").ToString
        m_strAddress = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("Address"), "").ToString
        m_strCity = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("City"), "").ToString
        m_strState = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("State"), "").ToString
        m_strCountry = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("Country"), "").ToString
        m_strZip = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("ZipCode"), "").ToString
        m_strEmail = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("Email"), "").ToString
        m_intDateFormat = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("DateFormatID"), "0"), Integer)
        m_intFileSize = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("MaxReleaseFileSize"), "0"), Integer)
        m_strStartdate = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("FinancialYearStart"), "").ToString
        If m_strStartdate <> "" Then m_strStartdate = CommonFunction.Dates.CGetDate(CType(m_strStartdate, Date))
        m_strEndDate = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("FinancialYearEnd"), "").ToString
        If m_strEndDate <> "" Then m_strEndDate = CommonFunction.Dates.CGetDate(CType(m_strEndDate, Date))
        m_intUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NoOfusers"), ""), Integer)
        m_intWeekDays = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("WeekDays"), ""), Integer)
        m_intHoursInDay = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("HoursPerDay"), ""), Integer)
        m_strProductVersion = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("ProductVersion"), "").ToString

        CommonFunction.Data.DisposeDataReader(drCompanyInfo)
    End Sub ' Set variables being used in this page

    Private Function GenerateMenu() As String
        '=====================================================================
        ' Function Name         : GenerateMenu()	
        ' Purpose               : To generate Menu 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : menu string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 18, 2004
        ' Revisions             :
        '=====================================================================

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips


        'Save 
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Save_OnClick()")

        'Close
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        'Help 
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('IB_REPORTS')")

        'Convert arraylist to array - Menu captions
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

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)

    End Function 'Menu generation

    Private Sub PlotControls()
        '=====================================================================
        ' Procedure Name        : PlotControls()	
        ' Purpose               : Plot the controls on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 18, 2004
        ' Revisions             :
        '=====================================================================


        MyBase.InitializeResources("AppResources.CompanyInformation", "AppResources")

        Response.Write("<TABLE class=clsTable cellspacing=0 cellpadding=0 width=99.9%>")

        'Company name
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("COMPANYNAME") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawTextBox("txtCompanyName", "txtCompanyName", , 350, 400, , m_strCompanyName, IsMandatory:=True, ReturnHTML:=True) + "</TD>")
        Response.Write("</TR>")

        'Company short name
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("COMPANYSHORTNAME") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawTextBox("txtCompanyShortName", "txtCompanyShortName", , 100, 10, m_strcompanyShortName, IsMandatory:=True, ReturnHTML:=True) + "</TD>")
        Response.Write("</TR>")

        'Address
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("ADDRESS") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawTextBox("txtAddress", "txtAddress", , 300, 50, m_strAddress, ReturnHTML:=True) + "</TD>")
        Response.Write("</TR>")

        'City
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("CITY") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawTextBox("txtCity", "txtCity", , 150, 30, m_strCity, ReturnHTML:=True) + "</TD>")
        Response.Write("</TR>")

        'State
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("STATE") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawTextBox("txtState", "txtState", , 150, 30, m_strState, ReturnHTML:=True) + "</TD>")
        Response.Write("</TR>")

        'Country
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("COUNTRY") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawTextBox("txtCountry", "txtCountry", , 150, 30, m_strCountry, ReturnHTML:=True) + "</TD>")
        Response.Write("</TR>")

        'Zip
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("ZIP") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawTextBox("txtZip", "txtZip", , 150, 10, m_strZip, ReturnHTML:=True) + "</TD>")
        Response.Write("</TR>")

        'EMail
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("EMAIL") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawTextBox("txtEmail", "txtEmail", , 300, 50, m_strEmail, ReturnHTML:=True) + "</TD>")
        Response.Write("</TR>")

        'Date Format
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("DATEFORMAT") + "</TD>")
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        '' Response.Write("<TD>" + CommonFunction.HTMLControls.DrawComboBox("cboDateformat", "Select DateFormatID,FormatDate From tbl_PM_DateFormats", 150, m_intDateFormat.ToString, IsMandatory:=True, ReturnAsHTML:=True) + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawComboBox("cboDateformat", "usp_sel_tbl_PM_DateFormats_DateFormat ", 150, m_intDateFormat.ToString, IsMandatory:=True, ReturnAsHTML:=True) + "</TD>")
        ''End of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        Response.Write("</TR>")

        'Financial year start date
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("FYSTARTDATE") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawDateControl("txtStartDate", "txtStartDate", value:=m_strStartdate, formname:="frmCompanyInformation", ReturnHTML:=True, IsMandatory:=True) + "</TD>")
        Response.Write("</TR>")

        'Financial year end date
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("FYENDDATE") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawDateControl("txtEndDate", "txtEndDate", value:=m_strEndDate, formname:="frmCompanyInformation", ReturnHTML:=True, ismandatory:=True) + "</TD>")
        Response.Write("</TR>")

        'Number of Users
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("USERS") + "</TD>")
        Response.Write("<TD>" + m_intUsers.ToString + "</TD>")
        Response.Write("</TR>")

        'Week Days
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("WEEKDAYS") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawTextBox("txtWeekDays", "txtWeekDays", , 50, 1, m_intWeekDays.ToString, "Right", IsMandatory:=True, ReturnHTML:=True) + "</TD>")
        Response.Write("</TR>")

        'Hours in a day
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("HOURS") + "</TD>")
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawTextBox("txtHours", "txtHours", , 50, 10, m_intHoursInDay.ToString, "Right", IsMandatory:=True, ReturnHTML:=True) + "</TD>")
        Response.Write("</TR>")

        'Product version
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>" + MyBase.GetResourceString("PRODUCTVERSION") + "</TD>")
        Response.Write("<TD>" + m_strProductVersion + "</TD>")
        Response.Write("</TR>")

        Response.Write("</TABLE>")

    End Sub 'Plot controls on the page
End Class
