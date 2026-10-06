'=====================================================================
' Module Name       :       RFI_InvoiceGeneration
' Purpose           :       To Plot the Screen for Invoice Generation
' Description       :       Same as above 
' Dependencies      :       Resource File For the same
' Author            :       DipaliS
' Created           :       August 05, 2004
' Revisions         :
'=====================================================================

Public Class RFI_InvoiceGeneration
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

#Region "Constants"
    Private Const TAG_ID As Integer = 826
    Private Const RFI_INITIATOR As String = "Initiator"
    Private Const RFI_APPROVER As String = "Approver"
    Private Const RFI_ACCOUNTS_PERSON As String = "Accounts"

    Private Const RFI_STATUS_DRAFT As String = "Draft"
    Private Const RFI_STATUS_SUBMITTED As String = "Submitted"
    Private Const RFI_STATUS_RESUBMITTED As String = "Re-submitted"
    Private Const RFI_STATUS_APPROVED As String = "Approved"
    Private Const RFI_STATUS_REJECTED As String = "Rejected"
    Private Const RFI_STATUS_CANCELLED As String = "Cancelled"
    Private Const RFI_STATUS_CLOSED As String = "Closed"

#End Region

#Region "Member Variables"
    Protected m_strMode As String       ' The page mode. (NEW/EDIT)
    Protected m_strAction As String      ' The action to be performed. (VIEW/SAVE)
    Protected m_intRFIID As Integer      ' The RFI ID.
    Protected m_intProjectID As Integer     ' The Project ID.		
    Private m_strProjectOrProduct As String    ' Flag indicating whether the project type is PROJECT / PRODUCT.	
    Private m_strCurrentStatus As String    ' The current status of the RFI.
    Private m_intRFITypeID As Integer     ' The RFI Type ID.		
    Protected m_intCustomerID As Integer     ' The Customer ID.		
    Private m_intCustomerContactID As Integer   ' The Customer Contact ID.	
    Protected m_intCustomerAddressID As Integer  ' The Customer Address ID.	

    Private m_intBillingCurrencyID As Integer  ' The Billing Currency ID.	
    Private m_strBillingCurrencyCode As String   ' The Billing Currency Code.
    Private m_strBillingMajorCurrencyUnit As String  ' The Major Unit of the Billing Currency.
    Private m_strBillingMinorCurrencyUnit As String  ' The Minor Unit of the Billing Currency.
    Private m_dblTotalBillingCurrencyAmount As Double  ' The Total billing currency amount.
    Private m_strBaseCurrencyCode As String    ' The Base Currency Code.
    Private m_dblBaseCurrencyAmount As Double   ' The Base Currency Amount.	
    'Integrated by TruptiK on 26-Apr-2007
    ''Added  by PrashantSJ on 31st July 2006
    ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
    Private m_dblItem_TotalCompanyBaseCurrencyAmount As Double 'The Total Company Base Currency Amount of all the selected items.	
    ''End of addition by PrashantSJ on 31st July 2006
    'End of integration by TruptiK
    Private m_dblItem_TotalBillingCurrencyAmount As Double ' The Total Billing Currency Amount of all the selected items.			
    Private m_dblItem_TotalBaseCurrencyAmount As Double   ' The Total Base Currency Amount of all the selected items.	

    Private m_blnInvoiceGenerated As Boolean   ' Flag indicating whether partial invoicing has been done for the selected RFI.	
    Private m_intSalesPersonID As Integer   ' The Sales Person ID.

    Private m_intChecklistID As Integer    ' The Checklist ID.
    Private m_intChecklistInstanceIDas As Integer   ' The Invoice Checklist Instance ID.
    Private m_intRFIChecklistInstanceID As Integer  ' The RFI Checklist Instance ID.		
    Private m_intChecklistItemID As Integer   ' The Checklist Item ID.
    Private m_blnDeviationFound As Boolean    ' Flag indicating whether deviation was found in the checklist instance.	
    Private m_intChecklistInstanceItemID As Integer ' The Checklist Instance Item ID.
    Protected m_blnMultipleAccounts As Boolean
    Private m_intChecklistInstanceID As Integer

    Protected m_intInvoiceID As Integer     ' The Invoice ID.
    Private m_dtmInvoiceDate As Date    ' The Invoice Date.
    Private m_dtmDueDate As Date     ' The Due Date for payment.
    Private m_intPaymentModeID As Integer   ' The Payment Mode ID.
    Private m_intBankID As Integer     ' The Bank ID.
    Private m_intContractID As Integer    ' The Contract ID.	
    Protected m_blnReadOnly As Boolean     ' Flag indicating whether invoice is read-only or no.	
    Private m_strConfirmEmailID As String

    Private m_objNumToWordConvertor As Object  ' Object to convert currency into word format.
    Private m_strBillingCurrencyAmountInWords As String ' String containing currency value in words.

    Private m_arrRFITypeAttributes(,) As String  ' Array to store the RFI Item attributes and the captions applicable for the current RFI Type.		
    Private m_intRFIItemID As Integer     ' The RFI Item ID.

    Private m_intTaxID As Integer     ' The Tax ID.
    Private m_intPrevTaxID As Integer     ' The Previous Tax ID.
    Private m_strTaxName As String      ' The Tax Name.
    Private m_dblTaxPercentage As Double    ' The Tax Percentage to be applied.
    Private m_strTaxFormula As String     ' The Tax Formula.
    Private m_arrTaxDetails(5, 3) As String  ' Array to store the tax details.	
    Private m_blnSendEmail, m_blnShowPopup As Boolean
    Private m_strToEmailID, m_strCCToEmailID, m_strFromEmailID, m_strSubject, m_strEmailMessage As String
    Protected m_dtmSalesPeriodStartDate As Date
    Protected m_dtmSalesPeriodEndDate As Date
    Private m_blnAuditTrailExists As Boolean

    Private m_strOnloadClientScript As String
    Private m_objGlobal As WebPages.Template.IGlobal
    Private WithEvents m_objGrid As WebPages.Template.AdvancedGrid
    Private m_intCounter As Integer
    Private WithEvents m_objMenuForStep1 As WebPages.UI.cStaticMenu
    Private WithEvents m_objMenuForStep2 As WebPages.UI.cStaticMenu
    Private WithEvents m_objMenuForStep3 As WebPages.UI.cStaticMenu
    Private WithEvents m_objMenuForStep4 As WebPages.UI.cStaticMenu
    Private arrRFITypeAttributes(,) As String
    Private WithEvents m_objGridforItems As WebPages.Template.AdvancedGrid
    Private WithEvents m_objGridForSalesPersons As WebPages.Template.AdvancedGrid
    Private WithEvents m_objGridForTaxDetails As WebPages.Template.AdvancedGrid
    'Integrated by TruptiK on 19-May-09
     'Addition by SuchitraP on 20-Mar-2009 for IssueID : 29346
    'Purpose : Invoice>Invoice Genaration : For the step no 5 on the page the tax percentage field alignment  is not proper.(Mozilla)
    'Private m_intCounterForTax As Integer
    Protected m_intCounterForTax As Integer
    'End of addition by SuchitraP on 20-Mar-2009 for IssueID : 29346
    'end of Integrated by TruptiK on 19-May-09
    Private gridintTaxID As String
    Private griddblTaxPercentage As String
    Private gridstrTaxFormula As String
    Private gridstrTaxName As String
    Private m_strFromDetails As String
    'Added by TruptiK on 22-Jun-2007
    Private m_GovtInvoiceNumber As String
    Private m_TermsAndConditionsID As Integer
    Private m_sPONumber As String
    Private m_dtmPODate As String = ""
    'End of addition by TruptiK on 22-Jun-2007
    ''Added  by PrashantSJ on 31st July 2006
    ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
    Private m_strCompanyBaseCurrencyCode As String = ""
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private m_intSalesPeriodID As Long
    Private m_strSalesPeriod As String = ""
    Private m_dblCreditDays As Integer = 0
    ''End of addition by PrashantSJ on 31st July 2006
    'Added By JyotiG
    'Start
    Protected strId As String
    Protected strUserId As String
    Protected m_intTagID As String
    Protected m_ParentTagID As String
    Protected m_strToken As String
    Protected m_LoadFrom As String
    'Added by PrashantSJ on 8th Dec 2008 for - T&M with Cap invoicing
    Protected m_dblTotalInvoiceAmount As Double = 0.0
    Protected m_dblProjectCAPAmount As Double = 0.0
    Private m_strSQL As String = ""
    Private drCAP As IDataReader
    Protected m_blnIsCAPAllowed As Boolean
    Protected m_strCorporateBaseCurrency As String = CommonFunction.Application.CorporateBaseCurrency
    'End of addition by PrashantSJ on 8th Dec 2008 for - T&M with Cap invoicing
    'End
#End Region

