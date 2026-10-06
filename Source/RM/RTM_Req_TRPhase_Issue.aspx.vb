Public Class RTM_Req_TRPhase_Issue
    Inherits WebPages.Template.WhizTemplate
    Protected m_strAction As String = ""
    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean

    Private WithEvents m_objGrid As New WebPages.Grid.cMultiInsertGrid
    Protected m_intProjectRequirementID As Integer
    Protected m_intReqTRPhaseID As Integer
    Protected m_intProjectID As Integer


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
        Call Initialize()
    End Sub


    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub


    Private Sub Initialize()
        ' Action of the page
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        m_intProjectRequirementID = CType(Request.QueryString("ProjectRequirementID"), Integer)
        m_intReqTRPhaseID = CType(Request.QueryString("ReqTRPhaseID"), Integer)
        m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)

        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function

    Protected Sub WritePage()
        Dim dr As IDataReader
        Dim strSQL As String
        Dim strMenu As String
        Dim strProjectType As String
        Dim arrUFN() As String = {"Issue ID", "Summary", "Select"}
        Dim arrAN() As String = {"IssueID", "Summary", "Selected"}
        Dim arrChkBox() As String = {"", "", "chkSelect"}
        Dim arrChkBoxCheckedOn() As String = {"", "", "Selected"}

        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_CLEAR_ALL"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_CLEAR_ALL"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        'Dim arrCSFunction() As String = {"Save_OnClick(" & m_intProjectRequirementID & " , " & m_intReqTRPhaseID & " , " & m_intProjectID & ")", "SelectAll_OnClick('frmReqTRPhaseIssue','chkSelect')", "ClearAll_OnClick('frmReqTRPhaseIssue','chkSelect')", "Close_OnClick()", "Help_OnClick('ReqTRPhaseIssue')"}
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrCSFunctionList As New ArrayList

        If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_Chk_ParentRequirementOpen " + m_intProjectRequirementID.ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0").ToString = "1" Then
            arrMenuList.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
            arrCSFunctionList.Add("Save_OnClick(" & m_intProjectRequirementID & " , " & m_intReqTRPhaseID & " , " & m_intProjectID & ")")

            arrMenuList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))
            arrCSFunctionList.Add("SelectAll_OnClick('frmReqTRPhaseIssue','chkSelect')")

            arrMenuList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL"))
            arrCSFunctionList.Add("ClearAll_OnClick('frmReqTRPhaseIssue','chkSelect')")
        End If

        arrMenuList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrCSFunctionList.Add("Close_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_Help"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_Help_TOOLTIP"))
        arrCSFunctionList.Add("Help_OnClick('ReqTRPhaseIssue')")

        strMenu = WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenuList), GetArray(arrCSFunctionList), GetArray(arrMenuToolTipList))
        ' menu
        Response.Write(strMenu)
        Response.Write("<BR>")

        'page caption
        Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Issues"))
        Response.Write("<BR>")

        ' plot the grid here
        With m_objGrid
            .NoOfDataColumns = 2
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrUFN
            .CheckBoxIDArray = arrChkBox
            .CheckboxCheckOnColumnArray = arrChkBoxCheckedOn
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = "usp_Sel_tbl_RTM_TRPhase_Issue " & m_intReqTRPhaseID & " , " & m_intProjectID
            .TableName = "tbl_RTM_TRPhase_Issue"
            .ForeignKey = "ReqTRPhaseID"
            .PrimaryKey = "IssueID"
            .ForeignKeyValue = m_intReqTRPhaseID.ToString
            .UseSQL = m_blnUseSQL

            If UCase(Trim(m_strAction & "")) = "SAVE" Then
                .Save()
            End If

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
    Private Sub m_objGrid_Grid_BeforeInsertion(ByRef Cancel As Boolean, ByRef Args As WebPages.Grid.WAF_MultiInsert_Data) Handles m_objGrid.Grid_BeforeInsertion
        Dim strSQL As String = ""

        ''strSQL = " IF NOT EXISTS( SELECT * FROM " + Args.TableName + " WHERE " + Args.ForeignKey + "='" + CommonFunctions.General.BuildQueryString(Args.ForeignKeyValue) + "' AND " + Args.PrimaryKey + "='" + CommonFunctions.General.BuildQueryString(Args.PrimaryKeyValue) + "')" + vbCrLf
        ''strSQL += " BEGIN " + vbCrLf
        ''strSQL += Args.SQL + vbCrLf
        ''strSQL += " END " + vbCrLf
        ''Args.SQL = strSQL

    End Sub
#End Region

End Class
