Imports Dundas.Charting.WebControl
Imports System.IO.File
Imports System.IO.StringWriter
Imports System.Text
Imports Whiz
Imports System.Collections.Generic
Public Class ShowProjectDetails
    Inherits WebPages.Template.WhizTemplate
    Protected strProjectID As String = ""
    Protected Shared strReportPath As String
    Protected Shared strLogPath As String
    Protected Shared strLogo As String
    Protected Shared strProject As String
    Protected Shared strImagePath As String
    Protected Shared lngDefaultLCID As Long
    Protected Shared lngCurrentThreadUICultureID As Long

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        Dim strPath As String = Server.MapPath("../../Reports/")
        strReportPath = strPath
        Dim LogPath = Server.MapPath("../../Attachments/Log/")
        strLogPath = LogPath
        Dim logo As String = Server.MapPath("../../images/customerlogo.gif")
        strLogo = logo
        Dim imagePath As String = Server.MapPath("../../Images/")
        strImagePath = imagePath
        Dim defaultlcID As Long = MyBase.DefaultUILCID
        lngDefaultLCID = defaultlcID
        Dim CurrentThreadUICultureID As Long = MyBase.CurrentThreadUICultureID
        lngCurrentThreadUICultureID = CurrentThreadUICultureID
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") = "Get" Then
            'DisplayNonNeedleGraphs(Request.QueryString("DashboardID"), "", "300", "ScheduleVAR")
        ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") = "Update" Then
            Call UpdateGraphType(CommonFunction.General.CheckIsNothing(Request.QueryString("GraphTypeID"), 0), CommonFunction.General.CheckIsNothing(Request.QueryString("DashboardID"), 0))
        ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") = "Select" Then
            If (CommonFunction.General.CheckIsNothing(Request.QueryString("TabID"), 0) = 0) Then    '' Schedule Variance
                Call SelectScheduleVariance(CommonFunction.General.CheckIsNothing(Request.QueryString("AttributeID"), 0))
                'ElseIf (CommonFunction.General.CheckIsNothing(Request.QueryString("TabID"), 0) = 1) Then    '' Effort Variance
                '    Call SelectEffortVariance(CommonFunction.General.CheckIsNothing(Request.QueryString("AttributeID"), 0))
                'ElseIf (CommonFunction.General.CheckIsNothing(Request.QueryString("TabID"), 0) = 2) Then    ''On Time delivery
                '    Call SelectOnTimeDelivery(CommonFunction.General.CheckIsNothing(Request.QueryString("AttributeID"), 0))
                'ElseIf (CommonFunction.General.CheckIsNothing(Request.QueryString("TabID"), 0) = 3) Then    ''Defects Density
                '    Call SelectDefectDensity(CommonFunction.General.CheckIsNothing(Request.QueryString("AttributeID"), 0))
                'ElseIf (CommonFunction.General.CheckIsNothing(Request.QueryString("TabID"), 0) = 4) Then    ''Rework hours
                '    Call SelectReworkHours(CommonFunction.General.CheckIsNothing(Request.QueryString("AttributeID"), 0))
                'ElseIf (CommonFunction.General.CheckIsNothing(Request.QueryString("TabID"), 0) = 5) Then    '' No.Of Deliverable
                '    Call SelectNoOfDeliverables(CommonFunction.General.CheckIsNothing(Request.QueryString("AttributeID"), 0))
                'ElseIf (CommonFunction.General.CheckIsNothing(Request.QueryString("TabID"), 0) = 6) Then    ''No. of Deliverables open
                '    Call SelectNoOfDeliverablesOpen(CommonFunction.General.CheckIsNothing(Request.QueryString("AttributeID"), 0))
                'ElseIf (CommonFunction.General.CheckIsNothing(Request.QueryString("TabID"), 0) = 7) Then    ''No. of Deliverables closed
                '    Call SelectNoOfDeliverablesClosed(CommonFunction.General.CheckIsNothing(Request.QueryString("AttributeID"), 0))
                'ElseIf (CommonFunction.General.CheckIsNothing(Request.QueryString("TabID"), 0) = 8) Then    ''Schedule Slippage on Task 
                '    Call SelectScheduleSlippageOnTask(CommonFunction.General.CheckIsNothing(Request.QueryString("AttributeID"), 0))
            End If
        ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") = "Snapshot" Then
            SelectScheduleVarianceSnapshot(CommonFunction.General.CheckIsNothing(Request.QueryString("AttributeID"), 0), CommonFunction.General.CheckIsNothing(Request.QueryString("SnapshotCount"), 0))
            'ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") = "Report" Then
            '    ShowReport()
        End If
    End Sub

    Public Sub UpdateGraphType(ByVal GraphTypeID As Integer, ByVal DashboardID As Integer)
        Dim StrSQL As String
        StrSQL = "UPDATE tbl_CDB_Item_Details SET GraphTypeID=" & GraphTypeID & ",DrilldowngraphTypeID=" & GraphTypeID & " WHERE DashboardID=" & DashboardID
        CommonFunction.Data.InsertOrUpdateData(StrSQL, True)
        StrSQL = "UPDATE tbl_CDB_Item_Master SET GraphTypeID=" & GraphTypeID & ",DrilldowngraphTypeID=" & GraphTypeID & " WHERE DashboardID=" & DashboardID
        CommonFunction.Data.InsertOrUpdateData(StrSQL, True)
    End Sub

