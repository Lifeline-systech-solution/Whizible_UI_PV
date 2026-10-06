Imports CommonFunction
Imports Whizible
Public Class OverSchedule_ClearBaseline
    Inherits WebPages.Template.WhizTemplate
    'Private WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objGrid1 As New WebPages.Template.GenericGrid
    Protected m_intProjectID As Integer
    Protected m_strAction As String
    Protected m_strMode As String
    Protected m_strLoginType As String
    Protected m_lngEmployeeID As Integer
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights          'This variable is for access rights of page.
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected strTemplate As String = "0"
    Protected m_TotalPlannedHours As Double = 0.0
    Protected AvailableWorkHours As Double = 0.0
    Protected Const m_MismatchAlert As String = "Available hours have exhausted, Please replan."

    Private m_TotalRecords As Integer
    Public m_RecruiterID As String
    Public m_BGID As String
    Public m_HiringManager As String
    Public m_strRecruiterId As String
    Public m_strPipelineId As String
    Public m_strFlag As String
    Public m_strChkd As String
    Public m_RecruiterFilterID As String
    Public m_BGFilterID As String
    Public m_HMFilterID As String
    'Chakshuta
    Public intCapValue As String
    Public CapPeriodID As String
    Public CapUnitID As String
    Public BillingCalendarID As String
    'Chakshuta
    'Code Added By Bharat Tekade On 25th-May-2015
    Protected m_strStartDate As String = ""
    Protected m_strEndDate As String = ""
    Public m_AssignedOn As String
    Protected m_strModifiedField As String = ""
    Protected m_strModifiedBy As String = ""
    Protected m_strUniqueID As String = ""
    Protected CustomerID As String
    Protected intUniqueID As String = ""
    'Code Ended By Bharat Tekade On 25th-May-2015
    Protected m_TimeSheetNo As String

    Protected intOverallScheduleID As String
    Protected strWhichTask As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        m_lngEmployeeID = CType(Session("intUserID"), Long)
      
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

      
    End Sub

    Public Sub PageInit()
        GetGlobalObject()
       
        If m_strAction = "ClearBaseline" Then
            ClearBaseline()
        ElseIf m_strAction = "SetBaseline" Then
            SetBaseline()
        End If
        WriteMenu_Filters()
        WritePage()

    End Sub
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
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub

    Private Sub InitVariables()
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString
        Else
            m_strMode = ""
        End If
        m_intProjectID = CInt(Session("intProjectID"))
    End Sub

    Protected Sub WriteMenu_Filters()
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String
        Dim sbSTRHTML As New System.Text.StringBuilder


        Dim m_arrMenu() As String = {"Set Baseline", "Clear Baseline", "Select All", "Clear All", "Close"}
        Dim m_arrMenuToolTip() As String = {"Set Baseline", "Clear Baseline", "Select All", "Clear All", "Close"}
        Dim m_arrCSFunction() As String = {"SetBaseline_OnClick()", "ClearBaseline_OnClick()", "SelectAll_OnClick()", "ClearAll_OnClick()", "window.close();"}
        arrMenu = m_arrMenu
        arrMenuToolTip = m_arrMenuToolTip
        arrCSFunction = m_arrCSFunction

        Dim strMenu As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        strMenu = Replace(strMenu, ">Save", "id=Save>Save")

        sbSTRHTML.Append(strMenu)

        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Task Details", , , True))
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "", , , True))

    End Sub

    Protected Sub WritePage()

        Dim sbSTRHTML As New System.Text.StringBuilder
        'sbSTRHTML.Append("<div id='divList' name='divList' style='overflow:auto;width:100%'>") ''overflow:auto;
        sbSTRHTML.Append("<BR />")
        Call DisplayData_Grid(sbSTRHTML)     
        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

    End Sub
   
    Private Sub DisplayData_Grid(ByRef sbSTRHTML As System.Text.StringBuilder)
        Dim strQuery As String = ""
        Dim strSQLQuery1 As String = ""

        m_intProjectID = CInt(Session("intProjectID"))
        m_strAction = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), ""), String)
        intOverallScheduleID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("OverallScheduleID"), ""), String)

        Dim arrActualColumns() As String = {"OS", "CurrentStartDate", "CurrentEndDate", "CurrentEffort", "CurrentDuration", "BaselineStartDate", "BaselineEndDate", "BaselineEfforts", "Actualworkingdays", ""}
        Dim arrUserFriendlyColumn() As String = {"WBS Combination", "Current Start Date", "Current End Date", "Current Effort", "Current Duration", "Baseline Start Date", "Baseline End Date", "Baseline Efforts", "Actual Working Days", "Select"}
        Dim arrTDStyle() As String = {"Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center"}

        strQuery = "EXEC Usp_Sel_OS_Details_ClearBaseline " & m_intProjectID

        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .SQL = strQuery
            .PrimaryKey = "OverallScheduleID"
            .UseSQL = True
            .DIVID = "divList"
            .DIVHeight = 110           
            .DIVStyle = "overflow:auto;width:100%;height:355px;"           
            .NoOfDataColumns = 14
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            m_TotalRecords = .NoOfRows
            sbSTRHTML.Append(.DrawGrid())
        End With

        m_objGrid = Nothing

    End Sub
 
    Protected Sub SetBaseline()
        Dim strOSIDList As String
        Dim arrTaskId() As String
        Dim intRowCount As Integer = 0
        Dim strTaskID As String
        Dim strQuery As String

        strOSIDList = Request.Form("chkSelect")
        'arrTaskId = Split(strOSIDList, ",")

        'For intRowCount = 0 To arrTaskId.Length - 1
        '    strTaskID = arrTaskId(intRowCount)

        strQuery = "Exec Usp_Upd_tbl_WPBN_PM_OverallSchedule_SetBaseline '" & strOSIDList & "','" & Session("strUserName") & "'"

        CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
        'Next

        CommonFunctions.General.WriteHTML("<script type=text/javascript>")
        Response.Write("window.opener.location.href='../Enhancement/EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?MasterTagID=20177&FromWhere=PM'")
        CommonFunctions.General.WriteHTML("</script>")
    End Sub
    Protected Sub ClearBaseline()
        Dim strOSIDList As String
        Dim arrTaskId() As String
        Dim intRowCount As Integer = 0
        Dim strTaskID As String
        Dim strQuery As String

        strOSIDList = Request.Form("chkSelect")
        'arrTaskId = Split(strOSIDList, ",")

        'For intRowCount = 0 To arrTaskId.Length - 1
        '    strTaskID = arrTaskId(intRowCount)

        strQuery = "Exec Usp_Upd_tbl_WPBN_PM_OverallSchedule_ClearBaseline '" & strOSIDList & "','" & Session("strUserName") & "'"

        CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
        'Next

        CommonFunctions.General.WriteHTML("<script type=text/javascript>")
        Response.Write("window.opener.location.href='../Enhancement/EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?MasterTagID=20177&FromWhere=PM'")
        CommonFunctions.General.WriteHTML("</script>")

    End Sub

    Private Sub InheritData()

        Dim intRowCount As Integer = 0
        Dim strRecruiterID As String = ""
        Dim strRecruiterIDValues As String = ""
        m_intProjectID = CInt(Session("intProjectID"))
        'Dim regDate As Date = Date.Now()
        'Dim strDate As String = regDate.ToString("ddMMMyyyy")

        Dim strSQLQuery As New System.Text.StringBuilder

        'If m_intProjectID <> "" Then
        strSQLQuery.Append("Exec usp_Upd_CapDetails_And_Calendar ")

        strSQLQuery.Append("" & m_intProjectID & "")
        strSQLQuery.Append(" " & vbCrLf)
        'End If


        If strSQLQuery.ToString.Trim <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
        End If

    End Sub

#Region " General Events Definition"
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Dim intOSID As String
            Dim ActualEndDate As String

            intOSID = Args.DataReader("OverallScheduleID")
            ActualEndDate = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualEndDate"), "")

            'If ActualEndDate <> "" Then
            '    Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelect' id='chkSelect_" + intOSID.ToString + "' class='clsCheckBox' value=" + intOSID.ToString + " disabled=true  ></td>"
            'Else
            Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelect' id='chkSelect_" + intOSID.ToString + "' class='clsCheckBox' value=" + intOSID.ToString + " ></td>"
        End If
        'End Of Modified By Chakshuta H pn 3rd-July-2015 Purpose::EASI Issue Fixing
        'End If
        If Args.DataField.ToUpper = "OS" Then
            Args.TDStyle = "style='white-space:nowrap;'"
        End If
       
    End Sub
#End Region

    Private Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad

    End Sub
End Class



