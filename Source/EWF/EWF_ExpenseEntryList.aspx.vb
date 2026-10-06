'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleE
' Module Name           :  EWF_ExpenseEntryList.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
Imports System.Globalization

#End Region

Public Class EWF_ExpenseEntryList
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

#Region "Member Variables"
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 3556

    Protected m_ExpenseEntryID As Long
    Private m_strParamAction As String
    Private m_strProjectID As String
    Protected m_strParamDate As String

    Private m_objDTFI As New DateTimeFormatInfo       'Required to parse the date.

    Private m_strSessionUserID As String        'For storing the User ID from Session
    Private m_strSessionPostID As String        'For storing the Post ID from Session
    Private m_blnUseClientDateForDA As Boolean  'For storing the Client Date from Session

    Private m_dblTotalAmount As Double

    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Private m_strProjectName As String = ""
    Private m_lngProjectID As Long
    'Modified By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197
    Protected m_strPKToken_Expense_EntryList As String
    Protected m_strPKToken_Expense_EntryList_ForADDNEW As String
#End Region

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
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()

        'Store UserID in Local Variable
        m_strSessionUserID = CType(Session("intUserID"), String)
        m_strSessionPostID = CType(Session("intPostID"), String)
        m_blnUseClientDateForDA = CommonFunction.Application.UseClientDateForDA()

        'Modified By ShraddhaM on 20,Sep 2006 For SP7 Issue ID : 6197
        m_strPKToken_Expense_EntryList_ForADDNEW = CommonFunctions.Security.Token.GetToken(CType(Session("intProjectID"), String) + CType(Session("intUserID"), String) + "0" + CType(m_lngTagId, String))
        'Ended By ShraddhaM on 20,Sep 2006 For SP7 Issue ID : 6197
        ' Retrieve the Entry date. If no date is specified, then the Current Date will be set as the Default Date.	
        If Trim(MyBase.GetFormValue("txtDate")) <> "" Then
            m_strParamDate = Trim(FixString(MyBase.GetFormValue("txtDate"), 0, False, False))
        ElseIf Trim(Request.QueryString("txtDate")) <> "" Then
            m_strParamDate = Request.QueryString("txtDate")
        Else
            'Get the client side as default date for daily activity
            'To keep the flag at corporate level to whether to use the client for DA or Not
            If m_blnUseClientDateForDA = True Then
                m_strParamDate = CType(Session("ClientDate"), String)
            Else
                m_strParamDate = Date.Today.ToString("dd-MMM-yyyy")
            End If
        End If

        ' Retrieve the Action to be performed.
        m_strParamAction = Trim(Request.QueryString("Action"))

        If m_strParamAction.ToUpper = "DELETE" Then
            Call DeleteExpenseEntry()
        End If
        Call DrawPage()

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
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        If m_objGlobal.TagID <> 0 Then
            m_lngTagId = m_objGlobal.TagID
        Else
            m_objGlobal.TagID = m_lngTagId
        End If

    End Sub
    Private Sub drawMenu(ByVal Location As String)
        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu

        ' Dim objGate As CommonEngines.HashTables.Gates
        ' objGate = CommonEngines.HashTables.Gates.GetGetsHashTableObject(CommonFunction.Constants.GATE_EXPENSES)
        'If Not objGate Is Nothing Then
        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_EXPENSES"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_EXPENSES"))
        'arrMenuCaptionsList.Add(MyBase.GetResourceString("EXPENSES"))
        'arrMenuToolTipsList.Add(MyBase.GetResourceString("EXPENSES"))
        arrClientSideFunctionList.Add("Expenses_OnClick('" + m_strPKToken_Expense_EntryList_ForADDNEW + "')")
        'End If
        ' objGate = Nothing

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DELETE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DELETE"))
        'arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DELETE"))
        'arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DELETE"))
        arrClientSideFunctionList.Add("Delete_OnClick()")

        'Code Added By SantoshK on 22 May 2006
        'Expenses Entry Tabular View - Bristlecone Customization
        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_WEEKLY_VIEW"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_WEEKLY_VIEW"))
        arrClientSideFunctionList.Add("WeeklyView_OnClick()")
        'Addition ends by SantoshK on 22 may 2006
        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        'arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('3089')")

        If Location.ToUpper = "TOP" Then
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True, PrepareDayNavigation())
        Else
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        End If


        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

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
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Function PrepareDayNavigation() As String
        '=====================================================================
        ' Procedure Name        : PrepareDayNavigation()	
        ' Purpose               : This function is used to Prepare the left hand side 
        '                         of the Menu.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : String as HTML
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================

        Dim strTaskList As String                       'Stores the Title on the Left HandSide from resources
        Dim strHTML As String                           'Stores the whole HTML on the Left Hand Side.
        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strPrevDay As String = ""
        Dim strNextDay As String = ""
        'strTaskList = MyBase.GetResourceString("TASK_LIST")
        'strHTML = strTaskList

        'strPrevDay = DateAdd("d", -1, Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)).ToString("dd-MMM-yyyy")
        'strNextDay = DateAdd("d", 1, Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)).ToString("dd-MMM-yyyy")

        'strHTML = strHTML + Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI).ToString("dddd") + " " + CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , , CommonFunction.Dates.GetDate(Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)), , "frmEWF", , , , , True, , True)
        ''strHTML = strHTML + "<A class='Menu' style='' " & _
        ''                    "HREF='EWF_ExpenseEntryList.aspx?txtDate=" + strPrevDay + "' Title=""" & _
        ''                    MyBase.GetResourceString("PREVIOUS_DAY") & """ >" & _
        ''                    MyBase.GetResourceString("PREVIOUS_DAY") & _
        ''                    "</A> | <A class='Menu' style='' HREF='EWF_ExpenseEntryList.aspx?txtDate=" & _
        ''                    strNextDay + "' Title=""" & MyBase.GetResourceString("NEXT_DAY") & """ >" & _
        ''                    MyBase.GetResourceString("NEXT_DAY") & "</A> |"

        'strHTML = strHTML + "<A class='Menu' style='' " & _
        '                    "HREF='EWF_ExpenseEntryList.aspx?txtDate=" + strPrevDay + "' Title=""" & _
        '                    "Previous Day" & """ >" & _
        '                    "Previous Day" & _
        '                    "</A> | <A class='Menu' style='' HREF='EWF_ExpenseEntryList.aspx?txtDate=" & _
        '                    strNextDay + "' Title=""" & "Next Day" & """ >" & _
        '                    "Next Day" & "</A> |"

        'Return strHTML

        strTaskList = "Expense List:"
        strHTML = strTaskList

        strPrevDay = DateAdd("d", -1, Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)).ToString("dd-MMM-yyyy")
        strNextDay = DateAdd("d", 1, Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)).ToString("dd-MMM-yyyy")
        '***** Code Modified by SandipL on 2 Dec 2005 --To solve page refresh problem due to editable Date Control 
        strHTML = strHTML + Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI).ToString("dddd") + " " + CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , , CommonFunction.Dates.GetDate(Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)), , "frmEWF", , , , , True, , True, , , "onkeypress= change_date(event)")
        '***** End modification by SandipL on 2 Dec 2005
        strHTML = strHTML + "<A class='Menu' style='' " & _
                            "HREF='EWF_ExpenseEntryList.aspx?MasterTagID=3556&txtDate=" + strPrevDay + "' Title=""" & _
                            "Previous Day" & """ >" & _
                            "Previous Day" & _
                            "</A> | <A class='Menu' style='' HREF='EWF_ExpenseEntryList.aspx?MasterTagID=3556&txtDate=" & _
                            strNextDay + "' Title=""" & "Next Day" & """ >" & _
                            "Next Day" & "</A> |"

        Return strHTML
        strHTML = Nothing
    End Function


    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()	
        ' Purpose               : This procedure holds the logic of plotting the 
        '                         which page and when.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : MAy  25, 2004
        ' Revisions             :
        '=====================================================================



        ' Draw Top Menu
        drawMenu("TOP")

        'Main Div
        If CommonFunction.General.IsClientBrowserIE Then
            'Commented and added by Yogesh J on 09-OCT-2015
            'CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='width:100%; Height:475px; overflow: auto;'>")
            'CommonFunctions.General.WriteHTML("<br><DIV id=DivTaksList style='width: 100%; Height: 425px; overflow: auto; '>")
            CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='width:100%;  overflow: auto;'>")
            CommonFunctions.General.WriteHTML("<br><DIV id=DivTaksList style='width: 100%;  overflow: auto; '>")
            'End of addition by Yogesh J on 09-OCT-2015
        Else
            'Commented and added by Yogesh J on 09-OCT-2015
            'CommonFunctions.General.WriteHTML("<DIV id=""DivMain"" style=""height:475px; overflow: auto;"">")
            'CommonFunctions.General.WriteHTML("<br><DIV id=DivTaksList style='margin-left: 1px; height: 3750px; overflow: auto; '>")
            CommonFunctions.General.WriteHTML("<DIV id=""DivMain"" style="" overflow: auto;"">")
            CommonFunctions.General.WriteHTML("<br><DIV id=DivTaksList style='margin-left: 1px; overflow: auto; '>")
            'End of addition by Yogesh J on 09-OCT-2015
        End If
        DrawGrid()

        'Display Total Duration (Actual Hours) and closes Div 
        CommonFunctions.General.WriteHTML("</div>")
        '& _
        '                                          "</br></br><Table class=clsTable width='100%' cellpadding=0 cellspacing=0><TR class='clsTREven'><TD>" & MyBase.GetResourceString("MARKED_RED") & "</TD><td widht=50%></td>" & _
        '                                          "<td align=right><B>" & "Total Amount" & " " & CStr(m_dblTotalAmount) & "</B></TD></TR></Table><BR>")
        '"<td align=right><B>" & MyBase.GetResourceString("TOTAL_ACTUAL_WORK") & " " & CStr(m_dblTotalAmount) & "</B></TD></TR></Table><BR>")
        CommonFunctions.General.WriteHTML("</Div>")

        ' Comments 
        CommonFunction.General.WriteHTML("<Table Class='clsTable'  cellspacing=0 cellpadding=0 width=99.9%>")
        CommonFunction.General.WriteHTML("<TR class= 'clsTREven' width=100%> <TD align='left' > <I>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("EXPENSELIST_COMMENTS"))
        CommonFunction.General.WriteHTML("</I> </TD></TR> </Table>  ")

        If Not CommonFunction.General.IsClientBrowserIE Then
            CommonFunctions.General.WriteHTML("</td></tr></table>")
        End If

        ' Draw Bottom  Menu
        drawMenu("BOTTOM")

    End Sub

    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : This procedure actually plots the grid on the Page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        Dim drExpenseEntryList As IDataReader
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim strSQL As String
        'To store the link details while clicking on Links in grid
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "chkDelete"}
        Dim arrGrouping() As String = {"1"}
        Dim arrWidthArray() As String = {"", "style='width:5%'", "style='width:18%'", "style='width:4%' align='right'", "style='width:18%' align=right", "style='width:50%'", "style='width:5%' align=center"}
        Dim arrColRowLinks() As String = {"", "", "Edit_OnClick(ExpensesEntryID)", "", "", "", ""}
        strSQL = "Exec usp_sel_tbl_PM_Expenses " & m_strSessionUserID & ",'" & m_strParamDate & "'"
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Plots the Table for Daily Activity .
        '-------------------------------------------------------------------

        'Header 
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_PROJECT_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_EXPENSE_ENTRYID"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_COST_HEAD"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_CURRENCYSYMBOL"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_AMOUNT"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_DESCRIPTION"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_DELETE"))

        ' Actual Column 

        arrActualColumnNames.Add("ProjectName")
        arrActualColumnNames.Add("ExpensesEntryID")
        arrActualColumnNames.Add("CostHead")
        arrActualColumnNames.Add("CurrencySymbol")
        arrActualColumnNames.Add("Amount")
        arrActualColumnNames.Add("Description")
        arrActualColumnNames.Add("Delete")

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .GroupOnColumn = arrGrouping
            .NoOfDataColumns = 6
            .TDStyleArray = arrWidthArray
            .CheckBoxIDArray = arrCheckBox
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .RowLinkArray = arrColRowLinks
            .SQL = strSQL
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .PrimaryKey = "ExpensesEntryID"
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()

        End With
        m_objGrid = Nothing

        '-------------------------------------------------------------------

    End Sub

    Private Sub DeleteExpenseEntry()
        '=====================================================================
        ' Procedure Name        : DeleteExpenseEntry()	
        ' Purpose               : This procedure holds the logic to Delete the Expense Entry
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : May 25, 2005 
        ' Revisions             :
        '=====================================================================

        Dim arrChkDelete() As String
        Dim strExpenseEntryIDsToDelete As String
        Dim objExpenseEntryDR As IDataReader
        Dim strSQL As String

        'Construct the query to delete the selected records from tbl_PM_DailyActivity table.
        If CType(MyBase.GetFormValue("chkDelete"), String) <> "" Then

            arrChkDelete = Split(CType(FixString(MyBase.GetFormValue("chkDelete"), 0, False, True), String), ",")
            For Each strExpenseEntryIDsToDelete In arrChkDelete
                strSQL = "usp_Del_tbl_PM_Expenses " & strExpenseEntryIDsToDelete
                objExpenseEntryDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objExpenseEntryDR.Read Then
                    If CType(CommonFunction.Data.CheckIsDBNull(objExpenseEntryDR(1), "0"), Boolean) = False Then
                        CommonFunction.General.WriteHTML("<script language=Javascript>")
                        CommonFunction.General.WriteHTML("alert('Expense Entry " + CType(CommonFunction.Data.CheckIsDBNull(objExpenseEntryDR(0), "0"), String) + " cannot be deleted');")
                        CommonFunction.General.WriteHTML("</script>")
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(objExpenseEntryDR)
                'Added By Santosh Pawar on 20th June 2005 
                'TODO : Send mail to Finance if the status of the Expense Sheet has got changed to Approver 
                '       because of the Rejected Entry Deletion
                'End of Addition 
            Next
        End If


    End Sub


    Private Function DisplayProjectwiseTotals() As String

        Dim intCount As Integer
        Dim strToBeInserted As String = ""
        Dim strToBeReturned As String = ""
        Dim intColspan As Integer = 0
        Dim strSQL As String
        Dim strHTML As String = ""
        Dim objDR As IDataReader

        strSQL = "usp_sel_AmountSum_PerCurrency_forProject " + m_lngProjectID.ToString + " , " + m_strSessionUserID + " ,'" + m_strParamDate + "'"

        objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        While objDR.Read()
            strHTML += CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("CurrencySymbol"), ""), "") + " "
            strHTML += CommonFunction.General.CheckIsNothing(FormatNumber(CommonFunction.Data.CheckIsDBNull(objDR("Amount"), ""), 2), "") + " , "
        End While

        If strHTML <> "" Then
            strHTML = strHTML.Substring(0, strHTML.Length - 2)
        End If

        CommonFunction.Data.DisposeDataReader(objDR)

        strToBeReturned &= "<tr class='clsTRColumnHeader' id=ProjectTotal Name= ProjectTotal ><td nowrap align=left width='100%' colspan=7 >"

        strToBeReturned &= "Total Amount: " + strHTML
        strToBeReturned &= "</td></tr>"

        Return strToBeReturned

    End Function

#End Region

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.EWF_ExpenseEntryList", "AppResources")
    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        If (m_strProjectName <> CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectName").ToString.Trim, ""), String)) And (m_strProjectName <> "") Then
            Args.StringToBeInserted = DisplayProjectwiseTotals()
        End If

    End Sub
    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint

        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
        End If

        If Args.DataField.ToUpper = "CURRENCYSYMBOL" Then
            Args.ColumnName = ""
        End If

        If Args.DataField.ToUpper = "EXPENSESENTRYID" Then
            Cancel = True
        End If

    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'Modified By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197
        'Dim m_strToken As String
        'ExpensesEntryID
        If Args.ColumnName.ToUpper = "COST HEAD" Then
            Cancel = True
            'Ended By Tejal D on 16-Aug-2016 For Pk Token
            'm_strPKToken_Expense_EntryList = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpensesEntryID"), String) + CType(Session("intUserID"), String) + "0" + CType(m_lngTagId, String))
            m_strPKToken_Expense_EntryList = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpensesEntryID"), String) + CType(Session("intUserID"), String) + "0" + CType(m_lngTagId, String))
            'Ended By Tejal D on 16-Aug-2016  For Pk Token
            Args.StringToBeInserted = "<TD vAlign=top Title='Task Name' style='width=225' nowrap;>" _
                                             & "<A href=""JavaScript:Edit_OnClick('" & CType(Args.DataReader("ExpensesEntryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_strPKToken_Expense_EntryList) & "')"">"
            Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Args.DataReader("CostHead").ToString) & "</A></TD>"

            Args.ApplyHTMLEncode = False
        End If
        'Ended By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197
        If Args.ColumnName.ToUpper = "DELETE" Then
            Dim IsUsed As Boolean
            IsUsed = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsUsed"), "0"), "0"), Boolean)

            If IsUsed = True Then
                ' code is commented by harshada d for whizible sem 6 for issue id 2318 expense workflow on 14 april 2006
                ' Args.IsCheckBoxChecked = True
                'end of code commentation by harshada d for whizible sem 6 for issue id 2318 expense workflow on 14 april 2006
                Args.IsCheckBoxDisabled = True

            End If
        End If

        If Args.DataField.ToUpper <> "PROJECTNAME" Then
            m_strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ProjectName"), ""), String)
            m_lngProjectID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ProjectID"), ""), Long)
        End If

        If Args.DataField.ToUpper = "EXPENSESENTRYID" Then
            Cancel = True
        End If

    End Sub

    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint

        Args.StringToBeInserted = DisplayProjectwiseTotals()
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub

    Private Sub m_objGrid_NoDataCommentTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_NoDataCommentTR) Handles m_objGrid.NoDataCommentTR_BeforePrint
        Args.StringToBeInserted = "<SCRIPT>"
        Args.StringToBeInserted += " var objForm = GetFormReference('frmEWF');"
        Args.StringToBeInserted += " var ObjTRProjectTotal = document.getElementById(""ProjectTotal"");"
        Args.StringToBeInserted += " ObjTRProjectTotal.style.display='none';"
        Args.StringToBeInserted += "</SCRIPT>"
    End Sub

    ''Added by Dhanashri S on 1 Apr 2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateExpensesToken(txtDate As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(txtDate, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of addition by Dhanashri S on 1 Apr 2016
End Class

