#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_DeliverablePercentProgress
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
    Protected m_strDeliverableType As String
    Protected m_strDepartmet As String
    Protected m_strProjectID As String
    Protected m_strFromDate As String
    Protected m_strToDate As String
    Protected m_strFreeze As String
    Protected m_strFreeseDisable As String

    Protected m_dblDepartmentEffords As Double
    Protected m_dblProjectEffords As Double
    Protected m_dblDepartmentCalcPercent As Double
    Protected m_dblProjectCalcPercent As Double

#End Region

#Region "Action Handling"
    Public Sub SavePercentProgress()
        Dim strAction As String
        Dim i As Integer
        Dim strSQL As String
        Dim drPercentProgress As IDataReader
        Dim strDeliverableID As String
        Dim strActualEffords As String
        Dim strCalculatedPercent As String
        Dim strPercentEntered As String
        Dim objDr As IDataReader

        strSQL = "DELETE FROM tbl_PM_DeliverableProgress Where ProjectID = " + m_strProjectID + "AND FromDate = '" + m_strFromDate + "' AND ToDate = '" + m_strToDate + "'"
        objDr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        CommonFunctions.Data.DisposeDataReader(objDr)

        strSQL = ""

        strAction = CType(Request.QueryString("Action"), String)
        If Request.Form.GetValues("DeliverableID").Length > 0 Then
            For i = 0 To Request.Form.GetValues("DeliverableID").Length - 1

                Dim intDeliverableID As Integer
                Dim dblActualEffords As Double
                Dim dblCalculatedPercent As Double
                Dim dblPercentEntered As Double


                strDeliverableID = CType(Request.Form.GetValues("DeliverableID")(i), String)
                strActualEffords = CType(Request.Form.GetValues("ActualEfforts")(i), String)
                strCalculatedPercent = CType(Request.Form.GetValues("CalculatedPercent")(i), String)
                strPercentEntered = CType(Request.Form.GetValues("txtEnteredPercent")(i), String)


                intDeliverableID = CType(strDeliverableID, Integer)
                dblActualEffords = CType(strActualEffords, Double)
                dblCalculatedPercent = CType(strCalculatedPercent, Double)
                dblPercentEntered = CType(strPercentEntered, Double)

                strDeliverableID = CType(intDeliverableID, String)
                strActualEffords = CType(dblActualEffords, String)
                strCalculatedPercent = CType(dblCalculatedPercent, String)
                strPercentEntered = CType(dblPercentEntered, String)

                If strActualEffords = "" Then
                    strActualEffords = "0.00"
                End If
                If strCalculatedPercent = "" Then
                    strCalculatedPercent = "0.00"
                End If
                If strPercentEntered = "" Then
                    strPercentEntered = "0.00"
                End If

                strSQL = "usp_Ins_tbl_PM_DeliverableProgress '" + m_strFromDate + "','" + m_strToDate + "'," + m_strProjectID + "," + strDeliverableID + "," + strActualEffords + "," + strCalculatedPercent + "," + strPercentEntered
                drPercentProgress = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                CommonFunctions.Data.DisposeDataReader(drPercentProgress)
            Next

        End If
    End Sub
    Public Sub FreezePercentProgress()

        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strSQLCheck As String
        Dim objDrDataCheck As IDataReader

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQLCheck = "SELECT * FROM tbl_PM_DeliverableProgress Where ProjectID = " + m_strProjectID + "AND FromDate = '" + m_strFromDate + "' AND ToDate = '" + m_strToDate + "'"
        strSQLCheck = "usp_sel_tbl_PM_DeliverableProgress_FromDate_ToDate " + m_strProjectID + ",'" + m_strFromDate + "','" + m_strToDate + "'"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        objDrDataCheck = CommonFunction.Data.GetDataReader(strSQLCheck, MyBase.UseSQL)
        If objDrDataCheck.Read Then
        Else
            SavePercentProgress()
        End If

        strSQL = "Update tbl_PM_DeliverableProgress SET Freezed = 1 Where ProjectID = " + m_strProjectID + "AND FromDate = '" + m_strFromDate + "' AND ToDate = '" + m_strToDate + "'"
        objDr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        CommonFunctions.Data.DisposeDataReader(objDr)

        CommonFunction.Data.DisposeDataReader(objDrDataCheck)


        

    End Sub

    Public Sub RegeneratePercentProgress()
        Dim strSQL As String
        Dim objDr As IDataReader

        strSQL = "DELETE FROM tbl_PM_DeliverableProgress Where ProjectID = " + m_strProjectID + "AND FromDate = '" + m_strFromDate + "' AND ToDate = '" + m_strToDate + "'"
        objDr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        CommonFunctions.Data.DisposeDataReader(objDr)
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

        Dim arrMenu() As String = {MyBase.GetResourceString("SAVE"), MyBase.GetResourceString("REGENERATE"), MyBase.GetResourceString("APPROVE"), MyBase.GetResourceString("BACK")}

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("SAVE"), MyBase.GetResourceString("REGENERATE"), MyBase.GetResourceString("APPROVE"), MyBase.GetResourceString("BACK")}

        Dim arrClientSideFunction() As String = {"Save_OnClick()", "Regenerate_OnClick()", "Freeze_OnClick()", "Back_Onclick()"}

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

        'm_strProjectID = "1"
        'm_strFromDate = "1-Jan-2005"
        'm_strToDate = "30-Apr-2005"

        m_strProjectID = CType(Session("intProjectID"), String)
        m_strFromDate = (CType(Request.QueryString("FromDate"), String))
        m_strToDate = CType(Request.QueryString("ToDate"), String)

        If Request.QueryString("Action") = "Save" Then
            SavePercentProgress()
        End If

        If Request.QueryString("Action") = "Regenerate" Then
            RegeneratePercentProgress()
        End If

        If Request.QueryString("Action") = "Freeze" Then
            FreezePercentProgress()
        End If

        'This will initialize all the global objects.
        GetGlobalObject()
        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'Display the page caption.
        DrawPageCaption()

        '##### Getting the values from the querystring or session


        '##### End


        Dim strSQL As String
        Dim objDr As IDataReader

        m_strFreeze = "Y"
        strSQL = "Exec usp_Sel_CheckDeliverableFreezed " + CType(m_strProjectID, String) + ",'" + CType(m_strFromDate, String) + "','" + CType(m_strToDate, String) + "'"
        objDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            m_strFreeze = CType(objDr("Freezed"), String)
        End If
        If m_strFreeze.ToUpper = "Y" Then
            m_strFreeseDisable = " disabled"
        Else
            m_strFreeseDisable = " "
        End If
        CommonFunction.Data.DisposeDataReader(objDr)

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
        Dim strFilterDepartmentID As String
        Dim strFilterDeliverableTypeID As String
        Dim strSQL As String

        If CType(Request.Form("cboDepartment"), String) <> "" Then
            strFilterDepartmentID = CType(Request.Form("cboDepartment"), String)
        Else
            strFilterDepartmentID = ""
        End If

        If CType(Request.Form("cboDeliverableType"), String) <> "" Then
            strFilterDeliverableTypeID = CType(Request.Form("cboDeliverableType"), String)
        Else
            strFilterDeliverableTypeID = ""
        End If

        CommonFunctions.General.WriteHTML("<TABLE cellspacing='0' cellpadding='0' Width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRPageHeader'>")
        CommonFunctions.General.WriteHTML("<td align='left'><b>" + MyBase.GetResourceString("DEPARTMENT") + "&nbsp;")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQL = "SELECT Distinct tbl_PM_OtherSchedules.DepartMentID, tbl_PM_DepartmentMaster.Department FROM tbl_PM_OtherSchedules LEFT OUTER JOIN tbl_PM_DepartmentMaster ON tbl_PM_OtherSchedules.DepartMentID = tbl_PM_DepartmentMaster.DepartmentID WHERE tbl_PM_OtherSchedules.DepartMentID IS NOT NULL AND tbl_PM_OtherSchedules.ProjectID  = " + m_strProjectID + " Order By tbl_PM_DepartmentMaster.Department"
        strSQL = "usp_sel_tbl_PM_OtherSchedules_DepartMentID " + m_strProjectID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", strSQL, , CType(strFilterDepartmentID, String), "onChange=ApplyDepartmentFilter();", True)
        strSQL = ""
        CommonFunctions.General.WriteHTML("</b></td>")
        'strSQL = "Select Distinct A.ScheduleID, B.LabelSchedule	From tbl_PM_ProjectSchedules As A Inner Join tbl_PM_CompanySchedules As B  On A.ScheduleID=B.ScheduleID Where A.ProjectID = " + m_strProjectID
        'CommonFunctions.General.WriteHTML("<td align='left'><B>Deliverable Type &nbsp;")
        'CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableType", strSQL, , strFilterDeliverableTypeID, "onChange=ApplyDeliverableTypeFilter()", True)
        'CommonFunctions.General.WriteHTML("</B></td>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub


    Public Sub PlotPeriodHeader()
        Dim strStartDate As String
        Dim strEndDate As String
        Dim strSQL As String
        Dim drProjectName As IDataReader
        Dim strProjectName As String
        Dim strFromDate As String
        Dim strToDate As String

        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT ProjectName FROM tbl_PM_Project WHERE ProjectID = " + m_strProjectID
        strSQL = "usp_tbl_PM_Project_ProjectName " + m_strProjectID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        drProjectName = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drProjectName.Read Then
            strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(drProjectName("ProjectName"), ""), String)
        End If
        CommonFunctions.General.WriteHTML("<TABLE cellspacing='0' cellpadding='0' Width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRPageHeader'>")
        'To Do: Get dates
        CommonFunctions.General.WriteHTML("<td height='22' align='left'><B>" + "&nbsp;&nbsp;</B></td>")
        CommonFunctions.General.WriteHTML("<td height='22' align='right'><B>" + MyBase.GetResourceString("PERIOD") + CommonFunctions.Dates.CGetDate(CType(m_strFromDate, DateTime)) + "&nbsp;" + "To" + "&nbsp;" + CommonFunctions.Dates.CGetDate(CType(m_strToDate, DateTime)) + "</B></td>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.Data.DisposeDataReader(drProjectName)
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
        Dim strFilterDepartmentID As String
        Dim strFilterDeliverableTypeID As String
        Dim strSQL As String
        'Dim arrWidthArray() As String = {"style='width:10%'", "style='width:15%'", "style='width:15%' align='right'", "style='width:20%' align='center'", "style='width:20%' align='center'", "style='width:20%' align='center'", "style='width:20%' align='center'"}
        Dim arrWidthArray() As String = {"style='width:10%'", "style='width:10%'", "style='width:10%'", "style='width:10%'", "style='width:10%'", "style='width:10%' align='right'", "style='width:10%' align='right'", "style='width:10%' align='right'", "style='width:10%' align='right'"}
        Dim arrColRowLinks() As String = {"", "", "", "", "", "", "", "", "", ""}
        'Dim arrAlignment() As String = {"left", "left", "right", "center", "center", "center"}
        Dim arrAlignment() As String = {"left", "left", "left", "left", "left", "right", "right", "right", "right"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        If CType(Request.Form("cboDepartment"), String) <> "" Then
            strFilterDepartmentID = CType(Request.Form("cboDepartment"), String)
        Else
            strFilterDepartmentID = ""
        End If

        'If CType(Request.Form("cboDeliverableType"), String) <> "" Then
        '    strFilterDeliverableTypeID = CType(Request.Form("cboDeliverableType"), String)
        'Else
        '    strFilterDeliverableTypeID = ""
        'End If

        strFilterDeliverableTypeID = ""


        strSQL = "Exec usp_Sel_tbl_PM_OtherSchedules_PercentProgress " + CType(m_strProjectID, String) + ",'" + CType(m_strFromDate, String) + "','" + CType(m_strToDate, String) + "'"

        If strFilterDepartmentID = "" Then
            strSQL = strSQL + ", NULL"
        Else
            strSQL = strSQL + "," + CType(strFilterDepartmentID, String)
        End If

        If strFilterDeliverableTypeID = "" Then
            strSQL = strSQL + ", NULL"
        Else
            strSQL = strSQL + "," + CType(strFilterDeliverableTypeID, String)
        End If

        'CommonFunctions.General.WriteHTML("<br><DIV id='DivProjectTasksList' style='Overflow:auto;width=100%;Height:540'>")

        '##### Get Column Headings from Resources 
        arrColumnHeadingList.Add(MyBase.GetResourceString("DELIVERABLE_CODE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("DELIVERABLE_TYPE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("DELIVERABLE_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("START_DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("END_DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("PLANNED_EFFORTS"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("ACTUAL_EFFORTS"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("CALCULATE_PERCENT"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("PERCENT_ENTERED"))
        '##### End 

        '##### Actual Column Names List
        arrActualColumnNames.Add("DeliverableCode")
        arrActualColumnNames.Add("LabelSchedule")
        arrActualColumnNames.Add("Title")
        arrActualColumnNames.Add("StartDate")
        arrActualColumnNames.Add("EndDate")
        arrActualColumnNames.Add("ExpectedCompletionTime")
        arrActualColumnNames.Add("ActualEffords")
        arrActualColumnNames.Add("CalculatedPerCentage")
        arrActualColumnNames.Add("DefaultPercent")

        '##### End






        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 9
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 360
            .SQL = strSQL
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .GroupOnColumn = GetArray(arrGroupColumnNames)
            '.ColumnHeaderAlignment = arrAlignment
            '.FooterHTML = sbFooterHTML.ToString
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
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_DeliverablePercentProgress", "AppResources")
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
        Dim strDepartment As String
        Dim dblPercentDept As Double

        strDepartment = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Department"), "Not Defined"), String)

        If m_strDepartmet <> CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Department"), "Not Defined"), String).Trim Then
            strDepartment = ""
            If CType(m_strDepartmet, String) <> "" Then
                If CType(m_strDeliverableType, String) <> "" Then
                    If m_dblDepartmentEffords = 0 Then
                        dblPercentDept = 0
                    Else
                        dblPercentDept = m_dblDepartmentCalcPercent * 100 / m_dblDepartmentEffords
                    End If
                    Args.StringToBeInserted += "<tr class='clsTRGroupHeader'><td colspan=5></td><td align=right>"
                    Args.StringToBeInserted += FormatNumber(CType(m_dblDepartmentEffords, String), 2)
                    Args.StringToBeInserted += "</td><td colspan=2></td><td align=right>"
                    Args.StringToBeInserted += FormatNumber(CType(dblPercentDept, String), 2)
                    Args.StringToBeInserted += "</td></tr>"
                    m_dblDepartmentEffords = 0
                    m_dblDepartmentCalcPercent = 0
                End If
            End If

            m_strDepartmet = CommonFunction.Data.CheckIsDBNull(Args.DataReader("Department"), "Not Defined").ToString + ""
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=9>" + MyBase.GetResourceString("DEPARTMENT") + ": " + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Department"), "Not Defined"), String) + "</TD></TR>"
        End If


        If m_strDeliverableType <> CommonFunction.Data.CheckIsDBNull(Args.DataReader("LabelSchedule"), "Not Defined").ToString.Trim Or strDepartment <> m_strDepartmet Then
            If m_strDeliverableType <> "" And strDepartment <> "" And strDepartment = m_strDepartmet Then
            End If
            m_strDeliverableType = CommonFunction.Data.CheckIsDBNull(Args.DataReader("LabelSchedule"), "Not Defined").ToString + ""
            'Args.StringToBeInserted += "<TR class='clsTRGroupHeader' ><TD style='width=5%'></TD><TD align='left' colspan=6>Deliverable Type : " + CType(m_strDeliverableType, String) + "</TD></TD><TD align=right width=15%>"
            'Args.StringToBeInserted += "</TD></TR>"
        End If


    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint


        If Args.ColumnName = "Percent Entered" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='right' style='width:10%'><input class='clsTextBox' name='txtEnteredPercent' id='txtEnteredPercent' size='6' MaxLength='6' Style='text-align:right' " + m_strFreeseDisable + " value='" + FormatNumber(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DefaultPercent"), ""), String), 2) + "' onkeypress='Javascript:OnlyNumeric(1)'>"
            Args.StringToBeInserted += "<input type=hidden id=DeliverableID name=DeliverableID value = " + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ScheduleID"), ""), String) + " >"
            Args.StringToBeInserted += "<input type=hidden id=ActualEfforts name=ActualEfforts value = " + FormatNumber(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualEffords"), "0"), String), 2) + " >"
            Args.StringToBeInserted += "<input type=hidden id=CalculatedPercent name=CalculatedPercent value = " + FormatNumber(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CalculatedPercentage"), "0"), String), 2) + " >"
            Args.StringToBeInserted += "</td>"
        End If
    End Sub



#End Region


   

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strFreeze As String

        strSQL = "Exec usp_Sel_CheckDeliverableFreezed " + CType(m_strProjectID, String) + ",'" + CType(m_strFromDate, String) + "','" + CType(m_strToDate, String) + "'"
        objDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If objDr.Read Then
            strFreeze = CType(objDr("Freezed"), String)
        End If
        CommonFunction.Data.DisposeDataReader(objDr)

        If strFreeze.ToUpper = "Y" Then
            Select Case Args.LinkName.ToUpper
                Case "APPROVE"
                    Cancel = True
                Case "SAVE"
                    Cancel = True
                Case "REGENERATE"
                    Cancel = True
            End Select
        End If
    End Sub


    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        Dim dblEffords As Double
        Dim dblCalPercent As Double

        dblEffords = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpectedCompletionTime"), "0"), Double)
        dblCalPercent = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CalculatedWork"), "0"), Double)

        m_dblDepartmentEffords = m_dblDepartmentEffords + dblEffords
        m_dblProjectEffords = m_dblProjectEffords + dblEffords

        m_dblDepartmentCalcPercent = m_dblDepartmentCalcPercent + dblCalPercent
        m_dblProjectCalcPercent = m_dblProjectCalcPercent + dblCalPercent
    End Sub

    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint
        Dim strFilterDepartmentID As String
        Dim dblPercentDept As Double = 0
        Dim dblPercentProject As Double = 0

        If (m_dblDepartmentEffords = 0) Then
            dblPercentDept = 0
        Else
            dblPercentDept = m_dblDepartmentCalcPercent * 100 / m_dblDepartmentEffords
        End If

        Args.StringToBeInserted += "<tr class='clsTRGroupHeader'><td colspan=5></td><td align=right>"
        Args.StringToBeInserted += FormatNumber(CType(m_dblDepartmentEffords, String), 2)
        Args.StringToBeInserted += "</td><td colspan=2></td><td align=right>"
        Args.StringToBeInserted += FormatNumber(CType(dblPercentDept, String), 2)
        Args.StringToBeInserted += "</td></tr>"

        If CType(Request.Form("cboDepartment"), String) <> "" Then
            strFilterDepartmentID = CType(Request.Form("cboDepartment"), String)
        Else
            strFilterDepartmentID = ""
        End If

        If strFilterDepartmentID = "" Then
            If m_dblProjectEffords = 0 Then
                dblPercentProject = 0
            Else
                dblPercentProject = m_dblProjectCalcPercent * 100 / m_dblProjectEffords
            End If
            Args.StringToBeInserted += "<tr class='clsTRGroupHeader'><td colspan=2></td>"
            Args.StringToBeInserted += "<td colspan=2>" + MyBase.GetResourceString("PROJECT_PERCENT") + "</td><td></td><td align=right>"
            Args.StringToBeInserted += FormatNumber(CType(m_dblProjectEffords, String), 2)
            Args.StringToBeInserted += "</td><td colspan=2></td><td align=right>"
            Args.StringToBeInserted += FormatNumber(CType(dblPercentProject, String), 2)
            Args.StringToBeInserted += "</td></tr>"
        End If


    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim a As Integer
    End Sub
End Class
