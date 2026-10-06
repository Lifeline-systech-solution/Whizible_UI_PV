#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_SiteResourceTimesheet
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Page Name 	        :	
    ' Purpose				:	
    ' Description			:	
    ' Assumptions			:	
    ' Dependencies			:	
    ' Author				:	
    ' Created				:	
    ' Revisions				:	
    '=====================================================================

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
    Protected m_NormalResourceTotal As Double
    Protected m_ExtraResourceTotal As Double
    Protected m_NonBillableResourceTotal As Double
    Protected m_NormalSiteTotal As Double
    Protected m_ExtraSiteTotal As Double
    Protected m_NonBillableSiteTotal As Double
    Protected m_NormalProjectTotal As Double
    Protected m_ExtraProjectTotal As Double
    Protected m_NonBillableProjectTotal As Double
    'Code Added by DipaliS 8 Oct 2004
    Private m_blnTimeSheetReadyForAuth As Boolean = False
    'End addition by DipaliS
#End Region

#Region "Action Handling"
    Public Sub SaveSiteResourceTimesheet()
        Dim strAction As String
        Dim i As Integer
        Dim strSQL As String
        Dim drSaveSiteResourceTimesheet As IDataReader
        Dim strSiteID As String
        Dim strSiteName As String
        Dim strEmployeeID As String
        Dim strEmployeeName As String
        Dim strDate As String
        Dim strNormalHours As String
        Dim strExtraHours As String
        Dim strNonBillableHours As String

        strAction = CType(Request.QueryString("Action"), String)
        If Request.Form.GetValues("txtSiteID").Length > 0 Then
            For i = 0 To Request.Form.GetValues("txtEmployeeID").Length - 1
                strSiteID = CType(Request.Form.GetValues("txtSiteID")(i), String)
                strSiteName = CType(Request.Form.GetValues("txtSiteName")(i), String)
                strEmployeeID = CType(Request.Form.GetValues("txtEmployeeID")(i), String)
                strEmployeeName = CType(Request.Form.GetValues("txtEmployeeName")(i), String)
                strDate = CType(Request.Form.GetValues("txtDate")(i), String)
                strNormalHours = CType(Request.Form.GetValues("txtNormalHours")(i), String)
                strExtraHours = CType(Request.Form.GetValues("txtExtraHours")(i), String)
                strNonBillableHours = CType(Request.Form.GetValues("txtNonBillableHours")(i), String)

                If strNormalHours = "" Then
                    strNormalHours = "0.00"
                End If
                If strExtraHours = "" Then
                    strExtraHours = "0.00"
                End If
                If strNonBillableHours = "" Then
                    strNonBillableHours = "0.00"
                End If

                strSQL = "usp_Ins_tbl_PM_SiteResourceTimesheet " + CType(m_strTimesheetID, String) + "," + CType(strSiteID, String) + ",'" + CType(strSiteName, String) + "'," + CType(strEmployeeID, String) + ",'" + CType(strEmployeeName, String) + "','" + CType(strDate, String) + "'," + CType(strNormalHours, String) + "," + CType(strExtraHours, String) + "," + CType(strNonBillableHours, String)
                drSaveSiteResourceTimesheet = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                CommonFunctions.Data.DisposeDataReader(drSaveSiteResourceTimesheet)
            Next

        End If
    End Sub
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

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

        Dim arrClientSideFunction() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick()"}

        Dim strGrid As String

        'cerate the static menu.
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

        'This will initialize all the global objects.
        GetGlobalObject()

        'Code Added by DipaliS 8 Oct 2004
        Dim strReadyToAuthenticate As String
        'strReadyToAuthenticate = CommonFunction.Data.GetDataScalar("Select ISNULL(ReadyToAuthenticate,'') FROM tbl_PM_TimeSheetInvoice WHERE TimeSheetNo= " + CType(Request.QueryString("TimesheetID"), String), MyBase.UseSQL)

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strReadyToAuthenticate = CommonFunction.Data.GetDataScalar("Select ISNULL(ReadyToAuthenticate,'') FROM tbl_PM_TimeSheetInvoice WHERE TimeSheetNo= " + CType(Request.QueryString("TimesheetID"), String), MyBase.UseSQL).ToString
        strReadyToAuthenticate = CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_ReadyToAuthenticate " + CType(Request.QueryString("TimesheetID"), String), MyBase.UseSQL).ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        If strReadyToAuthenticate.ToUpper = "Y" Then
            m_blnTimeSheetReadyForAuth = True
        End If
        'End addition by DipaliS
        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'Display the page caption.
        DrawPageCaption()

        '##### Getting the values from the querystring or session

        m_strTimesheetID = CType(Request.QueryString("TimesheetID"), String)

        m_strProjectID = CType(Session("intProjectID"), String)


        m_NormalResourceTotal = 0
        m_ExtraResourceTotal = 0
        m_NonBillableResourceTotal = 0

        m_NormalSiteTotal = 0
        m_ExtraSiteTotal = 0
        m_NonBillableSiteTotal = 0

        m_NormalProjectTotal = 0
        m_ExtraProjectTotal = 0
        m_NonBillableProjectTotal = 0
        '##### End

        If Request.QueryString("Action") = "Save" Then
            SaveSiteResourceTimesheet()
        End If

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
        CommonFunctions.General.WriteHTML("<td align='left'>" + MyBase.GetResourceString("SITE") + "&nbsp;")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''CommonFunctions.HTMLControls.DrawComboBox("cboSite", "Select ProjectSiteID,Name from tbl_PM_ProjectSites Where ProjectID=" + CType(m_strProjectID, String), , CType(strFilterSiteID, String), "onChange=ApplySiteFilter();", True)
        CommonFunctions.HTMLControls.DrawComboBox("cboSite", "usp_sel_tbl_PM_ProjectSites_ProjectSiteID_Name " + CType(m_strProjectID, String), , CType(strFilterSiteID, String), "onChange=ApplySiteFilter();", True)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.General.WriteHTML("</td>")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQL = "Select Distinct tbl_PM_EmployeeSiteDetails.EmployeeID,tbl_PM_Employee.EmployeeName FROM tbl_PM_EmployeeSiteDetails, tbl_PM_Employee WHERE tbl_PM_Employee.EmployeeID = tbl_PM_EmployeeSiteDetails.EmployeeID AND tbl_PM_EmployeeSiteDetails.ProjectID = " + CType(m_strProjectID, String)
        strSQL = "usp_sel_tbl_PM_EmployeeSiteDetails_EmployeeID_EmployeeName " + CType(m_strProjectID, String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.General.WriteHTML("<td align='left'><B>" + MyBase.GetResourceString("RESOURCE") + "&nbsp;")
        CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strSQL, , strFilterEmployeeID, "onChange=ApplyEmployeeFilter()", True)
        CommonFunctions.General.WriteHTML("</B></td>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub


    Public Sub PlotPeriodHeader()
        Dim strStartDate As String
        Dim strEndDate As String
        Dim strSQL As String
        Dim drGetTimesheetPeriod As IDataReader
        Dim strProjectName As String
        Dim strFromDate As String
        Dim strToDate As String

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT tbl_PM_TimesheetInvoice.TimesheetNo, tbl_PM_TimesheetInvoice.FromDate, tbl_PM_TimesheetInvoice.ToDate, tbl_PM_Project.ProjectName FROM tbl_PM_TimesheetInvoice, tbl_PM_Project WHERE tbl_PM_TimesheetInvoice.ProjectID = tbl_PM_Project.ProjectID AND TimesheetNo = " + CType(m_strTimesheetID, String)
        strSQL = "usp_sel_tbl_PM_TimesheetInvoice_TimesheetNo " + CType(m_strTimesheetID, String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        drGetTimesheetPeriod = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drGetTimesheetPeriod.Read Then
            strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(drGetTimesheetPeriod("ProjectName"), ""), String)
            strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(drGetTimesheetPeriod("FromDate"), ""), String)
            strToDate = CType(CommonFunctions.Data.CheckIsDBNull(drGetTimesheetPeriod("ToDate"), ""), String)
        End If
        CommonFunctions.General.WriteHTML("<TABLE cellspacing='0' cellpadding='0' Width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRPageHeader'>")
        'To Do: Get dates
        CommonFunctions.General.WriteHTML("<td height='22' align='left'><B>" + MyBase.GetResourceString("PROJECT") + strProjectName + "&nbsp;&nbsp;</B></td>")
        CommonFunctions.General.WriteHTML("<td height='22' align='right'><B>" + MyBase.GetResourceString("PERIOD") + CommonFunctions.Dates.GetDate(CType(strFromDate, Date)) + "&nbsp;" + MyBase.GetResourceString("TO") + "&nbsp;" + CommonFunctions.Dates.GetDate(CType(strToDate, Date)) + "</B></td>")
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
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
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
        ' Author                : AmitD
        ' Created               : Sep 22,20004
        ' Revisions             :
        '=====================================================================


        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrGroupColumnNames As New ArrayList        'To store grouping column names
        Dim strSQL As String
        Dim strFilterSiteID As String
        Dim strFilterEmployeeID As String

        'To store the link details while clicking on Links in grid
        'Dim arrWidthArray() As String = {"", "style='width:25%' align='left'", "style='width:8%' align='left'", "style='width:10%' align='left'", "style='width:10%' align='right'", "style='width:10%' align='right'", "style='width:28%' align='center'"}
        'Changed by DipaliS 7 Oct 2004 Added one more value in array for Total Hours
        Dim arrWidthArray() As String = {"style='width:15%'", "style='width:15%'", "style='width:15%' align='right'", "style='width:20%' align='center'", "style='width:20%' align='center'", "style='width:20%' align='center'", "style='width:20%' align='center'"}
        Dim arrColRowLinks() As String = {"", "", "", "", "", ""}
        Dim arrAlignment() As String = {"left", "left", "right", "center", "center", "center"}


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

        strSQL = "Exec usp_Sel_GetSiteResourceTimesheet " + CType(m_strProjectID, String) + "," + CType(m_strTimesheetID, String) + "," + CType(strFilterSiteID, String) + "," + CType(strFilterEmployeeID, String)

        'CommonFunctions.General.WriteHTML("<br><DIV id='DivProjectTasksList' style='Overflow:auto;width=100%;Height:540'>")

        '##### Get Column Headings from Resources 
        arrColumnHeadingList.Add(MyBase.GetResourceString("SITE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("RESOURCE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("DATE"))
        'Code Added by DipaliS 6 oct 2004
        arrColumnHeadingList.Add(MyBase.GetResourceString("TOTALBILLABLE"))
        'End addition by DipaliS
        arrColumnHeadingList.Add(MyBase.GetResourceString("NORMAL_EFFORTS"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("EXTRA_EFFORTS"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("NONBILLABLE_EFFORTS"))
        '##### End 

        '##### Actual Column Names List
        arrActualColumnNames.Add("Name")
        arrActualColumnNames.Add("EmployeeName")
        arrActualColumnNames.Add("")
        'Commented by DipaliS 8 Oct 2004 to display the date is format
        arrActualColumnNames.Add("Date")
        'End addition by DipaliS
        arrActualColumnNames.Add("NormalHours")
        arrActualColumnNames.Add("ExtraHours")
        arrActualColumnNames.Add("NonBillableHours")
        '##### End

        '##### Grouping column names list
        ' arrGroupColumnNames.Add("Name")
        ' arrGroupColumnNames.Add("EmployeeName")
        '##### End 

        Dim arrIgnoreHTMLEncode() As String = {"0"}


        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 6
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 540
            .SQL = strSQL
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .GroupOnColumn = GetArray(arrGroupColumnNames)
            '.ColumnHeaderAlignment = arrAlignment
            '.FooterHTML = sbFooterHTML.ToString
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()

        End With
        m_objGrid = Nothing

        'CommonFunction.General.WriteHTML("</div>")




        'CommonFunctions.General.WriteHTML("<BR>")
        'CommonFunctions.General.WriteHTML("<TABLE class='clsTable'cellpadding=0 cellspacing=0 width='100%'>")
        'CommonFunctions.General.WriteHTML("<TR class='clsTRSectionHeader'>")
        'CommonFunctions.General.WriteHTML("<TD colspan=3 align=right title='Project Total'>" + MyBase.GetResourceString("TOTAL_PERIOD") + "</td>")
        'CommonFunctions.General.WriteHTML("<td align='right' style='width:20%'>" + CType(m_NormalProjectTotal, String) + "</td>")
        'CommonFunctions.General.WriteHTML("<td align='right' style='width:20%'>" + CType(m_ExtraProjectTotal, String) + "</td>")
        'CommonFunctions.General.WriteHTML("<td align='right' style='width:20%'>" + CType(m_NormalProjectTotal, String) + "</td>")
        'CommonFunctions.General.WriteHTML("</tr>")
        'CommonFunctions.General.WriteHTML("</TABLE>")


    End Sub
#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.PM_SiteResourceTimesheet", "AppResources")
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

        strPrevSiteName = Args.DataReader("Name").ToString

        If m_strSiteName <> Args.DataReader("Name").ToString.Trim Then
            strPrevSiteName = ""
            If CType(m_strSiteName, String) <> "" Then
                If CType(m_strEmployeeName, String) <> "" Then
                    Args.StringToBeInserted = "<TR class='clsTRColumnHeader'>"
                    'Changed by DipaliS
                    'Args.StringToBeInserted += "<TD colspan=3 align=right title='Resource Total'>" + MyBase.GetResourceString("TOTAL_RESOURCE") + CType(m_strEmployeeName, String) + "</td>"
                    Args.StringToBeInserted += "<TD colspan=4 align=right title='Resource Total'>" + MyBase.GetResourceString("TOTAL_RESOURCE") + CType(m_strEmployeeName, String) + "</td>"
                    Args.StringToBeInserted += "<td align='right' style='width:15% align=right'>" + FormatNumber(CType(m_NormalResourceTotal, String), 2) + "</td>"
                    Args.StringToBeInserted += "<td align='right' style='width:15% align=right'>" + FormatNumber(CType(m_ExtraResourceTotal, String), 2) + "</td>"
                    Args.StringToBeInserted += "<td align='right' style='width:15% align=right'>" + FormatNumber(CType(m_NonBillableResourceTotal, String), 2) + "</td>"
                    Args.StringToBeInserted += "</tr>"
                    m_NormalResourceTotal = 0
                    m_ExtraResourceTotal = 0
                    m_NonBillableResourceTotal = 0
                End If

                Args.StringToBeInserted += "<TR class='clsTRGroupHeader'>"
                'Changed by DipaliS 
                'Args.StringToBeInserted += "<TD colspan=3 align=right title='Site Total'>" + MyBase.GetResourceString("TOTAL_SITE") + CType(m_strSiteName, String) + "</td>"
                Args.StringToBeInserted += "<TD colspan=4 align=right title='Site Total'>" + MyBase.GetResourceString("TOTAL_SITE") + CType(m_strSiteName, String) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:20%'>" + FormatNumber(CType(m_NormalSiteTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:20%'>" + FormatNumber(CType(m_ExtraSiteTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:15%'>" + FormatNumber(CType(m_NonBillableSiteTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "</tr>"
                m_NormalSiteTotal = 0
                m_ExtraSiteTotal = 0
                m_NonBillableSiteTotal = 0
            End If

            m_strSiteName = Args.DataReader("Name").ToString + ""
            'Added by DipaliS
            Dim dblWorkingHours As String = ""
            Dim dblExtra As String = ""
            Dim strSQL As String
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT IsNull(WorkHrs,0) as 'WorkHrs',IsNull(ExtraHoursCap,0) as 'ExtraHoursCap' From tbl_PM_ProjectSites WHERE ProjectID=" + m_strProjectID + " AND ProjectSiteID=" + Args.DataReader("SiteID").ToString
            strSQL = "usp_sel_tbl_PM_ProjectSites_WorkHrs_ExtraHoursCap " + m_strProjectID + "," + Args.DataReader("SiteID").ToString
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Dim drSite As IDataReader
            drSite = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drSite.Read Then
                dblWorkingHours = CType(drSite.Item("WorkHrs"), String)
                dblExtra = CType(drSite.Item("ExtraHoursCap"),String)
            End If
            dblWorkingHours = FormatNumber(dblWorkingHours.ToString, 2)
            dblExtra = FormatNumber(dblExtra.ToString, 2)

            CommonFunction.Data.DisposeDataReader(drSite)
            'End addition by DipaliS
            'Changed by DipaliS
            'Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=6>" + CType(Args.DataReader("Name"), String) + "</TD></TR>"
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=7>" + CType(Args.DataReader("Name"), String) + "    (" + MyBase.GetResourceString("WORKHOURS") + " : " + dblWorkingHours + "    " + MyBase.GetResourceString("EXTRAHOURS") + " : " + dblExtra + ")</TD></TR>"
        End If


        If m_strEmployeeName <> Args.DataReader("EmployeeName").ToString.Trim Then
            If m_strEmployeeName <> "" And strPrevSiteName <> "" And strPrevSiteName = m_strSiteName Then
                Args.StringToBeInserted += "<TR class='clsTRColumnHeader'>"
                'Changed by DipaliS
                'Args.StringToBeInserted += "<TD colspan=3 align=right title='Resource Total'>" + MyBase.GetResourceString("TOTAL_RESOURCE") + CType(m_strEmployeeName, String) + "</td>"
                Args.StringToBeInserted += "<TD colspan=4 align=right title='Resource Total'>" + MyBase.GetResourceString("TOTAL_RESOURCE") + CType(m_strEmployeeName, String) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:15%'>" + FormatNumber(CType(m_NormalResourceTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:15%'>" + FormatNumber(CType(m_ExtraResourceTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "<td align='right' style='width:15%'>" + FormatNumber(CType(m_NonBillableResourceTotal, String), 2) + "</td>"
                Args.StringToBeInserted += "</tr>"
                m_NormalResourceTotal = 0
                m_ExtraResourceTotal = 0
                m_NonBillableResourceTotal = 0

            End If
            m_strEmployeeName = Args.DataReader("EmployeeName").ToString + ""
            'Changed by DipaliS
            'Args.StringToBeInserted += "<TR class='clsTRGroupHeader' ><TD style='width=15%'></TD><TD align='left' colspan=4>" + CType(m_strEmployeeName, String) + "</TD></TD><TD align=right width=15%></TD></TR>"
            Args.StringToBeInserted += "<TR class='clsTRGroupHeader' ><TD style='width=15%'></TD><TD align='left' colspan=5>" + CType(m_strEmployeeName, String) + "</TD></TD><TD align=right width=15%></TD></TR>"
        End If


    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        'Code Added by DipaliS 8 Oct 2004
        Dim strDisabled As String = ""
        If m_blnTimeSheetReadyForAuth = True Then
            strDisabled = " disabled"
        End If
        'End addition by DipaliS
        If Args.ColumnName = "Site" Then
            Cancel = True
            Args.StringToBeInserted = "<TD style='width=15%'>&nbsp;"
            Args.StringToBeInserted += "<input type='Hidden' name='txtSiteID' id='txtSiteID' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SiteID"), ""), String) + "'>"
            Args.StringToBeInserted += "<input type='Hidden' name='txtSiteName' id='txtSiteName' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Name")), String) + "'>"
            Args.StringToBeInserted += "</TD>"
        End If


        If Args.ColumnName = "Employee Name" Then
            Cancel = True
            Args.StringToBeInserted = "<TD style='width=20%'>&nbsp;"
            Args.StringToBeInserted += "<input type='Hidden' name='txtEmployeeID' id='txtEmployeeID' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), ""), String) + "'>"
            Args.StringToBeInserted += "<input type='Hidden' name='txtEmployeeName' id='txtEmployeeName' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeName")), String) + "'>"
            Args.StringToBeInserted += "</TD>"
        End If

        If Args.ColumnName = "Date" Then
            'Code Added by DipaliS 8 Oct 2004
            'Purpose    :   To display the date in correct format

            Cancel = True
            Args.StringToBeInserted = "<td align='right' style='width:10%'>" + CommonFunction.Dates.CGetDate(CType(Args.DataReader("Date"), Date)) + "</td>"
            'end addition
            Args.StringToBeInserted += "<input type='hidden' name='txtDate' id='txtDate' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Date")), String) + "'>"
        End If

        'Added the strDisabled value and number formatting by DipaliS 
        If Args.ColumnName = "Normal Efforts (hrs)" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='right' style='width:20%'><input class='clsTextBox' name='txtNormalHours' id='txtNormalHours' size='6' " + strDisabled + " Style='text-align:right' value='" + FormatNumber(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NormalHours"), ""), String), 2) + "' onkeypress='Javascript:OnlyNumeric(1)'></td>"
        End If

        'Added the strDisabled value and number formatting by DipaliS
        If Args.ColumnName = "Extra Efforts (hrs)" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='right' style='width:20%'><input class='clsTextBox' name='txtExtraHours' id='txtExtraHours' size='6' size='6' " + strDisabled + " Style='text-align:right' value='" + FormatNumber(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExtraHours"), ""), String), 2) + "' onkeypress='Javascript:OnlyNumeric(1)'></td>"
        End If

        'Added the strDisabled value and number formatting by DipaliS
        If Args.ColumnName = "Non Billable Efforts (hrs)" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='right' style='width:20%'><input class='clsTextBox' name='txtNonBillableHours' id='txtNonBillableHours' size='6' " + strDisabled + " Style='text-align:right' value='" + FormatNumber(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NonBillableHours"), ""), String), 2) + "' onkeypress='Javascript:OnlyNumeric(1)'></td>"
        End If
        'Code Added by DipaliS 6 Oct 2004
        'Purpose: For the validation of the total with actual hours in timesheet
        If Args.ColumnName.ToUpper = MyBase.GetResourceString("TOTALBILLABLE").ToUpper Then
            'Get the total hours for the resource
            Cancel = True
            Dim dblTotalHours As String
            dblTotalHours = CommonFunction.Data.GetDataScalar("usp_sel_TimeSheet_Employee_Total " + m_strTimesheetID.ToString + ",'" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectName")), String) + "'," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), ""), String) + ",'" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Date")), String) + "'", MyBase.UseSQL).ToString
            dblTotalHours = FormatNumber(dblTotalHours, 2)
            'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Args.StringToBeInserted = "<td align='right' style='width:20%'>" + CommonFunction.HTMLControls.DrawTextBox("txtTotal", "txtTotal", , 50, , dblTotalHours, "right", , True, , , False, , True, EnableHTMLEncode:=True) + "</td>"
            'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            'End addition by DipaliS
        End If


    End Sub


    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        Dim dblNormalHours As Double
        Dim dblExtraHours As Double
        Dim dblNonBillableHours As Double

        dblNormalHours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NormalHours"), "0"), Double)
        dblExtraHours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExtraHours"), "0"), Double)
        dblNonBillableHours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NonBillableHours"), "0"), Double)

        m_NormalResourceTotal = m_NormalResourceTotal + dblNormalHours
        m_ExtraResourceTotal = m_ExtraResourceTotal + dblExtraHours
        m_NonBillableResourceTotal = m_NonBillableResourceTotal + dblNonBillableHours


        m_NormalSiteTotal = m_NormalSiteTotal + dblNormalHours
        m_ExtraSiteTotal = m_ExtraSiteTotal + dblExtraHours
        m_NonBillableSiteTotal = m_NonBillableSiteTotal + dblNonBillableHours


        m_NormalProjectTotal = m_NormalProjectTotal + dblNormalHours
        m_ExtraProjectTotal = m_ExtraProjectTotal + dblExtraHours
        m_NonBillableProjectTotal = m_NonBillableProjectTotal + dblNonBillableHours
    End Sub


    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint
        Args.StringToBeInserted = "<TR class='clsTRColumnHeader'>"
        'Chnaged by DipaliS
        'Args.StringToBeInserted += "<TD colspan=3 align=right title='Resource Total'>" + MyBase.GetResourceString("TOTAL_RESOURCE") + CType(m_strEmployeeName, String) + "</td>"
        Args.StringToBeInserted += "<TD colspan=4 align=right title='Resource Total'>" + MyBase.GetResourceString("TOTAL_RESOURCE") + CType(m_strEmployeeName, String) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:15%'>" + FormatNumber(CType(m_NormalResourceTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:15%'>" + FormatNumber(CType(m_ExtraResourceTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:15%'>" + FormatNumber(CType(m_NonBillableResourceTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "</tr>"
        Args.StringToBeInserted += "<TR class='clsTRGroupHeader'>"
        'Changed by DipaliS
        'Args.StringToBeInserted += "<TD colspan=3 align=right title='Site Total'>" + MyBase.GetResourceString("TOTAL_SITE") + CType(m_strSiteName, String) + "</td>"
        Args.StringToBeInserted += "<TD colspan=4 align=right title='Site Total'>" + MyBase.GetResourceString("TOTAL_SITE") + CType(m_strSiteName, String) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:20%'>" + FormatNumber(CType(m_NormalSiteTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:20%'>" + FormatNumber(CType(m_ExtraSiteTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:15%'>" + FormatNumber(CType(m_NonBillableSiteTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "</tr>"
        Args.StringToBeInserted += "<TR class='clsTRSectionHeader'>"
        'Changed by DipaliS
        'Args.StringToBeInserted += "<TD colspan=3 align=right title='Project Total'>" + MyBase.GetResourceString("TOTAL_PERIOD") + "</td>"
        Args.StringToBeInserted += "<TD colspan=4 align=right title='Project Total'>" + MyBase.GetResourceString("TOTAL_PERIOD") + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:20%'>" + FormatNumber(CType(m_NormalProjectTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:20%'>" + FormatNumber(CType(m_ExtraProjectTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "<td align='right' style='width:20%'>" + FormatNumber(CType(m_NonBillableProjectTotal, String), 2) + "</td>"
        Args.StringToBeInserted += "</tr>"


    End Sub
#End Region


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        'Code Added by DipaliS 7 Oct 2004
        'Purpose : When the TimeSheet is authenticated, do not show the save link
        'For this check for ReadyToAuthenticate flag in tbl_PM_TimeSheetInvoice for the TimeSheetNo
        If Args.LinkName.ToUpper = MyBase.GetResourceString("MENU_SAVE").ToUpper Then
            If m_blnTimeSheetReadyForAuth = True Then
                Cancel = True
            End If
        End If
        'End addition by DipaliS
    End Sub
End Class
