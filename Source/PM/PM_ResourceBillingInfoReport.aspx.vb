

#Region "Imports"

Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data

#End Region



Public Class PM_ResourceBillingInfoReport
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
    Protected m_strEmployeeName As String
    Protected m_strSiteName As String
    Protected m_strProjectID As String
    Private m_blnTimeSheetReadyForAuth As Boolean = False

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

    Protected strTokenID As String
    Protected strTagID As String
    Protected strParentTagID As String
    Protected strUserID As String

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

        Dim arrMenu() As String = {MyBase.GetResourceString("BACK"), MyBase.GetResourceString("MENU_HELP")}

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("BACK_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

        Dim arrClientSideFunction() As String = {"Back_Onclick()", "Help_OnClick()"}

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

        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_1")))
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
        Dim drProjectID As IDataReader
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

            'm_strTimesheetID = "1"

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT Distinct(ProjectID) FROM tbl_PM_TimeSheet WHERE TimeSheetNo = " + CType(m_strTimesheetID, String)
            strSQL = "usp_sel_tbl_PM_TimeSheet_ProjectID " + CType(m_strTimesheetID, String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            drProjectID = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drProjectID.Read Then
                m_strProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drProjectID("ProjectID"), ""), String)
            End If

            'm_strProjectID = CType(Session("intProjectID"), String)


            'Comments Added By VivekP For WhizibleSEm SP4 -IssueID : 176

            'strSQL = " Exec usp_Ins_tbl_PM_SiteResourceTimeSheet " + m_strProjectID + " , " + m_strTimesheetID
            'drIsHoliday = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            'drIsHoliday.Close()
            'drIsHoliday = Nothing

            'End Of Addition By VivekP For WhizibleSEm SP4 -IssueID : 176

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

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "Select Distinct EmployeeID, EmployeeName FROM tbl_PM_SiteResourceTimeSheet WHERE TimeSheetID = " + CType(m_strTimesheetID, String)
        strSQL = "usp_sel_tbl_PM_SiteResourceTimeSheet_EmployeeID_EmployeeName " + CType(m_strTimesheetID, String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

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
        'strSQL = "SELECT tbl_PM_TimesheetInvoice.TimesheetNo, tbl_PM_TimesheetInvoice.FromDate, tbl_PM_TimesheetInvoice.ToDate, tbl_PM_Project.ProjectName FROM tbl_PM_TimesheetInvoice, tbl_PM_Project WHERE tbl_PM_TimesheetInvoice.ProjectID = tbl_PM_Project.ProjectID AND TimesheetNo = " + CType(m_strTimesheetID, String)
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

        Dim arrWidthArray() As String = {"style='width:12%' align='center'", "style='width:12%' align='center'", "style='width:12%' align='center'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:10%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'", "style='width:9%' align='right'"}

        Dim arrColRowLinks() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""}

        Dim arrAlignment() As String = {"left", "left", "right", "center", "center", "center", "center", "center", "center", "center", "center", "center", "center"}

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

        strSQL = "Exec usp_CSP_ProjectResourceWageReport  " + m_strTimesheetID

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
        arrColumnHeadingList.Add(MyBase.GetResourceString("ROLE"))
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
        arrColumnHeadingList.Add(MyBase.GetResourceString("ISHOLIDAY"))


        '##### End 

        '##### Actual Column Names List
        arrActualColumnNames.Add("SiteName")
        arrActualColumnNames.Add("EmployeeName")
        arrActualColumnNames.Add("Role")
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
        arrActualColumnNames.Add("IsHoliday")
        '##### End
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 15
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 540
            .SQL = strSQL
            .UseSQL = True
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
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
        Dim strHolidayStatus As String
        Dim blnIsHoliday As Boolean

        strPrevSiteName = Args.DataReader("SiteName").ToString

        If m_strSiteName <> Args.DataReader("SiteName").ToString.Trim Then
            strPrevSiteName = ""
            If CType(m_strSiteName, String) <> "" Then

                Args.StringToBeInserted += "<TR class='clsTRGroupHeader'>"
                Args.StringToBeInserted += "<TD colspan=3 align=right title='Site Total'>" + "Total for Site " + CType(m_strSiteName, String) + "</td>"

                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteNormalHourTotal, String), 2) + "</td><td></td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteNoramlBillingTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteExtraHourTotal, String), 2) + "</td><td></td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteExtraBillingTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalBillableHour, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalBillableWage, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalNonBillableHour, String), 2) + "</td><td></td>"
                Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalNonBillableWage, String), 2) + "</td><td></td>"

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
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=15>" + CType(Args.DataReader("SiteName"), String)
        End If

        blnIsHoliday = CType(Args.DataReader("IsHoliday"), Boolean)
        ' Printing in red code 
        If blnIsHoliday = True Then
            Cancel = True
            Args.StringToBeInserted += "<TR class = 'clsTRGroupHeader' style = 'color:Red'>"
            Args.StringToBeInserted += "<td></td>"
            Args.StringToBeInserted += "<td style='width:9%'>" + CType(Args.DataReader("EmployeeName"), String) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + CType(Args.DataReader("Role"), String) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("NormalHours"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("NormalRate"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("TotalNormalWage"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("ExtraHours"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("ExtraRate"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("TotalExtraWage"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("TotalBillableHours"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("TotalBillableWage"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("NonBillableHours"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("NonBillableRate"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(Args.DataReader("TotalNonBillableWage"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' style='width:5% align=right'> Yes </td>"
            Args.StringToBeInserted += "</TR>"
        End If
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

        dblNormalHours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NormalHours"), "0"), Double)
        dblNormalWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalNormalWage"), "0"), Double)
        dblExtraHours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExtraHours"), "0"), Double)
        dblExtraWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalExtraWage"), "0"), Double)
        dblBillableHours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalBillableHours"), "0"), Double)
        dblBillableNormalWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalBillableWage"), "0"), Double)
        dblNonBillableHours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NonBillableHours"), "0"), Double)
        dblNonBillableWage = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalNonBillableWage"), "0"), Double)

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

        Args.StringToBeInserted += "<TR class='clsTRGroupHeader'>"
        Args.StringToBeInserted += "<TD colspan=3 align=right title='Site Total'> Total for Site:" + m_strSiteNameSubStr + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteNormalHourTotal, String), 2) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteNoramlBillingTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteExtraHourTotal, String), 2) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteExtraBillingTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalBillableHour, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalBillableWage, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalNonBillableHour, String), 2) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_SiteTotalNonBillableWage, String), 2) + "</td><td></td>"
        Args.StringToBeInserted += "</tr>"

        Args.StringToBeInserted += "<TR class='clsTRSectionHeader'>"
        Args.StringToBeInserted += "<TD colspan=3 align=right title='Project Total'> Total for Period:</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectNormalHourTotal, String), 2) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectNoramlBillingTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectExtraHourTotal, String), 2) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectExtraBillingTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectTotalBillableHour, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectTotalBillableWage, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectTotalNonBillableHour, String), 2) + "</td><td></td>"
        Args.StringToBeInserted += "<td align='right' style='width:5% align=right'>" + FormatNumber(CType(m_ProjectTotalNonBillableWage, String), 2) + "</td><td></td>"
        Args.StringToBeInserted += "</tr>"


    End Sub

#End Region
End Class

