'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleE
' Module Name           :  EWF_ExpenseSheet.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  Santosh Pawar
' Reviewed              :  
' Tested                :  
' Created               : 25 May 2005  
' Revisions             : 1.0 
'=====================================================================

#Region " Imports "
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class EWF_ExpenseSheet
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

    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Protected m_strWindowTitle As String
    Protected m_intTagID As Integer
    Protected m_strEmployeeID As String

    Dim m_intAccessAdd As Integer
    Dim m_intAccessDelete As Integer
    Dim m_intIndex As Integer

    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0

    Private m_strPagingAlphabet As String
    Private m_strSearchString As String
    Private m_strProjectID As String

    Protected m_strExpenseSheetID As String
    Protected m_strExpenseSheetStatus As String

    Protected m_lngAction As Long
    Protected m_Mode As String

    Protected m_lngActor As Long

    Private m_blnApprove As Boolean
    Private m_blnReject As Boolean
    Private m_blnEscalate As Boolean
    Private m_blnDisown As Boolean
    Private m_strExpensesEntryID As String

    Protected m_strSessionUserID As String
    Protected m_strSessionPostID As String

    'used for Showing Project Wise Sum of amount per Currency and Expense Sheet status in perspective of Logged in person 
    Private m_lngProjectID As Long
    Private m_strProjectName As String = ""
    Protected m_strExpenseSheetStatus_for_User As String

    Private m_blnIsAdminVerfied As Boolean
    Private m_blnIsFinanceVerified As Boolean
    Private m_blnIsFinanceApproved As Boolean
    Dim intCnt As Integer = -1
    ' To  Check if the Finance User has AdminVerification , FinanceVerification , FinacneApproval Rights 
    Private m_blnAdminVerifier As Boolean
    Private m_blnFinanceVerifier As Boolean
    Private m_blnFinanceApprover As Boolean

    'Added By HarshK on 14 Apr 2006 for IssueID 3350
    Protected m_blnFinanceApproverNotSet As Boolean = True
    'End Added By HarshK on 14 Apr 2006 for IssueID 3350

    'Added By MrugajaB on 02 May 2006 
    Protected m_blnEscaltedApproverNotSet As Boolean = True
    Dim drEscaltedApprover As IDataReader
    Dim strFinNotSetList As String
    'End Added By HarshK on 14 Apr 2006 for IssueID 3350

    'added by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 28 Jun 2006
    'Modified by PrajaktaR on 26 June 2006 for Bristlecone
    Private WithEvents oRpt As AdHocReports.Report.AdHocReport
    Protected m_strFileName As String
    Protected m_intShowMessage As Integer = 0
    Protected m_strQuery As String
    Protected Const ACTION_VIEW_REPORT As String = "ViewReport"
    Protected Const ACTION_SHOW_REPORT As String = "ShowReport"
    Protected m_lngReportID As Integer = 1974
    Private strMenu As String
    'END Of Modification by PrajaktaR on 26 June 2006 for Bristlecone
    'end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for Expenses Weekly View Enhancements 28 Jun 2006
    'Modified By ShraddhaM on 21,Sep 2006 For SP7 Issue ID : 6197
    Protected m_strPKToken_Expense_Sheet As String
    Protected m_strPKToken_Expense_SheetOld As String
    ''code added by RohiniK on 07 Sep 2006 for SA Issue : 3588 - Security issue 
    Protected m_blnisValidExpenses As Boolean = False
    ''End of code addition by RohiniK on 07 Sep 2006 for SA Issue : 3588 - Security issue 

    'Ended By ShraddhaM on 21,Sep 2006 For SP7 Issue ID : 6197
    ' Added by MahendraV On 9:27 AM 7/4/2007 for WhizibleSEM 7 
    ' The code changes required for the custom-report UI page 
    Protected m_strReportDisclaimer As String = ""
    ' End_MV_7/4/2007
#End Region

#Region "Constants"

    Const m_strActionDraft As String = "Draft"
    Const m_strActionSubmitted As String = "Submitted"
    Const m_strActionApproved As String = "Approved"
    Const m_strActionRejected As String = "Rejected"
    Const m_strActionEscalated As String = "Escalated"
    Const m_strActionDisowned As String = "Disowned"
    Const m_strActionFinanceApproved As String = "ApprovedByFinance"
    Const m_strActionFinanceRejected As String = "RejectedByFinance"
    Const m_strActionResubmitted As String = "Resubmitted"

