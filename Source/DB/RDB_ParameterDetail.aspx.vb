Public Class RDB_ParameterDetail
    Inherits WebPages.Template.WhizTemplate

    Protected m_strType As String = ""  ' | BR - Business Radar, PR - Project Radar
    Protected m_intRefreshParent As Integer
    Protected m_lngDepartmentID As Long = 0
    Protected m_lngLocationID As Long = 0
    Protected m_lngParameterID As Long = 0
    Protected m_intProjectRelated As Integer = 0
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
        'MyBase.ApplySecurity(False, 2)
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
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("LocationID")) <> "" Then
            m_lngLocationID = CType(Request.QueryString("LocationID"), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("DepartmentID")) <> "" Then
            m_lngDepartmentID = CType(Request.QueryString("DepartmentID"), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ParameterID")) <> "" Then
            m_lngParameterID = CType(Request.QueryString("ParameterID"), Long)
        End If
        m_intRefreshParent = 0
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
        Dim strParameterName As String = ""
        Dim strNMin As String = "null", strNMax As String = "null", strWMin As String = "null"
        Dim strWMax As String = "null", strDMin As String = "null", strDmax As String = "null"

        If UCase(Trim(m_strAction & "")) = "SAVE" Or UCase(Trim(m_strAction & "")) = "NEXT" Then
            ' get the submitted values
            strNMin = MyBase.GetFormValue("txtNMin")
            strNMax = MyBase.GetFormValue("txtNMax")
            strWMin = MyBase.GetFormValue("txtWMin")
            strWMax = MyBase.GetFormValue("txtWMax")
            strDMin = MyBase.GetFormValue("txtDMin")
            strDmax = MyBase.GetFormValue("txtDMax")
            strParameterName = MyBase.GetFormValue("txtParameterName")

            ' build the sql
            strSQL = "usp_upd_tbl_RDB_Parameter_UserSettings_Details " & m_lngParameterID
            strSQL += "," & m_lngEmployeeID & ",'" & m_strLoginType & "'"
            strSQL += ",'" & strParameterName + "'"
            strSQL += "," + strNMin + "," + strNMax
            strSQL += "," + strWMin + "," + strWMax
            strSQL += "," + strDMin + "," + strDmax

            ' update
            CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
            ' refresh parent? set the flag and refresh in window_onload event
            m_intRefreshParent = 1

            If UCase(Trim(m_strAction & "")) = "NEXT" Then
                Response.Redirect("RDB_DrillDownSettings.aspx?ParameterID=" & m_lngParameterID & "&type=" & m_strType)
            End If
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

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_NEXT"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_NEXT_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrCSFunction() As String = {"Next_OnClick()", "Save_OnClick()", "Close_OnClick()", "Help_OnClick('RDB_PARAMETER_LIST')"}
        Dim strMenu As String

        Dim strSQL As String
        Dim dr As IDataReader
        Dim strParameterName As String = ""
        Dim blnProjectRelated As Boolean
        Dim strNMin As String = "", strNMax As String = "", strWMin As String = ""
        Dim strWMax As String = "", strDMin As String = "", strDmax As String = ""

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)

        strSQL = "usp_sel_tbl_RDB_Parameter_UserSettings " & m_lngEmployeeID & ",'" & m_strLoginType & "'," & m_lngParameterID & ",'" & CommonFunctions.General.BuildQueryString(m_strType) & "'"
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            strParameterName = dr("ParameterName").ToString
            blnProjectRelated = CType(CommonFunctions.Data.CheckIsDBNull(dr("IsProjectRelated"), "0"), Boolean)
            strNMin = dr("NormalStart").ToString
            strNMax = dr("NormalEnd").ToString
            strWMin = dr("WarningStart").ToString
            strWMax = dr("WarningEnd").ToString
            strDMin = dr("DangerStart").ToString
            strDmax = dr("DangerEnd").ToString
        End If
        DisposeDataDeader(dr)

        If blnProjectRelated Then : m_intProjectRelated = 1 : Else : m_intProjectRelated = 0 : End If

        MyBase.InitializeResources("AppResources.RDB_ParameterDetail", "AppResources")

        With Response
            .Write(strMenu)
            .Write("<BR>")
            ' title
            .Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAP_PARAMETER_DETAIL") & GetParameterName(m_lngParameterID), , , False))
            .Write("<BR>")

            .Write("<DIV id=divList style='overflow:auto;height:300;width=100%'>")

            .Write("<Table class=clsTable cellpadding=0 cellspacing=0 width=99.9% >")

            ' Parameter Name
            .Write("<TR class=clsTrEven >")
            .Write("<TD width=30% align=right>" & MyBase.GetResourceString("LBL_PARAMETER_NAME") & "</TD>")
            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawTextBox("txtParameterName", "txtParameterName", , 200, 200, strParameterName, , , , , , , , , True, EnableHTMLEncode:=True)
            .Write("</TD>")
            .Write("</TR>")
            .Write("</Table>")

            ' for project-related parameter we will capture the ranges also!!
            If blnProjectRelated Then
                .Write("<Table class=clsTable id=tblRange width='99.9%'cellpadding=1 cellspacing=1 >" & vbCrLf)
            Else
                .Write("<Table class=clsTable id=tblRange width='99.9%'cellpadding=1 cellspacing=1 style='display:none'>" & vbCrLf)
            End If

            .Write("<TR class=clsTRColumnHeader>" & vbCrLf)
            .Write("<TD  width='40%' align=right>" & MyBase.GetResourceString("LBL_RANGE") & "</td>" & vbCrLf)
            .Write("<TD  width='30%' align=right>" & MyBase.GetResourceString("LBL_START") & "</td>" & vbCrLf)
            .Write("<TD  width='30%' align=right>" & MyBase.GetResourceString("LBL_END") & "</td>" & vbCrLf)
            .Write("</TR>" & vbCrLf)

            ' Normal range
            .Write("<TR class=clsTROdd>" & vbCrLf)
            .Write("<TD  width='40%'align=right>" & MyBase.GetResourceString("LBL_NORMAL_RANGE") & "</td>" & vbCrLf)
            .Write("<TD  width='30%'align=right>" & vbCrLf)
            CommonFunctions.HTMLControls.DrawTextBox("txtNMin", "txtNMin", , 50, 8, strNMin, "right", , , , , , , , True, EnableHTMLEncode:=True)
            .Write("</td>" & vbCrLf)
            .Write("<TD  width='30%'align=right>" & vbCrLf)
            CommonFunctions.HTMLControls.DrawTextBox("txtNMax", "txtNMax", , 50, 8, strNMax, "right", , , , , , , , True, EnableHTMLEncode:=True)
            .Write("</td>" & vbCrLf)
            .Write("</TR>" & vbCrLf)

            ' warning range
            .Write("<TR class=clsTREven>" & vbCrLf)
            .Write("<TD  width='40%'align=right>" & MyBase.GetResourceString("LBL_WARNING_RANGE") & "</td>" & vbCrLf)
            .Write("<TD  width='30%'align=right>" & vbCrLf)
            CommonFunctions.HTMLControls.DrawTextBox("txtWMin", "txtWMin", , 50, 8, strWMin, "right", , , , , , , , True, EnableHTMLEncode:=True)
            .Write("</td>" & vbCrLf)
            .Write("<TD  width='30%'align=right>" & vbCrLf)
            CommonFunctions.HTMLControls.DrawTextBox("txtWMax", "txtWMax", , 50, 8, strWMax, "right", , , , , , , , True, EnableHTMLEncode:=True)
            .Write("</td>" & vbCrLf)
            .Write("</TR>" & vbCrLf)

            ' danger range
            .Write("<TR class=clsTRodd>" & vbCrLf)
            .Write("<TD  width='40%'align=right>" & MyBase.GetResourceString("LBL_DANGER_RANGE") & "</td>" & vbCrLf)
            .Write("<TD  width='30%'align=right>" & vbCrLf)
            CommonFunctions.HTMLControls.DrawTextBox("txtDMin", "txtDMin", , 50, 8, strDMin, "right", , , , , , , , True, EnableHTMLEncode:=True)
            .Write("</td>" & vbCrLf)
            .Write("<TD  width='30%'align=right>" & vbCrLf)
            CommonFunctions.HTMLControls.DrawTextBox("txtDMax", "txtDMax", , 50, 8, strDmax, "right", , , , , , , , True, EnableHTMLEncode:=True)
            .Write("</td>" & vbCrLf)
            .Write("</TR>" & vbCrLf)

            .Write("</TABLE>" & vbCrLf)

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





