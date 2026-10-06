Public Class PRO_ProjectTypeTaskTypes
    Inherits WebPages.Template.WhizTemplate

    Protected m_strAction As String = ""
    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean

    Private WithEvents m_objGrid As New WebPages.Grid.cMultiInsertGrid
    Private m_intProjectTypeID As Integer

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ''commented by nilesh g on 31/12/2015 for Security
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        ''end of commented by nilesh g on 31/12/2015 for Security
        Call Initialize()
    End Sub


    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
    End Sub


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 18,2004
        ' Revisions             :
        '=====================================================================
        ' Action of the page
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        m_intProjectTypeID = CType(Request.QueryString("TypeID"), Integer)
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

    End Sub


    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page for mapping task types for
        '                         the project type
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Feb 18,2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_CLEAR_ALL"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_CLEAR_ALL"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        Dim arrCSFunction() As String = {"Save_OnClick(" & m_intProjectTypeID & ")", "SelectAll_OnClick('frmProjectTypeTaskTypes','chkSelect')", "ClearAll_OnClick('frmProjectTypeTaskTypes','chkSelect')", "Close_OnClick()", "Help_OnClick('PTYPECONFIG_TASKTYPES')"}

        Dim dr As IDataReader
        Dim strSQL As String
        Dim strMenu As String
        Dim strProjectType As String
        Dim arrUFN() As String = {"Task Type", "Select"}
        Dim arrAN() As String = {"TaskType", "Selected"}
        Dim arrChkBox() As String = {"", "chkSelect"}
        Dim arrChkBoxCheckedOn() As String = {"", "Selected"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)

        ' menu
        Response.Write(strMenu)
        Response.Write("<BR>")

        ' get the project type name
        strSQL = "usp_sel_ProjectTypeRelated_Informaion 7," & m_intProjectTypeID & ",null"
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            strProjectType = dr("ProjectType").ToString
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        'page caption
        Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Task Types", "Practice : " & strProjectType))
        Response.Write("<BR>")

        ' plot the grid here
        With m_objGrid
            .NoOfDataColumns = 1
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrUFN
            .CheckBoxIDArray = arrChkBox
            .CheckboxCheckOnColumnArray = arrChkBoxCheckedOn

            .SQL = "usp_Sel_Project_TaskType " & m_intProjectTypeID
            .TableName = "tbl_PM_ProjectTypes_TaskTypes"
            .ForeignKey = "ProjectTypeID"
            .PrimaryKey = "TaskTypeID"
            .ForeignKeyValue = m_intProjectTypeID.ToString
            .UseSQL = m_blnUseSQL

            If UCase(Trim(m_strAction & "")) = "SAVE" Then
                ' calling the save method of the grid
                .Save()
            End If
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ' draw the grid
            .DrawGrid()
        End With
        m_objGrid = Nothing
        Response.Write(strMenu)
    End Sub


#Region "Events"
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint

    End Sub

    Private Sub m_objGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objGrid.ColumnHeaderTR_BeforePrint

    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint

    End Sub

    Private Sub m_objGrid_Div_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DIV) Handles m_objGrid.Div_BeforePrint

    End Sub

    Private Sub m_objGrid_Footer_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_Footer) Handles m_objGrid.Footer_BeforePrint

    End Sub

    Private Sub m_objGrid_Header_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_Header) Handles m_objGrid.Header_BeforePrint

    End Sub

    Private Sub m_objGrid_Initialize(ByRef Cancel As Boolean, ByVal Args As WAF_Grid) Handles m_objGrid.Initialize

    End Sub

    Private Sub m_objGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objGrid.SummaryFunctionsTD_BeforePrint

    End Sub

    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint

    End Sub

    Private Sub m_objGrid_Table_BeforePrint(ByRef Args As WAF_Table) Handles m_objGrid.Table_BeforePrint

    End Sub


    ' Added Nov 23,2004 Rajanikant Khethawatt
    Private Sub m_objGrid_Grid_BeforeDeletion(ByRef Cancel As Boolean, ByRef Args As WebPages.Grid.WAF_MultiInsert_Data) Handles m_objGrid.Grid_BeforeDeletion
        Dim strSQL As String = Args.SQL
        ' deleting only those entries which are not selected currently
        If Trim(Args.SubmittedPrimaryKeys & "") <> "" Then
            strSQL += " AND " + Args.PrimaryKey + " NOT IN (" + Args.SubmittedPrimaryKeys + ")"
        End If
        Args.SQL = strSQL
    End Sub

    Private Sub m_objGrid_Grid_BeforeInsertion(ByRef Cancel As Boolean, ByRef Args As WebPages.Grid.WAF_MultiInsert_Data) Handles m_objGrid.Grid_BeforeInsertion
        Dim strSQL As String = ""

        strSQL = " IF NOT EXISTS( SELECT * FROM " + Args.TableName + " WHERE " + Args.ForeignKey + "='" + CommonFunctions.General.BuildQueryString(Args.ForeignKeyValue) + "' AND " + Args.PrimaryKey + "='" + CommonFunctions.General.BuildQueryString(Args.PrimaryKeyValue) + "')" + vbCrLf
        strSQL += " BEGIN " + vbCrLf
        strSQL += Args.SQL + vbCrLf
        strSQL += " END " + vbCrLf
        Args.SQL = strSQL
    End Sub
    ' End Addition Nov 23,2004 Rajanikant Khethawatt
#End Region
End Class
