Imports Whizible
Partial Public Class MB_SendMailConfiguration
    Inherits WebPages.Template.WhizTemplate

    Protected m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_strSQL As String = ""
    Protected m_strPageNumber As String = ""
    Protected strShowSelected As String = ""
    ' Protected dsMetrics As DataSet
    Protected WithEvents objGrid As New WebPage.Templates.GenericGrid
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting        
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016
    End Sub
    Protected Sub PageInit()
        InitVariables()
        If m_strAction = "SAVE" Then
            PerformAction()
        End If
        DrawMenu()
        DrawPage()
        DrawMenu()
    End Sub
    Protected Sub InitVariables()
        m_strAction = CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), "")
        m_strPageNumber = CommonFunctions.General.CheckIsNothing(Request("PageNumber"))
        m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
        If m_strPageNumber = "" Then
            m_strPageNumber = "-1"
        Else
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_AND, "&")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_HASH, "#")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")
        End If

        strShowSelected = CommonFunctions.General.CheckIsNothing(Request("ShowSelected"), "0")
    End Sub
    Protected Sub DrawMenu()
        Dim arrMenuCaptionsList As New ArrayList
        Dim arrMenuToolTipsList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim strPagingstring As String

        arrMenuCaptionsList.Add("Select")
        arrMenuToolTipsList.Add("Select")
        arrClientSideFunctionList.Add("Select_OnClick()")

        If strShowSelected = "1" Then
            arrMenuCaptionsList.Add("Show All")
            arrMenuToolTipsList.Add("Show All")
            arrClientSideFunctionList.Add("ShowSelected_OnClick(0)")
        Else
            arrMenuCaptionsList.Add("Show Selected")
            arrMenuToolTipsList.Add("Show Selected")
            arrClientSideFunctionList.Add("ShowSelected_OnClick(1)")
        End If

        arrMenuCaptionsList.Add("Close")
        arrMenuToolTipsList.Add("Close")
        arrClientSideFunctionList.Add("Close_OnClick()")

        m_strSQL = "usp_sel_tbl_PM_Employee_MetricsSendMail " + Session("intProjectID").ToString + ",1"
        strPagingstring = WebPages.Template.Paging.DrawPaging(m_strPageNumber, m_strSQL, "Select", , "Alphabet", True)
        If strPagingstring = "" Then m_strPageNumber = "-1"

        m_objMenu = New WebPages.Template.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True, strPagingstring)
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub
    Protected Sub DrawPage()
        Dim dr As IDataReader
        m_strSQL = "usp_sel_tbl_PM_Employee_MetricsSendMail " + Session("intProjectID").ToString + ",0,'" + m_strPageNumber.ToString + "', " + strShowSelected.ToString
        dr = CommonFunction.Data.GetDataReader(m_strSQL, True)
        'dsMetrics = CommonFunction.Data.GetDataSet(m_strSQL, "Metrics", , , True)
        'If intShowSelected = 1 Then
        'dr = dsMetrics.Tables(0).Select("Selected = " + intShowSelected.ToString)
        'Else
        '    dr = dsMetrics.Tables(0)
        'End If

        CommonFunction.General.WriteHTML("<BR><TABLE class='clsTable' width='99.9%'>")
        CommonFunction.General.WriteHTML("<TR class='clsTRSectionHeader'><TD>Send Mail To list</TD></TR>")
        CommonFunction.General.WriteHTML("</TABLE><BR>")
        CommonFunction.General.WriteHTML("<DIV id=divlist style=overflow:auto;width:99.9%;>")

        CommonFunction.General.WriteHTML("<TABLE class='clsGridTable' width='99.9%' cellspacing=1 cellpadding=0>")
        CommonFunction.General.WriteHTML("<TR class='clsTRColumnHeader'><TH>Select</TH><TH align='left'>Employee</TH><TH align='left'>Business Group</TH><TH align='left'>Organization Unit</TH><TH align='left'>Role</TH></TH>")
        While dr.Read()
            CommonFunction.General.WriteHTML("<TR class='clsTREven'><TD align='center'>" + CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("Selected"), ""), ""), CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("EmployeeID"), ""), "").ToString, , "onclick=javascript:chkSelect_Onclick(this)", True) + " </TD>")
            CommonFunction.General.WriteHTML("<TD align='left'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("EmployeeName"), ""), "") + "</TD>")
            CommonFunction.General.WriteHTML("<TD align='left'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("BusinessGroup"), ""), "") + "</TD>")
            CommonFunction.General.WriteHTML("<TD align='left'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("Location"), ""), "") + "</TD>")
            CommonFunction.General.WriteHTML("<TD align='left'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("RoleDescription"), ""), "") + "</TD></TR>")

        End While
        CommonFunction.General.WriteHTML("</TABLE><BR>")

        'Dim arrColumnHeadingList() As String = {"Employee", "Select"}
        'Dim arrActualColumnNames() As String = {"EmployeeName", ""}
        'Dim arrCheckBoxId() As String = {"", "chkSelect"}
        'Dim arrColRowLinks() As String = {"", "onClick=chkSelect_OnClick(this)"}

        ''If dsMetrics.Tables(0).Rows.Count > 0 Then
        'With objGrid
        '    .UserFriendlyColumnArray = arrColumnHeadingList
        '    .ActualColumnArray = arrActualColumnNames
        '    .CheckBoxIDArray = arrCheckBoxId
        '    .RowLinkArray = arrColRowLinks
        '    .NoOfDataColumns = 1
        '    .DIVStyle = "overflow:none"
        '    .ColNameToolTipOnEachRow = True
        '    '.GridDataTable = dsMetrics.Tables(0)
        '    .SQL = m_strSQL.ToString
        '    .UseSQL = MyBase.UseSQL
        '    .PrimaryKey = "EmployeeID"
        '    .DIVHeight = 100
        '    .DrawGrid()
        'End With
        'End If

        'dsMetrics = Nothing
        CommonFunction.Data.DisposeDataReader(dr)
        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.General.WriteHTML("<BR>")
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function

    Protected Sub PerformAction()
        Dim strSelected As String = CommonFunction.General.CheckIsNothing(Request.Form("chkSelect"), "")
        Dim strUnSelected As String = CommonFunction.General.CheckIsNothing(Request("hid_UnSelected"), "")
        CommonFunction.Data.InsertOrUpdateData("usp_UPD_tbl_PM_Employee_MetricsSendMail '" + strSelected.ToString + "'," + Session("intProjectID").ToString + ",'" + strUnSelected.ToString + "'", True) ' 
    End Sub

    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            'Cancel = True
            'Args.StringToBeInserted = "<TD>" + CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , Args.DataReader("Selected"), Args.DataReader("EmployeeID").ToString, , "onclick=javascript:chkSelect_Onclick(this," + Args.DataReader("EmployeeID").ToString + ")", True) + "</TD>"
            If Args.DataReader("Selected") = 1 Then
                Args.IsCheckBoxChecked = 1
            End If
        End If


    End Sub

End Class