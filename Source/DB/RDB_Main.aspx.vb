Imports RadarLibrary
Public Class RDB_Main
    Inherits WebPages.Template.WhizTemplate

    Private WithEvents m_objDBRadar As New DBRadar
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu

    Protected m_strType As String = ""  ' | BR - Business Radar, PR - Project Radar
    Protected m_strView As String = "PARAMETER"
    Protected m_lngProjectID As Long = 0
    Protected m_lngParameterID As Long = 0
    Protected m_lngDashboardID As Long = 0
    Private m_lngEmployeeID As Long = 0
    Private m_lngPostID As Long = 0
    Private m_strUserName As String = ""
    Private m_strLoginType As String = ""
    Private m_lngDepartmentID As Long = 0
    Private m_lngLocationID As Long = 0
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
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the elements for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 23,2004
        ' Revisions             :
        '=====================================================================
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_lngPostID = CType(Session("intPostID"), Long)

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        ' business/project radar
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("type")) <> "" Then
            m_strType = Request.QueryString("type").ToString
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("DashboardID")) <> "" Then
            m_lngDashboardID = CType(Request.QueryString("DashboardID"), Long)
        End If

        ' location
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("LocationID")) <> "" Then
            m_lngLocationID = CType(Request.QueryString("LocationID"), Long)
        End If
        ' department
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("DepartmentID")) <> "" Then
            m_lngDepartmentID = CType(Request.QueryString("DepartmentID"), Long)
        End If
        ' submitted location when combo item selected
        If Trim(MyBase.GetFormValue("cboLocation", False) & "") <> "" Then
            m_lngLocationID = CType(MyBase.GetFormValue("cboLocation", False), Long)
        End If
        ' submitted dept. when combo item selected
        If Trim(MyBase.GetFormValue("cboDepartment", False) & "") <> "" Then
            m_lngDepartmentID = CType(MyBase.GetFormValue("cboDepartment", False), Long)
        End If
        If Trim(MyBase.GetFormValue("cboParameter", False) & "") <> "" Then
            m_lngParameterID = CType(MyBase.GetFormValue("cboParameter", False), Long)
        End If
        If Trim(MyBase.GetFormValue("cboProject", False) & "") <> "" Then
            m_lngProjectID = CType(MyBase.GetFormValue("cboProject", False), Long)
        End If
        ' view
        If Trim(MyBase.GetFormValue("cboView", False) & "") <> "" Then
            m_strView = MyBase.GetFormValue("cboView", False)
        End If

        ' inherit user settings 
        InheritUserSettings()
    End Sub

    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page for the Radar DB
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 23,2004
        ' Revisions             :
        '=====================================================================
        ' Modified By NitinVS on 2 Sep 2005 for WhizibleSEM SP4 IssueId 130 
        ' Project View is Not Shown hence removed the menu link for Configuration 
        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CONFIGURATION"), MyBase.GetResourceString("MENU_HELP")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CONFIGURATION_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        'Dim arrCSFunction() As String = {"Configure_OnClick()", "Help_OnClick('RDB_BUSINESSRADAR')"}
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrCSFunction() As String = {"Help_OnClick('RDB_BUSINESSRADAR')"" style=""color:'white'"}

        Dim strMenu As String
        Dim strSQL As String
        Dim strAccessFilter As String

        '--- Added By purvaj on 15 Jul 2009
        Dim m_blnHideCombo As Boolean = False
        Dim m_strDashboardID As String = ""
        m_strDashboardID = CommonFunction.General.CheckIsNothing(Request.QueryString("DashboardID"), "0")
        If m_strDashboardID.ToString <> "" And m_strDashboardID.ToString <> "0" Then
            m_blnHideCombo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_ShowOrHide_DashboardCombo " + m_strDashboardID.ToString, True), False), False)
        End If
        '--- End addition purvaj

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)

        Call Boot()

        MyBase.InitializeResources("AppResources.RDB_main", "AppResources")
        With Response
            '.Write(strMenu)
            .Write("<TABLE class=clsTable cellpadding=0 cellspacing=0 width=99.9%>")
            .Write("<TR>")
            If m_blnHideCombo = False Then '--- Added By purvaj on 15 Jul 2009
                .Write("<td align=left>" & MyBase.GetResourceString("LBL_EDASHBOARD"))
                CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo  " & m_lngEmployeeID.ToString & "," & m_lngPostID, 0, "../DB/RDB_Main.aspx?Type=" & Trim(m_strType & "") & "|0", "OnChange='JavaScript:cboDashboard_OnChange()'")
                .Write("</td>")
            End If
            ' Project Is Shown in the line of Dashboard combo.
            '.Write("<TD align=right>" & strMenu & "</td>")
            '.Write("</tr>")
            '.Write("</TABLE>")

            '.Write("<table width='100%'><TR ><TD bgcolor=white width=100%></td></TR></table><BR>")

            '.Write("<TABLE class=clsTable cellpadding=0 cellspacing=0 width=100%>")

            '.Write("<tr>")

            If UCase(Trim(m_strType & "")) = "PR" Then

                ' Only Parameter View is shown hence removed teh view combo 

                '.Write("<td  align=center>" & MyBase.GetResourceString("LBL_VIEW"))
                '' combo for view
                '.Write(CommonFunctions.HTMLControls.DrawComboBox("cboView", "usp_RDB_Get_RadarViews_ForCombo", , m_strView, " onchange=javascript:cboView_OnChange() ", False, True))
                '.Write("</td>")

                ' parameter/project drop down
                If UCase(Trim(m_strView & "")) = "PARAMETER" Then
                    .Write("<td  align=center>" & MyBase.GetResourceString("LBL_PROJECT"))

                    strAccessFilter = GetProjectAccessFilter()
                    If Trim(strAccessFilter & "") <> "" Then
                        strSQL = "usp_RDB_Get_Projects_ForCombo '" & CommonFunctions.General.BuildQueryString(strAccessFilter) & "'"
                    Else
                        strSQL = "usp_RDB_Get_Projects_ForCombo"
                    End If

                    ' for First Login initialised the First Project Id 
                    If m_lngProjectID = 0 Then
                        m_lngProjectID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0"), Long)
                    End If

                    .Write(CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQL, , m_lngProjectID.ToString, " onchange=javascript:cboProject_OnChange() ", False, True))
                Else
                    .Write("<td  align=center>" & MyBase.GetResourceString("LBL_PARAMETER"))
                    .Write(CommonFunctions.HTMLControls.DrawComboBox("cboParameter", "usp_RDB_Get_Parameters_ForCombo " & m_lngEmployeeID & ",'" & m_strLoginType & "','" & CommonFunctions.General.BuildQueryString(m_strType) & "'", , m_lngParameterID.ToString, " onchange=javascript:cboParameter_OnChange() ", True, True))
                End If
                .Write("</td>")
            End If

            'Commented By VidyaJ on 11th Dec 2004
            'Commented following code as Department is not associated to project in WhizibleSEM
            ''usp_RDB_Get_Parameters_ForCombo
            '.Write("<td  align=center>" & MyBase.GetResourceString("LBL_LOCATION"))
            '' combo for location
            '.Write(CommonFunctions.HTMLControls.DrawComboBox("cboLocation", "usp_Sel_PM_LocationList", , m_lngLocationID.ToString, " onchange=javascript:cboLocation_OnChange() ", True, True))
            '.Write("</td>")
            '.Write("<td align=center>" & MyBase.GetResourceString("LBL_DEPARTMENT"))
            '' combo for department
            '.Write(CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_Sel_PM_DepartmentList", , m_lngDepartmentID.ToString, " onchange=javascript:cboLocation_OnChange() ", True, True))
            '.Write("</td>")

            .Write("<TD align=right>" & strMenu & "</td>")
            ' End Modification By NitinVS on 2 Sep 2005 for WhizibleSEM SP4 IssueId 130 

            .Write("</tr>")

            .Write("</TABLE>")
            .Write("<div id='divRadar' align='center' width='100%'>")
            ' plot the radar here
            .Write(Radar())
            .Write("</div>")

            Call WriteLegends()
        End With

        Call ShutDown()
    End Sub