#End Region

    Private Enum ActorIndex
        Owner
        Approver
        EscalatedApprover
        FinanceApprover
    End Enum

    Private Enum ActionIndex
        Draft
        Submitted
        Approved
        Rejected
        Escalated
        Disowned
        FinanceApproved
        FinanceRejected
        Resubmitted
        AdminVerified
        FinanceVerified
    End Enum

    Private Enum ExpenseSheetStatus
        draft
        Submitted
        Approved
        FinanceApproved
    End Enum

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
        ' Author                :   Santosh Pawar
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        ''' added By NageshM on 21st Jun 2005
        ''' Commented By NageshM on 27th june 2005
        'Purpose of commenting  : To avoid the display of alert message in edit mode
        ''        Code is placed at ADD mode .
        '        Call DisplayAlert()
        '' End of addtion By NageshM
        Call GetGlobalObject()

        Call getQueryStringParameter()
        m_lngTagId = CType(Request.QueryString("MasterTagID"), Long)
        'Modified By ShraddhaM on 21,Sep 2006 For SP7 Issue ID : 6197
        If m_Mode.ToUpper = "ADD" Then
            m_strPKToken_Expense_Sheet = Request.QueryString("PkToken").ToString

            If ((m_strPKToken_Expense_Sheet = "") And (CType(Session("intProjectID"), String) <> "0")) Or _
             ((CType(Session("intProjectID"), String) <> "0") And _
             (CommonFunctions.Security.Token.ValidateToken(CType(Session("intProjectID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String), m_strPKToken_Expense_Sheet) = False)) Then

                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Expense Sheet", m_lngTagId, 0, "Expense ID", CType(m_strExpenseSheetID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If

        End If
        If m_Mode.ToUpper = "EDIT" Then
            'Modified By ShraddhaM on 21,Sep 2006 For SP7 Issue ID : 6197
            If CType(m_strPKToken_Expense_Sheet, String) <> "0" Then
                If Request.QueryString("PkToken") Is Nothing Then
                    m_strPKToken_Expense_Sheet = Request.Form("txtPkToken").ToString
                    m_strPKToken_Expense_SheetOld = m_strPKToken_Expense_Sheet
                Else
                    m_strPKToken_Expense_Sheet = Request.QueryString("PkToken").ToString
                    m_strPKToken_Expense_SheetOld = m_strPKToken_Expense_Sheet
                End If
            End If


            If ((m_strPKToken_Expense_Sheet = "") And (m_strExpenseSheetID <> "0")) Or _
        ((m_strExpenseSheetID <> "0") And _
        (CommonFunctions.Security.Token.ValidateToken(CType(m_strExpenseSheetID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String), m_strPKToken_Expense_Sheet) = False)) Then


                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Expense Sheet", m_lngTagId, 0, "Expense ID", CType(m_strExpenseSheetID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        'Ended By ShraddhaM on 21,Sep 2006 For SP7 Issue ID : 6197
        ' Call DrawPageHeader()
        ' added by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 28 Jun 2006
        'Added by PrajaktaR on 26 June 2006 for Bristlecone
        Dim strAction As String = ""
        strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))
        If strAction = ACTION_SHOW_REPORT Then
            ShowReport()
        Else
            'END Of Addition by PrajaktaR on 26 June 2006 for Bristlecone
            Call getQueryStringParameter()
            ' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for Expenses Weekly View Enhancements 28 Jun 2006
            Call HandleModesAndActions()

            Call getExpenseSheetStatus()

            ' Draw the Page 
            Call DrawMenu()
            'CommonFunctions.General.WriteHTML("<DIV id='PageDiv' name='PageDiv' style='Overflow:auto;width:100%;Height:450;'>")
            Call CheckRoleAccess()

            Call DrawPageLegend()

            Call PlotControls()

            CommonFunctions.General.WriteHTML("<BR>")
            CommonFunctions.General.WriteHTML("</DIV>")

            Call DrawMenu()
        End If
    End Sub

    Private Sub DisplayAlert()
        ''''Added By NageshM on 21'st jun 2005
        ''' Declared By NageshM On Date 21'st June 2005
        Dim Stremployeeid As String
        Dim m_strSessionUserID As String = CType(Session("intUserID"), String)
        '' End of declaration by NageshM
        ''''Added By NageshM On Date 21'st June 2005
        Dim strquery As String

        Dim StrUserID As String
        Dim strOutput As String
        strquery = "usp_get_Pending_Expense_Entries " + m_strSessionUserID
        strOutput = CType(CommonFunctions.Data.CheckIsDBNull(CType(CommonFunction.Data.GetDataScalar(strquery, MyBase.UseSQL), String), "0"), String)

        '***  Added by TinaB for Removing the alert when Projectname is Blank - 21st Sept 2005
        If strOutput.ToUpper <> "PROJECTNAME(S) :" Then
            If strOutput.ToString.Trim <> "" Then

                CommonFunction.General.WriteHTML("<SCRIPT Language=JavaScript>")
                'CommonFunction.General.WriteHTML("alert('" &MyBase.GetResourceString("APPROVE_ENTRY") & "');")
                CommonFunction.General.WriteHTML("alert('" & MyBase.GetResourceString("APPROVE_ENTRY") & " ' + ' " & strOutput & " ');")
                ' CommonFunction.General.WriteHTML("alert('" & srtOutput & "');")
                CommonFunction.General.WriteHTML("</Script>")
            End If
        End If
        '***  End of Code Added by TinaB - 21st Sept 2005

        ''''End of addition


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
        ' Author                :  Santosh Pawar
        ' Created               :  
        ' Revisions             :  
        '=====================================================================

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
        m_lngTagId = 3593
    End Sub
    Protected Sub getExpenseSheetStatus()
        '====================================================================
        ' Procedure Name        :  getExpenseSheetStatus
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get the status of the ExpenseSheet 
        ' Description           :  This sub-routine gets the Status of the Expenseshet which is used to show or hide menu
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS
        ' Created               :  6 Jun 2005 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String

        If m_strExpenseSheetID <> "" Then
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            '' strSQL = "SELECT UPPER(Status) FROM tbl_PM_ExpenseSheet_status WHERE ExpenseSheetID = " + m_strExpenseSheetID
            strSQL = "usp_sel_tbl_PM_ExpenseSheet_status " + m_strExpenseSheetID
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            m_strExpenseSheetStatus = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), String)

        Else

            m_strExpenseSheetStatus = ""

        End If

        'm_strExpenseSheetStatus()
    End Sub


    Private Function DisplayProjectwiseTotals() As String

        Dim intCount As Integer
        Dim strToBeInserted As String = ""
        Dim strToBeReturned As String = ""
        Dim intColspan As Integer = 0
        Dim strSQL As String
        Dim strHTML As String = ""
        Dim objDR As IDataReader


        strSQL = "usp_sel_AmountSum_PerCurrency_forProject_ExpenseSheet " + m_lngProjectID.ToString + " , " + m_strSessionUserID + " ,'" + m_strExpenseSheetID + "'" + ", " + m_lngActor.ToString

        objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        strHTML += "<tr class='clsTRColumnHeader'><td nowrap align=left width='100%' colspan=10>"

        strHTML += "Total Amount : "
        While objDR.Read()
            strHTML += CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("CurrencySymbol"), ""), "") + " "
            strHTML += CommonFunction.General.CheckIsNothing(FormatNumber(CommonFunction.Data.CheckIsDBNull(objDR("Amount"), ""), 2), "") + " ; "
        End While

        If strHTML <> "" Then
            strHTML = strHTML.Substring(0, strHTML.Length - 2)
        End If

        strHTML += " </td></tr> "

        CommonFunction.Data.DisposeDataReader(objDR)

        strToBeReturned &= strHTML

        Return strToBeReturned

    End Function

    ' added by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 28 Jun 2006
    Private Function DisplayProjectwiseTotalsReport() As String

        Dim intCount As Integer
        Dim strToBeInserted As String = ""
        Dim strToBeReturned As String = ""
        Dim intColspan As Integer = 0
        Dim strSQL As String
        Dim strHTML As String = ""
        Dim objDR As IDataReader
        Dim strQuery As String
        Dim drProject As IDataReader
        Dim m_intProjectID As Integer

        'strQuery = "SELECT DISTINCT ProjectID FROM tbl_PM_Expenses WHERE ExpensesEntryID IN (select ExpensesEntryID FROM tbl_PM_ExpenseSheet_Details WHERE ExpenseSheetID = " + m_strExpenseSheetID + ")"
        'drProject = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
        'While drProject.Read

        '    m_intProjectID = CType(drProject("ProjectID"), Integer)

        strSQL = "usp_sel_AmountSum_PerCurrency_forProject_ExpenseSheet " + m_lngProjectID.ToString + " , " + m_strSessionUserID + " ,'" + m_strExpenseSheetID + "'" + ", " + m_lngActor.ToString

        objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        strHTML += "Total Amount :"
        While objDR.Read()
            strHTML += CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("CurrencySymbol"), ""), "") + " "
            strHTML += CommonFunction.General.CheckIsNothing(FormatNumber(CommonFunction.Data.CheckIsDBNull(objDR("Amount"), ""), 2), "") + " ; "
        End While

        If strHTML <> "" Then
            strHTML = strHTML.Substring(0, strHTML.Length - 2)
        End If

        CommonFunction.Data.DisposeDataReader(objDR)

        strToBeReturned &= strHTML
        'End While

        Return strToBeReturned

    End Function

    ' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for Expenses Weekly View Enhancements 28 Jun 2006
    Private Sub PlotSubControls()
        '=====================================================================
        ' Procedure Name        : PlotSubControls()	
        ' Purpose               : This procedure actually plots the description and title Controls on the Page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Santosh Pawar
        ' Created               : 25 May 2005
        ' Revisions             : 1.0
        '=====================================================================

        Dim blnDisabled As Boolean
        Dim strSQL As String
        Dim strTitle As String = ""
        Dim strDescription As String = ""
        Dim strOwner As String


        If m_lngActor <> ActorIndex.Owner Then blnDisabled = True Else blnDisabled = False

        If m_Mode.ToUpper = "EDIT" Then

            DrawPageHeader()
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            '' strSQL = "SELECT Title FROM tbl_PM_ExpenseSheet WHERE ExpenseSheetID = " + m_strExpenseSheetID
            strSQL = "usp_sel_tbl_PM_ExpenseSheet_Title " + m_strExpenseSheetID
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            strTitle = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "")
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            '' strSQL = "SELECT Comments FROM tbl_PM_ExpenseSheet WHERE ExpenseSheetID = " + m_strExpenseSheetID
            strSQL = "usp_sel_tbl_PM_ExpenseSheet_Comments " + m_strExpenseSheetID
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            strDescription = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "")
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''strSQL = "SELECT EmployeeName FROM tbl_PM_ExpenseSheet , tbl_PM_Employee WHERE tbl_PM_ExpenseSheet.EmployeeID =  tbl_PM_Employee.EmployeeID AND  tbl_PM_ExpenseSheet.ExpenseSheetID = " + m_strExpenseSheetID
            strSQL = "usp_sel_tbl_PM_ExpenseSheet_EmployeeName " + m_strExpenseSheetID
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            strOwner = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "")

        End If

        Response.Write("<Table width=100% Class='clsTable'  cellspacing=0 cellpadding=0 >")

        If m_Mode.ToUpper = "EDIT" Then

            Response.Write("<TR Class = 'clsTREven' >")
            Response.Write("<TD align='right'>")
            Response.Write(MyBase.GetResourceString("COL_EXPENSESHEETID") + " :")
            Response.Write("</TD>")
            Response.Write("<TD>")
            Response.Write(m_strExpenseSheetID)
            Response.Write("</TD>")
            Response.Write("</TR>")

            Response.Write("<TR Class = 'clsTREven' >")
            Response.Write("<TD align='right'>")
            Response.Write(MyBase.GetResourceString("COL_OWNER") + " :")
            Response.Write("</TD>")
            Response.Write("<TD>")
            Response.Write(strOwner)
            Response.Write("</TD>")
            Response.Write("</TR>")

        End If

        Response.Write("<TR Class = 'clsTREven' >")
        Response.Write("<TD align='right'>")
        Response.Write("Title : ") 'MyBase.GetResourceString("ENTER_SEARCH"))
        Response.Write("</TD>")
        Response.Write("<TD>")
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtTitle", "txtTitle", , 300, 100, strTitle, , , blnDisabled, , , , , True, True, , , EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        Response.Write("</TD>")
        Response.Write("</TR>")

        Response.Write("<TR Class = 'clsTREven' >")
        Response.Write("<TD align='Right' valign='Top' >")
        Response.Write("Description : ") 'MyBase.GetResourceString("ENTER_SEARCH"))
        Response.Write("</TD>")
        Response.Write("<TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'Response.Write(CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmEWF_ExpenseSheet", , , 300, 80, 1000, strDescription, , , blnDisabled, , , , " valign='top' ", , True))
        Response.Write(CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmEWF_ExpenseSheet", , , 300, 80, 1000, strDescription, , , blnDisabled, , , , " valign='top' ", , True, EnableHTMLEncode:=True))
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        Response.Write("</TD>")
        Response.Write("</TR>")

        ' to show the check boxes for Verified By Admin , Verified By Finance 

        If m_blnAdminVerifier = True Then

            If m_Mode.ToUpper = "EDIT" Then
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ''strSQL = "SELECT  IsNull(IsAdminVerfied ,0)  FROM  tbl_PM_ExpenseSheet WHERE ExpenseSheetID = " + m_strExpenseSheetID
                strSQL = "usp_sel_tbl_PM_ExpenseSheet_IsAdminVerfied " + m_strExpenseSheetID
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                m_blnIsAdminVerfied = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), Boolean)
            End If

            Response.Write("<TR Class = 'clsTREven' >")
            Response.Write("<TD>")
            Response.Write(MyBase.GetResourceString("VERIFIED_BY_ADMIN")) 'MyBase.GetResourceString("ENTER_SEARCH"))
            Response.Write("</TD>")
            Response.Write("<TD>")
            Response.Write(CommonFunction.HTMLControls.DrawCheckBox("ChkAdminVerified", "ChkAdminVerified", , m_blnIsAdminVerfied, m_strExpenseSheetID, m_blnIsAdminVerfied, , True))
            Response.Write("</TD>")
            Response.Write("</TR>")
        End If

        If m_blnFinanceVerifier = True Then

            If m_Mode.ToUpper = "EDIT" Then
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ''strSQL = "SELECT  ISNull(IsFinanceVerified,0) FROM  tbl_PM_ExpenseSheet WHERE ExpenseSheetID = " + m_strExpenseSheetID
                strSQL = "usp_sel_tbl_PM_ExpenseSheet_IsFinanceVerified " + m_strExpenseSheetID
                ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                m_blnIsFinanceVerified = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), Boolean)
            End If

            Response.Write("<TR Class = 'clsTREven' >")
            Response.Write("<TD>")
            Response.Write(MyBase.GetResourceString("VERIFIED_BY_FINANCE")) 'MyBase.GetResourceString("ENTER_SEARCH"))
            Response.Write("</TD>")
            Response.Write("<TD>")
            Response.Write(CommonFunction.HTMLControls.DrawCheckBox("ChkFinanceVerified", "ChkFinanceVerified", , m_blnIsFinanceVerified, m_strExpenseSheetID, m_blnIsFinanceVerified, , True))
            Response.Write("</TD>")
            Response.Write("</TR>")
        End If

        'ShraddhaM
        ' Dim m_strPKToken_Expense_Entry As String
        'm_strPKToken_Expense_Entry = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpensesEntryID"), String) + CType(Session("intUserID"), String) + "0" + CType(m_lngTagId, String))
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strPKToken_Expense_Sheet, , , , , , , , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'ShraddhaM

        Response.Write("</Table>")

        Response.Write("<BR>")

    End Sub


    Public Sub getQueryStringParameter()
        '=====================================================================
        ' Procedure Name        : getQueryStringParameter()
        ' Purpose               : To store the query string parameter and to Update the Variables 
        '                         used for Showing or hiding links for Finance Approver
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : Jun 1 , 2005 
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim objDr As IDataReader

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpenseSheetID"), "") <> "" Then
            m_strExpenseSheetID = HttpContext.Current.Request.QueryString("ExpenseSheetID")
        Else
            m_strExpenseSheetID = ""
        End If

        If HttpContext.Current.Request.QueryString("Actor") <> "" Then
            m_lngActor = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Actor"), ""), Long)
        End If

        If HttpContext.Current.Request.QueryString("Mode") <> "" Then
            m_Mode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "")
        End If

        If Request.Form("txtCommand") <> "" Then
            m_lngAction = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtCommand"), "0"), Long)
        End If

        m_strSessionUserID = CType(Session("intUserID"), String)
        m_strSessionPostID = CType(Session("intPostID"), String)

        ' Get whether the Finance Approver is having rights the approve the Expense Entries 
        If m_lngActor = 3 Then

            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''strSQL = "SELECT FPCenterDetailsID FROM tbl_CNF_FinanceProcessingCenter_Details WHERE EmployeeID = " + m_strSessionUserID
            strSQL = "usp_sel_tbl_CNF_FinanceProcessingCenter_Details " + m_strSessionUserID
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query

            objDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                'm_blnAdminVerifier = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("AdminVerifier"), "0"), "0"), Boolean)
                'm_blnFinanceVerifier = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("FinanceVerifier"), "0"), "0"), Boolean)
                'm_blnFinanceApprover = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("FinanceApprover"), "0"), "0"), Boolean)

                m_blnAdminVerifier = False
                m_blnFinanceVerifier = False
                m_blnFinanceApprover = True
            Else
                m_blnAdminVerifier = False
                m_blnFinanceVerifier = False
                m_blnFinanceApprover = False
            End If

            CommonFunction.Data.DisposeDataReader(objDr)

            If m_Mode.ToUpper = "EDIT" Then
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ''strSQL = "SELECT  IsNull(IsAdminVerfied ,0)  FROM  tbl_PM_ExpenseSheet WHERE ExpenseSheetID = " + m_strExpenseSheetID
                strSQL = "usp_sel_tbl_PM_ExpenseSheet_IsAdminVerfied " + m_strExpenseSheetID
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                m_blnIsAdminVerfied = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), Boolean)
            End If


            If m_Mode.ToUpper = "EDIT" Then
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ''strSQL = "SELECT  ISNull(IsFinanceVerified,0) FROM  tbl_PM_ExpenseSheet WHERE ExpenseSheetID = " + m_strExpenseSheetID
                strSQL = "usp_sel_tbl_PM_ExpenseSheet_IsFinanceVerified " + m_strExpenseSheetID
                ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                m_blnIsFinanceVerified = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), Boolean)
            End If

        End If

        'Added By HarshK on 14 Apr 2006 for IssueID 3350
        'Added by PurvaJ on 24 April 2006 for whiziblesem 6 issue ID 2318 for expenses workflow 
        Dim strSelectedExpensesEntry As String

        Dim drExpenseEntry As IDataReader

        'strSelectedExpensesEntry = MyBase.GetFormValue("chkDelete")
        strSelectedExpensesEntry = MyBase.GetFormValue("chkSelect")
        'End Addtion PurvaJ

        'Modified by PurvaJ on 24 April 2006 for whiziblesem 6 issue ID 2318 for expenses workflow 

        'If m_strExpenseSheetID <> "" Then
        If strSelectedExpensesEntry <> "" And m_strExpenseSheetID <> "" Then
            Dim strSQL2 As String = "SELECT 1 FROM (select E.ExpensesEntryID,F.EmployeeID from tbl_PM_Expenses E LEFT JOIN tbl_CNF_FinanceProcessingCenter_Details F on F.FPCenterID = E.FPCenterID where expensesentryid in (" & strSelectedExpensesEntry & ")) as ApproverTable WHERE ApproverTable.EmployeeID IS NULL"
            'End modification PurvaJ
            'Dim strSQL2 As String = "SELECT 1 FROM (SELECT B.ExpensesEntryID, D.EmployeeID FROM tbl_PM_ExpenseSheet_Details A INNER JOIN  tbl_PM_Expenses B ON (A.ExpensesEntryID = B.ExpensesEntryID  AND A.ExpenseSheetID=" & m_strExpenseSheetID & " ) LEFT JOIN tbl_CNF_FinanceProcessingCenter_Details D ON (D.FPCenterID = B.FPCenterID)) as ApproverTable WHERE ApproverTable.EmployeeID IS NULL"
            m_blnFinanceApproverNotSet = CBool(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL2, MyBase.UseSQL), "0"))

            If m_blnFinanceApproverNotSet = True Then
                strSQL2 = ""
                strSQL2 = "Exec usp_sel_FinanceApprover_NotSet '" + strSelectedExpensesEntry.ToString + "'"
                drExpenseEntry = CommonFunction.Data.GetDataReader(strSQL2, MyBase.UseSQL)

                If drExpenseEntry.Read Then
                    strFinNotSetList = drExpenseEntry("FinNotSet").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drExpenseEntry)
                If Len(strFinNotSetList) > 0 Then
                    strFinNotSetList = Left(strFinNotSetList, Len(strFinNotSetList) - 1)
                End If
            End If
        Else
            m_blnFinanceApproverNotSet = False
        End If

        'End Added By HarshK on 14 Apr 2006 for IssueID 3350

        'Modified by PurvaJ on 24 April 2006 for whiziblesem 6 issue ID 2318 for expenses workflow 

        'If m_strExpenseSheetID <> "" Then
        If strSelectedExpensesEntry <> "" And m_strExpenseSheetID <> "" Then
            Dim strSQLQuery As String = "EXEC usp_sel_ReportingTo " + m_strExpenseSheetID + "," + CType(HttpContext.Current.Session("intUserID"), String)
            drEscaltedApprover = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drEscaltedApprover.Read Then
                If drEscaltedApprover("ReportingToID").ToString = "0" Then
                    m_blnEscaltedApproverNotSet = True
                Else
                    m_blnEscaltedApproverNotSet = False
                End If

            End If
            CommonFunction.Data.DisposeDataReader(drEscaltedApprover)
        Else
            m_blnEscaltedApproverNotSet = False
        End If

        'End Added By HarshK on 14 Apr 2006 for IssueID 3350
    End Sub
    Public Sub HandleModesAndActions()
        '=====================================================================
        ' Procedure Name        : HandleModesAndActions()	
        ' Purpose               : To Execute the appropriate Action 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SantoshP
        ' Created               : May 25, 2005 
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strSelectedExpensesEntry As String
        Dim strcommentsList As String = "'"
        Dim strComments As String
        Dim strSelectedExpenseEntryIds As String()
        Dim strExpenseEntryID As String

        Dim intResult As Integer

        strSelectedExpensesEntry = MyBase.GetFormValue("chkSelect")

        strSelectedExpenseEntryIds = Split(strSelectedExpensesEntry, ",")

        For Each strExpenseEntryID In strSelectedExpenseEntryIds

            'Modified  by PurvaJ on 18 April 2006  for whiziblesem 6 issue ID 2318 for expenses workflow            
            'strComments = MyBase.GetFormValue("txtComments" + strExpenseEntryID)
            strComments = Trim(Request.Form("txtComments" + strExpenseEntryID))
            'End Modification PurvaJ

            If strComments = "" Then strComments = " "
            strcommentsList += CommonFunction.General.BuildQueryString(strComments) + ":#:" + ""

        Next

        strcommentsList += "'"
        
        'ShraddhaM 3558
        ''added by RohiniK on 07 Sep 2006 for SA Issue : 3558 - Security Issue
        ''Purpose: for avoiding approve/reject/escalate invalid expense entries from edashboard -> Links
        ''code added by RohiniK on 04 Sep 2006 for SA ISsue:3588 - Security issue 
        Dim strValidExpensesQuery As String = ""
        If m_strSessionUserID <> "" And m_strExpenseSheetID <> "" Then
            'Code commneted and added by PrashantD on 12 Sept 2006 for Sierra Security patch
            'strValidExpensesQuery = "EXEC usp_Sel_CheckValidExpenseEntries " & m_strSessionUserID & ", " & m_strExpenseSheetID & ",'" & strSelectedExpensesEntry & ",'"
            strValidExpensesQuery = "EXEC usp_Sel_CheckValidExpenseEntries " & m_strSessionUserID & ", " & m_lngActor.ToString.Trim & "," & m_strExpenseSheetID & ",'" & strSelectedExpensesEntry & ",'"
            'End of  commnet and addition by PrashantD on 12 Sept 2006 for Sierra Security patch

            m_blnisValidExpenses = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strValidExpensesQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Boolean)
        End If
        ''End of code addition by RohiniK on 07 Sep 2006 for SA Issue : 3558 - Security Issue


        '''' Added By NageshM on date 27th jun 2005
        If m_Mode.ToUpper = "ADD" And m_lngAction <> 1 Then
            Call DisplayAlert()
        End If
        ''' End of addition By NageshM

        'ShraddhaM 3558
        If m_Mode.ToUpper = "ADD" Then
            'Added by JyotiG
            'Start_JG_7286_13-Nov-2006
            'Commented By JyotiG (11-Dec-2006)
            'Dim strPaymentSql As String
            'Dim strPaymentId As String
            'If strSelectedExpensesEntry <> "" Then
            '    strPaymentSql = "usp_sel_PendingPaymentMode_ExpenseEntry " & m_strSessionUserID & ",'" & strSelectedExpensesEntry & "',NULL"
            '    strPaymentId = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strPaymentSql, MyBase.UseSQL), "")
            '    If strPaymentId <> "" Then
            '        CommonFunction.General.WriteHTML("<SCRIPT Language=JavaScript>")
            '        CommonFunction.General.WriteHTML("alert('Mode of Payment is not set for ' + '" & strPaymentId & "' + ' expense entry.');")
            '        CommonFunction.General.WriteHTML("</Script>")
            '    End If
            'End If
            'End_JG_7286_13-Nov-2006
            'If strPaymentId = "" Then
            If strSelectedExpensesEntry <> "" And (m_lngAction = ActionIndex.Draft Or m_lngAction = ActionIndex.Submitted) Then

                strSQL = "usp_ins_tbl_PM_ExpenseSheet "
                strSQL += "N'" + MyBase.GetFormValue("txtTitle") + "' ,"
                strSQL += "N'" + MyBase.GetFormValue("txtDescription") + "' ,"
                strSQL += "'" + strSelectedExpensesEntry + "' , "
                strSQL += strcommentsList + ", "
                strSQL += m_strSessionUserID
                If m_lngAction = ActionIndex.Submitted Then
                    strSQL += ", 1 "
                End If

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)



                If m_lngAction = ActionIndex.Submitted Then

                    ' Get the New ExpenseSheetID  
                    strSQL = "usp_sel_NewlyCreated_ExpenseSheetID " + m_strSessionUserID + " , '" + strSelectedExpensesEntry + "'"
                    m_strExpenseSheetID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), "")

                    Call sendMail(m_lngAction, strSelectedExpensesEntry)
                End If

                CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                CommonFunction.General.WriteHTML("window.location.href=""../EWF/MyExpenseSheet_commonList.aspx?FromWhere=DT&MasterTagId=3593"";" + vbCrLf)
                CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
            End If
        End If
        'End If

        If m_Mode.ToUpper = "EDIT" Then

            If strSelectedExpensesEntry <> "" And m_lngAction = ActionIndex.Draft Then
                strSQL = "usp_upd_tbl_PM_ExpenseSheet_Draft "
                strSQL += m_strExpenseSheetID + ", "
                strSQL += "N'" + MyBase.GetFormValue("txtTitle") + "' ,"
                strSQL += "N'" + MyBase.GetFormValue("txtDescription") + "' ,"
                strSQL += "'" + strSelectedExpensesEntry + "' , "
                strSQL += strcommentsList + ", "
                strSQL += m_strSessionUserID


                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                CommonFunction.General.WriteHTML("		var objform=GetFormReference('frmEWF_ExpenseSheet');" + vbCrLf)
                CommonFunction.General.WriteHTML("frmEWF_ExpenseSheet.txtCommand.value=""0"";" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.action=window.location.href;" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.submit();" + vbCrLf)
                CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)

            End If

            ' Update Status as Submitted
            If strSelectedExpensesEntry <> "" And m_lngAction = ActionIndex.Submitted Then
                strSQL = "usp_upd_tbl_PM_ExpenseSheet_send_for_approval "
                strSQL += m_strExpenseSheetID + ", "
                strSQL += "N'" + MyBase.GetFormValue("txtTitle") + "' ,"
                strSQL += "N'" + MyBase.GetFormValue("txtDescription") + "' ,"
                strSQL += "'" + strSelectedExpensesEntry + "' , "
                strSQL += strcommentsList + ", "
                strSQL += m_strSessionUserID

                If m_lngAction = ActionIndex.Submitted Then
                    strSQL += ", 1 "
                End If

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                ' Send Mail To Approver 

                Call sendMail(m_lngAction, strSelectedExpensesEntry)

                CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                CommonFunction.General.WriteHTML("		var objform=GetFormReference('frmEWF_ExpenseSheet');" + vbCrLf)
                CommonFunction.General.WriteHTML("frmEWF_ExpenseSheet.txtCommand.value=""1"";" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.action=window.location.href;" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.submit();" + vbCrLf)
                CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)

            End If

            ' Set Expense Entries Status As Approved
            If strSelectedExpensesEntry <> "" And m_lngAction = ActionIndex.Approved Then
                'added by harshada d for whiziblesem 6 issue id 2318 expenses workflow on 25 April 2006
                ' if finance approver is not set for particular processing centre then the entries should not be approved

                If m_blnFinanceApproverNotSet = True Then
                    CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                    CommonFunction.General.WriteHTML("alert('Expense Entries with following IDs cannot be sent for Finance Approval as Finance Approver is not Set for them. IDs:" + strFinNotSetList + "');" + vbCrLf)
                    CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
                Else

                    'ShraddhaM 3558
                    If CheckApproverAccess() = False Then
                        'action to take on invalid login
                        Session.Abandon()
                        Response.Write("<script language=javascript>" & vbCrLf)
                        Response.Write("	window.open(""../../Default.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
                        Response.Write("</script>" & vbCrLf)
                        Response.End()

                        ''added by RohiniK on 07 Sep 2006 for SA Issue : 3558 - Security Issue
                        ''Purpose:  to check whether logged in user is Expense Approver 
                        ''          and Selected Expense Entries are valid and belong to the ExpenseSheet displayed
                    Else

                        If m_blnisValidExpenses = False Then
                            'action to take on invalid login
                            Session.Abandon()
                            Response.Write("<script language=javascript>" & vbCrLf)
                            Response.Write("	window.open(""../../Default.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
                            Response.Write("</script>" & vbCrLf)
                            Response.End()

                            'ShraddhaM 3558
                        Else
                            'end of addition by harshada d for whiziblesem 6 issue id 2318 expenses workflow on 25 April 2006
                            '' added by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 28 Jun 2006
                            '	'Added by PrajaktaR on 14th June 2006 for Bristlecone ReqNo5 
                            '                Dim strResourceTimesheets As String
                            '                Dim drResourceTimesheets As IDataReader

                            '                Dim strSQLUserID As String
                            '                Dim strEmployeeID As String

                            '                Dim strSQLUserName As String
                            '                Dim strEmployeeName As String

                            '                Dim m_blnNotApproved As Boolean = False

                            '                Dim m_strSessionUserID As String = CType(Session("intUserID"), String)
                            '                strSQLUserID = "SELECT EmployeeID FROM tbl_PM_ExpenseSheet WHERE ExpenseSheetID = " + m_strExpenseSheetID
                            '                strEmployeeID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLUserID, MyBase.UseSQL), "")

                            '                strSQLUserName = "SELECT EmployeeName FROM tbl_PM_ExpenseSheet , tbl_PM_Employee WHERE tbl_PM_ExpenseSheet.EmployeeID =  tbl_PM_Employee.EmployeeID AND  tbl_PM_ExpenseSheet.ExpenseSheetID = " + m_strExpenseSheetID
                            '                strEmployeeName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLUserName, MyBase.UseSQL), "")

                            '                strResourceTimesheets = "usp_sel_tbl_PM_ResourceTimesheet_Approval " + m_strSessionUserID + ", " + strEmployeeID
                            '                drResourceTimesheets = CommonFunctions.Data.GetDataReader(strResourceTimesheets, MyBase.UseSQL)
                            '                While drResourceTimesheets.Read
                            '                    If CType(drResourceTimesheets("StatusCode"), String) <> "V" And CType(drResourceTimesheets("StatusCode"), String) <> "J" Then
                            '                        m_blnNotApproved = True
                            '                    End If
                            '                End While
                            '                If m_blnNotApproved = True Then
                            '                    CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                            '                    CommonFunction.General.WriteHTML("alert('There are ResourceTimesheets for \'" + strEmployeeName + "\' which are Not Approved');" + vbCrLf)
                            '                    CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
                            '                End If
                            '      	         'END Of Addition by PrajaktaR on 14th June 2006 for Bristlecone ReqNo5 
                            '        		' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for Expenses Weekly View Enhancements 28 Jun 2006
                            strSQL = "usp_upd_tbl_PM_ExpenseEntry_Approved "
                            strSQL += m_strExpenseSheetID + ", "
                            strSQL += "'" + strSelectedExpensesEntry + "' , "
                            strSQL += strcommentsList + ", "
                            strSQL += m_strSessionUserID + ","
                            strSQL += CType(m_lngActor, String)

                            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                            ' Send Mail To Approver 

                            Call sendMail(m_lngAction, strSelectedExpensesEntry)

                            ' if the Expensesheet is Approved then send mail to Finance 
                            If m_strExpenseSheetID <> "" Then
                                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                                '' strSQL = "SELECT UPPER(Status) FROM tbl_PM_ExpenseSheet_status WHERE ExpenseSheetID = " + m_strExpenseSheetID
                                strSQL = "usp_sel_tbl_PM_ExpenseSheet_status " + m_strExpenseSheetID
                                ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                                m_strExpenseSheetStatus = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), String)
                            Else
                                m_strExpenseSheetStatus = ""
                            End If

                            If m_strExpenseSheetStatus = m_strActionApproved.ToUpper Then

                                Call sendMail(10, strSelectedExpensesEntry)
                            End If

                            CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                            CommonFunction.General.WriteHTML("		var objform=GetFormReference('frmEWF_ExpenseSheet');" + vbCrLf)
                            CommonFunction.General.WriteHTML("frmEWF_ExpenseSheet.txtCommand.value=""4"";" + vbCrLf)
                            CommonFunction.General.WriteHTML("objform.action=window.location.href;" + vbCrLf)
                            CommonFunction.General.WriteHTML("objform.submit();" + vbCrLf)
                            CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
                            'harshadaa
                        End If
                    End If
                    'harshada
                End If
            End If

            ' Set Expense Entries Status As Rejected
            If strSelectedExpensesEntry <> "" And m_lngAction = ActionIndex.Rejected Then

                'ShraddhaM 3558
                'Added by ShamkantD - 1-Sep-2006
                'For issue 3558 - Expense Security patch
                If CheckApproverAccess() = False Then
                    'action to take on invalid login
                    Session.Abandon()
                    Response.Write("<script language=javascript>" & vbCrLf)
                    Response.Write("	window.open(""../../Default.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
                    Response.Write("</script>" & vbCrLf)
                    Response.End()

                    ''added by RohiniK on 07 Sep 2006 for SA Issue : 3558 - Security Issue
                    ''Purpose:  to check whether logged in user is Expense Approver 
                    ''          and Selected Expense Entries are valid and belong to the ExpenseSheet displayed
                Else

                    If m_blnisValidExpenses = False Then
                        'action to take on invalid login
                        Session.Abandon()
                        Response.Write("<script language=javascript>" & vbCrLf)
                        Response.Write("	window.open(""../../Default.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
                        Response.Write("</script>" & vbCrLf)
                        Response.End()

                    Else


                        'ShraddhaM 3558
                        strSQL = "usp_upd_tbl_PM_ExpenseEntry_Rejected "
                        strSQL += m_strExpenseSheetID + ", "
                        strSQL += "'" + strSelectedExpensesEntry + "' , "
                        strSQL += strcommentsList + ", "
                        strSQL += m_strSessionUserID

                        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                        ' Send Mail To Approver 

                        Call sendMail(m_lngAction, strSelectedExpensesEntry)


                        CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                        CommonFunction.General.WriteHTML("		var objform=GetFormReference('frmEWF_ExpenseSheet');" + vbCrLf)
                        CommonFunction.General.WriteHTML("frmEWF_ExpenseSheet.txtCommand.value=""4"";" + vbCrLf)
                        CommonFunction.General.WriteHTML("objform.action=window.location.href;" + vbCrLf)
                        CommonFunction.General.WriteHTML("objform.submit();" + vbCrLf)
                        CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)

                    End If
                End If
            End If

            ' set Expense Entries Status is Resubmitted 
            If strSelectedExpensesEntry <> "" And m_lngAction = ActionIndex.Resubmitted Then

                strSQL = "usp_upd_tbl_PM_ExpenseSheet_Resubmitted  "
                strSQL += m_strExpenseSheetID + ", "
                strSQL += "'" + strSelectedExpensesEntry + "' , "
                strSQL += strcommentsList + ", "
                strSQL += m_strSessionUserID

                'CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                intResult = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0"), Integer)

                If intResult = 0 Then

                    Dim strquery As String

                    Dim StrUserID As String
                    Dim strOutput As String
                    strquery = "usp_get_Pending_Expense_Entries_Resubmitted " + m_strSessionUserID + "," + m_strExpenseSheetID
                    strOutput = CType(CommonFunctions.Data.CheckIsDBNull(CType(CommonFunction.Data.GetDataScalar(strquery, MyBase.UseSQL), String), "0"), String)

                    '***  Added by TinaB for Removing the alert when Projectname is Blank - 21st Sept 2005
                    If strOutput.ToUpper <> "PROJECTNAME(S) :" Then
                        If strOutput.ToString.Trim <> "" Then

                            CommonFunction.General.WriteHTML("<SCRIPT Language=JavaScript>")
                            CommonFunction.General.WriteHTML("alert('" & MyBase.GetResourceString("APPROVE_ENTRY_RESUBMIT") & " ' + ' " & strOutput & " ');")
                            CommonFunction.General.WriteHTML("</Script>")
                        End If
                    End If

                Else

                    ' Send Mail To Approver 
                    Call sendMail(m_lngAction, strSelectedExpensesEntry)


                    CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                    CommonFunction.General.WriteHTML("		var objform=GetFormReference('frmEWF_ExpenseSheet');" + vbCrLf)
                    CommonFunction.General.WriteHTML("frmEWF_ExpenseSheet.txtCommand.value=""8"";" + vbCrLf)
                    CommonFunction.General.WriteHTML("objform.action=window.location.href;" + vbCrLf)
                    CommonFunction.General.WriteHTML("objform.submit();" + vbCrLf)
                    CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)

                End If


            End If

            ' Set the EXpense Entry As Escalated 
            If strSelectedExpensesEntry <> "" And m_lngAction = ActionIndex.Escalated Then
                'If m_blnEscaltedApproverNotSet = True Then
                ' CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                ' CommonFunction.General.WriteHTML("alert('Selected Expense Entries cannot be escalted as Escalted Approver is not Set');" + vbCrLf)
                ' CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
                'ShraddhaM 3558

                'Added by ShamkantD - 1-Sep-2006 
                'For issue 3558 - Expense Security patch
                If CheckApproverAccess() = False Then
                    'action to take on invalid login
                    Session.Abandon()
                    Response.Write("<script language=javascript>" & vbCrLf)
                    Response.Write("	window.open(""../../Default.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
                    Response.Write("</script>" & vbCrLf)
                    Response.End()

                    ''added by RohiniK on 07 Sep 2006 for SA Issue : 3558 - Security Issue
                    ''Purpose:  to check whether logged in user is Expense Approver 
                    ''          and Selected Expense Entries are valid and belong to the ExpenseSheet displayed
                Else

                    If m_blnisValidExpenses = False Then
                        'action to take on invalid login
                        Session.Abandon()
                        Response.Write("<script language=javascript>" & vbCrLf)
                        Response.Write("	window.open(""../../Default.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
                        Response.Write("</script>" & vbCrLf)
                        Response.End()




                        'ShraddhaM 3558

                    Else
                        strSQL = "usp_upd_tbl_PM_ExpenseEntry_Escalated  "
                        strSQL += m_strExpenseSheetID + ", "
                        strSQL += "'" + strSelectedExpensesEntry + "' , "
                        strSQL += strcommentsList + ", "
                        strSQL += m_strSessionUserID + ","
                        strSQL += CType(m_lngActor, String)

                        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                        ' Send Mail To Escalated Approver 

                        Call sendMail(m_lngAction, strSelectedExpensesEntry)


                        CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                        CommonFunction.General.WriteHTML("		var objform=GetFormReference('frmEWF_ExpenseSheet');" + vbCrLf)
                        CommonFunction.General.WriteHTML("frmEWF_ExpenseSheet.txtCommand.value=""4"";" + vbCrLf)
                        CommonFunction.General.WriteHTML("objform.action=window.location.href;" + vbCrLf)
                        CommonFunction.General.WriteHTML("objform.submit();" + vbCrLf)
                        CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
                    End If
                End If
            End If

            ' If the Expenese Entry Is Disowned then Update the Status 
            If strSelectedExpensesEntry <> "" And m_lngAction = ActionIndex.Disowned Then
                strSQL = "usp_upd_tbl_PM_ExpenseEntry_Disowned  "
                strSQL += m_strExpenseSheetID + ", "
                strSQL += "'" + strSelectedExpensesEntry + "' , "
                strSQL += strcommentsList + ", "
                strSQL += m_strSessionUserID

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                ' Send Mail To Approver who has escalated the Request

                Call sendMail(m_lngAction, strSelectedExpensesEntry)


                CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                CommonFunction.General.WriteHTML("		var objform=GetFormReference('frmEWF_ExpenseSheet');" + vbCrLf)
                CommonFunction.General.WriteHTML("frmEWF_ExpenseSheet.txtCommand.value=""5"";" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.action=window.location.href;" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.submit();" + vbCrLf)
                CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
            End If

            ' If Expense Entry Is Approved By Finance then Updat the status 
            If strSelectedExpensesEntry <> "" And m_lngAction = ActionIndex.FinanceApproved Then
                'ShraddhaM 3558

                'Added by ShamkantD - 1-Sep-2006
                'For issue 3558 - Expense Security patch
                If CheckApproverAccess() = False Then
                    'action to take on invalid login
                    Session.Abandon()
                    Response.Write("<script language=javascript>" & vbCrLf)
                    Response.Write("	window.open(""../../Default.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
                    Response.Write("</script>" & vbCrLf)

                    Response.End()

                    ''added by RohiniK on 07 Sep 2006 for SA Issue : 3558 - Security Issue
                    ''Purpose:  to check whether logged in user is Expense Approver 
                    ''          and Selected Expense Entries are valid and belong to the ExpenseSheet displayed
                Else

                    If m_blnisValidExpenses = False Then
                        'action to take on invalid login
                        Session.Abandon()
                        Response.Write("<script language=javascript>" & vbCrLf)
                        Response.Write("	window.open(""../../Default.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
                        Response.Write("</script>" & vbCrLf)
                        Response.End()

                    Else


                        'ShraddhaM 3558

                        strSQL = "usp_upd_tbl_PM_ExpenseEntry_FinanceApproved  "
                        strSQL += m_strExpenseSheetID + ", "
                        strSQL += "'" + strSelectedExpensesEntry + "' , "
                        strSQL += strcommentsList + ", "
                        strSQL += m_strSessionUserID

                        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                        ' Send Mail To Approver who has escalated the Request

                        Call sendMail(m_lngAction, strSelectedExpensesEntry)

                        CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                        CommonFunction.General.WriteHTML("		var objform=GetFormReference('frmEWF_ExpenseSheet');" + vbCrLf)
                        CommonFunction.General.WriteHTML("frmEWF_ExpenseSheet.txtCommand.value=""6"";" + vbCrLf)
                        CommonFunction.General.WriteHTML("objform.action=window.location.href;" + vbCrLf)
                        CommonFunction.General.WriteHTML("objform.submit();" + vbCrLf)
                        CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
                    End If
                End If
            End If

            ' If Expense Entry Is Approved By Finance then Update the status as RejectedByFinance
            If strSelectedExpensesEntry <> "" And m_lngAction = ActionIndex.FinanceRejected Then
                strSQL = "usp_upd_tbl_PM_ExpenseEntry_FinanceRejected  "
                strSQL += m_strExpenseSheetID + ", "
                strSQL += "'" + strSelectedExpensesEntry + "' , "
                strSQL += strcommentsList + ", "
                strSQL += m_strSessionUserID

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                ' Send Mail To Approver who has escalated the Request

                Call sendMail(m_lngAction, strSelectedExpensesEntry)

                CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                CommonFunction.General.WriteHTML("		var objform=GetFormReference('frmEWF_ExpenseSheet');" + vbCrLf)
                CommonFunction.General.WriteHTML("frmEWF_ExpenseSheet.txtCommand.value=""7"";" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.action=window.location.href;" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.submit();" + vbCrLf)
                CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
            End If


            If m_lngAction = ActionIndex.AdminVerified Then
                strSQL = " UPDATE tbl_PM_ExpenseSheet SET IsAdminVerfied = 1  WHERE ExpenseSheetID = " + m_strExpenseSheetID
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                CommonFunction.General.WriteHTML("		var objform=GetFormReference('frmEWF_ExpenseSheet');" + vbCrLf)
                CommonFunction.General.WriteHTML("frmEWF_ExpenseSheet.txtCommand.value=""-1"";" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.action=window.location.href;" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.submit();" + vbCrLf)
                CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
            End If

            If m_lngAction = ActionIndex.FinanceVerified Then
                strSQL = " UPDATE tbl_PM_ExpenseSheet SET IsFinanceVerified = 1  WHERE ExpenseSheetID = " + m_strExpenseSheetID
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                CommonFunction.General.WriteHTML("		var objform=GetFormReference('frmEWF_ExpenseSheet');" + vbCrLf)
                CommonFunction.General.WriteHTML("frmEWF_ExpenseSheet.txtCommand.value=""-1"";" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.action=window.location.href;" + vbCrLf)
                CommonFunction.General.WriteHTML("objform.submit();" + vbCrLf)
                CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)

            End If

        End If

    End Sub

    Private Sub sendMail(ByVal Action As Long, ByVal strExpenseEntryIDList As String)
        '=====================================================================
        ' Procedure Name        : sendMail()	
        ' Purpose               : To send Mail to the appropriate Person 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS 
        ' Created               : Jun 7, 2005 
        ' Revisions             :
        '=====================================================================
        Dim lngMessageID As Long
        Dim blnShowPopUp As Boolean
        Dim blnSendMail As Boolean
        Dim strMessage As String
        Dim objMailDr As IDataReader
        Dim strToEmailId As String
        Dim strFromEmailId As String
        Dim strCCToEmailId As String
        Dim strSubject As String
        Dim strMailBody As String

        Select Case Action
            Case ActionIndex.Submitted
                lngMessageID = 460
            Case ActionIndex.Approved
                lngMessageID = 466
            Case ActionIndex.Rejected
                lngMessageID = 467
            Case ActionIndex.Escalated
                lngMessageID = 462
            Case ActionIndex.Disowned
                lngMessageID = 463
            Case ActionIndex.FinanceApproved
                lngMessageID = 461
            Case ActionIndex.FinanceRejected
                lngMessageID = 464
            Case ActionIndex.Resubmitted
                lngMessageID = 460
            Case 10 ' if the expensesheet is approved then send mail to finance
                lngMessageID = 465
        End Select


        strMessage = "usp_Sel_tbl_PM_EmailMessages " + lngMessageID.ToString
        objMailDr = CommonFunction.Data.GetDataReader(strMessage, MyBase.UseSQL)

        If objMailDr.Read Then
            blnSendMail = CType(CommonFunction.Data.CheckIsDBNull(objMailDr("SendMail"), "0"), Boolean)
            blnShowPopUp = CType(CommonFunction.Data.CheckIsDBNull(objMailDr("ShowPopup"), "0"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(objMailDr)
        If blnSendMail = True Then
            If blnShowPopUp = True Then

                CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                CommonFunction.General.WriteHTML(" window.open(""../General/SendEmail.aspx?MessageID=" + lngMessageID.ToString + "&ExpenseSheetID=" + m_strExpenseSheetID + "&ExpenseEntryIDList=" + CommonFunction.General.BuildQueryString(strExpenseEntryIDList) + """, """", ""resizable=no,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
            Else
                Select Case Action
                    Case ActionIndex.Submitted
                        CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_460(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), strExpenseEntryIDList)
                    Case ActionIndex.Approved
                        CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_466(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), strExpenseEntryIDList)
                    Case ActionIndex.Rejected
                        CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_467(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), strExpenseEntryIDList)
                    Case ActionIndex.Escalated
                        CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_462(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), strExpenseEntryIDList)
                    Case ActionIndex.Disowned
                        CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_463(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), strExpenseEntryIDList)
                    Case ActionIndex.FinanceApproved
                        CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_461(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), strExpenseEntryIDList)
                    Case ActionIndex.FinanceRejected
                        CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_464(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), strExpenseEntryIDList)
                    Case 10
                        CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_465(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), strExpenseEntryIDList)
                End Select

                If strToEmailId <> "" Then
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strMailBody)
                End If

            End If
        End If



    End Sub
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
        ' Author                : SantoshP
        ' Created               : May 25, 2005 
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList  'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList  'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String   'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu

        'Use Resources Solution

        ' If Actor is OWNER and Expense Sheet is not Submitted then show the Add Expense Entry Link 
        ' added by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 28 Jun 2006
        arrMenuCaptionsList.Add("Print")
        arrMenuToolTipsList.Add("Print Expense Sheet")
        arrClientSideFunctionList.Add("Show_Report(" + m_lngReportID.ToString + ")")

        ' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for Expenses Weekly View Enhancements 28 Jun 2006
        If m_lngActor = ActorIndex.Owner And m_Mode.ToUpper = "EDIT" And m_strExpenseSheetStatus.ToUpper = m_strActionDraft.ToUpper Then

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ADD_EXPENSE_ENTRY"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ADD_EXPENSE_ENTRY"))
            arrClientSideFunctionList.Add("Add_ExpenseEntry('ExpenseSheetid')")

        End If

        If m_lngActor = ActorIndex.Owner Then

            If m_strExpenseSheetStatus = m_strActionDraft.ToUpper Or m_strExpenseSheetStatus = "" Then

                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_SUBMIT_FOR_APPROVAL"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_SUBMIT_FOR_APPROVAL"))
                arrClientSideFunctionList.Add("SaveAndSendForApproval()")

            End If

            If m_strExpenseSheetStatus = m_strActionRejected.ToUpper Then
                'Or m_strExpenseSheetStatus = m_strActionResubmitted.ToUpper Then

                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_RESUBMIT"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_RESUBMIT"))
                arrClientSideFunctionList.Add("SaveandResubmit()")

            End If

        End If

        If m_lngActor = ActorIndex.Owner And m_strExpenseSheetStatus = m_strActionDraft.ToUpper Or m_strExpenseSheetStatus = "" Then

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE_AS_DRAFT"))
            arrClientSideFunctionList.Add("Save_Onclick()")
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_AS_DRAFT"))

        End If

        If m_strExpenseSheetStatus.ToUpper <> "APPROVED" Or m_strExpenseSheetStatus.ToUpper <> "REJECTED" Then
            '    If m_strExpenseSheetStatus.ToUpper = m_strActionSubmitted.ToUpper Or m_strExpenseSheetStatus.ToUpper = m_strActionResubmitted.ToUpper Or m_strExpenseSheetStatus.ToUpper = m_strActionFinanceRejected.ToUpper Or m_strExpenseSheetStatus.ToUpper = m_strActionEscalated.ToUpper Then
            If m_lngActor = ActorIndex.Approver Or m_lngActor = ActorIndex.EscalatedApprover Then
                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_APPROVE"))
                arrClientSideFunctionList.Add("Approve_Onclick()")
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_APPROVE"))

                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_REJECT"))
                arrClientSideFunctionList.Add("Reject_Onclick()")
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_REJECT"))

                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ESCALATE"))
                arrClientSideFunctionList.Add("Escalate_Onclick()")
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ESCALATE"))
            End If

            If m_lngActor = ActorIndex.EscalatedApprover Then

                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISOWN"))
                arrClientSideFunctionList.Add("Disown_Onclick()")
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISOWN"))

            End If
        End If

        ' added by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 28 Jun 2006
        'If m_strExpenseSheetStatus.ToUpper <> "APPROVED" And m_strExpenseSheetStatus.ToUpper <> "REJECTED" Then
        '    If m_strExpenseSheetStatus.ToUpper <> "APPROVEDBYFINANCE" Then
        '        If m_lngActor = ActorIndex.Approver Or m_lngActor = ActorIndex.EscalatedApprover Then
        '            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_APPROVE"))
        '            arrClientSideFunctionList.Add("Approve_Onclick()")
        '            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_APPROVE"))

        '            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_REJECT"))
        '            arrClientSideFunctionList.Add("Reject_Onclick()")
        '            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_REJECT"))

        '            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ESCALATE"))
        '            arrClientSideFunctionList.Add("Escalate_Onclick()")
        '            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ESCALATE"))
        '        End If

        '        If m_lngActor = ActorIndex.EscalatedApprover Then

        '            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISOWN"))
        '            arrClientSideFunctionList.Add("Disown_Onclick()")
        '            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISOWN"))

        '        End If
        '    End If
        'ElseIf m_strExpenseSheetStatus.ToUpper <> "REJECTED" Then
        '    If m_lngActor = ActorIndex.Approver Or m_lngActor = ActorIndex.EscalatedApprover Then
        '        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_APPROVE"))
        '        arrClientSideFunctionList.Add("Approve_Onclick()")
        '        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_APPROVE"))

        '        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_REJECT"))
        '        arrClientSideFunctionList.Add("Reject_Onclick()")
        '        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_REJECT"))

        '        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ESCALATE"))
        '        arrClientSideFunctionList.Add("Escalate_Onclick()")
        '        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ESCALATE"))
        '    End If
        '    If m_lngActor = ActorIndex.EscalatedApprover Then

        '        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISOWN"))
        '        arrClientSideFunctionList.Add("Disown_Onclick()")
        '        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISOWN"))

        '    End If
        'ElseIf m_strExpenseSheetStatus.ToUpper <> "APPROVEDBYFINANCE" Then

        'End If
        ' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for Expenses Weekly View Enhancements 28 Jun 2006
        'If m_strExpenseSheetStatus.ToUpper = m_strActionDisowned.ToUpper Then
        '    If m_lngActor = ActorIndex.Approver Then
        '        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_APPROVE"))
        '        arrClientSideFunctionList.Add("Approve_Onclick()")
        '        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_APPROVE"))

        '        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_REJECT"))
        '        arrClientSideFunctionList.Add("Reject_Onclick()")
        '        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_REJECT"))

        '        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ESCALATE"))
        '        arrClientSideFunctionList.Add("Escalate_Onclick()")
        '        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ESCALATE"))
        '    End If
        'End If
        ' if the Logged in Person is Finance Approver allow him to approve or reject
        'If m_strExpenseSheetStatus.ToUpper <> "APPROVEDBYFINANCE" And m_strExpenseSheetStatus.ToUpper <> "REJECTEDBYFINANCE" Then
        '    If m_strExpenseSheetStatus.ToUpper = m_strActionApproved.ToUpper Then
        If m_lngActor = ActorIndex.FinanceApprover And m_blnFinanceApprover = True Then

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_FINANCE_APPROVE"))
            arrClientSideFunctionList.Add("FinacneApprove_Onclick()")
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_FINANCE_APPROVE"))

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_FINANCE_REJECT"))
            arrClientSideFunctionList.Add("FinacneReject_Onclick()")
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_FINANCE_REJECT"))

        End If
        'End If
        'if logged in person is AdminApprover allow him to update Addmin verfied flag 

        If m_lngActor = ActorIndex.FinanceApprover And m_blnAdminVerifier = True And m_blnIsAdminVerfied = False Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ADMIN_VERIFIED"))
            arrClientSideFunctionList.Add("AdminVerified_Onclick()")
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ADMIN_VERIFIED"))
        End If

        ' if Logged in Person is Finance Verifier then allow him to update Finance Verified 
        If m_lngActor = ActorIndex.FinanceApprover And m_blnFinanceVerifier = True And m_blnIsFinanceVerified = False Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_FINANCE_VERIFIED"))
            arrClientSideFunctionList.Add("FinanceVerified_Onclick()")
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_FINANCE_VERIFIED"))
        End If


        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))
        arrClientSideFunctionList.Add("SelectAll_OnClick('frmEWF_ExpenseSheet','chkSelect')")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL"))
        arrClientSideFunctionList.Add("ClearAll_OnClick('frmEWF_ExpenseSheet','chkSelect')")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL"))

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
        arrClientSideFunctionList.Add("Back_OnClick('" + m_lngActor.ToString + "')")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK"))

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrClientSideFunctionList.Add("Help_OnClick('3008')")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

    Private Sub DrawPageLegend()

        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

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
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub PlotControls()

        ' Code added by SwapnilR on 17th Oct 2006
        ' Purpose: add a one combobox for ExpenseSheetID and Previous and next link
        '           (PrashantSJ's code integration along with security patch)
        Dim strLeftSectionTitile As String = ""

        If m_lngActor = 1 Or m_lngActor = 2 Or m_lngActor = 3 Then

            strLeftSectionTitile = "Expense Sheet For : "
            strLeftSectionTitile += CommonFunctions.HTMLControls.DrawComboBox("cboExpenseSheetIDs", "usp_Sel_tbl_PM_ExpenseSheets_ExpenseSheetID '" & HttpContext.Current.Session("ExpenseSheetIDList").ToString & "'", 300, m_strExpenseSheetID.ToString, "onchange=""cboExpenseSheetID_OnChange()""", , True)

            strLeftSectionTitile += "<a style='TEXT-DECORATION:None' "
            strLeftSectionTitile += " href='javascript:Previous_OnClick()' ><Font Size=1 face=Arial;verdana color=black><B>|"
            strLeftSectionTitile += "<Font Size=1 face=Arial;verdana color=Black>&nbsp;<b id=lblThisMonth>"
            strLeftSectionTitile += "Previous" + "</font></b></font>"
            strLeftSectionTitile += "</a><Font Size=1 face=Arial;verdana color=black><B>"

            strLeftSectionTitile += "<a style='TEXT-DECORATION:None' "
            strLeftSectionTitile += " href='javascript:Next_OnClick()' ><Font Size=1 face=Arial;verdana color=black><B>|"
            strLeftSectionTitile += "<Font Size=1 face=Arial;verdana color=Black>&nbsp;<b id=lblAssignedTasks>"
            strLeftSectionTitile += "Next" + "</font></b></font>"
            strLeftSectionTitile += "</a><Font Size=1 face=Arial;verdana color=black><B>|"

            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION"), strLeftSectionTitile)
        Else
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION"))
        End If
        ' End of code addition by SwapnilR on 17th Oct 2006

        Response.Write("<br>")

        PlotSubControls()
        'If CommonFunction.General.IsClientBrowserIE Then
        '    CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='width:100%; Height:425px; overflow: auto;'>")
        'Else
        '    CommonFunctions.General.WriteHTML("<DIV id=""DivMain"" style=""height:450px; overflow: auto;"">")
        'End If

        'Modified By VarunA on 19-Mar-2008 RequestID-12099

        ''Commented and Added by Dhanashri S on 9 Dec 2015 for IssueID:2710
        ''CommonFunctions.General.WriteHTML("<DIV id='PageDiv' name='PageDiv' style='Overflow:auto;width:100%;Height:255;'>")
        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' name='PageDiv' style='Overflow:auto;width:100%;'>")
        ''End of Comment and Addition by Dhanashri S on 9 Dec 2015

        'CommonFunctions.General.WriteHTML("<DIV id='PageDiv' name='PageDiv' style='Overflow:auto;width:100%;Height:450;'>")
        DrawGrid()
        CommonFunction.General.WriteHTML("</DIV>")
        'End By VarunA on 19-Mar-2008 RequestID-12099

    End Sub

    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()	
        ' Purpose               : This procedure actually plots the grid on the Page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Santosh Pawar
        ' Created               : 25 May 2005
        ' Revisions             : 1.0
        '=====================================================================
        Dim drDailyActivity As IDataReader
        Dim strSQL As String
        Dim arrColumnHeadingList As New ArrayList 'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        'Dim arrCheckBox() As String = {"", "", "", "", "", "", "", "chkApprove", "chkReject", "chkEscalate", "chkDisown", "chkDelete"}

        'Dim arrCheckBox() As String = {"", "", "", "", "", "", "", "", "", "chkDelete"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "", "", "", "chkSelect"}

        'Dim arrGrouping() As String = {"16"}
        Dim arrGroupColumnNames As New ArrayList

        Dim arrIgnoreHTMLEncode() As String = {"0"}
        Dim arrWidthArray() As String = {"style='width:0%'", _
                 "style='width:5%'", _
                 "style='width:15%'", _
                 "style='width:10%'", _
                 "style='width:25%'", _
                 "style='width:10%'  align=right", _
                 "style='width:5%'  align=left", _
                 "style='width:10%'", _
                 "style='width:10%' valign='top' align=Left", _
                 "style='width:5%' valign='top' align=left"} ', _
        '"style='width:5%' align=center", _
        '"align=center", _
        '"align=center", _
        '"align=center", _
        '"align=center"}

        Dim arrColRowLinks() As String = {"", "", "Edit_OnClick(ExpensesEntryID,EntryDate)", "", "", ""}
        '"ShowDiscussions_OnClick(ExpensesEntryID)"

        'Dim arrIgnoreHTMLEncode() As String = {"", "1", "", "", "", "", "", ""}


        strSQL = " usp_Sel_tbl_PM_Expenses_ForExpenseSheet " & CType(HttpContext.Current.Session("intUserID"), String)

        If m_strExpenseSheetID <> "" Then
            strSQL += " , " + m_strExpenseSheetID
        Else
            strSQL += " , Null "
        End If
        If m_lngActor <> -1 Then
            strSQL += " , '" + m_lngActor.ToString + "' "
        Else
            strSQL += " , Null"
        End If


        'TODO: Read from Resource FilearrColumnHeadingList.Add(MyBase.GetResourceString("PROJECT_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_PROJECT"))
        'arrColumnHeadingList.Add("<IMG border=0 src='../../Images/Discussions.gif'>")
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_EXPENSE_ENTRYID"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_ENTRY_DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_COST_HEAD"))
        'arrColumnHeadingList.Add(MyBase.GetResourceString("COL_STATUS"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("DESCRIPTION"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_AMOUNT"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("CURRENCYSYMBOL"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_COMMENTS"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_STATUS"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_SELECT"))

        arrActualColumnNames.Add("ProjectName")
        'arrActualColumnNames.Add("Discussion")
        arrActualColumnNames.Add("ExpensesEntryID")
        arrActualColumnNames.Add("EntryDate")
        arrActualColumnNames.Add("CostHead")
        'arrActualColumnNames.Add("Status")
        arrActualColumnNames.Add("Description")
        arrActualColumnNames.Add("Amount")
        arrActualColumnNames.Add("CurrencySymbol")
        arrActualColumnNames.Add("Comments")
        arrActualColumnNames.Add("Status")

        arrGroupColumnNames.Add("Project Name")

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            '.GroupOnColumn = arrGrouping
            .GroupOnColumn = GetArray(arrGroupColumnNames)
            .NoOfDataColumns = 9
            .TDStyleArray = arrWidthArray
            '.IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .CheckBoxIDArray = arrCheckBox
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            'Modified By HarshK on 14 Apr 2006 for issueID 3345
            .DIVHeight = 250
            'End Modified By HarshK on 14 Apr 2006 for issueID 3345
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

    Private Sub DrawPageHeader()
        '=====================================================================
        ' Procedure Name        : DrawPageHeader()
        ' Purpose               : This procedure actually plots Page Header 

        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 25 May 2005
        ' Revisions             : 1.0
        '=====================================================================
        Dim strSQL As String
        Dim StrStatus As String = ""
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        Dim strHTML As String

        strSQL = "usp_sel_ExpenseSheet_Status_For_LoggedInUser " + m_strExpenseSheetID + ", " + m_strSessionUserID + " , " + m_lngActor.ToString
        m_strExpenseSheetStatus_for_User = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), "")
        cObjSectionTitle.GetSectionTitle("", "", "", , "Status : " + m_strExpenseSheetStatus_for_User, , , , , , , , False, False)

    End Sub


