'=====================================================================
' Module Name       :       JobCodeConfig

' Purpose           :       Allows the user to configure job code ranges

' Description       :       Same as above

' Dependencies      :       None

' Author            :       DipaliS

' Created           :       May 12, 2004

' Revisions :
'=====================================================================

Public Class JobCodeConfig
    Inherits WebPages.Template.WhizTemplate

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
 
#Region "Constructor"
    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
#End Region

#Region "Member Variables"
    Private WithEvents m_objGrid As WebPages.Template.AdvancedGrid
    Private m_strMode As String = ""
    Private m_intRowCount As Integer
    Private m_intCurrentCount As Integer = 0
#End Region

#Region "Procedures"
    Public Sub PageInit()
        '######### Page Code starts here

        Dim strSQL As String

        m_strMode = Request.QueryString("Mode")

        If m_strMode Is Nothing Then
            m_strMode = ""
        End If

        'If Mode is save then save the data
        If m_strMode.ToLower = "save" Then
            strSQL = "usp_Upd_tbl_PM_JobCodeConfiguration '" & _
                        CommonFunctions.General.BuildQueryString(MyBase.GetFormValue("txtHidden")) & "','" & _
              CType(Session("strUserName"), String) & "'"

            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            m_strMode = ""
        End If

        'Get the Menu
        GetMenu()

        MyBase.InitializeResources("AppResources.JobCodeConfig", "AppResources")

        'Draw the Legend
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {CommonFunctions.HTMLControls.DrawMandatoryImage(, True)}
        WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)

        'Get the Page Caption
        WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("PAGE_CAPTION"))
        Response.Write("<DIV ID='PageDiv' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")

        'Get the UI depenging upon strCodeGenerationLogic
        GetUI()

        Response.Write("</DIV>")

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        GetMenu()
        MyBase.InitializeResources("AppResources.JobCodeConfig", "AppResources")
    End Sub

    '====================================================================
    ' Procedure Name        :       GetMenu
    ' Parameters Passed     :       None
    ' Returns               :       None
    ' Parameters Affected   :       None
    ' Purpose               :       Displays the Static menu for the page
    ' Description           :       Same as above
    ' Assumptions           :       None
    ' Dependencies          :       None
    ' Author                :       DipaliS
    ' Created               :       May 12, 2004
    ' Revisions :
    '=====================================================================
    Private Sub GetMenu()
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDNEW"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuClientFun() As String = {"AddNew_OnClick()", "Save_OnClick()", "Close_OnClick()", "Help_OnClick('JOBCODE_CONF')"}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim objMenu As WebPages.Template.StaticMenu
        objMenu = New WebPages.Template.StaticMenu
        objMenu.DrawMenu(arrMenu, arrMenuClientFun, arrMenuToolTip, False)
        objMenu = Nothing
    End Sub

    '====================================================================
    ' Procedure Name        :       GetUI
    ' Parameters Passed     :       None
    ' Returns               :       None
    ' Parameters Affected   :       None
    ' Purpose               :       Displays the UI for the page 
    ' Description           :       Same as above
    ' Assumptions           :       None
    ' Dependencies          :       None
    ' Author                :       DipaliS
    ' Created               :       May 12, 2004
    ' Revisions :
    '=====================================================================

    Private Sub GetUI()
        Dim strSQL As String = "usp_sel_tbl_PM_JobCodeConfiguration"
        Dim drNoOfRows As IDataReader

        'Get  the number of rows 
        drNoOfRows = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        While drNoOfRows.Read
            m_intRowCount = m_intRowCount + 1
        End While
        CommonFunctions.Data.DisposeDataReader(drNoOfRows)

        'Show the UI
        Response.Write("<BR>")

        m_objGrid = New WebPages.Template.AdvancedGrid
        Dim arrActualColumnArray() As String = {"LCVStart", _
                                                "LCVEnd", _
                                                "JobCodeStart", _
                                                "JobCodeEnd", _
                                                "LastCodeUsed"}
        Dim arrUserFriendlyArray() As String = {MyBase.GetResourceString("START_RANGE_LCV"), _
                                                MyBase.GetResourceString("END_RANGE_LCV"), _
                                                MyBase.GetResourceString("START_RANGE_JOB"), _
                                                MyBase.GetResourceString("END_RANGE_JOB"), _
                                                MyBase.GetResourceString("LAST_CODE")}
        Dim arrTDStyle() As String = {"align=center", "align=center", "align=center", "align=center", "align=center"}

        m_objGrid.ActualColumnArray = arrActualColumnArray
        m_objGrid.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGrid.UseSQL = MyBase.UseSQL
        m_objGrid.SQL = strSQL
        m_objGrid.NoOfDataColumns = 5
        m_objGrid.DIVStyle = "'overflow:auto;height=100%;width:100%;'"
        m_objGrid.TDStyleArray = arrTDStyle
        m_objGrid.DrawGrid()
        m_objGrid = Nothing

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtHidden", "txtHidden", , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
    End Sub

#End Region

