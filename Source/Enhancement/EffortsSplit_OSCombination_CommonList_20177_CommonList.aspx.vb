Imports CommonEngines.General.cEventHandlers
Imports Whizible
Public Class EffortsSplit_OSCombination_CommonList_20177_CommonList
    Inherits CommonList
    Protected strOSListIDs As String
    Protected strOSListIDsNew As String
    Protected strBSD, strBED, strBaselineEfforts, strOnsitePer, strOffshorePer, strPlannedEfforts, strOffshoreBaselineEfforts, strOnshoreBaselineEfforts, strASD, strAED, strActualEfforts, strActualEffort, streffortvariance, strschedulevariance, strCSD, strCED, strCurrEfforts, strCurrDuration As New StringBuilder
    Protected intProcessgroupID, intProjectID As String
    Public strMode As String
    Protected strProjectStartDate, strProjectEndDate As String

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region


#Region "Legend, Page Caption and HeaderFooter"

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub
    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        If Trim(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("MSG_REFINE_SEARCH" + CStr(15014)))) <> "" Then
            CommonFunctions.General.WriteHTML("<td><TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD id='tdShowHide_showHide_divSection1'><A href=""Javascript:showHide_div()""><Img Border=0 id=imgShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;<b>Filters:</b></TD></TR></TABLE></td>")
            CommonFunctions.General.WriteHTML("<DIV id='divFilter' name='divFilter' height=20 style=""overflow:auto;display:''"">")
            CommonFunctions.General.WriteHTML("<TABLE ID='tblFilter' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr class='clsTREven' Width='100%'>")
        End If
    End Sub

    Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)
        'If Args.Legend.Contains("Note") Then
        '    Cancel = True
        '    CommonFunctions.General.WriteHTML("<td><TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD id='tdShowHide_showHide_divSection2'><A href=""Javascript:showHide_div1()""><Img Border=0 id=imgShowHide1 Src='../../Images/minus.gif' title=''></A>&nbsp;<b>Note:</b></TD></TR></TABLE></td>")
        '    CommonFunctions.General.WriteHTML("<DIV id='divFilter1' name='divFilter1' height=10 style=""overflow:auto;display:''"">")
        '    CommonFunctions.General.WriteHTML("<TABLE ID='tblFilter1' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        '    CommonFunctions.General.WriteHTML("<tr class='clsTREven' Width='100%'>")
        'End If
    End Sub

    Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)
        ' If Args.HeaderFooter.Contains("Note") Then
        'Cancel = True

        Dim strTagID As String
        Dim SetFilter As String
        strTagID = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Request.QueryString("MastertagID")), "0")
        SetFilter = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Request.QueryString("SetFilter")), "0")
        If strTagID = 20177 Or SetFilter = 1 Then
            CommonFunctions.General.WriteHTML("<td><TABLE id=osNote width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD id='tdShowHide_showHide_divSection2'><A href=""Javascript:showHide_div1()""><Img Border=0 id=imgShowHide1 Src='../../Images/minus.gif' title=''></A>&nbsp;<b>Note:</b></TD></TR></TABLE></td>")
            CommonFunctions.General.WriteHTML("<DIV id='divFilter1' name='divFilter1' height=10 style=""margin-top: 20px;overflow:auto;display:''"">")

            CommonFunctions.General.WriteHTML("<TABLE id='tblFilter1'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader><TD align=Left><p><font color='#cc0000' face='Helvetica' size='2'><font color='#000000'><strong>Note</strong>: Baseline Start Date: Min(baseline start date) of task in the combination if any of the task doesn''t have the baseline start date then system will consider the current start date of the task<br>Baseline End Date: Max(baseline end date) of task in the combination&nbsp;if any of the task doesn''t have the baseline end date then system will consider the current end date of the task</font></font><font color='#cc0000' face='Helvetica' size='2'><br></font><strong><font color='#cc0000' face='Helvetica' size='2'>(Red color indicates there is change in overall schedule plan.)</font></strong><br><strong><font color='blue' face='Helvetica' size='2'>(Blue color indicates there are tasks without baseline.)</font></strong><br></p><p>(S-Sub-Project , M-Modules , P-Phases , Mi-Milestones , D-Project Deliverables)</p><br><img id=imgPane src='../../Images/Scrum/task.gif' style='height:15px' border=0 align='center' alt='Tasks' /> - Indicates all the tasks depends on OS combination. <br>   <img id=imgPane src='../../Images/Home/CloseTask.jpg' style='height:13px' border=0 align='center' alt='Close image' /> - To Close All Tasks</p></TD></TR></TABLE><br>")

            CommonFunctions.General.WriteHTML("<div id=GanttChart>")
            CommonFunctions.General.WriteHTML("<p style='margin-bottom:0px !important;'>Gantt View <a href='Javascript:GanttView_OnClick(this);'><img id=imgHideShow src='../../Images/Home/leftarrow.png'></img> </a></p>")
            CommonFunctions.General.WriteHTML("<p style='margin-bottom:0px !important;'>Network Diagram <a href='Javascript:NetworkView_OnClick(this);'><img id=imgHideShowNetwork src='../../Images/Home/leftarrow.png'></img> </a></p>")
            CommonFunctions.General.WriteHTML("</div>")

            CommonFunctions.General.WriteHTML("<tr class='clsTREven' Width='100%'>")
        End If

    End Sub

