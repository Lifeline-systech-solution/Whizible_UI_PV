
'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleE
' Module Name           :  EWF_ExpenseEntry.aspx
' Purpose               :  Entry Page for Expnese Entry 
' Description           :  
' Dependencies          :  None
' Author                :  NitinVS
' Reviewed              :  SantoshP
' Tested                :  
' Created               :  25 May 2005 
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

Public Class EWF_ExpenseEntry
    Inherits WebPages.Template.WhizTemplate
    Private m_blnValidate As Boolean = True
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

    Protected m_ExpenseEntryID As Long
    Protected m_strParamAction As String
    Private m_strProjectID As String = "0"
    Protected m_strParamDate As String
    Protected m_strParamMode As String

    Private m_objDTFI As New DateTimeFormatInfo       'Required to parse the date.

    Private m_strSessionUserID As String        'For storing the User ID from Session
    Private m_strSessionPostID As String        'For storing the Post ID from Session
    Private m_blnUseClientDateForDA As Boolean  'For storing the Client Date from Session
    Private m_strProjectFilters As String = ""
    Protected m_strTodaysDate As String


    'Review Comments : Naming Conventions should be followed Ex. m_variablename  Updated the Variable Names 

    Protected m_lngExpensesEntryID As Long = 0
    Protected m_dtEntryDate As Date = Date.Today
    Private m_lngGroupID As Long = 0
    Private m_lngSubItemID As Long = 0
    Private m_dblAmount As Double = 0
    Private m_lngEmployeeID As Long = 0
    Private m_strDescription As String = ""
    Private m_lngPaymentMode As Long = 0
    Private m_lngCurrencyID As Long = 0
    Private m_lngCountryID As Long = 0
    Private m_lngFPCenterID As Long = 0
    Private m_dtDateofBooking As Date = Date.Today
    Private m_blnIsbillable As Boolean
    Private m_blnUserCanOverRide As Boolean
    Private m_dblAdvance As Double

    Protected m_strReadOnlyMode As String = ""
    Protected m_strFinanceApprover As String = ""
    Protected m_strAdminVerifier As String = ""
    Private m_strRefreshDetailsWindow As String = ""
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu

    Protected m_blnIsSubmitted As Boolean
    'Modified By ShraddhaM on 19,Sep 2006 For SP7 Issue ID : 6197
    Protected m_strPKToken_Expense_Entry As String
#End Region