#Region "Other Procedures"
    Private Sub WriteLegends()
        '=====================================================================
        ' Procedure Name        : WriteLegends()	
        ' Purpose               : To write the image legends
        ' Description           : same as above
        ' Parameters Passed     : Parameter ID
        ' Returns               : Parameter Name
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 23,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        Dim sb As New System.Text.StringBuilder("")
        If UCase(Trim(m_strView & "")) = "PROJECT" Then
            sb.Append("<img src='../../Images/RDB_ProjectGreen.gif' border=0>-Project In Normal Zone ")
            sb.Append("<img src='../../Images/RDB_ProjectOrange.gif' border=0>-Project In Warning Zone ")
            sb.Append("<img src='../../Images/RDB_ProjectRed.gif' border=0>-Project In Danger Zone ")
        Else
            strSQL = "usp_sel_tbl_RDB_Parameter_UserSettings " & m_lngEmployeeID & ",'" & m_strLoginType & "',null,'" & CommonFunctions.General.BuildQueryString(m_strType) & "',1"
            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            Do While dr.Read()
                Select Case CType(dr("ParameterID"), Long)
                    Case ATTRITION_RATE : sb.Append("<img src='../../Images/RDB_AttritionRate.gif' border=0>")
                    Case IDLE_CAPACITY : sb.Append("<img src='../../Images/RDB_IdleResource.gif' border=0>")
                    Case EFFORT_VARIANCE : sb.Append("<img src='../../Images/RDB_Clock.gif' border=0>")
                    Case SCHEDULE_VARIANCE : sb.Append("<img src='../../Images/RDB_Calendar.gif' border=0>")
                    Case PROFIT : sb.Append("<img src='../../Images/RDB_Dollar.gif' border=0>")
                    Case OPEN_ISSUES : sb.Append("<img src='../../Images/RDB_Zoom.gif' border=0>")
                        ' Modified By NitinVS on 31 Aug 2005 for WhizibleSEM SP4 IssueID 130
                        ' As Discussed With Satchit S % Out Standing Is Not To Be Shown.

                        ' Case OUTSTANDING : sb.Append("<img src='../../Images/RDB_Dollar.gif' border=0>")



                    Case REWORK_EFFORTS : sb.Append("<img src='../../Images/RDB_Rework.gif' border=0>")
                End Select

                If dr("ParameterName").ToString.ToUpper <> "% OUTSTANDING" Then
                    sb.Append("-" & Server.HtmlEncode(dr("ParameterName").ToString) & " ")
                End If

                ' End Modification  By NitinVS on 31 Aug 2005 for WhizibleSEM SP4 IssueID 130
            Loop
            DisposeDataDeader(dr)
        End If
        Response.Write("<Table class=clsTable  cellpaddng=0 cellspacing=0 width=99.9% ><TR ><TD bgcolor=white width=100%></td></TR><TR><TD align=center width=100%><font face='verdana,arial' size=0 color=white >" & sb.ToString & "</font></TD></TR></Table>")
    End Sub

    Private Function GetProjectAccessFilter() As String
        '=====================================================================
        ' Procedure Name        : GetProjectAccessFilter()	
        ' Purpose               : To get the project access
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Session Variables are set
        ' Dependencies          : WebPages.Filters.cRoleLevelAccessFilter
        ' Author                : Rajanikant Khethawatt
        ' Created               : May 09,2004
        ' Revisions             :
        '=====================================================================
        Dim strAccess As String
        Dim objAccess As New WebPages.Filters.cRoleLevelAccessFilter(Session("strUserName").ToString, CType(Session("intPostID"), Long), CType(HttpContext.Current.Session("intUserID"), Long), Session("LoginType").ToString, CType(Session("intLoginID"), Integer), CType(Session("intRoleLevel"), Integer), CType(HttpContext.Current.Session("IsCreatedByCustomer"), Boolean))
        'Dim objAccess As New WebPages.Filters.cRoleLevelAccessFilter("VilasJ", 21, 64, "E", 64, 1, False)
        With objAccess
            .UseSQL = m_blnUseSQL
            .AccessParameter = "ProjectID"
            .ShowReleasedProjects = False
            strAccess = .GetRoleLevelAccessFilter()
        End With
        objAccess = Nothing
        ' just in case! if string is greater than 7900 chars truncate it
        If Len(strAccess & "") > 7900 Then
            strAccess = Left(strAccess, 7900)
            If Right(Trim(strAccess & ""), 1) = "," Then
                strAccess = Left(strAccess, 7899) + ")"
            End If
            If Right(Trim(strAccess & ""), 1) = "'" Then
                strAccess = Left(strAccess, 7899) + "')"
            End If
            If Right(Trim(strAccess & ""), 1) <> ")" Then
                strAccess = Left(strAccess, 7899) + "')"
            End If
        End If
        GetProjectAccessFilter = strAccess
    End Function

    Private Sub Boot()
        '=====================================================================
        ' Procedure Name        : boot()	
        ' Purpose               : To write the start up radar scripts
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : None
        ' Dependencies          : radar object
        ' Author                : Rajanikant Khethawatt
        ' Created               : May 06,2004
        ' Revisions             :
        '=====================================================================
        Response.Write(m_objDBRadar.GetScript())
    End Sub

    Private Sub ShutDown()
        '=====================================================================
        ' Procedure Name        : ShutDown()	
        ' Purpose               : To write the closing radar scripts
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : None
        ' Dependencies          : radar object
        ' Author                : Rajanikant Khethawatt
        ' Created               : May 06,2004
        ' Revisions             :
        '=====================================================================
        Response.Write(m_objDBRadar.GetScriptCalls())
    End Sub

    Private Sub InheritUserSettings()
        '=====================================================================
        ' Procedure Name        : InheritUserSettings()	
        ' Purpose               : To inherit the user settings for radar
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : None
        ' Dependencies          : namespace:commonfunctions,,module variables 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 30,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String

        strSQL = "usp_RDB_Inherit_UserSettings " & m_lngEmployeeID & ",'" & m_strLoginType & "'"
        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

    End Sub

    Private Function Radar() As String
        '=====================================================================
        ' Procedure Name        : Radar()	
        ' Purpose               : To plot the radar 
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 23,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strAccess As String = ""

        If UCase(Trim(m_strType & "")) = "BR" Then
            ' Business Radar
            strSQL = "usp_sel_tbl_RDB_BusinessRadar_Data " & m_lngEmployeeID & ",'" & m_strLoginType & "'"

            ' location specific?
            If m_lngLocationID <> 0 Then
                strSQL += "," + m_lngLocationID.ToString
            Else
                strSQL += ",null"
            End If
            ' department specific?
            If m_lngDepartmentID <> 0 Then
                strSQL += "," + m_lngDepartmentID.ToString
            Else
                strSQL += ",null"
            End If
            If m_lngLocationID <> 0 Or m_lngDepartmentID <> 0 Then
                ' Not organisation level data
                strSQL += ",0"
            Else
                ' organisation level data
                strSQL += ",1"
            End If
        Else
            ' Project radar
            strAccess = GetProjectAccessFilter()

            If UCase(Trim(m_strView & "")) = "PROJECT" Then
                If m_lngParameterID > 0 Then
                    ' project view
                    strSQL = "usp_sel_tbl_RDB_ProjectRadar_Data_ByProject " & m_lngParameterID & "," & m_lngEmployeeID & ",'" & m_strLoginType & "'"

                    ' location specific?
                    If m_lngLocationID <> 0 Then
                        strSQL += "," + m_lngLocationID.ToString
                    Else
                        strSQL += ",null"
                    End If
                    ' department specific?
                    If m_lngDepartmentID <> 0 Then
                        strSQL += "," + m_lngDepartmentID.ToString
                    Else
                        strSQL += ",null"
                    End If
                    If Trim(strAccess & "") <> "" Then
                        'Modified by PrajaktaR on 2 June 2005 for IssueID 19217 of Nucleus
                        'strSQL += ",'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.BuildQueryString(strAccess)) + "'"
                        strSQL += ",'" + CommonFunctions.General.BuildQueryString(strAccess) + "'"
                        'End of Modification by PrajaktaR on 2 June 2005 for IssueID 19037 of Nucleus
                    Else
                        strSQL += ",null"
                    End If
                Else
                    strSQL = "select 0 as [KeyName],0 as [KeyValue]"
                End If
            Else
                ' parameter view
                strSQL = "usp_sel_tbl_RDB_ProjectRadar_Data " & m_lngEmployeeID & ",'" & m_strLoginType & "'"

                ' location specific?
                If m_lngLocationID <> 0 Then
                    strSQL += "," + m_lngLocationID.ToString
                Else
                    strSQL += ",null"
                End If
                ' department specific?
                If m_lngDepartmentID <> 0 Then
                    strSQL += "," + m_lngDepartmentID.ToString
                Else
                    strSQL += ",null"
                End If
                ' parameter specific?
                If m_lngParameterID <> 0 Then
                    strSQL += "," + m_lngParameterID.ToString
                Else
                    strSQL += ",null"
                End If
                ' project specific?
                If m_lngProjectID <> 0 Then
                    strSQL += "," + m_lngProjectID.ToString
                Else
                    strSQL += ",0"
                End If
                If Trim(strAccess & "") <> "" Then
                    'Code Commented and added by Harshada D on 24 th May 2005 for FreeScale ISSUE ID :19217
                    'strSQL += ",'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.BuildQueryString(strAccess)) + "'"
                    strSQL += ",'" + CommonFunctions.General.BuildQueryString(strAccess) + "'"
                    'End of Addition By Harshada D

                Else
                    strSQL += ",null"
                End If
            End If

        End If

        ' return the HTML for plotting the radar
        Return PlotRadar(strSQL)
    End Function


    Private Function PlotRadar(ByVal SQL As String, Optional ByVal maxvalue As Double = 100) As String
        '=====================================================================
        ' Procedure Name        : PlotRadar()	
        ' Purpose               : To plot the radar
        ' Description           : same as above
        ' Parameters Passed     : SQL, 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 23,2004
        ' Revisions             :
        '=====================================================================
        With m_objDBRadar
            .RadarMaxValue = maxvalue
            .DefaultPlotImageURL = "../../images/RDB_ProjectRed.gif"
            .BackImageURL = "../../images/RDB_radar.gif"
            .ConnectionString = CommonFunctions.Application.ConnectionString
            .SQLQuery = SQL
            .DigitsAfterDecimal = 2
            .HandleNullAsZero = True
            PlotRadar = m_objDBRadar.GetHTML
        End With
    End Function

    Private Function GetParameterName(ByVal ParameterID As Long) As String
        '=====================================================================
        ' Procedure Name        : GetParameterName()	
        ' Purpose               : To get the parameter name
        ' Description           : same as above
        ' Parameters Passed     : Parameter ID
        ' Returns               : Parameter Name
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
        strSQL = "usp_sel_tbl_RDB_Parameter_UserSettings " & m_lngEmployeeID & ",'" & m_strLoginType & "'," & ParameterID & ",'" & CommonFunctions.General.BuildQueryString(m_strType) & "'"
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            GetParameterName = Replace(dr("ParameterName").ToString, "%", "")
        End If
        DisposeDataDeader(dr)
    End Function

    Private Function AreDrillDownsPresent(ByVal ParameterID As Long) As Byte
        '=====================================================================
        ' Procedure Name        : AreDrillDownsPresent()	
        ' Purpose               : To check if drill downs are present
        ' Description           : same as above
        ' Parameters Passed     : Parameter ID
        ' Returns               : true/false
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : May 11,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        AreDrillDownsPresent = 0
        strSQL = "usp_sel_tbl_RDB_DrillDown_UserSettings " & ParameterID & "," & m_lngEmployeeID & ",'" & m_strLoginType & "',null,1"
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            AreDrillDownsPresent = 1
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

    Private Function OtherParameterString(ByVal ID As Long, ByVal strProjectID As String) As String
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

        strSQL = "usp_sel_tbl_RDB_ProjectRadar_Data_ProjectDetails " & ID & "," & strProjectID & "," & m_lngEmployeeID & ",'" & m_strLoginType & "'"
        dr = CommonFunctions.Data.GetDataReader(strSQL, True)
        If dr.Read Then
            strRet = dr("Details").ToString
        End If
        DisposeDataDeader(dr)
        Return strRet
    End Function

    Protected Overrides Sub Finalize()
        m_objDBRadar = Nothing
        MyBase.Finalize()
    End Sub

    Private Function GetImageURL(ByVal PlotPercentage As Double) As String
        '=====================================================================
        ' Procedure Name        : GetImageURL()	
        ' Purpose               : To get the image URL for the project view
        ' Description           : same as above
        ' Parameters Passed     : The plot percentage
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Images are present in the ../../Images folder
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : May 07,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim dr As IDataReader
        Dim dblNStart, dblNEnd, dblWStart, dblWEnd, dblDStart, dblDEnd As Double

        ' based on the plot percentage change the image URL
        strSQL = "usp_sel_tbl_RDB_Parameter_UserSettings " & m_lngEmployeeID & ",'" & m_strLoginType & "'"
        strSQL += "," & m_lngParameterID & ",'" & m_strType & "'"
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            dblNStart = CType(CommonFunctions.Data.CheckIsDBNull(dr("NormalStart"), "0"), Double)
            dblNEnd = CType(CommonFunctions.Data.CheckIsDBNull(dr("NormalEnd"), "0"), Double)
            dblWStart = CType(CommonFunctions.Data.CheckIsDBNull(dr("WarningStart"), "0"), Double)
            dblWEnd = CType(CommonFunctions.Data.CheckIsDBNull(dr("WarningEnd"), "0"), Double)
            dblDStart = CType(CommonFunctions.Data.CheckIsDBNull(dr("DangerStart"), "0"), Double)
            dblDEnd = CType(CommonFunctions.Data.CheckIsDBNull(dr("DangerEnd"), "0"), Double)
        End If
        DisposeDataDeader(dr)

        ' set the image URL accordingly
        If PlotPercentage >= dblNStart And PlotPercentage <= dblNEnd Then
            GetImageURL = "../../Images/RDB_ProjectGreen.gif"
        ElseIf PlotPercentage >= dblWStart And PlotPercentage <= dblWEnd Then
            GetImageURL = "../../Images/RDB_ProjectOrange.gif"
        ElseIf PlotPercentage >= dblDStart And PlotPercentage <= dblDEnd Then
            GetImageURL = "../../Images/RDB_ProjectRed.gif"
        Else
            GetImageURL = "../../Images/RDB_ProjectGreen.gif"
        End If
    End Function
