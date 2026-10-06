Imports RadarLibrary

Public Class RDB_ProjectRadar
    Inherits WebPages.Template.WhizTemplate

    Private WithEvents m_objDBRadar As New DBRadar
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu

    Protected m_strType As String = "PR"
    Protected m_strView As String = "PARAMETER"
    Protected m_lngProjectID As Long = 0
    Protected m_lngParameterID As Long = 0

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load, Me.Load
        MyBase.ApplySecurity(True)
        Call Initialize()
    End Sub

    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        ' MyBase.ApplySecurity(False, 2)
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
        ' Created               : May 07,2004
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
        ' location
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("LocationID")) <> "" Then
            m_lngLocationID = CType(Request.QueryString("LocationID"), Long)
        End If
        ' department
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("DepartmentID")) <> "" Then
            m_lngDepartmentID = CType(Request.QueryString("DepartmentID"), Long)
        End If
        ' parameter
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ParameterID")) <> "" Then
            m_lngParameterID = CType(Request.QueryString("ParameterID"), Long)
        End If
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
        ' Created               : May 07,2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrCSFunction() As String = {"Close_OnClick()"}
        Dim strMenu As String

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        Call Boot()

        With Response
            .Write(strMenu)
            .Write("<div id='divRadar' align='center' width='100%'>")
            ' plot the radar here
            .Write(Radar())
            .Write("</div>")
            .Write(strMenu)
        End With

        Call ShutDown()
    End Sub



#Region "Other Procedures"

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
        ' Created               : May 07,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strAccess As String = ""

        strAccess = GetProjectAccessFilter()

        ' Project radar
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
                strSQL += ",'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.BuildQueryString(strAccess)) + "'"
            Else
                strSQL += ",null"
            End If
        Else
            strSQL = "select 0 as [KeyName],0 as [KeyValue]"
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
        ' Created               : May 07,2004
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
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : May 07,2004
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
        ' Created               : May 07,2004
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
            ' default
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

        ' get the radar point object
        objRadarPoint = CType(sender, RadarPoint)
        ' get the image used for the point
        img = objRadarPoint.PlotImage
        img.Border = 0

        If objRadarPoint.PlotPercentage < 0 Then objRadarPoint.PlotPercentage = 0

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

        objRadarPoint.PlotImage = img
        objRadarPoint = Nothing
    End Sub

#End Region


    Private Sub m_objMenu_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_Menu) Handles m_objMenu.Initialize
        Args.clsTR = "clsTRRadarMenu"
        Args.cssClass = "RadarMenu"
    End Sub
End Class


