Imports RadarLibrary
Public Class DB_RadarDashboard
    Inherits WebPages.Template.WhizTemplate

    Private WithEvents m_objDBRadar As DBRadar
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu

    Protected m_strType As String = "BR"  ' | BR - Business Radar, PR - Project Radar
    Private m_lngEmployeeID As Long = 0
    Private m_strUserName As String = ""
    Private m_strLoginType As String = ""
    Private m_lngParameterID As Long = 0
    Private m_lngDepartmentID As Long = 0
    Private m_lngLocationID As Long = 0
    Private m_lngProjectID As Long = 0
    Private m_blnUseSQL As Boolean

    Const ATTRITION_RATE As Long = 1
    Const IDLE_CAPACITY As Long = 2
    Const EFFORT_VARIANCE As Long = 3
    Const SCHEDULE_VARIANCE As Long = 4
    Const OUTSTANDING As Long = 5
    Const REWORK_EFFORTS As Long = 6
    Const OPEN_ISSUES As Long = 7
    Const PROFIT As Long = 8


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
        MyBase.ApplySecurity(True)
        Call Initialize()
    End Sub

    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        'MyBase.ApplySecurity(False, 2)
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True, 2)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
    End Sub

    Private Sub Initialize()
        ' TODO : replace with session values
        m_strUserName = "VilasJ" ' Session("strUserName")
        m_strLoginType = "E" ' ' Session("LoginType")
        m_lngEmployeeID = 64 ' CType(Session("intUserID"), Long)

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        m_lngParameterID = 0
        m_lngProjectID = 0
        If Trim(MyBase.GetFormValue("cboLocation", False) & "") <> "" Then
            m_lngLocationID = CType(MyBase.GetFormValue("cboLocation", False), Long)
        End If
        If Trim(MyBase.GetFormValue("cboDepartment", False) & "") <> "" Then
            m_lngDepartmentID = CType(MyBase.GetFormValue("cboDepartment", False), Long)
        End If


    End Sub

    Protected Sub WritePage()
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CONFIGURATION"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CONFIGURATION_TOLLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrCSFunction() As String = {"Configure_OnClick()", "Help_OnClick('RDB_BUSINESSRADAR')"}
        Dim strMenu As String

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)

        With Response
            .Write(strMenu)
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<TABLE class=clsTable cellpadding=0 cellspacing=0 width=99.9%>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<TR>")
            .Write("<td><font color='white'>e-Dashboard</font></td>")
            .Write("</tr>")
            .Write("<tr>")
            .Write("<td><font color='white'>Location:</font>")
            ' combo for location
            CommonFunctions.HTMLControls.DrawComboBox("cboLocation", "usp_Sel_PM_LocationList", , m_lngLocationID.ToString, " onchange=javascript:cboLocation_OnChange() ")
            .Write("</td>")
            .Write("<td><font color=white>Department:</font>")
            ' combo for department
            CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_Sel_PM_DepartmentList", , m_lngDepartmentID.ToString, " onchange=javascript:cboLocation_OnChange() ")
            .Write("</td>")
            .Write("</tr>")

            .Write("<TR >")
            .Write("<TD width=100%>")
            .Write("<div id='divRadar' align='cente'r width=1'00%'>")
            Call radar()
            .Write("</div>")
            .Write("</TD>")
            .Write("</TR>")
            .Write("</TABLE>")


        End With
    End Sub

    Protected Sub radar()
        Dim strSQL As String
        If UCase(Trim(m_strType & "")) = "BR" Then
            ' Business Radar
            strSQL = "usp_sel_tbl_RDB_BusinessRadar_Data "
            If m_lngLocationID <> 0 Then
                strSQL += m_lngLocationID.ToString
            Else
                strSQL += "null"
            End If
            If m_lngDepartmentID <> 0 Then
                strSQL += "," + m_lngDepartmentID.ToString
            Else
                strSQL += ",null"
            End If
            If m_lngLocationID <> 0 Or m_lngDepartmentID <> 0 Then
                ' Not organisation level data
                strSQL += ",0"
            End If

            Dim arrImage() As String = {"../../images/RDB_Dollar.gif", "../../images/RDB_IdleResource.gif", _
                                            "../../images/RDB_clock.gif", _
                                            "../../images/RDB_calendar.gif", _
                                            "../../images/RDB_Dollar.gif", _
                                            "../../images/RDB_Rework.gif", _
                                            "../../images/RDB_Zoom.gif", _
                                            "../../images/RDB_Dollar.gif"}
            Response.Write(PlotRadar(strSQL, arrImage))
        Else
            ' Project radar

        End If

    End Sub

    Private Function PlotRadar(ByVal SQL As String, ByVal ColImages As String(), Optional ByVal maxvalue As Double = 100) As String
        m_objDBRadar = New DBRadar

        With m_objDBRadar
            .RadarMaxValue = 100 'maxvalue
            .DefaultPlotImageURL = "../../images/rdb_Rework.gif"
            .BackImageURL = "../../images/RDB_radar.gif"
            .ConnectionString = CommonFunctions.Application.ConnectionString
            .SQLQuery = SQL
            .ColumnImages = ColImages
            .DigitsAfterDecimal = 2
            .HandleNullAsZero = True
            PlotRadar = m_objDBRadar.GetHTML
        End With
        m_objDBRadar = Nothing

    End Function


