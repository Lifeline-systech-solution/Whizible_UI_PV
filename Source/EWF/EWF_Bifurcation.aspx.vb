'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleE
' Module Name           :  EWF_Bifurcation.aspx
' Purpose               :  To Plot the Filter Screen For Bifurcating the Expenes Entries 
'                          into Billable And Non Billable 
' Description           :  
' Dependencies          :  None
' Author                :  NitinVS
' Reviewed              :  
' Tested                :  
' Created               :  15 Jun 2005 
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class EWF_Bifurcation
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
    Protected m_lngTagId As Long = 0

    ' Used to Store the values selected by the User 
    Protected m_StrExpenseEntryList As String
    Protected m_lngMode As Long
    Protected m_strAction As String

    Protected m_strFromDate As String = ""
    Protected m_strToDate As String = ""
    Protected m_strFilterValue As String = ""
    Protected m_strWindowTitle As String
    Protected m_blnCustomer As Boolean
    Protected m_blnProject As Boolean
    Protected m_strCustomerID As String = ""
    Protected m_strProjectID As String = ""
    Protected m_strFilterType As String = ""

    Protected m_sessionUserID As String
    Protected m_strPKToken_Bifurcation As String

    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Protected WithEvents frmEWF_Bifurcation As System.Web.UI.HtmlControls.HtmlForm
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    'Protected m_strPKToken_Bifurcation As String
#End Region

