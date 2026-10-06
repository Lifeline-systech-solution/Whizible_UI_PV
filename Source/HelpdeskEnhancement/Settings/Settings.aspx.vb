Public Class Settings
    Inherits System.Web.UI.Page

#Region "Member Declaration"
    Private WithEvents m_objTypeGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objSubTypeGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objStatusGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objPriorityGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objSeverityGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objDepartmentGrid As New WebPages.Template.GenericGrid

    Private WithEvents objGrid As WebPages.Template.GenericGrid



    Protected arrIgnoreHTMLEncode() As String = {"0"}
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

#Region "Request Tab Section Related Code"

    Protected Function WriteRequestTabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String) As String
        Dim strGridHTML As New StringBuilder("")

        strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid))
     

        If (strGridFlag = "") Then
            CommonFunctions.General.WriteHTML(strGridHTML.ToString)
        Else
            Return strGridHTML.ToString
        End If
    End Function    

    Private Function WriteHelpdeskMasterGrid(ByVal strWhichGrid As String) As String
        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""

        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String

        If strWhichGrid.ToUpper = "TYPE" Then
            intNoOfDataColumn = 6
            strDivID = "divRequestType"
            strSQLQuery = "Usp_Sel_NG2_RequestType"
            arrstrActualList = {"RequestTypeCode", "RequestType", "SubRequestType", "GroupEmail", "ApprovedRequired", "NewValue"}
            arrstrUserFriendlyList = {"Request Type Code", "Request Type", "SubRequest Type", "Group Email", "Approved Required", "New Value"}
            arrstrLinkArray = {"", "", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objTypeGrid
        ElseIf strWhichGrid.ToUpper = "SUBTYPE" Then
            intNoOfDataColumn = 5
            strDivID = "divSubRequestType"
            strSQLQuery = "Usp_Sel_NG2_SubRequestType"

            arrstrActualList = {"SubRequestTypeCode", "SubRequestType", "TaskType", "ConfigureStatusFlow", "Select"}
            arrstrUserFriendlyList = {"SubRequestType Code", "SubRequestType", "Task Type", "Configure Status Flow", "Select"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objSubTypeGrid
        ElseIf strWhichGrid.ToUpper = "PRIORITY" Then
            intNoOfDataColumn = 4
            strDivID = "divPriority"
            strSQLQuery = "Usp_NG2_Sel_tbl_CRM_Priority"

            arrstrActualList = {"PriorityCode", "Priority", "OrderNumber", "Select"}
            arrstrUserFriendlyList = {"Priority Code", "Priority", "Order Number", "Select"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objPriorityGrid
        ElseIf strWhichGrid.ToUpper = "SEVERITY" Then
            intNoOfDataColumn = 3
            strDivID = "divSeverity"
            strSQLQuery = "Usp_NG2_Sel_v_tbl_CRM_Severity"

            arrstrActualList = {"SeverityCode", "Severity", "Select"}
            arrstrUserFriendlyList = {"Severity Code", "Severity", "Select"}
            arrstrLinkArray = {"", "", ""}
            arrCheckBoxArray = {"", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left"}

            objGrid = m_objSeverityGrid
        ElseIf strWhichGrid.ToUpper = "STATUS" Then
            intNoOfDataColumn = 5
            strDivID = "divStatus"
            strSQLQuery = "Usp_NG2_Sel_v_tbl_CRM_Status"

            arrstrActualList = {"StatusCode", "Status", "StatusOfStatus", "OrderNumber", "Select"}
            arrstrUserFriendlyList = {"Request Status Code", "Request Status", "System Status", "Order Number", "Select"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objStatusGrid
        ElseIf strWhichGrid.ToUpper = "DEPARTMENT" Then
            intNoOfDataColumn = 4
            strDivID = "divDepartment"
            strSQLQuery = "Usp_NG2_Sel_v_tbl_PM_DepartmentMaster"

            arrstrActualList = {"DepartmentCode", "Department", "ExposeToCustomer", "Select"}
            arrstrUserFriendlyList = {"Short Name", "Department", "Expose To Customer", "Select"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objDepartmentGrid
        End If

        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            ' .CheckBoxIDArray = arrCheckBoxArray
            .NoOfDataColumns = intNoOfDataColumn
            .RowLinkArray = arrstrLinkArray
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = strDivID
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            '.ClientSideSortFunctionName = "Sort_OnClickwe_For_CRM"
            '.SortBy = strSortBy
            '.SortOrder = strSortOrder
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With

        'intRecordCount = m_objGridAttachment.NoOfRows

        objGrid = Nothing

        Return strGridHTML.ToString
    End Function
   
    Private Sub m_objTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objTypeGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "APPROVEDREQUIRED" Then
            Cancel = True

            Args.StringToBeInserted = "<td><input type=checkbox name='chkApprovedRequired' title='Approved Required' /></td>"
        End If

        If Args.DataField.ToUpper = "NEWVALUE" Then
            Cancel = True

            Args.StringToBeInserted = "<td><input type=checkbox name='chkNewValue' title='New Value' /></td>"
        End If
    End Sub

    Private Sub m_objSubTypeGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objSubTypeGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input type=checkbox name='chkSubTypeSelect' title='select' /></th>"
        End If
    End Sub
    Private Sub m_objSubTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSubTypeGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<td><input type=checkbox name='chkSubTypeSelect' title='select' /></td>"
        End If
    End Sub

    Private Sub m_objStatusGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objStatusGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input type=checkbox name='chkSubTypeSelect' title='select' /></th>"
        End If
    End Sub
    Private Sub m_objStatusGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objStatusGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<td><input type=checkbox name='chkStatusSelect' title='select' /></td>"
        End If
    End Sub

    Private Sub m_objPriorityGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objPriorityGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input type=checkbox name='chkSubTypeSelect' title='select' /></th>"
        End If
    End Sub
    Private Sub m_objPriorityGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objPriorityGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<td><input type=checkbox name='chkPrioritySelect' title='select' /></td>"
        End If
    End Sub

    Private Sub m_objSeverityGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objSeverityGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input type=checkbox name='chkSubTypeSelect' title='select' /></th>"
        End If
    End Sub
    Private Sub m_objSeverityGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSeverityGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<td><input type=checkbox name='chkSeveritySelect' title='select' /></td>"
        End If
    End Sub

    Private Sub m_objDepartmentGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objDepartmentGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input type=checkbox name='chkSubTypeSelect' title='select' /></th>"
        End If
    End Sub
    Private Sub m_objDepartmentGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objDepartmentGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<td><input type=checkbox name='chkDepartmentSelect' title='select' /></td>"
        End If
    End Sub

#End Region

#Region "Jquery AJAX Methods"
    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshGrid(ByVal GridParameter As Object) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Description           : For Refreshing The grid0
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Try

            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New Settings()

            strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh"))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
#End Region
End Class