#End Region

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.EWF_ExpenseSheet", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        '' added by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 28 Jun 2006
        'Call getQueryStringParameter()
        'Call GetGlobalObject()
        '' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for Expenses Weekly View Enhancements 28 Jun 2006

        ''AbhijitD 09-Dec-05- Added following code to check valid login for approvers
        'If m_lngActor = 1 Or m_lngActor = 2 Then
        '    If CheckApproverAccess() = False Then
        '        'action to take on invalid login
        '        Session.Abandon()
        '        Response.Write("<script language=javascript>" & vbCrLf)
        '        Response.Write("	window.open(""../../Default.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
        '        Response.Write("</script>" & vbCrLf)
        '        Response.End()
        '    End If
        'End If

        Call getQueryStringParameter()
        Call GetGlobalObject()

        'AbhijitD 09-Dec-05- Added following code to check valid login for approvers

        ''commented and added by RohiniK on 11 Sept 2006
        'If m_lngActor = 1 Or m_lngActor = 2 Then
        If m_lngActor = 0 Or m_lngActor = 1 Or m_lngActor = 2 Or m_lngActor = 3 Then
            If m_strExpenseSheetID <> "" Then
                If CheckApproverAccess() = False Then
                    'action to take on invalid login
                    Session.Abandon()
                    Response.Write("<script language=javascript>" & vbCrLf)
                    Response.Write("	window.open(""../../Default.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
                    Response.Write("</script>" & vbCrLf)
                    Response.End()
                End If
            End If
        End If
        'End of addition by AbhijitD
        'm_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE")
    End Sub

    'AbhijitD 09-Dec-05- Added following code to check valid login for approvers
    Private Function CheckApproverAccess() As Boolean

        Dim drAccess As IDataReader
        Dim strQuery As String

        'If m_lngActor = 1 Then
        '    strQuery = "SELECT ExpenseSheetID FROM v_tbl_PM_ExpenseSheet_ExpenseSheets_for_Approval "
        '    strQuery &= "WHERE ExpenseSheetID=" & m_strExpenseSheetID & " AND EmployeeID=" & m_objGlobal.UserID

        'ElseIf m_lngActor = 2 Then
        '    strQuery = "SELECT FPCenterDetailsID FROM v_tbl_CNF_FinanceProcessingCenter_Details "
        '    strQuery &= "WHERE EmployeeID=" & m_objGlobal.UserID

        'End If

        Dim strSql As String
        Dim strCount As String
        Dim blnResult As Boolean
        strSql = "USP_GET_Valid_ExpenseSheetApprover " & m_strExpenseSheetID & "," & m_objGlobal.UserID & "," & m_lngActor & ""
        strCount = CType(CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL), String)

        If strCount = "1" Then
            blnResult = True
            CheckApproverAccess = blnResult
        Else
            blnResult = False
            CheckApproverAccess = blnResult
        End If

        CommonFunctions.Data.DisposeDataReader(drAccess)

        'drAccess = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        'CheckApproverAccess = drAccess.Read
        'CommonFunctions.Data.DisposeDataReader(drAccess)
    End Function
    'End of addition by AbhijitD

    Public Sub CheckRoleAccess()

        Dim drAccess As IDataReader
        Dim strQuery As String

        'Check if Project is Selected
        If Not CType(Session("intProjectID"), String) = "" Then
            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " + CType(m_intTagID, String) + "," + CType(Session("intPostID"), String) + "," + CType(Session("intUserID"), String) + ",'" + CType(Session("LoginType"), String) + "'," + CType(Session("intProjectID"), String)
        Else
            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " + CType(m_intTagID, String) + "," + CType(Session("intPostID"), String) + "," + CType(Session("intUserID"), String) + ",'" + CType(Session("LoginType"), String) + "'"
        End If

        '##### Get the Default Approver
        drAccess = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drAccess.Read Then
            m_intAccessAdd = CType(CommonFunctions.Data.CheckIsDBNull(drAccess("A"), "0"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drAccess)
        '##### End 



    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        Dim ExpenseEntryID As String
        Dim strDisable As String = ""
        Dim strChecked As String = ""
        Dim strApproved As String
        Dim strRejected As String
        Dim strEscalated As String
        Dim strDisowned As String
        Dim strStatus As String
        'Modified By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197
        'Edit_OnClick(ExpensesEntryID,EntryDate)
        If Args.ColumnName.ToUpper = "DATE" Then
            Cancel = True
            m_strPKToken_Expense_Sheet = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpensesEntryID"), String) + CType(Session("intUserID"), String) + "0" + CType(m_lngTagId, String))

            Args.StringToBeInserted = "<TD vAlign=top Title='Task Name' style='width=225' nowrap;>" _
                                             & "<A href=""JavaScript:Edit_OnClick('" & CType(Args.DataReader("ExpensesEntryID"), String) & "','" & CType(Args.DataReader("EntryDate"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_strPKToken_Expense_Sheet) & "')"">"
            Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Args.DataReader("EntryDate").ToString) & "</A></TD>"

            Args.ApplyHTMLEncode = False
        End If
        'Ended By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197
        ExpenseEntryID = CType(Args.DataReader("ExpensesEntryID"), String)

        strStatus = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ActualStatus"), ""), ""), String).ToUpper

        If Args.ColumnName.ToUpper = "DESCRIPTION" Then
            Args.ApplyHTMLEncode = False
            'Args.DataFieldValue = "<PRE><FONT face='Verdana, Arial'>" & Server.HtmlEncode(Args.DataFieldValue.ToString) & "</FONT></PRE>"
            Args.DataFieldValue = "<P><FONT face='Verdana, Arial'>" & Server.HtmlEncode(Args.DataFieldValue.ToString) & "</FONT></P>"

        ElseIf Args.ColumnName.ToUpper = "SELECT" Then

            Args.IsCheckBoxChecked = True

            Select Case m_lngActor

                Case ActorIndex.Owner

                    If strStatus = "" Or strStatus = m_strActionDraft.ToUpper Or strStatus = m_strActionRejected.ToUpper Then

                    Else
                        Args.IsCheckBoxDisabled = True
                    End If

                Case ActorIndex.Approver

                    If (strStatus = m_strActionSubmitted.ToUpper Or strStatus = m_strActionResubmitted.ToUpper Or strStatus = m_strActionDisowned.ToUpper Or strStatus = m_strActionFinanceRejected.ToUpper) _
                        And m_strSessionUserID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CurrentActor"), ""), String) Then

                    Else

                        Args.IsCheckBoxDisabled = True
                    End If

                Case ActorIndex.EscalatedApprover

                    If (strStatus = m_strActionDisowned.ToUpper Or strStatus = m_strActionEscalated.ToUpper Or strStatus = m_strActionResubmitted.ToUpper Or strStatus = m_strActionFinanceRejected.ToUpper) _
                        And (m_strSessionUserID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CurrentActor"), ""), String)) Then

                    Else
                        Args.IsCheckBoxDisabled = True
                    End If

                Case ActorIndex.FinanceApprover

                    If strStatus = m_strActionApproved.ToUpper Then
                    Else
                        Args.IsCheckBoxDisabled = True
                    End If

            End Select

            'Cancel = True
            ' Args.StringToBeInserted = "<td style='width:10%' align=center> <Input type=checkbox name='chkDelete' id='chkDelete' class='clsCheckBox' value='" & CType(Args.DataReader("ExpensesEntryID"), String) & "' " + strDisable + " checked ></td>"

        ElseIf Args.DataField.ToUpper = "DISCUSSION" Then
            Args.ApplyHTMLEncode = False


        ElseIf Args.ColumnName.ToUpper = "COMMENTS" Then
            Dim blnDisabled As Boolean
            Dim strHTML As String
            Dim strComments As String
            strComments = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Comments"), ""), "")



            Select Case m_lngActor

                Case ActorIndex.Owner
                    If strStatus = "" Or strStatus = m_strActionDraft.ToUpper Or strStatus = m_strActionRejected.ToUpper Then
                        strComments = ""
                    Else
                        blnDisabled = True
                    End If

                Case ActorIndex.Approver
                    If strStatus = m_strActionSubmitted.ToUpper Or strStatus = m_strActionResubmitted.ToUpper Or strStatus = m_strActionDisowned.ToUpper Or strStatus = m_strActionFinanceRejected.ToUpper Then
                        strComments = ""
                    Else
                        blnDisabled = True
                    End If

                Case ActorIndex.EscalatedApprover

                    If strStatus = m_strActionDisowned.ToUpper Or strStatus = m_strActionEscalated.ToUpper Or strStatus = m_strActionResubmitted.ToUpper Or strStatus = m_strActionFinanceRejected.ToUpper Then
                        strComments = ""
                    Else
                        blnDisabled = True
                    End If

                Case ActorIndex.FinanceApprover
                    If strStatus = m_strActionApproved.ToUpper Then
                        strComments = ""
                    Else
                        blnDisabled = True
                    End If

            End Select

            'Added by PurvaJ on 18 April 2006 for whiziblesem 6 issue ID 2318 for expenses workflow
            'To display the latest comment in comments textbox.
            ' if the Further action is there then make the Comments text box as empty  else show the Last comment
            Dim ExpenseEntry As String
            'Dim strComment As String
            Dim Strsql As String
            ExpenseEntry = CType(Args.DataReader("ExpensesEntryID"), String)
            Strsql = "select top 1 comments from tbl_PM_ExpenseEntry_status_History where expensesentryid=" + ExpenseEntry + " order by lastupdateddate desc"
            strComments = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(Strsql, MyBase.UseSQL), ""), String)

            'End Addition PurvaJ

            Cancel = True

            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strHTML = "<td style='width:20%' valign='top' align=Left>" + CommonFunction.HTMLControls.DrawTextBox("txtComments" + ExpenseEntryID, "s" + ExpenseEntryID, , 120, 500, strComments, , , blnDisabled, blnDisabled, , , " height=50 valign='top'", True, True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding

            strHTML += "&nbsp;<A Href=""JavaScript: ShowDicussionTherad(" + ExpenseEntryID + " , " + IIf(blnDisabled = True, 1, 0).ToString + ")""><img Border=0 valign=Top align=top src='../../images/zoomin.gif' alt='click to add more text'></img></a></TD>"

            ' add hidded control to store disowned status of a expense Entry 
            ' strDisowned = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Disowned"), "0"), "0")
            ''' Added By NageshM on date 21'st june 2005
            '''Purpose : To create alert related diswoned entry unavailable for escalation


            Dim strDisownedStatus As String
            'Dim Strsql As String
            Strsql = "Select isnull(Disowned,'0') from tbl_PM_Expenses where ExpensesEntryID =" + ExpenseEntry
            strDisownedStatus = CType(CommonFunctions.Data.CheckIsDBNull(CType(CommonFunction.Data.GetDataScalar(Strsql, MyBase.UseSQL), String), "0"), String)
            If strDisownedStatus = "True" Then
                strDisownedStatus = (CType(1, String))
            Else
                strDisownedStatus = (CType(0, String))
            End If
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strHTML += CommonFunction.HTMLControls.DrawTextBox("txtDisowned" + ExpenseEntryID, "txtDisowned" + ExpenseEntryID, , , , strDisownedStatus, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            '' End of addition By NageshM
            'commented by NageshM
            ' strHTML += CommonFunction.HTMLControls.DrawTextBox("txtDisowned" + ExpenseEntryID, "txtDisowned" + ExpenseEntryID, , , , strDisowned, returnHtml:=True, displayNone:=True)
            'End of commenting by NageshM
            Args.StringToBeInserted = strHTML
        End If

        If Args.DataField.ToUpper = "PROJECTNAME" Then

            m_strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ProjectName"), ""), String)
            m_lngProjectID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ProjectID"), ""), Long)
        End If

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
        End If

        If Args.DataField.ToUpper = "DISCUSSION" Then
            Args.ApplyHTMLEncode = False
        End If

        If Args.ColumnName.ToUpper = "CURRENCYSYMBOL" Then
            Args.ColumnName = ""
        End If
    End Sub


    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

        'Added by PrashantD on 8 March 2007 for IssueID 11109
        If Request.QueryString("Mode").ToUpper = "ADD" Then
            If Args.LinkName.ToUpper = "PRINT" Then
                Cancel = True
            End If
        End If
        'End of addition by PrashantD on 8 March 2007


    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint

        If m_Mode.ToUpper = "EDIT" Then
            If (Trim(m_strProjectName) <> Trim(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectName").ToString.Trim, ""), String))) And (Trim(m_strProjectName) <> "") Then
                Args.StringToBeInserted = DisplayProjectwiseTotals()
            End If
        End If

    End Sub

    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint

        If m_Mode.ToUpper = "EDIT" Then
            Args.StringToBeInserted = DisplayProjectwiseTotals()
        End If

    End Sub
    ' added by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 28 Jun 2006
    'End Of Modification by PrajaktaR on 26 June 2006 for Bristlecone
    Private Sub ShowReport()
        '=====================================================================
        ' Procedure Name        : ShowReport
        ' Purpose               : To generate the report 
        ' Description           : The report is generated and file is opened
        '                         from window_onload() event
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFucntions.dll,AdHocReports.dll
        ' Author                : PrajaktaR
        ' Created               : 26 th June, 2006
        ' Revisions             :
        '=====================================================================
        Dim strFilePath As String
        Dim strFormat, strQuery As String
        Dim dr As IDataReader
        'added by harshada d on 01 July 2006 for plotting the report menu first and then open the report formatt
        DrawReportMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:150px;Height:70px'>")
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='width:150px;Overflow:auto'>")
        CommonFunctions.General.WriteHTML("</DIV>")
        CommonFunctions.General.WriteHTML("<BR>")


        ' Added by MahendraV On 9:27 AM 7/4/2007 for WhizibleSEM 7 
        ' The code changes required for the custom-report UI page 
        ' Start_MV_7/4/2007
        Dim strBaseResourceName As String = MyBase.ResourceName
        Dim strBaseResourceAssemblyName As String = MyBase.ResourceAssemblyName
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        m_strReportDisclaimer = MyBase.GetResourceString("REPORT_DISCLAIMER") + ""

        'Reset the resources.
        MyBase.InitializeResources(strBaseResourceName, strBaseResourceAssemblyName)
        Response.Write("<BR>" + m_strReportDisclaimer)
        ' End_MV_7/4/2007

        CommonFunctions.General.WriteHTML(strMenu)

        CommonFunctions.General.WriteHTML("<BR>")
        'end of addition by harshada d on 01 July 2006 for plotting the report menu first and then open the report formatt
        m_intShowMessage = 0

        strFormat = CommonFunction.General.CheckIsNothing(Request.QueryString("format").ToString, "")

        If strFormat.Trim <> "" And strFormat.Trim <> Nothing Then

            strQuery = "EXEC usp_Sel_tbl_PM_Expenses_ForExpenseSheet " + CType(HttpContext.Current.Session("intUserID"), String)

            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpenseSheetID"), "") <> "" Then
                m_strExpenseSheetID = HttpContext.Current.Request.QueryString("ExpenseSheetID")
            Else
                m_strExpenseSheetID = ""
            End If
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Actor"), "") = "" Then
                m_lngActor = 0
            Else
                m_lngActor = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Actor"), ""), Long)
            End If

            If m_strExpenseSheetID <> "" Then
                strQuery += " , " + m_strExpenseSheetID
            Else
                strQuery += " , Null "
            End If
            If m_lngActor <> -1 Then
                strQuery += " , '" + m_lngActor.ToString + "' "
            Else
                strQuery += " , Null"
            End If

            'Depending upon the project selected, select the 
            dr = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If dr.Read Then
                ' The reports are created in the "Reports" folder
                strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))

                ' get a unique file name
                m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim

                ' add extn to file name based on format requested
                Select Case UCase(Trim(strFormat))
                    Case "PDF" : m_strFileName += ".pdf"
                    Case "HTML" : m_strFileName += ".htm"
                    Case "RTF" : m_strFileName += ".rtf"
                    Case "EXCEL" : m_strFileName += ".xls"
                    Case "CSV" : m_strFileName += ".csv"
                    Case "TEXT" : m_strFileName += ".txt"
                    Case "XML" : m_strFileName += ".xml"
                    Case Else : m_strFileName += ".pdf"
                End Select

                ' create object of Adhoc reports
                oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strQuery, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
                With oRpt
                    .UseMSSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                    .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                    .LCID = MyBase.CurrentThreadUICultureID

                    If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                        .UseHashTables = True
                    Else
                        .UseHashTables = False
                    End If
                    .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                    .CompanyName = CommonFunctions.Application.CompanyName
                    .GraphImageGenerationAbsolutePath = Server.MapPath("../../Images/")

                    ' generate the report in requested format
                    Select Case strFormat
                        Case "PDF" : .GenerateReport(AdHocReports.Format.PDF)
                        Case "HTML" : .GenerateReport(AdHocReports.Format.HTML)
                        Case "RTF" : .GenerateReport(AdHocReports.Format.RTF)
                        Case "EXCEL" : .GenerateReport(AdHocReports.Format.EXCEL)
                        Case "CSV" : .GenerateReport(AdHocReports.Format.CSV)
                        Case "TEXT" : .GenerateReport(AdHocReports.Format.TEXT)
                        Case "XML" : .GenerateReport(AdHocReports.Format.XML)
                        Case Else : .GenerateReport(AdHocReports.Format.PDF)
                    End Select
                End With
                oRpt = Nothing
                'Added by PrashantD on 21 Aug 2007 for WhizFrameWork SP8
                m_strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(m_strFileName))
                Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + m_strFileName, True)
                'End of addition by PrashantD on 21 Aug 2007
            Else
                m_intShowMessage = 1
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        Else
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpenseSheetID"), "") <> "" Then
                m_strExpenseSheetID = HttpContext.Current.Request.QueryString("ExpenseSheetID")
            Else
                m_strExpenseSheetID = ""
            End If
            'commented by harshada d on 01 July 2006 for plotting the report menu first and then open the report formatt
            'DrawReportMenu()
            'CommonFunctions.General.WriteHTML(strMenu)

            'CommonFunctions.General.WriteHTML("<BR>")
            ''CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:150px;Height:70px'>")
            'CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='width:150px;Height:75px'>")
            'CommonFunctions.General.WriteHTML("</DIV>")
            'CommonFunctions.General.WriteHTML("<BR>")
            'CommonFunctions.General.WriteHTML(strMenu)

            'CommonFunctions.General.WriteHTML("<BR>")
            'end of commented by harshada d on 01 July 2006 for plotting the report menu first and then open the report formatt
        End If

    End Sub
    'End Of Modification by PrajaktaR on 26 June 2006 for Bristlecone

    Public Sub DrawReportMenu()
        '====================================================================
        ' Procedure Name        : DrawReportMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the Report menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : PrajaktaR
        ' Created               : 27th June 2006
        ' Revisions             :
        '=====================================================================

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strGrid As String

        'arrMenuList.Add("?")
        'arrMenuToolTipList.Add("Help")
        'arrClientSideFunctionList.Add("Help_OnClick(5007)")
        m_objMenu = New WebPages.Template.StaticMenu

        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

        arrMenuList.Add(MyBase.GetResourceString("MENU_PDF"))
        arrMenuList.Add(MyBase.GetResourceString("MENU_HTML"))
        arrMenuList.Add(MyBase.GetResourceString("MENU_RTF"))
        arrMenuList.Add(MyBase.GetResourceString("MENU_EXCEL"))
        arrMenuList.Add(MyBase.GetResourceString("MENU_CSV"))
        arrMenuList.Add(MyBase.GetResourceString("MENU_Text"))
        arrMenuList.Add(MyBase.GetResourceString("MENU_XML"))
        arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))

        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_PDF_TOOLTIP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HTML_TOOLTIP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_RTF_TOOLTIP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_EXCEL_TOOLTIP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CSV_TOOLTIP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_Text_TOOLTIP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_XML_TOOLTIP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))

        arrClientSideFunctionList.Add("ViewReport_OnClick('PDF')")
        arrClientSideFunctionList.Add("ViewReport_OnClick('HTML')")
        arrClientSideFunctionList.Add("ViewReport_OnClick('RTF')")
        arrClientSideFunctionList.Add("ViewReport_OnClick('EXCEL')")
        arrClientSideFunctionList.Add("ViewReport_OnClick('CSV')")
        arrClientSideFunctionList.Add("ViewReport_OnClick('TEXT')")
        arrClientSideFunctionList.Add("ViewReport_OnClick('XML')")
        arrClientSideFunctionList.Add("Help_OnClick(5010)")

        'Create the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)

    End Sub

    Private Sub oRpt_Section_BeforePrint(ByVal sender As Object, ByVal e As System.EventArgs, ByVal Report As DataDynamics.ActiveReports.ActiveReport) Handles oRpt.Section_BeforePrint
        'Dim section As DataDynamics.ActiveReports.Section
        'Dim i As Integer
        ''Static blnLinePrinted As Boolean = False
        ''Static blnSet As Boolean = False
        ''Static strBankName As String
        ''Static strBkAccountNo As String
        ''Static strBankToAddress As String
        ''Static strRSwiftNo As String
        ''Static strGreeting As String
        ''Static dblAmount As Double
        ''Static dblDiscount As Double = 0
        'Dim strQuery As String
        'Dim drProject As IDataReader
        'Dim m_intProjectID As Integer

        'Dim arrProjectID As New ArrayList

        ''Dim intCnt As Integer = -1
        ''strQuery = "SELECT DISTINCT ProjectID FROM tbl_PM_Expenses WHERE ExpensesEntryID IN (select ExpensesEntryID FROM tbl_PM_ExpenseSheet_Details WHERE ExpenseSheetID = " + m_strExpenseSheetID + ")"
        'strQuery = "GetExpensheetProjectIDs " + m_strExpenseSheetID
        'drProject = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
        'While drProject.Read
        '    m_intProjectID = CType(drProject("ProjectID"), Integer)
        '    arrProjectID.Add(m_intProjectID)
        'End While
        ''If arrProjectID.Count > 1 Then
        ''    GetArray(arrProjectID)
        ''End If
        'm_strSessionUserID = CType(Session("intUserID"), String)

        'section = CType(sender, DataDynamics.ActiveReports.Section)
        'Select Case UCase(Trim(section.Name & ""))
        '    'Case "GROUPHEADER1"
        '    '    'Select Case UCase(CType(section.Controls(i).DataField = "PROJECTID", DataDynamics.ActiveReports.TextBox).Text).Trim

        '    '    If UCase(section.Controls(i).DataField) = "PROJECTID" Then
        '    '        arrProjectID.Add(CType(CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text, Long))
        '    '        'm_lngProjectID = CType(CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text, Long)
        '    '    End If
        '    '    'End Select
        '    Case "GROUPFOOTER1"
        '        intCnt = intCnt + 1
        '        For i = 0 To section.Controls.Count - 1
        '            'Dim strQuery As String
        '            'Dim drProject As IDataReader
        '            'Dim m_intProjectID As Integer

        '            'strQuery = "SELECT DISTINCT ProjectID FROM tbl_PM_Expenses WHERE ExpensesEntryID IN (select ExpensesEntryID FROM tbl_PM_ExpenseSheet_Details WHERE ExpenseSheetID = " + m_strExpenseSheetID + ")"
        '            'drProject = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
        '            'While drProject.Read
        '            '    arrProjectID.Add(CType(drProject("ProjectID"), Integer))
        '            '    m_intProjectID = CType(drProject("ProjectID"), Integer)
        '            'End While
        '            'Select Case UCase(Trim(section.Controls(i).GetType.ToString & ""))
        '            'Select Case UCase(CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text).Trim
        '            If UCase(CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text).Trim.StartsWith("TOTAL AMOUNT :") Then

        '            'Case "TOTAL AMOUNT :"
        '            '   Dim intCnt As Integer
        '            'If arrProjectID.Count > 1 Then
        '            '    GetArray(arrProjectID)
        '            'End If
        '            m_lngProjectID = CType(arrProjectID(intCnt), Long)

        '            'For intCnt = 0 To arrProjectID.Count
        '            '    m_lngProjectID = CType(arrProjectID(intCnt).GetType.ToString, Long)
        '                CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = DisplayProjectwiseTotalsReport()
        '            End If
        '            'Next
        '            'CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = DisplayProjectwiseTotals()
        '            'End Select
        '        Next
        'End Select
    End Sub
    ' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for Expenses Weekly View Enhancements 28 Jun 2006
End Class