#Region "Method For ScheduleVariance"
    Public Sub SelectScheduleVariance(ByVal AttributeID As String)
        Dim StrSQL As String
        StrSQL = "usp_INS_tbl_PM_ProjectSV_SnapShot " & CommonFunction.General.CheckIsNothing(Request.QueryString("projectId") & "," & Session("intUserID"), 0)
        CommonFunction.Data.GetDataScalar(StrSQL, True)
        StrSQL = "usp_INS_tbl_SV_Temp '" & AttributeID & "', " & CommonFunction.General.CheckIsNothing(Request.QueryString("projectId") & ",1," & Session("intUserID"), 0)
        CommonFunction.Data.GetDataScalar(StrSQL, True)
    End Sub
#End Region

#Region "Method For ScheduleVariance"
    Public Sub SelectScheduleVarianceSnapshot(ByVal AttributeID As String, ByVal intSnapshotCount As String)
        Dim StrSQL As String
        StrSQL = "usp_INS_tbl_PM_ProjectSV_SnapShot " & CommonFunction.General.CheckIsNothing(Request.QueryString("projectId") & "," & Session("intUserID"), 0)
        CommonFunction.Data.GetDataScalar(StrSQL, True)
        StrSQL = "usp_INS_tbl_SV_Temp '" & AttributeID & "', " & CommonFunction.General.CheckIsNothing(Request.QueryString("projectId") & "," & intSnapshotCount & "," & Session("intUserID"), 0)
        CommonFunction.Data.GetDataScalar(StrSQL, True)
    End Sub