#Region "Functions and Sub-Procedures"

    Public Sub PageInit()
        'Review Comments : No Code Header 

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
        If CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagID"), "0"), Long) <> 0 Then
            m_lngTagId = CType(Trim(Request.QueryString("MasterTagID")), Long)
        Else
            m_lngTagId = CType(MyBase.GetFormValue("txtTagId"), Long)
        End If

        'm_lngExpensesEntryID = CType(Trim(Request.QueryString("ExpensesEntryID")), Long)
        'If IsNothing(m_lngExpensesEntryID) Then m_lngExpensesEntryID = 0
        'If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
        '    m_blnValidate = False
        'ElseIf m_lngExpensesEntryID <> 0 And Request.QueryString("PKToken") <> "" Then
        '    'If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngExpensesEntryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String) + CType(m_lngTagId, String), m_strPKToken_Expense_Entry) = False) Then
        '    Dim token As String = CommonFunctions.Security.Token.GetToken(CType(m_lngExpensesEntryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String))
        '    If (CommonFunctions.Security.Token.ValidateToken(token, m_strPKToken_Expense_Entry) = False) Then
        '        m_blnValidate = False
        '    End If
        '    'End If
        'End If
        'If (m_blnValidate = False) Then
        '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        'End If

        Dim ProjectID As String
        Call GetGlobalObject()
        'Modified By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197
        m_strParamMode = Trim(Request.QueryString("Mode"))
        'Commnented and Modified  By JyotiG
        'Issue ID : 6655
        'Start
        'Date : 05-Oct-2006
        'm_lngTagId = CType(Trim(Request.QueryString("MasterTagID")), Long)

        'End of modification by JyotiG

        If m_strParamMode.ToUpper = "ADD_NEW" Then

            'ProjectID = Request.QueryString("ProjectID").ToString
            'If Request.QueryString("PkToken") Is Nothing Then
            If Request.QueryString("ProjectID") Is Nothing Then
                ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), 0)
            Else
                ProjectID = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), 0)
            End If
            'm_strPKToken_Expense_Entry = CommonFunctions.Security.Token.GetToken(CType(Session("intProjectID"), String) + CType(Session("intUserID"), String) + "0" + CType(m_lngTagId, String))
            'End If
            m_strPKToken_Expense_Entry = CommonFunctions.Security.Token.GetToken(ProjectID + CType(Session("intUserID"), String) + "0" + CType(m_lngTagId, String))
            '  Dim dropdownCheck As String = CommonFunction.General.CheckIsNothing(Request.QueryString("d"), "0")
            ' If dropdownCheck <> "Dropdown" Then
            ' If (Request.QueryString("PKExpensesToken") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
            '    'm_blnValidate = False
            'ElseIf ProjectID <> "0" And Request.QueryString("PKToken") = "" Then
            '    m_blnValidate = False  '******************
            '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngExpensesEntryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String), m_strPKToken_Expense_Entry) = False) Then
            '        If (m_strPKToken_Expense_Entry <> Request.QueryString("PKExpensesToken").ToString) Then
            '            m_blnValidate = False '************************
            '        ElseIf (Request.QueryString("PKExpensesToken") <> "" And Request.QueryString("txtDate") <> "") Then
            '            m_blnValidate = False
            '            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("txtDate"), String) + "0" + "0", Request.QueryString("PKExpensesToken")) = False) Then
            '            End If
            '            ' End If
            '        End If
            '    Else
            '        m_blnValidate = False
            '    End If
            '    If (m_blnValidate = False) Then
            '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            '    End If
        End If
        '***

        'If ((m_strPKToken_Expense_Entry = "") And (ProjectID <> "0")) Or _
        '    ((ProjectID <> "0") And _
        '    (CommonFunctions.Security.Token.ValidateToken(ProjectID + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String), m_strPKToken_Expense_Entry) = False)) Then
        '    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Expense Entry", m_lngTagId, 0, "Expense ID", CType(m_lngExpensesEntryID, String))
        '    'Token is Invalid now redirect to the Invalid Access Page
        '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        'End If


        ' ''Added by Dhanashri S on 1 April 2016
        'If (Request.QueryString("PKExpensesToken") <> "" And Request.QueryString("txtDate") <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("txtDate"), String) + "0" + "0", Request.QueryString("PKExpensesToken")) = False) Then

        '        'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        ''End of Addition by Dhanashri S on 1 April 2016

        'End If *
        If m_strParamMode.ToUpper = "EDIT" Then
            m_lngExpensesEntryID = CType(Trim(Request.QueryString("ExpensesEntryID")), Long)
            If IsNothing(m_lngExpensesEntryID) Then m_lngExpensesEntryID = 0


            If CType(m_strPKToken_Expense_Entry, String) <> "0" Then
                If Request.QueryString("PkToken") Is Nothing Then
                    'Added  By Sanyogeeta R on 16-Aug-2016
                    If (Request.Form("txtPkToken") <> "") Then
                        m_strPKToken_Expense_Entry = Request.Form("txtPkToken").ToString
                    End If
                    '''End of Addition by Sanyogeeta R on 16-Aug-2016
                Else
                    m_strPKToken_Expense_Entry = Request.QueryString("PkToken").ToString
                End If
            End If


            m_lngTagId = CType(Trim(Request.QueryString("MasterTagID")), Long)
            'Added And Commented By Sanyogeeta R on 16-Aug-2016
            'If ((m_strPKToken_Expense_Entry = "") And (m_lngExpensesEntryID <> 0)) Or _
            '    ((m_lngExpensesEntryID <> 0) And _
            '    (CommonFunctions.Security.Token.ValidateToken(CType(m_lngExpensesEntryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String), m_strPKToken_Expense_Entry) = False)) Then
            '    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Expense Entry", m_lngTagId, 0, "Expense ID", CType(m_lngExpensesEntryID, String))
            '    'Token is Invalid now redirect to the Invalid Access Page
            '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            'End If

            'CommonFunctions.Security.Token.ValidateToken(CType(m_lngExpensesEntryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String) + CType(m_lngTagId, String), m_strPKToken_Expense_Entry) = False)

        End If
        '''End of Comment and Addition by Sanyogeeta R on 16-Aug-2016
        'Ended By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197
        'Review Comments : Following Code block not required  Removed the Code Block

        'Store UserID in Local Variable
        m_strSessionUserID = CType(Session("intUserID"), String)
        m_strSessionPostID = CType(Session("intPostID"), String)
        m_blnUseClientDateForDA = CommonFunction.Application.UseClientDateForDA()

        'Retrieve the Entry date. If no date is specified, then the Current Date will be set as the Default Date.	
        If Trim(MyBase.GetFormValue("txtDate")) <> "" Then
            m_strParamDate = Trim(FixString(MyBase.GetFormValue("txtDate"), 0, False, False))
        ElseIf Trim(Request.QueryString("txtDate")) <> "" Then
            m_strParamDate = Request.QueryString("txtDate")
        Else
            'Get the client side as default date for Expense entry 
            'To keep the flag at corporate level to whether to use the client for DA or Not
            If m_blnUseClientDateForDA = True Then
                m_strParamDate = CType(Session("ClientDate"), String)
            Else
                m_strParamDate = Date.Today.ToString("dd-MMM-yyyy")
            End If
        End If

        ' Todays Date for blocking future Expense Entry 
        If m_blnUseClientDateForDA = True Then
            m_strTodaysDate = CType(Session("ClientDate"), String)
        Else
            m_strTodaysDate = Date.Today.ToString("dd-MMM-yyyy")
        End If

        ' Get the Query String Parameter 
        Call getQueryStringParameters()

        ' Draw the Page
        Call DrawPage()

    End Sub
    Private Sub getQueryStringParameters()
        '=====================================================================
        ' Procedure Name        : getQueryStringParameters()	
        ' Purpose               : This procedure saves the Query String Parameters
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : Jun 1 ,2005
        ' Revisions             :
        '=====================================================================

        m_strParamMode = Trim(Request.QueryString("Mode"))
        If IsNothing(m_strParamMode) Then m_strParamMode = "ADD_NEW"

        m_strParamAction = Trim(Request.QueryString("Action"))
        If IsNothing(m_strParamAction) Then m_strParamAction = ""

        m_strRefreshDetailsWindow = Trim(Request.QueryString("RefreshDetailsWindow"))
        If IsNothing(m_strParamAction) Then m_strParamAction = ""

        m_strReadOnlyMode = Trim(Request.QueryString("State"))

        m_strFinanceApprover = Trim(Request.QueryString("FinanceApprover"))

        m_strAdminVerifier = CommonFunction.General.CheckIsNothing(Request.QueryString("AdminVerifier"))

        If m_strParamMode.ToUpper = "EDIT" Then
            m_lngExpensesEntryID = CType(Trim(Request.QueryString("ExpensesEntryID")), Long)
            If IsNothing(m_lngExpensesEntryID) Then m_lngExpensesEntryID = 0
        End If

    End Sub
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
        ' added by harshada d for whiziblesem 6 issue ID 2318 for expenses workflow to fix the issue  Footer for the list page are not displayed. 
        Dim objHeaderFooter As WebPages.Template.HeaderFooter
        Call GetGlobalObject()
        'end of addition by harshada d for whiziblesem 6 issue ID 2318 for expenses workflow to fix the issue  Footer for the list page are not displayed. 
        ' Draw Top Menu
        ManipulateRecord()
        ' added by harshada d for whiziblesem 6 issue ID 2318 for expenses workflow to fix the issue  Footer for the list page are not displayed . 
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing
        ' end of addition by harshada d for whiziblesem 6 issue ID 2318 for expenses workflow to fix the issue  Footer for the list page are not displayed. 
        drawMenu("TOP")
        DrawPageLegend()
        DrawEntryFormForExpense()
        ' Draw Bottom  Menu
        drawMenu("BOTTOM")

    End Sub
    Private Sub ManipulateRecord()
        '=====================================================================
        ' Procedure Name        : ManipulateRecord()
        ' Purpose               : This procedure holds the logic of saving the expense entry 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : May  25, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String

        If Trim(MyBase.GetFormValue("cboProject")) <> "" Then m_strProjectID = CType(FixString(MyBase.GetFormValue("cboProject"), 0, False, True), String)

        If Trim(MyBase.GetFormValue("cboCostGroup")) <> "" Then m_lngGroupID = CType(FixString(MyBase.GetFormValue("cboCostGroup"), 0, False, True), Long)

        If Trim(MyBase.GetFormValue("cboCostHead")) <> "" Then m_lngSubItemID = CType(FixString(MyBase.GetFormValue("cboCostHead"), 0, False, True), Long)

        If Trim(MyBase.GetFormValue("txtAmount")) <> "" And IsNumeric(MyBase.GetFormValue("txtAmount")) Then m_dblAmount = CType(FixString(MyBase.GetFormValue("txtAmount"), 0, False, True), Double)

        If Trim(MyBase.GetFormValue("txtAdvance")) <> "" And IsNumeric(MyBase.GetFormValue("txtAdvance")) Then m_dblAdvance = CType(FixString(MyBase.GetFormValue("txtAdvance"), 0, False, True), Double)

        If Trim(MyBase.GetFormValue("cboPaymentMode")) <> "" Then m_lngPaymentMode = CType(FixString(MyBase.GetFormValue("cboPaymentMode"), 0, False, True), Long)

        If Trim(MyBase.GetFormValue("txtDescription")) <> "" Then m_strDescription = FixString(MyBase.GetFormValue("txtDescription"), 0, False, True)

        If Trim(MyBase.GetFormValue("CboCurrency")) <> "" Then m_lngCurrencyID = CType(FixString(MyBase.GetFormValue("CboCurrency"), 0, False, True), Long)

        If Trim(MyBase.GetFormValue("CboCountry")) <> "" Then m_lngCountryID = CType(FixString(MyBase.GetFormValue("CboCountry"), 0, False, True), Long)

        If Trim(MyBase.GetFormValue("CboFpCenterID")) <> "" Then m_lngFPCenterID = CType(FixString(MyBase.GetFormValue("CboFpCenterID"), 0, False, True), Long)

        If Trim(MyBase.GetFormValue("chkIsBillable")) <> "" Then m_blnIsbillable = CType(FixString(MyBase.GetFormValue("chkIsBillable"), 0, False, True), Boolean)



        If m_strParamMode.ToUpper = "ADD_NEW" Then
            If m_strParamAction.ToUpper = "SAVE" Then

                strSQL = "usp_ins_tbl_PM_Expenses_for_ExpenseEntry '" + m_strParamDate + "' "
                strSQL += " , " + m_strProjectID.ToString
                strSQL += " , " + m_lngSubItemID.ToString
                strSQL += " , '" + m_dblAmount.ToString + "'"
                strSQL += " , '" + m_strSessionUserID + "' "
                strSQL += " , '" + m_strDescription.ToString + "' "
                strSQL += " , '" + m_lngPaymentMode.ToString + "' "
                strSQL += " , " + m_lngCurrencyID.ToString
                strSQL += " , " + m_lngCountryID.ToString
                strSQL += " , " + m_lngFPCenterID.ToString
                'Commented and added by Yogesh J on 18/12/2015 for datetime format issue
                'strSQL += " , '" + Date.Today.ToString + "'"
                strSQL += " , '" + Format(CType(FormatDateTime(Date.Today, DateFormat.ShortDate), Date), "MM/dd/yyyy").ToString + "'"
                'End of comment by Yogesh J
                strSQL += " , " + CType(IIf(m_blnIsbillable = True, 1, 0), String)
                strSQL += " , '" + m_dblAdvance.ToString + "'"

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            End If

        ElseIf m_strParamMode = "EDIT" Then

            If m_strParamAction.ToUpper = "SAVE" And m_strRefreshDetailsWindow <> "4" Then

                strSQL = "Update tbl_PM_Expenses SET "
                strSQL += " AMOUNT = " + m_dblAmount.ToString
                strSQL += " , CountryID = " + m_lngCountryID.ToString
                strSQL += " , CurrencyID = " + m_lngCurrencyID.ToString
                strSQL += " , FPCenterID = " + m_lngFPCenterID.ToString
                strSQL += "  , PaymentMode = '" + m_lngPaymentMode.ToString + "' "
                strSQL += ", Description = '" + m_strDescription.ToString + "' "
                strSQL += " , IsBillable = " + CType(IIf(m_blnIsbillable = True, 1, 0), String)
                strSQL += " , Advance = '" + m_dblAdvance.ToString + "' "
                strSQL += " WHERE ExpensesEntryID = " + m_lngExpensesEntryID.ToString

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            ElseIf m_strParamAction.ToUpper = "SAVE" And m_strRefreshDetailsWindow = "4" Then
                '16-Nov-05 Modified by AbhijitD- Billiable checkbox IS enabled for PM. Hence save that entry
                If m_strFinanceApprover = "1" Then
                    strSQL = "Update tbl_PM_Expenses SET "
                    strSQL += "FPCenterID = " + m_lngFPCenterID.ToString
                    '17-Nov-05 Added by AbhijitD- Billiable checkbox IS enabled for Finance Manager also
                    strSQL += ",IsBillable = " + CType(IIf(m_blnIsbillable = True, 1, 0), String)
                    '17-Nov-05 End of addition by AbhijitD
                    strSQL += " WHERE ExpensesEntryID = " + m_lngExpensesEntryID.ToString
                    CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                ElseIf m_strAdminVerifier = "1" Then
                    strSQL = "Update tbl_PM_Expenses SET "
                    strSQL += "IsBillable = " + CType(IIf(m_blnIsbillable = True, 1, 0), String)
                    strSQL += " WHERE ExpensesEntryID = " + m_lngExpensesEntryID.ToString
                    CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                    '16-Nov-05 End of Modification by AbhijitD

                End If
            End If
        End If

        ' Refresh Parent 

        ''                 1 - Save & Refresh Task List :- Refresh Task List, Close
        ''                 2 - Save & Close :- Close
        ''                 3 - Save & Add More :- Refresh Task List	
        ''Commented And Added By Usha Pandit On 01.07.2019 For Refresh issue on Save and close link
        'If m_strRefreshDetailsWindow = "1" Or m_strRefreshDetailsWindow = "3" Then
        If m_strRefreshDetailsWindow = "1" Or m_strRefreshDetailsWindow = "2" Or m_strRefreshDetailsWindow = "3" Then
            ''End Of Added By Usha Pandit On 01.07.2019 For Refresh issue on Save and close link
            ''                     Refresh the Task List
            CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>")
            CommonFunctions.General.WriteHTML("var strParentPage;")
            CommonFunctions.General.WriteHTML("try")
            CommonFunctions.General.WriteHTML("{	")
            CommonFunctions.General.WriteHTML("strParentPage = new String(); ")
            'Modified by HarshK for IssueID 3314 on 13 Apr 2006
            'CommonFunctions.General.WriteHTML("strParentPage = opener.location.href; ")
            CommonFunctions.General.WriteHTML("strParentPage='EWF_ExpenseEntryList.aspx?FromWhere=DT&MasterTagId=3556'; ")
            CommonFunctions.General.WriteHTML("strParentPage = strParentPage + '&txtDate=' + '" & m_strParamDate & "'; ")
            'End Modified by HarshK for IssueID 3314 on 13 Apr 2006
            CommonFunctions.General.WriteHTML("opener.location.href =''" + " + strParentPage; ")
            CommonFunctions.General.WriteHTML("}")
            CommonFunctions.General.WriteHTML("catch(e)")
            CommonFunctions.General.WriteHTML("{")
            CommonFunctions.General.WriteHTML("// This condition will come if the parent page has been closed, of changed.")
            CommonFunctions.General.WriteHTML("// Do nothing.")
            CommonFunctions.General.WriteHTML("}")
            CommonFunctions.General.WriteHTML("</script>")
        End If

        If m_strRefreshDetailsWindow = "1" Or m_strRefreshDetailsWindow = "2" _
        Or (m_strParamAction.ToUpper = "SAVE" And (m_strAdminVerifier = "1" Or m_strFinanceApprover = "1")) Then
            'Above line for Or condition commented by Abhijit and added following line for closing window on save by PM and finance Approvers
            'Or (m_strParamAction.ToUpper = "SAVE" And m_strRefreshDetailsWindow = "4") Then
            CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>" + vbCrLf)
            CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
        End If


        If m_strRefreshDetailsWindow = "3" Then
            ' commented by harshadad for whiziblesem expenses functionality on 28 March 2006
            'CommonFunction.General.WriteHTML("<script LANGUAGE=Javascript>" + vbCrLf)
            'CommonFunction.General.WriteHTML(" alert('Expense Entry Saved Sucessfully !');" + vbCrLf)
            'CommonFunction.General.WriteHTML("</script>")
            'end of commentation by harshadad for whiziblesem expenses functionality  on 28 March 2006
            m_strParamMode = "ADD_NEW"
            m_dblAmount = 0
            m_strDescription = ""
        End If

    End Sub
    Private Sub DrawEntryFormForExpense()
        '=====================================================================
        ' Procedure Name        : DrawEntryFormForExpense()	
        ' Purpose               : To plot the entry form for Expense entry.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : May 26, 2005
        ' Revisions             :
        '=====================================================================

        Dim objExpenseDR As IDataReader
        Dim strSQL As String
        Dim ProjectStartDate As String
        Dim ProjectEndDate As String
        Dim FinancialYearStartDate As String
        Dim FinancialYearEndDate As String
        Dim strToBeInserted As String

        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle


        Dim strHTML As String

        If m_strParamMode = "EDIT" Then

            m_lngExpensesEntryID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpensesEntryID"), "0"), Long)
            If m_lngExpensesEntryID <> 0 Then
                strSQL = "usp_sel_tbl_PM_Expense_for_Entry " + m_lngExpensesEntryID.ToString
            Else
                strSQL = "usp_sel_tbl_PM_Expense_for_Entry Null"
            End If

            objExpenseDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objExpenseDR.Read Then
                m_dtEntryDate = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("EntryDate"), ""), Date.Today.ToString), Date)
                m_strProjectID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("ProjectID"), "0"), "0"), String)
                m_lngSubItemID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("SubItemID"), "0"), "0"), Long)
                m_dblAmount = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("Amount"), "0"), "0"), Double)
                m_lngEmployeeID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("EmployeeID"), "0"), "0"), Long)
                m_strDescription = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("Description"), ""), ""), String)
                'm_lngPaymentMode = (CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("PaymentMode"), "0"), "0"), Long))
                
                If CType(CommonFunction.Data.CheckIsDBNull(objExpenseDR("PaymentMode"), ""), String) = "" Then
                    m_lngPaymentMode = 0
                Else
                    m_lngPaymentMode = (CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("PaymentMode"), "0"), "0"), Long))
                End If
                m_lngCurrencyID = (CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("CurrencyID"), "0"), "0"), Long))
                m_lngCountryID = (CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("CountryID"), "0"), "0"), Long))
                m_lngFPCenterID = (CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("FPCenterID"), "0"), "0"), Long))
                m_blnIsbillable = (CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("IsBillable"), "0"), "0"), Boolean))
                'DateofBooking = (CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("FPCenterID"), ""), Date.Today.ToString), Date))
                m_blnIsSubmitted = (CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("IsSubmitted"), "0"), "0"), Boolean))
                m_dblAdvance = (CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("Advance"), "0"), "0"), Double))

                ' if Called from Expense Sheet page Show all Controles as Disabled 

                If m_strReadOnlyMode.ToUpper = "VIEW" Then
                    m_blnIsSubmitted = True
                    'Added by Santosh Pawar to consider Employee Details instead of Approver Details 
                    'in View Mode .
                    m_strSessionUserID = CType(m_lngEmployeeID, String)
                    'End of Addition
                End If

                If m_blnIsSubmitted = True Then strToBeInserted = "disabled"

            End If

            CommonFunction.Data.DisposeDataReader(objExpenseDR)

        Else

            ' If no project is selected, then...
            If Trim(MyBase.GetFormValue("cboProject")) <> "" Then
                m_strProjectID = FixString(MyBase.GetFormValue("cboProject"), 0, False, True)
            Else
                m_strProjectID = "0"

            End If

            If m_strProjectID = "0" Then

                ' Get the project for which an Expense  was filled last. Select the project.			
                strSQL = "EXEC usp_sel_Project_for_ExpenseEntry " & m_strSessionUserID & ", '" & m_strParamDate & "', 1"
                m_strProjectID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0")

            End If

            ' If still no project is selected, then...
            If m_strProjectID = "0" Then

                objExpenseDR = CommonFunctions.Data.GetDataReader("EXEC usp_sel_Project_for_ExpenseEntry  " + m_strSessionUserID + ",'" & m_strParamDate & "'", MyBase.UseSQL)

                If objExpenseDR.Read Then
                    m_strProjectID = CType((CommonFunctions.Data.CheckIsDBNull(objExpenseDR("ProjectID"), "0")), String)
                End If
                CommonFunctions.Data.DisposeDataReader(objExpenseDR)
            End If




            ' If Trim(MyBase.GetFormValue("cboCostGroup")) <> "" Then m_lngGroupID = CType(FixString(MyBase.GetFormValue("cboCostGroup"), 0, False, True), Long)

            If Trim(MyBase.GetFormValue("cboCostHead")) <> "" Then m_lngSubItemID = CType(FixString(MyBase.GetFormValue("cboCostHead"), 0, False, True), Long)

            'If Trim(MyBase.GetFormValue("txtAmount")) <> "" Then Amount = CType(FixString(MyBase.GetFormValue("txtAmount"), 0, False, True), Long)

            If Trim(MyBase.GetFormValue("cboPaymentMode")) <> "" Then
                m_lngPaymentMode = CType(FixString(MyBase.GetFormValue("cboPaymentMode"), 0, False, True), Long)
            Else
                m_lngPaymentMode = CType(CommonFunction.Data.GetDataScalar("usp_sel_FPCenter_for_ExpenseEntry 1 , " + m_strSessionUserID, MyBase.UseSQL), Long)
            End If

            'If Trim(MyBase.GetFormValue("txtDescription")) <> "" Then Description = FixString(MyBase.GetFormValue("txtDescription"), 0, False, True)

            If Trim(MyBase.GetFormValue("CboCurrency")) <> "" Then
                m_lngCurrencyID = CType(FixString(MyBase.GetFormValue("CboCurrency"), 0, False, True), Long)
            Else
                m_lngCurrencyID = CType(CommonFunction.Data.GetDataScalar("usp_sel_currency_for_ExpenseEntry 1 , " + m_strSessionUserID, MyBase.UseSQL), Long)
            End If


            If Trim(MyBase.GetFormValue("CboCountry")) <> "" Then
                m_lngCountryID = CType(FixString(MyBase.GetFormValue("CboCountry"), 0, False, True), Long)
            Else
                m_lngCountryID = CType(CommonFunction.Data.GetDataScalar("usp_sel_country_for_ExpenseEntry 1 , " + m_strSessionUserID, MyBase.UseSQL), Long)
            End If

            If Trim(MyBase.GetFormValue("CboFpCenterID")) <> "" Then
                m_lngFPCenterID = CType(FixString(MyBase.GetFormValue("CboFpCenterID"), 0, False, True), Long)
            Else
                m_lngFPCenterID = CType(CommonFunction.Data.GetDataScalar("usp_sel_FPCenter_for_ExpenseEntry 1 , " + m_strSessionUserID, MyBase.UseSQL), Long)
            End If


            If Trim(MyBase.GetFormValue("chkIsBillable")) <> "" Then
                m_blnIsbillable = CType(FixString(MyBase.GetFormValue("chkIsBillable"), 0, False, True), Boolean)
            End If


        End If

        ' plot the Date control


        strHTML = ""
        '' If resource has selected any project then disable the date control
        'If m_strParamMode.ToUpper = "EDIT" Then
        '    strHTML = strHTML + CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , , CommonFunction.Dates.GetDate(Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)), , "frmEWF_ExpenseEntry", , , , True, True, , True)
        'Else
        '    strHTML = strHTML + CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , , CommonFunction.Dates.GetDate(Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)), , "frmEWF_ExpenseEntry", , , , , True, , True)
        'End If



        'With cObjSectionTitle
        '    strHTML = .GetSectionTitle(MyBase.GetResourceString("SECTION_TITLE") + " " + strHTML, "", "", , , , , , , , True, , False, False)
        '    'strHTML = .GetSectionTitle("Add/Modify Expense for the date" + " " + strHTML, "", "", , , , , , , , , , False, False)
        'End With
        CommonFunctions.General.WriteHTML(strHTML)

        'Main Div
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:310px'>")

        strHTML = ""
        '        strHTML = "<DIV id=DivExpenseEntry style='Overflow:auto;width=100%;Height:225'>"

        'Modified by MrugajaB on Date 3rd July 2006 for WhizibleSEM Issue ID.4168
        strHTML = "<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable> "
        'End Modification

        ' Expense Date 
        strHTML = strHTML + "<TR class=clsTRSectionHeader > <TD align=right>" + MyBase.GetResourceString("SECTION_TITLE") + "</TD>"
        strHTML = strHTML + "<TD align=left colspan=4>"

        ' If resource has selected any project then disable the date control
        If m_strParamMode.ToUpper = "EDIT" Then
            strHTML = strHTML + CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , , CommonFunction.Dates.GetDate(Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)), , "frmEWF_ExpenseEntry", , , , True, True, , True)
        Else
            strHTML = strHTML + CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , , CommonFunction.Dates.GetDate(Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)), , "frmEWF_ExpenseEntry", , , , , True, , True)
        End If

        strHTML = strHTML + "</TD></TR>"
        CommonFunction.General.WriteHTML(strHTML)

        ' Project
        strHTML = ""
        strHTML = strHTML + "<TR class=clsTREven > <TD align=right>" + MyBase.GetResourceString("SELECT_PROJECT") + "</TD>"
        strHTML = strHTML + "<TD align=left colspan=4>"

        If m_strParamMode.ToUpper = "EDIT" Then
            'strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_sel_Project_for_ExpenseEntry " & m_strSessionUserID & ",'" & m_strParamDate & "'", 300, m_strProjectID, " disabled ", True, True, , True)
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "Select ProjectID,ProjectName From tbl_PM_Project  where ProjectID=" & m_strProjectID, 300, m_strProjectID, " disabled ", True, True, , True)
            strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_sel_tbl_PM_Project_ProjectName " & m_strProjectID, 300, m_strProjectID, " disabled ", True, True, , True)
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        Else
            strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_sel_Project_for_ExpenseEntry " & m_strSessionUserID & ",'" & m_strParamDate & "'", 300, m_strProjectID, " Langugage=JavaScript OnChange=ProjectComboSubmit('" & m_strParamMode & "')", True, True, , True)
        End If
        'Added By JyotiG
        'Issue ID : 6655
        'Start
        'Date : 05-Oct-2006
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        strHTML = strHTML + CommonFunctions.HTMLControls.DrawTextBox("txtTagId", "txtTagId", , , , CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagID"), m_lngTagId.ToString), String), , , False, , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'End
        strHTML = strHTML + "</TD></TR>"

        CommonFunction.General.WriteHTML(strHTML)


        ' Commented by NitinVS as cost Group Is Not To Be Shown 
        '' Expense Group 
        'CommonFunction.General.WriteHTML("<TR class=clsTREven >")
        'CommonFunction.General.WriteHTML("<TD align=right>")
        'CommonFunction.General.WriteHTML(MyBase.GetResourceString("COSTGROUP"))
        'CommonFunction.General.WriteHTML("</TD> <TD  align=left colspan=2>")

        'strHTML = ""

        'If m_strParamMode = "EDIT" Then
        '    m_lngGroupID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT CostGroupID FROM tbl_CNF_CostHeads WHERE CostheadID = " + m_lngSubItemID.ToString, MyBase.UseSQL), "0"), "0"), Long)

        '    strHTML = CommonFunction.HTMLControls.DrawComboBox("cboCostGroup", "usp_sel_CostGroup_for_ExpenseEntry " + m_strSessionUserID & ", '" & m_strParamDate & "' ," + m_strProjectID, 300, m_lngGroupID.ToString, " disabled ", True, True, , True)
        'Else
        '    strHTML = CommonFunction.HTMLControls.DrawComboBox("cboCostGroup", "usp_sel_CostGroup_for_ExpenseEntry " + m_strSessionUserID & ", '" & m_strParamDate & "' ," + m_strProjectID, 300, m_lngGroupID.ToString, " Langugage=JavaScript OnChange=CostGroupComboSubmit('" & m_strParamMode & "')", True, True, , True)
        'End If

        'CommonFunction.General.WriteHTML(strHTML + "</TD></TR>")

        ' End comment By NitinVS 

        ' Expense Head 
        CommonFunction.General.WriteHTML("<TR class=clsTREven >")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COSTHEAD"))
        CommonFunction.General.WriteHTML("</TD> <TD  align=left colspan=4>")

        strHTML = ""

        If m_strParamMode = "EDIT" Then
            ' strHTML = CommonFunction.HTMLControls.DrawComboBox("cboCostHead", "usp_sel_CostHead_for_ExpenseEntry " + m_strSessionUserID & ", '" & m_strParamDate & "' ," + m_strProjectID + " , Null ", 300, m_lngSubItemID.ToString, " Langugage=JavaScript OnChange=CostHeadComboSubmit('" & m_strParamMode & "')" + " disabled ", True, True, , True)
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            '' strHTML = CommonFunction.HTMLControls.DrawComboBox("cboCostHead", " Select CostHeadID,CostHead From tbl_CNF_CostHeads Where CostHeadID= " & m_lngSubItemID, 300, m_lngSubItemID.ToString, " Langugage=JavaScript OnChange=CostHeadComboSubmit('" & m_strParamMode & "')" + " disabled ", True, True, , True)
            strHTML = CommonFunction.HTMLControls.DrawComboBox("cboCostHead", "usp_sel_tbl_CNF_CostHeads_CostHeadID " & m_lngSubItemID, 300, m_lngSubItemID.ToString, " Langugage=JavaScript OnChange=CostHeadComboSubmit('" & m_strParamMode & "')" + " disabled ", True, True, , True)
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        Else
            strHTML = CommonFunction.HTMLControls.DrawComboBox("cboCostHead", "usp_sel_CostHead_for_ExpenseEntry " + m_strSessionUserID & " , '" & m_strParamDate & "' ," + m_strProjectID + " , Null ", 300, m_lngSubItemID.ToString, " Langugage=JavaScript OnChange=CostHeadComboSubmit('" & m_strParamMode & "','Dropdown')", True, True, , True)
        End If

        CommonFunction.General.WriteHTML(strHTML + "</TD></TR>")

        ' Amount 
        CommonFunction.General.WriteHTML("<TR class=clsTREven >")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("AMOUNT"))
        CommonFunction.General.WriteHTML("</TD> <TD  align=left width=10%>")

        strHTML = ""

        'Modified by SantoshK on Date July 06,2006 --changed length form 10 to 8
        If m_dblAmount = 0 Then
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strHTML = CommonFunction.HTMLControls.DrawTextBox("txtAmount", "txtAmount", , 50, 7, "", "right", , m_blnIsSubmitted, , , , , True, True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        Else
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strHTML = CommonFunction.HTMLControls.DrawTextBox("txtAmount", "txtAmount", , 50, 7, m_dblAmount.ToString, "right", , m_blnIsSubmitted, , , , , True, True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        End If
        'End of modification by SantoshK on July 06,2006 

        CommonFunction.General.WriteHTML(strHTML + "</TD>")

        'Currency 
        'CommonFunction.General.WriteHTML("<TR class=clsTREven >")
        CommonFunction.General.WriteHTML("<TD align=right width=10%>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("CURRENCY"))
        CommonFunction.General.WriteHTML("</TD> <TD  align=left >")

        'Set Default Currency to Corporate Base Currency if no currency selected 
        If m_lngCurrencyID = 0 Then
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''m_lngCurrencyID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT BaseCurrencyID FROM tbl_PM_CompanyInformation", MyBase.UseSQL), "0"), "0"), Long)
            m_lngCurrencyID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_BaseCurrencyID", MyBase.UseSQL), "0"), "0"), Long)
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        End If

        strHTML = ""
        strHTML = CommonFunction.HTMLControls.DrawComboBox("CboCurrency", "usp_sel_currency_for_ExpenseEntry ", 80, m_lngCurrencyID.ToString, CommonFunction.General.CheckIsNothing(strToBeInserted, ""), True, True, , True)
        CommonFunction.General.WriteHTML(strHTML + "</TD></TR>")

        'commented by PurvaJ on 14 April 2006 issue 2886
        ' Advance Taken 
        'CommonFunction.General.WriteHTML("<TR class=clsTREven >")
        'CommonFunction.General.WriteHTML("<TD align=right>")
        'CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_ADVANCE"))
        'CommonFunction.General.WriteHTML("</TD> <TD  align=left width=10% colspan=4>")

        'strHTML = ""

        'If m_dblAmount = 0 Then
        'strHTML = CommonFunction.HTMLControls.DrawTextBox("txtAdvance", "txtAdvance", , 75, 10, "", "right", , m_blnIsSubmitted, , , , , True, )
        'Else
        'strHTML = CommonFunction.HTMLControls.DrawTextBox("txtAdvance", "txtAdvance", , 75, 10, m_dblAdvance.ToString, "right", , m_blnIsSubmitted, , , , , True, )
        'End If
        'end comment

        'CommonFunction.General.WriteHTML(strHTML + "</TD></TR>")


        ' IsBillable

        CommonFunction.General.WriteHTML("<TR class=clsTREven >")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("ISBILLABLE"))
        CommonFunction.General.WriteHTML("</TD> <TD  align=left colspan=1>")

        strHTML = ""
        ' If UserCanOverRide is 1 then make the Isbillable Checkbox enabled 
        If CommonFunction.General.CheckIsNothing(m_lngSubItemID, "0") <> "0" Then

            strSQL = "usp_sel_CostHead_for_ExpenseEntry " + m_strSessionUserID & ", '" & m_strParamDate & "' ," & m_strProjectID + " , Null  , " + CommonFunction.General.CheckIsNothing(m_lngSubItemID.ToString, " Null")
            objExpenseDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

            If objExpenseDR.Read Then
                'Added By PradeepD to resolve Issue 21332 on 27-Oct-2005: Read value from CostHead Master table only if mode is NOT "EDIT"
                If UCase(m_strParamMode) <> "EDIT" Then
                    m_blnIsbillable = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("Billable"), "0"), "0"), Boolean)
                End If
                m_blnUserCanOverRide = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("UserCanOverRide"), "0"), "0"), Boolean)

            End If

            CommonFunction.Data.DisposeDataReader(objExpenseDR)

            If m_strParamMode.ToUpper = "ADD_NEW" Then
                strHTML = CommonFunction.HTMLControls.DrawCheckBox("chkIsBillable", "chkIsBillable", , m_blnIsbillable, m_blnIsbillable.ToString, CType(IIf(m_blnUserCanOverRide, False, True), Boolean), "onClick='IsBillable_OnClick()'", True)

            Else
                '15-Nov-05 AbhijitD- If the logged in user is PM, enable the Billiable checkbox
                If m_strAdminVerifier = "1" Or m_strFinanceApprover = "1" Then
                    strHTML = CommonFunction.HTMLControls.DrawCheckBox("chkIsBillable", "chkIsBillable", , m_blnIsbillable, m_blnIsbillable.ToString, False, "onClick='IsBillable_OnClick()'", True)
                Else
                    strHTML = CommonFunction.HTMLControls.DrawCheckBox("chkIsBillable", "chkIsBillable", , m_blnIsbillable, m_blnIsbillable.ToString, CType(IIf(m_blnUserCanOverRide, m_blnIsSubmitted, True), Boolean), "onClick='IsBillable_OnClick()'", True)
                End If
                'End of addition by Abhijit
            End If
        Else

            '15-Nov-05 AbhijitD- If the logged in user is PM, enable the Billiable checkbox
            If m_strAdminVerifier = "1" Or m_strFinanceApprover = "1" Then
                strHTML = CommonFunction.HTMLControls.DrawCheckBox("chkIsBillable", "chkIsBillable", , m_blnIsbillable, m_blnIsbillable.ToString, False, "onClick='IsBillable_OnClick()'", True)
            Else
                strHTML = CommonFunction.HTMLControls.DrawCheckBox("chkIsBillable", "chkIsBillable", , m_blnIsbillable, m_blnIsbillable.ToString, CType(IIf(m_blnUserCanOverRide, m_blnIsSubmitted, True), Boolean), "onClick='IsBillable_OnClick()'", True)
            End If
            'End of addition by Abhijit

        End If
        CommonFunction.General.WriteHTML(strHTML + "</TD><TD colspan=4> <I>" + MyBase.GetResourceString("BILLABLE_COMMENT") + "<I></TD></TR>")

        ' Description
        CommonFunction.General.WriteHTML("<TR class=clsTREven >")
        CommonFunction.General.WriteHTML("<TD align=right valign=top>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("DESCRIPTION"))
        CommonFunction.General.WriteHTML("</TD> <TD  align=left colspan=4>")

        strHTML = ""

        If m_strParamMode = "EDIT" Then
            If m_blnIsSubmitted = True Then

                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'strHTML = CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmEWF_ExpenseEntry", , , 400, 75, 500, m_strDescription.ToString, ToBeInserted:="Disabled", returnhtml:=True, IsMandatory:=True)
                strHTML = CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmEWF_ExpenseEntry", , , 400, 75, 500, m_strDescription.ToString, ToBeInserted:="Disabled", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Else
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'strHTML = CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmEWF_ExpenseEntry", , , 400, 75, 500, m_strDescription.ToString, returnhtml:=True, IsMandatory:=True)
                strHTML = CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmEWF_ExpenseEntry", , , 400, 75, 500, m_strDescription.ToString, returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            End If
        Else
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'strHTML = CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmEWF_ExpenseEntry", , , 400, 75, 500, m_strDescription.ToString, CType(m_blnIsSubmitted, String), returnhtml:=True, IsMandatory:=True)
            strHTML = CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmEWF_ExpenseEntry", , , 400, 75, 500, m_strDescription.ToString, CType(m_blnIsSubmitted, String), returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        End If
        CommonFunction.General.WriteHTML(strHTML + "</TD></TR>")

        If m_strParamMode = "EDIT" Then
            ' strHTML = CommonFunction.HTMLControls.DrawComboBox("cboCostHead", "usp_sel_CostHead_for_ExpenseEntry " + m_strSessionUserID & ", '" & m_strParamDate & "' ," + m_strProjectID + " , Null ", 300, m_lngSubItemID.ToString, " Langugage=JavaScript OnChange=CostHeadComboSubmit('" & m_strParamMode & "')" + " disabled ", True, True, , True)
            strHTML = CommonFunction.HTMLControls.DrawComboBox("cboCostHead", " Select CostHeadID,CostHead From tbl_CNF_CostHeads Where CostHeadID= " & m_lngSubItemID, 300, m_lngSubItemID.ToString, " Langugage=JavaScript OnChange=CostHeadComboSubmit('" & m_strParamMode & "')" + " disabled ", True, True, , True)

        Else
            strHTML = CommonFunction.HTMLControls.DrawComboBox("cboCostHead", "usp_sel_CostHead_for_ExpenseEntry " + m_strSessionUserID & " , '" & m_strParamDate & "' ," + m_strProjectID + " , Null ", 300, m_lngSubItemID.ToString, " Langugage=JavaScript OnChange=CostHeadComboSubmit('" & m_strParamMode & "')", True, True, , True)
        End If


        ' Country 
        CommonFunction.General.WriteHTML("<TR class=clsTREven >")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COUNTRY"))
        CommonFunction.General.WriteHTML("</TD> <TD  align=left colspan=4>")

        strHTML = ""


        strHTML = CommonFunction.HTMLControls.DrawComboBox("CboCountry", "usp_sel_country_for_ExpenseEntry ", 300, m_lngCountryID.ToString, CommonFunction.General.CheckIsNothing(strToBeInserted, ""), True, True, , True)
        CommonFunction.General.WriteHTML(strHTML + "</TD></TR>")


        ' Financial Processing Center 
        CommonFunction.General.WriteHTML("<TR class=clsTREven >")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("FINANCIAL_PROCESSING_CENTER"))
        CommonFunction.General.WriteHTML("</TD> <TD  align=left colspan=4>")

        strHTML = ""
        ' If Finacne Approver is Viewinng the Details then he can Change the Finance Processing Center
        If m_strFinanceApprover = "1" Then
            strHTML = CommonFunction.HTMLControls.DrawComboBox("CboFpCenterID", "usp_sel_FPCenter_for_ExpenseEntry ", 300, m_lngFPCenterID.ToString, , True, True, , True)
        Else
            strHTML = CommonFunction.HTMLControls.DrawComboBox("CboFpCenterID", "usp_sel_FPCenter_for_ExpenseEntry ", 300, m_lngFPCenterID.ToString, CommonFunction.General.CheckIsNothing(strToBeInserted), True, True, , True)
        End If

        CommonFunction.General.WriteHTML(strHTML + "</TD></TR>")

        ' Payment Mode 
        CommonFunction.General.WriteHTML("<TR class=clsTREven >")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("PAYMENT_MODE"))
        CommonFunction.General.WriteHTML("</TD> <TD  align=left colspan=4>")

        strHTML = ""

        'Modified by MrugajaB on 27th Nov 2006 for whiziblesem SP8
        'Mandatory check removed for 'Payment Mode' from expense entry screen as it is non mandatory in weekly view
        'strHTML = CommonFunction.HTMLControls.DrawComboBox("cboPaymentMode", "usp_sel_PaymentMode_for_ExpenseEntry ", 300, m_lngPaymentMode.ToString, CommonFunction.General.CheckIsNothing(strToBeInserted), True, True, , True)
        strHTML = CommonFunction.HTMLControls.DrawComboBox("cboPaymentMode", "usp_sel_PaymentMode_for_ExpenseEntry ", 300, m_lngPaymentMode.ToString, CommonFunction.General.CheckIsNothing(strToBeInserted), True, True, , False)
        'End Modification

        CommonFunction.General.WriteHTML(strHTML + "</TD></TR>")


        ' Draw Hidden Controls 
        ' Project Start Date and end Date 
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        ''strSQL = "SELECT REPLACE(CONVERT(VARCHAR(12),ExpectedStartDate ,106) , ' ', '-') FROM tbl_PM_Project WHERE ProjectID = " + m_strProjectID
        strSQL = "usp_sel_ExpectedStartDate_106_tbl_PM_Project " + m_strProjectID
        ProjectStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), Today.ToString)
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtProjectStartDate", "txtProjectStartDate", , , , ProjectStartDate, IsHidden:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        ''strSQL = "SELECT REPLACE(CONVERT(VARCHAR(12),ExpectedEndDate ,106) , ' ', '-') FROM tbl_PM_Project WHERE ProjectID = " + m_strProjectID
        strSQL = "usp_sel_ExpectedEndDate_106_tbl_PM_Project " + m_strProjectID
        ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        ProjectEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), Today.ToString)
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtProjectEndDate", "txtProjectEndDate", , , , ProjectEndDate, IsHidden:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding

        strSQL = "usp_sel_FinancialYear_StartDate_EndDate_for_Expense  '" + m_strParamDate + "'"
        objExpenseDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If objExpenseDR.Read() Then
            FinancialYearStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("FinYearStartDate"), ""), "")
            FinancialYearEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objExpenseDR("FinYearEndDate"), ""), "")
        End If



        CommonFunction.Data.DisposeDataReader(objExpenseDR)

        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtFinYearStartDate", "txtFinYearStartDate", , , , FinancialYearStartDate, IsHidden:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding

        'Modified by SantoshK on Date July 06,2006 for WhizibleSEM Issue ID.4168
        'Changed txtProjectStartDate to txtFinYearEndDate
        'CommonFunction.HTMLControls.DrawTextBox("txtFinYearEndDate", "txtProjectStartDate", , , , FinancialYearEndDate, ishidden:=True)
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtFinYearEndDate", "txtFinYearEndDate", , , , FinancialYearEndDate, IsHidden:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'End of modification by SantoshK on July 06,2006 Isse ID.4168

        ' Todays date 
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtTodaysDate", "txtTodaysDate", , , , m_strTodaysDate, IsHidden:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding


        'Modified By ShraddhaM on 19,Sep 2006 For SP7 Issue ID : 6197
        ' Dim m_strPKToken_Expense_Entry As String
        'm_strPKToken_Expense_Entry = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpensesEntryID"), String) + CType(Session("intUserID"), String) + "0" + CType(m_lngTagId, String))

        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strPKToken_Expense_Entry, , , , , , , , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'Ended By ShraddhaM on 19,Sep 2006 For SP7 Issue ID : 6197
        CommonFunction.General.WriteHTML("</TABLE>")

        CommonFunction.General.WriteHTML("</DIV></DIV>")


    End Sub
    Private Sub DrawPageLegend()
        '=====================================================================
        ' Procedure Name        : DrawPageLegend()	
        ' Purpose               : To plot the Legends of the Page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : May 26, 2005
        ' Revisions             :
        '=====================================================================
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)
    End Sub



    Private Sub drawMenu(ByVal Location As String)
        '=====================================================================
        ' Procedure Name        : DrawEntryFormForExpense()	
        ' Purpose               : To plot Menu
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : May 26, 2005
        ' Revisions             :
        '=====================================================================


        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu

        If m_strReadOnlyMode.ToUpper <> "VIEW" Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_ADD"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_ADD"))
            arrClientSideFunctionList.Add("Save_OnClick(3)")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_REFRESH_EXPENSE_LIST"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_REFRESH_EXPENSE_LIST"))
            arrClientSideFunctionList.Add("Save_OnClick(1)")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_CLOSE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_CLOSE"))
            arrClientSideFunctionList.Add("Save_OnClick(2)")

        End If
        ' commented by harshada d for whiziblesem 6 for expenses workflow issue id :2318 
        ' If Finacne Approver is Viewing the Page Then show the Save and Close Link 
        'Commented by SavitaS on 16 Nov 2005
        'Purpose :To show "Save and Close" link when Login Person is PM and Finance Approver
        'If m_strReadOnlyMode.ToUpper = "VIEW" And m_strFinanceApprover.ToUpper = "1" _
        'Or m_strReadOnlyMode.ToUpper = "VIEW" And m_strAdminVerifier = "1" Then
        '    arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_CLOSE"))
        '    arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_CLOSE"))
        '    arrClientSideFunctionList.Add("Save_OnClick(4)")
        'End If
        ' end of commentation by harshada d for whiziblesem 6 for issue id 2318 

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrClientSideFunctionList.Add("Close_OnClick()")


        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        'arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('EWF')")

        If Location.ToUpper = "TOP" Then
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True, )
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
        If m_objGlobal.TagID <> 3556 Then
            m_objGlobal.TagID = 3556
        End If
        'If m_objGlobal.TagID <> 3593 Then
        '    m_objGlobal.TagID = 3593
        'End If
        m_lngTagId = m_objGlobal.TagID
    End Sub

#End Region

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.EWF_ExpenseEntry", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

    End Sub
End Class