#Region "Constants"

    Protected Enum Mode
        FILTER
        ADD
        EDIT
    End Enum

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
        ' Author                :   NitinVS
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()

        'Modified By ShraddhaM on 21,Sep 2006 For SP7 Issue ID : 6197
        m_lngTagId = CType(Trim(Request.QueryString("MasterTagID")), Long)
        Dim m_lngExpensesEntryID As Long
        Dim projectID As String
        'm_strPKToken_Expense_Bbifurcation

        If m_lngMode = 0 Then


            projectID = CType(Session("intProjectID"), String)

            m_strPKToken_Bifurcation = CType(Trim(Request.QueryString("PkToken")), String)
            If IsNothing(projectID) Then m_lngExpensesEntryID = 0

            If CType(m_strPKToken_Bifurcation, String) <> "0" Then
                'If Request.QueryString("PkToken") Is Nothing Then
                '    m_strPKToken_Bifurcation = Request.Form("txtPkToken").ToString
                'Else
                    m_strPKToken_Bifurcation = Request.QueryString("PkToken").ToString
                'End If
            End If

            'm_lngTagId = CType(Trim(Request.QueryString("MasterTagID")), Long)

            If ((m_strPKToken_Bifurcation = "") And (projectID <> "0")) Or _
                ((projectID <> "0") And _
                (CommonFunctions.Security.Token.ValidateToken(projectID + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String), m_strPKToken_Bifurcation) = False)) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Expense Bifurcation", 0, m_lngTagId, "Expense ID", CType(m_lngExpensesEntryID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If


        End If
        If m_lngMode = 2 Then

            m_lngExpensesEntryID = CType(Trim(Request.QueryString("ExpensesEntryID")), Long)
            m_strPKToken_Bifurcation = CType(Trim(Request.QueryString("PkToken")), String)
            If IsNothing(m_lngExpensesEntryID) Then m_lngExpensesEntryID = 0

            If CType(m_strPKToken_Bifurcation, String) <> "0" Then
                If Request.QueryString("PkToken") Is Nothing Then
                    m_strPKToken_Bifurcation = Request.Form("txtPkToken").ToString
                Else
                    m_strPKToken_Bifurcation = Request.QueryString("PkToken").ToString
                End If
            End If

            'm_lngTagId = CType(Trim(Request.QueryString("MasterTagID")), Long)

            If ((m_strPKToken_Bifurcation = "") And (m_lngExpensesEntryID <> 0)) Or _
                ((m_lngExpensesEntryID <> 0) And _
                (CommonFunctions.Security.Token.ValidateToken(CType(m_lngExpensesEntryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String), m_strPKToken_Bifurcation) = False)) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Expense Bifurcation", 0, m_lngTagId, "Expense ID", CType(m_lngExpensesEntryID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        'Ended By ShraddhaM on 21,Sep 2006 For SP7 Issue ID : 6197


        If m_strAction = "BIFURCATE" Then
            Call HandelModesAndActions()
        End If

        Call DrawMenu()

        ' Page Div 
        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' name='PageDiv' style='Overflow:auto;width:100%;Height:450;'>")

        Select Case m_lngMode

            Case Mode.FILTER
                Call DrawFilterScreen()
            Case Else
                'Call DrawHeader()
                Call DrawBifurcationScreen()
        End Select


        CommonFunction.General.WriteHTML("</DIV>")

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
        ' Author                :  NitinVS
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

    Private Sub GetQueryString()
        '====================================================================
        ' Procedure Name        :  GetQueryString
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get the Query String Parameters and form values 
        ' Description           :  This sub-routine will store the Query String Parameters and Session Variables
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS
        ' Created               :  15 Jun 2005 
        ' Revisions             :  
        '=====================================================================
        m_lngMode = CType(HttpContext.Current.Request.QueryString("MODE"), Long)

        If m_lngMode = Mode.FILTER Then
            m_strWindowTitle = MyBase.GetResourceString("TITLE_FILTER")
        Else
            m_strWindowTitle = MyBase.GetResourceString("TITLE_BIFURCATE")
        End If

        m_strFilterType = CommonFunction.General.CheckIsNothing(MyBase.Request.QueryString("FILTERTYPE"), "")

        If m_strFilterType = "" Or m_strFilterType = "C" Then
            m_blnCustomer = True
            m_strFilterType = "C"
            m_strFilterValue = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("cboFilter"), "")

            m_strCustomerID = m_strFilterValue
        Else
            m_blnProject = True
            m_strFilterType = "P"

            m_strFilterValue = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("cboFilter"), "")

            m_strProjectID = m_strFilterValue
        End If

        m_strFromDate = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtFromDate"), "")

        m_strToDate = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtToDate"), "")

        m_strAction = HttpContext.Current.Request.QueryString("ACTION") + ""

        m_sessionUserID = CType(MyBase.Session("intUserID"), String)

        If m_lngMode = Mode.EDIT Then
            'm_StrExpenseEntryList = CommonFunction.General.CheckIsNothing(MyBase.Session("ExpenseEntryList"), "")
            m_StrExpenseEntryList = HttpContext.Current.Request.QueryString("ExpensesEntryID")
        End If
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        :  DrawMenu()
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw the Menu base upon the mode 
        ' Description           :  This sub-routine will Plot the menu based on the Parameter
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS
        ' Created               :  15 Jun 2005 
        ' Revisions             :  
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu

        ' Draw Menu for Filter Page
        If m_lngMode = Mode.FILTER Then

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOW_DETAILS"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOW_DETAILS"))
            arrClientSideFunctionList.Add("ShowDetails_OnClick()")

            'added by harshada d for whiziblesem 6 expenses issue id : 2886 on 8 April 2006
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            'end of addition by harshada d for whiziblesem 6 expenses issue id : 2886 on 8 April 2006

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
            arrClientSideFunctionList.Add("Help_OnClick('3598')")

            'added by harshada d for whiziblesem 6 expenses issue id : 2886 on 8 April 2006
            MyBase.InitializeResources("AppResources.EWF_Bifurcation", "AppResources")
            'end of addition by harshada d for whiziblesem 6 expenses issue id : 2886 on 8 April 2006

        End If

        ' Draw Menu for Add Bifurcation Entries and Edit Bifurcation Entries 

        If m_lngMode = Mode.ADD Or m_lngMode = Mode.EDIT Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BIFURCATE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BIFURCATE"))
            arrClientSideFunctionList.Add("Bifurcate_OnClick()")
        End If

        If m_lngMode = Mode.ADD Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))
            arrClientSideFunctionList.Add("SelectAll_OnClick('frmEWF_Bifurcation','chkDelete')")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL"))
            arrClientSideFunctionList.Add("ClearAll_OnClick('frmEWF_Bifurcation','chkDelete')")

        End If
        If m_lngMode = Mode.ADD Or m_lngMode = Mode.EDIT Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK"))
            arrClientSideFunctionList.Add("Back_OnClick()")
        End If

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

    Private Sub HandelModesAndActions()
        '====================================================================
        ' Procedure Name        :  HandelModesAndActions()
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To save the Details of Bifurcation when mode is Bifurcate 
        ' Description           :  As Above
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS
        ' Created               :  16 Jun 2005 
        ' Revisions             :  
        '=====================================================================

        Dim strExpenseEntryIDList As String
        Dim strArrExpenseEntryID As String()
        Dim strExpenseEntryID As String

        Dim strSQL As String
        Dim strBifurcationComments As String
        Dim strBillableAmount As String
        Dim strNonBillableAmount As String
        Dim strAmount As String
        Dim strComments As String

        strExpenseEntryIDList = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("chkDelete"), "")

        If m_lngMode = Mode.EDIT Then
            strExpenseEntryIDList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("ExpensesEntryID"), "")
        End If

        If strExpenseEntryIDList <> "" Then
            strArrExpenseEntryID = strExpenseEntryIDList.Split(","c)
            Dim intCount As Integer = strArrExpenseEntryID.Length()
            For Each strExpenseEntryID In strArrExpenseEntryID
                intCount = intCount - 1
                strComments = Request.Form("txtComments" + strExpenseEntryID) + ""
                If strComments = "" Then strComments = " "

                strBillableAmount = MyBase.GetFormValue("txtBillable" + strExpenseEntryID) + ""
                strNonBillableAmount = MyBase.GetFormValue("txtNonBillable" + strExpenseEntryID) + ""
                strAmount = MyBase.GetFormValue("txtAmount" + strExpenseEntryID) + ""

                If m_lngMode = Mode.ADD Then
                    strSQL = "usp_ins_tbl_PM_ExpensesBifurcation "
                    strSQL += strExpenseEntryID
                    strSQL += " , '" + strAmount + "' "
                    strSQL += ", '" + strBillableAmount + "' "
                    strSQL += ", '" + strNonBillableAmount + "'"
                    strSQL += ", '" + CommonFunction.General.BuildQueryString(strComments) + "'"
                    strSQL += ", " + m_sessionUserID
                    CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    'Commented by SandipL on 14 April 2006 For whizsemsp6 IssueID 3349
                    'Response.Write("<SCRIPT>")
                    'modified by harshada d for expense workflow for whiziblesem 6 on 4 April 2006
                    'Response.Write(" window.open(""../General/CommonList.aspx?FromWhere=DT&MasterTagId=3108"",""_self"");")
                    'Response.Write(" window.open(""../EWF/ExpenseBifurcation_CommonList.aspx?FromWhere=DT&MasterTagId=3598"",""_self"");")
                    'end of modification by harshada d for expense workflow for whiziblesem 6 on 4 April 2006
                    'Response.Write("</SCRIPT>")
                    'End Commenting by SandipL

                End If

                If m_lngMode = Mode.EDIT Then
                    strSQL = "update tbl_PM_ExpensesBifurcation SET "
                    strSQL += " Billable = " + strBillableAmount + " , "
                    strSQL += " NonBillable = " + strNonBillableAmount + " , "
                    strSQL += " Remark = '" + CommonFunction.General.BuildQueryString(strComments) + "' "
                    strSQL += " ,ModifiedBy = " + m_sessionUserID
                    strSQL += " , ModifiedDate = '" + Today.Date.ToString + "' "
                    strSQL += " WHERE ExpensesEntryID = " + strExpenseEntryID

                    CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If
            Next
            'Added by SandipL on 14 April 2006 For whizsemsp6 IssueID 3349
            If m_lngMode <> Mode.EDIT Then
                Response.Redirect("ExpenseBifurcation_CommonList.aspx?FromWhere=DT&MasterTagId=3598")
            End If
            'End addition by SandipL on 14 April 2006
        End If





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

    Private Sub DrawFilterScreen()
        '====================================================================
        ' Procedure Name        :  DrawFilterScreen()
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw the Filter Screen for Seleting Filter for Expense Entries to Be Bifurcated 
        ' Description           :  This sub-routine will Plot the menu based on the Parameter
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS
        ' Created               :  15 Jun 2005 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String

        Response.Write("<Table width=99.9% Class='clsTable'  cellspacing=0 cellpadding=0 >")

        ' Draw Customer Option Button 
        Response.Write("<TR Class = 'clsTREven' >")
        Response.Write("<TD align=right>")
        Response.Write(MyBase.GetResourceString("COL_CUSTOMER"))
        Response.Write("</TD>")
        Response.Write("<TD>")
        Response.Write(CommonFunction.HTMLControls.DrawOptionButton("optCustomer", "optCustomer", , m_blnCustomer, "C", , "onClick='ShowFilter(""1"")'", True))
        Response.Write("</TD>")

        'Draw Project Option Button 
        Response.Write("<TD align=right>")
        Response.Write(MyBase.GetResourceString("COL_PROJECT_NAME"))
        Response.Write("</TD>")
        Response.Write("<TD>")
        Response.Write(CommonFunction.HTMLControls.DrawOptionButton("optProject", "optProject", , m_blnProject, "P", , "onClick='ShowFilter(""2"")'", True, False))
        Response.Write("</TD>")
        Response.Write("</TR>")

        ' Draw Combo Box for Either Project Or Customer 
        Response.Write("<TR Class = 'clsTREven' >")
        Response.Write("<TD align=right>")

        If m_blnCustomer = True Then

            strSQL = "SELECT Customer , CustomerName FROM tbl_PM_Customer Order By CustomerName"
            Response.Write(MyBase.GetResourceString("COL_CUSTOMER"))
            Response.Write("</TD>")
            Response.Write("<TD colspan=3 align=left>")
            Response.Write(CommonFunction.HTMLControls.DrawComboBox("cboFilter", strSQL, 300, m_strCustomerID, , True, True))
            Response.Write("</TD>")
            Response.Write("</TR>")

        ElseIf m_blnProject = True Then

            strSQL = "SELECT ProjectID , ProjectName FROM tbl_PM_Project  WHERE GlobalProject<>1 Order By ProjectName"
            Response.Write(MyBase.GetResourceString("COL_PROJECT_NAME"))
            Response.Write("</TD>")
            Response.Write("<TD colspan=3 align=left>")
            Response.Write(CommonFunction.HTMLControls.DrawComboBox("cboFilter", strSQL, 300, m_strProjectID, , True, True))
            Response.Write("</TD>")
            Response.Write("</TR>")

        End If

        ' From Date 
        Response.Write("<TR Class = 'clsTREven' >")
        Response.Write("<TD align=right>")
        Response.Write(MyBase.GetResourceString("COL_STARTDATE"))
        Response.Write("</TD>")
        Response.Write("<TD align=left>")
        Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_strFromDate, , "frmEWF_Bifurcation", , , , , , , True, ))
        Response.Write("</TD>")
        'Modified By ShraddhaM on 22,Sep 2006 For SP7 Issue ID : 6197
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strPKToken_Bifurcation, , , , , , , , , , , , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        'Ended By ShraddhaM on 22,Sep 2006 For SP7 Issue ID : 6197

        ' To Date
        Response.Write("<TD align=right>")
        Response.Write(MyBase.GetResourceString("COL_ENDDATE"))
        Response.Write("</TD>")
        Response.Write("<TD align=left>")
        Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_strToDate, , "frmEWF_Bifurcation", , , , , , , True, ))
        Response.Write("</TD>")

        
      
        Response.Write("</TABLE>")


    End Sub

    Private Sub DrawBifurcationScreen()
        '====================================================================
        ' Procedure Name        :  DrawBifurcationScreen()
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw the Bifurcation Screen 
        ' Description           :  This sub-routine will Plot the Bifurcation Screen 
        ' Assumptions           :  When Mdoe is Add then Show the Grid for All Epxense Entries not yet Bifurcated 
        '                          Else show the Expenes Entries selected by the user 
        ' Dependencies          :  None
        ' Author                :  NitinVS
        ' Created               :  15 Jun 2005 
        ' Revisions             :  
        '=====================================================================
        Dim drDailyActivity As IDataReader
        Dim strSQL As String
        Dim arrColumnHeadingList As New ArrayList 'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'To store the link details while clicking on Links in grid
        'Dim arrCheckBox() As String = {"", "", "", "", "", "", "", "chkApprove", "chkReject", "chkEscalate", "chkDisown", "chkDelete"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "", "chkDelete"}
        Dim arrGrouping() As String = {"1"}
        Dim arrWidthArray() As String = {"style='width:0%'", _
                 "style='width:5%'", _
                 "style='width:15%'", _
                 "style='width:2%'", _
                 "style='width:15%'", _
                 "style='width:15%'", _
                 "style='width:5%'  align=right", _
                 "style='width:10%'  align=right", _
                 "style='width:10%' align='right'", _
                 "style='width:3%'", _
                 "style='width:10%' align='right'", _
                 "style='width:5%' ", _
                "style='width:5%' valign='top' align=left"}

        Dim arrColRowLinks() As String = {"", "", "", "", "", "Edit_OnClick(ExpensesEntryID,EntryDate)"}
        '"ShowDiscussions_OnClick(ExpensesEntryID)"

        'Dim arrIgnoreHTMLEncode() As String = {"", "1", "", "", "", "", "", ""}

        If m_lngMode = 1 Then
            strSQL = " usp_Sel_tbl_PM_Expenses_ForBifurcation "

            strSQL += m_sessionUserID

            If m_strCustomerID <> "" Then
                strSQL += ", " + m_strCustomerID
            Else
                strSQL += " , Null "
            End If


            If m_strProjectID <> "" Then

                strSQL += ", " + m_strProjectID
            Else
                strSQL += ", Null "
            End If

            If m_strFromDate <> "" Then
                strSQL += ", '" + m_strFromDate + "' "
            Else
                strSQL += ", Null "
            End If

            If m_strToDate <> "" Then
                strSQL += ", '" + m_strToDate + "' "
            Else
                strSQL += ", Null "
            End If

        ElseIf m_lngMode = 2 Then


            strSQL = "usp_Sel_tbl_PM_Expenses_ToBifurcateSelectedEntries "

            strSQL += "'" + m_StrExpenseEntryList + "'"

        End If

        'Added By Bharat T on 23rd-Aug-2017 for pagination
        'Commented And Added By Usha Pandit On 11.02.2021 For crash on edit Expense Entry
        'DrawPaging(strSQL)
        'If m_lngMode = 1 Then
        '    DrawPaging(strSQL)
        'End If
        'End of Added By Usha Pandit On 11.02.2021 For crash on edit Expense Entry
        'End of Added By Bharat T on 23rd-Aug-2017 for pagination

        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_PROJECT_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_EXPENSESHEETID"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_TITLE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_EXPENSE_ENTRYID"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_ENTRY_DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_COST_HEAD"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_CURRENCYSYMBOL"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_AMOUNT"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_BILLABLE"))
        '  If m_lngMode <> 2 Then
        arrColumnHeadingList.Add("Move")
        ' End If
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_NON_BILLABLE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_COMMENTS"))
        arrColumnHeadingList.Add("Discussion")
        If m_lngMode <> 2 Then
            arrColumnHeadingList.Add(MyBase.GetResourceString("COL_SELECT"))
        End If


        arrActualColumnNames.Add("ProjectName")
        arrActualColumnNames.Add("ExpenseSheetID")
        arrActualColumnNames.Add("Title")
        arrActualColumnNames.Add("ExpensesEntryID")
        arrActualColumnNames.Add("EntryDate")
        arrActualColumnNames.Add("CostHead")
        arrActualColumnNames.Add("CurrencySymbol")
        arrActualColumnNames.Add("Amount")
        arrActualColumnNames.Add("Billable")
        'If m_lngMode <> 2 Then
        arrActualColumnNames.Add("Move")
        'End If

        arrActualColumnNames.Add("NonBillable")
        arrActualColumnNames.Add("Comments")
        'arrColumnHeadingList.Add("<IMG border=0 src='../../Images/Discussions.gif'>")

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .GroupOnColumn = arrGrouping
            .NoOfDataColumns = 11
            .TDStyleArray = arrWidthArray
            '.IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .CheckBoxIDArray = arrCheckBox
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .EmptyValueReplacement = "-"
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


    End Sub