#Region "events"
    Private Sub m_objDBRadar_DataPoint_Render(ByVal sender As Object, ByVal e As System.EventArgs) Handles m_objDBRadar.DataPoint_Render
        Dim obj As New RadarPoint("")
        Dim img As New RadarPointImage("")
        Dim strParameter As String = ""


        obj = CType(sender, RadarPoint)
        img = obj.PlotImage
        img.Border = 0

        If obj.PlotPercentage < 0 Then obj.PlotPercentage = 0

        strParameter = Replace(Replace(Replace(obj.ToolTipText, obj.PlotPercentage.ToString, ""), Chr(13), ""), Chr(10), "")

        Select Case UCase(Trim(strParameter & ""))
            Case "ATTRITIONRATE"
                obj.ToolTipText = GetParameterName(ATTRITION_RATE) & ":" & FormatNumber(obj.PlotPercentage, 2) & " %"
                img.URL = "../../images/RDB_projectred.gif"
            Case "IDLECAPACITY"
                obj.ToolTipText = GetParameterName(IDLE_CAPACITY) & ":" & FormatNumber(obj.PlotPercentage, 2) & " %"
                img.URL = "../../images/RDB_IdleResource.gif"
            Case "EFFORTVARIANCE"
                obj.ToolTipText = GetParameterName(EFFORT_VARIANCE) & ":" & FormatNumber(obj.PlotPercentage, 2) & " %"
                img.URL = "../../images/RDB_Clock.gif"
            Case "SCHEDULEVARIANCE"
                obj.ToolTipText = GetParameterName(SCHEDULE_VARIANCE) & ":" & FormatNumber(obj.PlotPercentage, 2) & " %"
                img.URL = "../../images/RDB_Calendar.gif"
            Case "OUTSTANDING"
                obj.ToolTipText = GetParameterName(OUTSTANDING) & ":" & FormatNumber(obj.PlotPercentage, 2) & " %"
                img.URL = "../../images/RDB_Dollar.gif"
            Case "PROFIT"
                obj.ToolTipText = GetParameterName(PROFIT) & ":" & FormatNumber(obj.PlotPercentage, 2) & " %"
                img.URL = "../../images/RDB_Dollar.gif"
            Case "OPENISSUES"
                obj.ToolTipText = GetParameterName(OPEN_ISSUES) & ":" & FormatNumber(obj.PlotPercentage, 2) & " %"
                img.URL = "../../images/RDB_Zoom.gif"
            Case "REWORK"
                obj.ToolTipText = GetParameterName(REWORK_EFFORTS) & ":" & FormatNumber(obj.PlotPercentage, 2) & " %"
                img.URL = "../../images/RDB_Rework.gif"
            Case Else
        End Select

        obj.PlotImage = img
        obj = Nothing
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

    End Sub
    Private Sub m_objMenu_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_Menu) Handles m_objMenu.Initialize
        Args.clsTR = ""
    End Sub
#End Region