#Region "Functions"
    '====================================================================
    ' Procedure Name        :       GetStringForNewRow
    ' Parameters Passed     :       CLSToBeApplied
    ' Returns               :       String For New Row
    ' Parameters Affected   :       None
    ' Purpose               :       Gives string of new row with prpoer CSS appliesd
    ' Description           :       Same as above
    ' Assumptions           :       None
    ' Dependencies          :       None
    ' Author                :       DipaliS
    ' Created               :       May 12, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetStringForNewRow(ByVal CLSToBeApplied As String) As String
        Dim strResult As String
        'Set proper Class for TR
        If CLSToBeApplied.ToLower = "odd" Then
            strResult = "<tr class=clsTROdd>"
        Else
            strResult = "<tr class=clsTREven>"
        End If
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        strResult += "<td align=center>" + CommonFunctions.HTMLControls.DrawTextBox("txtStartLCV", "txtStartLCV", , 60, , , "right", , , , , , "onkeypress=OnlyNumeric(0)", True, True, EnableHTMLEncode:=True) + "</td>"
        strResult += "<td align=center>" + CommonFunctions.HTMLControls.DrawTextBox("txtEndLCV", "txtEndLCV", , 60, , , "right", , , , , , "onkeypress=OnlyNumeric(0)", True, True, EnableHTMLEncode:=True) + "</td>"
        strResult += "<td align=center>" + CommonFunctions.HTMLControls.DrawTextBox("txtStartJobCode", "txtStartJobCode", , 60, , , "right", , , , , , "onkeypress=OnlyNumeric(0)", True, True, EnableHTMLEncode:=True) + "</td>"
        strResult += "<td align=center>" + CommonFunctions.HTMLControls.DrawTextBox("txtEndJobCode", "txtEndJobCode", , 60, , , "right", , , , , , "onkeypress=OnlyNumeric(0)", True, True, EnableHTMLEncode:=True) + "</td>"
        strResult += "<td align=center>" + CommonFunctions.HTMLControls.DrawTextBox("txtLastJobCode", "txtLastJobCode", , 60, , , "right", , , , , , "onkeypress=OnlyNumeric(0)", True, EnableHTMLEncode:=True) + "</td>" + "</tr>"
        'ended by Yogesh J for HTML encoding Date:06/10/15
        Return strResult
    End Function
#End Region

#Region "GridEvents"
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'Insert the Text Boxes into the row
        Dim strToBeInserted As String = ""
        Select Case Args.ColIndex
            Case 0
                If Not IsNothing(Args.DataReader.Item("LCVStart")) Then

                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    strToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txtStartLCV", "txtStartLCV", , 60, , CType(Args.DataReader.Item("LCVStart"), String), "right", , , , , , "onkeypress=OnlyNumeric(0)", True, True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                End If
            Case 1
                If Not IsNothing(Args.DataReader.Item("LCVEnd")) Then
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    strToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txtEndLCV", "txtEndLCV", , 60, , CType(Args.DataReader.Item("LCVEnd"), String), "right", , , , , , "onkeypress=OnlyNumeric(0)", True, True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                End If
            Case 2
                If Not IsNothing(Args.DataReader.Item("JobCodeStart")) Then
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    strToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txtStartJobCode", "txtStartJobCode", , 60, , CType(Args.DataReader.Item("JobCodeStart"), String), "right", , , , , , "onkeypress=OnlyNumeric(0)", True, True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                End If
            Case 3
                If Not IsNothing(Args.DataReader.Item("JobCodeEnd")) Then
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    strToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txtEndJobCode", "txtEndJobCode", , 60, , CType(Args.DataReader.Item("JobCodeEnd"), String), "right", , , , , , "onkeypress=OnlyNumeric(0)", True, True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                End If
            Case 4
                If Not IsNothing(Args.DataReader.Item("LastCodeUsed")) Then
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    strToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txtLastJobCode", "txtLastJobCode", , 60, , CType(Args.DataReader.Item("LastCodeUsed"), String), "right", , , , , , "onkeypress=OnlyNumeric(0)", True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                End If
        End Select
        Cancel = True
        Args.StringToBeInserted = "<td align=center>" & strToBeInserted & "</td>"
    End Sub

    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        'If it is the last row and mode is add then add a new row containing blank text boxes with proper CLS applied
        m_intCurrentCount = m_intCurrentCount + 1
        If m_intCurrentCount = m_intRowCount Then
            If m_strMode.ToLower = "add" Then
                If Args.clsTR.ToLower = "clstreven" Then
                    Args.StringToBeInserted = GetStringForNewRow("odd")
                End If
                If Args.clsTR.ToLower = "clstrodd" Then
                    Args.StringToBeInserted = GetStringForNewRow("even")
                End If
            End If
        End If

    End Sub

    Private Sub m_objGrid_NoDataCommentTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_NoDataCommentTR) Handles m_objGrid.NoDataCommentTR_BeforePrint
        If m_strMode.ToLower = "add" Then
            Cancel = True
            Args.StringToBeInserted = GetStringForNewRow("odd")
        End If
    End Sub

#End Region

End Class
