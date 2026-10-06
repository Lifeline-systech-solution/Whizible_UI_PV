'=====================================================================
' Module Name   :     IB_StatusReport

' Purpose       :     Status and duration based report for Issues

' Description   :     Same as Above

' Dependencies  :     None

' Author        :     DipaliS

' Created       :     March 23, 2004

' Revisions     :   
'=====================================================================

Public Class IB_StatusReport
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        ''Added by Yogesh J on on 02-FEB-2016 to validate Token
        If Request.QueryString("cboFromStatus") <> "" And Request.QueryString("PKToken") <> "" And Request.QueryString("txtFromDate") <> "" Then

            If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("cboFromStatus"), String) + CType(Request.QueryString("cboToStatus"), String) + CType(Request.QueryString("txtFromDate"), String) + CType(Request.QueryString("txtToDate"), String) + CType(Request.QueryString("cboView"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Show Report", 0, 0, "ViewID", CType(Request.QueryString("cboView"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If


        End If
        ''End of addition by Yogesh J on on 02-FEB-2016 to validate Token
    End Sub

#End Region

#Region "Member Variables"
    Private m_strIssueCaption As String = ""
    Private m_strPageCaption As String
    Private m_strProjectID As String
    Private m_strMenu As String
    Private m_strFromStatus As String
    Private m_strToStatus As String
    Private m_strFromDate As String = ""
    Private m_strToDate As String = ""
    Private m_strView As String
    Private WithEvents m_objGrid As New WebPages.Template.AdvancedGrid
    Protected m_strToken As String
#End Region

#Region "Constructor"
    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.IB_StatusReport", "AppResources")
    End Sub
#End Region

#Region "Procedures"

    Public Sub PageInit()
        '######### Page Code starts here

        'Initilly draw the UI for Selecting the parameters for the Report
        If Request.QueryString("Action") = "" Then

            GetIssueCaption(10)

            GetMenu()

            GetPageLegend()

            GetPageCaption()

            'Page Div Tag

            Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")

            GetUI()

            Response.Write("</DIV>")

            GetFooterMenu()
        Else
            Dim strSQL As String
            m_strFromStatus = Request.QueryString("cboFromStatus")
            m_strToStatus = Request.QueryString("cboToStatus")
            m_strFromDate = Request.QueryString("txtFromDate")
            m_strToDate = Request.QueryString("txtToDate")
            m_strView = Request.QueryString("cboView")
            ' Create the SQL query which will select the issues based on the above values

            'Session("intProjectID") replaced by Session("IssueProject") by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
            strSQL = "EXEC usp_IB_IssueList_StatusChanged '" & CommonFunctions.General.BuildQueryString(m_strFromStatus) & "','" & CommonFunctions.General.BuildQueryString(m_strToStatus) & "','" & m_strFromDate & "','" & m_strToDate & "'," & m_strView & "," & CType(Session("IssueProject"), String) & ",'" & CType(Session("LoginType"), String) & "'"
            GetUIForReport(strSQL)
        End If
        ''Added by Yogesh J on 02-Feb-2016 to generate Token
        m_strToken = CommonFunctions.Security.Token.GetToken(CType(Session("intUserID"), String) + CType(Session("IssueProject"), String) + "0" + "0")
        ''End of addition by Yogesh J on 02-Feb-2016 to generate Token
    End Sub

    '=====================================================================
    ' Procedure Name        : GetMenu()	
    ' Purpose               : Function To Draw the Static Menu
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 23, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetMenu()
        'modified by harshk for sp4 issues 617 on 20/10/2005
        'Display the static menu
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_STATUS_BASED_REPORT"), MyBase.GetResourceString("MENU_VIEW_REPORT"), _
                                  MyBase.GetResourceString("MENU_CLOSE"), _
                                  MyBase.GetResourceString("MENU_HELP")}

        Dim arrClientSideFunctions() As String = {"Show_Status_Report_OnClick()", "ShowReport_OnClick()", "Close_OnClick()", "Help_OnClick('STATUS_REPORT')"}

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_STATUS_BASED_REPORT_TOOLTIP"), MyBase.GetResourceString("MENU_VIEW_REPORT_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        'End modified by harshk for sp4 issues 617 on 20/10/2005
        Dim objMenu As New WebPages.Template.StaticMenu
        m_strMenu = objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        objMenu = Nothing

        Response.Write(m_strMenu)

    End Sub
    '=====================================================================
    ' Procedure Name        : GetPageLegend()	
    ' Purpose               : Function To Draw the Page Legend
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 23, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetPageLegend()
        Dim arrLegend() As String = {MyBase.GetResourceString("PAGE_LEGEND")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        Response.Write(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True))
    End Sub

    '=====================================================================
    ' Procedure Name        : GetPageCaption()	
    ' Purpose               : Function To Draw the Page Caption
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 23, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetPageCaption()
        m_strPageCaption = MyBase.GetResourceString("PAGE_CAPTION")
        'Modified by by SandipL on 8 Feb 2006 to show current Project Name as right PageCaption
        Dim strProjectName As String
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(CommonFunctions.General.CheckIsNothing(Session("IssueProject"), "0"), String), True), String)
        strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectNameID " + CType(CommonFunctions.General.CheckIsNothing(Session("IssueProject"), "0"), String), True), String)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, m_strPageCaption, "Project: " + strProjectName, , True))
        'End Modification by SandipL on 8 Feb 2006
        Response.Write("<BR>")
    End Sub
    '=====================================================================
    ' Procedure Name        : GetUI()	
    ' Purpose               : Function To Draw the UI Necessary for Report
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 23, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetUI()
        'Get the Project ID From Session

        'commonted by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
        'm_strProjectID = CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID")), String)

        'Added by AniruddhaD on 18 Nov 2005 for providing project combo on issue list page(IssueID:685)
        m_strProjectID = CType(CommonFunctions.General.CheckIsNothing(Session("IssueProject")), String)

        'Start of Table

        Response.Write("<TABLE class=" & "'clsTable'" & " cellpadding=0 cellspacing=0 width=" & "'99.9%'" & ">")

        'Start of TR for Changed From Status
        Response.Write("<TR class=" & "'clsTREven'" & " >")

        'Label for CHANGED_FROM_STATUS
        Response.Write("<TD align=" & "'right'" & " width=" & "'30%'>")
        Response.Write(MyBase.GetResourceString("CHANGED_FROM_STATUS"))
        Response.Write("</TD>")

        Response.Write("<TD width=" & "'70%'>")
        Dim strSqlStatus As String
        strSqlStatus = "EXEC usp_Sel_tbl_IB_Project_Type_Status_Status " & m_strProjectID
        CommonFunctions.HTMLControls.DrawComboBox("cboFromStatus", strSqlStatus, , , , True, , , True)

        Response.Write("</TD>")

        'End of TR for Changed From Status
        Response.Write("</TR>")

        'Start of TR for Changed To Status
        Response.Write("<TR class=" & "'clsTREven'" & " >")

        'Label for CHANGED_TO_STATUS
        Response.Write("<TD align=" & "'right'" & " width=" & "'30%'>")
        Response.Write(MyBase.GetResourceString("CHANGED_TO_STATUS"))
        Response.Write("</TD>")

        Response.Write("<TD width=" & "'70%'>")
        CommonFunctions.HTMLControls.DrawComboBox("cboToStatus", strSqlStatus, , , , True, , , True)

        Response.Write("</TD>")

        'End of TR for Changed To Status
        Response.Write("</TR>")

        'Start of TR for From Date
        Response.Write("<TR class=" & "'clsTREven'" & " >")

        'Label for FROM_DATE
        Response.Write("<TD align=" & "'right'" & " width=" & "'30%'>")
        Response.Write(MyBase.GetResourceString("FROM_DATE"))
        Response.Write("</TD>")

        Response.Write("<TD width=" & "'70%'>")
        CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , , , "frmIB_StatusReport", , , , , , , , True)

        Response.Write("</TD>")

        'End of TR for From Date
        Response.Write("</TR>")

        'Start of TR for To Date
        Response.Write("<TR class=" & "'clsTREven'" & " >")

        'Label for TO_DATE
        Response.Write("<TD align=" & "'right'" & " width=" & "'30%'>")
        Response.Write(MyBase.GetResourceString("TO_DATE"))
        Response.Write("</TD>")

        Response.Write("<TD width=" & "'70%'>")
        CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , , , "frmIB_StatusReport", , , , , , , , True)

        Response.Write("</TD>")

        'End of TR for To Date
        Response.Write("</TR>")

        'Start of TR for View
        Response.Write("<TR class=" & "'clsTREven'" & " >")

        'Label for VIEW_TO_APPLY
        Response.Write("<TD align=" & "'right'" & " width=" & "'30%'>")
        Response.Write(MyBase.GetResourceString("VIEW_TO_APPLY"))
        Response.Write("</TD>")

        Response.Write("<TD width=" & "'70%'>")
        strSqlStatus = "Exec usp_Sel_tbl_IB_Project_Views " & m_strProjectID & ", '" & CType(Session("LoginType"), String) & "'," & CType(Session("intUserID"), String) & ", NULL, 4, '-1'"
        CommonFunctions.HTMLControls.DrawComboBox("cboView", strSqlStatus, , , , True, , , True)
		
		'Added By VidyaJ - For IssueID - 3330 - Whiz6.0
 		'' Integrated By ParagD On 17-Feb-2006
        '' Purpose : DSS 916 - Not able to set default view.

        '' Addition by Harshada D on 21 st of May 2005 for DATAMATICS ISSUE ID : 18606
        Response.Write("<SCRIPT LANGUAGE=""JavaScript"">document.forms[0].cboView.options[document.forms[0].cboView.options.length] = new Option('Corporate View','0')</SCRIPT>")
        '' end of Addition by Harshada D on 21 st of May 2005 for DATAMATICS ISSUE ID : 18606

        '' END : Integrated By ParagD On 17-Feb-2006.
        Response.Write("</TD>")

        'End of TR for View To Apply
        Response.Write("</TR>")

        Response.Write("<TR><TD><BR></TD></TR>")

        'Start of TR Note
        Response.Write("<TR class=" & "'clsTREven'" & " >")

        Dim strNote As String

        'Label for VIEW_TO_APPLY
        Response.Write("<TD colspan=" & "'2'>")
        strNote = MyBase.GetResourceString("NOTE")
        Response.Write(strNote.Replace("<issues>", m_strIssueCaption.ToLower))
        Response.Write("</TD>")

        'End of TR for View To Apply
        Response.Write("</TR>")

        'End of table
        Response.Write("</TABLE>")
    End Sub
    '=====================================================================
    ' Procedure Name        : GetFooterMenu()	
    ' Purpose               : Function To Draw the Static Menu at Footer
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 23, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetFooterMenu()
        Response.Write("<BR>")
        Response.Write(m_strMenu)
    End Sub
    '=====================================================================
    ' Procedure Name        : GetUIForReport()	
    ' Purpose               : Function To Draw the UI for report
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 23, 2004
    ' Revisions             : 1.0 Added Code for Grid 
    '=====================================================================
    Private Sub GetUIForReport(ByVal SQL As String)
        Dim lngNumberOfRows As Long
        Dim strViewName As String = ""
        Dim drView As IDataReader
        Dim strSQL As String
        Dim strMenu As String
        Dim arrFieldName() As String

		'Added By VidyaJ - IssueID - 3330 - Whiz6.0
        '' Added by ParagD On 28-Feb-2006
        '' Purpose : Foursoft - 1007.
        If m_strView <> "0" Then
            'Get the information about the view selected.
            strSQL = "EXEC usp_Sel_tbl_IB_Project_Views NULL,NULL,NULL," & m_strView
        Else
            strSQL = "EXEC usp_Sel_tbl_IB_Project_CorporateView"
        End If
        '' Added by ParagD On 28-Feb-2006
        drView = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        Dim strFieldNames As String

        If drView.Read = True Then
            strFieldNames = CType(CommonFunctions.General.CheckIsNothing(drView("Fields")), String)
            strViewName = CType(CommonFunctions.General.CheckIsNothing(drView("ViewName")), String)
        End If
        CommonFunction.Data.DisposeDataReader(drView)
        'drView.Dispose()

        Dim delimStr As String = ","
        Dim delimiter As Char() = delimStr.ToCharArray()

        arrFieldName = strFieldNames.Split(delimiter)

        'Get the number of rows in the report
        'dsReportResult = CommonFunctions.Data.GetDataSet(SQL, "tbl_IB_Issue")
        'strNumberOfRows = dsReportResult.Tables(0).Rows.Count.ToString

        'strViewName = CType(dsReport.Tables(0).Rows(0).Item("ViewName"), String)

        'Display the static menu
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), _
                                  MyBase.GetResourceString("MENU_HELP")}

        Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick('STATUS_REPORT')"}

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

        Dim objMenu As New WebPages.Template.StaticMenu
        strMenu = objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        objMenu = Nothing

        Response.Write(strMenu)

        'Header for the page
        Response.Write("<TABLE width=" & "'99.9%'" & " class=" & "'clsTable'" & ">")
        Response.Write("<TR>")
        Response.Write("<TD align=left><b><font Face=Verdana Size=1>" & MyBase.GetResourceString("PREFIX_DEF") & "</b></FONT></TD>")
        Response.Write("</TR>")
        Response.Write("</TABLE>")
        Response.Write("<BR>")

        'Report header details
        'Number of Issues
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        Response.Write("<TABLE width=" & "'99.9%'" & " class=" & "'clsTable'" & " cellPadding=0 cellspacing=0>")
        'Code Removed as Number of records are now displayed as footer 
        'Response.Write("<TR class=" & "'clsTREven'" & " >")
        'Response.Write("<TD align=left width=" & "'100%'" & " colspan= " & "'2'" & ">")
        'Response.Write(MyBase.GetResourceString("TOTAL_ISSUES"))
        'Response.Write("&nbsp;&nbsp;&nbsp;&nbsp; :<B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        'Response.Write(strNumberOfRows)

        'Response.Write("</TD></TR>")

        'View
        Response.Write("<TR class=" & "'clsTREven'" & " >")
        Response.Write("<TD align=left width=" & "'100%'" & " colspan= " & "'2'" & ">")
        Response.Write(MyBase.GetResourceString("VIEW_APPLIED"))
        Response.Write("&nbsp;&nbsp;&nbsp; :<B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        Response.Write(strViewName)

        Response.Write("</TD></TR>")

        'From And To status
        Response.Write("<TR class=" & "'clsTREven'" & " >")
        Response.Write("<TD align=left width=" & "'50%'" & ">")
        Response.Write(MyBase.GetResourceString("FROM_STATUS"))
        Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        Response.Write(m_strFromStatus)
        Response.Write("</TD>")
        Response.Write("<TD align=left width=" & "'50%'" & ">")
        Response.Write(MyBase.GetResourceString("TO_STATUS"))
        Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        Response.Write(m_strToStatus)
        Response.Write("</TD></TR>")

        'From and To Date
        Response.Write("<TR class=" & "'clsTREven'" & " >")
        Response.Write("<TD align=left width=" & "'50%'" & ">")
        Response.Write(MyBase.GetResourceString("FROM_DATE"))
        Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        Response.Write(CommonFunctions.Dates.CGetDate(CType(m_strFromDate, Date)))
        Response.Write("</TD>")
        Response.Write("<TD align=left width=" & "'50%'" & ">")
        Response.Write(MyBase.GetResourceString("TO_DATE"))
        Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        Response.Write(CommonFunctions.Dates.CGetDate(CType(m_strToDate, Date)))
        Response.Write("</TD></TR>")
        Response.Write("</TABLE>")

        'Note
        Dim strNote As String
        Response.Write("<BR>")
        Response.Write("<TABLE width=" & "'99.9%'" & " class=" & "'clsTable'" & ">")
        Response.Write("<TR class=" & "'clsTREven'" & " >")
        Response.Write("<TD align=left width=" & "'100%'" & ">")
        strNote = MyBase.GetResourceString("NOTE")
        Response.Write(strNote.Replace("<issues>", "issues"))
        Response.Write("</TD></TR></TABLE>")

        Response.Write("<BR>")
        'Draw the grid for report

        'Create array for the fields in the view to be displayed in the Grid
        Dim strFieldName As String
        Dim strColumnName As String
        Dim intCount As Integer
        Dim arrActualColumnArray(arrFieldName.Length) As String
        Dim arrUserFriendlyArray(arrFieldName.Length) As String
        Dim arrTDStyle(arrFieldName.Length) As String

        For intCount = 0 To arrFieldName.Length - 1

            strFieldName = Trim(arrFieldName(intCount) & "")
            strColumnName = Trim(arrFieldName(intCount) & "")

            'Build the Actual Column Name
            If InStr(1, strColumnName, "Custom") > 0 Then
                If InStr(1, strColumnName, "AS") > 0 Then
                    strColumnName = Trim(Left(strColumnName, InStr(1, strColumnName, "AS") - 1))
                End If
            End If
            arrActualColumnArray(intCount) = strColumnName

            'Build the user friendly column name
            If InStr(1, strFieldName, "Custom") > 0 Then
                If InStr(1, strFieldName, "AS") > 0 Then
                    strFieldName = Right(strFieldName, (Len(strFieldName) - InStr(1, strFieldName, "AS") - 1))
                End If
                strFieldName = "$" & Trim(strFieldName & "")
            End If

            strFieldName = Replace(strFieldName, Chr(34), "")
            strFieldName = Replace(strFieldName, " ", "")
            arrUserFriendlyArray(intCount) = strFieldName & " "
            arrTDStyle(intCount) = "align=left"
        Next

        'Page Div Tag
        Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")

        'Plot the Grid
        m_objGrid.ActualColumnArray = arrActualColumnArray
        m_objGrid.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGrid.TDStyleArray = arrTDStyle
        m_objGrid.UseSQL = MyBase.UseSQL
        m_objGrid.SQL = SQL
        m_objGrid.NoOfDataColumns = arrFieldName.Length
        m_objGrid.DIVStyle = "'overflow:auto;width:100%;'"
        m_objGrid.DrawGrid()
        lngNumberOfRows = m_objGrid.NoOfRows

        m_objGrid = Nothing

        Response.Write("<BR>")

        Response.Write("</DIV>")

        CommonFunctions.General.WriteTotalRecordsHTML(lngNumberOfRows, MyBase.GetResourceString("TOTAL_ISSUES") & "  :     ")
        Response.Write(strMenu)
    End Sub
    '=====================================================================
    ' Procedure Name        : GetIssueCaption()	
    ' Purpose               : Function To Get the Issue Caption depending upon the Module ID
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : March 24, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetIssueCaption(ByVal ModuleID As Integer)
        Dim intModuleID As Integer = ModuleID
        Dim strSQL As String = "Exec usp_Sel_tbl_PM_SystemModules " & intModuleID.ToString
        Dim dsCaption As DataSet
        dsCaption = CommonFunctions.Data.GetDataSet(strSQL, "tbl_PM_SystemModules")
        m_strIssueCaption = CType(CommonFunctions.General.CheckIsNothing(dsCaption.Tables(0).Rows(0).Item("ModuleName")), String)
    End Sub
#End Region

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataType.ToLower = "int" Then
            Args.ReplacementValue = FormatNumber(Args.DataReader("IssueID"), 0, TriState.False, TriState.False, TriState.False)
        End If
    End Sub
    ''Added by Yogesh J on 02-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowReport_OnClick(FromStatus As String, EmployeeID As String, ToStatus As String, FromDate As String, ToDate As String, View As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(FromStatus, String) + CType(ToStatus, String) + CType(FromDate, String) + CType(ToDate, String) + CType(View, String) + "0" + "0")

        Return m_PKToken_Request_Multiple

    End Function
    ''End of addition by Yogesh J on 02-Feb-2016
End Class