#End Region
#Region "Section"

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    '    If Args.DivSectionTag = "divListPageTag" Then

    '    End If
    'End Sub
    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub
    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx"
        MyBase.strFormPage = "EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx" '"EffortsSplit_OSCombination_CommonList.aspx"
        'MyBase.strSubTagPage = "../General/CommonSubTag.aspx"

        Dim sbSTRHTML As New System.Text.StringBuilder
        Dim intOverallScheduleID As String, strSQL As String
        Dim strSql1 As String
        'Put user code to initialize the page here
        intProcessgroupID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProcessGroupID"), "0"))
        intProjectID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"))
        strMode = Convert.ToString(CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), ""))
        intOverallScheduleID = Convert.ToString(CommonFunctions.General.CheckIsNothing(Request.QueryString("OverallScheduleID"), "0"))
        strProjectStartDate = Convert.ToString(CommonFunctions.Data.GetDataScalar("Select ExpectedStartDate from tbl_pm_project where ProjectID=  " + CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0") + "", True))
        strProjectEndDate = Convert.ToString(CommonFunctions.Data.GetDataScalar("Select ExpectedEndDate from tbl_pm_project where ProjectID=  " + CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0") + "", True))

        'Added By Bharat T on 13th-Oct-2016 for getting os combination from tasks table
        'If CommonFunctions.General.CheckIsNothing(Request.QueryString("IsFirstTime"), "") = "1" Then
        '    CommonFunctions.Data.InsertOrUpdateData("usp_INS_tbl_PM_ProjectSchedule " & intProjectID & ",'" & CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "")) & "'", True)
        'End If
        'End of Added By Bharat T on 13th-Oct-2016 for getting os combination from tasks table

        'Draft
        If strMode = "Save" Or strMode = "SnapShot" Or strMode = "Baseline" Or strMode = "Draft" Or strMode = "Rebaseline" Then
            'If strMode = "Save" Then
            strOSListIDs = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtHidListUniqueIDs"))

            'If strOSListIDs = "" Then
            '    strSql1 = "usp_sel_OverallScheduleIDs " & intProjectID
            '    strOSListIDs = CommonFunction.Data.GetDataScalar(strSql1, True)
            'End If

            Dim arrOSListIDs As String() = strOSListIDs.Split(CChar(","))
            Dim i As Integer = 0
            For i = 0 To arrOSListIDs.Length - 1
                strBSD.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtBaselineStartDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strBED.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtBaselineEndDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strBaselineEfforts.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtBaselineEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strOnsitePer.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtOnsiteEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strOffshorePer.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtOffshoreEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strPlannedEfforts.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtReuseEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")

                strOffshoreBaselineEfforts.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtOffshoreBaselineEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strOnshoreBaselineEfforts.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtOnshoreBaselineEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")


                strASD.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtActualStartDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strAED.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtActualEndDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strActualEfforts.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtActualworkingdays" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strActualEffort.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtActualWork" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strschedulevariance.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtschedulevariance" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                streffortvariance.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txteffortvariance" + arrOSListIDs(i).ToString()), "0"), String) + ",")

                strCSD.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtCurrentStartDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strCED.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtCurrentEndDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strCurrEfforts.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtCurrentEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strCurrDuration.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtCurrentDuration" + arrOSListIDs(i).ToString()), "0"), String) + ",")

            Next

            CommonFunctions.Data.InsertOrUpdateData("usp_upd_tbl_WPBN_PM_OverallSchedule_OSCombination '" + strOSListIDs.ToString + "','" + strBSD.ToString() + "','" + strBED.ToString() + "','" + strBaselineEfforts.ToString() + "','" + strOnsitePer.ToString() + "','" + strOffshorePer.ToString() + "','" + strPlannedEfforts.ToString() + "'," + intProcessgroupID + ",'" + strOffshoreBaselineEfforts.ToString() + "','" + strOnshoreBaselineEfforts.ToString() + "','" + strASD.ToString() + "','" + strAED.ToString() + "','" + strActualEfforts.ToString() + "','" + strActualEffort.ToString() + "','" + strschedulevariance.ToString() + "','" + streffortvariance.ToString() + "','" + intProjectID.ToString() + "','" + strCSD.ToString() + "','" + strCED.ToString() + "','" + strCurrEfforts.ToString() + "','" + strCurrDuration.ToString() + "'", True)

            If strMode = "Save" Or strMode = "Draft" Or strMode = "" Or strMode = "CloseTasks" Or strMode = "SnapShot" Or strMode = "Baseline" Or strMode = "Rebaseline" Then

                CommonFunctions.Data.InsertOrUpdateData("usp_get_EV_tbl_WPBN_PM_OverallSchedule_OSCombination '" + strOSListIDs.ToString + "','" + strBSD.ToString() + "','" + strBED.ToString() + "','" + strBaselineEfforts.ToString() + "','" + strOnsitePer.ToString() + "','" + strOffshorePer.ToString() + "','" + strPlannedEfforts.ToString() + "'," + intProcessgroupID + ",'" + strOffshoreBaselineEfforts.ToString() + "','" + strOnshoreBaselineEfforts.ToString() + "','" + strASD.ToString() + "','" + strAED.ToString() + "','" + strActualEfforts.ToString() + "','" + strActualEffort.ToString() + "','" + strschedulevariance.ToString() + "','" + streffortvariance.ToString() + "','" + intProjectID.ToString() + "','" + strCSD.ToString() + "','" + strCED.ToString() + "'", True)

            End If

            If strMode = "SnapShot" Then
                Dim strCreatedBy As String = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))

                CommonFunctions.Data.InsertOrUpdateData("usp_upd_tbl_WPBN_PM_OverallSchedule_OSCombination_SnapShot " + intProjectID + ",'" + strCreatedBy + "'", True)

                CommonFunctions.Data.InsertOrUpdateData("usp_ins_WBS_OSSnapshotTables " + intProjectID + ",'" + strCreatedBy + "'", True)
            End If

            If strMode = "Baseline" Then
                Dim strCreatedBy As String = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))

                CommonFunctions.Data.InsertOrUpdateData("usp_ins_tbl_pm_baselineHistory " + intProjectID + ",'" + strCreatedBy + "'", True)

            End If
            If strMode = "Rebaseline" Then

                Dim strCreatedBy As String = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))

                CommonFunctions.Data.InsertOrUpdateData("usp_Upd_BaselineData_OnRebaseline " + intProjectID + ",'" + strCreatedBy + "'", True)

            End If
            If strMode = "ImportBaseLine" Then
                Dim strCreatedBy As String = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))

                CommonFunctions.Data.InsertOrUpdateData("usp_ins_tbl_pm_baselineHistory " + intProjectID + ",'" + strCreatedBy + "'", True)
            End If
        End If

        strBSD = Nothing
        strBED = Nothing
        strBaselineEfforts = Nothing
        strOnsitePer = Nothing
        strOffshorePer = Nothing
        strPlannedEfforts = Nothing
        strOffshoreBaselineEfforts = Nothing
        strOnshoreBaselineEfforts = Nothing

        MyBase.Page_Load(sender, e)
        'MyBase.OnLoadComplete(e)
        'Page_LoadComplete(sender, e)
    End Sub
    Protected Sub Page_LoadComplete(ByVal sender As System.Object, ByVal e As System.EventArgs)
        ' protected void Page_LoadComplete(object sender, EventArgs e)

        Dim strBSD, strBED, strBaselineEfforts, strOnsitePer, strOffshorePer, strPlannedEfforts, strOffshoreBaselineEfforts, strOnshoreBaselineEfforts, strASD, strAED, strActualEfforts, strActualEffort, streffortvariance, strschedulevariance, strCSD, strCED, strCurrEfforts, strCurrDuration As New StringBuilder
        Dim strOSListIDs As String
        Dim intOverallScheduleID As String, strMode As String
        Dim strOSListIDsNew As String

        Dim sbSTRHTML As New System.Text.StringBuilder
        'Dim intOverallScheduleID As String, strSQL As String
        'Dim strSql1 As String
        'Put user code to initialize the page here
        intProcessgroupID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProcessGroupID"), "0"))
        intProjectID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"))
        strMode = Convert.ToString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), ""))
        intOverallScheduleID = Convert.ToString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OverallScheduleID"), "0"))

        'Draft

        If strMode = "" Or strMode = "CloseTasks" Then
            'If strMode = "Save" Then
            strOSListIDs = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtHidListUniqueIDs"))
            'strOSListIDs = strMappedString
            'If strOSListIDs = "" Then
            '    strSql1 = "usp_sel_OverallScheduleIDs " & intProjectID
            '    strOSListIDs = CommonFunction.Data.GetDataScalar(strSql1, True)
            'End If

            Dim arrOSListIDs As String() = strOSListIDs.Split(CChar(","))
            Dim i As Integer = 0
            For i = 0 To arrOSListIDs.Length - 1
                'strBSD.Append(CType(CommonFunction.General.CheckIsNothing(Request.Form("txtBaselineStartDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strBSD.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtBaselineStartDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strBED.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtBaselineEndDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strBaselineEfforts.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtBaselineEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strOnsitePer.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOnsiteEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strOffshorePer.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOffshoreEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strPlannedEfforts.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtReuseEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")

                strOffshoreBaselineEfforts.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOffshoreBaselineEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strOnshoreBaselineEfforts.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOnshoreBaselineEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")


                strASD.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtActualStartDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strAED.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtActualEndDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strActualEfforts.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtActualworkingdays" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strActualEffort.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtActualWork" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strschedulevariance.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtschedulevariance" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                streffortvariance.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txteffortvariance" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                '

                strCSD.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCurrentStartDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strCED.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCurrentEndDate" + arrOSListIDs(i).ToString()), ""), String) + ",")
                strCurrEfforts.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCurrentEfforts" + arrOSListIDs(i).ToString()), "0"), String) + ",")
                strCurrDuration.Append(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCurrentDuration" + arrOSListIDs(i).ToString()), "0"), String) + ",")

            Next

            If strMode = "" Or strMode = "CloseTasks" Then
                CommonFunctions.Data.InsertOrUpdateData("usp_get_EV_tbl_WPBN_PM_OverallSchedule_OSCombination '" + strOSListIDs.ToString + "','" + strBSD.ToString() + "','" + strBED.ToString() + "','" + strBaselineEfforts.ToString() + "','" + strOnsitePer.ToString() + "','" + strOffshorePer.ToString() + "','" + strPlannedEfforts.ToString() + "'," + intProcessgroupID + ",'" + strOffshoreBaselineEfforts.ToString() + "','" + strOnshoreBaselineEfforts.ToString() + "','" + strASD.ToString() + "','" + strAED.ToString() + "','" + strActualEfforts.ToString() + "','" + strActualEffort.ToString() + "','" + strschedulevariance.ToString() + "','" + streffortvariance.ToString() + "','" + intProjectID.ToString() + "'", True)
                'HttpContext.Current.Response.Redirect("EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?MasterTagID=20177&FromWhere=Enhancement&PagingAlphabet=-1&SortBy=OS&SortOrder=ASC&ParentTagID=0&FromCL=1&PagingNumber=1&Mode=Save")
            End If
        End If

    End Sub
    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    PlotNote()
    'End Function
    Protected Function PlotNote() As String
        Dim strPlot As String = "<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader><TD align=Left><b>Note : </b> The Overall schedule plan has been chaged for one or more tasks.</TD></TR></TABLE>"
        Return CStr(strPlot)
    End Function

#Region "Dynamic Filters"

    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cMyDynamicFilters(MyBase.m_objGlobal)
    End Function

    Private Class cMyDynamicFilters
        Inherits CommonEngine.CommonList.cDynamicFilters

        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            'Assign the Parameter values to the local variables
            Call MyBase.New(WhizGlobal)
        End Sub

        '    Protected Overrides Sub Initialize_Filters(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFiltersTable, ByVal WhizGlobal As WebPages.Template.IGlobal)

        '    End Sub

        Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
            If Args.ControlTypeID <> CommonFunctions.Constants.CONTROL_TYPE_CHECK_BOX Or Args.ControlTypeID <> CommonFunctions.Constants.CONTROL_TYPE_COMBO_BOX Then

                If Args.FilterName.ToUpper = "SUBPROJECTID" Then
                    Args.ToBeInserted = "<td><TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD id='tdShowHide_showHide_divSection1'><A href=""Javascript:showHide_div()""><Img Border=0 id=imgShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;<b>Filters:</b></TD></TR></TABLE></td>"
                    Args.ToBeInserted += "<DIV id='divFilter' name='divFilter' height=20 style=""overflow:auto;display:''"">"
                    Args.ToBeInserted += "<TABLE ID='tblFilter' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>"
                    Args.ToBeInserted += "<tr class='clsTREven' Width='100%'>"
                End If

            End If
        End Sub


    End Class

#End Region
    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")


    'End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strPGStatus"), "").ToString = "Closed" Then
            If Args.ClientSideFunctionName.ToUpper = "SAVEBREAKUP" _
            Or Args.ClientSideFunctionName.ToUpper = "CRSELECTION_ONCLICK" _
            Or Args.ClientSideFunctionName.ToUpper = "SNAPSHOT_ONCLICK1" Then
                Cancel = True
            End If
        Else
            If Args.ClientSideFunctionName.ToUpper = "SAVEBREAKUP" Then
                Args.CommonQueryString = Args.CommonQueryString.Replace("CommonPage", "CommonList")
                Args.CommonQueryString += "&Mode=Save"
            End If
            If Args.ClientSideFunctionName.ToUpper = "CRSELECTION_ONCLICK" Then

                'Used Function:fun_IsRBMPG Instead of SP:usp_WPBN_ID_sel_IsIterativeDevelopment_OSCombination 
                Dim IsRBMPG As String = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select dbo.fun_IsRBMPG(" + intProcessgroupID + ")", True), "0"))
                If IsRBMPG.ToUpper = "YES" Then
                    Cancel = True
                End If
            End If
        End If
        If Args.LinkName.ToUpper = "DELETE" Then
            Cancel = True
        End If
        If Args.LinkName.ToUpper = "SELECT ALL" Then
            Cancel = True
        End If
        If Args.LinkName.ToUpper = "CLEAR ALL" Then
            Cancel = True
        End If

        If Args.LinkName.ToUpper = "SET BASELINE" Then
            'Cancel = True
            Dim IsOnceBaselined As String
            Dim strSqlQuery As String
            Dim strProjectID As String = CType(Session("intProjectID"), Long)
            strSqlQuery = "Usp_check_IsOnceBaselined " & strProjectID
            IsOnceBaselined = CommonFunction.Data.GetDataScalar(strSqlQuery, True)

            If IsOnceBaselined = "1" Then
                Args.LinkName = "Re-Baseline"
            End If

        End If

    End Sub


    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New EffortsSplit_CLPlotGrid(MyBase.m_objGlobal)
    End Function
    Public Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        strActionCode = ReturnCodes.IGNORE_SAVE.ToString
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New Phase_Filter_CommonListSQL(MyBase.m_objGlobal)
    End Function

End Class

Public Class Phase_Filter_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String

        Dim strTagID As String
        strTagID = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Request.QueryString("MastertagID")), "0")
        If strTagID = 21181 Then
            Dim strIsFilterApplied As String
            strIsFilterApplied = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OverallScheduleMasterID"), "0")

            If Not strIsFilterApplied Is Nothing And strIsFilterApplied <> "" Then
                GetPageSpecificFilters += "AND (OverallScheduleMasterID = " + strIsFilterApplied + ")"
            End If
            GetPageSpecificFilters += "AND (OverallScheduleID is NOT NULL)"
            GetPageSpecificFilters += "and ProjectID = " + CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0")
            GetPageSpecificFilters += " order by OS"
        ElseIf strTagID = 22188 Then
            Dim strIsFilterApplied As String
            strIsFilterApplied = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OverallScheduleMasterID"), "0")

            If Not strIsFilterApplied Is Nothing And strIsFilterApplied <> "" Then
                GetPageSpecificFilters += "AND (OverallScheduleMasterID = " + strIsFilterApplied + ")"
            End If
            GetPageSpecificFilters += "AND (OverallScheduleID is NOT NULL)"
            GetPageSpecificFilters += "and ProjectID = " + CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0")
            GetPageSpecificFilters += " order by OS"
        Else
            If strTagID <> 1536 Then
                GetPageSpecificFilters += " and ProjectID = " + CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0")
                'GetPageSpecificFilters += " order by OverallScheduleID,BaselineStartDate"
            End If

        End If


        'GetPageSpecificFilters &= " AND ProjectID is  NULL "
    End Function
End Class