#End Region

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.EWF_Bifurcation", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        '====================================================================
        ' Procedure Name        :  Page_Load()
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Store the Variables and Query string parameetrs and Window Title 
        ' Description           :  This sub-routine will Plot the menu based on the Parameter
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS
        ' Created               :  15 Jun 2005 
        ' Revisions             :  
        '=====================================================================

        Call GetQueryString()

    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        ' If m_lngMode <> 2 Then

        
        'Args.StringToBeInserted = "<td style='width:10%' valign='top' align=Left>" + CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strPKToken_Bifurcation, , , , , , , , , , , , True, ) + "</TD>"
        'Modified By ShraddhaM on 22,Sep 2006 For SP7 Issue ID : 6197
        If Args.DataField.ToUpper = "BILLABLE" Then
            Dim strBillable As String
            Dim ExpenseEntryID As String

            ExpenseEntryID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpensesEntryID"), ""), String)

            strBillable = FormatNumber(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Billable"), ""), String), 2, , , TriState.False)
            Cancel = True
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted = "<td style='width:10%' valign='top' align=Left>" + CommonFunction.HTMLControls.DrawTextBox("txtBillable" + ExpenseEntryID, "txtBillable" + ExpenseEntryID, , 80, 10, strBillable, "right", , , , , , " height=50 valign='top'", True, EnableHTMLEncode:=True) + "</TD>"
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        End If

        If Args.DataField.ToUpper = "NONBILLABLE" Then
            Dim strNonBillable As String
            Dim ExpenseEntryID As String
            Dim strAmount As String

            ExpenseEntryID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpensesEntryID"), ""), String)
            strAmount = FormatNumber(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Amount"), ""), String), 2, , , TriState.False)
            strNonBillable = FormatNumber(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("NonBillable"), ""), String), 2, , , TriState.False)

            Cancel = True
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted = "<td style='width:10%' valign='top' align=Left>" + CommonFunction.HTMLControls.DrawTextBox("txtNonBillable" + ExpenseEntryID, "txtNonBillable" + ExpenseEntryID, , 80, 10, strNonBillable, "right", , , , , , " height=50 valign='top'", True, EnableHTMLEncode:=True)
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtAmount" + ExpenseEntryID, "txtAmount" + ExpenseEntryID, , , 20, strAmount, "right", , , , , , " height=50 valign='top'", True, DisplayNone:=True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted += "</TD>"
        End If

        If Args.DataField.ToUpper = "COMMENTS" Then
            Dim strNonBillable As String
            Dim ExpenseEntryID As String
            Dim strComments As String = ""

            ExpenseEntryID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpensesEntryID"), ""), String)
            strComments = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Comments"), ""), ""), String)
            Cancel = True
            'Code commented and added by PrashantD on 8 March 2007 for IssueID 11090
            'Args.StringToBeInserted = "<td style='width:10%' valign='top' align=Left>" + CommonFunction.HTMLControls.DrawTextArea("txtComments" + ExpenseEntryID, "txtComments" + ExpenseEntryID, "Comments", , , "frmEWF_Bifurcation", , , 100, 20, 500, strComments, , " height=50 valign='top'", , , , , , True) + "</TD>"
            Args.StringToBeInserted = "<td style='width:10%' valign='top' align=Left>"
            Args.StringToBeInserted += "<Textarea wrap='off'  name='txtComments" + ExpenseEntryID + "' id='txtComments" + ExpenseEntryID + "' class='clsTextArea' style=""width:100px  ; height:40px  ; text-align:Left ;  height=50 valign='top'""  >"
            Args.StringToBeInserted += strComments + "</TextArea>"
            Args.StringToBeInserted += "<A Href=""JavaScript:opentextdialog(&quot;frmEWF_Bifurcation&quot;,&quot;txtComments" + ExpenseEntryID + "&quot;,&quot;Comments&quot;,&quot;False&quot;)"" tabindex=""-1""><img Border=0 valign=Top src='../../images/zoomin.gif' alt='Double click the text area to add more text'></img></a></TD>"
            'End of addition by PrashantD on 8 March 2007
        End If

        If Args.DataField.ToUpper = "MOVE" Then
            Dim ExpenseEntryID As String

            ExpenseEntryID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpensesEntryID"), ""), String)
            Cancel = True
            Args.StringToBeInserted = "<td style='width:5%' valign='top' align=Left>"
            Args.StringToBeInserted += "&nbsp;<A Href=""JavaScript: MakeBillable_onClick(" + ExpenseEntryID + ")""><img Border=0 valign=Top align=top src='../../images/left.gif' alt='click to move amount to Billble'></img></a>"
            Args.StringToBeInserted += "&nbsp;<A Href=""JavaScript: MakeNonBillable_onClick(" + ExpenseEntryID + ")""><img Border=0 valign=Top align=top src='../../images/right.gif' alt='click to move amount to Non Billble'></img></a> &nbsp;"
            Args.StringToBeInserted += "</TD>"
        End If
        ' End If
        If Args.ColumnName.ToUpper = "DISCUSSION" Then

            'Modified By ShraddhaM on 22,Sep 2006 For SP7 Issue ID : 6197
            Dim ExpenseEntryID As String

            ExpenseEntryID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpensesEntryID"), ""), String)
            m_strPKToken_Bifurcation = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpensesEntryID"), String) + CType(Session("intUserID"), String) + "0" + CType(m_lngTagId, String))

            Cancel = True
            Args.StringToBeInserted = "<td style='width:5%' valign='top' align=Left> &nbsp;<A Href=""JavaScript: ShowDicussionTherad(" + ExpenseEntryID + ",'" + m_strPKToken_Bifurcation + "')""><IMG border=0 src='../../Images/Discussions.gif' alt='click to view Discussion'> </img></a></TD>"
            'Ended By ShraddhaM on 22,Sep 2006 For SP7 Issue ID : 6197
            Args.ApplyHTMLEncode = False

            
        End If


        If Args.ColumnName.ToUpper = "COST HEAD" Then

            'Modified By ShraddhaM on 21,Sep 2006 For SP7 Issue ID : 6197
            Cancel = True
            Dim ExpenseEntryID As String
            Dim EntryDate As String
            Dim costHead As String

            ExpenseEntryID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpensesEntryID"), ""), String)
            EntryDate = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EntryDate"), ""), String)
            costHead = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("costHead"), ""), String)

            m_strPKToken_Bifurcation = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpensesEntryID"), String) + CType(Session("intUserID"), String) + "0" + CType(m_lngTagId, String))

            Args.StringToBeInserted = "<td style='width:5%' valign='top' align=Left> &nbsp;<A Href=""JavaScript: Edit_OnClick(" + ExpenseEntryID + ",'" + EntryDate + "','" + m_strPKToken_Bifurcation & "')"">"

            ' Args.StringToBeInserted = "</A></TD>"
            Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Args.DataReader("CostHead").ToString) & "</A></TD>"

            Args.ApplyHTMLEncode = False
            'Ended By ShraddhaM on 21,Sep 2006 For SP7 Issue ID : 6197

        End If

        If Args.ColumnName.ToUpper = "SELECT" Then
            Args.IsCheckBoxChecked = True
        End If


       


    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint

        If Args.DataField.ToUpper = "PROJECTNAME" Then
            Args.ColumnName = ""
        End If

        If Args.DataField.ToUpper = "MOVE" Then
            Args.ColumnName = ""
        End If

        If Args.DataField.ToUpper = "CURRENCYSYMBOL" Then
            Args.ColumnName = ""
        End If

        If Args.ColumnName.ToUpper = "DISCUSSION" Then

            Args.ColumnName = "<IMG border=0 src='../../Images/Discussions.gif' alt='click to view Discussion'> </img>"
            Args.ApplyHTMLEncode = False

        End If

    End Sub
End Class
