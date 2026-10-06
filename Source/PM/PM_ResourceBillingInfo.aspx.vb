

#Region "Imports"

Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data

#End Region



Public Class PM_ResourceBillingInfo
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
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.
    Protected m_strTimesheetID As String
    'Added by MonikaI on 10th Oct 2006 IssueID : 6942
    Protected strTagID As String
    Protected strParentTagID As String
    Protected strTokenID As String
    Protected strUserID As String
    'End of addition by MonikaI
    Protected m_strEmployeeName As String
    Protected m_strSiteName As String
    Protected m_strProjectID As String
    Private m_blnTimeSheetReadyForAuth As Boolean = False

    'Resource variables for total
    Protected m_ResourceNormalHourTotal As Double
    Protected m_ResourceNoramlBillingTotal As Double
    Protected m_ResourceExtraHourTotal As Double
    Protected m_ResourceExtraBillingTotal As Double
    Protected m_ResourceTotalBillableHour As Double
    Protected m_ResourceTotalBillableWage As Double
    Protected m_ResourceTotalNonBillableHour As Double
    Protected m_ResourceTotalNonBillableWage As Double

    'Site variables for total
    Protected m_SiteNormalHourTotal As Double
    Protected m_SiteNoramlBillingTotal As Double
    Protected m_SiteExtraHourTotal As Double
    Protected m_SiteExtraBillingTotal As Double
    Protected m_SiteTotalBillableHour As Double
    Protected m_SiteTotalBillableWage As Double
    Protected m_SiteTotalNonBillableHour As Double
    Protected m_SiteTotalNonBillableWage As Double

    'Project variables for total
    Protected m_ProjectNormalHourTotal As Double
    Protected m_ProjectNoramlBillingTotal As Double
    Protected m_ProjectExtraHourTotal As Double
    Protected m_ProjectExtraBillingTotal As Double
    Protected m_ProjectTotalBillableHour As Double
    Protected m_ProjectTotalBillableWage As Double
    Protected m_ProjectTotalNonBillableHour As Double
    Protected m_ProjectTotalNonBillableWage As Double

    Protected m_strProjectName As String

    Protected m_strEmployee As String
    Protected m_strSiteNameSubStr As String
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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_HELP")}

        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

        'Modified By VidyaJ - For IssueI - 492 - SP4
        'Dim arrClientSideFunction() As String = {"Help_OnClick('1060')"}

        'Modified By SuchitraP on 30-APR-2007 for IssueID-12628

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("BACK"), MyBase.GetResourceString("MENU_HELP")}

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("BACK_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

        'Modified By VidyaJ - For IssueI - 492 - SP4
        Dim arrClientSideFunction() As String = {"Close_Onclick()", "Back_Onclick()", "Help_OnClick('1060')"}
        'End of modification by SuchitraP on 30-APR-2007 



        Dim strGrid As String

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)
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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION")))
        Response.Write("<BR>")
    End Sub

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing
    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here
        Dim strSQL As String
        Dim drIsHoliday As IDataReader

        ' Code added by SwapnilR on 26th Sept 2006
        ' Purpose : Added token based page security 


        m_strTimesheetID = CType(Request.QueryString("TimesheetID"), String)

        strTagID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TagID"), "0"), String)
        If strTagID <> "0" Then
            strUserID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UserID"), "0"), String)
            strTagID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TagID"), "0"), String)
            strParentTagID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ParentTagID"), "0"), String)
            strTokenID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PKToken"), "0"), String)
        End If


        If CommonFunctions.Security.Token.ValidateToken(m_strTimesheetID + strUserID + strParentTagID + strTagID, strTokenID) = False Then
            ' If token is not validated then displaying the invalid access page
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Billing Information", CType(strTagID, Long), CType(strParentTagID, Long), "PrimaryKey", m_strTimesheetID)
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        Else
            'This will initialize all the global objects.
            GetGlobalObject()

            'This will strore the constructed menu string in a string variable.   
            DrawMenu()

            CommonFunctions.General.WriteHTML(strMenu)
            CommonFunctions.General.WriteHTML("<BR>")

            'Display the page caption.
            DrawPageCaption()

            '##### Getting the values from the querystring or session



            m_strProjectID = CType(Session("intProjectID"), String)

            'Code commented by SwapnilR on 21st Jan 2005
            'strSQL = " Exec usp_Ins_tbl_PM_SiteResourceTimeSheet " + m_strProjectID + " , " + m_strTimesheetID
            'drIsHoliday = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            'drIsHoliday.Close()
            'End of code comment by SwapnilR on 21st Jan 2005
            drIsHoliday = Nothing

            PlotFilters()

            Response.Write("<BR>")
            PlotPeriodHeader()
            Response.Write("<BR>")
            Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
            PlotGrid()
            HttpContext.Current.Response.Write("</DIV>")
            'Display the Menu at the Bottom
            CommonFunctions.General.WriteHTML("<BR>")
            CommonFunctions.General.WriteHTML(strMenu)
            CommonFunctions.General.WriteHTML("<BR>")

            DisposeObjects()

        End If

        ' End of code addition by SwapnilR on 26th Sept 2006


    End Sub

    Public Sub PlotFilters()
        Dim strFilterSiteID As String
        Dim strFilterEmployeeID As String
        Dim strSQL As String

        If CType(Request.Form("cboSite"), String) <> "" Then
            strFilterSiteID = CType(Request.Form("cboSite"), String)
        Else
            strFilterSiteID = ""
        End If

        If CType(Request.Form("cboEmployee"), String) <> "" Then
            strFilterEmployeeID = CType(Request.Form("cboEmployee"), String)
        Else
            strFilterEmployeeID = ""
        End If

        CommonFunctions.General.WriteHTML("<TABLE cellspacing='0' cellpadding='0' Width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRPageHeader'>")
        CommonFunctions.General.WriteHTML("<td align='left'><b>" + MyBase.GetResourceString("SITE") + "</b>&nbsp;")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''CommonFunctions.HTMLControls.DrawComboBox("cboSite", "Select Distinct SiteID,SiteName from tbl_PM_SiteResourceTimeSheet Where TimeSheetID = " + CType(m_strTimesheetID, String), , CType(strFilterSiteID, String), "onChange=ApplySiteFilter();", True)
        CommonFunctions.HTMLControls.DrawComboBox("cboSite", "usp_sel_tbl_PM_SiteResourceTimeSheet_SiteID_SiteName " + CType(m_strTimesheetID, String), , CType(strFilterSiteID, String), "onChange=ApplySiteFilter();", True)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.General.WriteHTML("</td>")

        '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "Select Distinct EmployeeID, EmployeeName FROM tbl_PM_SiteResourceTimeSheet WHERE TimeSheetID = " + CType(m_strTimesheetID, String)
        strSQL = "usp_sel_tbl_PM_SiteResourceTimeSheet_EmployeeID_EmployeeName " + CType(m_strTimesheetID, String)
        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016


        CommonFunctions.General.WriteHTML("<td align='left'><B>" + MyBase.GetResourceString("RESOURCE") + "</b>&nbsp;")
        CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strSQL, , strFilterEmployeeID, "onChange=ApplyEmployeeFilter()", True)
        CommonFunctions.General.WriteHTML("</B></td>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub

    Public Sub PlotPeriodHeader()
        Dim strSQL As String
        Dim drGetTimesheetPeriod As IDataReader
        Dim strFromDate As String
        Dim strToDate As String
        Dim objFromDate As DateTime
        Dim objToDate As DateTime

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT tbl_PM_TimesheetInvoice.TimesheetNo, tbl_PM_TimesheetInvoice.FromDate, tbl_PM_TimesheetInvoice.ToDate, tbl_PM_Project.ProjectName FROM tbl_PM_TimesheetInvoice, tbl_PM_Project WHERE tbl_PM_TimesheetInvoice.ProjectID = tbl_PM_Project.ProjectID AND TimesheetNo = " + CType(m_strTimesheetID, String)
        strSQL = "usp_sel_tbl_PM_TimesheetInvoice_TimesheetNo " + CType(m_strTimesheetID, String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        drGetTimesheetPeriod = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drGetTimesheetPeriod.Read Then
            m_strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(drGetTimesheetPeriod("ProjectName"), ""), String)
            strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(drGetTimesheetPeriod("FromDate"), ""), String)
            If strFromDate <> "" Then objFromDate = CType(strFromDate, DateTime)
            strToDate = CType(CommonFunctions.Data.CheckIsDBNull(drGetTimesheetPeriod("ToDate"), ""), String)
            If strToDate <> "" Then objToDate = CType(strToDate, DateTime)
        End If
        CommonFunctions.General.WriteHTML("<TABLE cellspacing='0' cellpadding='0' Width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRPageHeader'>")
        'To Do: Get dates
        CommonFunctions.General.WriteHTML("<td height='22' align='left'><B>" + MyBase.GetResourceString("PROJECT") + m_strProjectName + "&nbsp;&nbsp;</B></td>")
        CommonFunctions.General.WriteHTML("<td height='22' align='right'><B>" + MyBase.GetResourceString("PERIOD") + CommonFunctions.Dates.CGetDate(objFromDate) + "&nbsp;" + MyBase.GetResourceString("TO") + "&nbsp;" + CommonFunctions.Dates.CGetDate(objToDate) + "</B></td>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.Data.DisposeDataReader(drGetTimesheetPeriod)
    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Swapnil Ranjankar
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function


    Public Sub PlotGrid()
        '=====================================================================
        ' Procedure Name        : PlotGrid()	
        ' Purpose               : Plots the grid displaying tasks of employee
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Swapnil Ranjankar
        ' Created               : 
        ' Revisions             :
        '=====================================================================


        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim strSQL As String
        Dim strFilterSiteID As String
        Dim strFilterEmployeeID As String

        'To store the link details while clicking on Links in grid

        Dim arrWidthArray() As String = {"style='width:12%' align='center'", "style='width:12%' align='center'", "style='width:12%' align='center'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:10%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'"}

        Dim arrColRowLinks() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "", ""}

        Dim arrAlignment() As String = {"left", "left", "right", "center", "center", "center", "center", "center", "center", "center", "center", "center"}

        If CType(Request.Form("cboSite"), String) <> "" Then
            strFilterSiteID = CType(Request.Form("cboSite"), String)
        Else
            strFilterSiteID = "NULL"
        End If

        If CType(Request.Form("cboEmployee"), String) <> "" Then
            strFilterEmployeeID = CType(Request.Form("cboEmployee"), String)
        Else
            strFilterEmployeeID = "NULL"
        End If

        'Commented And Added By Usha Pandit On 10.12.2020 For getting work hours in HH:MM from decimal format
        'strSQL = "Exec usp_CSP_ProjectResourceWage_1  " + m_strTimesheetID
        strSQL = "Exec usp_CSP_ProjectResourceHHMMWage_1  " + m_strTimesheetID
        'Commented And Added By Usha Pandit On 10.12.2020 For getting work hours in HH:MM from decimal format

        If strFilterSiteID <> "NULL" Then
            strSQL = strSQL + " , " + strFilterSiteID
        Else
            strSQL = strSQL + " , NULL"
        End If

        If strFilterEmployeeID <> "NULL" Then
            strSQL = strSQL + " , " + strFilterEmployeeID
        Else
            strSQL = strSQL + ", NULL"
        End If


        '##### Get Column Headings from Resources 
        arrColumnHeadingList.Add(MyBase.GetResourceString("SITE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("RESOURCE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("NORMAL_HOURS"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("NORMAL_RATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("NORMAL_BILLING_TOTAL"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("EXTRA_HOURS"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("EXTRA_RATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("EXTRA_BILLING_TOTAL"))

        arrColumnHeadingList.Add(MyBase.GetResourceString("TOTAL_BILLABLE_HOURS"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("TOTAL_BILLABLE_WAGE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("TOTAL_NONBILLABLE_HOURS"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("NONBILLABLE_RATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("TOTAL_NONBILLABLE_WAGE"))


        '##### End 

        '##### Actual Column Names List
        arrActualColumnNames.Add("SiteName")
        arrActualColumnNames.Add("EmployeeName")
        arrActualColumnNames.Add("Date")
        arrActualColumnNames.Add("NormalHours")
        arrActualColumnNames.Add("NormalRate")
        arrActualColumnNames.Add("TotalNormalWage")
        arrActualColumnNames.Add("ExtraHours")
        arrActualColumnNames.Add("ExtraRate")
        arrActualColumnNames.Add("TotalExtraWage")
        arrActualColumnNames.Add("TotalBillableHours")
        arrActualColumnNames.Add("TotalBillableWage")
        arrActualColumnNames.Add("NonBillableHours")
        arrActualColumnNames.Add("NonBillableRate")
        arrActualColumnNames.Add("TotalNonBillableWage")
        '##### End
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 14
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 540
            .SQL = strSQL
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGrid = Nothing

    End Sub


#End Region


#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_ProjectTimesheetBillingInfo", "AppResources")
    End Sub
#End Region



#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

#Region "Grid Event Handling"
    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        Dim strPrevSiteName As String
        Dim arrSiteName() As String
        Dim arrEmployee() As String
        Dim strSQL As String
        Dim drIsHoliday As IDataReader
        Dim blnHolidayStatus As Boolean
        Dim strDate As String
        Dim objDate As DateTime

        strPrevSiteName = Args.DataReader("SiteName").ToString

        If m_strSiteName <> Args.DataReader("SiteName").ToString.Trim Then
            strPrevSiteName = ""
            If CType(m_strSiteName, String) <> "" Then
                If CType(m_strEmployeeName, String) <> "" Then

                    Args.StringToBeInserted = "<TR class='clsTRColumnHeader'>"
                    Args.StringToBeInserted += "<TD colspan=3 align=right title='Resource Total'>" + "Total for Resource " + CType(m_strEmployeeName, String) + "</td>"
                    Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceNormalHourTotal, String), 2) + "</td><td></td>"
                    Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceNoramlBillingTotal, String), 2) + "</td>"
                    Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceExtraHourTotal, String), 2) + "</td><td></td>"
                    Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceExtraBillingTotal, String), 2) + "</td>"
                    Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalBillableHour, String), 2) + "</td>"
                    Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalBillableWage, String), 2) + "</td>"
                    Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalNonBillableHour, String), 2) + "</td><td></td>"
                    Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalNonBillableWage, String), 2) + "</td>"
                    Args.StringToBeInserted += "</tr>"

                    m_ResourceNormalHourTotal = 0
                    m_ResourceNoramlBillingTotal = 0
                    m_ResourceExtraHourTotal = 0
                    m_ResourceExtraBillingTotal = 0
                    m_ResourceTotalBillableHour = 0
                    m_ResourceTotalBillableWage = 0
                    m_ResourceTotalNonBillableHour = 0
                    m_ResourceTotalNonBillableWage = 0
                End If

                Args.StringToBeInserted += "<TR class='clsTRGroupHeader'>"
                Args.StringToBeInserted += "<TD colspan=3 align=right title='Site Total'>" + "Total for Site " + CType(m_strSiteName, String) + "</td>"
                'Commented And Added By Usha Pandit On 09.12.2020 For getting work hours in HH:MM from decimal format

                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteNormalHourTotal, String), 2) + "</td><td></td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteNoramlBillingTotal, String), 2) + "</td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteExtraHourTotal, String), 2) + "</td><td></td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteExtraBillingTotal, String), 2) + "</td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalBillableHour, String), 2) + "</td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalBillableWage, String), 2) + "</td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalNonBillableHour, String), 2) + "</td><td></td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalNonBillableWage, String), 2) + "</td>"

                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_SiteNormalHourTotal, String), 2) + "',1)", True) + "</td><td></td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteNoramlBillingTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_SiteExtraHourTotal, String), 2) + "',1)", True) + "</td><td></td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteExtraBillingTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_SiteTotalBillableHour, String), 2) + "',1)", True) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalBillableWage, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_SiteTotalNonBillableHour, String), 2) + "',1)", True) + "</td><td></td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalNonBillableWage, String), 2) + "</td>"

                'End Of Added By Usha Pandit On 09.12.2020 For getting work hours in HH:MM from decimal format
                Args.StringToBeInserted += "</tr>"
                m_SiteNormalHourTotal = 0
                m_SiteNoramlBillingTotal = 0
                m_SiteExtraHourTotal = 0
                m_SiteExtraBillingTotal = 0
                m_SiteTotalBillableHour = 0
                m_SiteTotalBillableWage = 0
                m_SiteTotalNonBillableHour = 0
                m_SiteTotalNonBillableWage = 0

            End If
            m_strSiteName = Args.DataReader("SiteName").ToString + ""
            arrSiteName = m_strSiteName.Split(":"c)
            m_strSiteNameSubStr = arrSiteName.GetValue(0).ToString
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=14>" + CType(Args.DataReader("SiteName"), String)
        End If


        If m_strEmployeeName <> Args.DataReader("EmployeeName").ToString.Trim Then
            If m_strEmployeeName <> "" And strPrevSiteName <> "" And strPrevSiteName = m_strSiteName Then

                'Commented And Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format
                'Args.StringToBeInserted += "<TR class='clsTRColumnHeader'>"
                'Args.StringToBeInserted += "<TD colspan=3 align=right title='Resource Total'>" + "Total for Resource " + CType(m_strEmployeeName, String) + "</td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceNormalHourTotal, String), 2) + "</td><td></td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceNoramlBillingTotal, String), 2) + "</td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceExtraHourTotal, String), 2) + "</td><td></td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceExtraBillingTotal, String), 2) + "</td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalBillableHour, String), 2) + "</td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalBillableWage, String), 2) + "</td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalNonBillableHour, String), 2) + "</td><td></td>"
                'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalNonBillableWage, String), 2) + "</td>"
                'Args.StringToBeInserted += "</tr>"

                Args.StringToBeInserted += "<TR class='clsTRColumnHeader'>"
                Args.StringToBeInserted += "<TD colspan=3 align=right title='Resource Total'>" + "Total for Resource " + CType(m_strEmployeeName, String) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_ResourceNormalHourTotal, String), 2) + "',1)", True) + "</td><td></td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceNoramlBillingTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_ResourceExtraHourTotal, String), 2) + "',1)", True) + "</td><td></td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceExtraBillingTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_ResourceTotalBillableHour, String), 2) + "',1)", True) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalBillableWage, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_ResourceTotalNonBillableHour, String), 2) + "',1)", True) + "</td><td></td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalNonBillableWage, String), 2) + "</td>"
                Args.StringToBeInserted += "</tr>"

                'End Of Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format

                m_ResourceNormalHourTotal = 0
                m_ResourceNoramlBillingTotal = 0
                m_ResourceExtraHourTotal = 0
                m_ResourceExtraBillingTotal = 0
                m_ResourceTotalBillableHour = 0
                m_ResourceTotalBillableWage = 0
                m_ResourceTotalNonBillableHour = 0
                m_ResourceTotalNonBillableWage = 0

            End If
            m_strEmployeeName = Args.DataReader("EmployeeName").ToString + ""
            Args.StringToBeInserted += "<TR class='clsTRGroupHeader' ><TD></TD><TD align='left' colspan=13>" + CType(m_strEmployeeName, String) + "</TD></TR>"
            m_strEmployeeName = Args.DataReader("EmployeeName").ToString
            arrEmployee = m_strEmployeeName.Split(":"c)
            m_strEmployee = arrEmployee.GetValue(0).ToString
        End If

        'strSQL = "SELECT Holiday FROM tbl_PM_ProjectSiteCalendar  WHERE ProjectID = " + CType(m_strProjectID, String) + " AND SiteID = " + Args.DataReader("SiteID").ToString + " AND [Date] = '" + Args.DataReader("Date").ToString + "' AND Holiday = 1 AND Freeze = 1"
        'drIsHoliday = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        'If drIsHoliday.Read Then
        '    blnHolidayStatus = CType(CommonFunctions.Data.CheckIsDBNull(drIsHoliday("Holiday"), ""), Boolean)
        '    If (blnHolidayStatus) Then
        '        Cancel = True
        '        Args.StringToBeInserted += "<TR class = 'clsTRGroupHeader' style = 'color:Red'>"
        '        Args.StringToBeInserted += "<td></td><td></td>"
        '        strDate = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Date"), ""), String)
        '        If strDate <> "" Then objDate = CType(strDate, DateTime)
        '        Args.StringToBeInserted += "<td style='width:9%'>" + CommonFunction.Dates.GetDate(objDate) + "</td>"
        '        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("NormalHours"), String), 2) + "</td>"
        '        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("NormalRate"), String), 2) + "</td>"
        '        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("TotalNormalWage"), String), 2) + "</td>"
        '        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("ExtraHours"), String), 2) + "</td>"
        '        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("ExtraRate"), String), 2) + "</td>"
        '        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("TotalExtraWage"), String), 2) + "</td>"
        '        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("TotalBillableHours"), String), 2) + "</td>"
        '        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("TotalBillableWage"), String), 2) + "</td>"
        '        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("NonBillableHours"), String), 2) + "</td>"
        '        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("NonBillableRate"), String), 2) + "</td>"
        '        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("TotalNonBillableWage"), String), 2) + "</td>"
        '        Args.StringToBeInserted += "</TR>"
        '    End If
        'End If

    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        Dim strDisabled As String = ""
        If m_blnTimeSheetReadyForAuth = True Then
            strDisabled = " disabled"
        End If

        If Args.ColumnName = "Site" Then
            Cancel = True
            Args.StringToBeInserted = "<TD style='width=10%'>&nbsp;"
            Args.StringToBeInserted += "<input type='Hidden' name='txtSiteID' id='txtSiteID' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SiteID"), ""), String) + "'>"
            Args.StringToBeInserted += "<input type='Hidden' name='txtSiteName' id='txtSiteName' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SiteName")), String) + "'>"
            Args.StringToBeInserted += "</TD>"
        End If


        If Args.ColumnName = "Resource" Then
            Cancel = True
            Args.StringToBeInserted = "<TD style='width=10%'>&nbsp;"
            Args.StringToBeInserted += "<input type='Hidden' name='txtEmployeeID' id='txtEmployeeID' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), ""), String) + "'>"
            Args.StringToBeInserted += "<input type='Hidden' name='txtEmployeeName' id='txtEmployeeName' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeName")), String) + "'>"
            Args.StringToBeInserted += "</TD>"
        End If
    End Sub

    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        Dim dblNormalHours As Double
        Dim dblNormalWage As Double
        Dim dblExtraHours As Double
        Dim dblExtraWage As Double
        Dim dblBillableHours As Double
        Dim dblBillableNormalWage As Double
        Dim dblNonBillableHours As Double
        Dim dblNonBillableWage As Double

        'Commented And Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
        'dblNormalHours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NormalHours"), "0"), Double)
        'dblNormalWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalNormalWage"), "0"), Double)
        'dblExtraHours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExtraHours"), "0"), Double)
        'dblExtraWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalExtraWage"), "0"), Double)
        'dblBillableHours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalBillableHours"), "0"), Double)
        'dblBillableNormalWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalBillableWage"), "0"), Double)
        'dblNonBillableHours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NonBillableHours"), "0"), Double)
        'dblNonBillableWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalNonBillableWage"), "0"), Double)

        dblNormalHours = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NormalHours"), "0") + "',2)", True)
        dblNormalWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalNormalWage"), "0"), Double)
        dblExtraHours = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExtraHours"), "0") + "',2)", True)
        dblExtraWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalExtraWage"), "0"), Double)
        dblBillableHours = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalBillableHours"), "0") + "',2)", True)
        dblBillableNormalWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalBillableWage"), "0"), Double)
        dblNonBillableHours = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NonBillableHours"), "0") + "',2)", True)
        dblNonBillableWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalNonBillableWage"), "0"), Double)
        'End Of Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format

        m_ResourceNormalHourTotal = m_ResourceNormalHourTotal + dblNormalHours
        m_ResourceNoramlBillingTotal = m_ResourceNoramlBillingTotal + dblNormalWage
        m_ResourceExtraHourTotal = m_ResourceExtraHourTotal + dblExtraHours
        m_ResourceExtraBillingTotal = m_ResourceExtraBillingTotal + dblExtraWage
        m_ResourceTotalBillableHour = m_ResourceTotalBillableHour + dblBillableHours
        m_ResourceTotalBillableWage = m_ResourceTotalBillableWage + dblBillableNormalWage
        m_ResourceTotalNonBillableHour = m_ResourceTotalNonBillableHour + dblNonBillableHours
        m_ResourceTotalNonBillableWage = m_ResourceTotalNonBillableWage + dblNonBillableWage

        m_SiteNormalHourTotal = m_SiteNormalHourTotal + dblNormalHours
        m_SiteNoramlBillingTotal = m_SiteNoramlBillingTotal + dblNormalWage
        m_SiteExtraHourTotal = m_SiteExtraHourTotal + dblExtraHours
        m_SiteExtraBillingTotal = m_SiteExtraBillingTotal + dblExtraWage
        m_SiteTotalBillableHour = m_SiteTotalBillableHour + dblBillableHours
        m_SiteTotalBillableWage = m_SiteTotalBillableWage + dblBillableNormalWage
        m_SiteTotalNonBillableHour = m_SiteTotalNonBillableHour + dblNonBillableHours
        m_SiteTotalNonBillableWage = m_SiteTotalNonBillableWage + dblNonBillableWage

        m_ProjectNormalHourTotal = m_ProjectNormalHourTotal + dblNormalHours
        m_ProjectNoramlBillingTotal = m_ProjectNoramlBillingTotal + dblNormalWage
        m_ProjectExtraHourTotal = m_ProjectExtraHourTotal + dblExtraHours
        m_ProjectExtraBillingTotal = m_ProjectExtraBillingTotal + dblExtraWage
        m_ProjectTotalBillableHour = m_ProjectTotalBillableHour + dblBillableHours
        m_ProjectTotalBillableWage = m_ProjectTotalBillableWage + dblBillableNormalWage
        m_ProjectTotalNonBillableHour = m_ProjectTotalNonBillableHour + dblNonBillableHours
        m_ProjectTotalNonBillableWage = m_ProjectTotalNonBillableWage + dblNonBillableWage

    End Sub


    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint

        'Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format

        'Args.StringToBeInserted = "<TR class='clsTRColumnHeader'>"
        'Args.StringToBeInserted += "<TD colspan=3 align=right title='Resource Total'> Total for Resource:" + m_strEmployee + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceNormalHourTotal, String), 2) + "</td><td></td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceNoramlBillingTotal, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceExtraHourTotal, String), 2) + "</td><td></td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceExtraBillingTotal, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalBillableHour, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalBillableWage, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalNonBillableHour, String), 2) + "</td><td></td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalNonBillableWage, String), 2) + "</td>"
        'Args.StringToBeInserted += "</tr>"

        'Args.StringToBeInserted += "<TR class='clsTRGroupHeader'>"
        'Args.StringToBeInserted += "<TD colspan=3 align=right title='Site Total'> Total for Site:" + m_strSiteNameSubStr + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteNormalHourTotal, String), 2) + "</td><td></td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteNoramlBillingTotal, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteExtraHourTotal, String), 2) + "</td><td></td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteExtraBillingTotal, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalBillableHour, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalBillableWage, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalNonBillableHour, String), 2) + "</td><td></td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalNonBillableWage, String), 2) + "</td>"
        'Args.StringToBeInserted += "</tr>"


        Args.StringToBeInserted = "<TR class='clsTRColumnHeader'>"
        Args.StringToBeInserted += "<TD colspan=3 align=right title='Resource Total'> Total for Resource:" + m_strEmployee + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_ResourceNormalHourTotal, String), 2) + "',1)", True) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceNoramlBillingTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_ResourceExtraHourTotal, String), 2) + "',1)", True) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceExtraBillingTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_ResourceTotalBillableHour, String), 2) + "',1)", True) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalBillableWage, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_ResourceTotalNonBillableHour, String), 2) + "',1)", True) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ResourceTotalNonBillableWage, String), 2) + "</td>"
        Args.StringToBeInserted += "</tr>"

        Args.StringToBeInserted += "<TR class='clsTRGroupHeader'>"
        Args.StringToBeInserted += "<TD colspan=3 align=right title='Site Total'> Total for Site:" + m_strSiteNameSubStr + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_SiteNormalHourTotal, String), 2) + "',1)", True) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteNoramlBillingTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_SiteExtraHourTotal, String), 2) + "',1)", True) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteExtraBillingTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_SiteTotalBillableHour, String), 2) + "',1)", True) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalBillableWage, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(CType(m_SiteTotalNonBillableHour, String), 2) + "',1)", True) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalNonBillableWage, String), 2) + "</td>"
        Args.StringToBeInserted += "</tr>"

        'End Of Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format


        ' Code commented by SwapnilR on 11th Feb 2005
        ' Purpose : Not showing total billing for the given period for given timesheet

        'Args.StringToBeInserted += "<TR class='clsTRSectionHeader'>"
        'Args.StringToBeInserted += "<TD colspan=3 align=right title='Project Total'> Total for Period:</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectNormalHourTotal, String), 2) + "</td><td></td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectNoramlBillingTotal, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectExtraHourTotal, String), 2) + "</td><td></td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectExtraBillingTotal, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectTotalBillableHour, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectTotalBillableWage, String), 2) + "</td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectTotalNonBillableHour, String), 2) + "</td><td></td>"
        'Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectTotalNonBillableWage, String), 2) + "</td>"
        'Args.StringToBeInserted += "</tr>"

        ' End of comment by SwapnilR on 11th Feb 2005

    End Sub

#End Region

    Private Sub m_objGrid_Table_BeforePrint(ByRef Args As WAF_Table) Handles m_objGrid.Table_BeforePrint
        ' Call sp - usp_Ins_tbl_PM_SiteResourceTimeSheet


    End Sub
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If Args.LinkName.ToUpper = "BACK" And strTagID <> "42" Then
            Cancel = True
        End If
        If Args.LinkName.ToUpper = "CLOSE" And strTagID = "42" Then
            Cancel = True
        End If
    End Sub
End Class

