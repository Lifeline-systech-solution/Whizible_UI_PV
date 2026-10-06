Imports Whizible
Public Class BlockedUser_PendingTimesheet

    Inherits System.Web.UI.Page
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private m_blnUseSQL As Boolean
    Protected strMenu As String
    Protected strEmployeeID As String = ""
    Protected m_strAction As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Call Initialize()
        If Request.QueryString("EmployeeID") IsNot Nothing Then
            strEmployeeID = Request.QueryString("EmployeeID")
        End If
        If Request.QueryString("Action") IsNot Nothing Then
            m_strAction = Request.QueryString("Action")
        End If
    End Sub
    Private Sub Initialize()
        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

    End Sub
    Public Sub PageInit()
        WriteMenu()
        If m_strAction.ToUpper = "SAVE" Then
            SaveData()
            DrawPage()
        Else
            DrawPage()
        End If

    End Sub

    Protected Sub WriteMenu()

        'Procedure Name         : WriteMenu()
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	to plot Menu(Link)
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:	04-SEP-2017
        ' Revisions				:	
        '=====================================================================
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String
        Dim sbSTRHTML As New System.Text.StringBuilder


        Dim m_arrMenu() As String = {"Save"}
        Dim m_arrMenuToolTip() As String = {"Save"}
        Dim m_arrCSFunction() As String = {"Save_OnClick()"}

        arrMenu = m_arrMenu
        arrMenuToolTip = m_arrMenuToolTip
        arrCSFunction = m_arrCSFunction


        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)

        CommonFunction.General.WriteHTML(strMenu)
        CommonFunction.General.WriteHTML("</BR>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "By Pass Pending Timesheet", , , True))

        sbSTRHTML.Append("</BR>")


        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

    End Sub
    Private Sub DrawPage()

        CommonFunction.General.WriteHTML("<DIV ID='PageDiv' Style='OVERFLOW:auto'>")
        PlotGrid()
        CommonFunction.General.WriteHTML("</DIV>")
    End Sub
    Private Sub PlotGrid()
        Dim strSQL As String

        'Dim arrActualCols() As String = {"CurrentDate", "", "", ""}
        Dim arrActualCols() As String = {"PendingDates", "Remark", "Reason", "select"}
        ''Dim arrUserFriendlyCols() As String = {"Timesheet Pending Date", "Remark", "Reason for Bypass", "Select"}
        Dim arrUserFriendlyCols() As String = {"Timesheet Pending Date", "Remark", "Reason for Bypass", "Select"}

        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Dim arrCheckBox() As String = {"", "", "", "chkSelectList"}
        Dim arrCheckBox() As String = {"", "", "", ""}
        Dim arrRowLink() As String = {""}
        Dim arrTDStyle() As String
        arrTDStyle = {"align=center nowrap", "align=center", "align=center", "align=center"} ', "align=center"
        strSQL = "usp_NG2_Get_Employee_PendingTSDates " & strEmployeeID
        ' grid
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            '.DIVHeight = 100
            .DIVID = "divList"
            '.IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .DIVStyle = "overflow:auto; width:100%;"
            .NoOfDataColumns = 1
            .TDStyleArray = arrTDStyle
            '.CheckBoxIDArray = arrCheckBox
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .returnHTML = False
            .SQL = strSQL
            .UseSQL = m_blnUseSQL
            .DrawGrid()
        End With
        m_objGrid = Nothing



    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "REMARK" Then
            Cancel = True
            Args.StringToBeInserted = "<TD>" & CommonFunctions.HTMLControls.DrawTextArea("txtRemark" & Args.DataReader("ID"), "txtRemark" & Args.DataReader("ID"), , , , "frmBlockedUser", , , 150, 100, , , , , , , , , , True, True, , , , , , , EnableHTMLEncode:=True) & "</TD>"

        End If
        If Args.DataField.ToUpper = "REASON" Then
            Cancel = True
            Args.StringToBeInserted = "<TD>" & CommonFunctions.HTMLControls.DrawComboBox("cboReasons" & Args.DataReader("ID"), "usp_sel_tbl_CNF_NG2_predefinedValues ", 100, , "", True, True, True, True, , , ) & "</TD>"      '"onchange=Project_OnChange(cboProjectName)" ::m_ProjectID.ToString
        End If
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<TD>" & CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect" & Args.DataReader("ID"), , , Args.DataReader("ID"), False, , True) & "</TD>"
        End If
        If Args.DataField.ToUpper = "PENDINGDATES" Then
            Cancel = True
            Args.StringToBeInserted = "<TD>" & Args.DataReader("PendingDates") & CommonFunctions.HTMLControls.DrawTextBox("txthiddenDate" & Args.DataReader("ID"), "txthiddenDate" & Args.DataReader("ID"), , 150, 255, Args.DataReader("PendingDates"), , , , , , True, , True, , , , , 1, EnableHTMLEncode:=True) & "</TD>"      '"onchange=Project_OnChange(cboProjectName)" ::m_ProjectID.ToString
        End If
    End Sub
    Protected Sub SaveData()

        'Procedure Name         : SaveData()
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	To save data
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:	04-SEP-2017
        ' Revisions				:	
        '=====================================================================
        Dim strChekSelect As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelect"), "")
        Dim intRowCount As Integer = 0
        Dim strDate As String
        Dim strRemark As String
        Dim strReason As String
        Dim strSQLQuery As New StringBuilder("")
        If strChekSelect <> "" Then
            Dim strArray() As String = strChekSelect.Split(",")
            For intRowCount = 0 To strArray.Length - 1
                strDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txthiddenDate" & strArray(intRowCount)), "")
                strRemark = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtRemark" & strArray(intRowCount)), "")
                strReason = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboReasons" & strArray(intRowCount)), "")
                strSQLQuery = New StringBuilder()
                strSQLQuery.Append("Exec usp_ins_tbl_CNF_NG2_AllowByPasses " & strEmployeeID)

                strSQLQuery.Append(",'" & strRemark & "'")
                strSQLQuery.Append(",'" & strDate & "'")
                strSQLQuery.Append(",'" & strReason & "'")

                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, True)


            Next
        End If
    End Sub
End Class