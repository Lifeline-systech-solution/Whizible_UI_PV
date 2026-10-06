'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  PbNITE
' Module Name           :  PM_WorkOrder_PlannedCost.aspx
' Purpose               :  This page is used to maintain planned costs for work order
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  May 10, 2004
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports System.Text
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class PM_WorkOrder_PlannedCost
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

#Region "Variables"
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Private m_intBaselineNo As Integer = 0
    Private m_strBaselineStatus As String
    Protected m_strFromWhere As String
    Private m_drReader As IDataReader
    Private WithEvents m_objStaticMenu As New StaticMenu
    Private WithEvents m_objGrid As New GenericGrid
#End Region

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()        
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.PM_WorkOrder_PlannedCost", "AppResources")
    End Sub

#Region "Functions and Sub-Procedures"

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   PrakashR
        ' Created               :   May 10, 2004
        ' Revisions             :   
        '=====================================================================
        Dim strMode As String = ""

        strMode = Request.QueryString("Mode")
        m_strFromWhere = Request.QueryString("FromWhere")

        ''TODO:Delete the Following lines which were added for testing purposes.
        'm_strFromWhere = "APPDB"
        'm_strBaselineStatus = "S"
        'm_intBaselineNo = 1
        ''End of Test Code

        Call GetGlobalObject()
        Call DrawMenu()
        WriteHTML("<BR>")
        WriteHTML(PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PROJECT_DOH"), , , True))
        WriteHTML("<BR>")
        WriteHTML("<TABLE class=clsTable><TR><TD class=""clsTDEvenLabelLeft""><font size=1><b>" & MyBase.GetResourceString("COMMENT") & "</b></font></TD></TR></TABLE>")


        If strMode = "UPDATE" Then
            Call SaveChanges()
            strMode = ""
        End If

        WriteHTML("<BR>")
        WriteHTML("<div id=""PageDiv"" style=""OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100%"">")
        Call DrawGrid()
        WriteHTML("</DIV>")
        WriteHTML("<BR>")
        Call DrawMenu()
    End Sub

    Private Sub GetGlobalObject()

        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  May 10, 2004
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        :  DrawMenu
        ' Parameters Passed     :  None 
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  Initialization of the menu
        ' Description           :  This function renders the menu
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  May 10, 2004
        ' Revisions             : 
        '=====================================================================
        Dim strMenu As String
        Dim strSQL As String
        Dim drReader As IDataReader
        Dim intEdit As Integer = 0
        Dim blnReadOnly As Boolean = False

        If (m_objGlobal.ProjectID <> 0) Then
            strSQL = "Exec usp_Sel_tbl_UI_NodeAccess " & m_objGlobal.TagID & "," & m_objGlobal.RoleID & "," & m_objGlobal.UserID & ",'" & m_objGlobal.LoginType & "'," & m_objGlobal.ProjectID
        Else
            strSQL = "Exec usp_Sel_tbl_UI_NodeAccess " & m_objGlobal.TagID & "," & m_objGlobal.RoleID & "," & m_objGlobal.UserID & ",'" & m_objGlobal.LoginType & "'"
        End If

        drReader = GetDataReader(strSQL, MyBase.UseSQL)

        'We check the access of the user to see whether the Save Link can be shown to him or not.
        If drReader.Read Then
            If Boolean.Parse(drReader("A").ToString) = True AndAlso Boolean.Parse(drReader("D").ToString) = True _
            AndAlso Boolean.Parse(drReader("E").ToString) = True Then intEdit = 1
        End If
        CommonFunction.Data.DisposeDataReader(drReader)
        'TODO:Delete the following line (intEdit = 1).
        intEdit = 1 'This is for testing

        If m_intBaselineNo > 0 Then
            If m_strFromWhere.ToUpper = "PM" Then blnReadOnly = True
            If m_strFromWhere.ToUpper = "PWDB" AndAlso m_strBaselineStatus = "S" Then blnReadOnly = True
            If m_strFromWhere.ToUpper = "APPDB" AndAlso m_strBaselineStatus = "S" Then blnReadOnly = True
        End If

        'If the user does not have appropriate access, do not render the Save Link.
        If intEdit = 0 OrElse blnReadOnly = True Then
            Dim arrMenu() As String = {MyBase.GetResourceString("BACK"), _
                                       MyBase.GetResourceString("HELP")}
            Dim arrMenuTooltip() As String = {MyBase.GetResourceString("BACK_TOOLTIP"), _
                                              MyBase.GetResourceString("HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"Back_OnClick()", "Help_OnClick()"}
            m_objStaticMenu = New StaticMenu
            strMenu = m_objStaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuTooltip, True)

        Else

            Dim arrMenu() As String = {MyBase.GetResourceString("SAVE"), _
                                       MyBase.GetResourceString("BACK"), _
                                       MyBase.GetResourceString("HELP")}
            Dim arrMenuTooltip() As String = {MyBase.GetResourceString("SAVE_TOOLTIP"), _
                                              MyBase.GetResourceString("BACK_TOOLTIP"), _
                                              MyBase.GetResourceString("HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Back_OnClick()", "Help_OnClick()"}
            m_objStaticMenu = New StaticMenu
            strMenu = m_objStaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuTooltip, True)
        End If

        WriteHTML(strMenu)
    End Sub

    Private Sub SaveChanges()
        '====================================================================
        ' Procedure Name        :  SaveChanges
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To save the contents of the textboxes in the grid 
        '                          to the database
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  May 11, 2004
        ' Revisions             :  
        '=====================================================================
        Dim intIndex As Integer = 0
        Dim strDict As String
        Dim strCostCompany() As String
        Dim strReimbursable() As String
        Dim strWorkOrderCost() As String
        Dim strCostHead() As String

        Dim strUpdateID As String
        Dim strUpdateCostToCompany As String
        Dim strUpdateReimbursable As String
        Dim strUpdateCosts As String
        Dim strInsertID As String
        Dim strInsertCostToCompany As String
        Dim strInsertReimbursable As String
        Dim strInsertCosts As String
        Dim strSQL As String = ""

        'We first collect the values in the text boxes and the hidden controls into arrays
        strCostCompany = Request.Form("txtCostToCompany").Split(Char.Parse(","))
        strReimbursable = Request.Form("txtReimbursable").Split(Char.Parse(","))
        strWorkOrderCost = Request.Form("WorkOrderCost_ID").Split(Char.Parse(","))
        strCostHead = Request.Form("CostHead_ID").Split(Char.Parse(","))

        'Here we form the update and insert strings for passing to the stored procedure as parameters.
        For intIndex = 0 To strCostCompany.Length - 1
            If (strWorkOrderCost.GetValue(intIndex).ToString <> "") Then

                strUpdateID = strCostHead.GetValue(intIndex).ToString

                If strCostCompany Is Nothing Then
                    strUpdateCostToCompany = "0"
                Else
                    strUpdateCostToCompany = strCostCompany.GetValue(intIndex).ToString
                End If

                If strReimbursable Is Nothing Then
                    strUpdateReimbursable = "0"
                Else
                    strUpdateReimbursable = strReimbursable.GetValue(intIndex).ToString
                    If strUpdateReimbursable.Length = 0 Then strUpdateReimbursable = "0"
                End If

                strUpdateCosts = strUpdateCosts & strUpdateID.Trim & "," & strUpdateCostToCompany.Trim & "," & strUpdateReimbursable.Trim & ","

            Else

                If (strCostCompany.GetValue(intIndex).ToString <> "") Or _
                   (strReimbursable.GetValue(intIndex).ToString <> "") Then

                    strInsertID = strCostHead.GetValue(intIndex).ToString

                    If strCostCompany Is Nothing Then
                        strInsertCostToCompany = "0"
                    Else
                        strInsertCostToCompany = strCostCompany.GetValue(intIndex).ToString
                    End If

                    If strReimbursable Is Nothing Then
                        strInsertReimbursable = "0"
                    Else
                        strInsertReimbursable = strReimbursable.GetValue(intIndex).ToString
                        If strInsertReimbursable.Length = 0 Then strInsertReimbursable = "0"
                    End If

                    strInsertCosts = strInsertCosts & strInsertID.Trim & "," & strInsertCostToCompany.Trim & "," & strInsertReimbursable.Trim & ","
                End If
            End If
        Next

        'Remove the extra commas from the end of the strings
        If Not (strUpdateCosts Is Nothing) Then
            strUpdateCosts = strUpdateCosts.Substring(0, strUpdateCosts.Length - 1)
        Else
            strUpdateCosts = ""
        End If
        If Not (strInsertCosts Is Nothing) Then
            strInsertCosts = strInsertCosts.Substring(0, strInsertCosts.Length - 1)
        Else
            strInsertCosts = ""
        End If

        m_drReader = GetDataReader("EXEC usp_Sel_tbl_PM_Project " & m_objGlobal.ProjectID.ToString, MyBase.UseSQL)

        m_drReader.Read()
        If Not IsDBNull(m_drReader("BaselineNumber")) Then m_intBaselineNo = Integer.Parse(m_drReader("BaselineNumber").ToString)
        CommonFunction.Data.DisposeDataReader(m_drReader)
        m_strBaselineStatus = GetDataScalar("EXEC usp_Sel_tbl_PM_ProjectRevision_BaselineStatus " & m_objGlobal.ProjectID.ToString, MyBase.UseSQL).ToString

        ''TODO:Delete the following lines which was added for testing purpose
        'm_intBaselineNo = 1
        'm_strBaselineStatus = "S"
        ''End of test code

        'Before baseline, we save the changes to both; the baseline table and the intermediate table.
        If m_intBaselineNo = 0 Then
            'Save changes to the baseline table.
            strSQL = "Exec usp_Upd_tbl_PM_WorkOrderCosts '" & _
                        strUpdateCosts & "','" & _
                        strInsertCosts & "'," & _
                        m_objGlobal.ProjectID & ",'" & _
                        m_objGlobal.UserName & "'"
            InsertOrUpdateData(strSQL, MyBase.UseSQL)

            'Save changes to the intermediate table.
            strSQL = "Exec usp_Upd_tbl_PM_WorkOrderCosts_Revision '" & _
                        strUpdateCosts & "','" & _
                        strInsertCosts & "'," & _
                        m_objGlobal.ProjectID & ",'" & _
                        m_objGlobal.UserName & "'"
            InsertOrUpdateData(strSQL, MyBase.UseSQL)
        Else
            If m_strFromWhere.ToUpper = "PWDB" AndAlso (m_strBaselineStatus.ToUpper = "C" OrElse m_strBaselineStatus.ToUpper = "B") Then
                'Save changes to the intermediate table.
                strSQL = "Exec usp_Upd_tbl_PM_WorkOrderCosts_Revision '" & _
                            strUpdateCosts & "','" & _
                            strInsertCosts & "'," & _
                            m_objGlobal.ProjectID & ",'" & _
                            m_objGlobal.UserName & "'"
                InsertOrUpdateData(strSQL, MyBase.UseSQL)
            End If
        End If
    End Sub

    Private Sub DrawGrid()
        '====================================================================
        ' Procedure Name        :  DrawGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To render the grid
        ' Description           :  This sub-routine renders the grid to show the task report
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  May 10, 2004
        ' Revisions             :  
        '=====================================================================

        Dim strGridHTML As String
        Dim drTotal As IDataReader
        Dim decCostToCompany As Decimal = 0
        Dim decreimbursable As Decimal = 0

        Dim arrUserFriendlyNames() As String = {"", MyBase.GetResourceString("ITEM"), _
                                                MyBase.GetResourceString("COST_TO_COMPANY"), _
                                                MyBase.GetResourceString("REIMBURSABLE")}
        Dim arrActualNames() As String = {"CostGroup", "CostHead", "CostToCompany", "Reimbersable"}
        Dim arrGroupBy() As String = {"1", "", "", ""}
        Dim arrTDStyle() As String = {"", "width=""50%""", "width=""25%""", "width=""25%"""}

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        With m_objGrid
            .ActualColumnArray = arrActualNames
            .UserFriendlyColumnArray = arrUserFriendlyNames
            .NoOfDataColumns = 4
            .GroupOnColumn = arrGroupBy
            .TDStyleArray = arrTDStyle
            .ColumnHeaderAlignment = "center"

            'We decide where to fetch the Work Order data from depending on the FromWhere querystring parameter
            If m_strFromWhere.ToUpper = "PM" Then
                .SQL = "EXEC usp_Sel_GetWorkOrderCosts " & m_objGlobal.ProjectID
            Else
                .SQL = "EXEC usp_Sel_GetWorkOrderCosts_Revision " & m_objGlobal.ProjectID
            End If

            .DIVHeight = 0
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            .UseSQL = True
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            strGridHTML = .DrawGrid
        End With

        'We get the resultset into a datareader for the purpose of calculating the Company Cost Total 
        ' and reimbursement total.
        drTotal = GetDataReader(m_objGrid.SQL, True)

        m_objGrid = Nothing

        WriteHTML(strGridHTML)

        While drTotal.Read
            decCostToCompany = decCostToCompany + Decimal.Parse(CheckIsDBNull(drTotal("CostToCompany"), "0").ToString)
            decreimbursable = decreimbursable + Decimal.Parse(CheckIsDBNull(drTotal("Reimbersable"), "0").ToString)
        End While
        CommonFunction.Data.DisposeDataReader(drTotal)
        'Here we render two textboxes at the end of the grid which will contain the totals.
        Dim strTotal As New StringBuilder
        strTotal.Append("<TABLE width='99.9%' cellpadding=0 cellspacing=0 class=clsTable><TR class='clsTRSectionHeader'><TD width='50%' title=""Totals"" colspan='2'>")
        strTotal.Append(MyBase.GetResourceString("TOTALS") & "</TD>")
        strTotal.Append("<TD align=center width='25%'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT class=""clsTextBox""  title=""Company Cost Total"" readonly size=""8"" style=""BACKGROUND-COLOR=#d3d3d3; WIDTH: 100px; HEIGHT: 16px; text-align: right"" id=""txtCompanyTotal"" name=""txtCompanyTotal"" value=""" & FormatNumber(decCostToCompany, 4) & """></TD>")
        strTotal.Append("<TD align=center width='25%'>&nbsp;&nbsp;&nbsp;<INPUT class=""clsTextBox"" title=""Reimbursement Total"" readonly size=""8"" style=""BACKGROUND-COLOR=#d3d3d3; WIDTH: 100px; HEIGHT: 16px; text-align: right"" id=""txtReimbursableTotal"" name=""txtReimbursableTotal"" value=""" & FormatNumber(decreimbursable, 4) & """></TD></TR></TABLE>")
        WriteHTML(strTotal.ToString)
        strTotal = Nothing
    End Sub

#End Region

#Region "Events"
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'In this event we write the code to render text boxes in the grid.
        Dim strToBeInserted As String
        Dim strReadOnly As String = ""

        If Args.ColIndex = 2 OrElse Args.ColIndex = 3 Then
            If m_intBaselineNo > 0 Then
                If m_strFromWhere.ToUpper = "PM" Then strReadOnly = "readonly"
                If m_strFromWhere.ToUpper = "PWDB" AndAlso m_strBaselineStatus.ToUpper = "S" Then strReadOnly = "readonly"
                If m_strFromWhere.ToUpper = "APPDB" AndAlso m_strBaselineStatus.ToUpper = "S" Then strReadOnly = "readonly"
            End If
        End If

        If Args.ColIndex = 2 Then
            strToBeInserted = "<INPUT size=""8"" " & strReadOnly & " style=""WIDTH: 100px; HEIGHT: 16px;  text-align: right"" class=""clsTextBox"" class=""clsTextBox"" Maxlength=""10"" align=""right"" id=""txtCostToCompany"" name=""txtCostToCompany"" onkeypress=""OnlyNumeric(1)"" value=""" & Args.DataReader("CostToCompany").ToString.Trim & """>"
            Args.ApplyHTMLEncode = False
            Args.TDStyle = "align='center'"
            Args.DataFieldValue = strToBeInserted
        End If

        If Args.ColIndex = 3 Then
            strToBeInserted = "<INPUT size=""8"" " & strReadOnly & " style=""WIDTH: 100px; HEIGHT: 16px;  text-align: right"" class=""clsTextBox"" Maxlength=""10"" id=""txtReimbursable"" name=""txtReimbursable"" onkeypress=""OnlyNumeric(1)"" value=""" & Args.DataReader("Reimbersable").ToString.Trim & """>"
            strToBeInserted &= "<INPUT type=""Hidden"" id=""WorkOrderCost_ID"" name=""WorkOrderCost_ID"" value=""" & Args.DataReader("WorkOrderCostID").ToString.Trim & """>"
            strToBeInserted &= "<INPUT type=""Hidden"" id=""CostHead_ID"" name=""CostHead_ID"" value=""" & Args.DataReader("CostHeadID").ToString.Trim & """>"
            Args.TDStyle = "align='center'"
            Args.ApplyHTMLEncode = False
            Args.DataFieldValue = strToBeInserted
        End If
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        'We do not render the Cost Group column header.
        If Args.ColIndex = 0 Then
            Cancel = True
            Args.StringToBeInserted = "<TD></TD>"
        End If
    End Sub
#End Region

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

End Class