#End Region



    Public Sub PlotProjectInformation()
        Dim strQueryBuilder As New StringBuilder

        ''Added By Aniruddh Gujar on 17-May-2016 Purpose::To remove Quick View for Agile Project Type
        Dim isAgile As String
        Dim strQuery As String
        strQuery = "usp_sel_Is_AgileProject " & Request.QueryString("projectId")
        isAgile = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), "")

        If isAgile <> "1" Then
            ''End of Added By Aniruddh Gujar on 17-May-2016 Purpose::To remove Quick View for Agile Project Type
            If Request.QueryString("projectId") IsNot Nothing Then
                strProjectID = Request.QueryString("projectId")
                strProject = Request.QueryString("projectId")

                Dim dtProjectInfo As New DataTable
                'Commented and added By Bharat Tekade on 18th-May-2016 for quick view ui page
                'dtProjectInfo = CommonFunction.Data.GetDataTable("usp_sel_tbl_PM_ProjectInformation_quickview " & strProjectID & "", True)
                dtProjectInfo = CommonFunction.Data.GetDataTable("usp_sel_tbl_PM_ProjectInformation_quickview1 " & strProjectID & "", True)
                'End of Commented and added By Bharat Tekade on 18th-May-2016 for quick view ui page
                strQueryBuilder.Append("<table style='width:99%;'>")
                strQueryBuilder.Append("<tr>")
                strQueryBuilder.Append("<td style='width:30%'>")
                strQueryBuilder.Append("</td>")
                strQueryBuilder.Append("<td align='right' style='width:70%'>")
                'strQueryBuilder.Append("<a href='' >Save as Snapshot/Report</a>")
                'Commented and added by bharat tekade on 17th-May-2016 to change link name
                'strQueryBuilder.Append("<a id='ancSaveSnapshot' class='clsSaveSnapshot' onclick='f_SaveSnapshot()'>Save as Snapshot/Report</a>")
                strQueryBuilder.Append("<a id='ancSaveSnapshot' class='clsSaveSnapshot' onclick='f_SaveSnapshot()'>View Report</a>")
                'End of Commented and added by bharat tekade on 17th-May-2016 to change link name
                strQueryBuilder.Append("</td>")
                strQueryBuilder.Append("</tr>")
                strQueryBuilder.Append("</table></br>")
                If dtProjectInfo IsNot Nothing Then
                    If dtProjectInfo.Rows.Count > 0 Then
                        strQueryBuilder.Append("<table class='tableQuick' rules='rows' style='width:100%;'>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Project Name: ")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("ProjectName").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Description: ")
                        strQueryBuilder.Append("</td style='width:50%'>")
                        strQueryBuilder.Append("<td>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("Description").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Billable: ")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("Billable").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Start Date: ")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("ExpectedStartDate").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("End Date: ")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("ExpectedEndDate").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Work(Hrs): ")
                        strQueryBuilder.Append("</td >")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("EstimatedEfforts").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Project Manager: ")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("ProjectManager").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Count of Resources: ")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("CountOfResources").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Baseline Hrs: ")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("Baseline").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Current Hrs: ")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("CurrentWork").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Actual Hrs: ")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("Actual").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")

                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Open Tasks: ")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("OpenTasks").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("<tr>")
                        strQueryBuilder.Append("<td style='width:50%;vertical-align:top'>")
                        strQueryBuilder.Append("Open Issues: ")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append(dtProjectInfo.Rows(0)("OpenIssues").ToString())
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("</tr>")
                        strQueryBuilder.Append("</table>")
                        strQueryBuilder.Append("<input id='hdnTabsCount' type='hidden' value='0' /><input id='hdnTabID' type='hidden' />")
                        CommonFunction.General.WriteHTML(strQueryBuilder.ToString())
                    End If
                End If
            End If
            FillDropDown()
            PlotTabs()
            ''Added By Aniruddh Gujar on 17-May-2016 Purpose::To remove Quick View for Agile Project Type
        Else
            strQueryBuilder.Append("<table style='width:99%;'>")
            strQueryBuilder.Append("<tr>")
            strQueryBuilder.Append("<td style='width:30%' align=center>")
            strQueryBuilder.Append("Project Progress View is not available for Agile Project Type.")
            strQueryBuilder.Append("</td>")
            strQueryBuilder.Append("</tr>")
            strQueryBuilder.Append("</table></br>")
            CommonFunction.General.WriteHTML(strQueryBuilder.ToString())
            ''End of Added By Aniruddh Gujar on 17-May-2016 Purpose::To remove Quick View for Agile Project Type
        End If
    End Sub
    Public Sub PlotTabs()
        If Request.QueryString("projectId") IsNot Nothing Then
            Dim strQueryBuilder As New StringBuilder
            Dim dtAttr As New DataTable
            dtAttr = CommonFunction.Data.GetDataTable("usp_sel_tbl_PM_GraphAttributes_Quickview", True)
            'Added By Chakshuta H on 27th-Apr-2016:Purpose:To plot Note
            Dim dtAttr1 As New DataTable
            dtAttr1 = CommonFunction.Data.GetDataTable("usp_sel_tbl_PM_GraphAttributes_Quickview_Formula", True)
            'End Of Added By Chakshuta H on 27th-Apr-2016:Purpose:To plot Note

            'strQueryBuilder.Append("<table style='width:100%'>")
            'strQueryBuilder.Append("<ul class=tabs>")
            strQueryBuilder.Append("<div id=""contain""><div class=""accordion"">")
            strQueryBuilder.Append("<div id=tabLab-"" style='height:2%'><table style='width:100%'><tr><td align=Center style='width:33%'>-</td><td align=Center style='width:33%'>0</td><td align=Center style='width:33%'>+</td></tr></table></div>")
            If dtAttr IsNot Nothing Then
                If dtAttr.Rows.Count > 0 Then
                    For i As Integer = 0 To dtAttr.Rows.Count - 1
                        'For j As Integer = 0 To dtAttr.Rows.Count - 1
                        'strQueryBuilder.Append("<li>")
                        'strQueryBuilder.Append("" & dtAttr.Rows(i)(1).ToString())
                        'strQueryBuilder.Append("</li>")
                        'strQueryBuilder.Append("<div id=tabLab-" & i & " style='height:2%'><table style='width:100%'><tr><td align=Left style='width:33%'>-</td><td align=Center style='width:33%'>0</td><td align=Right style='width:33%'>+</td></tr></table></div>")
                        strQueryBuilder.Append("<div id=tab-" & i & ">")    'DIV tab- STARTS
                        'strQueryBuilder.Append("<table style='width:100%'><tr><td align=Left style='width:33%'>-</td><td align=Center style='width:33%'>0</td><td align=Right style='width:33%'>+</td></tr></table>")
                        'strQueryBuilder.Append("<a id=anc" & i & " class=""tab"" style='background:#fff;' title='" & dtAttr.Rows(i)(1).ToString() & "' onclick=""assignID(this," & i & ",'" & Request.QueryString("projectId") & "')""><div id=bar-5" & i & " role='progressbar' aria-valuenow='40' aria-valuemin='0' aria-valuemax='100' style='width:40%' class='progress-bar progress-bar-success progress-bar-striped'><div class=wrap><div class=bar-percentage data-percentage=33></div><div class=bar-container><div class=bar></div></div></div></div><div id=bar-6" & i & " class='bar-main-container divRight'><div class=wrap><div class=bar-percentage data-percentage=33></div><div class=bar-container><div class=bar></div></div></div></div><div class='divLabel'>" & dtAttr.Rows(i)(1).ToString() & "<label id=lbl" & i & "></label></div></a>")
                        'Modified By Chakshuta H on 26th-Apr-2016 
                        'strQueryBuilder.Append("<a id=anc" & i & " class=""tab"" style='background:#fff;' title='" & dtAttr.Rows(i)(1).ToString() & "' onclick=""assignID(this," & i & ",'" & Request.QueryString("projectId") & "')""><div class='progress'>  <div id=bar-5" & i & " class='progress-bar progress-bar-success progress-bar-striped' role='progressbar' aria-valuenow='40'  aria-valuemin='0' aria-valuemax='100' >  </div></div><div class='divLabel'>" & dtAttr.Rows(i)(1).ToString() & "<label id=lbl" & i & "></label></div> </a>")
                        strQueryBuilder.Append("<div style='width:100%'>")
                        'strQueryBuilder.Append("<table style='width:100%'><tr><td><p>-</p></td>")
                        strQueryBuilder.Append("<table style='width:100%'><tr>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append("<a id=anc" & i & " class=""tab"" style='background:#fff;' title='" & dtAttr.Rows(i)(1).ToString() & "' onclick=""assignID(this," & i & ",'" & Request.QueryString("projectId") & "')""><div class='progress'>  <div id=bar-5" & i & " class='progress-bar progress-bar-success progress-bar-striped' role='progressbar' aria-valuenow='40'  aria-valuemin='0' aria-valuemax='100' style='float:right'></div></div><div class='divLabel' id='cap" & i & "'>" & dtAttr.Rows(i)(1).ToString() & "<label id=lbl" & i & "></label></div> </a>")
                        strQueryBuilder.Append("</td>")
                        strQueryBuilder.Append("<td style='width:50%'>")
                        strQueryBuilder.Append("<a id=anc" & i & " class=""tab"" style='background:#fff;' title='" & dtAttr.Rows(i)(1).ToString() & "' onclick=""assignID1(this," & i & ",'" & Request.QueryString("projectId") & "')""><div class='progress'>  <div id=bar-51" & i & " class='progress-bar progress-bar-success progress-bar-striped' role='progressbar' aria-valuenow='40'  aria-valuemin='0' aria-valuemax='100' ></div></div><div class='divLabel' id='cap1" & i & "'>" & dtAttr.Rows(i)(1).ToString() & "<label id=lbl1" & i & "></label></div> </a>")
                        strQueryBuilder.Append("</td>")
                        'strQueryBuilder.Append("<td><p>+</p></td></tr></table>")
                        strQueryBuilder.Append("</tr></table>")
                        strQueryBuilder.Append("</div>")
                        'strQueryBuilder.Append("<div style='width:50%'>")
                        'strQueryBuilder.Append("</div>")
                        'End Of Modified By Chakshuta H on 26th-Apr-2016 

                        strQueryBuilder.Append("<div class=content" & i & ">")    'DIV class=content STARTS
                        strQueryBuilder.Append("<div id=TabGraph" & i & ">")    'TabGraph STARTS

                        strQueryBuilder.Append("<div id=TabGraphTypeDDL" & i & " class='clsTabGraphTypeDDL'>")    'TabGraphTypeDDL STARTS
                        strQueryBuilder.Append("</div>")    'TabGraphTypeDDL ENDS

                        'strQueryBuilder.Append("<div id=TabGraphplot" & i & ">")    'TabGraphplot STARTS
                        'strQueryBuilder.Append("</div>")    'TabGraphplot ENDS
                        strQueryBuilder.Append("<div id='divGraphs" & i & "' runat=""server"">")
                        'Added By Chakshuta H on 27th-Apr-2016:Purpose:To plot Note
                        strQueryBuilder.Append("<div id='Note" & i & "' runat=""server"" style='margin-top:7px;font-size: 12px;'><strong>Note:</strong>" & dtAttr1.Rows(i)(1).ToString() & "</div>")
                        'End Of Added By Chakshuta H on 27th-Apr-2016:Purpose:To plot Note
                        strQueryBuilder.Append("<table id='tblGraphs" & i & "' runat=""server"" cellpadding=""0"" cellspacing=""0"" align=""middle""></table>")
                        strQueryBuilder.Append("<iframe id='frameGraph" & i & "' height='330' width='515' style='border:0'  ></iframe>")   ''src='../Home/ShowProjectDetailGraph.aspx?FromWhere=ADMIN&DashboardID=20018'
                        strQueryBuilder.Append("</div>")

                        strQueryBuilder.Append("</div>")    'TabGraph ENDS
                        strQueryBuilder.Append("</div>")    'DIV class=content ENDS
                        strQueryBuilder.Append("</div>")    'DIV tab- ENDS
                        'Next
                    Next
                    strQueryBuilder.Append("<script>document.getElementById(""hdnTabsCount"").value='" & dtAttr.Rows.Count & "';</script>")
                End If
            End If
            strQueryBuilder.Append("</div></div>")
            'strQueryBuilder.Append("</ul>")
            'strQueryBuilder.Append("</table>")
            CommonFunction.General.WriteHTML(strQueryBuilder.ToString())
        End If
    End Sub

    Public Sub FillDropDown()
        If Request.QueryString("projectId") IsNot Nothing Then
            Dim strQueryBuilder As New StringBuilder
            Dim StrQry As String = "usp_sel_tbl_PM_WBSAttributes"
            strQueryBuilder.Append("<br /><table style='width:100%'>")


            strQueryBuilder.Append("<tr>")
            'Commented By Chakshuta H on 27th-Apr-2016
            'strQueryBuilder.Append("<td>")
            'strQueryBuilder.Append("<div style='width:10px;height:10px;border:1px solid #CCC;background-color:#47BC7C'></div>")
            'strQueryBuilder.Append("</td>")
            'strQueryBuilder.Append("<td style='width:26%'>")
            'strQueryBuilder.Append("<div class='clsdisplay'> -100 to -5</div>")
            'strQueryBuilder.Append("</td>")
            'strQueryBuilder.Append("<td align='right' style='width:70%'>")
            'strQueryBuilder.Append("</td>")
            'strQueryBuilder.Append("</tr>")
            'strQueryBuilder.Append("<tr>")
            'strQueryBuilder.Append("<td>")
            'strQueryBuilder.Append("<div style='width:10px;height:10px;border:1px solid #CCC;background-color:#EBC620'></div>")
            'strQueryBuilder.Append("</td>")
            'strQueryBuilder.Append("<td style='width:26%'>")
            'strQueryBuilder.Append("<div class='clsdisplay'> -5 to 5</div>")
            'strQueryBuilder.Append("</td>")
            'strQueryBuilder.Append("<td align='right' style='width:70%'>")
            'strQueryBuilder.Append("</td>")
            'strQueryBuilder.Append("</tr>")
            'strQueryBuilder.Append("<tr>")
            'strQueryBuilder.Append("<td>")
            'strQueryBuilder.Append("<div style='width:10px;height:10px;border:1px solid #CCC;background-color:#F05E3D'></div>")
            'strQueryBuilder.Append("</td>")
            'strQueryBuilder.Append("<td style='width:26%'>")
            'strQueryBuilder.Append("<div class='clsdisplay'> 5 to 100</div>")
            'strQueryBuilder.Append("</td>")
            'Added By Chakshuta H on 27th-Apr-2016
            strQueryBuilder.Append("<td align='right' style='width:70%'>")
            strQueryBuilder.Append(CommonFunctions.HTMLControls.DrawComboBox("cboAttributes", StrQry, 250, , "OnChange='ChangeAttribute(this)'", , True))
            strQueryBuilder.Append("</td>")
            strQueryBuilder.Append("</tr>")
            strQueryBuilder.Append("</table>")
            CommonFunction.General.WriteHTML(strQueryBuilder.ToString())
        End If
    End Sub
    Protected Shared WithEvents m_oReport As DynamicReports.Report
    Private Shared WithEvents oRpt As AdHocReports.Report.AdHocReport
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowReport(TabID As String, userID As String, attribute As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        TabID = Utilities.Security.SecurityBuilder.CheckUserInput(TabID, 2, True, False, False)
        userID = Utilities.Security.SecurityBuilder.CheckUserInput(userID, 2, True, False, False)
        attribute = Utilities.Security.SecurityBuilder.CheckUserInput(attribute, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : ShowReport
        ' Purpose               : Function used to generate the Report depending on the Chosen Format
        ' Description           : The Chosen Format is specified in Querystring
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat K
        ' Created               : 31/03/2016
        ' Revisions             :
        '=====================================================================
        Try
            Dim strQuery As String = ""

            Const CONST_ERROR_LOG As String = "../../Attachments/Log/"
            Dim strFormat, strFileName As String
            Dim sExtension, sFilePath, sPath, strViewID As String
            Dim objResult As Object
            Dim dsReport As New DataSet
            Dim strMaxSnapshotID As Integer

            Dim m_lngReportID As Integer = 20127
            If TabID = "all" Then
                'Commented and Added By Bharat Tekade on 30th-May-2016 for to pass max snapshot id for quick view report           
                'strQuery = "usp_sel_tbl_PM_ProjectInformation_quickview " & strProject & "," & userID & ""
                strMaxSnapshotID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Sel_tbl_PM_ProjectInformation_quickview_MaxSnapshotID " & strProject, True), 0)
                strQuery = "usp_sel_tbl_PM_ProjectInformation_quickview " & strProject & "," & strMaxSnapshotID & "," & userID & ""
                'End of Commented and Added By Bharat Tekade on 30th-May-2016 for to pass max snapshot id for quick view report
            End If
            dsReport = CommonFunctions.Data.GetDataSet(strQuery, True)
            sExtension = ".pdf"
            ' Create a random and Unique file name
            sFilePath = CommonFunction.FileDirectory.GetUniqueFileName()
            sPath = strReportPath + sFilePath + sExtension
            strFileName = sFilePath + sExtension
            ' Create the report object ''.SQLSource = strQuery
            'm_oReport = New DynamicReports.Report
            '' set the properties and generate the report
            'With m_oReport
            '    .ConnectionString = CommonFunctions.Application.ConnectionString
            '    .FilePathName = sPath
            '    .ErrorLogFilePathName = CommonFunctions.FileDirectory.CleanPath(strLogPath)
            '    .ReportDataSource = dsReport
            '    .Title = "Score Card"
            '    .EmptyValueReplacement = "-"
            '    .LogoPathName = strLogo
            '    .UseMSSQL = True
            '    .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
            '    'Modified by vidyak for PDF Higher Versions
            '    .FontName = "Verdana"
            '    'End Modified by vidyak for PDF Higher Versions
            '    .CompanyName = CommonFunctions.Application.CompanyName
            'End With
            'm_oReport.GenerateReport(DynamicReports.Format.PDF)
            'm_oReport = Nothing
            'strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(strFileName))
            oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strQuery, CommonFunctions.Application.ConnectionString, sPath, CommonFunctions.FileDirectory.CleanPath(strLogPath))
            With oRpt
                .UseMSSQL = True
                .DefaultLCID = CType(lngDefaultLCID, Integer)
                .LCID = lngCurrentThreadUICultureID
                If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                    .UseHashTables = True
                Else
                    .UseHashTables = False
                End If
                '.UIParameters = strCaptions
                '.UIParametersDelimiter = "|"
                '.WatermarkImageFilePath = ""
                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName
                .GraphImageGenerationAbsolutePath = strImagePath

                ' generate the report in requested format

                .GenerateReport(AdHocReports.Format.PDF)
            End With
            oRpt = Nothing

            Return strFileName
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
        ' End Modification By NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 63 

    End Function


    <System.Web.Services.WebMethod> _
    Public Shared Function GetGraphTypeDropDown() As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim StrQry As String = "usp_tbl_CDB_GraphTypes"
            Dim dt As New DataTable
            dt = CommonFunction.Data.GetDataTable(StrQry, True)
            Return GetSerialized(dt)
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    '<System.Web.Services.WebMethod> _
    'Public Shared Function GetScheduleVariance(ByVal ProjectID As String) As String
    '    Try
    '        Dim StrQry As String = "usp_Sel_ScheduleVariance " & ProjectID & ", 'Project', NULL, NULL"
    '        Dim dt As New DataTable
    '        dt = CommonFunction.Data.GetDataTable(StrQry, True)
    '        Return GetSerialized(dt)
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetScheduleVariancePercentage(ByVal intProjectID As String, ByVal strType As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        intProjectID = Utilities.Security.SecurityBuilder.CheckUserInput(intProjectID, 2, True, False, False)
        strType = Utilities.Security.SecurityBuilder.CheckUserInput(strType, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            ''Dim StrQry As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT ScheduleVariance FROM  tbl_SV_Temp", True), "")
            Dim StrQry As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_SV_Temp_ScheduleVariance", True), "")
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            Return StrQry
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SelectEffortVariance(ByVal projectID As String, ByVal AttributeID As String, ByVal userID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        projectID = Utilities.Security.SecurityBuilder.CheckUserInput(projectID, 2, True, False, False)
        AttributeID = Utilities.Security.SecurityBuilder.CheckUserInput(AttributeID, 2, True, False, False)
        userID = Utilities.Security.SecurityBuilder.CheckUserInput(userID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim StrSQL As String
            StrSQL = "usp_Sel_Effort_Variance_Quickview " & projectID & ",'" & AttributeID & "',1," & userID
            StrSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(StrSQL, True), "")
            Return StrSQL
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SelectOnTimeDelivery(ByVal projectId As String, ByVal userid As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        projectId = Utilities.Security.SecurityBuilder.CheckUserInput(projectId, 2, True, False, False)
        userid = Utilities.Security.SecurityBuilder.CheckUserInput(userid, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim StrSQL As String
            StrSQL = "usp_UD_Sel_OnTimedelivery " & projectId & ",1," & userid
            StrSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(StrSQL, True), "")
            Return StrSQL
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SelectDefectDensity(ByVal projectId As String, ByVal userid As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        projectId = Utilities.Security.SecurityBuilder.CheckUserInput(projectId, 2, True, False, False)
        userid = Utilities.Security.SecurityBuilder.CheckUserInput(userid, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim StrSQL As String
            StrSQL = "usp_Sel_DefectDensity " & projectId & ",1," & userid
        StrSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(StrSQL, True), "")
        Return StrSQL
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SelectReworkHours(ByVal projectId As String, ByVal userID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        projectId = Utilities.Security.SecurityBuilder.CheckUserInput(projectId, 2, True, False, False)
        userID = Utilities.Security.SecurityBuilder.CheckUserInput(userID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim StrSQL As String
            Dim dtSetReworkHours As New DataTable
            StrSQL = "usp_GetReworkHours_Quickview " & projectId & ",1," & userID
            dtSetReworkHours = CommonFunction.Data.GetDataTable(StrSQL, True)
            StrSQL = dtSetReworkHours.Rows(0).Item("ReworkHours").ToString()
            Return StrSQL
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SelectNoOfDeliverables(ByVal projectId As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        projectId = Utilities.Security.SecurityBuilder.CheckUserInput(projectId, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim StrSQL As String
            StrSQL = "usp_Sel_TotalNoOfDeliverables " & projectId & ""
            StrSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(StrSQL, True), "")
            Return StrSQL
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SelectNoOfDeliverablesOpen(ByVal projectId As String, ByVal userID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        projectId = Utilities.Security.SecurityBuilder.CheckUserInput(projectId, 2, True, False, False)
        userID = Utilities.Security.SecurityBuilder.CheckUserInput(userID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim StrSQL As String
            Dim dtSetDeliverable As New DataTable
            StrSQL = "usp_Sel_TotalNoOfDeliverables_Quickview " & projectId & ",1," & userID
            dtSetDeliverable = CommonFunction.Data.GetDataTable(StrSQL, True)
            StrSQL = dtSetDeliverable.Rows(0).Item("Open").ToString()
            Return StrSQL
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SelectNoOfDeliverablesClosed(ByVal projectId As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        projectId = Utilities.Security.SecurityBuilder.CheckUserInput(projectId, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim StrSQL As String
            StrSQL = "usp_Sel_TotalNoOfDeliverablesClosed " & projectId & ""
            StrSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(StrSQL, True), "")
            Return StrSQL
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SelectScheduleSlippageOnTask(ByVal projectId As String, ByVal AttributeID As String, ByVal userID As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        projectId = Utilities.Security.SecurityBuilder.CheckUserInput(projectId, 2, True, False, False)
        AttributeID = Utilities.Security.SecurityBuilder.CheckUserInput(AttributeID, 2, True, False, False)
        userID = Utilities.Security.SecurityBuilder.CheckUserInput(userID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim StrSQL As String
            StrSQL = "usp_sel_ScheduleSlippage " & projectId & ",'" & AttributeID & "',1," & userID
            StrSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(StrSQL, True), "")
            Return StrSQL
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    'Added By Bharat Tekade on 20th-May-2016 for give an alert if snapshot is not taken to view the report
    <System.Web.Services.WebMethod> _
    Public Shared Function CheckSnapshotTaken(ByVal ProjectID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        ProjectID = Utilities.Security.SecurityBuilder.CheckUserInput(ProjectID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim StrSQL As String
            StrSQL = "Usp_Check_IsOSSnapshotTaken " & ProjectID & ""
            StrSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(StrSQL, True), "")
            Return StrSQL
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    'End of Added By Bharat Tekade on 20th-May-2016 for give an alert if snapshot is not taken to view the report
    Public Shared Function GetSerialized(dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        Return serializer.Serialize(rows)
    End Function



End Class
