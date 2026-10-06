Public Class RDB_DrillDownGraphSettings
    Inherits WebPages.Template.WhizTemplate

    Protected m_strType As String = ""  ' | BR - Business Radar, PR - Project Radar
    Protected m_lngParameterID As Long = 0
    Protected m_strSystemDrillDownType As String = ""

    Private m_lngEmployeeID As Long = 0
    Private m_strUserName As String = ""
    Private m_strLoginType As String = ""
    Private m_blnUseSQL As Boolean
    Private m_strAction As String = ""

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
        If Page.IsPostBack Then
            Call PeformActions()
        End If
    End Sub

    Public Sub New()
        ' MyBase.ApplySecurity(False, 2)
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True, 2)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the variables for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : May 10,2004
        ' Revisions             :
        '=====================================================================

        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_lngEmployeeID = CType(Session("intUserID"), Long)

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("type")) <> "" Then
            m_strType = Request.QueryString("type").ToString
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Action")) <> "" Then
            m_strAction = Request.QueryString("Action").ToString
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ParameterID")) <> "" Then
            m_lngParameterID = CType(Request.QueryString("ParameterID"), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("DrillDownType")) <> "" Then
            m_strSystemDrillDownType = Request.QueryString("DrillDownType").ToString
        End If
    End Sub

    Private Sub PeformActions()
        '=====================================================================
        ' Procedure Name        : PeformActions()	
        ' Purpose               : To perform the actions on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Commonfunctions namespace
        ' Author                : Rajanikant Khethawatt
        ' Created               : May 10,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strGraphTypeID As String
        Dim strPalleteStyle As String = ""
        Dim strBorderStyle As String = ""
        Dim strChartBackColor As String = ""
        Dim strChartAreaColor As String = ""
        Dim strCaptionColor As String = ""
        Dim strEnable3D As String
        Dim strShowLegends As String
        Dim strShowLabels As String
        Dim strGraphHeight As String
        Dim strGraphWidth As String
        Dim strBorderColor As String = ""
        Dim strTitleColor As String = ""

        If UCase(Trim(m_strAction & "")) = "SAVE" Then

            strGraphTypeID = MyBase.GetFormValue("cboGraphType")
            strPalleteStyle = MyBase.GetFormValue("cboPalleteStyle")
            strBorderStyle = MyBase.GetFormValue("cboBorderStyle")
            strChartBackColor = MyBase.GetFormValue("cboChartBackColor")
            strChartAreaColor = MyBase.GetFormValue("cboChartAreaColor")
            strCaptionColor = MyBase.GetFormValue("cboCaptionColor")
            strEnable3D = MyBase.GetFormValue("chkEnable3D")
            strShowLegends = MyBase.GetFormValue("chkShowLegends")
            strShowLabels = MyBase.GetFormValue("chkShowLabels")
            strGraphHeight = MyBase.GetFormValue("txtGraphHeight")
            strGraphWidth = MyBase.GetFormValue("txtGraphWidth")
            strBorderColor = MyBase.GetFormValue("cboBorderColor")
            strTitleColor = MyBase.GetFormValue("cboTitleColor")
            If Trim(strShowLegends & "") = "" Then strShowLegends = "0"
            If Trim(strShowLabels & "") = "" Then strShowLabels = "0"
            If Trim(strEnable3D & "") = "" Then strEnable3D = "0"

            ' get the submitted values
            strSQL = "usp_upd_tbl_RDB_DrillDown_UserSettings_Graph " & m_lngParameterID
            strSQL += "," & m_lngEmployeeID & ",'" & m_strLoginType & "'"
            strSQL += ",'" & m_strSystemDrillDownType & "'"
            strSQL += ",'" & strGraphTypeID & "'"
            strSQL += ",'" & strPalleteStyle & "'"
            strSQL += ",'" & strBorderStyle & "'"
            strSQL += ",'" & strChartBackColor & "'"
            strSQL += ",'" & strChartAreaColor & "'"
            strSQL += ",'" & strCaptionColor & "'"
            strSQL += "," & strEnable3D & ""
            strSQL += "," & strShowLegends & ""
            strSQL += "," & strShowLabels & ""
            strSQL += "," & strGraphHeight & ""
            strSQL += "," & strGraphWidth & ""
            strSQL += ",'" & strBorderColor & "'"
            strSQL += ",'" & strTitleColor & "'"

            ' update
            CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
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
        ' Created               : May 10,2004
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrCSFunction() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick('RDB_PARAMETER_DRILLDOWNS')"}
        Dim strMenu As String
        Dim strSQL As String
        Dim dr As IDataReader

        Dim intGraphTypeID As Integer
        Dim strPalleteStyle As String = ""
        Dim strBorderStyle As String = ""
        Dim strChartBackColor As String = ""
        Dim strChartAreaColor As String = ""
        Dim strCaptionColor As String = ""
        Dim strBorderColor As String = ""
        Dim strTitleColor As String = ""
        Dim blnEnable3D As Boolean
        Dim blnShowLegends As Boolean
        Dim blnShowLabels As Boolean
        Dim intGraphHeight As Integer
        Dim intGraphWidth As Integer
        Dim intNoOfGraphElements As Integer

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)

        strSQL = "usp_sel_tbl_RDB_DrillDown_UserSettings " & m_lngParameterID & "," & m_lngEmployeeID & ",'" & m_strLoginType & "'"
        Select Case m_strSystemDrillDownType
            Case "QTRLY" : strSQL += ",1"
            Case "MTHLY" : strSQL += ",2"
            Case "DAILY" : strSQL += ",3"
        End Select
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            intGraphTypeID = CType(dr("GraphType"), Integer)
            strPalleteStyle = dr("PalleteStyle").ToString
            strBorderStyle = dr("BorderStyle").ToString
            strChartBackColor = dr("ChartBackColor").ToString
            strChartAreaColor = dr("ChartAreaColor").ToString
            strCaptionColor = dr("CaptionColor").ToString
            strBorderColor = dr("BorderColor").ToString
            strTitleColor = dr("TitleColor").ToString
            blnEnable3D = CType(CommonFunctions.Data.CheckIsDBNull(dr("Enable3d"), "0"), Boolean)
            blnShowLegends = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowLegends"), "0"), Boolean)
            blnShowLabels = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowLabels"), "0"), Boolean)
            intGraphHeight = CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphHeight"), "300"), Integer)
            intGraphWidth = CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphWidth"), "400"), Integer)
        End If
        DisposeDataDeader(dr)

        MyBase.InitializeResources("AppResources.RDB_DrillDownGraphSettings", "AppResources")
        With Response
            .Write(strMenu)
            .Write("<BR>")

            ' title
            .Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAP_DRILLDOWN_GRAPH_SETTINGS") & GetParameterName(m_lngParameterID), , , False))
            .Write("<BR>")
            .Write("<DIV id=DivList style='overflow:auto;height=300'>")
            .Write("<TABLE class=clsTable cellpadding=0 cellspacing=0 width='99.9%'>" & vbCrLf)

            ' query for the graph
            strSQL = "EXEC usp_RDB_GetGraphTypes "
            .Write("<TR class=clsTREven>")
            .Write("<TD align=right>" & MyBase.GetResourceString("LBL_GRAPH") & "</TD>")
            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawComboBox("cboGraphType", strSQL, 0, intGraphTypeID.ToString, "", , , , True)
            .Write("</TD>")
            .Write("</TR>")

            ' Pallete Style
            .Write("<TR class=clsTrEven>")
            .Write("<TD align=right>" & MyBase.GetResourceString("LBL_COLOR_SCHEME") & "</TD>")
            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawComboBox("cboPalleteStyle", "usp_sel_CDB_GetPalleteStyle", 0, strPalleteStyle, "", False, , , True)
            .Write("</TD>")
            .Write("</TR>")

            ' border style
            .Write("<TR class=clsTREven>")
            .Write("<TD width='40%' align=right>" & MyBase.GetResourceString("LBL_BORDER_STYLE") & "</TD>")
            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawComboBox("cboBorderStyle", "usp_sel_CDB_GetBorderStyle", 0, strBorderStyle, , , , , True)
            .Write("</TD>")
            .Write("</TR>")

            ' Border color
            .Write("<TR class=clsTREven>")
            .Write("<TD width='40%' align=right>" & MyBase.GetResourceString("LBL_BORDER_COLOR") & "</TD>")
            .Write("<TD>")
            CommonFunction.HTMLControls.DrawColorComboBox("cboBorderColor", 100, strBorderColor, , , , , True)
            .Write("</TD>")
            .Write("</TR>")
            ' Title color
            .Write("<TR class=clsTREven>")
            .Write("<TD width='40%' align=right>" & MyBase.GetResourceString("LBL_TITLE_COLOR") & "</TD>")
            .Write("<TD>")
            CommonFunction.HTMLControls.DrawColorComboBox("cboTitleColor", 100, strTitleColor, , , , , True)
            .Write("</TD>")
            .Write("</TR>")


            ' chart back color
            .Write("<TR class=clsTREven>")
            .Write("<TD width='40%' align=right>" & MyBase.GetResourceString("LBL_CHART_BACK_COLOR") & "</TD>")
            .Write("<TD>")
            CommonFunction.HTMLControls.DrawColorComboBox("cboChartBackColor", 100, strChartBackColor, , , , , True)
            .Write("</TD>")
            .Write("</TR>")

            ' chart area color
            .Write("<TR class=clsTREven>")
            .Write("<TD width='40%' align=right>" & MyBase.GetResourceString("LBL_CHART_AREA_COLOR") & "</TD>")
            .Write("<TD>")
            CommonFunction.HTMLControls.DrawColorComboBox("cboChartAreaColor", 100, strChartAreaColor, , , , , True)
            .Write("</TD>")
            .Write("</TR>")

            ' caption color
            .Write("<TR class=clsTREven>")
            .Write("<TD width='40%' align=right>" & MyBase.GetResourceString("LBL_CAPTION_COLOR") & "</TD>")
            .Write("<TD>")
            CommonFunction.HTMLControls.DrawColorComboBox("cboCaptionColor", 100, strCaptionColor, , , , , True)
            .Write("</TD>")
            .Write("</TR>")

            ' Show Legends
            .Write("<TR class=clsTREven>")
            .Write("<TD width='40%' align=right>" & MyBase.GetResourceString("LBL_SHOW_LEGENDS") & "</TD>")
            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawCheckBox("chkShowLegends", "chkShowLegends", , blnShowLegends, "1")
            .Write("</TD>")
            .Write("</TR>")

            ' Show Legends
            .Write("<TR class=clsTREven>")
            .Write("<TD width='40%' align=right>" & MyBase.GetResourceString("LBL_SHOW_LABELS") & "</TD>")
            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawCheckBox("chkShowLabels", "chkShowLabels", , blnShowLabels, "1")
            .Write("</TD>")
            .Write("</TR>")

            ' enable 3D 
            .Write("<TR class=clsTREven>")
            .Write("<TD align=right>" & MyBase.GetResourceString("LBL_ENABLE_3D") & "</TD>")
            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawCheckBox("chkEnable3D", "chkEnable3D", , blnEnable3D, "1")
            .Write("</TD>")
            .Write("</TR>")

            ' Graph Height
            .Write("<TR class=clsTrEven>")
            .Write("<TD align=right>" & MyBase.GetResourceString("LBL_HEIGHT") & "</TD>")
            .Write("<TD>")
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("txtGraphHeight", "txtGraphHeight", , 40, 3, intGraphHeight.ToString, "right", , , , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .Write("</TD>")
            .Write("</TR>")

            ' Graph Height
            .Write("<TR class=clsTrEven>")
            .Write("<TD align=right>" & MyBase.GetResourceString("LBL_WIDTH") & "</TD>")
            .Write("<TD>")
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("txtGraphWidth", "txtGraphWidth", , 40, 3, intGraphWidth.ToString, "right", , , , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .Write("</TD>")
            .Write("</TR>")

            .Write("</TABLE>")
            .Write("</DIV>")

            .Write(strMenu)
        End With

    End Sub

#Region "Other Procedures"
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
        ' Created               : May 10,2004
        ' Revisions             :
        '=====================================================================
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub

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
        strSQL = "usp_sel_tbl_RDB_Parameter_UserSettings " & m_lngEmployeeID & ",'" & m_strLoginType & "'," & ParameterID & ",'" & CommonFunctions.General.BuildQueryString(m_strType) & "'"
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            GetParameterName = dr("ParameterName").ToString
        End If
        DisposeDataDeader(dr)
    End Function
#End Region

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class





