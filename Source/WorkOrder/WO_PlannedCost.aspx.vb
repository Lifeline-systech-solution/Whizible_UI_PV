Public Class WO_PlannedCost
    Inherits WebPages.Template.WhizTemplate

    Private m_intProjectID As Integer
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private m_intEdit As Integer

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
        'Put user code to initialize the page here
    End Sub
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_PlannedCost", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#Region " Generic Functions "
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
        ' Author                : PareshB   
        ' Created               : Aug 02, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
#End Region
    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Paresh B
        ' Created               : Aug 02, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim strPageAlphabets As String

        m_objMenu = New WebPages.Template.StaticMenu

        'Use Resources Solution
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")


        If m_intEdit = 1 Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
            arrClientSideFunctionList.Add("Save_OnClick()")
        End If

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
        arrClientSideFunctionList.Add("Back_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("ShowHelp()")

        'Plot the menu
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
        MyBase.InitializeResources("AppResources.PM_PlannedCost", "AppResources")

        'strPageAlphabets = ""
    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PareshB
        ' Created               : Aug 2, 2004
        ' Revisions             :
        '=====================================================================
        Dim intTagID As Integer
        Dim strSQL As String
        Dim strMode As String
        Dim i As Integer

        'Fields to hold the values in the database
        Dim strUpdateID As String
        Dim strUpdateCostToCompany As String
        Dim strUpdateReimbursable As String
        Dim strUpdateCosts As String
        Dim strInsertID As String
        Dim strInsertCostToCompany As String
        Dim strInsertReimbursable As String
        Dim strInsertCosts As String
        Dim drProjectValue As IDataReader
        Dim strProjectValue As String

        'Arrays to hold the values in the array from REQUEST
        Dim arrCostToCompany As String()
        Dim arrID As String()
        Dim arrCostID As String()
        Dim arrReimbursable As String()

        strMode = Request.QueryString("Mode")

        Dim drAccess As IDataReader

        MyBase.InitializeResources("AppResources.PM_PlannedCost", "AppResources")
        m_intProjectID = CType(Session("intProjectID"), Integer)

        'Save the record
        If strMode = "UPDATE" Then
            'Get the request in array
            arrCostToCompany = Request.Form("txtCostToCompany").Split(","c)
            arrID = Request.Form("txtID").Split(","c)
            arrCostID = Request.Form("txtCostID").Split(","c)
            arrReimbursable = Request.Form("txtReimbursable").Split(","c)

            For i = 0 To arrCostToCompany.Length - 1
                If arrID(i) <> "" Then
                    strUpdateID = arrCostID(i)
                    If arrCostToCompany(i) = "" Then
                        strUpdateCostToCompany = "0"
                    Else
                        strUpdateCostToCompany = arrCostToCompany(i)
                    End If

                    If arrReimbursable(i) = "" Then
                        strUpdateReimbursable = "0"
                    Else
                        strUpdateReimbursable = arrReimbursable(i)
                    End If

                    strUpdateCosts = strUpdateCosts & strUpdateID & "," & strUpdateCostToCompany & "," & strUpdateReimbursable & ","
                Else
                    If arrCostToCompany(i) <> "" Or arrReimbursable(i) <> "" Then
                        strInsertID = arrCostID(i)
                        If arrCostToCompany(i) = "" Then
                            strInsertCostToCompany = "0"
                        Else
                            strInsertCostToCompany = arrCostToCompany(i)
                        End If
                        If arrReimbursable(i) = "" Then
                            strInsertReimbursable = "0"
                        Else
                            strInsertReimbursable = arrReimbursable(i)
                        End If
                        strInsertCosts = strInsertCosts & strInsertID & "," & strInsertCostToCompany & "," & strInsertReimbursable & ","
                    End If
                End If
            Next

            If strInsertCosts <> "" Then strInsertCosts = Left(strInsertCosts, Len(strInsertCosts) - 1)
            If strUpdateCosts <> "" Then strUpdateCosts = Left(strUpdateCosts, Len(strUpdateCosts) - 1)

            strSQL = "Exec usp_Upd_tbl_PM_WorkOrderCosts '" & strUpdateCosts & "','" & strInsertCosts & "'," & m_intProjectID & ",'" & CType(HttpContext.Current.Session("strUserName"), String) & "'"

            'Executes the query 
            i = CommonFunction.Data.InsertOrUpdateData(strSQL, True)

            strMode = ""
        End If

        'GETS THE ACCESS FOR THE USER	
        intTagID = 27
        If Not m_intProjectID = 0 Then
            strSQL = "Exec usp_Sel_tbl_UI_NodeAccess " & intTagID & "," & CType(Session("intPostID"), Integer) & "," & CType(Session("intUserID"), Integer) & ",'" & CType(Session("LoginType"), String) & "'," & m_intProjectID
        Else
            strSQL = "Exec usp_Sel_tbl_UI_NodeAccess " & intTagID & "," & CType(Session("intPostID"), Integer) & "," & CType(Session("intUserID"), Integer) & ",'" & CType(Session("LoginType"), String) & "'"
        End If

        drAccess = CommonFunctions.Data.GetDataReader(strSQL, True)

        m_intEdit = 0

        'Setting the access variables 
        If drAccess.Read = True Then
            If CType(drAccess.Item("A"), Boolean) = True And CType(drAccess.Item("D"), Boolean) = True And CType(drAccess.Item("E"), Boolean) = True Then
                m_intEdit = 1
            Else
                m_intEdit = 0
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drAccess)
        'Draw the Menu
        DrawMenu()

        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_TITLE"))

        CommonFunctions.General.WriteHTML("<div id='divList' style='OVERFLOW: auto; WIDTH: 100%'>")
        ''Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'strSQL = "Select ContractValue From tbl_PM_Project Where ProjectID = " & HttpContext.Current.Session("intProjectID").ToString
        strSQL = "usp_sel_tbl_PM_Project_ContractValue " & HttpContext.Current.Session("intProjectID").ToString
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        drProjectValue = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drProjectValue.Read = True Then
            strProjectValue = CommonFunction.Data.CheckIsDBNull(drProjectValue.Item(0), "").ToString
        End If

        CommonFunction.Data.DisposeDataReader(drProjectValue)
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtProjectLCV", "txtProjectLCV", , , , strProjectValue, , , , , , True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("<br>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("    <table border='0' cellSpacing='0' class='clsTable' width='99.9%' align=center>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("    <tr><td class='clsTDEvenLabelLeft'>")
        CommonFunctions.General.WriteHTML("    * * Please enter the cost that will be incurred during execution of the project under following cost groups/cost heads. * *")
        CommonFunctions.General.WriteHTML("    </td></tr></table>")
        CommonFunctions.General.WriteHTML("<br>")

        CommonFunctions.General.WriteHTML("<BR>")
        DrawGrid()

        CommonFunctions.General.WriteHTML("</Div>")
        DrawMenu()

    End Sub
    Public Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()	
        ' Purpose               : Plots the grid displaying information of employee
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PareshB
        ' Created               : Aug 02,20004
        ' Revisions             :
        '=====================================================================

        '--- Variables related to DOH Details
        Dim drDOH As IDataReader
        Dim strCostGroup As String
        Dim strCostHead As String
        Dim strCostToCompany As String
        Dim strReimbersable As String
        Dim strWorkOrderCostID As String
        Dim strCostHeadID As String
        Dim strWorkingOffice As String

        Dim strDisplayCostToCompany As String
        Dim strDisplayReimbersable As String

        Dim intRow As Integer
        Dim strClass As String

        Dim dblTotCostToCompany As Double
        Dim dblTotReimbursable As Double

        Dim intCost As Integer
        Dim strCurrCostGroup As String

        Dim strSQLQuery As String
        Dim i As Integer

        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrGroupColumnNames As New ArrayList        'To store grouping column names

        arrColumnHeadingList.Add("Item")
        arrColumnHeadingList.Add("Cost to Company")
        arrColumnHeadingList.Add("Reimbursable")

        arrGroupColumnNames.Add("CostGroup")

        arrActualColumnNames.Add("CostHead")
        arrActualColumnNames.Add("CostToCompany")
        arrActualColumnNames.Add("Reimbersable")


        'Grid For Employee Details
        strSQLQuery = "EXEC usp_Sel_GetWorkOrderCosts " & m_intProjectID

        drDOH = CommonFunctions.Data.GetDataReader(strSQLQuery, True)

        'With t
        '    .CellSpacing = 1
        '    .CellPadding = 0
        '    .Border = 0
        '    .Width = "100%"
        'End With

        'r(0) = New PBCommons.Row

        'c(0) = New PBCommons.Col
        'c(1) = New PBCommons.Col
        'c(2) = New PBCommons.Col

        'For i = 0 To 2
        '    With c(i)
        '        .cls = "clsTDHeader"
        '        .AdditionalAttributes = " height='22' "
        '        Select Case i
        '            Case 0
        '                .Width = "60%"
        '                .Contents = "Item"
        '            Case 1
        '                .Width = "20%"
        '                .Contents = "Cost to Company"
        '            Case 2
        '                .Width = "20%"
        '                .Contents = "Reimbursable"
        '        End Select

        '        .Width = "60%"

        '    End With

        '    r(0).Columns = c

        '    arrCols(0) = c


        'Next
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<table CellSpacing='1' cellPadding='0' border='0' width='99.9%' class='clsTable'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<tr class='clsTRColumnHeader'>")
        CommonFunctions.General.WriteHTML("<td align='center' height='22' width='60%'>Item</td>")
        CommonFunctions.General.WriteHTML("<td align='center' height='22' width='20%'>Cost to Company</td>")
        CommonFunctions.General.WriteHTML("<td align='center' height='22' width='20%'>Reimbursable</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        intRow = 0
        strCurrCostGroup = ""

        Do While drDOH.Read = True

            strCostGroup = CType(CommonFunctions.Data.CheckIsDBNull(drDOH.Item("CostGroup"), ""), String)
            strCostHead = CType(CommonFunctions.Data.CheckIsDBNull(drDOH.Item("CostHead"), ""), String)
            strCostToCompany = CType(CommonFunctions.Data.CheckIsDBNull(drDOH.Item("CostToCompany"), ""), String)
            If strCostToCompany <> "" Then
                strDisplayCostToCompany = Format(CType(strCostToCompany, Double), "0.00")
            Else
                strDisplayCostToCompany = ""
            End If
            strReimbersable = CType(CommonFunctions.Data.CheckIsDBNull(drDOH.Item("Reimbersable"), ""), String)
            If strReimbersable <> "" Then
                strDisplayReimbersable = Format(CType(strReimbersable, Double), "0.00")
            Else
                strDisplayReimbersable = ""
            End If
            strWorkOrderCostID = CType(CommonFunctions.Data.CheckIsDBNull(drDOH.Item("WorkOrderCostID"), ""), String)
            strCostHeadID = CType(CommonFunctions.Data.CheckIsDBNull(drDOH.Item("CostHeadId"), ""), String)


            If strCurrCostGroup <> strCostGroup Then
                CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader' ><td colspan='3'>" & strCostGroup & "</td></tr>")
                strCurrCostGroup = strCostGroup
            End If

            intRow = intRow + 1
            If intRow Mod 2 = 0 Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If

            CommonFunctions.General.WriteHTML("<tr class=" & strClass & "><td>" & strCostHead & "</td>")
            CommonFunctions.General.WriteHTML("<td align='middle'>")
            CommonFunctions.General.WriteHTML("<input class='clsTextBox' name='txtCostToCompany' style='WIDTH: 60px; HEIGHT: 16px; text-align: right' size='8' value='" & strDisplayCostToCompany & "' onkeypress='OnlyNumeric(1)' onBlur='javascript:CalculateCostToCompany()'>")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td align='middle'>")
            CommonFunctions.General.WriteHTML("<input class='clsTextBox' name='txtReimbursable' align='right' style='WIDTH: 60px; HEIGHT: 16px;  text-align: right' size='8' value='" & strDisplayReimbersable & "' onkeypress='OnlyNumeric(1)' onBlur='javascript:CalculateReimersable()'>")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td style='display:none'><input name='txtID' type='hidden' value='" & strWorkOrderCostID & "'></td>")
            CommonFunctions.General.WriteHTML("<td style='display:none'><input name='txtCostID' type='hidden' value='" & strCostHeadID & "'></td>")
            CommonFunctions.General.WriteHTML("</tr>")

            If strCostGroup <> "" Then
                dblTotCostToCompany = dblTotCostToCompany + CType(IIf(strCostToCompany = "", "0", strCostToCompany), Double)
            End If

            If strReimbersable <> "" Then
                dblTotReimbursable = dblTotReimbursable + CType(IIf(strReimbersable = "", "0", strReimbersable), Double)
            End If
        Loop
        CommonFunction.Data.DisposeDataReader(drDOH)
        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'>")
        CommonFunctions.General.WriteHTML("<td class='clsTRSectionHeader'>Totals</td>")
        CommonFunctions.General.WriteHTML("<td class='clsTRSectionHeader' align='middle'>")
        CommonFunctions.General.WriteHTML("    <input class='clsTextBox' name='txtTotalCostToCompany' style='BACKGROUND-COLOR=#d3d3d3; WIDTH: 60px; HEIGHT: 16px; text-align: right' readonly size='8' value='" & Format(dblTotCostToCompany, "0.00") & "'>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td class='clsTRSectionHeader' align='middle'>")
        CommonFunctions.General.WriteHTML("   <input class='clsTextBox' name='txtTotalReimbursable' style='BACKGROUND-COLOR=#d3d3d3; WIDTH: 60px; HEIGHT: 16px; text-align: right' readonly size='8' value='" & Format(dblTotReimbursable, "0.00") & "'>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td><input class='clsTextBox' id='txtHidden' name='txtHidden' style='WIDTH: 247px; HEIGHT: 16px' size='41' value type='hidden'> ")
        'CommonFunctions.General.WriteHTML("</td></tr>")
        CommonFunctions.General.WriteHTML("</table>")

        'With m_objGrid
        '.SQL = strSQLQuery
        '.ActualColumnArray = GetArray(arrActualColumnNames)
        '.UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
        '.GroupOnColumn = GetArray(arrGroupColumnNames)
        '.NoOfDataColumns = 3
        '.UseSQL = True
        '.DrawGrid()
        'End With


    End Sub

End Class