#Region "Procedures/Functions"
    Public Sub PageInit()
        '######### Page Code starts here
        GetGlobalObject()
        GetTagAccessRights()
        InitilizeData()

        If m_strAction.ToUpper <> "SAVE" Then
            PlotUI()
        End If
    End Sub

    Public Sub New()
        ' Added  By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ' End Added  By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
    '====================================================================
    ' Procedure Name        :   InitilizeData
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To Initialize the data required for page
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 05, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub InitilizeData()
        ' Get the action to be performed (VIEW/SAVE).
        If Trim(Request.QueryString("Action")) <> "" Then
            m_strAction = Trim(Request.QueryString("Action"))
        Else
            m_strAction = "View"
        End If

        m_blnReadOnly = False

        ' Get the RFIID, etc. from Query String (if page accessed for the first time.).
        If MyBase.GetFormValue("txtUseFormContents") = "" Then

            If Not IsNothing(Request.QueryString("InvoiceID")) Then
                m_intInvoiceID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("InvoiceID")), Integer)
            Else
                m_intInvoiceID = 0
            End If

            If Trim(Request.QueryString("FromDetails")) <> "" Then
                m_strFromDetails = Trim(Request.QueryString("FromDetails"))
            Else
                m_strFromDetails = ""
            End If

            m_intRFIID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("RFIID"), "0"), Integer)

            ' Build the query to retrieve the details of the RFI/Invoice.
            Dim strSQLQuery As String
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFIInvoices_ForInvoiceGeneration"
            ' The RFI ID. [Passed when a new invoice is being generated from the RFI.]
            If m_intRFIID <> 0 Then
                strSQLQuery = strSQLQuery & " " & m_intRFIID
            Else
                strSQLQuery = strSQLQuery & " NULL"
            End If

            ' The Invoice ID. [Passed when the invoice is being edited.]
            If m_intInvoiceID <> 0 Then
                strSQLQuery = strSQLQuery & ", " & m_intInvoiceID
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            Dim drInvoice As IDataReader

            ' Get the details of the RFI/invoice.
            drInvoice = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drInvoice.Read Then
                m_intRFIID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("RFIID"), "0"), Integer)
                m_intProjectID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("ProjectID"), "0"), Integer)
                m_strProjectOrProduct = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("ProjectOrProduct")), String)
                m_intRFITypeID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("RFITypeID"), "0"), Integer)
                m_intChecklistID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("ChecklistID"), "0"), Integer)
                m_intChecklistInstanceID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("ChecklistInstanceID"), "0"), Integer)
                m_intRFIChecklistInstanceID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("RFIChecklistInstanceID"), "0"), Integer)
                m_intCustomerID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("CustomerID"), "0"), Integer)
                m_intCustomerContactID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("CustomerContactID"), "0"), Integer)
                m_strConfirmEmailID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("ConfirmEmailID")), String)
                m_intCustomerAddressID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("CustomerAddressID"), "0"), Integer)
                m_strBaseCurrencyCode = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("BaseCurrencyCode")), String)
                m_dblBaseCurrencyAmount = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("BaseCurrencyAmount"), "0"), Double)
                m_intBillingCurrencyID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("BillingCurrencyID"), "0"), Integer)
                m_strBillingCurrencyCode = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("BillingCurrencyCode")), String)
                m_intBankID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("BankID"), "0"), Integer)
                m_intContractID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("ContractID"), "0"), Integer)
                m_intPaymentModeID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("PaymentModeID"), "0"), Integer)
                m_dtmInvoiceDate = CType(CommonFunctions.Dates.GetDate(CType(drInvoice.Item("InvoiceDate"), Date)), Date)
                ''''''PrashantSJ on 01 Aug 2007
                m_intSalesPeriodID = CType(CommonFunctions.Data.CheckIsDBNull(drInvoice.Item("SalesPeriodID"), "0"), Integer)
                m_strSalesPeriod = CType(CommonFunctions.Data.CheckIsDBNull(drInvoice.Item("SalesPeriod"), ""), String)
                m_dblCreditDays = CType(CommonFunctions.Data.CheckIsDBNull(drInvoice.Item("CreditDays"), ""), Integer)
                ''''''End of addtion by PrashantSJ on 01-Aug-2006 
                m_dtmSalesPeriodStartDate = CType(CommonFunctions.Dates.GetDate(CType(drInvoice.Item("SalesPeriodStartDate"), Date)), Date)
                'm_dtmSalesPeriodStartDate = CType(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Dates.GetDate(CType(drInvoice.Item("SalesPeriodStartDate"),"") Date)), Date)
                m_dtmSalesPeriodEndDate = CType(CommonFunctions.Dates.GetDate(CType(drInvoice.Item("SalesPeriodEndDate"), Date)), Date)
                m_dtmDueDate = CType(CommonFunctions.Dates.GetDate(CType(drInvoice.Item("DueDate"), Date)), Date)
                m_blnInvoiceGenerated = CType(drInvoice.Item("InvoiceGenerated"), Boolean)
                ''Added and commented by PrashantSJ on 31st July 2006
                ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
                m_strCompanyBaseCurrencyCode = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("CompanyBaseCurrencyCode")), String)
                ''End of addition by PrashantSJ on 31st July 2006
                'Added by TruptiK on 22-Jun-2007
                m_GovtInvoiceNumber = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("CustomFieldText1")), String)
                m_sPONumber = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("CustomFieldText2")), String)

                m_dtmPODate = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("PODate"), ""), String)


            m_TermsAndConditionsID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TermsAndConditionID"), "0"), Integer)
            'End of addition by TruptiK 
            'Fill the Array for Tax Details
            m_arrTaxDetails(1, 0) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxID1")), String)
            m_arrTaxDetails(1, 1) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxPercentage1")), String)
            m_arrTaxDetails(1, 2) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxAmount1")), String)
            m_arrTaxDetails(2, 0) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxID2")), String)
            m_arrTaxDetails(2, 1) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxPercentage2")), String)
            m_arrTaxDetails(2, 2) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxAmount2")), String)
            m_arrTaxDetails(3, 0) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxID3")), String)
            m_arrTaxDetails(3, 1) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxPercentage3")), String)
            m_arrTaxDetails(3, 2) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxAmount3")), String)
            m_arrTaxDetails(4, 0) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxID4")), String)
            m_arrTaxDetails(4, 1) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxPercentage4")), String)
            m_arrTaxDetails(4, 2) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxAmount4")), String)
            m_arrTaxDetails(5, 0) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxID5")), String)
            m_arrTaxDetails(5, 1) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxPercentage5")), String)
            m_arrTaxDetails(5, 2) = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TaxAmount5")), String)

            m_blnReadOnly = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("ReadOnly"), "false"), Boolean)
            m_blnMultipleAccounts = CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("MultipleAccounts"), "false"), Boolean)

        End If
        CommonFunctions.Data.DisposeDataReader(drInvoice)

        Dim intCtr As Integer

        If m_intInvoiceID = 0 Then
            For intCtr = 0 To 5
                m_arrTaxDetails(intCtr, 0) = ""
                m_arrTaxDetails(intCtr, 1) = ""
                m_arrTaxDetails(intCtr, 2) = ""
            Next

            ' Get the previously selected tax details.
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFITypes_TaxDetails " & m_intRFITypeID
            Dim drTax As IDataReader

            drTax = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)


            Do While drTax.Read
                intCtr = CType(Right(Trim(CType(CommonFunction.Data.CheckIsDBNull(drTax.Item("FieldName")), String) & ""), 1), Integer)
                If Not IsNumeric(intCtr) Then
                    intCtr = 0
                Else
                    intCtr = CInt(intCtr)
                End If
                m_arrTaxDetails(intCtr, 0) = Trim(CType(CommonFunction.Data.CheckIsDBNull(drTax.Item("TaxID")), String) & "")
                m_arrTaxDetails(intCtr, 1) = Trim(CType(CommonFunction.Data.CheckIsDBNull(drTax.Item("StandardTaxPercentage")), String) & "")
                m_arrTaxDetails(intCtr, 2) = Trim(CType(CommonFunction.Data.CheckIsDBNull(drTax.Item("Formula")), String) & "")
            Loop
            CommonFunction.Data.DisposeDataReader(drTax)
        End If

        ' Else, get the details from the Form collection.	
        'Added By JyotiG
        'Start
        'Date : 20-Sep-2006
        'Issue ID : 6197
        m_strToken = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("PKToken"), ""), String)
        If m_intInvoiceID = 0 Then
            m_ParentTagID = "2083"
            strId = CType(m_intRFIID, String)
        Else
            If m_LoadFrom = "" Then
                m_LoadFrom = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("LoadFrom"), "List"), String)
            End If
            If m_LoadFrom = "List" Then
                m_ParentTagID = "2084"
            ElseIf m_LoadFrom = "Mail" Then
                m_ParentTagID = "2173"
            End If
            strId = CType(m_intInvoiceID, String)
        End If
        'End
        Else

        m_intRFIID = CType(Trim(MyBase.GetFormValue("txtRFIID")), Integer)
        m_intInvoiceID = CType(Trim(MyBase.GetFormValue("txtInvoiceID")), Integer)
        m_strFromDetails = Trim(MyBase.GetFormValue("txtFromDetails"))
        m_intProjectID = CType(Trim(MyBase.GetFormValue("txtProjectID")), Integer)
        m_intCustomerID = CType(Trim(MyBase.GetFormValue("cboCustomerID")), Integer)
        m_intRFITypeID = CType(Trim(MyBase.GetFormValue("txtRFITypeID")), Integer)
        m_intChecklistID = CType(Trim(MyBase.GetFormValue("txtChecklistID")), Integer)
        m_intChecklistInstanceID = CType(Trim(MyBase.GetFormValue("txtChecklistInstanceID")), Integer)
        m_arrTaxDetails(0, 0) = "0"
        m_arrTaxDetails(0, 1) = "0"
        m_arrTaxDetails(0, 2) = ""
        m_arrTaxDetails(1, 0) = "0"
        m_arrTaxDetails(1, 1) = "0"
        m_arrTaxDetails(1, 2) = ""
        m_arrTaxDetails(2, 0) = "0"
        m_arrTaxDetails(2, 1) = "0"
        m_arrTaxDetails(2, 2) = ""
        m_arrTaxDetails(3, 0) = "0"
        m_arrTaxDetails(3, 1) = "0"
        m_arrTaxDetails(3, 2) = ""
        m_arrTaxDetails(4, 0) = "0"
        m_arrTaxDetails(4, 1) = "0"
        m_arrTaxDetails(4, 2) = ""
        'Added By JyotiG
        'Start
        'Date : 20-Sep-2006
        'Issue ID : 6197
        m_LoadFrom = CType(Trim(MyBase.GetFormValue("txtLoadFrom")), String)
        If m_LoadFrom = "" Then
            m_LoadFrom = "List"
        End If
        m_strToken = CType(Trim(MyBase.GetFormValue("txtToken")), String)
        If m_intInvoiceID = 0 Then
            m_ParentTagID = "2083"
            strId = CType(m_intRFIID, String)
        Else
            If m_LoadFrom = "List" Then
                m_ParentTagID = "2084"
            ElseIf m_LoadFrom = "Mail" Then
                m_ParentTagID = "2173"
            End If
            strId = CType(m_intInvoiceID, String)
        End If
        'End
        End If

        If m_intInvoiceID <> 0 Then
            m_strMode = "Edit"
        Else
            m_strMode = "New"
        End If

        ' If RFI ID not found, reset the values to 0.
        If m_intRFIID = 0 Then
            m_intRFIID = 0
            m_intInvoiceID = 0
            m_intProjectID = 0
            m_intCustomerID = 0
            m_intRFITypeID = 0
            m_intChecklistID = 0
            m_intChecklistInstanceID = 0
        End If

        If m_intInvoiceID <> 0 Then
            m_blnAuditTrailExists = AuditTrailExists(TAG_ID, m_intInvoiceID, m_intProjectID)
        End If
        '''Added by PrashantSJ on 08th DEC 2008
        ''Purpose: To have TotalInvoiceAmount and CAP amount for Project Profitability
        m_strSQL = "usp_ValidationOfCapInvoiceAmount " & m_intProjectID & "," & m_intInvoiceID
        drCAP = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drCAP.Read Then
            m_dblTotalInvoiceAmount = CType(CommonFunction.Data.CheckIsDBNull(drCAP("TotalInvoiceAmount"), "0.0"), Double)
            m_dblProjectCAPAmount = CType(CommonFunction.Data.CheckIsDBNull(drCAP("CAPAmount"), "0.0"), Double)
            m_blnIsCAPAllowed = CType(CommonFunction.Data.CheckIsDBNull(drCAP("IsCAPAllowed"), "0"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(drCAP)
        '''End of addition by PrashantSJ on 08th DEC 2008
        PerformAction()

    End Sub

    '=====================================================================
    ' Procedure Name		:	AuditTrailExists
    ' Purpose				:	To check if ane entries are made in the audit trail.
    ' Description			:	Same as above.
    ' Parameters Passed		:	intTagID	:	The Tag ID. 
    '							intUniqueID	:	The Primary key column value.
    '							intProjectID:	The current ProjectID
    ' Parameters Affected	:	None.
    ' Returns				:	No return values.
    ' Assumptions			:	None.
    ' Dependencies			:	None.
    ' Author				:	DipaliS 
    ' Created				:	6 July  2004
    ' Revisions				:   
    '=====================================================================

    Private Function AuditTrailExists(ByVal TagID As Integer, ByVal RFIID As Integer, ByVal ProjectID As Long) As Boolean

        Dim drAT As IDataReader
        Dim result As Boolean

        Dim strSQLQuery As String
        strSQLQuery = "Exec usp_Sel_tbl_PM_AuditTrail " & TagID & ", " & RFIID & ", " & ProjectID
        drAT = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drAT.Read Then
            result = True
        End If
        CommonFunctions.Data.DisposeDataReader(drAT)
        Return result

    End Function
    '====================================================================
    ' Procedure Name        :   PerformAction
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To Perform necessary action from UI
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                : DipaliS
    ' Created               : August 06, 2004
    ' Revisions :
    '=====================================================================
    Private Sub PerformAction()
        Dim strSQLQuery As String

        '=====================================================================
        '	SAVE THE INVOICE DETAILS.
        '=====================================================================
        'Added by JyotiG IssueID : 6197
        If CommonFunctions.Security.Token.ValidateToken(CType(strId, String) + Session("intUserID").ToString + CType(m_ParentTagID, String) + CType(0, String) + CType(m_intProjectID, String), m_strToken) = False Or m_strToken = "" Then
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End

        If m_strAction.ToUpper = "SAVE" Then
            '=====================================================================
            '	STEP 1 : SAVE THE CHECKLIST THAT WAS FILLED BY THE USER.
            '=====================================================================	
            ' First create a master entry for the checklist instance.	
            strSQLQuery = "Exec usp_Ins_tbl_PM_RFIChecklistInstances "

            ' Checklist Instance ID.
            If m_intChecklistInstanceID <> 0 Then
                strSQLQuery = strSQLQuery & m_intChecklistInstanceID
            Else
                strSQLQuery = strSQLQuery & "NULL"
            End If

            ' Project ID.
            strSQLQuery = strSQLQuery & ", " & m_intProjectID

            ' Checklist ID.
            strSQLQuery = strSQLQuery & ", " & m_intChecklistID

            ' RFI ID.
            strSQLQuery = strSQLQuery & ", " & m_intRFIID

            ' Invoice ID.
            If m_intInvoiceID = 0 Then
                strSQLQuery = strSQLQuery & ", NULL"
            Else
                strSQLQuery = strSQLQuery & ", " & m_intInvoiceID
            End If


            m_intChecklistInstanceID = CType(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), Integer)

            ' Next enter the details of each checklist item, within the checklist instance.
            m_blnDeviationFound = False

            Dim m_strCheckListItemIDs As String
            Dim m_strChecklistInstanceItemIDs As String
            Dim m_strCheckListItemID() As String
            Dim m_strChecklistInstanceItemID() As String
            Dim strChkDel() As String
            Dim m_strSeperator As String = ","
            Dim intCtr As Integer
            Dim m_charSep() As Char = m_strSeperator.ToCharArray

            m_strCheckListItemIDs = MyBase.GetFormValue("txtChecklistItemID")
            m_strChecklistInstanceItemIDs = MyBase.GetFormValue("txtChecklistInstanceItemID")

            If m_strCheckListItemIDs <> "" Then
                m_strCheckListItemID = m_strCheckListItemIDs.Split(m_charSep)
            End If

            If m_strChecklistInstanceItemIDs <> "" Then
                m_strChecklistInstanceItemID = m_strChecklistInstanceItemIDs.Split(m_charSep)
            End If

            If Not IsNothing(m_strChecklistInstanceItemID) Then
                For intCtr = 0 To m_strChecklistInstanceItemID.Length - 1

                    m_intChecklistItemID = CType(m_strCheckListItemID(intCtr), Integer)
                    m_intChecklistInstanceItemID = CType(m_strChecklistInstanceItemID(intCtr), Integer)

                    ' Build Query to enter the checklist item details.
                    strSQLQuery = "Exec usp_Ins_tbl_PM_RFIChecklistInstance_Items "
                    If m_intChecklistInstanceItemID <> 0 Then
                        strSQLQuery = strSQLQuery & m_intChecklistInstanceItemID
                    Else
                        strSQLQuery = strSQLQuery & "NULL"
                    End If

                    strSQLQuery = strSQLQuery & ", " & m_intChecklistInstanceID.ToString & ", " & m_intProjectID.ToString & ", " & m_intChecklistID.ToString & ", " & m_intChecklistItemID.ToString

                    ' Checklist Item Response.
                    If Trim(MyBase.GetFormValue("chkChecklistItemResponse" & m_intChecklistItemID)) <> "" Then
                        strSQLQuery = strSQLQuery & ", 1"
                    Else
                        strSQLQuery = strSQLQuery & ", 0"

                        ' If any of the check boxes are unchecked, then it indicates, that there is a deviation.
                        m_blnDeviationFound = True
                    End If

                    ' Comments.
                    If Trim(Request.Form("txtComments" & m_intChecklistItemID)) <> "" Then
                        strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(Left(Trim(Request.Form("txtComments" & m_intChecklistItemID)), 2000)) & "'"
                    Else
                        strSQLQuery = strSQLQuery & ", NULL"
                    End If

                    ' Created By (for audit trail).				
                    strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(Trim(CType(Session("strUserName"), String))) & "'"

                    ' Insert the checklist item response.
                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

                Next
            End If

            '=====================================================================
            '	STEP 2 : SAVE THE INVOICE DETAILS.
            '=====================================================================
            ' Insert new record for Invoice. (Invoice Number will be generated within the stored procedure.)
            strSQLQuery = "Exec usp_Ins_tbl_PM_RFIInvoices "

            ' For "Edit" mode pass the InvoiceID. For "New" mode pass NULL.
            If m_intInvoiceID <> 0 Then
                strSQLQuery = strSQLQuery & m_intInvoiceID
            Else
                strSQLQuery = strSQLQuery & "NULL"
            End If

            ' RFI ID.		
            strSQLQuery = strSQLQuery & ", " & m_intRFIID

            ' Invoice Date.
            If Trim(MyBase.GetFormValue("txtInvoiceDate")) <> "" Then
                strSQLQuery = strSQLQuery & ", '" & CommonFunction.Dates.GetDate(CType(Trim(MyBase.GetFormValue("txtInvoiceDate")), Date)) & "'"
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Due Date.
            If Trim(MyBase.GetFormValue("txtDueDate")) <> "" Then
                strSQLQuery = strSQLQuery & ", '" & CommonFunction.Dates.GetDate(CType(Trim(MyBase.GetFormValue("txtDueDate")), Date)) & "'"
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Customer Contact ID.
            If Trim(MyBase.GetFormValue("cboCustomerContactID")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & Trim(MyBase.GetFormValue("cboCustomerContactID"))
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Confirm Email ID.
            If Trim(MyBase.GetFormValue("txtConfirmEmailID")) <> "" Then
                strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(Left(Trim(MyBase.GetFormValue("txtConfirmEmailID")), 100)) & "'"
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If
            
            ' Customer Address ID.
            If Trim(MyBase.GetFormValue("txtCustomerAddressID")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & Trim(MyBase.GetFormValue("txtCustomerAddressID"))
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Payment Mode ID.
            If Trim(MyBase.GetFormValue("cboPaymentModeID")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & Trim(MyBase.GetFormValue("cboPaymentModeID"))
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Bank ID.
            If Trim(MyBase.GetFormValue("cboBankID")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & Trim(MyBase.GetFormValue("cboBankID"))
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Contract ID.
            If Trim(MyBase.GetFormValue("cboContractID")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & Trim(MyBase.GetFormValue("cboContractID"))
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Checklist ID.
            If m_intChecklistID <> 0 Then
                strSQLQuery = strSQLQuery & ", " & m_intChecklistID
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Checklist Instance ID.
            If m_intChecklistInstanceID <> 0 Then
                strSQLQuery = strSQLQuery & ", " & m_intChecklistInstanceID
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Deviation Found.
            If m_blnDeviationFound = True Then
                strSQLQuery = strSQLQuery & ", 1"
            Else
                strSQLQuery = strSQLQuery & ", 0"
            End If

            ' Created By (for audit trail).				
            strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(Trim(CType(Session("strUserName"), String))) & "'"
            'Added by TruptiK on 22-Jun-2007
            If Trim(MyBase.GetFormValue("cboTermsAndConditionsID")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & Trim(MyBase.GetFormValue("cboTermsAndConditionsID"))
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If
            If Trim(MyBase.GetFormValue("txtGovtInvoiceNo")) <> "" Then
                strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(Left(Trim(MyBase.GetFormValue("txtGovtInvoiceNo", False)), 100)) & "'"
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If
            If Trim(MyBase.GetFormValue("txtPONo")) <> "" Then
                strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(Left(Trim(MyBase.GetFormValue("txtPONo")), 100)) & "'"
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If
            If Trim(MyBase.GetFormValue("txtPODate")) <> "" Then
                strSQLQuery = strSQLQuery & ", '" & CommonFunction.Dates.GetDate(CType(Trim(MyBase.GetFormValue("txtPODate")), Date)) & "'"
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If
            'End of addition by TruptiK
            If Trim(Request.Form("txtSalesPeriodID")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("txtSalesPeriodID"))
                'End of modification by TruptiK on 21-Jun-2007
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If
            ' Save record and retrieve the Invoice ID.
            m_intInvoiceID = CType(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), Integer)

            Dim strRFIItemIDs As String
            Dim strRFIItemID() As String
            strRFIItemIDs = MyBase.GetFormValue("chkRFIItemID")
            If strRFIItemIDs <> "" Then
                strRFIItemID = strRFIItemIDs.Split(m_charSep)
            End If

            If Not IsNothing(strRFIItemID) Then
                ' Save the details of the selected RFI Items in the Invoice Items table.
                For intCtr = 0 To strRFIItemID.Length - 1

                    m_intRFIItemID = CType(strRFIItemID(intCtr), Integer)

                    ' Build Query to enter the RFI item details in the invoice table.
                    strSQLQuery = "Exec usp_Ins_tbl_PM_RFIInvoice_Items NULL, " & m_intInvoiceID & ", " & m_intRFIItemID

                    ' Account ID.
                    If Trim(Request.Form("cboAccountID" & m_intRFIItemID)) <> "" Then
                        strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("cboAccountID" & m_intRFIItemID))
                    Else
                        strSQLQuery = strSQLQuery & ", NULL"
                    End If

                    ' Created By (for audit trail).				
                    strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(Trim(CType(Session("strUserName"), String))) & "'"

                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
                Next
            End If

            ' Delete the items that are unchecked.
            If Trim(Request.Form("chkRFIItemID")) <> "" Then

                strSQLQuery = "DELETE FROM tbl_PM_RFIInvoice_Items WHERE InvoiceID = " & m_intInvoiceID & " AND RFIItemID NOT IN (" & Trim(MyBase.GetFormValue("chkRFIItemID")) & ") "

                CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

            End If

            '=====================================================================
            '	STEP 3 : SAVE THE SALES COMMISSION DETAILS.
            '=====================================================================

            ' Save All the selected Sales Persons.		
            If Trim(MyBase.GetFormValue("chkSalesPersonID")) <> "" Then

                Dim strSalesPersons As String = MyBase.GetFormValue("chkSalesPersonID")
                Dim strSalesPerson() As String
                If strSalesPersons <> "" Then
                    strSalesPerson = strSalesPersons.Split(m_charSep)
                End If

                ' Save the sales commission details of each selected sales person.
                If Not IsNothing(strSalesPerson) Then
                    For intCtr = 0 To strSalesPerson.Length - 1

                        m_intSalesPersonID = CType(Trim(strSalesPerson(intCtr)), Integer)

                        ' Build Query to enter the sales person details.
                        strSQLQuery = "Exec usp_Ins_tbl_PM_RFIInvoice_SalesPersons NULL, " & m_intInvoiceID & ", " & m_intProjectID & ", " & m_intRFIID & ", " & m_intSalesPersonID

                        ' Sales Commission Percentage.
                        If Trim(MyBase.GetFormValue("txtSalesCommissionPercentage" & m_intSalesPersonID)) <> "" Then
                            strSQLQuery = strSQLQuery & ", " & FormatNumber(Trim(MyBase.GetFormValue("txtSalesCommissionPercentage" & m_intSalesPersonID)), , , , TriState.False)
                        Else
                            strSQLQuery = strSQLQuery & ", NULL"
                        End If

                        ' Created By (for audit trail).				
                        strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(Trim(CType(Session("strUserName"), String))) & "'"

                        CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
                    Next
                End If

            End If

            ' Delete the items that are unchecked.
            If Trim(MyBase.GetFormValue("chkSalesPersonID")) <> "" Then
                strSQLQuery = "DELETE FROM tbl_PM_RFIInvoice_SalesPersons WHERE InvoiceID = " & m_intInvoiceID & " AND SalesPersonID NOT IN (" & Trim(Request.Form("chkSalesPersonID")) & ") "
                CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
            End If

            '=====================================================================
            '	STEP 4 : SAVE THE TAX DETAILS.
            '=====================================================================
            For intCtr = 1 To 5

                If Trim(MyBase.GetFormValue("cboTaxID" & intCtr)) <> "" Then
                    m_intTaxID = CType(Trim(MyBase.GetFormValue("cboTaxID" & intCtr)), Integer)
                Else
                    m_intTaxID = 0
                End If

                If Trim(MyBase.GetFormValue("txtTaxPercentage" & intCtr)) <> "" Then
                    'Added by PrashantSJ on 15 March 2007 For Tax (should accept decimal also)
                    'm_dblTaxPercentage = CType(Trim(MyBase.GetFormValue("txtTaxPercentage" & intCtr)), Integer)
                    m_dblTaxPercentage = CType(Trim(MyBase.GetFormValue("txtTaxPercentage" & intCtr)), Double)
                    'End of addition by PrashantSJ on 15 March 2007 For Tax
                Else
                    m_dblTaxPercentage = 0
                End If

                ' Build query to update the tax details.
                strSQLQuery = "Exec usp_Upd_tbl_PM_RFIInvoices_TaxDetails " & m_intInvoiceID & ", " & intCtr

                ' The Tax ID.
                If m_intTaxID <> 0 Then
                    strSQLQuery = strSQLQuery & ", " & m_intTaxID
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' The Tax %.
                If m_dblTaxPercentage <> 0 Then
                    'Added by PrashantSJ on 15 March 2007 For Tax (should accept decimal also)
                    'strSQLQuery = strSQLQuery & ", " & FormatNumber(m_dblTaxPercentage, 1, , , TriState.False)
                    strSQLQuery = strSQLQuery & ", " & m_dblTaxPercentage
                    'End of addition by PrashantSJ
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' Created By (for audit trail).				
                strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(Trim(CType(Session("strUserName"), String))) & "'"

                CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
            Next

            '=====================================================================
            '	STEP 5 : SAVE THE TOTAL BILLING AMOUNT IN WORDS.
            '=====================================================================		
            ' NOTE: The total billing currency amount is updated automatically as the invoice items are entered in the table.
            '		Hence, this value is retrieved after all the invoice items are entered in the table.
            m_dblTotalBillingCurrencyAmount = 0
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFIInvoices " & m_intInvoiceID
            Dim drInvoice As IDataReader

            drInvoice = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drInvoice.Read Then
                ' Get the total billing currency amount.

                If Trim(CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("TotalBillingCurrencyAmount")), String) & "") <> "" Then
                    m_dblTotalBillingCurrencyAmount = CType(FormatNumber(CType(drInvoice.Item("TotalBillingCurrencyAmount"), Double), 2, , , TriState.False), Double)
                End If
                m_strBillingMajorCurrencyUnit = Trim(CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("MajorCurrencyUnit")), String) & "")
                m_strBillingMinorCurrencyUnit = Trim(CType(CommonFunction.Data.CheckIsDBNull(drInvoice.Item("MinorCurrencyUnit")), String) & "")
            End If
            CommonFunction.Data.DisposeDataReader(drInvoice)

            ' Convert the amount to words.
            m_strBillingCurrencyAmountInWords = CommonFunction.General.NumToWord(m_dblTotalBillingCurrencyAmount, m_strBillingMajorCurrencyUnit, m_strBillingMinorCurrencyUnit)

            ' Update the invoice record.
            strSQLQuery = "usp_Upd_tbl_PM_RFIInvoices_SetBillingCurrencyAmountInWords " & m_intInvoiceID & ", '" & CommonFunction.General.BuildQueryString(Left(Trim(m_strBillingCurrencyAmountInWords & ""), 1000)) & "'"
            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

            ' Get the RFI Status.		
            Dim drRFI As IDataReader
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFIs " & m_intRFIID

            drRFI = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drRFI.Read Then
                m_strCurrentStatus = Trim(CType(CommonFunction.Data.CheckIsDBNull(drRFI.Item("CurrentStatus")), String) & "")
            End If
            CommonFunction.Data.DisposeDataReader(drRFI)

            Dim strScript As String
            If m_strMode.ToUpper = "NEW" Then
                m_strOnloadClientScript = "window.open('../General/SendEmail_Attatchment.aspx?MessageID=56&INVOICEID=" & m_intInvoiceID.ToString & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
            End If

            'Generate the report for Invoice
            Dim strFilePath As String
            Dim strFileName As String
            'Generate the report
            ''Commented By PrashantSJ on 22nd Aug 2007 
            ''Purpose: no need to have this function here which is actualy called from sendemail_attachemnt page
            'If m_strFromDetails = "1" Then
            '    GenerateInvoiceReport(m_intInvoiceID, strFilePath, strFileName)
            'End If
            ''End of comment by PrashantSJ on 22nd Aug 2007
            'Write the necessary client side script
            strScript = "<script>" + vbCrLf
            strScript += "var strParentPage;" + vbCrLf
            strScript += "strParentPage = new String();" + vbCrLf
            strScript += "strParentPage = window.opener.location.href;" + vbCrLf

            strScript += "if (strParentPage.toUpperCase().indexOf('RFI_RFI.ASPX') != -1)" + vbCrLf
            strScript += "{" + vbCrLf
            If m_strCurrentStatus = RFI_STATUS_CLOSED Then
                'Go back to list page of invoice generation
                'If it is the Invoice list page, then close the window
                strScript += "var objParent=GetParentFormReference('frmRFI_RFI');" + vbCrLf
                strScript += "if(objParent!=null)" + vbCrLf
                strScript += "{" + vbCrLf
                strScript += "objParent.action=objParent.action + '&FromGenerate=1'" + ";" + vbCrLf
                strScript += "objParent.submit();" + vbCrLf
                strScript += "}" + vbCrLf

            Else
                strScript += "var objtxtRFIID=GetParentObjectReference('frmRFI_RFI','txtRFIID');" + vbCrLf
                strScript += "objtxtRFIID.value=""0"";" + vbCrLf
                strScript += "var objParent=GetParentFormReference('frmRFI_RFI');" + vbCrLf
                strScript += "if(objParent!=null)" + vbCrLf
                strScript += "{" + vbCrLf
                strScript += "objParent.action=replaceSubstring(replaceSubstring(replaceSubstring(objParent.action, ""&Action=Save&"", ""&""), ""&Action=Copy&"", ""&""), ""&RFIID=&"", ""&RFIID=<%=m_intRFIID%>&"");" + vbCrLf
                strScript += "objParent.submit();" + vbCrLf
                strScript += "}" + vbCrLf
            End If
            strScript += "}" + vbCrLf

            ''Added by PrashantSJ on 6th June 2007 For WhizibleSEM 7.0 Build 3
            ''Purpose: To get page refershed after save on invoice list page.
            strScript += "else { refreshParent('frmCommonList','CommonList.aspx','../General/CommonList.aspx?FromWhere=FA&MasterTagId=2084'); } " + vbCrLf
            ''End of addition by PrashantSJ on 6th June 2007

            '            strScript += "if (strParentPage.toUpperCase().indexOf('COMMONLIST.ASPX') != -1)" + vbCrLf
            '            strScript += "{" + vbCrLf'

            'strScript += "}" + vbCrLf

            If m_strOnloadClientScript <> "" Then
                strScript += m_strOnloadClientScript + vbCrLf
            End If

            strScript += "window.close();" + vbCrLf
            strScript += "</script>" + vbCrLf
            Response.Write(strScript)
        End If

    End Sub
    '====================================================================
    ' Procedure Name        :   PlotUI
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To plot the UI for invoice generation screen
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                : DipaliS
    ' Created               : August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub PlotUI()
        PlotHiddenControls()
        '=====================================================================
        '	STEP 1 : FILL CHECKLIST
        '=====================================================================
        Dim strHTML As String
        strHTML += "<Div id=""ActiveDiv1"" > "
        'Menu
        strHTML += GetMenuForCheckList()
        'Legend
        strHTML += GetPageLegend()
        'Page Header
        strHTML += GetPageHeader()
        'Page Caption
        strHTML += GetPageCaption("Checklist")
        'Grid
        strHTML += PlotGridForCheckList()
        'Footer
        strHTML += GetPageFooter()
        'Menu
        strHTML += GetMenuForCheckList()
        strHTML += "</Div>"

        '=====================================================================
        '	STEP 2 : FILL INVOICE DETAILS
        '=====================================================================
        strHTML += "<div id=ActiveDiv2 style='display:none; visibility:hidden'>"
        'Menu
        strHTML += GetMenuForInvoiceDetails()
        'Legend
        strHTML += GetPageLegend()

        strHTML += "<div id=divList style='overflow:auto; width:100%;height:100%'>"
        'Page Header
        strHTML += GetPageHeader()
        'Page Caption
        strHTML += GetPageCaption("InvoiceDetails")
        'UI
        strHTML += PlotUIForInvoiceDetails()
        strHTML += "</div>"
        'Footer
        strHTML += GetPageFooter()
        'Menu
        strHTML += GetMenuForInvoiceDetails()
        strHTML += "</Div>"

        '=====================================================================
        '	STEP 3 : FILL SALES COMMISSION INFORMATION
        '=====================================================================
        strHTML += "<div id=ActiveDiv3 style='display:none; visibility:hidden'>"
        'Menu
        strHTML += GetMenuForSalesCommission()
        'Legend
        strHTML += GetPageLegend()
        'Page Header
        strHTML += GetPageHeader()
        'Page Caption
        strHTML += GetPageCaption("SalesCommission")
        'UI
        strHTML += PlotUIForSalesCommision()
        'Footer
        strHTML += GetPageFooter()
        'Menu
        strHTML += GetMenuForSalesCommission()
        strHTML += "</Div>"
        '=====================================================================
        '	STEP 4 : FILL TAX DETAILS
        '=====================================================================
        strHTML += "<div id=ActiveDiv4 style='display:none; visibility:hidden'>"
        'Menu
        strHTML += GetMenuForTaxDetails()
        'Legend
        strHTML += GetPageLegend()
        'Page Header
        strHTML += GetPageHeader()
        'Page Caption
        strHTML += GetPageCaption("TaxDetails")
        'UI
        strHTML += PlotUIForTaxDetails()
        'Footer
        strHTML += GetPageFooter()
        'Menu
        strHTML += GetMenuForTaxDetails()
        strHTML += "</Div>"

        Response.Write(strHTML)

    End Sub
    '====================================================================
    ' Procedure Name        :   PlotHiddenControls
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To plot Hidden controls on page
    ' Description           :   Same as above         
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                : DipaliS
    ' Created               : August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub PlotHiddenControls()
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtUseFormContents", "txtUseFormContents", , , , "1", , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtRFIID", "txtRFIID", , , , m_intRFIID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtInvoiceID", "txtInvoiceID", , , , m_intInvoiceID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtProjectID", "txtProjectID", , , , m_intProjectID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtRFITypeID", "txtRFITypeID", , , , m_intRFITypeID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtChecklistID", "txtChecklistID", , , , m_intChecklistID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtChecklistInstanceID", "txtChecklistInstanceID", , , , m_intChecklistInstanceID.ToString, , , , , , True, EnableHTMLEncode:=True)
        'Current Date
        CommonFunction.HTMLControls.DrawTextBox("txtCurrentDate", "txtCurrentDate", , , , CommonFunction.Dates.GetDate(Now()).ToString, , , , , , True, EnableHTMLEncode:=True)
        'Sales Period Start Date
        CommonFunction.HTMLControls.DrawTextBox("txtSPStartDate", "txtSPStartDate", , , , CommonFunction.Dates.GetDate(m_dtmSalesPeriodStartDate).ToString, , , , , , True, EnableHTMLEncode:=True)
        'Sales Period End Date
        CommonFunction.HTMLControls.DrawTextBox("txtSPEndDate", "txtSPEndDate", , , , CommonFunction.Dates.GetDate(m_dtmSalesPeriodEndDate).ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtFromDetails", "txtFromDetails", , , , m_strFromDetails, , , , , , True, EnableHTMLEncode:=True)
        'Added By JyotiG
        'Start
        'Date : 20-Sep-2006
        'Issue Id : 6197
        CommonFunction.HTMLControls.DrawTextBox("txtCreditDays", "txtCreditDays", , , , m_dblCreditDays.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtToken", "txtToken", , , , Request.QueryString("PKToken"), , , False, , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtLoadFrom", "txtLoadFrom", , , , CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("LoadFrom"), "List"), String), , , False, , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        'End
    End Sub
    '====================================================================
    ' Procedure Name        :   GetMenuForCheckList
    ' Parameters Passed     :   None
    ' Returns               :   String contaning menu for CheckList
    ' Parameters Affected   :   None
    ' Purpose               :   Gives the menu for Checklist
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetMenuForCheckList() As String
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        'Display the static menu
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        'Save
        If m_blnReadOnly = False Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            ArrClientSideFunctionsList.Add("Save_OnClick()")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        End If

        MyBase.InitializeResources("AppResources.RFI_InvoiceGeneration", "AppResources")

        'Next
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GOBACK2STEP2"))
        ArrClientSideFunctionsList.Add("GoToStep2_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GO2STEP2_TOOLTIP"))

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'Show History
        If m_blnAuditTrailExists Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_SHOWHISTORY"))
            ArrClientSideFunctionsList.Add("ShowHistory_OnClick(" & TAG_ID & "," & m_intInvoiceID & "," & m_intProjectID & ")")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_SHOWHISTORY_TOOLTIP"))
        End If

        'Close
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))

        'Help
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('INV_GEN_FILL_CHECKLIST')")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))

        'Convert arraylist to array - Menu captions
        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing


        m_objMenuForStep1 = New WebPages.UI.cStaticMenu
        m_objMenuForStep1.MenuNames = ArrMenuCaptions
        m_objMenuForStep1.ToolTip = ArrMenuToolTips
        m_objMenuForStep1.returnHTML = True
        m_objMenuForStep1.ClientSideFunctionNames = ArrClientSideFunctions
        m_objMenuForStep1.clsTable = "clsTable"
        m_objMenuForStep1.clsTR = "clsTRMenu"
        m_objMenuForStep1.MenuAlignment = "right"
        m_objMenuForStep1.TableStyle = "cellspacing=0 cellpadding=0 width='100%'"
        m_objMenuForStep1.LinkSeperator = "|"
        m_objMenuForStep1.Action_NavigationSchema = WebPages.UI.cStaticMenu.DynamicAction_NavigationSchema.CLASSICAL
        Dim strMenu As String = m_objMenuForStep1.DrawMenu()
        m_objMenuForStep1 = Nothing

        MyBase.InitializeResources("AppResources.RFI_InvoiceGeneration", "AppResources")
        Return strMenu
    End Function
    '=====================================================================
    ' Procedure Name        : GetGlobalObject()	
    ' Purpose               : Function To Fill Global Object
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub
    '=====================================================================
    ' Procedure Name        : GetTagAccessRights()	
    ' Purpose               : Function To Get access rights for selected TAG
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : PrashantSJ
    ' Created               : July 3, 2007
    ' Revisions             :
    '=====================================================================
    Private Sub GetTagAccessRights()
        m_objGlobal.TagID = CommonFunction.Constants.APP_TAG_RFI_INVOICE_DETAIL_LIST
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub
    '====================================================================
    ' Procedure Name        :   GetPageHeader
    ' Parameters Passed     :   None  
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   To plot the header for page
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetPageHeader() As String
        Dim objHeader As New WebPages.Template.HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER
        Dim strHeader As String = objHeader.DrawHeaderFooter(m_objGlobal, True) & ""
        If strHeader.Trim <> "" Then strHeader = "<BR>"
        objHeader = Nothing
        Return strHeader
    End Function
    '====================================================================
    ' Procedure Name        :   GetPageFooter
    ' Parameters Passed     :   None  
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   To plot the Footer for page
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetPageFooter() As String
        Dim objFooter As New WebPages.Template.HeaderFooter
        objFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_FOOTER
        Dim strHeader As String = objFooter.DrawHeaderFooter(m_objGlobal, True) & ""
        If strHeader.Trim <> "" Then strHeader = "<BR>"
        objFooter = Nothing
        Return strHeader
    End Function
    '====================================================================
    ' Procedure Name        :   GetPageCaption
    ' Parameters Passed     :   Screen Name
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   Get teh page caption
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetPageCaption(ByVal ScreenName As String) As String
        Dim strCaption As String
        strCaption = "<BR>"
        Select Case ScreenName.ToUpper
            Case "CHECKLIST"
                strCaption += WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_CHK"), , , True)
            Case "INVOICEDETAILS"
                strCaption += WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_INVOICE"), , , True)
            Case "INVOICEITEMS"
                strCaption += WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_INVOICE_ITEMS"), , , True)
            Case "SALESCOMMISSION"
                strCaption += WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_SALES"), , , True)
            Case "TAXDETAILS"
                strCaption += WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_TAX"), , , True)
        End Select

        strCaption += "<BR>"
        Return strCaption
    End Function
    '====================================================================
    ' Procedure Name        :   PlotGridForCheckList
    ' Parameters Passed     :   None
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   To plot the grid for checklist
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function PlotGridForCheckList() As String
        Dim strGrid As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        m_objGrid = New WebPages.Template.AdvancedGrid

        Dim arrActualColumnArray() As String = {"", "RFIChecklistItem", "", ""}

        Dim arrUserFriendlyArray() As String = {MyBase.GetResourceString("SR_NO"), _
                                              MyBase.GetResourceString("CHKITEM"), _
                                                MyBase.GetResourceString("YES"), _
                                                MyBase.GetResourceString("COMMENTS")}

        m_objGrid.ActualColumnArray = arrActualColumnArray
        m_objGrid.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGrid.DIVID = "divList"
        m_objGrid.DIVStyle = "overflow:auto;width:100%"

        m_objGrid.UseSQL = MyBase.UseSQL
        m_objGrid.SQL = GetQueryForCheckList()
        m_objGrid.PrimaryKey = "RFIChecklistItemID"
        m_objGrid.NoOfDataColumns = 1
        m_objGrid.returnHTML = True
        'Added By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        m_objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strGrid = m_objGrid.DrawGrid()
        m_objGrid = Nothing
        Return strGrid
    End Function
    ' Procedure Name        :   GetQueryForCheckList
    ' Parameters Passed     :   None
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   To Get the SQL for CheckList Grid
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetQueryForCheckList() As String
        ' Build Query to get the list of Checklist Items.
        Dim strSQLQuery As String
        strSQLQuery = "Exec usp_Sel_tbl_PM_RFIChecklist_Items_ForInvoiceGeneration " & m_intChecklistID

        ' If the invoice is already generated, then use the previously filled checklist instance.
        If m_intChecklistInstanceID <> 0 Then
            strSQLQuery = strSQLQuery & ", " & m_intChecklistInstanceID
            ' If invoice is being genrated for the first time then use the RFI checklist instance.
        ElseIf m_intRFIChecklistInstanceID <> 0 Then
            strSQLQuery = strSQLQuery & ", " & m_intRFIChecklistInstanceID
        End If

        Return strSQLQuery

    End Function

    '====================================================================
    ' Procedure Name        :   GetMenuForInvoiceDetails
    ' Parameters Passed     :   None
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   To plot Menu for Invoice Details
    ' Description           :   Same as Above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetMenuForInvoiceDetails() As String
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        'Display the static menu
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        'Save
        If m_blnReadOnly = False Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            ArrClientSideFunctionsList.Add("Save_OnClick()")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        End If

        MyBase.InitializeResources("AppResources.RFI_InvoiceGeneration", "AppResources")

        'Next
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GOBACK2STEP2"))
        ArrClientSideFunctionsList.Add("GoToStep3_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GOTOSTEP3_TOOLTIP"))

        'Back
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GOBACK2STEP1"))
        ArrClientSideFunctionsList.Add("GoBackToStep1_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GOBACK2STEP1_TOOLTIP"))

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'Show History
        If m_blnAuditTrailExists Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_SHOWHISTORY"))
            ArrClientSideFunctionsList.Add("ShowHistory_OnClick(" & TAG_ID & "," & m_intInvoiceID & "," & m_intProjectID & ")")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_SHOWHISTORY_TOOLTIP"))
        End If

        'Close
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))

        'Help
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('INV_GEN_INVOICE_DETAILS')")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))

        'Convert arraylist to array - Menu captions
        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing


        m_objMenuForStep2 = New WebPages.UI.cStaticMenu
        m_objMenuForStep2.MenuNames = ArrMenuCaptions
        m_objMenuForStep2.ToolTip = ArrMenuToolTips
        m_objMenuForStep2.ClientSideFunctionNames = ArrClientSideFunctions
        m_objMenuForStep2.returnHTML = True
        m_objMenuForStep2.clsTable = "clsTable"
        m_objMenuForStep2.clsTR = "clsTRMenu"
        m_objMenuForStep2.MenuAlignment = "right"
        m_objMenuForStep2.TableStyle = "cellspacing=0 cellpadding=0 width='100%'"
        m_objMenuForStep2.LinkSeperator = "|"
        m_objMenuForStep2.Action_NavigationSchema = WebPages.UI.cStaticMenu.DynamicAction_NavigationSchema.CLASSICAL
        Dim strMenu As String = m_objMenuForStep2.DrawMenu()
        m_objMenuForStep2 = Nothing
        MyBase.InitializeResources("AppResources.RFI_InvoiceGeneration", "AppResources")
        Return strMenu
    End Function
    '====================================================================
    ' Procedure Name        :   GetPageLegend
    ' Parameters Passed     :   None
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   To plot page legend
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                : DipaliS
    ' Created               : August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetPageLegend() As String
        Dim strLegend As String
        'Legend
        Dim objLegend As WebPages.Template.PageLegends
        objLegend = New WebPages.Template.PageLegends
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        strLegend = objLegend.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True)
        objLegend = Nothing
        Return strLegend
    End Function
    '====================================================================
    ' Procedure Name        :   PlotUIForInvoiceDetails
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   None
    ' Description           :   Plots the UI for Invoice Details
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function PlotUIForInvoiceDetails() As String
        Dim strInvoiceDetails As String
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        strInvoiceDetails = "<table class=clsTable CellSpacing=0 width=99.9%>"
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        strInvoiceDetails += "<tr class=clsTREven><td align=right>"
        strInvoiceDetails += MyBase.GetResourceString("INVDATE")
        strInvoiceDetails += "</td><td align=left>"
        strInvoiceDetails += CommonFunction.HTMLControls.DrawDateControl("txtInvoiceDate", "txtInvoiceDate", , , CommonFunction.Dates.GetDate(m_dtmInvoiceDate), , "frmRFI_InvoiceGeneration", , , , , , , True, True)
        strInvoiceDetails += "</td><td align=right>"
        strInvoiceDetails += MyBase.GetResourceString("DUEDATE")
        strInvoiceDetails += "</td><td  align=left>"
        strInvoiceDetails += CommonFunction.HTMLControls.DrawDateControl("txtDueDate", "txtDueDate", , , CommonFunction.Dates.GetDate(m_dtmDueDate), , "frmRFI_InvoiceGeneration", , , , , , , True, True)
        strInvoiceDetails += "</td></tr>"
        'Modified by TruptiK on 7-May-2007 to adjust the controls on th UI
        strInvoiceDetails += "<tr class=clsTREven><td align=right width=15% valign=top>"
        strInvoiceDetails += MyBase.GetResourceString("CUSTOMER")
        strInvoiceDetails += "</td><td valign=top width =50% >"
        Dim strSQL As String = "Exec usp_Sel_tbl_PM_Customer_RFI NULL, '" & m_strProjectOrProduct & "'"
        strInvoiceDetails += CommonFunction.HTMLControls.DrawComboBox("cboCustomerID", strSQL, 250, m_intCustomerID.ToString, "disabled", False, True, , True)
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strInvoiceDetails += CommonFunction.HTMLControls.DrawTextBox("txtCustomerAddressID", "txtCustomerAddressID", , , , m_intCustomerAddressID.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

        'Modified By VidyaJ - Security issue - 6197
        Dim strToken As String
        strToken = CommonFunctions.Security.Token.GetToken(m_intCustomerAddressID.ToString + Session("intUserID").ToString + "0" + "2114")

        strInvoiceDetails += "<A href=" + "javascript:CustomerAddress_OnClick('" + strToken + "')" + " title='" + MyBase.GetResourceString("SELECTADDRTITLE") + _
                        "'><B>" + MyBase.GetResourceString("SELECTADDRESS") + "</B></A> "

        strInvoiceDetails += "</td><td align=right width=15%>"
        strInvoiceDetails += MyBase.GetResourceString("CURRENCY")
        strInvoiceDetails += "</td><td  align=left width=25%>"
        'End of modification by TruptiK on 7-May-2007
        strSQL = "Exec usp_Sel_tbl_PM_CurrencyMaster "
        strInvoiceDetails += CommonFunction.HTMLControls.DrawComboBox("cboBillingCurrencyID", strSQL, 50, m_intBillingCurrencyID.ToString, "disabled", , True, , True)
        strInvoiceDetails += "</td></tr>"
        strInvoiceDetails += "<tr class=clsTREven><td valign=top align=right>"
        strInvoiceDetails += MyBase.GetResourceString("CONTACTPERSON")
        strInvoiceDetails += "	</td><td valign=top>	"
        strSQL = "Exec usp_Sel_tbl_PM_CustomerContactPersons " & m_intCustomerID
        strInvoiceDetails += CommonFunction.HTMLControls.DrawComboBox("cboCustomerContactID", strSQL, 200, m_intCustomerContactID.ToString, "onchange=""javascript:cboCustomerContactID_OnChange()""", True, True, , True)
        'Hidden combo box for emailIDS
        strSQL = "Exec usp_Sel_tbl_PM_CustomerContactPersons_EmailID " & m_intCustomerID
        strInvoiceDetails += CommonFunctions.HTMLControls.DrawComboBox("cboCustomerContactEmailID", strSQL, , m_intCustomerContactID.ToString, , True, True, , , , True)
        strInvoiceDetails += "</td><td align=right>"
        strInvoiceDetails += MyBase.GetResourceString("MODEOFPAY")
        strInvoiceDetails += "	</td><td align=left>"
        strSQL = "Exec usp_Sel_tbl_PM_PaymentModeMaster "
        strInvoiceDetails += CommonFunction.HTMLControls.DrawComboBox("cboPaymentModeID", strSQL, 200, m_intPaymentModeID.ToString, , True, True, , True)
        strInvoiceDetails += "</td></tr>"
        strInvoiceDetails += "<tr class=clsTREven><td valign=top align=right>"
        strInvoiceDetails += MyBase.GetResourceString("EMAILCONFIRM")
        strInvoiceDetails += "</td><td valign=top >"
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strInvoiceDetails += CommonFunctions.HTMLControls.DrawTextBox("txtConfirmEmailID", "txtConfirmEmailID", , 200, 100, m_strConfirmEmailID, , , , True, , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strInvoiceDetails += "</td>"
        'Commented  AND Added by TruptiK on 22-Jun-2007
        '<td valign=top >"
        'strInvoiceDetails += "&nbsp;</td><td valign=top >&nbsp;</td></tr>"
        strInvoiceDetails += "<td align=right>"
        strInvoiceDetails += MyBase.GetResourceString("TERMSANDCOND")
        strInvoiceDetails += "</td><td align=left>"
        strSQL = "Exec Usp_sel_TermsAndConditions"
        strInvoiceDetails += CommonFunction.HTMLControls.DrawComboBox("cboTermsAndConditionsID", strSQL, 200, m_TermsAndConditionsID.ToString, , True, True)
        strInvoiceDetails += "</td>"
        strInvoiceDetails += "<tr class=clsTREven><td valign=top align=right>"
        strInvoiceDetails += MyBase.GetResourceString("BANK")
        strInvoiceDetails += "</td><td valign=top>"
        strSQL = "Exec usp_Sel_tbl_PM_BankMaster"
        strInvoiceDetails += CommonFunction.HTMLControls.DrawComboBox("cboBankID", strSQL, 200, m_intBankID.ToString, , True, True)
        strInvoiceDetails += "	</td><td align=right>"
        strInvoiceDetails += MyBase.GetResourceString("CONTRACT")
        strInvoiceDetails += "</td><td align=left>"
        strSQL = "Exec usp_Sel_tbl_PM_ContractMaster_RFI " & m_intCustomerID
        strInvoiceDetails += CommonFunction.HTMLControls.DrawComboBox("cboContractID", strSQL, 200, m_intContractID.ToString, , True, True, , True)
        strInvoiceDetails += "</td></tr>"
        '</table><br>"
        ''''''''''''Added by PrashantSJ on 3 July 2007 For WhizibleSEM 7.0
        ''''''''''''Purpose: Added Extra Field 
        'Added by TruptiK on 22-Jun-2007
        strInvoiceDetails += "<tr class=clsTREven><td valign=top align=right>"
        strInvoiceDetails += MyBase.GetResourceString("GOVTINVOICENO")
        strInvoiceDetails += "</td><td align=left>"
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strInvoiceDetails += CommonFunctions.HTMLControls.DrawTextBox("txtGovtInvoiceNo", "txtGovtInvoiceNo", , 150, 20, m_GovtInvoiceNumber.ToString, , , , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strInvoiceDetails += "</td>"
        strInvoiceDetails += "<td valign=top align=right>"
        strInvoiceDetails += "<a Href='javascript:SelectSalesPeriod()'>" + "Sales Period" + "</A></td>"
        strInvoiceDetails += "<td valign=top>"
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strInvoiceDetails += CommonFunctions.HTMLControls.DrawTextBox("txtSalesPeriodID", "txtSalesPeriodID", , , , m_intSalesPeriodID.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        strInvoiceDetails += CommonFunctions.HTMLControls.DrawTextBox("txtSalesPeriod", "txtSalesPeriod", , 150, 100, m_strSalesPeriod.ToString, , , , True, , , , True, True, , , , 7, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strInvoiceDetails += "</td>"
        strInvoiceDetails += "</tr>"

        strInvoiceDetails += "<tr class=clsTREven><td valign=top align=right>"
        strInvoiceDetails += MyBase.GetResourceString("PONUMBER")
        strInvoiceDetails += "</td><td align=left>"
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strInvoiceDetails += CommonFunctions.HTMLControls.DrawTextBox("txtPONo", "txtPONo", , 150, 20, m_sPONumber, , , , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strInvoiceDetails += "</td>"
        strInvoiceDetails += "<td align=right>"
        strInvoiceDetails += MyBase.GetResourceString("PODATE")
        strInvoiceDetails += "</td>"
        strInvoiceDetails += "<td align=left>"
        strInvoiceDetails += CommonFunction.HTMLControls.DrawDateControl("txtPODate", "txtPODate", , , m_dtmPODate, , "frmRFI_InvoiceGeneration", , , , , , , True, )
        strInvoiceDetails += "</td>"
        strInvoiceDetails += "</tr></table><br>"

        '''''''''''''End of addition by PrashantSJ on 3 July 2007 For WhizibleSEM 7.0
        'End of addition by TruptiK 22-Jun-2007
        strInvoiceDetails += GetItemDetailsForInvoice()
        Return strInvoiceDetails
    End Function
    '====================================================================
    ' Procedure Name        :   GetItemDetailsForInvoice
    ' Parameters Passed     :   None
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   To plot the UI for Invoice Item Details
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               : August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetItemDetailsForInvoice() As String
        Dim strItemDetails As String
        strItemDetails = GetPageCaption("INVOICEITEMS")
        strItemDetails += GetMenuForInvoiceItems()
        'Get the Attributes for Current RFI Type
        GetRFITypeAttributes(m_intRFITypeID)
        strItemDetails += PlotGridForItems()
        Return strItemDetails
    End Function
    '====================================================================
    ' Procedure Name        :   GetMenuForInvoiceItems
    ' Parameters Passed     :   None
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   To Plot the menu for Invoice Items
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                : DipaliS
    ' Created               : August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetMenuForInvoiceItems() As String
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        'Display the static menu
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SELECTALL"), _
                                    MyBase.GetResourceString("MENU_CLEARALL"), _
                                    MyBase.GetResourceString("MENU_Help")}

        Dim arrClientSideFunctions() As String = {"SelectAll_OnClick('chkRFIItemID')", "ClearAll_OnClick('chkRFIItemID')", "Help_OnClick('INV_GEN_INVOICE_DETAILS')"}

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_Help_TOOLTIP")}

        Dim objMenu As New WebPages.Template.StaticMenu
        Dim strMenu As String = objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        objMenu = Nothing

        MyBase.InitializeResources("AppResources.RFI_InvoiceGeneration", "AppResources")

        Return strMenu
    End Function

    '=====================================================================
    ' Procedure Name		:	GetRFITypeAttributes
    ' Purpose				:	To get the attributes related to the specified RFI Type.
    ' Description			:	Same as above.
    ' Parameters Passed		:	RFITypeID		:- The RFI Type ID.	
    ' Parameters Affected	:	None.
    ' Returns				:	No return values.
    ' Assumptions			:	None.
    ' Dependencies			:	None.
    ' Author				:	DipaliS
    ' Created				:	31 July 2004
    ' Revisions				:
    '=====================================================================	

    Sub GetRFITypeAttributes(ByVal RFITypeID As Integer)

        Dim drRFITypeAttributes As IDataReader
        Dim drRFIForCount As IDataReader
        Dim strSQLQuery As String
        Dim intCtr As Integer

        strSQLQuery = "Exec usp_Sel_tbl_PM_RFITypes_ItemAttributes " & RFITypeID
        drRFITypeAttributes = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        drRFIForCount = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        Dim intCount As Integer
        While drRFIForCount.Read
            intCount = intCount + 1
        End While

        If intCount > 0 Then
            ReDim arrRFITypeAttributes(intCount - 1, 4)
        Else
            ReDim arrRFITypeAttributes(0, 4)
        End If

        intCtr = 0

        Do While drRFITypeAttributes.Read And intCtr < intCount

            arrRFITypeAttributes(intCtr, 0) = Trim(CType(CommonFunctions.General.CheckIsNothing(drRFITypeAttributes.Item("FieldName")), String) & "")
            arrRFITypeAttributes(intCtr, 1) = Trim(CType(CommonFunctions.General.CheckIsNothing(drRFITypeAttributes.Item("UserFriendlyCaption")), String) & "")
            arrRFITypeAttributes(intCtr, 2) = CType(CommonFunctions.General.CheckIsNothing(drRFITypeAttributes.Item("IsMandatory")), String)
            arrRFITypeAttributes(intCtr, 3) = Trim(CType(CommonFunctions.General.CheckIsNothing(drRFITypeAttributes.Item("ControlTypeID")), String) & "")
            If Trim(CType(CommonFunctions.General.CheckIsNothing(drRFITypeAttributes.Item("StoredProcedure")), String) & "") <> "" Then
                arrRFITypeAttributes(intCtr, 4) = "BEGIN TRANSACTION" & vbCrLf & Trim(CType(drRFITypeAttributes.Item("StoredProcedure"), String) & "") & vbCrLf & "ROLLBACK TRANSACTION"
            End If
            intCtr = intCtr + 1
        Loop
        CommonFunctions.Data.DisposeDataReader(drRFITypeAttributes)
        CommonFunctions.Data.DisposeDataReader(drRFIForCount)

    End Sub

    '====================================================================
    ' Procedure Name        :   PlotGridForItems
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None 
    ' Purpose               :   To Plot the Grid fot Items 
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 06 2004
    ' Revisions             :
    '=====================================================================

    Private Function PlotGridForItems() As String
        m_objGridforItems = New WebPages.Template.AdvancedGrid
        Dim intCtr As Integer
        Dim strsql As String

        Dim arrActualColumnArray() As String

        Dim arrUserFriendlyArray() As String

        Dim arrSummary() As String
        Dim arrTDStyle() As String
        Dim strGrid As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'ReDim arrActualColumnArray(UBound(arrRFITypeAttributes) + 4)
        'ReDim arrUserFriendlyArray(UBound(arrRFITypeAttributes) + 4)
        'ReDim arrSummary(UBound(arrRFITypeAttributes) + 4)
        'ReDim arrTDStyle(UBound(arrRFITypeAttributes) + 4)
        ''Added and commented by PrashantSJ on 31st July 2006
        ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
        ReDim arrActualColumnArray(UBound(arrRFITypeAttributes) + 5)
        ReDim arrUserFriendlyArray(UBound(arrRFITypeAttributes) + 5)
        ReDim arrSummary(UBound(arrRFITypeAttributes) + 5)
        ReDim arrTDStyle(UBound(arrRFITypeAttributes) + 5)
        ''End of addition by PrashantSJ on 31st July 2006

        Dim intCounter As Integer
        For intCounter = 0 To UBound(arrRFITypeAttributes) + 4
            arrTDStyle(intCounter) = ""
        Next

        'Fill the array for Grid
        For intCtr = 0 To UBound(arrRFITypeAttributes)
            arrUserFriendlyArray(intCtr) = arrRFITypeAttributes(intCtr, 1)
            arrActualColumnArray(intCtr) = arrRFITypeAttributes(intCtr, 0)
            If arrRFITypeAttributes(intCtr, 0) = "Rate" Or arrRFITypeAttributes(intCtr, 0) = "Amount" Then
                arrUserFriendlyArray(intCtr) += "(" & m_strBillingCurrencyCode + ")"
            End If
            If arrRFITypeAttributes(intCtr, 0) = "Amount" Then
                arrSummary(intCtr) = ""
            Else
                arrSummary(intCtr) = ""
            End If
        Next
        arrUserFriendlyArray(intCtr) = MyBase.GetResourceString("EQUIVAMOUNT").Replace("<code>", m_strBaseCurrencyCode)
        arrActualColumnArray(intCtr) = "BaseCurrencyAmount"
        arrSummary(intCtr) = ""
        ''Added and commented by PrashantSJ on 31st July 2006
        ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
        'If m_blnMultipleAccounts = True Then
        '    arrUserFriendlyArray(intCtr + 1) = MyBase.GetResourceString("ACCOUNT")
        '    arrActualColumnArray(intCtr + 1) = ""
        '    arrTDStyle(intCtr + 1) = " align=center "
        'End If

        'arrUserFriendlyArray(intCtr + 2) = MyBase.GetResourceString("SELECT")
        'arrActualColumnArray(intCtr + 2) = ""
        arrUserFriendlyArray(intCtr + 1) = MyBase.GetResourceString("EQUIVAMOUNTCOMPANY").Replace("<code>", m_strCompanyBaseCurrencyCode)
        arrActualColumnArray(intCtr + 1) = "CompanyBaseCurrencyAmount"
        arrSummary(intCtr + 1) = ""

        If m_blnMultipleAccounts = True Then
            arrUserFriendlyArray(intCtr + 2) = MyBase.GetResourceString("ACCOUNT")
            arrActualColumnArray(intCtr + 2) = ""
            arrTDStyle(intCtr + 2) = " align=center "
        End If

        arrUserFriendlyArray(intCtr + 3) = MyBase.GetResourceString("SELECT")
        arrActualColumnArray(intCtr + 3) = ""
        ''End of addition by PrashantSJ on 31st July 2006


        m_dblItem_TotalBaseCurrencyAmount = 0
        m_dblItem_TotalBillingCurrencyAmount = 0

        ''Added and commented by PrashantSJ on 31st July 2006
        ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
        m_dblItem_TotalCompanyBaseCurrencyAmount = 0
        ''End of addition by PrashantSJ on 31st July 2006
        strsql = "Exec usp_Sel_tbl_PM_RFI_Items_ForInvoiceGeneration " & m_intRFIID.ToString
        If m_intInvoiceID <> 0 Then
            strsql = strsql & ", " & m_intInvoiceID
        End If

        m_objGridforItems.ActualColumnArray = arrActualColumnArray
        m_objGridforItems.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGridforItems.DIVID = "divRFItems"
        m_objGridforItems.DIVStyle = "Overflow:auto;width=100%"
        m_objGridforItems.DIVHeight = 250
        m_objGridforItems.TDStyleArray = arrTDStyle

        m_objGridforItems.UseSQL = MyBase.UseSQL
        m_objGridforItems.SQL = strsql
        m_objGridforItems.PrimaryKey = "RFIItemID"
        If m_blnMultipleAccounts = True Then
            ''Added and commented by PrashantSJ on 31st July 2006
            ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
            'm_objGridforItems.NoOfDataColumns = UBound(arrRFITypeAttributes) + 3
            m_objGridforItems.NoOfDataColumns = UBound(arrRFITypeAttributes) + 4
            ''End of addition by PrashantSJ on 31st July 2006
        Else
            ''Added and commented by PrashantSJ on 31st July 2006
            ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
            'm_objGridforItems.NoOfDataColumns = UBound(arrRFITypeAttributes) + 2
            m_objGridforItems.NoOfDataColumns = UBound(arrRFITypeAttributes) + 3
            ''End of addition by PrashantSJ on 31st July 2006
        End If
        m_objGridforItems.ShowSummaryFunctions = True
        m_objGridforItems.SummaryFunctions = arrSummary
        m_objGridforItems.returnHTML = True
        'Added By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        m_objGridforItems.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strGrid = m_objGridforItems.DrawGrid()
        m_objGridforItems = Nothing

        Return strGrid

    End Function

    '====================================================================
    ' Procedure Name        :   GetMenuForSalesCommission
    ' Parameters Passed     :   None
    ' Returns               :   String contaning menu for Sales Commission
    ' Parameters Affected   :   None
    ' Purpose               :   Gives the menu for Sales Commission
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 06, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetMenuForSalesCommission() As String
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        'Display the static menu
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        'Save
        If m_blnReadOnly = False Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            ArrClientSideFunctionsList.Add("Save_OnClick()")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        End If

        MyBase.InitializeResources("AppResources.RFI_InvoiceGeneration", "AppResources")

        'Next
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GOBACK2STEP2"))
        ArrClientSideFunctionsList.Add("GoToStep4_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GOTOSTEP4_TOOLTIP"))

        'Back
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GOBACK2STEP1"))
        ArrClientSideFunctionsList.Add("GoBackToStep2_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GOBACK2STEP2_TOOLTIP"))

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'Show History
        If m_blnAuditTrailExists Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_SHOWHISTORY"))
            ArrClientSideFunctionsList.Add("ShowHistory_OnClick(" & TAG_ID & "," & m_intInvoiceID & "," & m_intProjectID & ")")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_SHOWHISTORY_TOOLTIP"))
        End If

        'Close
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))

        'Help
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('INV_GEN_SALES_COMM')")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))

        'Convert arraylist to array - Menu captions
        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing


        m_objMenuForStep3 = New WebPages.UI.cStaticMenu
        m_objMenuForStep3.MenuNames = ArrMenuCaptions
        m_objMenuForStep3.ToolTip = ArrMenuToolTips
        m_objMenuForStep3.ClientSideFunctionNames = ArrClientSideFunctions
        m_objMenuForStep3.returnHTML = True
        m_objMenuForStep3.clsTable = "clsTable"
        m_objMenuForStep3.clsTR = "clsTRMenu"
        m_objMenuForStep3.MenuAlignment = "right"
        m_objMenuForStep3.TableStyle = "cellspacing=0 cellpadding=0 width='100%'"
        m_objMenuForStep3.LinkSeperator = "|"
        m_objMenuForStep3.Action_NavigationSchema = WebPages.UI.cStaticMenu.DynamicAction_NavigationSchema.CLASSICAL
        Dim strMenu As String = m_objMenuForStep3.DrawMenu()
        m_objMenuForStep3 = Nothing
        MyBase.InitializeResources("AppResources.RFI_InvoiceGeneration", "AppResources")
        Return strMenu
    End Function
    '====================================================================
    ' Procedure Name        :   PlotUIForSalesCommision
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To plot the UI for Sales Commission
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 07, 2004
    ' Revisions             :
    '=====================================================================
    Private Function PlotUIForSalesCommision() As String
        Dim strSales As String
        Dim strSQLQuery As String = "Exec usp_Sel_tbl_PM_RFIs_SalesPersons_ForInvoiceGeneration " & m_intProjectID
        ' The RFI ID.
        If m_intRFIID <> 0 Then
            strSQLQuery = strSQLQuery & ", " & m_intRFIID
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If
        ' The Invoice ID.
        If m_intInvoiceID <> 0 Then
            strSQLQuery = strSQLQuery & ", " & m_intInvoiceID
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        m_objGridForSalesPersons = New WebPages.Template.AdvancedGrid

        Dim arrActualColumnArray() As String = {"ElementName", "", ""}

        Dim arrUserFriendlyArray() As String = {MyBase.GetResourceString("SALESPERSON"), _
                                              MyBase.GetResourceString("SALESCOMMISSION"), _
                                                MyBase.GetResourceString("SELECT")}

        Dim arrTDStyle() As String = {"", "align=center", ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        m_objGridForSalesPersons.ActualColumnArray = arrActualColumnArray
        m_objGridForSalesPersons.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGridForSalesPersons.DIVID = "divList"
        m_objGridForSalesPersons.DIVStyle = "overflow:auto;width:100%;"

        m_objGridForSalesPersons.UseSQL = MyBase.UseSQL
        m_objGridForSalesPersons.SQL = strSQLQuery
        m_objGridForSalesPersons.PrimaryKey = "ElementID"
        m_objGridForSalesPersons.NoOfDataColumns = 2
        m_objGridForSalesPersons.returnHTML = True
        m_objGridForSalesPersons.TDStyleArray = arrTDStyle
        'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        m_objGridForSalesPersons.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        strSales = m_objGridForSalesPersons.DrawGrid()
        m_objGridForSalesPersons = Nothing

        Return strSales
    End Function
    '====================================================================
    ' Procedure Name        :   GetMenuForTaxDetails
    ' Parameters Passed     :   None
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   Plots the string for Tax Details menu
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 07, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetMenuForTaxDetails() As String
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        'Display the static menu
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        'Save
        If m_blnReadOnly = False Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            ArrClientSideFunctionsList.Add("Save_OnClick()")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        End If

        MyBase.InitializeResources("AppResources.RFI_InvoiceGeneration", "AppResources")

        'Back
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GOBACK2STEP1"))
        ArrClientSideFunctionsList.Add("GoBackToStep3_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GOBACK2STEP3_TOOLTIP"))

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'Show History
        If m_blnAuditTrailExists Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_SHOWHISTORY"))
            ArrClientSideFunctionsList.Add("ShowHistory_OnClick(" & TAG_ID & "," & m_intInvoiceID & "," & m_intProjectID & ")")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_SHOWHISTORY_TOOLTIP"))
        End If

        'Close
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))

        'Help
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('INV_GEN_TAX_DETAILS')")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))

        'Convert arraylist to array - Menu captions
        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing


        m_objMenuForStep4 = New WebPages.UI.cStaticMenu
        m_objMenuForStep4.MenuNames = ArrMenuCaptions
        m_objMenuForStep4.ToolTip = ArrMenuToolTips
        m_objMenuForStep4.ClientSideFunctionNames = ArrClientSideFunctions
        m_objMenuForStep4.returnHTML = True
        m_objMenuForStep4.clsTable = "clsTable"
        m_objMenuForStep4.clsTR = "clsTRMenu"
        m_objMenuForStep4.MenuAlignment = "right"
        m_objMenuForStep4.TableStyle = "cellspacing=0 cellpadding=0 width='100%'"
        m_objMenuForStep4.LinkSeperator = "|"
        m_objMenuForStep4.Action_NavigationSchema = WebPages.UI.cStaticMenu.DynamicAction_NavigationSchema.CLASSICAL
        Dim strMenu As String = m_objMenuForStep4.DrawMenu()
        m_objMenuForStep4 = Nothing

        MyBase.InitializeResources("AppResources.RFI_InvoiceGeneration", "AppResources")
        Return strMenu
    End Function
    '====================================================================
    ' Procedure Name        :   PlotUIForTaxDetails
    ' Parameters Passed     :   NOne
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   To plot the UI for Tax Details
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   NOne
    ' Author                :   DipaliS
    ' Created               :   August 07, 2004
    ' Revisions             :
    '=====================================================================

    Private Function PlotUIForTaxDetails() As String
        Dim strTax As String
        Dim strSQLQuery As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Dummy SQL for 5 rows
        strSQLQuery = "Select '1' Union Select '2' union Select '3' union Select '4' union Select'5'"
        ''''''''''''Added and commented by PrashantSJ on 3rd Aug 2007 For WhizibleSEM 7.0
        ''''''''''''Purpose: Always enable add link while adding tax for newly generated or generated invoice
        'm_intPrevTaxID = 0
        m_intPrevTaxID = 1
        ''''''''''''''End of addition by PrashantSJ on 3rd Aug 2007
        ''''''''''
        m_intCounterForTax = 1

        m_objGridForTaxDetails = New WebPages.Template.AdvancedGrid

        Dim arrActualColumnArray() As String = {"", "", "", "", ""}

        Dim arrUserFriendlyArray() As String = {MyBase.GetResourceString("TAXNO"), _
                                              MyBase.GetResourceString("TAX"), _
                                                MyBase.GetResourceString("FORMULA"), _
                                                MyBase.GetResourceString("TAXPER"), _
                                                MyBase.GetResourceString("ADDEDIT")}

        m_objGridForTaxDetails.ActualColumnArray = arrActualColumnArray
        m_objGridForTaxDetails.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGridForTaxDetails.DIVID = "divList"
        m_objGridForTaxDetails.DIVStyle = "overflow:auto;width:100%;"

        m_objGridForTaxDetails.UseSQL = MyBase.UseSQL
        m_objGridForTaxDetails.SQL = strSQLQuery
        m_objGridForTaxDetails.PrimaryKey = "TaxID"
        m_objGridForTaxDetails.NoOfDataColumns = 1
        m_objGridForTaxDetails.returnHTML = True
        'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        m_objGridForTaxDetails.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        strTax = m_objGridForTaxDetails.DrawGrid()
        m_objGrid = Nothing

        Return strTax
    End Function
    Function GenerateInvoiceReport(ByVal intInvoiceID As Integer, ByRef strFilePath As String, ByRef strFileName As String) As Boolean
        '=====================================================================
        ' Procedure Name        :	GenerateInvoiceReport
        ' Purpose               :	To generate the invoice report.
        ' Description           :	Same as above.	
        ' Parameters Passed     :	intInvoiceID		:- Invoice ID.		
        '							strFilePath			:- The File Path.
        '							strFileName			:- The File Name.	
        ' Parameters Affected   :   strFilePath, strFileName variables will be set.
        ' Returns               :	True  :- If the .zip file was generated successfully.
        '							False :- If the .zip file was not generated successfully.
        ' Assumptions           :	None.
        ' Dependencies          :	Commonfunctions.asp
        ' Author                :	DipaliS
        ' Created               :	10 Aug 2004
        ' Revisions             :	
        '=====================================================================

        Dim strSQLQuery As String      ' The SQL Query.
        Dim blnRecordsFound As Boolean      ' Flag to check whether records exist for the report.

        Dim drInvoice As IDataReader     ' Recordset variable to retrieve the Invoice details.
        Dim strInvoiceNumber As String    ' The Invoice Number.

        Dim drReport As IDataReader      ' Recordset variable to retrieve the Invoice report details.
        Dim intInvoiceReportID As Integer    ' The Invoice Report ID.		
        Dim strSPName As String      ' The Stored Procedure Name. [This SP will be used to generate the invoice report.]
        Dim intFormatID As Integer     ' The Format ID for the report. [1->.pdf;  2->.htm; 3->.xls; 4->.rtf; 5->.csv; 6->.txt]



        Dim strFilePath_Local As String    ' The path of the file. [.PDF file of the invoice]
        Dim strFileName_Local As String    ' The name of the file.										

        'Dim objFileSystemObject   ' File System object for checking the existence of the report generated.		

        ' Initialize the return parameters. Only after the .pdf file is created successfully, these parameters will be set.
        strFilePath = ""
        strFileName = ""

        ' Get the invoice details.
        strSQLQuery = "Exec usp_Sel_tbl_PM_RFIInvoices " & intInvoiceID

        drInvoice = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        If drInvoice.Read Then
            strInvoiceNumber = Trim(CType(CommonFunction.Data.CheckIsDBNull(drInvoice("InvoiceNumber")), String) & "")
            intInvoiceReportID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice("InvoiceReportID"), "0"), Integer)
            strFileName_Local = strInvoiceNumber
        End If

        CommonFunction.Data.DisposeDataReader(drInvoice)

        ' Get the report details.		
        strSQLQuery = "Exec usp_sel_tbl_CRW_Report_Master_ForRFI " & intInvoiceReportID

        'Remove the '/' from the Invoice Number for the name of Report
        strFileName_Local = strFileName_Local.Replace("/", "")
        'Aded by PrashantSJ on 5th June 2007 For WhizbieSEM 7.- Build 3
        'Purpose: To avoid crash when filename having special character
        strFileName_Local = strFileName_Local.Replace("\", "")
        strFileName_Local = strFileName_Local.Replace("*", "")
        strFileName_Local = strFileName_Local.Replace("""", "")
        strFileName_Local = strFileName_Local.Replace("?", "")
        strFileName_Local = strFileName_Local.Replace("@", "")
        strFileName_Local = strFileName_Local.Replace("|", "")
        strFileName_Local = strFileName_Local.Replace("<", "")
        strFileName_Local = strFileName_Local.Replace(">", "")
        strFileName_Local = strFileName_Local.Replace(":", "")

        'End of Comment and addition by PrashantSJ on 5th June 2007 For WhizbieSEM 7.- Build 3

        drReport = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        If drReport.Read Then
            strSPName = Trim(CType(CommonFunction.Data.CheckIsDBNull(drReport("SpName")), String) & "")
        End If
        CommonFunction.Data.DisposeDataReader(drReport)

        ' PDF Format.
        intFormatID = 1

        ' Initialize the flag indicating whether records are present for the SP specified.
        blnRecordsFound = False

        ' Checking for existence of records before invoking the report.
        strSQLQuery = strSPName & " " & intInvoiceID

        drReport = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        If drReport.Read Then
            blnRecordsFound = True
        End If
        CommonFunction.Data.DisposeDataReader(drReport)

        ' If no records are found, exit the function.
        If blnRecordsFound = False Then
            Exit Function
        End If

        ' Get the file name to be used. [The Invoice Number will be used as the file name.]
        strFilePath_Local = "../../Reports/" & strFileName_Local & ".pdf"
        'strFilePath_Local = "../../Reports/" & CommonFunctions.FileDirectory.GetUniqueFileName(".pdf")

        ' Create the report object.
        Dim objReport As New AdHocReports.Report.AdHocReport(CInt(intInvoiceReportID), strSPName & " " & intInvoiceID, CommonFunctions.Application.ConnectionString, Server.MapPath(strFilePath_Local), CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))

        With objReport
            .UseMSSQL = MyBase.UseSQL
            .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
            .LCID = MyBase.CurrentThreadUICultureID
            If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                .UseHashTables = True
            Else
                .UseHashTables = False
            End If
            .CompanyName = CommonFunctions.Application.CompanyName
            .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
        End With


        ' Generate the report in .PDF format. [FormatID for .PDF files = 1]
        'If objReport.GenerateReport(AdHocReports.Format.PDF) = True Then
        'Ask Mrugaja
        'End If

        objReport = Nothing

        ' Check for the existence of the file. If the file does not exist, then exit the function.

        Dim objFileSystemObject As CommonFunction.FileDirectory
        objFileSystemObject = New CommonFunction.FileDirectory
        If objFileSystemObject.IsFileExists(Server.MapPath(strFilePath_Local)) Then
            Exit Function
        End If
        objFileSystemObject = Nothing

        strFilePath = strFilePath_Local
        strFileName = strFileName_Local

        Return True
    End Function
#End Region

#Region "Grid Events"
    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        m_intCounter = m_intCounter + 1
    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim intChecklistItemID As Integer
        Dim intChecklistInstanceItemID As Integer
        intChecklistItemID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RFIChecklistItemID"), "0"), Integer)

        ' Applicable only if the invoice checklist is filled.	
        If m_intChecklistInstanceID <> 0 Then
            intChecklistInstanceItemID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RFIChecklistInstanceItemID"), "0"), Integer)
        End If

        Select Case Args.ColIndex
            Case 0
                Cancel = True
                Args.StringToBeInserted = "<td  valign=top align=right>" + m_intCounter.ToString + "</td>"
            Case 1
                Cancel = True
                ''Commented and Added By Vidya J ON 1 Sep 2016 For MasterCard NextGen Upgrade
                'Args.StringToBeInserted = _
                '"<td  valign=top>" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RFIChecklistItem")), String) + _
                '"<input type=hidden id=txtChecklistItemID name=txtChecklistItemID value=" + intChecklistItemID.ToString + ">" + vbCrLf + _
                ' "<input type=hidden id=txtChecklistInstanceItemID name=txtChecklistInstanceItemID value=" + intChecklistInstanceItemID.ToString + ">" + _
                ' "</td>"
                Args.StringToBeInserted = _
                "<td  valign=top>" + CType(CommonFunction.Data.CheckIsDBNull(HttpUtility.HtmlEncode(Args.DataReader.Item("RFIChecklistItem"))), String) + _
                "<input type=hidden id=txtChecklistItemID name=txtChecklistItemID value=" + intChecklistItemID.ToString + ">" + vbCrLf + _
                 "<input type=hidden id=txtChecklistInstanceItemID name=txtChecklistInstanceItemID value=" + intChecklistInstanceItemID.ToString + ">" + _
                 "</td>"
                ''End Of Commented and Added By Vidya J ON 1 Sep 2016 For MasterCard NextGen Upgrade
            Case 2
                Cancel = True
                Dim strToBeInserted As String
                If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("RFIChecklistItemResponse"), "false"), Boolean) = True Then
                    strToBeInserted = "checked"
                End If

                Args.StringToBeInserted = "<td valign=top>" + _
                                "<input type=checkbox id=chkChecklistItemResponse name=chkChecklistItemResponse" + intChecklistItemID.ToString + _
                                    " value = " + intChecklistItemID.ToString + " " + strToBeInserted + " >"

            Case 3
                Cancel = True
                'Modified By ShraddhaM on 27 July 2006
                Args.StringToBeInserted = "<td  valign=top>" + _
                                          CommonFunctions.HTMLControls.DrawTextArea("txtComments" + intChecklistItemID.ToString, "txtComments", , , , , , , 200, 60, 2000, CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("Comments")), String), , , , , , , , True, , , , , , , "Soft", , EnableHTMLEncode:=True) + _
                                        "</td>"

        End Select


    End Sub


    Private Sub m_objGridforItems_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridforItems.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "BASECURRENCYAMOUNT" Then
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted = CommonFunction.HTMLControls.DrawTextBox("txtItemBaseCurrencyAmount" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RFIItemID")), String), "txtItemBaseCurrencyAmount", , , , CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("BaseCurrencyAmount")), String), , , , , , True, , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        End If
        ''Added and commented by PrashantSJ on 31st July 2006
        ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
        If Args.DataField.ToUpper = "COMPANYBASECURRENCYAMOUNT" Then
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted = CommonFunction.HTMLControls.DrawTextBox("txtItemCompanyBaseCurrencyAmount" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RFIItemID")), String), "txtItemCompanyBaseCurrencyAmount", , , , CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("CompanyBaseCurrencyAmount")), String), , , , , , True, , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        End If

        ''End of addition by PrashantSJ on 31st July 2006
        If Args.ColIndex <= UBound(arrRFITypeAttributes) Then
            If CommonFunctions.General.CheckIsNothing(arrRFITypeAttributes(Args.ColIndex, 0), "").ToUpper = "AMOUNT" Then
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                Args.StringToBeInserted = CommonFunction.HTMLControls.DrawTextBox("txtItemBillingCurrencyAmount" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RFIItemID")), String), "txtItemBillingCurrencyAmount", , , , CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("Amount")), String), , , , , , True, , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            End If
        End If

        'Combo box for Account
        ''Added and commented by PrashantSJ on 31st July 2006
        ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
        'If Args.ColIndex = UBound(arrRFITypeAttributes) + 2 Then
        If Args.ColIndex = UBound(arrRFITypeAttributes) + 3 Then
            ''End of addition by PrashantSJ on 31st July 2006
            Cancel = True
            Args.StringToBeInserted = "<td align=center>"
            If m_blnMultipleAccounts Then

                Dim strSQL As String = "Exec usp_Sel_tbl_PM_AccountsMaster"
                If (m_intInvoiceID = 0) Or (m_intInvoiceID <> 0 And Trim(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("InvoiceItemID")), String) & "") <> "") Then
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawComboBox("cboAccountID" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RFIItemID")), String), strSQL, , CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("AccountID")), String), , True, True, , True)
                Else
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawComboBox("cboAccountID" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RFIItemID")), String), strSQL, , CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("AccountID")), String), "disabled", True, True, , True)
                End If
            End If
            Args.StringToBeInserted += "</td>"
        End If
        'CheckBox For Select
        ''Added and commented by PrashantSJ on 31st July 2006
        ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
        'If Args.ColIndex = UBound(arrRFITypeAttributes) + 3 Then
        If Args.ColIndex = UBound(arrRFITypeAttributes) + 4 Then
            ''End of addition by PrashantSJ on 31st July 2006
            Dim blnChecked As Boolean
            Cancel = True
            Args.StringToBeInserted = "<td>"
            If (m_intInvoiceID = 0) Or (m_intInvoiceID <> 0 And Trim(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("InvoiceItemID")), String) & "") <> "") Then
                blnChecked = True
                If Trim(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("BaseCurrencyAmount")), String) & "") <> "" Then
                    m_dblItem_TotalBaseCurrencyAmount = m_dblItem_TotalBaseCurrencyAmount + CType(FormatNumber(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("BaseCurrencyAmount")), String), 2), Double)
                End If
                If Trim(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("Amount")), String) & "") <> "" Then
                    m_dblItem_TotalBillingCurrencyAmount = CDbl(m_dblItem_TotalBillingCurrencyAmount) + CDbl(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("Amount"), "0"))
                End If
                ''Added and commented by PrashantSJ on 31st July 2006
                ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
                If Trim(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("CompanyBaseCurrencyAmount")), String) & "") <> "" Then
                    m_dblItem_TotalCompanyBaseCurrencyAmount += CType(FormatNumber(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("CompanyBaseCurrencyAmount")), String), 2), Double)
                End If
                ''End of addition by PrashantSJ on 31st July 2006
            End If
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkRFIItemID", "chkRFIItemID", , blnChecked, CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RFIItemID")), String), , " onclick='javascript:chkRFIItemID_Click(this)'", True)
            Args.StringToBeInserted += "</td>"
        End If
    End Sub

    Private Sub m_objGridforItems_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objGridforItems.SummaryFunctionsTD_BeforePrint
        'Totals

        If Args.ColIndex <= UBound(arrRFITypeAttributes) Then
            If arrRFITypeAttributes(Args.ColIndex, 0).ToUpper = "AMOUNT" Then
                Cancel = True
                Args.StringToBeInserted = "<td align=right><LABEL id=lblBillingCurrencyAmount>" + FormatNumber(m_dblItem_TotalBillingCurrencyAmount, 2) + "</LABEL>"
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtBillingCurrencyAmount", "txtBillingCurrencyAmount", , , , m_dblItem_TotalBillingCurrencyAmount.ToString, , , , , , True, , True, EnableHTMLEncode:=True) + "</td>"
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            End If
        ElseIf Args.ColIndex = UBound(arrRFITypeAttributes) + 1 Then
            Cancel = True
            Args.StringToBeInserted = "<td align=right><LABEL id=lblBaseCurrencyAmount>" + FormatNumber(m_dblItem_TotalBaseCurrencyAmount, 2) + "</LABEL>"
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtBaseCurrencyAmount", "txtBaseCurrencyAmount", , , , m_dblItem_TotalBaseCurrencyAmount.ToString, , , , , , True, , True, EnableHTMLEncode:=True) + "</td>"
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            ''Added and commented by PrashantSJ on 31st July 2006
            ''Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
        ElseIf Args.ColIndex = UBound(arrRFITypeAttributes) + 2 Then
            Cancel = True
            Args.StringToBeInserted = "<td align=right><LABEL id=lblCompanyBaseCurrencyAmount>" + FormatNumber(m_dblItem_TotalCompanyBaseCurrencyAmount, 2) + "</LABEL>"
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtCompanyBaseCurrencyAmount", "txtCompanyBaseCurrencyAmount", , , , m_dblItem_TotalCompanyBaseCurrencyAmount.ToString, , , , , , True, , True, EnableHTMLEncode:=True) + "</td>"
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        End If
        ''End of addition by PrashantSJ on 31st July 2006

        If Args.ColIndex <= UBound(arrRFITypeAttributes) Then
            If arrRFITypeAttributes(Args.ColIndex, 0).ToUpper = "ITEMDESCRIPTION" Then
                Cancel = True
                Args.StringToBeInserted = "<td>" + MyBase.GetResourceString("TOTALAMOUNT") + "</td>"
            End If
        End If
    End Sub

    Private Sub m_objGridForSalesPersons_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridForSalesPersons.DataRowTD_BeforePrint
        'Insert textbox for Sales Commission Percentage
        If Args.ColIndex = 1 Then
            Cancel = True
            Dim strValue As String
            Dim blnDisabled As Boolean
            If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("Selected"), "false"), Boolean) = False Then
                blnDisabled = True
            End If
            strValue = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("SalesCommissionPercentage")), String)
            'Integrated by TruptiK on 19-May-09
            'Comment and Modification by SuchitraP on 19-Mar-2009 for IssueID: 29345
            'Invoice>invoice Generation> User is not able to edit the sales commission .(Mozilla)	
            'Args.StringToBeInserted = "<td align=center>" + CommonFunction.HTMLControls.DrawTextBox("txtSalesCommissionPercentage" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ElementID")), String), "txtSalesCommissionPercentage", , 50, 6, strValue, "right", , blnDisabled, , , , , True) + "</td>"
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted = "<td align=center>" + CommonFunction.HTMLControls.DrawTextBox("txtSalesCommissionPercentage" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ElementID")), String), "txtSalesCommissionPercentage" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ElementID")), String), , 50, 6, strValue, "right", , blnDisabled, , , , , True, EnableHTMLEncode:=True) + "</td>"
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            'End of Comment and modification by SuchitraP on 19-Mar-2009 for IssueID: 29345
            'end of Integrated by TruptiK on 19-May-09
        End If
        'CheckBox 
        If Args.ColIndex = 2 Then
            Cancel = True
            Dim blnChecked As Boolean
            If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("Selected"), "false"), Boolean) = False Then
                blnChecked = False
            Else
                blnChecked = True
            End If
            'Integrated by TruptiK on 19-May-09
             'Comment and Modification by SuchitraP on 19-Mar-2009 for IssueID: 29345
            'Invoice>invoice Generation> User is not able to edit the sales commission .(Mozilla)	
            'Args.StringToBeInserted = "<td>" + CommonFunction.HTMLControls.DrawCheckBox("chkSalesPersonID", "chkSalesPersonID" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ElementID")), String), , blnChecked, CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ElementID")), String), , " onclick='javascript:chkSalesPersonID_Click()'", True) + "</td>"
            Args.StringToBeInserted = "<td>" + CommonFunction.HTMLControls.DrawCheckBox("chkSalesPersonID", "chkSalesPersonID" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ElementID")), String), , blnChecked, CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ElementID")), String), , " onclick='javascript:chkSalesPersonID_Click(" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ElementID")), String) + ")'", True) + "</td>"
            'End of Comment and modification by SuchitraP on 19-Mar-2009 for IssueID: 29345
            'Integrated by TruptiK on 19-May-09
        End If

    End Sub

    Private Sub m_objGridForTaxDetails_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGridForTaxDetails.DataRowTR_BeforePrint
        gridintTaxID = m_arrTaxDetails(m_intCounterForTax, 0)
        griddblTaxPercentage = m_arrTaxDetails(m_intCounterForTax, 1)
        gridstrTaxFormula = ""
        gridstrTaxName = ""
        Dim strSQLQuery As String
        ' Get the Tax Details.
        If gridintTaxID <> "" Then
            strSQLQuery = "Exec usp_Sel_tbl_PM_TaxMaster " & gridintTaxID
            Dim drTax As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drTax.Read Then
                gridstrTaxFormula = Trim(CType(CommonFunction.Data.CheckIsDBNull(drTax.Item("Formula")), String) & "")
                gridstrTaxName = Trim(CType(CommonFunction.Data.CheckIsDBNull(drTax.Item("TaxName")), String) & "")
            End If
            CommonFunction.Data.DisposeDataReader(drTax)
        End If


    End Sub

    Private Sub m_objGridForTaxDetails_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridForTaxDetails.DataRowTD_BeforePrint
        'Tax Number
        Dim strtobeinserted As String
        If Args.ColIndex = 0 Then
            strtobeinserted = MyBase.GetResourceString("TAX") + m_intCounterForTax.ToString
        End If
        If Args.ColIndex = 1 Then
            Dim strSQLQuery As String
            strtobeinserted += "<LABEL id=lblTaxID" + m_intCounterForTax.ToString + ">" + gridstrTaxName + "</LABEL>"
            strSQLQuery = "Exec usp_Sel_tbl_PM_TaxMaster NULL, 'TaxAmount" & m_intCounterForTax & "', 1"
            If gridintTaxID <> "" Then
                strSQLQuery = strSQLQuery & ", " & gridintTaxID
            End If
            strtobeinserted += CommonFunction.HTMLControls.DrawComboBox("cboTaxID" + m_intCounterForTax.ToString, strSQLQuery, 200, gridintTaxID, "onchange='javascript:cboTaxID_OnChange(" & m_intCounterForTax & ")' style='display:none; visibility:hidden'", True, True)
            Dim drTax As IDataReader
            drTax = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            strtobeinserted += " <SELECT id=cboTaxAttributes" + m_intCounterForTax.ToString + " style='display:none; visibility:hidden'>"
            strtobeinserted += "<OPTION value="" ""></OPTION>"
            While drTax.Read
                strtobeinserted += "<OPTION value="""
                If Trim(CType(CommonFunction.Data.CheckIsDBNull(drTax.Item("StandardTaxPercentage")), String) & "") <> "" Then
                    'Added by PrashantSJ on 15 March 2007 For Tax (should accept decimal also)
                    'strtobeinserted += FormatNumber(Trim(CType(CommonFunction.Data.CheckIsDBNull(drTax.Item("StandardTaxPercentage")), String) & ""), 1, , , TriState.False)
                    strtobeinserted += CType(CommonFunction.Data.CheckIsDBNull(drTax.Item("StandardTaxPercentage")), String)
                    'End of addition by PrashantSJ
                End If
                strtobeinserted += """ "

                If gridintTaxID = Trim(CType(CommonFunction.Data.CheckIsDBNull(drTax.Item("TaxID")), String) & "") Then
                    strtobeinserted += " selected"
                End If
                strtobeinserted += ">" + Trim(CType(CommonFunction.Data.CheckIsDBNull(drTax.Item("Formula")), String) & "") + " </OPTION>"
            End While
            CommonFunction.Data.DisposeDataReader(drTax)
            strtobeinserted += " </SELECT>"
        End If
        If Args.ColIndex = 2 Then
            strtobeinserted = "<LABEL id=lblTaxFormula" + m_intCounterForTax.ToString + " name=lblTaxFormula" + m_intCounterForTax.ToString + ">" + gridstrTaxFormula + "</LABEL>"
        End If
        If Args.ColIndex = 3 Then
            strtobeinserted = "<LABEL id=lblTaxPercentage" + m_intCounterForTax.ToString + ">"
            If griddblTaxPercentage <> "" Then
                'Added by PrashantSJ on 15 March 2007 For Tax (should accept decimal also)
                'strtobeinserted += FormatNumber(griddblTaxPercentage, 1, , , TriState.False)
                strtobeinserted += griddblTaxPercentage
                'End of addition by PrashantSJ 
            End If
            strtobeinserted += "</LABEL>"
            Dim strTextValue As String
            If griddblTaxPercentage <> "" Then
                'Added by PrashantSJ on 15 March 2007 For Tax (should accept decimal also)
                'strTextValue = FormatNumber(griddblTaxPercentage, 1, , , TriState.False)
                strTextValue = griddblTaxPercentage
                'End of addition by PrashantSJ 
            End If
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            strtobeinserted += CommonFunction.HTMLControls.DrawTextBox("txtTaxPercentage" + m_intCounterForTax.ToString, "txtTaxPercentage" + m_intCounterForTax.ToString, , , 7, strTextValue, , , , , , , "style='width:50; display:none; visibility:hidden'", True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        End If
        If Args.ColIndex = 4 Then
            strtobeinserted = "<LABEL id=lblAddOrEdit" + m_intCounterForTax.ToString + ">"
            If gridintTaxID <> "" Then
                strtobeinserted += "<A href='javascript:AddOrEdit_OnClick(" + m_intCounterForTax.ToString + ")'>" + MyBase.GetResourceString("EDIT") + "</A>"
            ElseIf m_intPrevTaxID = 0 Then
                strtobeinserted += MyBase.GetResourceString("N/A")
            Else
                strtobeinserted += "<A href='javascript:AddOrEdit_OnClick(" + m_intCounterForTax.ToString + ")'>" + MyBase.GetResourceString("ADD") + "</A>"
            End If
            strtobeinserted += "</LABEL>"
        End If

        Cancel = True
        Args.StringToBeInserted = "<td>" + strtobeinserted + "</td>"
        strtobeinserted = ""
    End Sub

    Private Sub m_objGridForTaxDetails_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGridForTaxDetails.DataRowTR_AfterPrint
        If m_arrTaxDetails(m_intCounterForTax, 0) <> "" Then
            m_intPrevTaxID = CType(m_arrTaxDetails(m_intCounterForTax, 0), Integer)
        Else
            m_intPrevTaxID = 0
        End If
        m_intCounterForTax += 1
    End Sub

#End Region

#Region "Menu Events"
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenuForStep1.Before_Link_Print, m_objMenuForStep2.Before_Link_Print, m_objMenuForStep3.Before_Link_Print, m_objMenuForStep4.Before_Link_Print
        If Args.LinkName.ToUpper = "SAVE" Then
            If m_objAccessRights.Edit = False Then
                Cancel = True
            Else
                'Modified By VarunA on 25-Sep-2008 IssueID-22570
                'Purpose : To have name of the label in Mozilla
                'Args.StringToBeInserted = "<LABEL id=lblSave style='display:none; visibility:hidden'>"
                Args.StringToBeInserted = "<LABEL id=lblSave name='lblSave' style='display:none; visibility:hidden'>"
                'End By VarunA on 25-Sep-2008 IssueID-22570
            End If
        End If
    End Sub

    Private Sub m_objMenu_After_Link_Print(ByRef Args As WAF_Menu_Links) Handles m_objMenuForStep1.After_Link_Print, m_objMenuForStep2.After_Link_Print, m_objMenuForStep3.After_Link_Print, m_objMenuForStep4.After_Link_Print
        If Args.LinkName.ToUpper = "SAVE" Then
            Args.StringToBeInserted = "</LABEL>"
        End If
    End Sub
#End Region



    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
       
    End Sub
End Class