Public Class EffortsSplit_CLPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Protected strMappedString As String = ""
    Protected strTotalEfforts As Double = 0
    Protected strStartDate, strEndDate As String
    Protected m_strPageTitle As String

    Public Sub New(ByVal whizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(whizGlobal)

    End Sub
    'Protected Overrides Sub After_GridColumnHeaderTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub
    'Protected Overrides Sub Before_GridColumnHeaderTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    Args.StringToBeInserted = "<tr class=clsTRColumnHeader ></tr>"       
    'End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        PlotNote()

        Dim strTagID As String
        strTagID = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Request.QueryString("MastertagID")), "0")
        If strTagID = 21181 Then
            Dim strOverallScheduleID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("OverallScheduleID"), "").ToString.Trim
            Dim strPhaseID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("PhaseID"), "").ToString.Trim
            Dim OverallScheduleHistoryID As String
            Dim strSQL As String
            Dim dsHistDetails1 As IDataReader
            Dim strBaselineWork As String
            Dim strActualWork As String
            Dim strScheduleVariance, strEffortVariance As String
            Dim strActualStartDate As String
            Dim strActualEndDate As String
            Dim strActualworkingDays As String
            Dim strCurrentStartDate As String
            Dim strCurrentEndDate As String
            Dim strCurrentEfforts As String
            Dim strCurrentDuration As String
            Dim strOSCombination As String
            Dim dsDetails2 As IDataReader
            Dim strModuleID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("ModuleID"), "").ToString.Trim
            Dim strSubProjectID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("SubProjectID"), "").ToString.Trim
            Dim strMilestoneID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("MilestoneID"), "").ToString.Trim
            Dim strDeliverableID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("DeliverableID"), "").ToString.Trim
            Dim strIterationID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("IterationID"), "").ToString.Trim
            Dim strReleaseID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReleaseID"), "").ToString.Trim

            Dim ProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"))
            Dim IsAgile = CStr(CommonFunctions.Data.GetDataScalar("usp_sel_Is_AgileProject " + ProjectID + "", True))


            If (strPhaseID <> "") Then
                strPhaseID = strPhaseID
            Else
                strPhaseID = "NULL"
            End If
            If (strModuleID <> "") Then
                strModuleID = strModuleID
            Else
                strModuleID = "NULL"
            End If
            If (strSubProjectID <> "") Then
                strSubProjectID = strSubProjectID
            Else
                strSubProjectID = "NULL"
            End If
            If (strMilestoneID <> "") Then
                strMilestoneID = strMilestoneID
            Else
                strMilestoneID = "NULL"
            End If
            If (strDeliverableID <> "") Then
                strDeliverableID = strDeliverableID
            Else
                strDeliverableID = "NULL"
            End If

            If (strIterationID <> "") Then
                strIterationID = strIterationID
            Else
                strIterationID = "NULL"
            End If
            If (strReleaseID <> "") Then
                strReleaseID = strReleaseID
            Else
                strReleaseID = "NULL"
            End If

            OverallScheduleHistoryID = Convert.ToString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OverallScheduleMasterID"), ""))

            'strSQL = "usp_Sel_SnapShotForGivenOverallScheduleHistoryID " & OverallScheduleHistoryID
            strSQL = "usp_Sel_SnapShotForGivenOverallScheduleHistoryID " & OverallScheduleHistoryID & "," & strOverallScheduleID
            dsHistDetails1 = CommonFunction.Data.GetDataReader(strSQL, True)
            If dsHistDetails1.Read Then
                strStartDate = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("BaselineStartDate"), "")
                strEndDate = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("BaselineEndDate"), "")
                strBaselineWork = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dsHistDetails1("BaselineEfforts"), ""), "0")
                strCurrentStartDate = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("CurrentStartDate"), "")
                strCurrentEndDate = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("CurrentEndDate"), "")
                strCurrentEfforts = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("CurrentEfforts"), "")
                strCurrentDuration = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("CurrentDuration"), "")
                strActualStartDate = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("ActualStartDate"), "")
                strActualEndDate = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("ActualEndDate"), "")
                strActualworkingDays = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("Actualworkingdays"), "")
                strScheduleVariance = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("ScheduleVariance"), "")
                strActualWork = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("ActualEfforts"), "")
                strEffortVariance = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("EffortVariance"), "")
                strOSCombination = CommonFunction.Data.CheckIsDBNull(dsHistDetails1("OS"), "")
            End If
            If IsAgile = "1" Then
                If strScheduleVariance = "" Or strEffortVariance = "" Or strActualworkingDays = "" Then
                    strSQL = "usp_sel_tbl_PM_ProjectTasks_OverallScheduleForAgile " & strPhaseID & "," & strModuleID & "," & strSubProjectID & "," & strMilestoneID & "," & strDeliverableID & "," & strIterationID & "," & strReleaseID
                    dsDetails2 = CommonFunction.Data.GetDataReader(strSQL, True)
                    If dsDetails2.Read Then
                        strActualworkingDays = CommonFunction.Data.CheckIsDBNull(dsDetails2("Actualworkingsdays"), "")
                        strScheduleVariance = CommonFunction.Data.CheckIsDBNull(dsDetails2("ScheduleVariance"), "")
                        strEffortVariance = CommonFunction.Data.CheckIsDBNull(dsDetails2("EffortVariance"), "")
                    End If
                End If
            Else
                If strScheduleVariance = "" Or strEffortVariance = "" Or strActualworkingDays = "" Then
                    strSQL = "usp_sel_tbl_PM_ProjectTasks_OverallSchedule " & strPhaseID & "," & strModuleID & "," & strSubProjectID & "," & strMilestoneID & "," & strDeliverableID & "," & strOverallScheduleID
                    dsDetails2 = CommonFunction.Data.GetDataReader(strSQL, True)
                    If dsDetails2.Read Then
                        strActualworkingDays = CommonFunction.Data.CheckIsDBNull(dsDetails2("Actualworkingsdays"), "")
                        strScheduleVariance = CommonFunction.Data.CheckIsDBNull(dsDetails2("ScheduleVariance"), "")
                        strEffortVariance = CommonFunction.Data.CheckIsDBNull(dsDetails2("EffortVariance"), "")
                    End If
                End If
            End If

            If Args.DataField.ToLower = "baselinestartdate" Then
                Cancel = True
                strMappedString = strMappedString.ToString + strOverallScheduleID + ","
                If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineStartDate"), "")) = "" Then
                    strStartDate = strStartDate
                Else
                    strStartDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineStartDate"), ""))
                End If

                If strStartDate = "01-01-1900 00:00:00" Then
                    strStartDate = ""
                End If
                Args.StringToBeInserted = "<td Title = 'Column Name : Baseline Start Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtBaselineStartDate" + strOverallScheduleID, "txtBaselineStartDate" + strOverallScheduleID, , 70, strStartDate, , "frmCommonList", , "Baseline StartDate", "background-color:#FAFAFA;", True, True, , True) + "</td>"
            End If

            If Args.DataField.ToLower = "baselineenddate" Then
                Cancel = True

                If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEndDate"), "")) = "" Then
                    strEndDate = strEndDate
                Else
                    strEndDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEndDate"), ""))
                End If
                If strEndDate = "01-01-1900 00:00:00" Then
                    strEndDate = ""
                End If
                Args.StringToBeInserted = "<td Title = 'Column Name : Baseline End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtBaselineEndDate" + strOverallScheduleID, "txtBaselineEndDate" + strOverallScheduleID, , 70, strEndDate, , "frmCommonList", , "Baseline EndDate", "background-color:#FAFAFA;", True, True, , True) + "</td>"
            End If
            If Args.DataField.ToLower = "baselineefforts" Then
                Cancel = True

                If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEfforts"), "")) = "" Then
                    strBaselineWork = strBaselineWork
                Else
                    strBaselineWork = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEfforts"), ""))
                End If
                Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",5)"
                Args.StringToBeInserted = "<td Title = 'Column Name : Baseline Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtBaselineEfforts" + strOverallScheduleID, "txtBaselineEfforts" + strOverallScheduleID, , 70, 14, strBaselineWork, "right", "background-color:#FAFAFA;", True, True, , , "onblur = '" + calculatebaselineefforts_onchange + "'", True, , , , , ) + "</td>"
                'Args.StringToBeInserted = "<td Title = 'Column Name : Baseline Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtBaselineEfforts" + strOverallScheduleID, "txtBaselineEfforts" + strOverallScheduleID, , 80, 14, CommonFunction.Data.CheckIsDBNull(Args.DataReader("BaselineEfforts"), "").ToString, "right", , , , , , , True, , , , , ) + "</td>"
                'Args.StringToBeInserted = "<td Title = 'Column Name : Baseline Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtBaselineEfforts" + strOverallScheduleID, "txtBaselineEfforts" + strOverallScheduleID, , 80, 14, strBaselineWork, "right", , , , , , , True, , , , , ) + "</td>"
                Args.StringToBeInserted += "<INPUT TYPE=HIDDEN name = txtHidUniqueIDs ID=txtHidUniqueID" + strOverallScheduleID + " VALUE=" + strOverallScheduleID + ">"
                If strPhaseID = "-99999" Then
                    Args.StringToBeInserted += "<INPUT TYPE=HIDDEN name = txtHidNonPhaseRow ID=txtHidNonPhaseRow VALUE=" + strOverallScheduleID + ">"
                End If

            End If

            If Args.DataField.ToLower = "currentstartdate" Then
                Cancel = True

                strCurrentStartDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentStartDate"), ""))
                If strCurrentStartDate = "01-01-1900 00:00:00" Then
                    strCurrentStartDate = ""
                End If

                Args.StringToBeInserted = "<td Title = 'Column Name : Current Start Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtCurrentStartDate" + strOverallScheduleID, "txtCurrentStartDate" + strOverallScheduleID, , 70, strCurrentStartDate, , "frmCommonList", , "Current StartDate", "background-color:#FAFAFA;", True, True, , True) + "</td>"
            End If
            If Args.DataField.ToLower = "currentenddate" Then
                Cancel = True

                If strCurrentEndDate = "01 Jan 1900" Then
                    strCurrentEndDate = ""
                End If

                Args.StringToBeInserted = "<td Title = 'Column Name : Current End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtCurrentEndDate" + strOverallScheduleID, "txtCurrentEndDate" + strOverallScheduleID, , 70, strCurrentEndDate, , "frmCommonList", , "Current EndDate", "background-color:#FAFAFA;", True, True, , True) + "</td>"

            End If
            If Args.DataField.ToLower = "currentefforts" Then
                Cancel = True

                Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",7)"

                Args.StringToBeInserted = "<td Title = 'Column Name : Current Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtCurrentEfforts" + strOverallScheduleID, "txtCurrentEfforts" + strOverallScheduleID, , 70, 14, strCurrentEfforts, "right", "background-color:#FAFAFA;", True, True, , , "onblur = '" + calculatebaselineefforts_onchange + "'", True, , , , , ) + "</td>"

            End If
            If Args.DataField.ToLower = "currentduration" Then
                Cancel = True

                ''strCurrentDuration = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentDuration"), ""))

                Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",7)"

                Args.StringToBeInserted = "<td Title = 'Column Name : Current Duration '>" + CommonFunctions.HTMLControls.DrawTextBox("txtCurrentDuration" + strOverallScheduleID, "txtCurrentDuration" + strOverallScheduleID, , 70, 14, strCurrentDuration, "right", "background-color:#FAFAFA;", True, True, , , "onblur = '" + calculatebaselineefforts_onchange + "'", True, , , , , ) + "</td>"

            End If

            If Args.DataField.ToLower = "actualworkingdays" Then
                Cancel = True

                strActualworkingDays = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("Actualworkingdays"), ""))
                Dim calculateactualworkingdays_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",6)"
                'Args.StringToBeInserted = "<td Title = 'Column Name : Actual Working Days'>" + CommonFunctions.HTMLControls.DrawTextBox("txtActualworkingdays" + strOverallScheduleID, "txtActualworkingdays" + strOverallScheduleID, , 80, 14, strActualworkingDays, "right", , , , , , , True, , , , , ) + "</td>"
                Args.StringToBeInserted = "<td Title = 'Column Name : Baseline Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtActualworkingdays" + strOverallScheduleID, "txtActualworkingdays" + strOverallScheduleID, , 70, 14, strActualworkingDays, "right", "background-color:#FAFAFA;", True, True, , , "onblur = '" + calculateactualworkingdays_onchange + "'", True, , , , , ) + "</td>"

            End If
            If Args.DataField.ToLower = "actualstartdate" Then
                Cancel = True
                strMappedString = strMappedString.ToString + strOverallScheduleID + ","

                strActualStartDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("ActualStartDate"), ""))
                If strActualStartDate = "01-01-1900 00:00:00" Then
                    strActualStartDate = ""
                End If

                Args.StringToBeInserted = "<td Title = 'Column Name : Actual Start Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtActualStartDate" + strOverallScheduleID, "txtActualStartDate" + strOverallScheduleID, , 70, strActualStartDate, , "frmCommonList", , "Actual StartDate", "background-color:#FAFAFA;", True, True, , True) + "</td>"
            End If

            If Args.DataField.ToLower = "actualenddate" Then
                Cancel = True

                strActualEndDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("ActualEndDate"), ""))
                If strActualEndDate = "01-01-1900 00:00:00" Then
                    strActualEndDate = ""
                End If


                Args.StringToBeInserted = "<td Title = 'Column Name : Actual End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtActualEndDate" + strOverallScheduleID, "txtActualEndDate" + strOverallScheduleID, , 70, strActualEndDate, , "frmCommonList", , "Actual EndDate", "background-color:#FAFAFA;", True, True, , True) + "</td>"
            End If
            If Args.DataField.ToLower = "actualefforts" Then
                Cancel = True

                strActualWork = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("ActualEfforts"), ""))
                'If strActualWork = "0" Then
                '    strActualWork = "NULL"
                'End If
                Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",7)"
                Args.StringToBeInserted = "<td Title = 'Column Name : Actual Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtActualWork" + strOverallScheduleID, "txtActualWork" + strOverallScheduleID, , 70, 14, strActualWork, "right", "background-color:#FAFAFA;", True, True, , , "onblur = '" + calculatebaselineefforts_onchange + "'", True, , , , , ) + "</td>"

            End If
            If Args.DataField.ToLower = "schedulevariance" Then
                Cancel = True
                If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("Schedulevariance"), "")) = "" Then
                    strScheduleVariance = strScheduleVariance
                Else
                    strScheduleVariance = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("Schedulevariance"), ""))
                End If
                'Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",5)"
                Args.StringToBeInserted = "<td Title = 'Column Name : Schedule Variance'>" + CommonFunctions.HTMLControls.DrawTextBox("txtschedulevariance" + strOverallScheduleID, "txtschedulevariance" + strOverallScheduleID, , 70, 14, strScheduleVariance, "right", "background-color:#FAFAFA;", , True, , , "disabled", True, , , , , ) + "</td>"
            End If
            If Args.DataField.ToLower = "effortvariance" Then
                Cancel = True
                If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("Effortvariance"), "")) = "" Then
                    strEffortVariance = strEffortVariance
                Else
                    strEffortVariance = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("Effortvariance"), ""))
                End If
                'Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",5)"
                Args.StringToBeInserted = "<td Title = 'Column Name : Effort Variance'>" + CommonFunctions.HTMLControls.DrawTextBox("txteffortvariance" + strOverallScheduleID, "txteffortvariance" + strOverallScheduleID, , 70, 14, strEffortVariance, "right", "background-color:#FAFAFA;", , True, , , "disabled", True, , , , , ) + "</td>"
            End If
            If Args.DataField.ToLower = "createddate" Then
                Cancel = True
            End If
            If Args.DataField.ToLower = "baselinedon" Then
                Cancel = True
            End If
            If Args.ColumnName.ToLower = "delete" Then
                Cancel = True
            End If
            If Args.DataField.ToLower = "snapshotno" Then
                Cancel = True
            End If
            '-------------------------------------------
        ElseIf strTagID = 22188 Then
            Dim strOverallScheduleID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("OverallScheduleID"), "").ToString.Trim
            Dim strPhaseID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("PhaseID"), "").ToString.Trim
            Dim OverallScheduleHistoryID As String
            Dim strSQL As String
            Dim dsBaselineDetails1 As IDataReader
            Dim strBaselineWork As String
            Dim strActualWork As String
            Dim strScheduleVariance, strEffortVariance As String
            Dim strActualStartDate As String
            Dim strActualEndDate As String
            Dim strActualworkingDays As String
            Dim strCurrentStartDate As String
            Dim strCurrentEndDate As String
            Dim strCurrentEfforts As String
            Dim strCurrentDuration As String
            Dim strOSCombination As String
            Dim dsDetails2 As IDataReader
            Dim strModuleID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("ModuleID"), "").ToString.Trim
            Dim strSubProjectID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("SubProjectID"), "").ToString.Trim
            Dim strMilestoneID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("MilestoneID"), "").ToString.Trim
            Dim strDeliverableID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("DeliverableID"), "").ToString.Trim
            Dim strIterationID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("IterationID"), "").ToString.Trim
            'Dim strReleaseID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReleaseID"), "").ToString.Trim

            Dim ProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"))
            Dim IsAgile = CStr(CommonFunctions.Data.GetDataScalar("usp_sel_Is_AgileProject " + ProjectID + "", True))


            If (strPhaseID <> "") Then
                strPhaseID = strPhaseID
            Else
                strPhaseID = "NULL"
            End If
            If (strModuleID <> "") Then
                strModuleID = strModuleID
            Else
                strModuleID = "NULL"
            End If
            If (strSubProjectID <> "") Then
                strSubProjectID = strSubProjectID
            Else
                strSubProjectID = "NULL"
            End If
            If (strMilestoneID <> "") Then
                strMilestoneID = strMilestoneID
            Else
                strMilestoneID = "NULL"
            End If
            If (strDeliverableID <> "") Then
                strDeliverableID = strDeliverableID
            Else
                strDeliverableID = "NULL"
            End If

            If (strIterationID <> "") Then
                strIterationID = strIterationID
            Else
                strIterationID = "NULL"
            End If

            OverallScheduleHistoryID = Convert.ToString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OverallScheduleMasterID"), ""))

            strSQL = "usp_Sel_BaselineDataForGivenBaselineHistoryID " & OverallScheduleHistoryID & "," & strOverallScheduleID

            dsBaselineDetails1 = CommonFunction.Data.GetDataReader(strSQL, True)
            If dsBaselineDetails1.Read Then
                strStartDate = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("BaselineStartDate"), "")
                strEndDate = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("BaselineEndDate"), "")
                strBaselineWork = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dsBaselineDetails1("BaselineEfforts"), ""), "0")
                strActualStartDate = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("ActualStartDate"), "")
                strActualEndDate = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("ActualEndDate"), "")
                strActualworkingDays = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("Actualworkingdays"), "")
                strCurrentStartDate = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("CurrentStartDate"), "")
                strCurrentEndDate = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("CurrentEndDate"), "")
                strCurrentEfforts = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("CurrentEfforts"), "")
                strCurrentDuration = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("CurrentDuration"), "")
                strScheduleVariance = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("ScheduleVariance"), "")
                strActualWork = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("ActualEfforts"), "")
                strEffortVariance = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("EffortVariance"), "")
                strOSCombination = CommonFunction.Data.CheckIsDBNull(dsBaselineDetails1("OS"), "")
            End If

            If strScheduleVariance = "" Or strEffortVariance = "" Or strActualworkingDays = "" Then
                strSQL = "usp_sel_tbl_PM_ProjectTasks_OverallSchedule " & strPhaseID & "," & strModuleID & "," & strSubProjectID & "," & strMilestoneID & "," & strDeliverableID & "," & strOverallScheduleID
                dsDetails2 = CommonFunction.Data.GetDataReader(strSQL, True)
                If dsDetails2.Read Then
                    strActualworkingDays = CommonFunction.Data.CheckIsDBNull(dsDetails2("Actualworkingsdays"), "")
                    strScheduleVariance = CommonFunction.Data.CheckIsDBNull(dsDetails2("ScheduleVariance"), "")
                    strEffortVariance = CommonFunction.Data.CheckIsDBNull(dsDetails2("EffortVariance"), "")
                End If
            End If
            'End If


            If Args.DataField.ToLower = "baselinestartdate" Then
                Cancel = True
                strMappedString = strMappedString.ToString + strOverallScheduleID + ","

                If strStartDate = "01 Jan 1900" Then
                    strStartDate = ""
                End If

                Args.StringToBeInserted = "<td Title = 'Column Name : Baseline Start Date' style='white-space:nowrap;'>" + strStartDate + "</td>"

            End If

            If Args.DataField.ToLower = "baselineenddate" Then
                Cancel = True

                If strEndDate = "01 Jan 1900" Then
                    strEndDate = ""
                End If

                Args.StringToBeInserted = "<td Title = 'Column Name : Baseline End Date' style='white-space:nowrap;'>" + strEndDate + "</td>"

            End If
            If Args.DataField.ToLower = "baselineefforts" Then
                Cancel = True

                strBaselineWork = strBaselineWork
                Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",5)"

                Args.StringToBeInserted = "<td Title = 'Column Name : Baseline Efforts (PHrs)'>" + strBaselineWork + "</td>"


                Args.StringToBeInserted += "<INPUT TYPE=HIDDEN name = txtHidUniqueIDs ID=txtHidUniqueID" + strOverallScheduleID + " VALUE=" + strOverallScheduleID + ">"
                If strPhaseID = "-99999" Then
                    Args.StringToBeInserted += "<INPUT TYPE=HIDDEN name = txtHidNonPhaseRow ID=txtHidNonPhaseRow VALUE=" + strOverallScheduleID + ">"
                End If

            End If

            If Args.DataField.ToLower = "actualworkingdays" Then
                Cancel = True

                ''strActualworkingDays = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("Actualworkingdays"), ""))
                Dim calculateactualworkingdays_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",6)"

                Args.StringToBeInserted = "<td Title = 'Column Name : Baseline Efforts (PHrs)'>" + strActualworkingDays + "</td>"

            End If
            If Args.DataField.ToLower = "currentstartdate" Then
                Cancel = True

                If strCurrentStartDate = "01 Jan 1900" Then
                    strCurrentStartDate = ""
                End If

                Args.StringToBeInserted = "<td Title = 'Column Name : Current Start Date' style='white-space:nowrap;'>" + strCurrentStartDate + "</td>"

            End If

            If Args.DataField.ToLower = "currentenddate" Then
                Cancel = True

                If strCurrentEndDate = "01 Jan 1900" Then
                    strCurrentEndDate = ""
                End If

                Args.StringToBeInserted = "<td Title = 'Column Name : Current End Date' style='white-space:nowrap;'>" + strCurrentEndDate + "</td>"

            End If
            If Args.DataField.ToLower = "currentefforts" Then
                Cancel = True

                Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",7)"

                Args.StringToBeInserted = "<td Title = 'Column Name : Current Efforts (PHrs)'>" + strCurrentEfforts + "</td>"

            End If
            If Args.DataField.ToLower = "currentduration" Then
                Cancel = True


                Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",7)"

                Args.StringToBeInserted = "<td Title = 'Column Name : Current Duration '>" + strCurrentDuration + "</td>"

            End If
            If Args.DataField.ToLower = "actualstartdate" Then
                Cancel = True
                strMappedString = strMappedString.ToString + strOverallScheduleID + ","

                If strActualStartDate = "01 Jan 1900" Then
                    strActualStartDate = ""
                End If

                Args.StringToBeInserted = "<td Title = 'Column Name : Actual Start Date' style='white-space:nowrap;'>" + strActualStartDate + "</td>"

            End If

            If Args.DataField.ToLower = "actualenddate" Then
                Cancel = True

                If strActualEndDate = "01 Jan 1900" Then
                    strActualEndDate = ""
                End If

                Args.StringToBeInserted = "<td Title = 'Column Name : Actual End Date' style='white-space:nowrap;'>" + strActualEndDate + "</td>"

            End If
            If Args.DataField.ToLower = "actualefforts" Then
                Cancel = True

                Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",7)"
                Args.StringToBeInserted = "<td Title = 'Column Name : Actual Efforts (PHrs)'>" + strActualWork + "</td>"

            End If
            If Args.DataField.ToLower = "schedulevariance" Then
                Cancel = True

                strScheduleVariance = strScheduleVariance

                Args.StringToBeInserted = "<td Title = 'Column Name : Schedule Variance'>" + strScheduleVariance + "</td>"

            End If
            If Args.DataField.ToLower = "effortvariance" Then
                Cancel = True
                'If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("Effortvariance"), "")) = "" Then
                strEffortVariance = strEffortVariance

                Args.StringToBeInserted = "<td Title = 'Column Name : Effort Variance'>" + strEffortVariance + "</td>"

            End If
            If Args.DataField.ToLower = "createddate" Then
                Cancel = True
            End If
            If Args.DataField.ToLower = "baselinedon" Then
                Cancel = True
            End If
            If Args.ColumnName.ToLower = "delete" Then
                Cancel = True
            End If
            If Args.DataField.ToLower = "baselineid" Then
                Cancel = True
            End If
            '-------------------------------------------
        Else
            If strTagID <> 1536 Then
                '20177
                'If Args.DataReader("IsReviewApproved").ToString = "0" Then
                Dim strOverallScheduleID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("OverallScheduleID"), "").ToString.Trim
                Dim strPhaseID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("PhaseID"), "").ToString.Trim

                Dim strModuleID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("ModuleID"), "").ToString.Trim
                Dim strSubProjectID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("SubProjectID"), "").ToString.Trim
                Dim strMilestoneID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("MilestoneID"), "").ToString.Trim
                Dim strDeliverableID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("DeliverableID"), "").ToString.Trim
                Dim strIterationID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("IterationID"), "").ToString.Trim
                Dim strReleaseID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReleaseID"), "").ToString.Trim
                'Dim dsDetails1 As DataSet
                Dim dsDetails1 As IDataReader
                Dim dsDetailsv As IDataReader
                Dim strSqlsv As String
                Dim dsBaselineDetails As IDataReader
                Dim strSQL As String
                Dim strBaselineWork As String
                Dim strActualWork As String
                Dim strScheduleVariance, strEffortVariance As String
                Dim strActualStartDate, strBStartDate, strBEndDate, strBBaselineWork As String
                Dim strActualEndDate As String
                Dim strCurrentStartDate As String
                Dim strCurrentEndDate As String
                Dim strCurrentEfforts As String
                Dim strCurrentDuration As String
                Dim strActualworkingDays As String
                Dim strSQLQuery As String
                Dim strResult As String
                Dim strSQLQuery1 As String
                Dim strResult1 As String
                Dim ProjectID As String
                Dim IsBaselinedtaskExists, IsScheduleChanged, CheckBaseline As String
                Dim strSqlQuery2, strSqlQuery3 As String
                ProjectID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"))
                Dim IsAgile = CStr(CommonFunctions.Data.GetDataScalar("usp_sel_Is_AgileProject " + ProjectID + "", True))


                If (strPhaseID <> "") Then
                    strPhaseID = strPhaseID
                Else
                    strPhaseID = "NULL"
                End If
                If (strModuleID <> "") Then
                    strModuleID = strModuleID
                Else
                    strModuleID = "NULL"
                End If
                If (strSubProjectID <> "") Then
                    strSubProjectID = strSubProjectID
                Else
                    strSubProjectID = "NULL"
                End If
                If (strMilestoneID <> "") Then
                    strMilestoneID = strMilestoneID
                Else
                    strMilestoneID = "NULL"
                End If
                If (strDeliverableID <> "") Then
                    strDeliverableID = strDeliverableID
                Else
                    strDeliverableID = "NULL"
                End If

                If (strIterationID <> "") Then
                    strIterationID = strIterationID
                Else
                    strIterationID = "NULL"
                End If
                If (strReleaseID <> "") Then
                    strReleaseID = strReleaseID
                Else
                    strReleaseID = "NULL"
                End If
                If IsAgile = "1" Then

                    strSQL = "usp_sel_tbl_PM_ProjectTasks_OverallScheduleForAgile " & strPhaseID & "," & strModuleID & "," & strSubProjectID & "," & strMilestoneID & "," & strDeliverableID & "," & strIterationID & "," & strReleaseID
                    dsDetails1 = CommonFunction.Data.GetDataReader(strSQL, True)
                    If dsDetails1.Read Then
                        strStartDate = CommonFunction.Data.CheckIsDBNull(dsDetails1("BaselineStart"), "")
                        strEndDate = CommonFunction.Data.CheckIsDBNull(dsDetails1("BaselineEnd"), "")
                        strBaselineWork = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dsDetails1("BaselineWork"), ""), "0")
                        strActualStartDate = CommonFunction.Data.CheckIsDBNull(dsDetails1("ActualStartDate"), "")
                        strActualEndDate = CommonFunction.Data.CheckIsDBNull(dsDetails1("ActualEndDate"), "")
                        strActualworkingDays = CommonFunction.Data.CheckIsDBNull(dsDetails1("Actualworkingsdays"), "")
                        strScheduleVariance = CommonFunction.Data.CheckIsDBNull(dsDetails1("ScheduleVariance"), "0")
                        strActualWork = CommonFunction.Data.CheckIsDBNull(dsDetails1("ActualEfforts"), "")
                        strEffortVariance = CommonFunction.Data.CheckIsDBNull(dsDetails1("EffortVariance"), "0")
                    End If
                Else
                    'strSQL = "usp_sel_tbl_PM_ProjectTasks_OverallSchedule " & strPhaseID & "," & strModuleID & "," & strSubProjectID & "," & strMilestoneID & "," & strDeliverableID
                    strSQL = "usp_sel_tbl_PM_ProjectTasks_OverallSchedule " & strPhaseID & "," & strModuleID & "," & strSubProjectID & "," & strMilestoneID & "," & strDeliverableID & "," & strOverallScheduleID
                    dsDetails1 = CommonFunction.Data.GetDataReader(strSQL, True)
                    If dsDetails1.Read Then
                        strStartDate = CommonFunction.Data.CheckIsDBNull(dsDetails1("BaselineStart"), "")
                        strEndDate = CommonFunction.Data.CheckIsDBNull(dsDetails1("BaselineEnd"), "")
                        strBaselineWork = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dsDetails1("BaselineWork"), ""), "0")
                        strActualStartDate = CommonFunction.Data.CheckIsDBNull(dsDetails1("ActualStartDate"), "")
                        strActualEndDate = CommonFunction.Data.CheckIsDBNull(dsDetails1("ActualEndDate"), "")
                        strActualworkingDays = CommonFunction.Data.CheckIsDBNull(dsDetails1("Actualworkingsdays"), "")
                        strScheduleVariance = CommonFunction.Data.CheckIsDBNull(dsDetails1("ScheduleVariance"), "0")
                        strActualWork = CommonFunction.Data.CheckIsDBNull(dsDetails1("ActualEfforts"), "")
                        strEffortVariance = CommonFunction.Data.CheckIsDBNull(dsDetails1("EffortVariance"), "0")
                        strCurrentStartDate = CommonFunction.Data.CheckIsDBNull(dsDetails1("CurrentStartDate"), "")
                        strCurrentEndDate = CommonFunction.Data.CheckIsDBNull(dsDetails1("CurrentEndDate"), "")
                        strCurrentEfforts = CommonFunction.Data.CheckIsDBNull(dsDetails1("CurrentEffort"), "")
                        strCurrentDuration = CommonFunction.Data.CheckIsDBNull(dsDetails1("CurrentDuration"), "")
                    End If
                End If

                If strBaselineWork = "" Then
                    strBaselineWork = "0"
                Else
                    strBaselineWork = strBaselineWork
                End If
                If strActualWork = "" Then
                    strActualWork = "0"
                Else
                    strActualWork = strActualWork
                End If

                strTagID = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Request.QueryString("MastertagID")), "0")
                If strTagID = 20177 Then
                    strSQLQuery = "Usp_check_IsPlanChanged " & ProjectID & "," & strOverallScheduleID & ""
                    strResult = CommonFunction.Data.GetDataScalar(strSQLQuery, True)
                End If

                strSqlQuery2 = "usp_get_tasks_Notbaselined_ForOS 'TASKNOTBASELINED'," & strPhaseID & "," & strModuleID & "," & strSubProjectID & "," & strMilestoneID & "," & strDeliverableID & ",NULL,NULL,NULL,NULL"
                IsBaselinedtaskExists = CommonFunction.Data.GetDataScalar(strSqlQuery2, True)

                Dim baseStartDate As String
                Dim baseEndDate As String
                If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineStartDate"), "")) = "" Then
                    If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentStartDate"), "")) = "" Then

                        baseStartDate = strCurrentStartDate
                    Else
                        baseStartDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentStartDate"), ""))
                    End If
                Else
                    baseStartDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineStartDate"), ""))
                End If
                If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEndDate"), "")) = "" Then
                    If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentEndDate"), "")) = "" Then

                        baseEndDate = strCurrentEndDate
                    Else
                        baseEndDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentEndDate"), ""))
                    End If
                Else
                    baseEndDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEndDate"), ""))
                End If

                strSqlQuery3 = "usp_get_tasks_Notbaselined_ForOS 'BASELINEDETAILS'," & strPhaseID & "," & strModuleID & "," & strSubProjectID & "," & strMilestoneID & "," & strDeliverableID & ",'" & baseStartDate & "','" & baseEndDate & "'," & CommonFunction.Data.CheckIsDBNull(Args.DataReader("BaselineEfforts"), "0") & "," & strActualWork & ""
                IsScheduleChanged = CommonFunction.Data.GetDataScalar(strSqlQuery3, True)

                Dim strMode As String = Convert.ToString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), ""))
                Dim intOverallScheduleID As String = Convert.ToString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OverallScheduleID"), ""))
                If strMode = "CloseTasks" Then
                    strSQL = "Usp_upd_tbl_pm_DailyActivity_ToCloseallTasks " & intOverallScheduleID
                    CommonFunctions.Data.InsertOrUpdateData("Usp_upd_tbl_pm_DailyActivity_ToCloseallTasks " + intOverallScheduleID + "", True)
                End If

                'Dim strSqlQ As String = "usp_Check_Baseline_OS " & intOverallScheduleID
                'CheckBaseline = CommonFunction.Data.GetDataScalar(strSqlQuery3, True)

                If Args.DataField.ToUpper = "OS" Then
                    Cancel = True
                    Dim strWBSCombination As String
                    Dim intOverallScheudleID As Integer

                    strWBSCombination = Args.DataReader("OS")
                    intOverallScheudleID = Args.DataReader("OverallScheduleID")

                    Args.StringToBeInserted = "<TD align=Left nowrap='' ><a onclick=javascript:Combination_OnClick(" & intOverallScheudleID & ") >" & strWBSCombination & "</TD>"

                    'Added By Bharat T on 13th-Oct-2016 for  update values in os table
                    If strMode = "" Or strMode = "CloseTasks" Or strMode = "Baseline" Or strMode = "Rebaseline" Then
                        If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineStartDate"), "")) = "" Then
                            strStartDate = strStartDate
                        Else
                            strStartDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineStartDate"), ""))
                        End If



                        If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEndDate"), "")) = "" Then

                            strEndDate = strEndDate
                        Else
                            strEndDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEndDate"), ""))
                        End If


                        If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEfforts"), "0")) = "" Then

                            strBaselineWork = strBaselineWork
                        Else
                            strBaselineWork = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEfforts"), ""))
                        End If

                        CommonFunctions.Data.InsertOrUpdateData("usp_get_SVandEV_Dyanmically '" + strOverallScheduleID.ToString + "','" + strStartDate.ToString() + "','" + strEndDate.ToString() + "','" + strBaselineWork.ToString() + "',0" + ",'" + strActualStartDate.ToString() + "','" + strActualEndDate.ToString() + "','" + strActualWork.ToString() + "','" + strActualWork.ToString() + "','" + strScheduleVariance.ToString() + "','" + strEffortVariance.ToString() + "','" + ProjectID.ToString() + "'", True)

                    End If
                    'End of Added By Bharat T on 13th-Oct-2016 for  update values in os table

                End If

                If Args.DataField.ToUpper = "HYPERLINK1" Then
                    Cancel = True
                    Args.StringToBeInserted = "<td valign='center' align='center'  class='clsTDBlank' width='25%'><a onclick=javascript:CloseAllTasks(" + strOverallScheduleID + ") style='cursor:pointer;'><img id=imgPane src='../../Images/Home/CloseTask.jpg' style='height:13px' border=0 align='center' alt='Close Task Image' /></a> "

                End If

                If Args.DataField.ToUpper = "HYPERLINK2" Then
                    Cancel = True


                    Args.StringToBeInserted = "<td valign='center' align='center'  class='clsTDBlank' width='25%'><a onclick=javascript:Details_OnClick(" + strOverallScheduleID + ") style='cursor:pointer;'><img id=imgPane src='../../Images/Scrum/task.gif' style='height:15px' border=0 align='center' alt='Warning' /></a> "

                End If

                If Args.DataField.ToLower = "baselinestartdate" Then
                    Cancel = True
                    strMappedString = strMappedString.ToString + strOverallScheduleID + ","

                    strSQLQuery1 = "Usp_Sel_BaselineStartDates " & strOverallScheduleID
                    strResult1 = CommonFunction.Data.GetDataScalar(strSQLQuery1, True)

                    If strResult1 = "0" Then
                        If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentStartDate"), "")) = "" Then

                            strStartDate = strCurrentStartDate
                        Else
                            strStartDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentStartDate"), ""))
                        End If
                    Else
                        strStartDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineStartDate"), ""))
                    End If

                    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                        Args.StringToBeInserted = "<td class=ch_1 Title = 'Column Name : Baseline Start Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtBaselineStartDate" + strOverallScheduleID, "txtBaselineStartDate" + strOverallScheduleID, , 70, strStartDate, , "frmCommonList", , "Baseline StartDate", "color:red;", True, , , True, , , , ) + "</td>"
                    ElseIf IsBaselinedtaskExists = "1" Then
                        Args.StringToBeInserted = "<td class=ch_1 Title = 'Column Name : Baseline Start Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtBaselineStartDate" + strOverallScheduleID, "txtBaselineStartDate" + strOverallScheduleID, , 70, strStartDate, , "frmCommonList", , "Baseline StartDate", "color:blue;", True, , , True, , , , ) + "</td>"
                    Else
                        Args.StringToBeInserted = "<td class=ch_1 Title = 'Column Name : Baseline Start Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtBaselineStartDate" + strOverallScheduleID, "txtBaselineStartDate" + strOverallScheduleID, , 70, strStartDate, , "frmCommonList", , "Baseline StartDate", , True, , , True, , , , ) + "</td>"
                    End If

                End If

                If Args.DataField.ToLower = "baselineenddate" Then
                    Cancel = True
                    strSQLQuery1 = "Usp_Ins_BaselineDates " & strOverallScheduleID
                    strResult1 = CommonFunction.Data.GetDataScalar(strSQLQuery1, True)


                    If strResult1 = "0" Then
                        If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentEndDate"), "")) = "" Then

                            strEndDate = strCurrentEndDate
                        Else
                            strEndDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentEndDate"), ""))
                        End If
                    Else
                        strEndDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEndDate"), ""))
                    End If


                    If strBaselineWork <> "" Then
                        strBaselineWork = "0"
                    Else
                        strBaselineWork = strBaselineWork
                    End If

                    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                        Args.StringToBeInserted = "<td class=ch_1 Title = 'Column Name : Baseline End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtBaselineEndDate" + strOverallScheduleID, "txtBaselineEndDate" + strOverallScheduleID, , 70, strEndDate, , "frmCommonList", , "Baseline EndDate", "color:red;", True, , , True) + "</td>"

                    ElseIf IsBaselinedtaskExists = "1" Then
                        Args.StringToBeInserted = "<td class=ch_1 Title = 'Column Name : Baseline End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtBaselineEndDate" + strOverallScheduleID, "txtBaselineEndDate" + strOverallScheduleID, , 70, strEndDate, , "frmCommonList", , "Baseline EndDate", "color:blue;", True, , , True) + "</td>"

                    Else
                        Args.StringToBeInserted = "<td class=ch_1 Title = 'Column Name : Baseline End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtBaselineEndDate" + strOverallScheduleID, "txtBaselineEndDate" + strOverallScheduleID, , 70, strEndDate, , "frmCommonList", , "Baseline EndDate", , True, , , True) + "</td>"

                    End If

                End If
                If Args.DataField.ToLower = "baselineefforts" Then
                    Cancel = True

                    If strBaselineWork Is Nothing Then
                        strBaselineWork = ""
                    Else
                        strBaselineWork = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("BaselineEfforts"), ""))
                    End If

                    Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",5)"

                    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                        Args.StringToBeInserted = "<td class=ch_1 Title = 'Column Name : Baseline Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtBaselineEfforts" + strOverallScheduleID, "txtBaselineEfforts" + strOverallScheduleID, , 70, 14, strBaselineWork, "right", "color:red;", , True, , , "onblur = '" + calculatebaselineefforts_onchange + "'", True, , , , , ) + "</td>"

                    ElseIf IsBaselinedtaskExists = "1" Then
                        Args.StringToBeInserted = "<td class=ch_1 Title = 'Column Name : Baseline Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtBaselineEfforts" + strOverallScheduleID, "txtBaselineEfforts" + strOverallScheduleID, , 70, 14, strBaselineWork, "right", "color:blue;", , True, , , "onblur = '" + calculatebaselineefforts_onchange + "'", True, , , , , ) + "</td>"

                    Else
                        Args.StringToBeInserted = "<td class=ch_1 Title = 'Column Name : Baseline Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtBaselineEfforts" + strOverallScheduleID, "txtBaselineEfforts" + strOverallScheduleID, , 70, 14, strBaselineWork, "right", , , True, , , "onblur = '" + calculatebaselineefforts_onchange + "'", True, , , , , ) + "</td>"

                    End If

                    Args.StringToBeInserted += "<INPUT TYPE=HIDDEN name = txtHidUniqueIDs ID=txtHidUniqueID" + strOverallScheduleID + " VALUE=" + strOverallScheduleID + ">"
                    If strPhaseID = "-99999" Then
                        Args.StringToBeInserted += "<INPUT TYPE=HIDDEN name = txtHidNonPhaseRow ID=txtHidNonPhaseRow VALUE=" + strOverallScheduleID + ">"
                    End If

                End If

                If Args.DataField.ToLower = "actualworkingdays" Then
                    Cancel = True

                    If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("Actualworkingdays"), "")) = "" Then
                        If CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentDuration"), "") = "" Then
                            strCurrentDuration = strCurrentDuration
                        Else
                            strCurrentDuration = CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentDuration"), "")
                        End If
                    Else
                        strActualworkingDays = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("Actualworkingdays"), ""))
                    End If


                    Dim calculateactualworkingdays_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",6)"

                    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                        Args.StringToBeInserted = "<td style='border-right:2px solid;' class=ch_1 Title = 'Column Name : Baseline Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtActualworkingdays" + strOverallScheduleID, "txtActualworkingdays" + strOverallScheduleID, , 70, 14, strActualworkingDays, "right", "color:red;background-color:#FAFAFA;", True, True, , , "onblur = '" + calculateactualworkingdays_onchange + "'", True, , , , , ) + "</td>"
                        Args.StringToBeInserted += "<td style='border-right:2px solid;' class=Blank_1 >&nbsp;</td>"
                    ElseIf IsBaselinedtaskExists = "1" Then
                        Args.StringToBeInserted = "<td style='border-right:2px solid;' class=ch_1 Title = 'Column Name : Baseline Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtActualworkingdays" + strOverallScheduleID, "txtActualworkingdays" + strOverallScheduleID, , 70, 14, strActualworkingDays, "right", "color:blue;background-color:#FAFAFA;", True, True, , , "onblur = '" + calculateactualworkingdays_onchange + "'", True, , , , , ) + "</td>"
                        Args.StringToBeInserted += "<td class=Blank_1 >&nbsp;</td>"
                    Else
                        Args.StringToBeInserted = "<td style='border-right:2px solid;' class=ch_1 Title = 'Column Name : Baseline Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtActualworkingdays" + strOverallScheduleID, "txtActualworkingdays" + strOverallScheduleID, , 70, 14, strActualworkingDays, "right", "background-color:#FAFAFA;", True, True, , , "onblur = '" + calculateactualworkingdays_onchange + "'", True, , , , , ) + "</td>"
                        Args.StringToBeInserted += "<td style='border-right:2px solid;' class=Blank_1 >&nbsp;</td>"
                    End If

                End If

                If Args.DataField.ToLower = "currentstartdate" Then
                    Cancel = True

                    If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentStartDate"), "")) = "" Then

                        strCurrentStartDate = strCurrentStartDate
                    Else
                        'strCurrentStartDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentStartDate"), ""))
                    End If

                    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                        Args.StringToBeInserted = "<td class=ch_2 Title = 'Column Name : Current Start Date' style='white-space:nowrap;border-left:2px solid;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtCurrentStartDate" + strOverallScheduleID, "txtCurrentStartDate" + strOverallScheduleID, , 70, strCurrentStartDate, , "frmCommonList", , "Current StartDate", "color:red;background-color:#FAFAFA;", True, , , True, True) + "</td>"
                    ElseIf IsBaselinedtaskExists = "1" Then
                        Args.StringToBeInserted = "<td class=ch_2 Title = 'Column Name : Current Start Date' style='white-space:nowrap;border-left:2px solid;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtCurrentStartDate" + strOverallScheduleID, "txtCurrentStartDate" + strOverallScheduleID, , 70, strCurrentStartDate, , "frmCommonList", , "Current StartDate", "color:blue;background-color:#FAFAFA;", True, , , True, True) + "</td>"
                    Else
                        Args.StringToBeInserted = "<td class=ch_2 Title = 'Column Name : Current Start Date' style='white-space:nowrap;border-left:2px solid;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtCurrentStartDate" + strOverallScheduleID, "txtCurrentStartDate" + strOverallScheduleID, , 70, strCurrentStartDate, , "frmCommonList", , "Current StartDate", "background-color:#FAFAFA;", True, , , True, True) + "</td>"
                    End If

                End If
                If Args.DataField.ToLower = "currentenddate" Then
                    Cancel = True

                    If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentEndDate"), "")) = "" Then

                        strCurrentEndDate = strCurrentEndDate
                    Else
                        'strCurrentEndDate = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentEndDate"), ""))
                    End If

                    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                        Args.StringToBeInserted = "<td class=ch_2 Title = 'Column Name : Current End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtCurrentEndDate" + strOverallScheduleID, "txtCurrentEndDate" + strOverallScheduleID, , 70, strCurrentEndDate, , "frmCommonList", , "Current EndDate", "color:red;background-color:#FAFAFA;", True, , , True, True) + "</td>"
                    ElseIf IsBaselinedtaskExists = "1" Then
                        Args.StringToBeInserted = "<td class=ch_2 Title = 'Column Name : Current End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtCurrentEndDate" + strOverallScheduleID, "txtCurrentEndDate" + strOverallScheduleID, , 70, strCurrentEndDate, , "frmCommonList", , "Current EndDate", "color:blue;background-color:#FAFAFA;", True, , , True, True) + "</td>"
                    Else
                        Args.StringToBeInserted = "<td class=ch_2 Title = 'Column Name : Current End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtCurrentEndDate" + strOverallScheduleID, "txtCurrentEndDate" + strOverallScheduleID, , 70, strCurrentEndDate, , "frmCommonList", , "Current EndDate", "background-color:#FAFAFA;", True, , , True, True) + "</td>"
                    End If

                End If
                If Args.DataField.ToLower = "currenteffort" Then
                    Cancel = True

                    If CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentEffort"), "0")) = "" Then

                        strCurrentEfforts = strCurrentEfforts
                    Else
                        'strCurrentEfforts = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentEffort"), ""))
                    End If

                    Dim CalculateCurrentEfforts_OnChange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",10)"

                    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                        Args.StringToBeInserted = "<td class=ch_2 Title = 'Column Name : Current Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtCurrentEfforts" + strOverallScheduleID, "txtCurrentEfforts" + strOverallScheduleID, , 70, 14, strCurrentEfforts, "right", "color:red;background-color:#FAFAFA;", , True, , , "onblur = '" + CalculateCurrentEfforts_OnChange + "'", True, , , , , ) + "</td>"
                    ElseIf IsBaselinedtaskExists = "1" Then
                        Args.StringToBeInserted = "<td class=ch_2 Title = 'Column Name : Current Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtCurrentEfforts" + strOverallScheduleID, "txtCurrentEfforts" + strOverallScheduleID, , 70, 14, strCurrentEfforts, "right", "color:blue;background-color:#FAFAFA;", , True, , , "onblur = '" + CalculateCurrentEfforts_OnChange + "'", True, , , , , ) + "</td>"
                    Else
                        Args.StringToBeInserted = "<td class=ch_2 Title = 'Column Name : Current Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtCurrentEfforts" + strOverallScheduleID, "txtCurrentEfforts" + strOverallScheduleID, , 70, 14, strCurrentEfforts, "right", "background-color:#FAFAFA;", , True, , , "onblur = '" + CalculateCurrentEfforts_OnChange + "'", True, , , , , ) + "</td>"
                    End If

                End If
                If Args.DataField.ToLower = "currentduration" Then
                    Cancel = True

                    Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",7)"

                    If CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentDuration"), "") = "" Then
                        strCurrentDuration = strCurrentDuration
                    Else
                        'strCurrentDuration = CommonFunctions.General.CheckIsNothing(Args.DataReader("CurrentDuration"), "")
                    End If

                    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                        Args.StringToBeInserted = "<td style='border-right:2px solid;' class=ch_2 Title = 'Column Name : Current Duration (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtCurrentDuration" + strOverallScheduleID, "txtCurrentDuration" + strOverallScheduleID, , 70, 14, strCurrentDuration, "right", "color:red;background-color:#FAFAFA;", , True, , , , True, , , , , ) + "</td>"
                        Args.StringToBeInserted += "<td style='border-right:2px solid;border-left:2px solid;' class=Blank_2 >&nbsp;</td>"
                    ElseIf IsBaselinedtaskExists = "1" Then
                        Args.StringToBeInserted = "<td style='border-right:2px solid;' class=ch_2 Title = 'Column Name : Current Duration (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtCurrentDuration" + strOverallScheduleID, "txtCurrentDuration" + strOverallScheduleID, , 70, 14, strCurrentDuration, "right", "color:blue;background-color:#FAFAFA;", , True, , , , True, , , , , ) + "</td>"
                        Args.StringToBeInserted += "<td style='border-right:2px solid;border-left:2px solid;' class=Blank_2 >&nbsp;</td>"
                    Else
                        Args.StringToBeInserted = "<td style='border-right:2px solid;' class=ch_2 Title = 'Column Name : Current Duration (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtCurrentDuration" + strOverallScheduleID, "txtCurrentDuration" + strOverallScheduleID, , 70, 14, strCurrentDuration, "right", "background-color:#FAFAFA;", , True, , , , True, , , , , ) + "</td>"
                        Args.StringToBeInserted += "<td style='border-right:2px solid;border-left:2px solid;' class=Blank_2 >&nbsp;</td>"
                    End If

                End If

                If Args.DataField.ToLower = "actualstartdate" Then
                    Cancel = True
                    strMappedString = strMappedString.ToString + strOverallScheduleID + ","

                    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                        Args.StringToBeInserted = "<td class=ch_3 Title = 'Column Name : Actual Start Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtActualStartDate" + strOverallScheduleID, "txtActualStartDate" + strOverallScheduleID, , 70, strActualStartDate, , "frmCommonList", , "Actual StartDate", "color:red;background-color:#FAFAFA;", True, True, , True) + "</td>"
                    ElseIf IsBaselinedtaskExists = "1" Then
                        Args.StringToBeInserted = "<td class=ch_3 Title = 'Column Name : Actual Start Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtActualStartDate" + strOverallScheduleID, "txtActualStartDate" + strOverallScheduleID, , 70, strActualStartDate, , "frmCommonList", , "Actual StartDate", "color:blue;background-color:#FAFAFA;", True, True, , True) + "</td>"
                    Else
                        Args.StringToBeInserted = "<td class=ch_3 Title = 'Column Name : Actual Start Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtActualStartDate" + strOverallScheduleID, "txtActualStartDate" + strOverallScheduleID, , 70, strActualStartDate, , "frmCommonList", , "Actual StartDate", "background-color:#FAFAFA;", True, True, , True) + "</td>"
                    End If

                End If

                If Args.DataField.ToLower = "actualenddate" Then
                    Cancel = True

                    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                        Args.StringToBeInserted = "<td class=ch_3 Title = 'Column Name : Actual End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtActualEndDate" + strOverallScheduleID, "txtActualEndDate" + strOverallScheduleID, , 70, strActualEndDate, , "frmCommonList", , "Actual EndDate", "color:red;background-color:#FAFAFA;", True, True, , True) + "</td>"
                    ElseIf IsBaselinedtaskExists = "1" Then
                        Args.StringToBeInserted = "<td class=ch_3 Title = 'Column Name : Actual End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtActualEndDate" + strOverallScheduleID, "txtActualEndDate" + strOverallScheduleID, , 70, strActualEndDate, , "frmCommonList", , "Actual EndDate", "color:blue;background-color:#FAFAFA;", True, True, , True) + "</td>"
                    Else
                        Args.StringToBeInserted = "<td class=ch_3 Title = 'Column Name : Actual End Date' style='white-space:nowrap;'>" + CommonFunctions.HTMLControls.DrawDateControl("txtActualEndDate" + strOverallScheduleID, "txtActualEndDate" + strOverallScheduleID, , 70, strActualEndDate, , "frmCommonList", , "Actual EndDate", "background-color:#FAFAFA;", True, True, , True) + "</td>"
                    End If

                End If
                If Args.DataField.ToLower = "actualefforts" Then
                    Cancel = True

                    Dim calculatebaselineefforts_onchange As String = "checkCalculate(" + strOverallScheduleID.ToString + ",7)"

                    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                        Args.StringToBeInserted = "<td style='border-right:2px solid;' class=ch_3 Title = 'Column Name : Actual Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtActualWork" + strOverallScheduleID, "txtActualWork" + strOverallScheduleID, , 70, 14, strActualWork, "right", "color:red;background-color:#FAFAFA;", , True, , , "onblur = '" + calculatebaselineefforts_onchange + "'", True, , , , , ) + "</td>"
                        Args.StringToBeInserted += "<td style='border-right:2px solid;' class=Blank_3 >&nbsp;</td>"
                    ElseIf IsBaselinedtaskExists = "1" Then
                        Args.StringToBeInserted = "<td style='border-right:2px solid;' class=ch_3 Title = 'Column Name : Actual Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtActualWork" + strOverallScheduleID, "txtActualWork" + strOverallScheduleID, , 70, 14, strActualWork, "right", "color:blue;background-color:#FAFAFA;", , True, , , "onblur = '" + calculatebaselineefforts_onchange + "'", True, , , , , ) + "</td>"
                        Args.StringToBeInserted += "<td style='border-right:2px solid;' class=Blank_3 >&nbsp;</td>"
                    Else
                        Args.StringToBeInserted = "<td style='border-right:2px solid;' class=ch_3 Title = 'Column Name : Actual Efforts (PHrs)'>" + CommonFunctions.HTMLControls.DrawTextBox("txtActualWork" + strOverallScheduleID, "txtActualWork" + strOverallScheduleID, , 70, 14, strActualWork, "right", "background-color:#FAFAFA;", , True, , , "onblur = '" + calculatebaselineefforts_onchange + "'", True, , , , , ) + "</td>"
                        Args.StringToBeInserted += "<td style='border-right:2px solid;' class=Blank_3 >&nbsp;</td>"
                    End If

                End If



                'Commented By Bharat T on 13th-Oct-2016 to remove sv and ev columns from grid
                ' ''If Args.DataField.ToLower = "schedulevariance" Then
                ' ''    Cancel = True
                ' ''    Dim strSQL1 As String
                ' ''    Dim strAns As String

                ' ''    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                ' ''        Args.StringToBeInserted = "<td Title = 'Column Name : Schedule Variance'>" + CommonFunctions.HTMLControls.DrawTextBox("txtschedulevariance" + strOverallScheduleID, "txtschedulevariance" + strOverallScheduleID, , 70, 14, strScheduleVariance, "right", "color:red;background-color:#FAFAFA;", , True, , , "disabled", True, , , , , ) + "</td>"
                ' ''    ElseIf IsBaselinedtaskExists = "1" Then
                ' ''        Args.StringToBeInserted = "<td Title = 'Column Name : Schedule Variance'>" + CommonFunctions.HTMLControls.DrawTextBox("txtschedulevariance" + strOverallScheduleID, "txtschedulevariance" + strOverallScheduleID, , 70, 14, strScheduleVariance, "right", "color:blue;background-color:#FAFAFA;", , True, , , "disabled", True, , , , , ) + "</td>"
                ' ''    Else
                ' ''        Args.StringToBeInserted = "<td Title = 'Column Name : Schedule Variance'>" + CommonFunctions.HTMLControls.DrawTextBox("txtschedulevariance" + strOverallScheduleID, "txtschedulevariance" + strOverallScheduleID, , 70, 14, strScheduleVariance, "right", "background-color:#FAFAFA;", , True, , , "disabled", True, , , , , ) + "</td>"
                ' ''    End If

                ' ''End If
                ' ''If Args.DataField.ToLower = "effortvariance" Then
                ' ''    Cancel = True
                ' ''    Dim strSQL2 As String
                ' ''    Dim strAns1 As String

                ' ''    strEffortVariance = strEffortVariance

                ' ''    If IsScheduleChanged = "1" Or strScheduleVariance > "0" Then
                ' ''        Args.StringToBeInserted = "<td Title = 'Column Name : Effort Variance'>" + CommonFunctions.HTMLControls.DrawTextBox("txteffortvariance" + strOverallScheduleID, "txteffortvariance" + strOverallScheduleID, , 70, 14, strEffortVariance, "right", "color:red;background-color:#FAFAFA;", , True, , , "disabled", True, , , , , ) + "</td>"
                ' ''    ElseIf IsBaselinedtaskExists = "1" Then
                ' ''        Args.StringToBeInserted = "<td Title = 'Column Name : Effort Variance'>" + CommonFunctions.HTMLControls.DrawTextBox("txteffortvariance" + strOverallScheduleID, "txteffortvariance" + strOverallScheduleID, , 70, 14, strEffortVariance, "right", "color:blue;background-color:#FAFAFA;", , True, , , "disabled", True, , , , , ) + "</td>"
                ' ''    Else
                ' ''        Args.StringToBeInserted = "<td Title = 'Column Name : Effort Variance'>" + CommonFunctions.HTMLControls.DrawTextBox("txteffortvariance" + strOverallScheduleID, "txteffortvariance" + strOverallScheduleID, , 70, 14, strEffortVariance, "right", "background-color:#FAFAFA;", , True, , , "disabled", True, , , , , ) + "</td>"
                ' ''    End If

                ' ''End If
                'End of Commented By Bharat T on 13th-Oct-2016 to remove sv and ev columns from grid

            End If
        End If
    End Sub
    'Protected Overrides Sub Before_GridColumnHeaderTR_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub
    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        PlotNote()

        If Args.ColumnName.ToUpper = "OS SNAPSHOT DATE" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "LAST MODIFIED ON" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "SNAPSHOT NO" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "BASELINED ON" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "BASELINE ID" Then
            Cancel = True

        End If
        Dim Projectid As String
        Projectid = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0")
        If Args.ColumnName.ToUpper = "OS COMBINATIONS" Or Args.ColumnName.ToUpper = "OS" Then
            'Args.ColumnName = "Delete"
            'Dim ReplaceString As String = CStr(CommonFunctions.Data.GetDataScalar("select dbo.fun_Sel_tbl_WPBN_PM_OverallSchedule_SMIIP_OSCombination('S','M','I','R','P','Mi','D',null,(CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session('intProjectID')), ""))", True))

            Dim ReplaceString As String = CStr(CommonFunctions.Data.GetDataScalar("Usp_Sel_OSCombinationHeader " + Projectid + "", True))
            'Args.StringToBeInserted = ReplaceString
            Args.ColumnName = ReplaceString
        End If


        If WhizGlobal.TagID = "20177" Then
            If Args.DataField.ToUpper = "ACTUALWORKINGDAYS" Then
                ' Cancel = True
                'Args.StringToBeInserted = "<td class=Baseline ondblclick=expcoll(this) align=Left>Total Duration (Days) <a name=Actualworkingdays_GridCol_DesignMode title=Configure id=Actualworkingdays_GridCol_DesignMode style='text-decoration: none;' href=javascript:OpenProperties('CONTROLPROPERTIES',20177,'','Tag','Actualworkingdays','')>&nbsp;<img height=11 src=../../Images/cssImages/Link Images/Configure.gif border=0></a> </td>"
                Args.TDStyle = "class=ch_1 ondblclick=expcoll(this) style='border-right:2px solid;'"
                Args.StringToBeInserted += "<td style='border-right:2px solid;' class=Blank_1 ondblclick=expcoll(this) ><a  class=Blank_1 href=# onclick=expcoll_new(this) ><img src='../../Images/plus.gif' border=0></a><br>B...</td>"

            ElseIf Args.ColumnName.ToUpper = "BASELINE START DATE" Or Args.ColumnName.ToUpper = "BASELINE END DATE" Or Args.ColumnName.ToUpper = "BASELINE EFFORTS (PHRS)." Then
                If Args.ColumnName.ToUpper = "BASELINE START DATE" Then
                    Cancel = True
                    'Args.TDStyle = "id=bsd  class=ch_1 ondblclick=expcoll(this) "
                    Args.StringToBeInserted = "<td id=bsd align=Left class=ch_1 style='display: inline-table;' ondblclick=expcoll(this)><div class=collapseImgDiv><a class=ch_1 href=# onclick=expcoll(this) ><img src='../../Images/minus.gif' border=0></a><br>Baseline Start Date</div></td>"
                    'ElseIf Args.ColumnName.ToUpper = "BASELINE END DATE" Then
                    '    Cancel = True
                    '    Args.StringToBeInserted = "<td align=Left class=ch_1 style='display: inline-table;' ondblclick=expcoll(this)><a class=ch_1 href=# onclick=expcoll(this) ><img src='../../Images/minus.gif' border=0></a><br>Baseline End Date</td>"
                Else
                    Args.TDStyle = "class=ch_1 ondblclick=expcoll(this) "
                End If

            End If
            If Args.DataField.ToUpper = "CURRENTDURATION" Then
                ' Cancel = True
                'Args.StringToBeInserted = "<td class=Baseline ondblclick=expcoll(this) align=Left>Total Duration (Days) <a name=Actualworkingdays_GridCol_DesignMode title=Configure id=Actualworkingdays_GridCol_DesignMode style='text-decoration: none;' href=javascript:OpenProperties('CONTROLPROPERTIES',20177,'','Tag','Actualworkingdays','')>&nbsp;<img height=11 src=../../Images/cssImages/Link Images/Configure.gif border=0></a> </td>"
                Args.TDStyle = "class=ch_2 ondblclick=expcoll(this) style='border-right:2px solid;'"
                Args.StringToBeInserted += "<td style='border-right:2px solid;border-left:2px solid;' class=Blank_2 ondblclick=expcoll(this) ><a class=Blank_2 href=# onclick=expcoll_new(this) ><img src='../../Images/plus.gif' border=0></a><br>C...</td>"
            ElseIf Args.DataField.ToUpper = "CURRENTSTARTDATE" Or Args.DataField.ToUpper = "CURRENTENDDATE" Or Args.DataField.ToUpper = "CURRENTEFFORT" Then
                Args.TDStyle = "class=ch_2 ondblclick=expcoll(this) "
                If Args.DataField.ToUpper = "CURRENTSTARTDATE" Then
                    'Args.TDStyle = "id=csd class=ch_2 ondblclick=expcoll(this) style='border-left:2px solid;' "
                    Cancel = True
                    Args.StringToBeInserted = "<td id=csd align=Left class=ch_2 style='display: inline-table;border-left:2px solid;' ondblclick=expcoll(this)> <div class=collapseImgDiv> <a  class=ch_2 href=# onclick=expcoll(this) ><img src='../../Images/minus.gif' border=0></a><br>Current Start Date</div></td>"
                End If

            End If
            If Args.DataField.ToUpper = "ACTUALEFFORTS" Then
                ' Cancel = True
                'Args.StringToBeInserted = "<td class=Baseline ondblclick=expcoll(this) align=Left>Total Duration (Days) <a name=Actualworkingdays_GridCol_DesignMode title=Configure id=Actualworkingdays_GridCol_DesignMode style='text-decoration: none;' href=javascript:OpenProperties('CONTROLPROPERTIES',20177,'','Tag','Actualworkingdays','')>&nbsp;<img height=11 src=../../Images/cssImages/Link Images/Configure.gif border=0></a> </td>"
                Args.TDStyle = "class=ch_3 ondblclick=expcoll(this) style='border-right:2px solid;'"
                Args.StringToBeInserted += "<td style='border-right:2px solid;' class=Blank_3 ondblclick=expcoll(this) ><a class=Blank_3 href=# onclick=expcoll_new(this) ><img src='../../Images/plus.gif' border=0></a><br>A...</td>"
            ElseIf Args.DataField.ToUpper = "ACTUALSTARTDATE" Or Args.DataField.ToUpper = "ACTUALENDDATE" Then
                If Args.DataField.ToUpper = "ACTUALSTARTDATE" Then
                    'Args.TDStyle = "id=asd class=ch_3 ondblclick=expcoll(this) "
                    Cancel = True
                    Args.StringToBeInserted = "<td id=asd align=Left class=ch_3 style='display: inline-table;' ondblclick=expcoll(this)><div class=collapseImgDiv><a  class=ch_3 href=# onclick=expcoll(this) ><img src='../../Images/minus.gif' border=0></a><br>Actual Start Date</div></td>"

                Else
                    Args.TDStyle = "class=ch_3 ondblclick=expcoll(this) "
                End If

            End If
        End If

    End Sub


    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim sbScript As New System.Text.StringBuilder
        Dim strVerify_SnapShot, strVerify_DeliverySubprogram, StrIsMPPAvailable, strVerify_TtlBaselineEfforts As String

        Dim intProcessgroupID As String = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProcessGroupID"), "0"))
        Dim intProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"))

        Dim strOverallSchedule As String = ""
        Dim StrBaselineEfforts_Sum As String = ""
        If strMappedString.Length <> 0 And strMappedString <> "" Then
            strOverallSchedule = strMappedString.Remove(strMappedString.Length - 1)
            StrBaselineEfforts_Sum = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(" Exec usp_sel_tbl_WPBN_PM_OverallSchedule_BESum " + intProjectID + "," + intProcessgroupID + ",'" + strOverallSchedule + "'", True), "0"))
            sbScript.Append("<Input  Type=hidden  name='StrBaselineEfforts_Sum' id='StrBaselineEfforts_Sum' value='" + StrBaselineEfforts_Sum + "'></TD>")
        End If

        sbScript.Append("<Input  Type=hidden  name='hdnSnapShot_Alert' id='hdnSnapShot_Alert' value='" + strVerify_SnapShot + "'></TD>")
        sbScript.Append("<INPUT TYPE=HIDDEN name = txtHidListUniqueIDs ID=txtHidListUniqueIDs VALUE='" + strMappedString + "'>")
        sbScript.Append("<Input  Type=hidden  name='hdnVerify_DeliverySubprogram' id='hdnVerify_DeliverySubprogram' value='" + strVerify_DeliverySubprogram + "'></TD>")

        sbScript.Append("<Input  Type=hidden  name='hdnVerify_TtlBaselineEfforts' id='hdnVerify_TtlBaselineEfforts' value='" + strVerify_TtlBaselineEfforts + "'></TD>")

        sbScript.Append("<Input  Type=hidden  name='hdnIsMPPAvailable' id='hdnIsMPPAvailable' value='" + StrIsMPPAvailable + "'></TD>")

        sbScript.Append("<SCRIPT>" + vbCrLf)
        sbScript.Append("function txtNumeric_OnChange(objTextBox){" + vbCrLf)
        sbScript.Append("var objText= GetObjectReference('frmCommonList', objTextBox.id);" + vbCrLf)
        sbScript.Append("if(objText!=null && objText.value=='') objText.value=0;}" + vbCrLf)
        sbScript.Append("</SCRIPT>" + vbCrLf)
        Args.ToBeInserted = sbScript.ToString


        sbScript = Nothing

        'HttpContext.Current.Response.Redirect("EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?MasterTagID=20177&FromWhere=PM")
    End Sub
    Protected Function PlotNote() As String
        Dim strPlot As String = "<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader><TD align=Left><b>Note : </b> The Overall schedule plan has been chaged for one or more tasks.</TD></TR></TABLE>"
        Return CStr(strPlot)
    End Function

End Class

