Imports Whizible
Public Class RoleAndEmployeeList
    Inherits WebPages.Template.WhizTemplate
   
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
       
    End Sub

#End Region

    Protected Shared Heading_ToolSkill As String = ""
    Protected m_strNatureOfDemandStageID As String = ""
    Protected m_strPageNumber As String = ""
    Protected strMenu As String
    Protected m_strAction As String
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private Shared WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private Shared WithEvents m_objGridEmp As New WebPages.Template.GenericGrid
    Protected FlagCheck As String
    Protected checkedValues As String
    Protected Shared m_strSelectedRole As String = ""
    Protected Shared m_strSelectedEmployee As String = ""
    Protected m_SBHTML As StringBuilder
    Protected m_strMode As String
    Protected m_strOUID As String
    Protected m_strDepartmentID As String
    Protected str_FromWhere As String = ""

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        ' DrawRoleAndEmployeeGrid("Role")
        FlagCheck = Request.QueryString("flag")
        checkedValues = Request.QueryString("strIds")


        If Request.QueryString("FromWhere") IsNot Nothing Then
            str_FromWhere = Request.QueryString("FromWhere")
        End If
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString
        Else
            m_strMode = ""
        End If
        If Not Request.QueryString("OUID") Is Nothing Then
            m_strOUID = Request.QueryString("OUID").ToString
        Else
            m_strOUID = ""
        End If
        If Not Request.QueryString("Department") Is Nothing Then
            m_strDepartmentID = Request.QueryString("Department").ToString
        Else
            m_strDepartmentID = ""
        End If
        If m_strAction.ToUpper = "SAVE" Then
            If str_FromWhere.ToUpper = "BYPASS" Then

                If FlagCheck = "Role" Then
                    Dim StrSql As String = "usp_Ins_tbl_CNF_NG2_IsBypassExculdedRole '" & checkedValues & "','" & HttpContext.Current.Session("strUserName") & "'"
                    CommonFunctions.Data.InsertOrUpdateData(StrSql, True)

                Else
                    Dim StrSql As String = "usp_Ins_tbl_CNF_NG2_IsBypassExculdedEmployee '" & checkedValues & "','" & HttpContext.Current.Session("strUserName") & "'"
                    CommonFunctions.Data.InsertOrUpdateData(StrSql, True)
                End If

            Else

                If FlagCheck = "Role" Then
                    Dim StrSql As String = "usp_Ins_tbl_CNF_NG2_IsExculdedRole '" & checkedValues & "','" & HttpContext.Current.Session("strUserName") & "'"
                    CommonFunctions.Data.InsertOrUpdateData(StrSql, True)

                Else
                    Dim StrSql As String = "usp_Ins_tbl_CNF_NG2_IsExculdedEmployee '" & checkedValues & "','" & HttpContext.Current.Session("strUserName") & "'"
                    CommonFunctions.Data.InsertOrUpdateData(StrSql, True)
                End If
            End If

        End If


    End Sub

    Public Sub PageInit()
        WriteMenu()
        If str_FromWhere.ToUpper = "BYPASS" Then

            If Request.QueryString("flag") = "Role" Then
                CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Role Configuration for Timesheet Exclusion", , , True))
                CommonFunctions.General.WriteHTML("</BR>")
                DrawByPassRoleGrid("Role")
            Else
                CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Resource Configuration for Timesheet Exclusion", , , True))
                CommonFunctions.General.WriteHTML("</BR>")
                DrawFilters("Emp")
                CommonFunctions.General.WriteHTML("</BR>")
                DrawBypassEmployeeGrid("Emp")
            End If

        Else

            If Request.QueryString("flag") = "Role" Then
                CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Role Configuration for Timesheet Exclusion", , , True))
                CommonFunctions.General.WriteHTML("</BR>")
                DrawRolGrid("Role")
            Else
                CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Resource Configuration for Timesheet Exclusion", , , True))
                CommonFunctions.General.WriteHTML("</BR>")
                DrawFilters("Emp")
                CommonFunctions.General.WriteHTML("</BR>")
                DrawEmployeeGrid("Emp")
            End If
        End If
    End Sub


    Protected Sub WriteMenu()
        '=====================================================================
        ' Procedure  Name		:	WriteMenu
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	plot links
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	tejal D
        ' Created				:  6/12/2016
        '=====================================================================
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String
        Dim sbSTRHTML As New System.Text.StringBuilder


        Dim m_arrMenu() As String = {"Save", "Select All", "Clear All", "Close"}
        Dim m_arrMenuToolTip() As String = {"Save", "Select All", "Clear All", "Close"}
        Dim m_arrCSFunction() As String = {"Save_OnClick();", "SelectAll_OnClick()", "ClearAll_OnClick()", "Close_onclick();"}

        arrMenu = m_arrMenu
        arrMenuToolTip = m_arrMenuToolTip
        arrCSFunction = m_arrCSFunction


        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)

        CommonFunction.General.WriteHTML(strMenu)

        sbSTRHTML.Append("</BR>")
        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

    End Sub
    Protected Sub DrawFilters(ByVal strFlag As String)
        CommonFunction.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding='1' style='width:99.99%' >")


        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        'BusinessGroup Filter
        'CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        'CommonFunction.General.WriteHTML("Business Group :")
        'CommonFunction.General.WriteHTML("</td>")
        'CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        'CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_Sel_tbl_CNF_BusinessGroup 1", 200, , "onchange = javascript:Filter_Onclick()", True, True))
        'CommonFunction.General.WriteHTML("</td>")

        'Location Filter
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Organization Unit :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_NextG2_sel_tbl_PM_Location ", 200, m_strOUID, "onchange = javascript:Filter_Onclick()", True, True))
        CommonFunction.General.WriteHTML("</td>")

        'Role Filter
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Department :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_NextG2_sel_tbl_PM_DepartmentMaster ", 200, m_strDepartmentID, "onchange = javascript:Filter_Onclick()", True, True))
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("</tr>")

        CommonFunction.General.WriteHTML("</table>")
    End Sub
    Private Function DrawRolGrid(ByVal StrFlag As String) As String
        '=====================================================================
        ' Procedure  Name		:	DrawRolGrid
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Grid plot (All corporate Role)
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	tejal D
        ' Created				:  6/12/2016

        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrWidthArray() As String = {"align=left", "align=center width=10%"}
        Dim arrCheckBoxIDs() As String = {"", "chkSelect"}
        Dim arrSelectedCheckBoxIDs() As String = {"", ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        txtSQLQuery.Append("EXEC usp_Sel_NG2_ExcludeRoleAndEmployee '" & StrFlag & "'")

        strSQLQuery = txtSQLQuery.ToString
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add("Role Description")
        arrColumnHeadingList.Add("Select")

        arrActualColumnNames.Add("RoleDescription")
        arrActualColumnNames.Add("")
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            ' .RowLinkArray = arrColRowLinks
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs

            .NoOfDataColumns = 1
            '.GroupOnColumn = arrGroupOn
            .PrimaryKey = "RoleID"
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 450
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True

            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            .DrawGrid()
        End With


        ' Clear Memory
        m_objGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing



    End Function

    Private Function DrawEmployeeGrid(ByVal StrFlag As String) As String
        '=====================================================================
        ' Procedure  Name		:	DrawEmployeeGrid 
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None 
        ' Dependencies			:	None
        ' Author				:	tejal D
        ' Created				:   5/12/2016
        '=====================================================================
        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrWidthArray() As String = {"align=left", "align=center width=10%"}
        Dim arrCheckBoxIDs() As String = {"", "chkSelect"}
        Dim arrSelectedCheckBoxIDs() As String = {"", ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        If m_strOUID = "" Then
            m_strOUID = "NULL"
        End If
        If m_strDepartmentID = "" Then
            m_strDepartmentID = "NULL"
        End If
        txtSQLQuery.Append("EXEC usp_Sel_NG2_ExcludeRoleAndEmployee '" & StrFlag & "'," & m_strOUID & "," & m_strDepartmentID & "")

        strSQLQuery = txtSQLQuery.ToString
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add("Employee Name")
        arrColumnHeadingList.Add("Select")

        arrActualColumnNames.Add("EmployeeName")
        arrActualColumnNames.Add("")

        m_objGridEmp = New WebPages.Template.GenericGrid

        With m_objGridEmp
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            ' .RowLinkArray = arrColRowLinks
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs

            .NoOfDataColumns = 1
            '.GroupOnColumn = arrGroupOn
            .PrimaryKey = "EmployeeID"
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 450
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True

            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            .DrawGrid()
        End With
        '**


        ' Clear Memory
        m_objGridEmp = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing

    End Function

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : tejal D
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Shared Sub m_objRoleGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure  Name		:	m_objRoleGrid_DataRowTD_BeforePrint 
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Before Print Event
        ' Description			:	
        ' Assumptions			:	None 
        ' Dependencies			:	None
        ' Author				:	tejal D
        ' Created				:   5/12/2016
        '=====================================================================
        If Args.ColumnName.ToUpper = "SELECT" Then
            Dim RoleID As String

            RoleID = Args.DataReader("RoleID").ToString()
            Cancel = True
            m_strSelectedRole = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExculdedRoleID"), "")

            If m_strSelectedRole <> "" Then
                Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , , RoleID, , "checked", True) + "</td>"
            Else
                Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , , RoleID, , , True) + "</td>"

            End If
        End If

    End Sub
    Private Shared Sub m_objEmployee_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridEmp.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure  Name		:	m_objEmployee_DataRowTD_BeforePrint 
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Before Print Event
        ' Description			:	
        ' Assumptions			:	None 
        ' Dependencies			:	None
        ' Author				:	tejal D
        ' Created				:   5/12/2016
        '=====================================================================
        If Args.ColumnName.ToUpper = "SELECT" Then
            Dim EmployeeID As String

            EmployeeID = Args.DataReader("EmployeeID").ToString()
            Cancel = True

            m_strSelectedRole = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExculdedEmpID"), "")

            If m_strSelectedRole <> "" Then

                Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , , EmployeeID, , "checked", True) + "</td>"
            Else
                Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , , EmployeeID, , , True) + "</td>"
            End If
        End If
    End Sub
  
    Private Function DrawByPassRoleGrid(ByVal StrFlag As String) As String
        '=====================================================================
        ' Procedure  Name		:	DrawByPassRoleGrid
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Grid plot (All corporate Role)
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:  01-SEP-2017

        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrWidthArray() As String = {"align=left", "align=center width=10%"}
        Dim arrCheckBoxIDs() As String = {"", "chkSelect"}
        Dim arrSelectedCheckBoxIDs() As String = {"", ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        txtSQLQuery.Append("EXEC usp_Sel_tbl_CNF_NG2_IsBypassExculdedRole '" & StrFlag & "'")

        strSQLQuery = txtSQLQuery.ToString
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add("Role Description")
        arrColumnHeadingList.Add("Select")

        arrActualColumnNames.Add("RoleDescription")
        arrActualColumnNames.Add("")
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            ' .RowLinkArray = arrColRowLinks
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs

            .NoOfDataColumns = 1
            '.GroupOnColumn = arrGroupOn
            .PrimaryKey = "RoleID"
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 450
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True

            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            .DrawGrid()
        End With


        ' Clear Memory
        m_objGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing



    End Function

    Private Function DrawBypassEmployeeGrid(ByVal StrFlag As String) As String
        '=====================================================================
        ' Procedure  Name		:	DrawBypassEmployeeGrid 
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None 
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:  01-SEP-2017
        '=====================================================================
        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrWidthArray() As String = {"align=left", "align=center width=10%"}
        Dim arrCheckBoxIDs() As String = {"", "chkSelect"}
        Dim arrSelectedCheckBoxIDs() As String = {"", ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        If m_strOUID = "" Then
            m_strOUID = "NULL"
        End If
        If m_strDepartmentID = "" Then
            m_strDepartmentID = "NULL"
        End If
        txtSQLQuery.Append("EXEC usp_Sel_tbl_CNF_NG2_IsBypassExculdedRole '" & StrFlag & "'," & m_strOUID & "," & m_strDepartmentID & "")

        strSQLQuery = txtSQLQuery.ToString
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add("Employee Name")
        arrColumnHeadingList.Add("Select")

        arrActualColumnNames.Add("EmployeeName")
        arrActualColumnNames.Add("")

        m_objGridEmp = New WebPages.Template.GenericGrid

        With m_objGridEmp
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            ' .RowLinkArray = arrColRowLinks
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs

            .NoOfDataColumns = 1
            '.GroupOnColumn = arrGroupOn
            .PrimaryKey = "EmployeeID"
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 450
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True

            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            .DrawGrid()
        End With
        '**


        ' Clear Memory
        m_objGridEmp = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing

    End Function
End Class