#Region "Other Procedures"

    Private Function GetParameterName(ByVal ParameterID As Long) As String
        '=====================================================================
        ' Procedure Name        : GetParameterName()	
        ' Purpose               : To get the parameter name
        ' Description           : same as above
        ' Parameters Passed     : Parameter ID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 23,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        GetParameterName = ""
        strSQL = "usp_sel_tbl_RDB_Parameter_Master " & ParameterID
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            GetParameterName = Replace(dr("ParameterName").ToString, "%", "")
        End If
        DisposeDataDeader(dr)
    End Function

    Private Sub DisposeDataDeader(ByRef dr As IDataReader)
        '=====================================================================
        ' Procedure Name        : DisposeDataDeader()	
        ' Purpose               : To dispose the data reader object
        ' Description           : same as above
        ' Parameters Passed     : by ref data-reader object
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : None
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 23,2004
        ' Revisions             :
        '=====================================================================
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub

    Private Function OtherParameterString(ByVal ID As Long, ByVal strProjectName As String) As String
        '=====================================================================
        ' Procedure Name        : OtherParameterString()	
        ' Purpose               : To get the string for other values of project
        ' Description           : same as above
        ' Parameters Passed     : Parameter ID, Project name
        ' Returns               : string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 23,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim dr As IDataReader
        Dim strRet As String = ""
        strSQL = "Select * from tbl_DB_RadarValues where ProjectName = '" + strProjectName + "'"
        dr = CommonFunctions.Data.GetDataReader(strSQL, True)
        If dr.Read Then
            Select Case ID
                Case 1
                    strRet += "Effort Variance =" & dr("EffortVariance").ToString & "%" & vbCrLf
                    strRet += "Amount Outstanding=" & dr("PercentAmountOutstanding").ToString & "%" & vbCrLf
                    strRet += "Billed=" & dr("PercentBilled").ToString & "%" & vbCrLf
                    strRet += "Defect Fixed=" & dr("PercentDefectFixing").ToString & "%" & vbCrLf
                    strRet += "Complete=" & dr("PercentComplete").ToString & "%" & vbCrLf
                Case 2
                    strRet += "Schedule Variance =" & dr("ScheduleVariance").ToString & "%" & vbCrLf
                    strRet += "Amount Outstanding=" & dr("PercentAmountOutstanding").ToString & "%" & vbCrLf
                    strRet += "Billed=" & dr("PercentBilled").ToString & "%" & vbCrLf
                    strRet += "Defect Fixed=" & dr("PercentDefectFixing").ToString & "%" & vbCrLf
                    strRet += "Complete=" & dr("PercentComplete").ToString & "%" & vbCrLf
                Case 3
                    strRet += "Schedule Variance =" & dr("ScheduleVariance").ToString & "%" & vbCrLf
                    strRet += "Effort Variance =" & dr("EffortVariance").ToString & "%" & vbCrLf
                    strRet += "Billed=" & dr("PercentBilled").ToString & "%" & vbCrLf
                    strRet += "Defect Fixed=" & dr("PercentDefectFixing").ToString & "%" & vbCrLf
                    strRet += "Complete=" & dr("PercentComplete").ToString & "%" & vbCrLf
                Case 4
                    strRet += "Schedule Variance =" & dr("ScheduleVariance").ToString & "%" & vbCrLf
                    strRet += "Effort Variance =" & dr("EffortVariance").ToString & "%" & vbCrLf
                    strRet += "Amount Outstanding=" & dr("PercentAmountOutstanding").ToString & "%" & vbCrLf
                    strRet += "Defect Fixed=" & dr("PercentDefectFixing").ToString & "%" & vbCrLf
                    strRet += "Complete=" & dr("PercentComplete").ToString & "%" & vbCrLf
                Case 5
                    strRet += "Schedule Variance =" & dr("ScheduleVariance").ToString & "%" & vbCrLf
                    strRet += "Effort Variance =" & dr("EffortVariance").ToString & "%" & vbCrLf
                    strRet += "Amount Outstanding=" & dr("PercentAmountOutstanding").ToString & "%" & vbCrLf
                    strRet += "Billed=" & dr("PercentBilled").ToString & "%" & vbCrLf
                    strRet += "Complete=" & dr("PercentComplete").ToString & "%" & vbCrLf
                Case 6
                    strRet += "Schedule Variance =" & dr("ScheduleVariance").ToString & "%" & vbCrLf
                    strRet += "Effort Variance =" & dr("EffortVariance").ToString & "%" & vbCrLf
                    strRet += "Amount Outstanding=" & dr("PercentAmountOutstanding").ToString & "%" & vbCrLf
                    strRet += "Billed=" & dr("PercentBilled").ToString & "%" & vbCrLf
                    strRet += "Defect Fixed=" & dr("PercentDefectFixing").ToString & "%" & vbCrLf
            End Select
        End If

        DisposeDataDeader(dr)

        Return strRet
    End Function
#End Region

End Class