#End Region

#Region "events"
    Private Sub m_objDBRadar_DataPoint_Render(ByVal sender As Object, ByVal e As System.EventArgs) Handles m_objDBRadar.DataPoint_Render
        Dim objRadarPoint As New RadarPoint("")
        Dim img As New RadarPointImage("")
        Dim strParameter As String = ""
        Dim strProjectID As String = ""
        Dim strToolTip As String = ""
        Dim arr() As String = {}
        Dim byteDrillDownExists As Byte

        ' get the radar point object
        objRadarPoint = CType(sender, RadarPoint)
        ' get the image used for the point
        img = objRadarPoint.PlotImage
        img.Border = 0

        If objRadarPoint.PlotPercentage < 0 Then objRadarPoint.PlotPercentage = 0

        If UCase(Trim(m_strView & "")) = "PROJECT" Then
            If m_lngParameterID > 0 Then
                ' check which zone the project lies in
                Try
                    arr = Split(objRadarPoint.ToolTipText, "|")
                    strProjectID = arr(0)
                Catch
                    strProjectID = "0"
                End Try
                objRadarPoint.ToolTipText = strToolTip
                img.ClickURL = "javascript:Project_OnClick(" & strProjectID & ")"
                ' get the tool tip for the project
                strToolTip = OtherParameterString(m_lngParameterID, strProjectID)
                ' set the image URL based on the percentage
                img.URL = GetImageURL(objRadarPoint.PlotPercentage)
                objRadarPoint.ToolTipText = strToolTip
            Else
                ' no parameter..no display
                objRadarPoint.PlotImage.Style = " style='display:none' "
            End If
        Else
            strParameter = Replace(Replace(Replace(objRadarPoint.ToolTipText, objRadarPoint.PlotPercentage.ToString, ""), Chr(13), ""), Chr(10), "")
            ' Modified By NitinVS on 2 Sep 2005 for WhizibleSEM SP4 IssueID 130 
            ' Added Parameter for Parameter value to Parameter_OnClick
            Select Case UCase(Trim(strParameter & ""))
                Case "ATTRITIONRATE"
                    byteDrillDownExists = AreDrillDownsPresent(ATTRITION_RATE)
                    objRadarPoint.ToolTipText = GetParameterName(ATTRITION_RATE) & ":" & FormatNumber(objRadarPoint.PlotPercentage, 2) & " %"
                    img.URL = "../../images/RDB_AttritionRate.gif"
                    img.ClickURL = "javascript:Parameter_OnClick('" & ATTRITION_RATE & "'," & byteDrillDownExists & "," & FormatNumber(objRadarPoint.PlotPercentage, 2) & ")"

                Case "IDLECAPACITY"
                    byteDrillDownExists = AreDrillDownsPresent(IDLE_CAPACITY)
                    objRadarPoint.ToolTipText = GetParameterName(IDLE_CAPACITY) & ":" & FormatNumber(objRadarPoint.PlotPercentage, 2) & " %"
                    img.URL = "../../images/RDB_IdleResource.gif"
                    img.ClickURL = "javascript:Parameter_OnClick('" & IDLE_CAPACITY & "'," & byteDrillDownExists & "," & FormatNumber(objRadarPoint.PlotPercentage, 2) & ")"
                Case "EFFORTVARIANCE"
                    byteDrillDownExists = AreDrillDownsPresent(EFFORT_VARIANCE)
                    objRadarPoint.ToolTipText = GetParameterName(EFFORT_VARIANCE) & ":" & FormatNumber(objRadarPoint.PlotPercentage, 2) & " %"

                    ' Modified BY NitinVS on  Sep 2005 for WhizibleSEM IssueID 130 
                    ' No Drilldown for Effort Variance
                    img.URL = "../../images/RDB_Clock.gif"
                    img.ClickURL = "javascript:Parameter_OnClick('" & EFFORT_VARIANCE & "'," & byteDrillDownExists & "," & FormatNumber(objRadarPoint.PlotPercentage, 2) & ")"
                    'img.ClickURL = ""
                    ' End Modification BY NitinVS on  Sep 2005 for WhizibleSEM IssueID 130 
                Case "SCHEDULEVARIANCE"
                    byteDrillDownExists = AreDrillDownsPresent(SCHEDULE_VARIANCE)
                    objRadarPoint.ToolTipText = GetParameterName(SCHEDULE_VARIANCE) & ":" & FormatNumber(objRadarPoint.PlotPercentage, 2) & " %"
                    img.URL = "../../images/RDB_Calendar.gif"
                    img.ClickURL = "javascript:Parameter_OnClick('" & SCHEDULE_VARIANCE & "'," & byteDrillDownExists & "," & FormatNumber(objRadarPoint.PlotPercentage, 2) & ")"

                Case "OUTSTANDING"
                    byteDrillDownExists = AreDrillDownsPresent(OUTSTANDING)
                    objRadarPoint.ToolTipText = GetParameterName(OUTSTANDING) & ":" & FormatNumber(objRadarPoint.PlotPercentage, 2) & " %"
                    img.URL = "../../images/RDB_Dollar.gif"
                    img.ClickURL = "javascript:Parameter_OnClick('" & OUTSTANDING & "'," & byteDrillDownExists & "," & FormatNumber(objRadarPoint.PlotPercentage, 2) & ")"
                Case "PROFIT"
                    byteDrillDownExists = AreDrillDownsPresent(PROFIT)
                    objRadarPoint.ToolTipText = GetParameterName(PROFIT) & ":" & FormatNumber(objRadarPoint.PlotPercentage, 2) & " %"
                    img.URL = "../../images/RDB_Dollar.gif"
                    img.ClickURL = "javascript:Parameter_OnClick('" & PROFIT & "'," & byteDrillDownExists & "," & FormatNumber(objRadarPoint.PlotPercentage, 2) & ")"
                Case "OPENISSUES"
                    byteDrillDownExists = AreDrillDownsPresent(OPEN_ISSUES)
                    objRadarPoint.ToolTipText = GetParameterName(OPEN_ISSUES) & ":" & FormatNumber(objRadarPoint.PlotPercentage, 2) & " %"
                    img.URL = "../../images/RDB_Zoom.gif"
                    img.ClickURL = "javascript:Parameter_OnClick('" & OPEN_ISSUES & "'," & byteDrillDownExists & "," & FormatNumber(objRadarPoint.PlotPercentage, 2) & ")"
                Case "REWORK"
                    byteDrillDownExists = AreDrillDownsPresent(REWORK_EFFORTS)
                    objRadarPoint.ToolTipText = GetParameterName(REWORK_EFFORTS) & ":" & FormatNumber(objRadarPoint.PlotPercentage, 2) & " %"
                    img.URL = "../../images/RDB_Rework.gif"
                    img.ClickURL = "javascript:Parameter_OnClick('" & REWORK_EFFORTS & "'," & byteDrillDownExists & "," & FormatNumber(objRadarPoint.PlotPercentage, 2) & ")"
                    ' End Modification By NitinVS On 2 Sep 2005 for WhizibleSEM SP4 IssueID 130 
                Case Else
            End Select
        End If

        'Modified BY NitinVS on  Sep 2005 for WhizibleSEM IssueID 130 
        ' If Plot Percentage of any value is more than 100 set it to 100 
        If objRadarPoint.PlotPercentage > 100 Then
            objRadarPoint.PlotPercentage = 100
        End If
        ' End Modification By NitinVS On 2 Sep 2005 for WhizibleSEM SP4 IssueID 130 

        objRadarPoint.PlotImage = img
        objRadarPoint = Nothing
    End Sub

    Private Sub m_objMenu_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_Menu) Handles m_objMenu.Initialize
        Args.clsTR = "clsTRRadarMenu"
        Args.cssClass = "RadarMenu"
    End Sub
#End Region


End Class

