'=====================================================================
' Module Name   :   RFI Details Page
' Purpose       :   To Display the Details of RFI
' Description   :   Same as above
' Dependencies  :   Resource file for the same
' Author        :   DipaliS
' Created       :   August 28, 2004
' Revisions     :
'=====================================================================

Public Class RFI_RFI
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
    Protected m_intRFIID As Integer
    Protected m_strMode As String
    'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
    Protected m_strToken As String
    Protected m_strItemToken As String
    Protected m_strNewItemToken As String
    Protected m_strSubmitToken As String
    Protected m_arrToken As String
    ''Added by PrashantSJ on 02 July 2007 Fow WhizibleSEM 7.0 
    ''Purpose to have common global object for menu
    Protected WithEvents objMenu As WebPages.Template.StaticMenu
    Private m_objAccessRights As WebPages.Security.cAccessRights
    ''End of addition by PrashantSJ 02 July 2007 Fow WhizibleSEM 7.0 

    'End of addition by MonikaI

'Added by       : ShubhadaL
    'Added on       :  26 Aug,2005
    'Purpose        :  to check contract expiry date.

    Protected m_VerifyExpDtStr As String = ""
    Protected m_verifyBit As Integer = 0
    'End of addition by ShubhadaL

    Protected m_strBaseCurrencyCode As String
    Protected m_strLocalCurrencyCode As String
    Private m_strCurrentStatus As String
    Private m_strProjectOrProduct As String
    Private m_strBillingCurrencyCode As String
    Private m_intCheckListInstanceId As Integer
    Protected m_intRFITypeID As Integer
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected m_strUserType As String
    Private m_intFilter_IsProforma As Integer
    Private m_intFilter_TypeID As Integer
    Private m_strFilter_Status As String
    Private m_intFilter_CustomerID As Integer
    Private m_intFilter_SalesPeriodID As Integer
    Private m_intFilter_ProjectID As Integer
    Protected m_intProjectID As Long
    Private m_blnIsProforma As Boolean
    Protected m_blnReadOnly As Boolean
    Private m_intTotalRFIItemCount As Integer
    Private m_intCreditDays As Integer
    Protected m_intCustomerID As Integer
    Protected m_intCustomerAddressID As Integer
    Protected m_intBillingCurrencyID As Integer
    Private m_intCustomerContactID As Integer
    Private m_strLOC As String = ""
    Private m_strConfirmEmailID As String
    Private m_strRFIToolIDs As String
    Private m_strRFIToolNames As String
    Private m_intMileStoneID As Integer
    Private m_strRFIHeader As String = ""
    Protected m_intContractID As Integer
    Private m_strRFISalesPersonIDs As String
    Private m_strRFISalesPersonNames As String
    'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
    'Added By MohitS On 4th JAN 2005 
    Private m_strRFIMilestoneIDs As String
    Private m_strRFIMilestone As String
    'End of addition Mohits
    'End Integration by SavitaS on 13 Mar 2006 for IssueID-2836
    'Integrated by TruptiK on 19-Apr-2007
    ''Added by PrashantSJ on 26th July 2006
    ''Purpose: At least 2 fields required to Create RFI (i.e Description,Rate)
    Public iItemAttributeFlag As Integer
    Private m_strCompanyBaseCurrencyCode As String = ""
    ''End of addition by PrashantSJ on 26th July 2006
    'Added by PrashantSJ on 13th Oct 2006 For Bristlecon
    Private m_strRFIOSIDs As String
    Private m_strRFIOSNames As String
    Protected m_strAction As String
    Private m_strRFITypeName As String
    Private m_strCustomerName As String
    Private m_strCustomerContactName As String
    Private m_dblBaseCurrencyAmount As Double
    Protected m_sIRApproverID As String = ""
    Protected m_iContractType As Integer
    Protected m_sSQL As String = ""
    'Private m_dblCompanyBaseCurrencyAmount As Double
    Private m_strMilestoneName As String
    Public m_strContractName As String
    Private m_blnInvoiceGenerated As Boolean
    Private m_blnAddAccess As Boolean
    Private m_blnDeleteAccess As Boolean
    Private m_blnEditAccess As Boolean
    Private m_blnViewAccess As Boolean
    Private arrRFITypeAttributes(,) As String
    Private WithEvents m_objGridforItems As WebPages.Template.AdvancedGrid
    Private m_strSeperator As String = ","
    Private m_charSep() As Char = m_strSeperator.ToCharArray
    Protected m_strDeletionStatus As String
    Private m_intHelpID As Integer
    Protected m_intSalesPeriodID_OpenPeriod As Integer
    Protected m_strFormula As String
    Private m_lngTagID As Long
    Private m_lngRespPerson As Long
    Protected m_blnFormulaExists As Boolean
    'Integrated by TruptiK
    'Added by PrashantSJ on 08 Dec 2006
    'Purpose: To plot the Salesperiod Combobox (using this we can select any open salesperiod
    Private m_intSalesPeriodID As Integer
    Private m_strSalesPeriod As String = ""
    Private strToken As String
    Private m_blnIsProjectOver As Boolean
    'End of addition by PrashantSJ on 08 Dec 2006
    'End of integration by TruptiK
    'Integreated by TruptiK on 8-Apr-09
    'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
    Private blnNegativeEntry As Boolean = False
    'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
    'added by TruptiK on 24-Apr-09
    'Purpose:-Invoice discount change.
    Private strtotalamount As Double = 0
    'end of addition by TruptiK
    'End of Integrated by TruptiK
#End Region

#Region "Constants"
    Private Const RFI_INITIATOR As String = "Initiator"
    Private Const RFI_APPROVER As String = "Approver"
    Private Const RFI_ACCOUNTS_PERSON As String = "Accounts"

    Private Const RFI_STATUS_DRAFT As String = "Draft"
    Private Const RFI_STATUS_SUBMITTED As String = "Submitted"
    Private Const RFI_STATUS_RESUBMITTED As String = "Re-submitted"
    Private Const RFI_STATUS_APPROVED As String = "Approved"
    Private Const RFI_STATUS_REJECTED As String = "Rejected"
    Private Const RFI_STATUS_CANCELLED As String = "Cancelled"
    Protected WithEvents frmRFI_RFI As System.Web.UI.HtmlControls.HtmlForm
    Private Const RFI_STATUS_CLOSED As String = "Closed"
#End Region

#Region "Member Functions"

    Public Sub PageInit()
        '######### Page Code starts here
        
        'Get the Mode 
        m_strMode = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("Mode")), String)
        m_strAction = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("Action")), String)
        'Get the User Type
        If Trim(Request.Form("txtUserType")) <> "" Then
            m_strUserType = Trim(Request.Form("txtUserType"))
        ElseIf Trim(Request.QueryString("UserType")) <> "" Then
            m_strUserType = Trim(Request.QueryString("UserType"))
        End If

        If Trim(Request.QueryString("FromGenerate")) <> "" Then
            Response.Redirect("../General/Commonlist.aspx?FromWhere=FA&MasterTagID=" + CommonFunction.Constants.APP_TAG_RFI_INVOICE_GENERATION.ToString)
        End If

        If Not IsNothing(Request.QueryString("FromStatus")) Then
            If Request.QueryString("FromStatus") = "1" Then
                If m_strUserType = RFI_INITIATOR Then
                    If m_strAction.ToUpper = "SAVE" Or m_strAction.ToUpper = "COPY" Then
                        m_strAction = ""
                    End If
                Else
                    'else go back to the list page
                    If m_strUserType = RFI_APPROVER Then
                        Response.Redirect("../General/Commonlist.aspx?FromWhere=FA&MasterTagID=" + CommonFunction.Constants.APP_TAG_RFI_APPROVAL.ToString)
                    ElseIf m_strUserType = RFI_ACCOUNTS_PERSON Then
                        Response.Redirect("../General/Commonlist.aspx?FromWhere=FA&MasterTagID=" + CommonFunction.Constants.APP_TAG_RFI_INVOICE_GENERATION.ToString)
                    End If
                End If

            End If
        End If

        Select Case m_strUserType
            Case RFI_INITIATOR
                m_intHelpID = CommonFunction.Constants.APP_TAG_RFI_INITIATOR
                m_lngTagID = CommonFunction.Constants.APP_TAG_RFI_INITIATOR
            Case RFI_APPROVER
                m_intHelpID = CommonFunction.Constants.APP_TAG_RFI_APPROVAL
                m_lngTagID = CommonFunction.Constants.APP_TAG_RFI_APPROVAL
            Case RFI_ACCOUNTS_PERSON
                m_intHelpID = CommonFunction.Constants.APP_TAG_RFI_INVOICE_GENERATION
                m_lngTagID = CommonFunction.Constants.APP_TAG_RFI_INVOICE_GENERATION
        End Select

        GetGlobalObject()
        GetTagAccessRights()
      
        m_intProjectID = m_objGlobal.ProjectID

        '  m_intRFIID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RFIID")), Integer)
        If Not IsNothing(Request.QueryString("RFIID")) Then
            m_intRFIID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RFIID")), Integer)
        End If

        'PrashantSJ on 11 Dec 2006
        'one salesperiod open
        'm_intSalesPeriodID_OpenPeriod = GetOpenSalesPeriod()
        GetCurrencyCodes()
        m_strFormula = GetInvoiceNumberGenerationFormula()

        'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
        'Added by GaneshG on 16 Jan 2006 --To avoid insertion of New RFI 
        'While Selecting Milestones or Deliverables for Perticular RFI.
        If (Request.QueryString("Mode").ToUpper = "NEW" And CommonFunction.General.CheckIsNothing(Request.QueryString("SelectionFlag"), "0") = "1") Then
            m_strMode = "Edit"
            m_strAction = ""
            m_intRFIID = CType(Request.QueryString("NewRFIID"), Integer)
        End If
        'End of Addition
        'End Integration by SavitaS
        ''Added by PrashantSJ on 22 June 2007 For WhizibleSEM 7.0 
        ''Purpose: To check IR Approver before submitting IR
        If m_strUserType = RFI_INITIATOR Then


            Dim drRFI As IDataReader
            Dim m_sSQL As String = ""
            Dim m_sHTML As String = ""


            m_sSQL = "usp_Validation_IR_BillingBaseLocalCompanyBaseCurrency " & m_intProjectID
            drRFI = CommonFunction.Data.GetDataReader(m_sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drRFI.Read() Then
                m_sIRApproverID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRFI("IRApprover"), "0"), "0"), String)
            End If

            CommonFunction.Data.DisposeDataReader(drRFI)

            m_sSQL = "usp_sel_tbl_PM_Project_TaskCaseStructure " & m_intProjectID
            drRFI = CommonFunction.Data.GetDataReader(m_sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drRFI.Read() Then
                m_iContractType = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRFI("ContractType"), "0"), "0"), Integer)
                m_blnIsProjectOver = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRFI("Over"), "0"), "0"), Boolean)
            End If

            CommonFunction.Data.DisposeDataReader(drRFI)
        End If
        ''End of addition by PrashantSJ on 22nd June 2007

        Select Case m_strMode.ToUpper
            Case "NEW"
                'Check for Sales Period,Base Currency Code,local Currency Code and billing currency ID
                If RequiredDataExist() = True Then
                    BuildRFIListQuery("")
                    PlotUI()
                Else
                    'Code Modified by SandipL on 29 Nov 2005 --To solve Issue of redirecting page to invalid Login Page
                    'Server.Execute("../General/Commonlist.aspx?Fromwhere=PM&MasterTagID=2044")
                    'Response.Redirect("../General/Commonlist.aspx?Fromwhere=PM&MasterTagID=2044")
                    'Modified by Truptik on 23-May-2007
                    CommonFunction.General.WriteHTML("<script language=javascript>")
                    CommonFunction.General.WriteHTML("window.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=2044'")
                    CommonFunction.General.WriteHTML("</script>")
                    'End of Modification by Truptik on 23-May-2007 
                    'End modification by SandiPL
                End If
            Case "EDIT"

                '**********************************************************
                'Added By       :   ShubhadaL
                'Addded on      :   26 Aug,2005
                'Purpose        :   purpose		:   To check whether contract has been expired or not,if yes then dont allow to generate invoice.


                Dim strSQL As String = ""
                strSQL = "usp_IR_VerifyContractExpired " + m_intRFIID.ToString
                m_verifyBit = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Integer)

                'end of addition by ShubhadaL
                '************************************************************
                BuildRFIListQuery("")
                PlotUI()
        End Select

       
    End Sub

    Public Sub New()

        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.RFI_RFI", "AppResources")
    End Sub

    '====================================================================
    ' Procedure Name    :      RequiredDataExist
    ' Parameters Passed :      None
    ' Returns           :      True/False 
    ' Parameters Affected :    None
    ' Purpose           :      To check if all the data required for Adding New RFI is present or not 
    ' Description       :      'Check for Sales Period,Base Currency Code,local Currency Code and billing currency ID
    ' Assumptions       :      None 
    ' Dependencies      :      None  
    ' Author            :      DipaliS
    ' Created           :      July 29, 2004
    ' Revisions         :
    '=====================================================================

    Private Function RequiredDataExist() As Boolean
        Dim blnResult As Boolean
        blnResult = True
        ''Integrated by TruptiK on 26-Apr-2007
        'Commented by PrashantSJ on 11 Dec 2006
        'Purpose: To avoid to take the open sales period directly from Saleperiod master (which was previosly have only
        'one salesperiod open
        'Check for Open Sales Period
        'If GetOpenSalesPeriod() = 0 Then
        '    blnResult = False
        'End If
        'End of comment by PrashantSJ on 11 Dec 2006
        'End of integration by TruptiK 26-Apr-2007

        GetCurrencyCodes()

        'Check For Base Currency Code
        If m_strBaseCurrencyCode = "" Then
            blnResult = False
        End If

        'Check For Local Currency Code
        'If m_strLocalCurrencyCode = "" Then
        '    blnResult = False
        'End If
        'Integrated by TruptiK
        'Added by PrashantSJ on 28 Nov 2006
        'Check for Company Base Currency Code
        'If m_strCompanyBaseCurrencyCode = "" Then
        '    blnResult = False
        'End If
        'End of addition by PrashantSJ on 28 Nov 2006
        'End of integration by TruptiK
        If GetBillingCurrecyID() = 0 Then
            blnResult = False
        End If
        'Commented by PrashantSJ on 22nd June 2007 For WhizibleSEM 7.0
        ''Purpose: No requirement to check this validation at this stage which is provided at IR addition level (Cliend side)
        'Check For Responsible person for Invoice
        'GetInvoiceResponsiblePerson()
        'If m_lngRespPerson = 0 Then
        '    blnResult = False
        'End If
        ''End of addition by PrashantSJ on 22nd June 2007

        Return blnResult
    End Function

    '====================================================================
    ' Procedure Name :GetOpenSalesPeriod
    ' Parameters Passed :None
    ' Returns :The Open sales period
    ' Parameters Affected :None
    ' Purpose :To get the Open Sales Period
    ' Description :Same as above
    ' Assumptions :None
    ' Dependencies :None
    ' Author : DipaliS
    ' Created : July 29, 2004
    ' Revisions :
    '=====================================================================

    Private Function GetOpenSalesPeriod() As Integer
        Dim strSQL As String
        Dim drSalesPeriod As IDataReader
        strSQL = "Exec usp_Sel_tbl_PM_SalesPeriodMaster_GetOpenPeriod"
        drSalesPeriod = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drSalesPeriod.Read Then
            Session("OpenSalesPeriod") = CType(CommonFunction.Data.CheckIsDBNull(drSalesPeriod.Item("SalesPeriodID"), "0"), Integer)
            Return CType(CommonFunction.Data.CheckIsDBNull(drSalesPeriod.Item("SalesPeriodID"), "0"), Integer)
        Else
            Session("OpenSalesPeriod") = 0
            Return 0
        End If
        CommonFunctions.Data.DisposeDataReader(drSalesPeriod)
    End Function

    '====================================================================
    ' Procedure Name :GetCurrencyCodes
    ' Parameters Passed :None
    ' Returns :None
    ' Parameters Affected :None
    ' Purpose :To get the currency codes
    ' Description :Same as above
    ' Assumptions :None
    ' Dependencies :None
    ' Author : DipaliS
    ' Created : July 29, 2004
    ' Revisions :
    '=====================================================================

    Private Sub GetCurrencyCodes()
        Dim strSQL As String
        Dim drBaseCode As IDataReader
        strSQL = "Exec usp_InvoiceDB_GetBaseCurrencyInfo"
        drBaseCode = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drBaseCode.Read Then
            Session("BaseCurrencyCode") = CType(CommonFunction.Data.CheckIsDBNull(drBaseCode.Item("CurrencyCode"), ""), String)
            m_strBaseCurrencyCode = CType(CommonFunction.Data.CheckIsDBNull(drBaseCode.Item("CurrencyCode"), ""), String)
        Else
            Session("BaseCurrencyCode") = ""
            m_strBaseCurrencyCode = ""
        End If
        CommonFunctions.Data.DisposeDataReader(drBaseCode)

        strSQL = "Exec usp_Sel_tbl_PM_CurrencyMaster_GetLocalCurrency"
        drBaseCode = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drBaseCode.Read Then
            Session("LocalCurrencyCode") = CType(CommonFunction.Data.CheckIsDBNull(drBaseCode.Item("CurrencyCode"), ""), String)
            m_strLocalCurrencyCode = CType(CommonFunction.Data.CheckIsDBNull(drBaseCode.Item("CurrencyCode"), ""), String)
        Else
            Session("LocalCurrencyCode") = ""
            m_strLocalCurrencyCode = ""
        End If
        CommonFunctions.Data.DisposeDataReader(drBaseCode)
        'Integrated by TruptiK on 20-Apr-2007
        ''Added by PrashantSJ on 28th July 2006 
        ''Purpose: To Get the Company (IR) Base currency 
        'strSQL = "Exec usp_Sel_tbl_PM_CurrencyMaster_GetCompanyBaseCurrency " & m_objGlobal.ProjectID.ToString
        'drBaseCode = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        'If drBaseCode.Read Then
        '    Session("CompanyBaseCurrencyCode") = CType(CommonFunction.Data.CheckIsDBNull(drBaseCode.Item("CurrencyCode"), ""), String)
        '    m_strCompanyBaseCurrencyCode = CType(CommonFunction.Data.CheckIsDBNull(drBaseCode.Item("CurrencyCode"), ""), String)
        'Else
        '    Session("CompanyBaseCurrencyCode") = ""
        '    m_strCompanyBaseCurrencyCode = ""
        'End If
        'CommonFunctions.Data.DisposeDataReader(drBaseCode)
        ''End of addition by PrashantSJ on 28th July 2006 
        'End of integration by TruptiK
    End Sub

    '====================================================================
    ' Procedure Name :GetBillingCurrecyID
    ' Parameters Passed :None
    ' Returns :Billing ID for Project
    ' Parameters Affected :None
    ' Purpose :None
    ' Description :Same as above
    ' Assumptions :None
    ' Dependencies :None
    ' Author : DipaliS
    ' Created : July 29, 2004
    ' Revisions :
    '=====================================================================

    Private Function GetBillingCurrecyID() As Integer
        Dim strSQL As String
        Dim drProject As IDataReader
        strSQL = "Exec usp_Sel_tbl_PM_Project " + m_objGlobal.ProjectID.ToString
        drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drProject.Read Then
            Session("BillingCurrencyID") = CType(CommonFunction.Data.CheckIsDBNull(drProject.Item("BillingCurrencyID"), "0"), Integer)
            Return CType(CommonFunction.Data.CheckIsDBNull(drProject.Item("BillingCurrencyID"), "0"), Integer)
        Else
            Session("BillingCurrencyID") = 0
            Return 0
        End If
        CommonFunctions.Data.DisposeDataReader(drProject)
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
    ' Created               : July 29, 2004
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
        m_objGlobal.TagID = CommonFunction.Constants.APP_TAG_RFI_INITIATOR

        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub

    '====================================================================
    ' Procedure Name        :   PlotUI
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   Plots the UI for RFI Entry Screen
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 29, 2004
    ' Revisions :
    '=====================================================================

    Private Sub PlotUI()

        'Plot the required Filds
        PlotHiddenControls()

        'Perform the necessary Action
        PerformAction()

        'Get the necessary fields for plotting UI
        GetTheRequiredFields()

        'Get the other field like RFIID,Status etc
        PlotOtherHiddenControls()

        'Plot the Menu
        GetMenu()

        'Legend
        Dim objLegend As WebPages.Template.PageLegends
        objLegend = New WebPages.Template.PageLegends
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        objLegend.DrawPageLegends(m_objGlobal, arrLegendImage, arrLegend)
        objLegend = Nothing
        'Page Caption
        GetPageCaption()
        'Trupti
        Response.Write("<BR>")

        'Modified by ShraddhaM on Date 04 Jully,2006 for WhizibleSEM Issue ID.4168
        'PageDiv
        Response.Write("<div id=PageDiv style=""overflow:auto;width=100%"">")
        'Hidden Fields

        Dim strHTML As String
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        strHTML += "<table cellspacing=0 class=clsTable width=99.9%>"
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        strHTML += "<tr class=clsTREven><td  width=50%>"
        'Option Buttons for RFI/RFPI
        'RFI
        If m_blnIsProforma = False Then
            If m_blnReadOnly = True Then
                strHTML += CommonFunctions.HTMLControls.DrawOptionButton("optRequestTypeID", "optIsRFI", , True, "0", True, , True)
            Else
                strHTML += CommonFunctions.HTMLControls.DrawOptionButton("optRequestTypeID", "optIsRFI", , True, "0", False, , True)
            End If
        Else
            If m_blnReadOnly = True Then
                strHTML += CommonFunctions.HTMLControls.DrawOptionButton("optRequestTypeID", "optIsRFI", , False, "0", True, , True)
            Else
                strHTML += CommonFunctions.HTMLControls.DrawOptionButton("optRequestTypeID", "optIsRFI", , False, "0", False, , True)
            End If
        End If
        strHTML += MyBase.GetResourceString("OPTIONRFI")
        strHTML += "</td>"
        strHTML += "<td  width=50%>"

        'RFPI
        If m_blnIsProforma = True Then
            If m_blnReadOnly = True Then
                strHTML += CommonFunctions.HTMLControls.DrawOptionButton("optRequestTypeID", "optIsRFPI", , True, "1", True, , True)
            Else
                strHTML += CommonFunctions.HTMLControls.DrawOptionButton("optRequestTypeID", "optIsRFPI", , True, "1", False, , True)
            End If
        Else
            If m_blnReadOnly = True Then
                strHTML += CommonFunctions.HTMLControls.DrawOptionButton("optRequestTypeID", "optIsRFPI", , False, "1", True, , True)
            Else
                strHTML += CommonFunctions.HTMLControls.DrawOptionButton("optRequestTypeID", "optIsRFPI", , False, "1", False, , True)
            End If
        End If
        strHTML += MyBase.GetResourceString("OPTIONRFPI")
        strHTML += "</td></tr>"
        strHTML += "</table>"
        'Trupti
        strHTML += "<br>"
        Response.Write(strHTML)

        PlotControls()

        Response.Write("</div>")

        GetMenu()
    End Sub

    '====================================================================
    ' Procedure Name        :   GetMenu
    ' Parameters Passed     :   None
    ' Returns               :   none
    ' Parameters Affected   :   None
    ' Purpose               :   To Plot Menu
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 29, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub GetMenu()
        'Display the static menu
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        ' Added and Commented By NageshM on date 12th Dec 2005
        Dim strUserType As String = CommonFunction.General.CheckIsNothing(Request.QueryString("UserType"), "")
        '' Start : Modified By ParagD On 29-Sept-2006
        '' Purpose : 'Select Project TImesheet' link disappear from the page when milestone is included in a IR-PIR.
        '' If strUserType.ToString.ToUpper = "INITIATOR" Or strUserType = "" then
        If (strUserType.ToString.ToUpper = "INITIATOR" Or strUserType = "") Or m_strUserType.ToString.ToUpper = "INITIATOR" Then
            '   If strUserType.ToString.ToUpper <> "APPROVER" And strUserType.ToString.ToUpper <> "ACCOUNTS" Then
            'added By VivekP On 3 May 2005 for checking the project timesheet against RFIID
            Dim strSQL As String
            Dim rsDataReader As IDataReader
            Dim strtemp As String

            ' Added and Commented By NageshM on date 12th Dec 2005
            '' Added By NageshM on Date 9th Dec 2005
            ' Purpose : To collect the ProjectId from the tbl_PM_RFIs 
            ' Reason : Session will not provide the ProjectID when it comes to the Billing Hence Following Code is Added
            Dim strSQLData As String = ""
            Dim IntProjectID As Integer
            If CommonFunction.General.CheckIsNothing(Session("intProjectID")) = "" Then
                strSQL = "Select ProjectID from tbl_PM_RFIs where RFIID=" & m_intRFIID
                IntProjectID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Integer)
                'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                'strSQL = "SELECT * FROM tbl_PM_TimeSheetInvoice WHERE ProjectID=" & IntProjectID & " AND RFIID=" & m_intRFIID
                strSQL = "usp_sel_tbl_PM_TimeSheetInvoice_GetData " & IntProjectID & "," & m_intRFIID
                'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            Else
                ''' End of addition By NageshM
                ' 'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                'strSQL = "SELECT * FROM tbl_PM_TimeSheetInvoice WHERE ProjectID=" & Session("intProjectID").ToString & " AND RFIID=" & m_intRFIID
                strSQL = "usp_sel_tbl_PM_TimeSheetInvoice_GetData " & Session("intProjectID").ToString & "," & m_intRFIID
                'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                '' Added By NageshM on Date 9th Dec 2005
            End If
            '' End of Addition By NageshM on date 9th Dec 2005
            rsDataReader = CommonFunction.Data.GetDataReader(strSQL, True)
            strtemp = ""
            If rsDataReader.Read() Then
                strtemp = rsDataReader("RFIID").ToString
            End If


            ' Added and Commented By NageshM on date 12th Dec 2005
            ' Purpose : to  Remove the link of Project Timesheet Selection From Billing 
            ' for Approver and Accounts User Types
            '' Reason : Only User Type = Initiator have the access to this link.
            ' Previous code is commented and New condition is added
            '    If (Request.QueryString("Mode") = "Edit" Or (Request.QueryString("Mode") = "New" And Request.QueryString("Action") = "Save")) And strtemp = "" Then

            '' Start : Commented By ParagD On 29-Sept-2006
            '' Purpose : 'Select Project TImesheet' link disappear from the page when milestone is included in a IR-PIR.
            '' If (Request.QueryString("Mode") = "Edit") Or (Request.QueryString("Mode") = "New") And strtemp = "" And (Request.QueryString("Action").ToUpper = "SAVE" then
            '' END : Modified By ParagD On 29-Sept-2006

            ''' End Of Addition By NageshM On Date 12th Dec 2005
            ''Added by MonikaI on 20th Sep 2006
            'If m_strCurrentStatus = RFI_STATUS_DRAFT Or m_strCurrentStatus = RFI_STATUS_REJECTED Then
            '    'End by MonikaI
            '    ArrMenuCaptionsList.Add("Project Timesheet")
            '    ArrClientSideFunctionsList.Add("ProjectTimesheet_OnClick()")
            '    ArrMenuToolTipsList.Add("Project Timesheet")
            'End If
            '' Start : Commented By ParagD On 29-Sept-2006
            '' End If
            '' END : Commented By ParagD On 29-Sept-2006
            CommonFunction.Data.DisposeDataReader(rsDataReader)

        End If

        'end of addition On 3 May 2005

        If m_blnAddAccess = True Or m_blnEditAccess = True Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            ArrClientSideFunctionsList.Add("Save_OnClick()")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        End If

        If m_intRFIID <> 0 Then

            ' If RFI Initiator has logged in, then...
            If m_strUserType = RFI_INITIATOR Then
                If m_intTotalRFIItemCount > 0 Then
                    m_strSubmitToken = CommonFunctions.Security.Token.GetToken(CType(m_intRFIID, String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String) + "Submitted")
                    If m_strCurrentStatus = RFI_STATUS_DRAFT Then
                        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SUBMIT"))
                        'Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                        ArrClientSideFunctionsList.Add("Submit_OnClick()")
                        'ArrClientSideFunctionsList.Add("Submit_OnClick('" + m_strToken + "')")
                        'End by MonikaI
                        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SUBMIT_TOOLTIP"))
                    ElseIf m_strCurrentStatus = RFI_STATUS_REJECTED Then
                        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_RESUBMIT"))
                        'Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                        ArrClientSideFunctionsList.Add("ReSubmit_OnClick()")
                        'ArrClientSideFunctionsList.Add("ReSubmit_OnClick('" + m_strToken + "')")
                        'End by MonikaI
                        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_RESUBMIT_TOOLTIP"))
                    End If
                End If

                'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
                'Added by GaneshG on 9 Jan 2006 --To show Deliverable and Milestone Links on Invoicing page.
                If m_strCurrentStatus = RFI_STATUS_DRAFT Or m_strCurrentStatus = RFI_STATUS_REJECTED Then
                    ArrMenuCaptionsList.Add("Project Milestones")
                    ArrClientSideFunctionsList.Add("SelectMilestones()")
                    ArrMenuToolTipsList.Add("Project Milestones")

                    ArrMenuCaptionsList.Add("Project Deliverables")
                    ArrClientSideFunctionsList.Add("SelectDeliverable()")
                    ArrMenuToolTipsList.Add("Project Deliverables")

                    'End of Addition
                    'End Integration by SavitaS on 13 Mar 2006
                    'Added by PrashantSJ on 20 June 2006 for adding one menu as 'Select Project Expense'
                    'Added by TruptiK

                    'End of addition by TruptiK

                    ArrMenuCaptionsList.Add("Project Expenses")
                    ArrClientSideFunctionsList.Add("ProjectExpense_OnClick()")
                    ArrMenuToolTipsList.Add("Project Expenses")

                    If m_iContractType > 1 And m_iContractType <> 5 Then
                        'End by MonikaI
                        ArrMenuCaptionsList.Add("Project Timesheets")
                        ArrClientSideFunctionsList.Add("ProjectTimesheet_OnClick()")
                        ArrMenuToolTipsList.Add("Project Timesheets")
                    ElseIf m_iContractType = 5 And CommonFunction.Application.EnableProjectProfitability = False Then
                        ArrMenuCaptionsList.Add("Project Fixed Fee")
                        ArrClientSideFunctionsList.Add("ProjectFixedFee_OnClick()")
                        ArrMenuToolTipsList.Add("Project Fixed Fee")
                    ElseIf m_iContractType = 5 And CommonFunction.Application.EnableProjectProfitability Then
                        ArrMenuCaptionsList.Add("Project Timesheets")
                        ArrClientSideFunctionsList.Add("ProjectTimesheet_OnClick()")
                        ArrMenuToolTipsList.Add("Project Timesheets")
                    End If

                End If
                'ArrMenuCaptionsList.Add("Project Timesheet")
                'ArrClientSideFunctionsList.Add("ProjectTimesheet_OnClick()")
                'ArrMenuToolTipsList.Add("Project Timesheet")
                'End of addition by PrashanSJ on 20 june 2006

                ' If RFI Approver of Accounts person has logged in, then...
            Else
                If m_strCurrentStatus <> RFI_STATUS_CLOSED Then
                    If m_blnInvoiceGenerated = False Then
                        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CHANGESTATUS"))
                        'Modified By JyotiG
                        'Start
                        'Issue ID : 6197
                        'Date :20-Sep-2006
                        'ArrClientSideFunctionsList.Add("ChangeStatus_OnClick()")
                        ArrClientSideFunctionsList.Add("ChangeStatus_OnClick('" + m_strToken + "')")
                        'End(JyotiG)
                        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CHANGESTATUS_TOOLTIP"))
                    End If
                    If m_strUserType = RFI_ACCOUNTS_PERSON Then
                        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GENERATEINVOICE"))
                        'Modified By JyotiG
                        'Start
                        'Issue ID : 6197
                        'Date :20-Sep-2006
                        'ArrClientSideFunctionsList.Add("GenerateInvoice_OnClick()")
                        ArrClientSideFunctionsList.Add("GenerateInvoice_OnClick('" + m_strToken + "')")
                        'End
                        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GENERATEINVOICE_TOOLTIP"))
                    End If
                End If
            End If

            If m_intCheckListInstanceId <> 0 Then
                If m_intTotalRFIItemCount > 0 Then
                    ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CHECKLIST"))
                    ArrClientSideFunctionsList.Add("CheckList_OnClick()")
                    ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CHECKLIST_TOOLTIP"))
                Else
                    m_intCheckListInstanceId = 0
                End If
            End If

            If AuditTrailExists(CommonFunction.Constants.APP_TAG_RFI_INITIATOR, m_intRFIID, m_intProjectID) Then
                ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOWHISTORY"))
                ArrClientSideFunctionsList.Add("ShowHistory_OnClick(" & CommonFunction.Constants.APP_TAG_RFI_INITIATOR & "," & m_intRFIID & "," & m_intProjectID & ")")
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"))
            End If

        End If
        'Commented by TruptiK on 15-Jun-2007
        'Purpose:-To remove querybuilder link from RFI Page
        'ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_QRB"))
        'ArrClientSideFunctionsList.Add("QRB_OnClick()")
        'ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_QRB_TOOLTIP"))
        'End of commented by TruptiK on 15-Jun-2007

        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))

        'Commented and Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
        'If m_strUserType.ToUpper = "INITIATOR" Then
        If CType(CommonFunction.General.CheckIsNothing(m_strUserType), String).ToUpper = "INITIATOR" Or m_strAction = "ChangeCustomer" Then
            ArrClientSideFunctionsList.Add("Back_OnClick(" + CommonFunction.Constants.APP_TAG_RFI_INITIATOR.ToString + ",'PM'" + ")")
            'ElseIf m_strUserType.ToUpper = "APPROVER" Then
        ElseIf CType(CommonFunction.General.CheckIsNothing(m_strUserType), String).ToUpper = "APPROVER" Then
            ArrClientSideFunctionsList.Add("Back_OnClick(" + CommonFunction.Constants.APP_TAG_RFI_APPROVAL.ToString + ",'FA'" + ")")
            'ElseIf m_strUserType.ToUpper = "ACCOUNTS" Then
        ElseIf CType(CommonFunction.General.CheckIsNothing(m_strUserType), String).ToUpper = "ACCOUNTS" Then
            ArrClientSideFunctionsList.Add("Back_OnClick(" + CommonFunction.Constants.APP_TAG_RFI_INVOICE_GENERATION.ToString + ",'FA'" + ")")
        End If
        'End Comment and Integration by SavitaS 
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))

        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('" + m_intHelpID.ToString + "')")
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


        objMenu = New WebPages.Template.StaticMenu
        Dim strMenu As String = objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        objMenu = Nothing
        Response.Write(strMenu)

    End Sub

    '====================================================================
    ' Procedure Name        :   GetPageCaption
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   Plots Page Caption
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 30, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub GetPageCaption()

        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        Dim strRightSectionTitile As String = ""
        If m_intRFIID <> 0 Then

            'Previous and Next links
            Dim strLinks As String() = {MyBase.GetResourceString("PRE"), MyBase.GetResourceString("NEXT")}

            'Previous and Next links - Client side functions
            Dim strLinkFunctions As String() = {"Previous_OnClick()", "Next_OnClick()"}
            'Added By JyotiG
            'Start
            'Issue Id : 6197
            'Date : 26-Sep-2006
            Dim strSqlProject As String
            Dim strTempPrjId As String
            Dim strPrjId As String
            'End

            'Previous and Next links - Tooltips
            Dim strLinkTooltips As String() = {MyBase.GetResourceString("PRE_TOOLTIP"), MyBase.GetResourceString("NEXT_TOOLTIP")}
            'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
            Dim drToken As IDataReader
            Dim strSql As String
            Dim intCnt As Integer

            intCnt = 0
            strSql = BuildRFIListQuery("usp_Sel_tbl_PM_RFIs_RFIID")
            drToken = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
            m_arrToken = ""
            If drToken.Read Then
                'Initiator
                If m_strUserType = "Initiator" Then
                    m_arrToken = CommonFunctions.Security.Token.GetToken(CType(drToken.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
                    While drToken.Read
                        m_arrToken = m_arrToken + "," + CommonFunctions.Security.Token.GetToken(CType(drToken.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
                    End While
                End If
                'Added By JyotiG
                'Start
                'Issue Id : 6197
                'Date : 26-Sep-2006
                'Approver
                If m_strUserType = "Approver" Then
                    strSqlProject = "Select ProjectID from tbl_PM_RFIs where RFIID=" & CType(drToken.Item("RFIID"), Integer)
                    strTempPrjId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlProject, MyBase.UseSQL), "0"), String)
                    m_arrToken = CommonFunctions.Security.Token.GetToken(CType(drToken.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2074, String) + CType(0, String) + CType(strTempPrjId, String))
                    While drToken.Read
                        strSqlProject = "Select ProjectID from tbl_PM_RFIs where RFIID=" & CType(drToken.Item("RFIID"), Integer)
                        strPrjId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlProject, MyBase.UseSQL), "0"), String)
                        m_arrToken = m_arrToken + "," + CommonFunctions.Security.Token.GetToken(CType(drToken.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2074, String) + CType(0, String) + CType(strPrjId, String))
                    End While
                End If
                'Accounts
                If m_strUserType = "Accounts" Then
                    strSqlProject = "Select ProjectID from tbl_PM_RFIs where RFIID=" & CType(drToken.Item("RFIID"), Integer)
                    strTempPrjId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlProject, MyBase.UseSQL), "0"), String)
                    m_arrToken = CommonFunctions.Security.Token.GetToken(CType(drToken.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2083, String) + CType(0, String) + CType(strTempPrjId, String))
                    While drToken.Read
                        strSqlProject = "Select ProjectID from tbl_PM_RFIs where RFIID=" & CType(drToken.Item("RFIID"), Integer)
                        strPrjId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlProject, MyBase.UseSQL), "0"), String)
                        m_arrToken = m_arrToken + "," + CommonFunctions.Security.Token.GetToken(CType(drToken.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2083, String) + CType(0, String) + CType(strPrjId, String))
                    End While
                End If
                'End
            End If
            CommonFunction.Data.DisposeDataReader(drToken)
            'End of addition by MonikaI

            strRightSectionTitile = MyBase.GetResourceString("RFIID") + ": "
            strRightSectionTitile += CommonFunctions.HTMLControls.DrawComboBox("cboRFIIDs", BuildRFIListQuery("usp_Sel_tbl_PM_RFIs_RFIID"), 100, m_intRFIID.ToString, "onchange=""cboRFIID_OnChange()""", , True)

            cObjSectionTitle.LinkNames = strLinks
            cObjSectionTitle.LinkFunctions = strLinkFunctions
            cObjSectionTitle.LinkTooltips = strLinkTooltips


        End If
        'cObjSectionTitle.GetSectionTitle(MyBase.GetResourceString("PAGE_CAPTION"), "DivRFI", "", , strRightSectionTitile, , , , , , , , False, False)
        cObjSectionTitle.GetSectionTitle(GetPageCaptionFromGlobal(m_lngTagID), "DivRFI", "", , strRightSectionTitile, , , , , , , , False, False)
        Dim objHeader As New WebPages.Template.HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        Dim strHeader As String = objHeader.DrawHeaderFooter(m_objGlobal, True) & ""
        Response.Write(strHeader)
        If strHeader.Trim <> "" Then Response.Write("<BR>")
        objHeader = Nothing


    End Sub

    '=====================================================================
    'Procedure(Name)        :   BuildRFIListQuery()
    'Purpose				:	To build the SQL Query to select the list of RFIs.
    'Description			:	Same as above.
    'Parameters Passed	    :	SPName
    'Parameters Affected	:	None.
    'Returns				:	The SQL Query will be returned.
    'Assumptions			:	None.
    'Dependencies		    :	None.
    'Author                 :   DipaliS
    'Created                :   July 30, 2004
    'Revisions:
    '=====================================================================

    Private Function BuildRFIListQuery(ByVal SPName As String) As String
        Dim strSQLQuery As String
        Dim strSQL As String

        ' Build Query to get the list of RFIs.
        strSQLQuery = "Exec " + SPName + " NULL "

        ' If the Initiator is viewing the RFI list, display only the RFIs of the selected project.
        If m_strUserType = RFI_INITIATOR Then
            strSQLQuery = strSQLQuery & ", " & m_objGlobal.ProjectID
        Else
            '  Apply the Project filter.
            strSQL = "usp_sel_tbl_UI_EmployeeFiletrsetting " + m_lngTagID.ToString + ",'" + m_objGlobal.LoginType + "'," + m_objGlobal.UserID.ToString + ",'ProjectID'"
            m_intFilter_ProjectID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Integer)

            If m_intFilter_ProjectID <> 0 Then
                strSQLQuery = strSQLQuery & ", " & m_intFilter_ProjectID
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If
        End If

        '' Apply the RFI / RFPI filter.
        Dim strIsProforma As String
        strSQL = "usp_sel_tbl_UI_EmployeeFiletrsetting " + m_lngTagID.ToString + ",'" + m_objGlobal.LoginType + "'," + m_objGlobal.UserID.ToString + ",'RFI'"
        strIsProforma = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL)), String)
        If strIsProforma = "" Then
            strSQLQuery = strSQLQuery & ", NULL"
        Else
            If strIsProforma.ToUpper = "IR" Then
                m_intFilter_IsProforma = 0
                m_blnIsProforma = False
                strSQLQuery = strSQLQuery & ",0"
            Else
                m_intFilter_IsProforma = 1
                m_blnIsProforma = True
                strSQLQuery = strSQLQuery & ",1"
            End If
        End If

        '' Apply the RFI Type filter.
        strSQL = "usp_sel_tbl_UI_EmployeeFiletrsetting " + m_lngTagID.ToString + ",'" + m_objGlobal.LoginType + "'," + m_objGlobal.UserID.ToString + ",'RFITypeID'"
        m_intFilter_TypeID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Integer)
        If m_intFilter_TypeID <> 0 Then
            strSQLQuery = strSQLQuery & ", " & m_intFilter_TypeID.ToString
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        '' Apply the Status filter.
        strSQL = "usp_sel_tbl_UI_EmployeeFiletrsetting " + m_lngTagID.ToString + ",'" + m_objGlobal.LoginType + "'," + m_objGlobal.UserID.ToString + ",'CurrentStatus'"
        m_strFilter_Status = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL)), String)
        If m_strFilter_Status <> "" Then
            strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Trim(m_strFilter_Status)) & "' "
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        ''  Apply the Customer filter.
        strSQL = "usp_sel_tbl_UI_EmployeeFiletrsetting " + m_lngTagID.ToString + ",'" + m_objGlobal.LoginType + "'," + m_objGlobal.UserID.ToString + ",'CustomerID'"
        m_intFilter_CustomerID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Integer)
        If m_intFilter_CustomerID <> 0 Then
            strSQLQuery = strSQLQuery & ", " & m_intFilter_CustomerID.ToString
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        '' Apply the Sales Period filter.
        strSQL = "usp_sel_tbl_UI_EmployeeFiletrsetting " + m_lngTagID.ToString + ",'" + m_objGlobal.LoginType + "'," + m_objGlobal.UserID.ToString + ",'SalesPeriodID'"
        m_intFilter_SalesPeriodID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Integer)

        If m_intFilter_SalesPeriodID <> 0 Then
            strSQLQuery = strSQLQuery & ", " & m_intFilter_SalesPeriodID.ToString
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        ''Pass the user type and Employee ID.
        strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(m_strUserType) & "', " & m_objGlobal.UserID

        '' Additional where clause to be applied.									
        If m_intRFIID <> 0 Then
            If m_strUserType = RFI_APPROVER Then
                'strSQLQuery = strSQLQuery & ", '( CurrentStatus = ''" & RFI_STATUS_SUBMITTED & "'' OR CurrentStatus = ''" & RFI_STATUS_RESUBMITTED & "'' ) OR RFIID = " & m_intRFIID.ToString & "'"
                strSQLQuery = strSQLQuery & ", '( CurrentStatus = ''" & RFI_STATUS_SUBMITTED & "'' OR CurrentStatus = ''" & RFI_STATUS_RESUBMITTED & "'' ) OR RFIID = " & m_intRFIID.ToString & "AND RFI.ProjectID IN (SELECT ProjectID  FROM  tbl_PM_IRApprovers WHERE  ISNULL(ApproverID,0)=" + HttpContext.Current.Session("intUserID").ToString + ")'"
            ElseIf m_strUserType = RFI_ACCOUNTS_PERSON Then
                'strSQLQuery = strSQLQuery & ", 'CurrentStatus = ''" & RFI_STATUS_APPROVED & "'' OR RFIID = " & m_intRFIID & "'"
                strSQLQuery = strSQLQuery & ", '(CurrentStatus = ''" & RFI_STATUS_APPROVED & "'' OR RFIID = " & m_intRFIID & ")" & " AND RFI.ProjectID IN (SELECT ProjectID FROM tbl_PM_InvoiceGenerators  WHERE  ISNULL(GeneratorID,0)= " + HttpContext.Current.Session("intUserID").ToString + ")'"
            Else
                strSQLQuery = strSQLQuery & ", ' 1=1 OR RFIID = " & m_intRFIID & "'"
            End If
        Else
            If m_strUserType = RFI_APPROVER Then
                strSQLQuery = strSQLQuery & ", '( CurrentStatus = ''" & RFI_STATUS_SUBMITTED & "'' OR CurrentStatus = ''" & RFI_STATUS_RESUBMITTED & "'' ) '"
            ElseIf m_strUserType = RFI_ACCOUNTS_PERSON Then
                strSQLQuery = strSQLQuery & ", 'CurrentStatus = ''" & RFI_STATUS_APPROVED & "'''"
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If
        End If

        Return strSQLQuery

    End Function

    '====================================================================
    ' Procedure Name        :   PlotHiddenControls
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   Plots the Hidden Controls
    ' Description           :   Same as above
    ' Assumptions           :
    ' Dependencies          :
    ' Author                :   DipaliS
    ' Created               :   July 28, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub PlotHiddenControls()
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtUseFormContents", "txtUseFormContents", , , , "1", , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtUserType", "txtUserType", , , , m_strUserType, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtFilter_IsProforma", "txtFilter_IsProforma", , , , m_intFilter_IsProforma.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtFilter_RFITypeID", "txtFilter_RFITypeID", , , , m_intFilter_TypeID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtFilter_CurrentStatus", "txtFilter_CurrentStatus", , , , m_strFilter_Status, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtFilter_CustomerID", "txtFilter_CustomerID", , , , m_intFilter_CustomerID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtFilter_ProjectID", "txtFilter_ProjectID", , , , m_intFilter_ProjectID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtFilter_SalesPeriodID", "txtFilter_SalesPeriodID", , , , m_intFilter_SalesPeriodID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtBaseCurrencyCode", "txtBaseCurrencyCode", , , , m_strBaseCurrencyCode, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtLocalCurrencyCode", "txtLocalCurrencyCode", , , , m_strLocalCurrencyCode, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
    End Sub

    '====================================================================
    ' Procedure Name        :   PlotHiddenControls
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   Plots the Hidden Controls
    ' Description           :   Same as above
    ' Assumptions           :
    ' Dependencies          :
    ' Author                :   DipaliS
    ' Created               :   July 28, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub PlotOtherHiddenControls()
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtRFIID", "txtRFIID", , , , m_intRFIID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtProjectID", "txtProjectID", , , , m_intProjectID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtCurrentStatus", "txtCurrentStatus", , , , m_strCurrentStatus, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtProjectOrProduct", "txtProjectOrProduct", , , , m_strProjectOrProduct, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtBillingCurrencyCode", "txtBillingCurrencyCode", , , , m_strBillingCurrencyCode, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtCompanyBaseCurrencyCode", "txtCompanyBaseCurrencyCode", , , , m_strCompanyBaseCurrencyCode, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtChecklistInstanceID", "txtChecklistInstanceID", , , , m_intCheckListInstanceId.ToString, , , , , , True, EnableHTMLEncode:=True)
        'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenToken", "txtHiddenToken", , , , m_strToken, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        'End of addition by MonikaI
        'Added by TruptiK on 21-Jun-2007
        'CommonFunctions.HTMLControls.DrawTextBox("txtHiddenToken1", "txtHiddenToken1", , , , strToken, , , , , , True)
        'End of addition by TruptiK
    End Sub

    '====================================================================
    ' Procedure Name        :   PlotControls
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To draw the controls
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 30 2004
    ' Revisions             :
    '=====================================================================

    Private Sub PlotControls()

        Dim strHTML As String
        strHTML += "<div id=divControls style=""overflow:auto;width=100%;"">"
        If m_blnReadOnly = False Then
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            strHTML += "<table cellspacing=0 class=clsTable width=99.9%>"
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            'Modified by TruptiK on 7-May-2007 to adjust the column on 
            strHTML += "<COL width=10%></COL><COL width=45%></COL><COL width=15%></COL><COL width=35%></COL>"
            'strHTML += "<COL width=15%></COL><COL width=40%></COL><COL width=20%></COL><COL width=35%></COL>"
            'End of modification by TruptiK on 7-May-2007
            strHTML += "<tr class=clsTREven><td valign=top  align=right>"

            'Type Combo Box
            strHTML += MyBase.GetResourceString("TYPE")
            strHTML += "</td><td valign=top >"
            Dim strSQL As String
            strSQL = "Exec usp_Sel_tbl_PM_RFITypesMaster NULL, 1"
            If m_intRFITypeID <> 0 Then
                strSQL += "," + m_intRFITypeID.ToString
            End If
            ' NOTE: Only active Types will be displayed in the Add New mode.
            '		If any items have been added, the Type combo box will be disabled.
            If m_intTotalRFIItemCount > 0 Then
                'Modified by TruptiK on 4-May-2007 to increase the width of th control
                strHTML += CommonFunctions.HTMLControls.DrawComboBox("cboRFITypeID", strSQL, 250, m_intRFITypeID.ToString, "disabled", True, True, , True)
            Else
                strHTML += CommonFunctions.HTMLControls.DrawComboBox("cboRFITypeID", strSQL, 250, m_intRFITypeID.ToString, , True, True, , True, , , 1)
                'End of modification by TruptiK on 4-May-2007
            End If
            strHTML += "	</td>"
            strHTML += "<td valign=top  align=right>"

            'Credit Days
            strHTML += MyBase.GetResourceString("CREDITDAYS")
            strHTML += "</td><td>"
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtCreditDays", "txtCreditDays", , 50, 4, m_intCreditDays.ToString, , , , , , , , True, True, , , , 2, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            strHTML += "</td></tr><tr class=clsTREven>"
            strHTML += "<td valign=top  align=right>"

            'Customer
            strHTML += MyBase.GetResourceString("CUSTOMER")
            strHTML += "</td><td valign=top >"
            'NOTE: If the project type is PROJECT, then the customer combo box will be disabled.
            'Modified by TruptiK on 18-Jun-2007
            strSQL = "Exec usp_Sel_tbl_PM_Customer_RFI NULL, '" + CommonFunctions.General.BuildQueryString(m_strProjectOrProduct) & "'"
            'End of addition by TruptiK
            If m_strProjectOrProduct.ToUpper = "PROJECT" Then
                'Modified by TruptiK on 4-May-2007 to increase the width of th control
                strHTML += CommonFunctions.HTMLControls.DrawComboBox("cboCustomerID", strSQL, 250, m_intCustomerID.ToString, "disabled", True, True, , True)
            Else
                strHTML += CommonFunctions.HTMLControls.DrawComboBox("cboCustomerID", strSQL, 250, m_intCustomerID.ToString, "onchange=""javascript:cboCustomerID_OnChange()""", True, True, , True, , , 3)
                'End of modification by TruptiK on 4-May-2007
            End If
            If m_intCustomerID <> 0 Then
                'Modified By VidyaJ - Security issue - 6197

                strToken = CommonFunctions.Security.Token.GetToken(m_intContractID.ToString + Session("intUserID").ToString + "0" + "2130")
                'strHTML += "<td valign=top  align=left>"
                strHTML += "<A href=" + "javascript:CustomerAddress_OnClick('" + strtoken + "')" + " title='" + MyBase.GetResourceString("SELECTADDRTITLE") + _
                        "'><B>" + MyBase.GetResourceString("SELECTADDRESS") + "</B></A> "
                'strHTML += "</td><td>"
            End If
            'Hidden Combo Box For Customer Address ID
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtCustomerAddressID", "txtCustomerAddressID", , , , m_intCustomerAddressID.ToString, , , , , , True, , True, , , , , 4, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            strHTML += "</td>"

            'Currency
            strHTML += "<td valign=top  align=right>"
            strHTML += MyBase.GetResourceString("CURRENCY")
            strHTML += "</td><td valign=top >"

            strHTML += CommonFunctions.HTMLControls.DrawComboBox("cboBillingCurrencyID", "Exec usp_Sel_tbl_PM_CurrencyMaster", 50, m_intBillingCurrencyID.ToString, "disabled", , True, , , , True)
            strHTML += m_strBillingCurrencyCode
            'Contact Person
            strHTML += "</td></tr><tr class=clsTREven><td valign=top  align=right> "
            strHTML += MyBase.GetResourceString("CONTACTPERSON")
            strHTML += "</td><td valign=top>"
            strSQL = "Exec usp_Sel_tbl_PM_CustomerContactPersons " & m_intCustomerID
            strHTML += CommonFunctions.HTMLControls.DrawComboBox("cboCustomerContactID", strSQL, 200, m_intCustomerContactID.ToString, "onchange=""javascript:cboCustomerContactID_OnChange()""", True, True, , True, , , 5)
            'Hidden combo box for emailIDS

            strSQL = "Exec usp_Sel_tbl_PM_CustomerContactPersons_EmailID " & m_intCustomerID
            strHTML += CommonFunctions.HTMLControls.DrawComboBox("cboCustomerContactEmailID", strSQL, , m_intCustomerContactID.ToString, , True, True, , , , True, 6)
            strHTML += "</td>"
            'Added by TruptiK on 20-Jun-2007
            'Commented by TruptiK on 21-Jun-2007
            strHTML += "<td valign=top align=right>"
            'strHTML += "Sales Period"
            strHTML += "<a Href='javascript:SelectSalesPeriod()'>" + "Sales Period" + "</A>"
            strHTML += "</td><td valign=top>"
            'strHTML += "</td><td valign=top rowspan=2>"
            'Commented by TruptiK on 21-Jun-2007
            'Purpose:-To add test box for sales period
            'If CType(CommonFunction.General.CheckIsNothing(m_intSalesPeriodID, "0"), Integer) = 0 Then
            '    strSQL = "Exec usp_Sel_tbl_PM_SalesPeriod "
            'Else
            '    strSQL = "Exec usp_Sel_tbl_PM_SalesPeriod " & m_intSalesPeriodID
            'End If
            'Trupti
            'strHTML += CommonFunctions.HTMLControls.DrawComboBox("cboSalesPeriodID", strSQL, 80, m_intSalesPeriodID.ToString, , True, True, , True)
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtSalesPeriodID", "txtSalesPeriodID", , , , m_intSalesPeriodID.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
            strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtSalesPeriod", "txtSalesPeriod", , 150, 100, m_strSalesPeriod.ToString, , , , True, , , , True, True, , , , 7, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            'End
            'strHTML += "</td></tr><tr class=clsTREven>"

            strHTML += "</td></tr>"
            'End of addition by TruptiK on 20-Jun-2007
            'No of Lines
            'Commented by TruptiK on 20-Jun-2007
            'strHTML += "<td valign=top align=right>"
            'strHTML += MyBase.GetResourceString("NOOFLINES")
            'strHTML += "</td><td valign=top >"
            'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtLOC", "txtLOC", , 200, 100, m_strLOC.ToString, , , , , , , , True)
            'strHTML += "</td></tr>"
            'strHTML += "<tr class=clsTREven><td valign=top align=right>"
            'End of commented by TruptiK on 20-Jun-2007
            'Email Confirm
            strHTML += "<tr class=clsTREven><td valign=top  align=right> "
            strHTML += MyBase.GetResourceString("EMAILCONFIRM")
            strHTML += "</td><td valign=top>"
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtConfirmEmailID", "txtConfirmEmailID", , 200, 100, m_strConfirmEmailID, , , , True, , , , True, , , , , 8, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            strHTML += "</td><td valign=top align=right>"

            'Language of development
            'Commented by TruptiK on 20-Jun-2007
            'strHTML += MyBase.GetResourceString("LANG")
            'strHTML += "</td><td valign=top>"
            'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRFIToolIDs", "txtRFIToolIDs", , , , m_strRFIToolIDs, , , , , , True, , True)
            'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRFIToolNames", "txtRFIToolNames", , 200, , m_strRFIToolNames, , , , True, , , , True)
            'strHTML += " <a Href='javascript:SelectDevelopmentTools()'><img BORDER='0' src='..\..\images\dblclick.gif' alt='" + MyBase.GetResourceString("ALTLANG") + "'></a>"
            'strHTML += "</td></tr>"
            'strHTML += "<tr class=clsTREven>"
            'strHTML += "<td valign=top align=right>"
            'End of commented by TruptiK on 20-Jun-2007
            'Sales Person
            strHTML += MyBase.GetResourceString("SALESPERSON")
            strHTML += "</td><td valign=top >"
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRFISalesPersonIDs", "txtRFISalesPersonIDs", , , , m_strRFISalesPersonIDs, , , , , , True, , True, EnableHTMLEncode:=True)
            strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRFISalesPersonNames", "txtRFISalesPersonNames", , 200, , m_strRFISalesPersonNames, , , , True, , , , True, , , , , 9, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

            strHTML += " <a Href='javascript:SelectSalesPersons()'><img BORDER='0' src='..\..\images\dblclick.gif' alt='" + MyBase.GetResourceString("ALTSALES") + "'></a>"
            strHTML += "</td>"
            '<td valign=top align=right>"
            'Operating system
            'Commented by TruptiK on 20-Jun-2007
            'strHTML += MyBase.GetResourceString("OS")
            'strHTML += "</td><td valign=top>"
            'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRFIOSIDs", "txtRFIOSIDs", , , , m_strRFIOSIDs, , , , , , True, , True)
            'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRFIOSNames", "txtRFIOSNames", , 200, , m_strRFIOSNames, , , , True, , , , True)
            'strHTML += " <a Href='javascript:SelectOperatingSystems()'><img BORDER='0' src='..\..\images\dblclick.gif' alt='" + MyBase.GetResourceString("ALTOS") + "'></a>"
            'strHTML += "</td></tr>"
            'End of commented by TruptiK on 20-Jun-2007
            strHTML += "<tr class=clsTREven><td valign=top align=right>"
            'Milestone
            'Commented and Integrated by SavitaS on 14 Mar 2006 for IssueID-2836
            'strHTML += MyBase.GetResourceString("MILESTONE")
            'strHTML += "</td><td valign=top >"
            'strSQL = "Exec usp_Sel_tbl_PM_Milestones_RFI " + m_intProjectID.ToString
            'strHTML += CommonFunctions.HTMLControls.DrawComboBox("cboMilestoneID", strSQL, 200, m_intMileStoneID.ToString, , True, True)
            'strHTML += "</td><td valign=top align=right rowspan=2>"

            'Header
            'strHTML += MyBase.GetResourceString("RFIHEADER")
            'strHTML += "</td><td valign=top rowspan=2>"
            'strHTML += CommonFunctions.HTMLControls.DrawTextArea("txtRFIHeader", "txtRFIHeader", , , , , , , 200, 50, 2000, m_strRFIHeader, , , , , , , , True)
            'strHTML += "</td></tr><tr class=clsTREven>"
            ''Contract
            'strHTML += "<td  align=right>"
            'End Integration 

            'strHTML += MyBase.GetResourceString("CONTRACT")
            'Added  and modified by TruptiK on 19-Jun-2007
            strHTML += "<a Href='javascript:SelectContract()'>" + MyBase.GetResourceString("CONTRACT") + "</A>"
            strHTML += "</td><td valign=top>"
            'strHTML += "</td><td align=left>"

            'strSQL = "Exec usp_Sel_tbl_PM_ContractMaster_RFI " + m_intRFIID.ToString
            'Dim drDetails As IDataReader
            'drDetails = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            'If drDetails.Read Then
            '    m_strContractName = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("InvoiceingMilestones")), String)
            'End If

            'Modified by TruptiK on 19-Jun-2007
            'strHTML += CommonFunctions.HTMLControls.DrawComboBox("cboContractID", strSQL, 200, m_intContractID.ToString, , True, True, , True)
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtcontractid", "txtcontractid", , , , m_intContractID.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
            strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtcontract", "txtcontract", , 200, 100, m_strContractName.ToString, , , , True, , , , True, True, , , , 10, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            'End of modification by TruptiK on 19-Jun-2007
            If m_intCustomerID <> 0 Then

                'Modified By VidyaJ - Security issue - 6197
                Dim strToken As String
                strToken = CommonFunctions.Security.Token.GetToken(m_intContractID.ToString + Session("intUserID").ToString + "0" + "2130")
                strHTML += "<A href=javascript:ContractDetails_OnClick('" + strToken + "') title='" + MyBase.GetResourceString("CONTITLE") + "'><B>" + MyBase.GetResourceString("SHOWDETAILS") + "</B></A>"
                'strHTML += "<A href=javascript:ContractDetails_OnClick() title='" + MyBase.GetResourceString("CONTITLE") + "'><B>" + MyBase.GetResourceString("SHOWDETAILS") + "</B></A>"
            End If
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("txtHiddenToken1", "txtHiddenToken1", , , , strToken, , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            strHTML += "</td>"
            'Integrated by TruptiK on 26-Apr-2007
            'Added by PrashantSJ on 08 Dec 2006
            'Purpose: To plot the Salesperiod Combobox (using this we can select any open salesperiod
            'strHTML += "<td valign=top align=right>"
            'strHTML += "Sales Period"
            'strHTML += "</td><td valign=top>"
            ''strHTML += "</td><td valign=top rowspan=2>"
            'If CType(CommonFunction.General.CheckIsNothing(m_intSalesPeriodID, "0"), Integer) = 0 Then
            '    strSQL = "Exec usp_Sel_tbl_PM_SalesPeriod "
            'Else
            '    strSQL = "Exec usp_Sel_tbl_PM_SalesPeriod " & m_intSalesPeriodID
            'End If
            'strHTML += CommonFunctions.HTMLControls.DrawComboBox("cboSalesPeriodID", strSQL, 80, m_intSalesPeriodID.ToString, , True, True, , True)
            ''strHTML += "</td></tr><tr class=clsTREven>"

            'strHTML += "</td></tr>"
            'strHTML += "</td></tr></table>"
            'End of addition by PrashantSJ on 08 Dec 2006
            'End of integration by TruptiK 26-Apr-2007

            ''Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
            ''Header
            'strHTML += "<td valign=top align=right>"
            'strHTML += MyBase.GetResourceString("RFIHEADER")
            ''tRUPTI
            ''strHTML += "</td><td align=left>"
            'strHTML += "</td><td valign=top>"
            ''eND 
            ''strHTML += "</td><td valign=top rowspan=2>"
            ''Modified By ShraddhaM on 27 July 2006
            'strHTML += CommonFunctions.HTMLControls.DrawTextArea("txtRFIHeader", "txtRFIHeader", , , , , , , 200, 50, 2000, m_strRFIHeader, , , , , , , , True, , , , , , , "Soft", )
            ''strHTML += CommonFunctions.HTMLControls.DrawTextArea("txtRFIHeader", "txtRFIHeader", , , , , , , 200, 50, 2000, m_strRFIHeader, , , , , , , , True)
            ''strHTML += "</td></tr><tr class=clsTREven>"
            ''End Integration by SavitaS on 13 Mar 2006
            ''tRUPTI
            ''strHTML += "</td></tr></table>"
            'strHTML += "</td><td  align=left></td><td  align=left></td></tr></table>"


            'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
            'Header
            'Modified by TrupitKmon 20-Jun-2007
            'strHTML += "<tr class=clsTREven><td valign=top align=right>"
            strHTML += "<td valign=top align=right>"
            strHTML += MyBase.GetResourceString("RFIHEADER")
            strHTML += "</td><td valign=top>"
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'strHTML += CommonFunctions.HTMLControls.DrawTextArea("txtRFIHeader", "txtRFIHeader", , , , , , , 200, 50, 2000, m_strRFIHeader, , , , , , , , True, , , , , , , , 11)
            strHTML += CommonFunctions.HTMLControls.DrawTextArea("txtRFIHeader", "txtRFIHeader", , , , , , , 200, 50, 2000, m_strRFIHeader, , , , , , , , True, , , , , , , , 11, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            strHTML += "</td></tr></table>"
            'End Integration by SavitaS on 13 Mar 2006



        Else
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            strHTML += "<table cellspacing=0 class=clsTable width=99.9%>"
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            strHTML += "<COL width=10%></COL><COL width=40%></COL><COL width=15%></COL><COL width=35%></COL>"
            strHTML += "<tr class=clsTREven><td valign=top  align=right>"

            'Type Combo Box
            strHTML += MyBase.GetResourceString("TYPE")
            strHTML += "</td><td valign=top >"
            strHTML += " : " + m_strRFITypeName
            strHTML += "	</td>"
            strHTML += "<td valign=top  align=right>"

            'Credit Days
            strHTML += MyBase.GetResourceString("CREDITDAYS")
            strHTML += "</td><td>"
            strHTML += " : " + m_intCreditDays.ToString
            strHTML += "</td></tr><tr class=clsTREven>"
            strHTML += "<td valign=top  align=right>"

            'Customer
            strHTML += MyBase.GetResourceString("CUSTOMER")
            strHTML += "</td><td valign=top >"
            strHTML += " : " + m_strCustomerName
            If m_intCustomerID <> 0 Then
                'Modified By VidyaJ - Security issue - 6197
                Dim strToken As String
                strToken = CommonFunctions.Security.Token.GetToken(m_intCustomerAddressID.ToString + Session("intUserID").ToString + "0" + "2114")

                strHTML += " <A href=" + "javascript:CustomerAddress_OnClick('" + strtoken + "')" + " title='" + MyBase.GetResourceString("SELECTADDRTITLE") + _
                        "'><B>" + MyBase.GetResourceString("ADDRESS") + "</B></A> "
            End If
            strHTML += "</td>"

            'Currency
            strHTML += "<td valign=top  align=right>"
            strHTML += MyBase.GetResourceString("CURRENCY")
            strHTML += "</td><td valign=top >"

            strHTML += " : " + m_strBillingCurrencyCode
            'Contact Person
            strHTML += "</td></tr><tr class=clsTREven><td valign=top  align=right> "
            strHTML += MyBase.GetResourceString("CONTACTPERSON")
            strHTML += "</td><td valign=top>"
            strHTML += " : " + m_strCustomerContactName

            strHTML += "</td>"
            strHTML += "<td valign=top align=right>"
            strHTML += "Sales Period"
            strHTML += "</td><td valign=top >"
            strHTML += " : " + m_strSalesPeriod
            strHTML += "</td>"
            'No of Lines
            'Commented by TruptiK on 20-Jun-2007
            'strHTML += "<td valign=top align=right>"
            'strHTML += MyBase.GetResourceString("NOOFLINES")
            'strHTML += "</td><td valign=top >"
            'strHTML += " : " + m_strLOC
            'strHTML += "</td></tr>"
            'strHTML += "<tr class=clsTREven><td valign=top align=right>"
            'End of commented by TruptiK
            'Email Confirm
            'Added by TruptiK on 20_Jun-2007
            strHTML += "<tr class=clsTREven><td valign=top  align=right> "
            'End of addition by TruptiK
            strHTML += MyBase.GetResourceString("EMAILCONFIRM")
            strHTML += "</td><td valign=top>"
            strHTML += " : " + m_strConfirmEmailID
            strHTML += "</td>"
            '<td valign=top align=right>"

            'Language of development
            'Commented by TruptiK on 20-Jun-2007
            'strHTML += MyBase.GetResourceString("LANG")
            'strHTML += "</td><td valign=top>"
            'strHTML += " : " + m_strRFIToolNames
            'strHTML += "</td></tr>"
            'strHTML += "<tr class=clsTREven>"
            'strHTML += "<td valign=top align=right>"
            'End of commented by TruptiK
            'Sales Person
            strHTML += "<td valign=top align=right>"
            strHTML += MyBase.GetResourceString("SALESPERSON")
            strHTML += "</td><td valign=top >"
            strHTML += " : " + m_strRFISalesPersonNames
            strHTML += "</td>"
            'Operating system
            'strHTML += MyBase.GetResourceString("OS")
            'strHTML += "</td><td valign=top>"
            'strHTML += " : " + m_strRFIOSNames
            'strHTML += "</td></tr>"


            strHTML += "<tr class=clsTREven><td valign=top align=right>"
            'Milestone
            'Integrated  by SavitaS on 14 Mar 2006 for IssueID-2836
            'strHTML += MyBase.GetResourceString("MILESTONE")
            'strHTML += "</td><td valign=top >"
            'strHTML += " : " + m_strMilestoneName
            'strHTML += "</td><td valign=top align=right rowspan=2>"
            'End Integration by SavitaS
            'Header
            ''Commented by PrashantSJ on 21st July 2006
            'strHTML += MyBase.GetResourceString("RFIHEADER")
            'strHTML += "</td><td valign=top rowspan=2>"
            'strHTML += " : " + m_strRFIHeader
            'strHTML += "</td></tr><tr class=clsTREven>"
            'End of comment by PrashantSJ
            'Contract
            'strHTML += "<td  align=right>"
            strHTML += MyBase.GetResourceString("CONTRACT")
            'strHTML += "</td><td align=left>"
            strHTML += "</td><td valign=top align=left>"
            strHTML += " : " + m_strContractName
            If m_intCustomerID <> 0 Then
                'Modified By VidyaJ - Security issue - 6197
                Dim strToken As String
                strToken = CommonFunctions.Security.Token.GetToken(m_intContractID.ToString + Session("intUserID").ToString + "0" + "2130")
                'strHTML += " <A href=" + "javascript:ContractDetails_OnClick('" + strtoken + "')" + " title='" + MyBase.GetResourceString("CONTITLE") + _"'><B>" + MyBase.GetResourceString("SHOWDETAILS") + "</B></A> "

                strHTML += " <A href=" + "javascript:ContractDetails_OnClick('" + strToken + "')" + " title='" + MyBase.GetResourceString("CONTITLE") + "'><B>" + MyBase.GetResourceString("SHOWDETAILS") + "</B></A>"
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                CommonFunctions.HTMLControls.DrawTextBox("txtHiddenToken1", "txtHiddenToken1", , , , strToken, , , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            End If

            strHTML += "</td>"
            'Added by PrashantSJ on 08 Dec 2006
            'Purpose: To plot the Salesperiod Combobox (using this we can select any open salesperiod
            'strHTML += "<td valign=top align=right>"
            'strHTML += "Sales Period"
            'strHTML += "</td><td align=left>"
            'strHTML += " : " + m_strSalesPeriod
            'strHTML += "</td></tr><tr class=clsTREven>"
            'End Integration by SavitaS on 13 Mar 2006
            'Commented by Trupti
            'strHTML += "</td></tr>"

            'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
            'Header 
            'strHTML += "<tr class=clsTREven><td valign=top align=right>"
            'End of addition by PrashantSJ on 08 Dec 2006

            'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
            'Header 
            'strHTML += "<td valign=top align=right>"
            strHTML += "<td valign=top align=right>"
            strHTML += MyBase.GetResourceString("RFIHEADER")
            strHTML += "</td><td align=left>"
            strHTML += " : " + m_strRFIHeader
            'strHTML += "</td></tr><tr class=clsTREven>"
            'End Integration by SavitaS on 13 Mar 2006
            'Trupti
            'strHTML += "</td></tr></table>"
            strHTML += "</td></tr></table>"
        End If
        strHTML += "</div>"

        If m_intRFIID <> 0 Then

            'strHTML += "<br>"


            'strHTML += "<table cellspacing=0 class=clsTable border=0 width=100%><tr class=clsTRColumnHeader><td width=95%>"
            'strHTML += MyBase.GetResourceString("SUBTAGHEAD")
            'strHTML += "</td></tr></table><br>"
            strHTML += GenerateTabSections()
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            strHTML += "<table class='clsSubtagTable' width=99.9%><tr><td>"
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            'Menu for Items

            'Display the static menu
            Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
            Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
            Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

            If m_blnAddAccess = True Then
                ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ADDNEW"))
                'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                m_strNewItemToken = CommonFunctions.Security.Token.GetToken(CType(0, String) + CType(m_intRFIID, String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
                'End by MonikaI
                ArrClientSideFunctionsList.Add("AddNewItem_OnClick()")
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP"))
            End If

            If m_blnDeleteAccess = True Then
                ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DEL"))
                ArrClientSideFunctionsList.Add("DeleteItem_OnClick()")
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DEL"))
                ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
                ArrClientSideFunctionsList.Add("SelectAll_OnClick()")
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP"))
                'Added by TruptiK on 19-Jun-2007
                'Purpose:-To add clear all link.
                ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLEARALL"))
                ArrClientSideFunctionsList.Add("ClearAll_OnClick()")
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP"))
                'End of addition by TruptiK

            End If
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_Help"))
            ArrClientSideFunctionsList.Add("Help_OnClick('" & m_intHelpID & "')")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_Help_TOOLTIP"))


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

            objMenu = New WebPages.Template.StaticMenu
            strHTML += objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
            objMenu = Nothing
            strHTML += "<br>"

            GetRFITypeAttributes(m_intRFITypeID)
            strHTML += PlotGridForItems()
            strHTML += "</td></tr></table><br>"

        End If
        Response.Write(strHTML)
    End Sub

    '====================================================================
    ' Procedure Name        :   GetTheRequiredFields
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To get the required Fields for Plotting UI
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 30, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub GetTheRequiredFields()
        ' If the form contents are to be retained, then...
        ' NOTE: This case will arise when Customer Name is changed, of record is saved, and the saved contents are to be persisted.
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtRFIID"), "0") <> "0" Or m_strAction = "ChangeCustomer" Then
            m_intProjectID = CType(MyBase.GetFormValue("txtProjectID"), Long)

            m_strProjectOrProduct = MyBase.GetFormValue("txtProjectOrProduct")

            If m_strProjectOrProduct = "" Then
                m_strProjectOrProduct = "Project"
            End If

            If MyBase.GetFormValue("optRequestTypeID") = "1" Then
                m_blnIsProforma = True
            Else
                m_blnIsProforma = False
            End If

            If MyBase.GetFormValue("cboRFITypeID") <> "" Then
                m_intRFITypeID = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboRFITypeID")), Integer)
            Else
                m_intRFITypeID = 0
            End If

            If MyBase.GetFormValue("cboCustomerID") <> "" Then
                m_intCustomerID = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboCustomerID")), Integer)
            Else
                m_intCustomerID = 0
            End If

            If MyBase.GetFormValue("cboCustomerContactID") <> "" Then
                m_intCustomerContactID = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboCustomerContactID"), "0"), Integer)
            Else
                m_intCustomerContactID = 0
            End If

            If MyBase.GetFormValue("txtCustomerAddressID") <> "" Then
                m_intCustomerAddressID = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtCustomerAddressID")), Integer)
            Else
                m_intCustomerAddressID = 0
            End If

            If MyBase.GetFormValue("cboBillingCurrencyID") <> "" Then
                m_intBillingCurrencyID = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboBillingCurrencyID")), Integer)
            Else
                m_intBillingCurrencyID = 0
            End If

            If MyBase.GetFormValue("txtBillingCurrencyCode") <> "" Then
                m_strBillingCurrencyCode = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtBillingCurrencyCode"))
            Else
                m_strBillingCurrencyCode = ""
            End If
            ''Added by PrashantSJ on 12th June 2007 for WhiziblesEM 7.0 

            If MyBase.GetFormValue("txtCompanyBaseCurrencyCode") <> "" Then
                m_strCompanyBaseCurrencyCode = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtCompanyBaseCurrencyCode"))
            Else
                m_strCompanyBaseCurrencyCode = ""
            End If
            'End of addition by PrashantSJ on 12th June 2007

            If MyBase.GetFormValue("txtCreditDays") <> "" Then
                m_intCreditDays = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtCreditDays")), Integer)
            Else
                m_intCreditDays = 0
            End If

            If MyBase.GetFormValue("txtLOC") <> "" Then
                m_strLOC = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtLOC"))
            Else
                m_strLOC = ""
            End If

            If MyBase.GetFormValue("txtConfirmEmailID") <> "" Then
                m_strConfirmEmailID = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtConfirmEmailID"))
            Else
                m_strConfirmEmailID = ""
            End If

            If MyBase.GetFormValue("cboMilestoneID") <> "" Then
                m_intMileStoneID = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboMilestoneID")), Integer)
            Else
                m_intMileStoneID = 0
            End If
            'Modified by TruptiK on 19-Jun-2007
            If MyBase.GetFormValue("txtcontractid") <> "" Then
                m_intContractID = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtcontractid"), "0"), Integer)
            Else
                m_intContractID = 0
            End If
            If MyBase.GetFormValue("txtcontract") <> "" Then
                m_strContractName = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtcontract", False))
            Else
                m_strContractName = ""
            End If
            If MyBase.GetFormValue("txtChecklistInstanceID") <> "" Then
                m_intCheckListInstanceId = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtChecklistInstanceID")), Integer)
            Else
                m_intCheckListInstanceId = 0
            End If
            'Integrated by TruptiK on 26-Apr-2007
            'Added by PrashantSJ on 08 Dec 2006
            'Purpose: To plot the Salesperiod Combobox (using this we can select any open salesperiod
            'Modified and added by TruptiK on 21-Jun-2007
            If MyBase.GetFormValue("txtSalesPeriodID") <> "" Then
                m_intSalesPeriodID = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtSalesPeriodID"), "0"), Integer)
            Else
                m_intSalesPeriodID = 0
            End If
            If MyBase.GetFormValue("txtSalesPeriod") <> "" Then
                m_strSalesPeriod = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtSalesPeriod"), ""), String)
            Else
                m_strSalesPeriod = ""
            End If
            'End of addition and modification by TruptiK on 21-Jun-2007
            'End of addition by PrashantSJ on 08 Dec 2006
            'End of integration by TruptiK
            If MyBase.GetFormValue("txtRFIHeader") <> "" Then
                m_strRFIHeader = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtRFIHeader"))
            Else
                m_strRFIHeader = ""
            End If

            m_strRFIToolIDs = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtRFIToolIDs"))
            m_strRFIToolNames = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtRFIToolNames"))
            m_strRFIOSIDs = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtRFIOSIDs"))
            m_strRFIOSNames = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtRFIOSNames"))
            m_strRFISalesPersonIDs = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtRFISalesPersonIDs"))
            m_strRFISalesPersonNames = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtRFISalesPersonNames"))

            ' When the RFI is saved for the first time, these values will be blank. So they need to be initialized.
            'If m_strRFIToolIDs = "" Then m_strRFIToolIDs = ","
            'If m_strRFIOSIDs = "" Then m_strRFIOSIDs = ","
            'If m_strRFISalesPersonIDs = "" Then m_strRFISalesPersonIDs = ","

            If m_strAction = "ChangeCustomer" And m_intCustomerID <> 0 Then
                ' Get the default credit days to be applied.
                Dim strSQLQuery As String
                Dim drDetails As IDataReader
                strSQLQuery = "Exec usp_Sel_tbl_PM_Customer_RFI " & m_intCustomerID
                drDetails = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDetails.Read Then
                    'm_intCreditDays = CType(CommonFunctions.General.CheckIsNothing(drDetails.Item("CreditPeriod")), Integer)
                    m_intCreditDays = CType(CommonFunctions.Data.CheckIsDBNull(drdetails.Item("CreditPeriod"), "0"), Integer)
                End If
                CommonFunctions.Data.DisposeDataReader(drDetails)

                m_intCustomerAddressID = 0

                ' Get the new Customer Address ID to be applied (for the new customer).
                strSQLQuery = "Exec usp_Sel_tbl_PM_Customer_Addresses_GetDefaultAddress " & m_intCustomerID.ToString & ", " & m_intProjectID.ToString
                drDetails = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDetails.Read Then
                    m_intCustomerAddressID = CType(CommonFunctions.General.CheckIsNothing(drDetails.Item("CustomerAddressID")), Integer)
                End If
                CommonFunctions.Data.DisposeDataReader(drDetails)
                m_strContractName = ""
                m_intContractID = 0
                m_strConfirmEmailID = ""

            End If
            'Added by TruptiK on 23-Jun-2007
            If m_strAction = "ChangeCustomer" And m_intCustomerID = 0 Then
                m_strContractName = ""
                m_intContractID = 0
            End If
            'End of addition by TruptiK

            ' In case the status has been changed, then the value in this variable will be set beforehand. 
            ' Else, retrieve the previous status value from the FORM collection.
            If m_strCurrentStatus = "" Then
                m_strCurrentStatus = Request.Form("txtCurrentStatus")
            End If

            ' Get the Recordset contents.
        ElseIf m_intRFIID <> 0 Then
            Dim strSQLQuery As String
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFIs " & m_intRFIID

            Dim drDetails As IDataReader
            drdetails = CommonFunctions.Data.GetDataReader(strsqlquery, MyBase.UseSQL)
            If drdetails.Read Then

                m_intProjectID = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("ProjectID")), Integer)
                m_strProjectOrProduct = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("ProjectOrProduct")), String)
                If m_strProjectOrProduct = "" Then
                    m_strProjectOrProduct = "Project"
                End If
                m_blnIsProforma = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("IsProforma"), "false"), Boolean)
                m_intRFITypeID = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("RFITypeID")), Integer)
                m_strRFITypeName = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("RFITypeName")), String)
                m_strCurrentStatus = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("CurrentStatus")), String)
                m_intCustomerID = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("CustomerID")), Integer)
                m_strCustomerName = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("CustomerName")), String)
                m_intCustomerContactID = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("CustomerContactID")), Integer)
                m_strCustomerContactName = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("ContactPerson")), String)
                'Modified by TruptiK on 18-Jun-2007
                m_intCustomerAddressID = CType(CommonFunctions.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drdetails.Item("CustomerAddressID"), "0"), "0"), Integer)
                'End of modification by TruptiK 
                m_intBillingCurrencyID = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("BillingCurrencyID")), Integer)
                m_strBillingCurrencyCode = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("BillingCurrencyCode")), String)
                m_dblBaseCurrencyAmount = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("BaseCurrencyAmount")), Double)
                'm_dblCompanyBaseCurrencyAmount = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("companybasecurrencyamount")), Double)
                m_intCreditDays = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("CreditDays")), Integer)
                m_strLOC = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("LOC")), String)
                m_strConfirmEmailID = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("ConfirmEmailID")), String)
                m_intMileStoneID = CType(CommonFunctions.Data.CheckIsDBNull(drdetails.Item("MilestoneID"), "0"), Integer)
                m_strMilestoneName = CType(CommonFunctions.Data.CheckIsDBNull(drdetails.Item("Milestone")), String)
                m_intContractID = CType(CommonFunctions.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drdetails.Item("ContractID"), "0"), "0"), Integer)
                'Modified by TruptiK on 20-Jun-2007
                'Purpose:-To get ContractName from contractsummry field
                m_strContractName = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drdetails.Item("InvoiceingMilestones"), ""), ""), String)
                'm_strContractName = CType(CommonFunctions.Data.CheckIsDBNull(drdetails.Item("ContractSummary")), String)
                'End of modification by TruptiK on 20-Jun-2007
                m_intCheckListInstanceId = CType(CommonFunctions.Data.CheckIsDBNull(drdetails.Item("ChecklistInstanceID"), "0"), Integer)
                m_strRFIHeader = CType(CommonFunctions.Data.CheckIsDBNull(drdetails.Item("RFIHeader")), String)
                'Integrated by TruptiK on 26-Apr-2007
                'Added by PrashantSJ on 08 Dec 2006
                'Purpose: To plot the Salesperiod Combobox (using this we can select any open salesperiod
                m_intSalesPeriodID = CType(CommonFunctions.Data.CheckIsDBNull(drdetails.Item("SalesPeriodID"), "0"), Integer)
                m_strSalesPeriod = CType(CommonFunctions.Data.CheckIsDBNull(drdetails.Item("SalesPeriod"), ""), String)
                'End of addition by PrashantSJ on 08 Dec 2006
                'End of integration by TruptiK
                m_strCurrentStatus = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("CurrentStatus")), String)
                m_blnInvoiceGenerated = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("InvoiceGenerated")), Boolean)
                m_strCompanyBaseCurrencyCode = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("CompanyBaseCurrencyCode")), String)
            End If
            CommonFunctions.Data.DisposeDataReader(drDetails)

            ' Retrieve comma separated list of Tool IDs and Tool Names.
            'm_strRFIToolIDs = ","
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFI_Tools " & m_intRFIID.ToString

            drdetails = CommonFunctions.Data.GetDataReader(strsqlquery, MyBase.UseSQL)

            Do While drdetails.Read
                m_strRFIToolIDs = m_strRFIToolIDs & CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("ProjectToolID")), String) & ","
                m_strRFIToolNames = m_strRFIToolNames & CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("ToolName")), String) & ", "
            Loop
            CommonFunctions.Data.DisposeDataReader(drDetails)

            If m_strRFIToolNames <> "" Then
                m_strRFIToolNames = Left(m_strRFIToolNames, InStrRev(m_strRFIToolNames, ",") - 1)
            End If

            If m_strRFIToolIDs <> "" Then
                m_strRFIToolIDs = Left(m_strRFIToolIDs, InStrRev(m_strRFIToolIDs, ",") - 1)
            End If


            ' Retrieve comma separated list of OS IDs and OS Names.
            'm_strRFIOSIDs = ","
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFI_OS " & m_intRFIID.ToString
            drdetails = CommonFunctions.Data.GetDataReader(strsqlquery, MyBase.UseSQL)

            Do While drdetails.Read
                m_strRFIOSIDs = m_strRFIOSIDs & CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("ProjectOSID")), String) & ","
                m_strRFIOSNames = m_strRFIOSNames & CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("OSName")), String) & ", "
            Loop

            CommonFunctions.Data.DisposeDataReader(drDetails)

            If m_strRFIOSNames <> "" Then
                m_strRFIOSNames = Left(m_strRFIOSNames, InStrRev(m_strRFIOSNames, ",") - 1)
            End If

            If m_strRFIOSIDs <> "" Then
                m_strRFIOSIDs = Left(m_strRFIOSIDs, InStrRev(m_strRFIOSIDs, ",") - 1)
            End If

            ' Retrieve comma separated list of Sales Person IDs and Sales Person Names.
            'm_strRFISalesPersonIDs = ","
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFI_SalesPersons " & m_intRFIID
            drdetails = CommonFunctions.Data.GetDataReader(strsqlquery, MyBase.UseSQL)

            Do While drdetails.Read
                m_strRFISalesPersonIDs = m_strRFISalesPersonIDs & CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("SalesPersonID")), String) & ","
                m_strRFISalesPersonNames = m_strRFISalesPersonNames & CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("SalesPersonName")), String) & ", "
            Loop
            CommonFunctions.Data.DisposeDataReader(drDetails)

            If m_strRFISalesPersonNames <> "" Then
                m_strRFISalesPersonNames = Left(m_strRFISalesPersonNames, InStrRev(m_strRFISalesPersonNames, ",") - 1)
            End If

            If m_strRFISalesPersonIDs <> "" Then
                m_strRFISalesPersonIDs = Left(m_strRFISalesPersonIDs, InStrRev(m_strRFISalesPersonIDs, ",") - 1)
            End If

            'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
            If m_strRFIMilestoneIDs <> "" Then
                m_strRFIMilestoneIDs = Left(m_strRFIMilestoneIDs, InStrRev(m_strRFIMilestoneIDs, ",") - 1)
            End If
            'End Integration by SavitaS on 13 Mar 2006
            ' The Default values (in case of new RFI).
        Else

            ' If the RFPI Filter is applied, assume that an RFPI is to be added.
            If m_intFilter_IsProforma = 1 Then
                m_blnIsProforma = True
            Else
                m_blnIsProforma = False
            End If

            ' If the RFI Type filter is applied, then assume that a new RFI/RFPI of that type has to be added.
            m_intRFITypeID = m_intFilter_TypeID

            ' The Customer ID.
            m_intCustomerID = 0
            'Added by TruptiK on 21-Jun-2007
            m_strContractName = ""
            'End of addition by TruptiK

            ' Retrieve information about the PROJECT.
            Dim strSQLQuery As String
            Dim drDetails As IDataReader
            strSQLQuery = "Exec usp_Sel_tbl_PM_Project " & m_intProjectID
            drdetails = CommonFunctions.Data.GetDataReader(strsqlquery, MyBase.UseSQL)
            If drdetails.Read Then
                m_strProjectOrProduct = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("ProjectOrProduct")), String)
                If m_strProjectOrProduct = "" Then
                    m_strProjectOrProduct = "Project"
                End If
                m_intCustomerID = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("CustomerID")), Integer)
                m_intBillingCurrencyID = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("BillingCurrencyID")), Integer)
            End If
            CommonFunctions.Data.DisposeDataReader(drDetails)


            ' Get the billing currency code.		
            If m_intBillingCurrencyID <> 0 Then
                strSQLQuery = "Exec usp_Sel_tbl_PM_CurrencyMaster " & m_intBillingCurrencyID
                drdetails = CommonFunctions.Data.GetDataReader(strsqlquery, MyBase.UseSQL)
                If drdetails.Read Then
                    m_strBillingCurrencyCode = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("CurrencyCode")), String)
                End If
                CommonFunctions.Data.DisposeDataReader(drDetails)
            End If

            m_intCreditDays = 30
            m_intCustomerAddressID = 0
            If m_intCustomerID <> 0 Then

                ' Get the default credit days to be applied.
                strSQLQuery = "Exec usp_Sel_tbl_PM_Customer_RFI " & m_intCustomerID.ToString
                drdetails = CommonFunctions.Data.GetDataReader(strsqlquery, MyBase.UseSQL)
                If drdetails.Read Then
                    ' m_intCreditDays = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("CreditPeriod")), Integer)
                    m_intCreditDays = CType(CommonFunctions.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drdetails.Item("CreditPeriod"), "0"), "0"), Integer)
                End If
                CommonFunctions.Data.DisposeDataReader(drDetails)


                ' Get the new Customer Address ID to be applied (for the new customer).
                strSQLQuery = "Exec usp_Sel_tbl_PM_Customer_Addresses_GetDefaultAddress " & m_intCustomerID.ToString & ", " & m_intProjectID.ToString
                drdetails = CommonFunctions.Data.GetDataReader(strsqlquery, MyBase.UseSQL)
                If drdetails.Read Then
                    m_intCustomerAddressID = CType(CommonFunctions.General.CheckIsNothing(drdetails.Item("CustomerAddressID")), Integer)
                End If
                CommonFunctions.Data.DisposeDataReader(drDetails)

            End If

        End If

        If m_intCustomerID = 0 Then
            m_intCustomerID = 0
        End If

        ' NOTE: For all other roles, except the RFI Initiator, the read-only screen must be displayed.
        '		Once the RFI Initiator submits the RFI, the RFI details screen will become read-only.
        '		In other word, only the RFI Initiator is allowed to edit the RFI details, and that too, if the RFI is in "Draft" or "Rejected" state.
        m_blnAddAccess = True
        m_blnDeleteAccess = True
        m_blnEditAccess = True
        m_blnViewAccess = False
        m_blnReadOnly = False
        If (m_strUserType <> RFI_INITIATOR) Or (m_strCurrentStatus <> "" And m_strCurrentStatus <> RFI_STATUS_DRAFT And m_strCurrentStatus <> RFI_STATUS_REJECTED) Then
            m_blnAddAccess = False
            m_blnDeleteAccess = False
            m_blnEditAccess = False
            m_blnViewAccess = True
            m_blnReadOnly = True
        End If

        ' Get the number of RFI Items added to the RFI.
        ' NOTE: If the Items are added, then the RFI Type, and Billing Currency cannot be modified.
        m_intTotalRFIItemCount = 0
        If m_intRFIID <> 0 Then
            Dim strSQLQuery As String
            Dim drdetails As IDataReader

            'Commented and Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
            'Modified by GaneshG on 6 Jan 2005
            'strSQLQuery = "Exec usp_Sel_tbl_PM_RFI_Items NULL, " & m_intRFIID.ToString

            '' Commented By NageshM On Date 15th Nov 2005
            '' Purpose : To insert the selected milestone as a line Item on save.
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFI_Items NULL, " & m_intRFIID.ToString
            'strSQLQuery = "Exec usp_Sel_tbl_PM_RFI_ItemswithMilestones NULL, " & m_intRFIID.ToString

            'End Modification by GaneshG on 6 Jan 2005
            'End Integration by SavitaS on 13 Mar 2006

            ' End of Commenting By NageshM
            drdetails = CommonFunctions.Data.GetDataReader(strsqlquery, MyBase.UseSQL)
            While drdetails.Read
                m_intTotalRFIItemCount += 1
            End While
            CommonFunctions.Data.DisposeDataReader(drDetails)
        End If
    End Sub

    '=====================================================================
    ' Procedure Name		:	ChangeRFIStatus
    ' Purpose				:	To update the RFI status and insert a record in the status history table.
    ' Description			:	Same as above.
    ' Parameters Passed		:	RFIID		    :- The RFI ID.
    '							ProjectID	:- The Project ID.
    '							NewRFIStatus	:- The new status of the RFI.
    '							Comments		:- Comments to be entered.
    ' Parameters Affected	:	None.
    ' Returns				:	No return values.
    ' Assumptions			:	None.
    ' Dependencies			:	None.
    ' Author				:	DipaliS
    ' Created				:	30 July 2004
    ' Revisions				:
    '=====================================================================							

    Private Sub ChangeRFIStatus(ByVal RFIID As Integer, ByVal ProjectID As Long, ByVal NewRFIStatus As String, ByVal Comments As String)
        Dim strSQLQuery As String
        ' Build query to update the RFI status and insert the Status History record.
        strSQLQuery = "Exec usp_Upd_tbl_PM_RFIs_ChangeRFIStatus " & m_intRFIID & ", " & m_intProjectID
        strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(NewRFIStatus) & "'"
        strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Comments) & "'"
        strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"

        m_strCurrentStatus = NewRFIStatus

        CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
    End Sub

    '====================================================================
    ' Procedure Name        :   PerformAction
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To perform necessary action 'SAVE/COPY/DELETE
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 29, 2004
    ' Revisions :
    '=====================================================================

    Private Sub PerformAction()
        Select Case m_strAction.ToUpper
            Case "SAVE"
                Dim strSQLQuery As String

                ' Build Query to insert/update the RFI record.
                strSQLQuery = "Exec usp_Ins_tbl_PM_RFIs "

                ' For "Edit" mode pass the RFIID. For "New" mode pass NULL.
                If m_intRFIID <> 0 Then
                    strSQLQuery = strSQLQuery & m_intRFIID
                Else
                    strSQLQuery = strSQLQuery & "NULL"
                End If

                ' Project ID.
                strSQLQuery = strSQLQuery & ", " & m_intProjectID

                ' RFI / RFPI. [0 : RFI; 1 : RFPI]
                If Trim(Request.Form("optRequestTypeID")) <> "" Then
                    strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("optRequestTypeID"))
                Else
                    strSQLQuery = strSQLQuery & ", 0"
                End If

                ' RFI Type ID.
                If Trim(Request.Form("cboRFITypeID")) <> "" Then
                    strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("cboRFITypeID"))
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' Customer ID.
                If Trim(Request.Form("cboCustomerID")) <> "" Then
                    strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("cboCustomerID"))
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' Customer Contact ID.
                'Modified by TruptiK on 20-Jun-2007
                If Trim(Request.Form("cboCustomerContactID")) <> "" Then
                    strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("cboCustomerContactID"))
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' Customer Address ID.
                If Trim(Request.Form("txtCustomerAddressID")) <> "" Then
                    strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("txtCustomerAddressID"))
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' Billing Currency ID.
                If Trim(Request.Form("cboBillingCurrencyID")) <> "" Then
                    strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("cboBillingCurrencyID"))
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' Credit Days.
                If Trim(Request.Form("txtCreditDays")) <> "" Then
                    strSQLQuery = strSQLQuery & ", " & CLng(Request.Form("txtCreditDays"))
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' LOC.
                If Trim(Request.Form("txtLOC")) <> "" Then
                    strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Left(Trim(Request.Form("txtLOC")), 100)) & "'"
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' Email Confirm.
                If Trim(Request.Form("txtConfirmEmailID")) <> "" Then
                    strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Left(Trim(Request.Form("txtConfirmEmailID")), 100)) & "'"
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' Milestone.
                If Trim(Request.Form("cboMilestoneID")) <> "" Then
                    strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("cboMilestoneID"))
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' Contract ID.
                'If Trim(Request.Form("cboContractID")) <> "" Then
                '    strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("cboContractID"))
                'Else
                '    strSQLQuery = strSQLQuery & ", NULL"
                'End If
                If Trim(Request.Form("txtcontractid")) <> "" Then
                    strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("txtcontractid"))
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' RFI Header.
                If Trim(Request.Form("txtRFIHeader")) <> "" Then
                    strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Left(Trim(Request.Form("txtRFIHeader")), 2000)) & "'"
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If
                'Integrated by TruptiK on 26-Apr-2007
                'Added by PrashantSJ on 08 Dec 2006
                'Purpose: To plot the Salesperiod Combobox (using this we can select any open salesperiod
                ' Sales period.
                'Modified by TruptiK on 21-Jun-2007
                If Trim(Request.Form("txtSalesPeriodID")) <> "" Then
                    strSQLQuery = strSQLQuery & ", " & Trim(Request.Form("txtSalesPeriodID"))
                    'End of modification by TruptiK on 21-Jun-2007
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If
                'End of addition by PrashantSJ on 08 Dec 2006
                'End of integration by TruptiK
                ' Created By (for audit trail).				
                strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Trim(m_objGlobal.UserName)) & "'"

                ' Save record and retrieve the RFIID.
                m_intRFIID = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL)), Integer)

                'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                If HttpContext.Current.Request.QueryString("Mode") = "New" Then
                    If m_strUserType = "Initiator" Then
                        m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_intRFIID, String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
                    End If
                End If
                'End by MonikaI

                ' If a new RFI is created change the status to "Draft".
                If m_strMode.ToUpper = "NEW" Then
                    Call ChangeRFIStatus(m_intRFIID, m_intProjectID, RFI_STATUS_DRAFT, "-")
                End If


                ' Save the selected Sales Persons.
                If Trim(Request.Form("txtRFISalesPersonIDs")) <> "" And Trim(Request.Form("txtRFISalesPersonIDs")) <> "," Then
                    strSQLQuery = "Exec usp_Ins_tbl_PM_RFI_SalesPersons_SaveAll " & m_intRFIID & ", " & m_intProjectID & ", '," & Trim(Request.Form("txtRFISalesPersonIDs")) & ",', '" & CommonFunctions.General.BuildQueryString(Trim(m_objGlobal.UserName)) & "'"
                Else
                    strSQLQuery = "Exec usp_Ins_tbl_PM_RFI_SalesPersons_SaveAll " & m_intRFIID & ", " & m_intProjectID & ", ',', '" & CommonFunctions.General.BuildQueryString(Trim(m_objGlobal.UserName)) & "'"
                End If

                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

                ' Save the selected Language(s) of Development.
                If Trim(Request.Form("txtRFIToolIDs")) <> "" And Trim(Request.Form("txtRFIToolIDs")) <> "," Then
                    strSQLQuery = "Exec usp_Ins_tbl_PM_RFI_Tools_SaveAll " & m_intRFIID & ", " & m_intProjectID & ", '," & Trim(Request.Form("txtRFIToolIDs")) & ",', '" & CommonFunctions.General.BuildQueryString(Trim(m_objGlobal.UserName)) & "'"
                Else
                    strSQLQuery = "Exec usp_Ins_tbl_PM_RFI_Tools_SaveAll " & m_intRFIID & ", " & m_intProjectID & ", ',', '" & CommonFunctions.General.BuildQueryString(Trim(m_objGlobal.UserName)) & "'"
                End If

                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

                ' Save the selected Operating Systems.							
                If Trim(Request.Form("txtRFIOSIDs")) <> "" And Trim(Request.Form("txtRFIOSIDs")) <> "," Then
                    strSQLQuery = "Exec usp_Ins_tbl_PM_RFI_OS_SaveAll " & m_intRFIID & ", " & m_intProjectID & ", '," & Trim(Request.Form("txtRFIOSIDs")) & ",', '" & CommonFunctions.General.BuildQueryString(Trim(m_objGlobal.UserName)) & "'"
                Else
                    strSQLQuery = "Exec usp_Ins_tbl_PM_RFI_OS_SaveAll " & m_intRFIID & ", " & m_intProjectID & ", ',', '" & CommonFunctions.General.BuildQueryString(Trim(m_objGlobal.UserName)) & "'"
                End If

                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

                m_strMode = "Edit"

            Case "COPY"

                ' Build Query to copy the selected RFI.		
                Dim StrSQLQuery As String
                strSQLQuery = "Exec usp_Ins_tbl_PM_RFIs_CopyRFI " & m_intRFIID

                ' Copied By.				
                strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Trim(m_objGlobal.UserName)) & "'"

                ' Save record and retrieve the RFIID.
                m_intRFIID = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), Integer)
                'Added by MonikaI on 18-Sep-2006 .IssueID : 6492 (Security)
                If HttpContext.Current.Request.QueryString("Mode") = "New" Then
                    If m_strUserType = "Initiator" Then
                        m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_intRFIID, String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
                    End If
                End If
                'End by MonikaI

                Call ChangeRFIStatus(m_intRFIID, m_intProjectID, RFI_STATUS_DRAFT, "-")

                m_strMode = "Edit"

            Case "DELETEITEM"

                Dim strSQLQuery As String

                Dim intCtr As Integer
                Dim strChkDel() As String
                Dim strChkDels As String
                strChkDels = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkDeleteItem"))
                If strChkDels <> "" Then
                    strChkDel = strChkDels.Split(m_charSep)
                End If

                m_strDeletionStatus = ""

                If strChkDels <> "" Then
                    'For each selected RFI Item...
                    For intCtr = 0 To strChkDel.Length - 1


                        ' Build Query to delete the selected RFI Item.
                        strSQLQuery = "DECLARE @strDeletionStatus AS varchar(1000)" & vbCrLf
                        strSQLQuery = strSQLQuery & "Exec usp_Del_tbl_PM_RFI_Items " & strChkDel(intCtr) & ", @strDeletionStatus OUTPUT" & vbCrLf
                        strSQLQuery = strSQLQuery & "SELECT 'DeletionStatus' = @strDeletionStatus" & vbCrLf


                        ' Get the status of the deletion. 
                        Dim strStatus As String
                        ' strStatus = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), String)

                        'Commented and Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
                        'strStatus = CType(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), "0"), String)
                        strStatus = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), ""), String)
                        'End Integration by SavitaS on 13 Mar 2006

                        If strStatus <> "" Then
                            m_strDeletionStatus += strStatus & "\n"
                        End If

                    Next
                End If
            Case "FIXEDFEE"
                Dim m_sLQuery As String = ""
                Dim iResult As Integer
                m_sLQuery = "usp_Ins_ProjectTimesheet_RFIItems " & m_intProjectID & "," & m_intRFIID.ToString & " ,NULL ,'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                'CommonFunction.Data.InsertOrUpdateData(m_sLQuery, MyBase.UseSQL)

                iResult = CommonFunction.Data.InsertOrUpdateData(m_sLQuery, MyBase.UseSQL)
                'CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(m_sLQuery, MyBase.UseSQL), "0"), "0"), Integer)()
                If iResult = 1 Then
                    m_sSQL = m_sSQL + "Currently,no resources assigned to this project !"
                End If

                ''''
                m_strMode = "Edit"
                'Trupti
                'Integrated  by SavitaS on 14 Mar 2006 for IssueID-2836
                'Added by GaneshG on 14 Mar 06 
                'Purpose : To delete the line item related to Customer.
                'Case "CHANGECUSTOMER"
                '    Dim strSQLQuery As String
                '    strSQLQuery = "usp_Del_RFI_Milestones " & m_intRFIID.ToString
                '    CommonFunction.Data.InsertOrUpdateData(StrSQLQuery, MyBase.UseSQL)
                'End Addition by GaneshG 
                'End Integration by SavitaS
        End Select

    End Sub

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
    ' Created               :   July 31 2004
    ' Revisions             :
    '=====================================================================

    Private Function PlotGridForItems() As String
        m_objGridforItems = New WebPages.Template.AdvancedGrid
        Dim intCtr As Integer

        ''' Commented By NageshM On date 15th Nov 2005
        ' Dim strsql As String = "Exec usp_Sel_tbl_PM_RFI_Items NULL, " & m_intRFIID.ToString
        'Commented and Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
        'Dim strsql As String = "Exec usp_Sel_tbl_PM_RFI_ItemswithMilestones NULL, " & m_intRFIID.ToString
        Dim strsql As String = "Exec usp_Sel_tbl_PM_RFI_Items NULL, " & m_intRFIID.ToString
        'End Integration by SavitaS on 13 Mar 2006
        '' End Of Commenting By NageshM
        Dim arrActualColumnArray() As String

        Dim arrUserFriendlyArray() As String

        Dim arrCheckBoxIDArray() As String
        Dim arrSummary() As String
        Dim strGrid As String
        Dim arrCheck() As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'ReDim arrActualColumnArray(UBound(arrRFITypeAttributes) + 3)
        'ReDim arrUserFriendlyArray(UBound(arrRFITypeAttributes) + 3)
        'ReDim arrCheckBoxIDArray(UBound(arrRFITypeAttributes) + 3)
        'ReDim arrCheck(UBound(arrRFITypeAttributes) + 3)
        'ReDim arrSummary(UBound(arrRFITypeAttributes) + 3)
        ReDim arrActualColumnArray(UBound(arrRFITypeAttributes) + 4)
        ReDim arrUserFriendlyArray(UBound(arrRFITypeAttributes) + 4)
        ReDim arrCheckBoxIDArray(UBound(arrRFITypeAttributes) + 4)
        ReDim arrCheck(UBound(arrRFITypeAttributes) + 4)
        ReDim arrSummary(UBound(arrRFITypeAttributes) + 4)

        'Fill the array for Grid
        For intCtr = 0 To UBound(arrRFITypeAttributes)
            arrUserFriendlyArray(intCtr) = arrRFITypeAttributes(intCtr, 1)
            arrActualColumnArray(intCtr) = arrRFITypeAttributes(intCtr, 0)
            If arrRFITypeAttributes(intCtr, 0) = "Rate" Or arrRFITypeAttributes(intCtr, 0) = "Amount" Then
                arrUserFriendlyArray(intCtr) += "(" & m_strBillingCurrencyCode + ")"
            End If
            arrCheckBoxIDArray(intCtr) = ""
            arrCheck(intCtr) = ""
            If arrRFITypeAttributes(intCtr, 0) = "Amount" Then
                arrSummary(intCtr) = "SUM"
            Else
                arrSummary(intCtr) = ""
            End If
        Next
        'Integrated by TruptiK
        ''Added and Commented By PrashantSJ on 28th July 2006
        ''Purpose: To Show the Company Base Currency Amount on List page of Invoice Item Sub tab
        'arrUserFriendlyArray(intCtr) = MyBase.GetResourceString("EQUIVAMOUNT").Replace("<code>", m_strBaseCurrencyCode)
        'arrActualColumnArray(intCtr) = "BaseCurrencyAmount"
        'arrCheckBoxIDArray(intCtr) = ""
        'arrCheck(intCtr) = ""
        'arrSummary(intCtr) = "SUM"

        'If m_blnDeleteAccess = True Then
        '    arrUserFriendlyArray(intCtr + 1) = MyBase.GetResourceString("MENU_DEL")
        '    arrActualColumnArray(intCtr + 1) = MyBase.GetResourceString("MENU_DEL")
        '    arrCheckBoxIDArray(intCtr + 1) = "chkDeleteItem"
        '    arrCheck(intCtr + 1) = "chkDeleteItem"
        'End If
        arrUserFriendlyArray(intCtr) = MyBase.GetResourceString("EQUIVAMOUNT").Replace("<code>", m_strBaseCurrencyCode)
        arrActualColumnArray(intCtr) = "BaseCurrencyAmount"
        arrCheckBoxIDArray(intCtr) = ""
        arrCheck(intCtr) = ""
        arrSummary(intCtr) = "SUM"


        arrUserFriendlyArray(intCtr + 1) = MyBase.GetResourceString("EQUIVAMOUNTCOMPANY").Replace("<code>", m_strCompanyBaseCurrencyCode)
        arrActualColumnArray(intCtr + 1) = "CompanyBaseCurrencyAmount"
        arrCheckBoxIDArray(intCtr + 1) = ""
        arrCheck(intCtr + 1) = ""
        arrSummary(intCtr + 1) = "SUM"


        If m_blnDeleteAccess = True Then
            'arrUserFriendlyArray(intCtr + 2) = MyBase.GetResourceString("MENU_DEL")
            'arrActualColumnArray(intCtr + 2) = MyBase.GetResourceString("MENU_DEL")
            'arrCheckBoxIDArray(intCtr + 2) = "chkDeleteItem"
            'arrCheck(intCtr + 2) = "chkDeleteItem"     
            arrUserFriendlyArray(intCtr + 3) = MyBase.GetResourceString("MENU_DEL")
            arrActualColumnArray(intCtr + 3) = MyBase.GetResourceString("MENU_DEL")
            arrCheckBoxIDArray(intCtr + 3) = "chkDeleteItem"
            arrCheck(intCtr + 3) = "chkDeleteItem"
        End If
        'End of addition
        m_objGridforItems.ActualColumnArray = arrActualColumnArray
        m_objGridforItems.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGridforItems.CheckBoxIDArray = arrCheckBoxIDArray
        m_objGridforItems.DIVID = "divItems"
        m_objGridforItems.DIVStyle = "Overflow:auto;width=100%;height=100%"
        m_objGridforItems.DIVHeight = 100

        m_objGridforItems.UseSQL = MyBase.UseSQL
        m_objGridforItems.SQL = strsql
        m_objGridforItems.PrimaryKey = "RFIItemID"
        ''Added and Commented by PrashantSJ on 28th July 2006
        ''Purpose: To Display Company (IR) Base Currency Amount
        'm_objGridforItems.NoOfDataColumns = UBound(arrRFITypeAttributes) + 2
        'cHAKSHUTA
        m_objGridforItems.NoOfDataColumns = UBound(arrRFITypeAttributes) + 3
        'If m_blnDeleteAccess = True Then
        '    m_objGridforItems.NoOfDataColumns = UBound(arrRFITypeAttributes) + 5
        'Else
        '    m_objGridforItems.NoOfDataColumns = UBound(arrRFITypeAttributes) + 4
        'End If

        'cHAKSHUTA
        ''End of addition  and Comment by PrashantSJ on 28th July 2006
        'End of integration by TruptiK
        ' m_objGridforItems.NoOfDataColumns = UBound(arrRFITypeAttributes) + 2
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
    ' Created				:	2 July 2004
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
    ' Procedure Name        :   GenerateTabSections
    ' Parameters Passed     :   None
    ' Returns               :   String
    ' Parameters Affected   :   None
    ' Purpose               :   To Plot the Client Side Tabs 
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 3, 2004
    ' Revisions             :
    '=====================================================================

    Private Function GenerateTabSections() As String
        Dim arrTabName() As String = {MyBase.GetResourceString("ITEM")}
        Dim arrTabToolTip() As String = {MyBase.GetResourceString("ITEM_TOOLTIP")}
        Dim arrTabOnClickFun() As String = {""}
        Dim objIssuesTab As WebPage.UI.cTabs
        Dim strResult As String

        objIssuesTab = New WebPage.UI.cTabs
        objIssuesTab.TabNameArray = arrTabName
        objIssuesTab.TooltipArray = arrTabToolTip
        objIssuesTab.TabOnclickFunctionArray = arrTabOnClickFun
        objIssuesTab.ReturnHTML = True
        objIssuesTab.Align = "Right"

        objIssuesTab.SelectedTab = MyBase.GetResourceString("ITEMS")
        strResult = objIssuesTab.DrawTabs()

        objIssuesTab = Nothing

        Return strResult

    End Function

    Private Function GetInvoiceNumberGenerationFormula() As String
        '=====================================================================
        ' Procedure Name		:	GetInvoiceNumberGenerationFormula
        ' Purpose				:	To retrieve the invoice generation series information.
        ' Description			:	Same as above.
        ' Parameters Passed		:	None.
        ' Parameters Affected	:	None.
        ' Returns				:	No Return values.
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	DipaliS
        ' Created				:	August 7,2004
        ' Revisions				:
        '=====================================================================

        Dim drCompanyInformation As IDataReader
        Dim strSQLQuery As String
        Dim strFormula As String
        strSQLQuery = "Exec usp_Sel_tbl_PM_CompanyInformation "
        drCompanyInformation = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drCompanyInformation.Read Then
            strFormula = Trim(CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation.Item("InvoiceNumberGenerationFormula")), String) & "")
            If strFormula.Trim <> "" Then
                m_blnFormulaExists = True
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drCompanyInformation)
        Return (strFormula.Replace(vbCrLf, ""))
    End Function
    '====================================================================
    ' Procedure Name        :   GetPageCaptionFromGlobal
    ' Parameters Passed     :   The TagID from which the page is being called
    ' Returns               :   String containing the Page Caption
    ' Parameters Affected   :   None
    ' Purpose               :   Gives Page Caption from Tag Master object
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 12, 2004
    ' Revisions             :
    '=====================================================================
    Private Function GetPageCaptionFromGlobal(ByVal TagID As Long) As String
        Dim objTag As CommonEngines.HashTables.UITagMaster
        objTag = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(TagID)
        Return objTag.TagDescription()
        objTag = Nothing
        '        obj.GetHashTableUITagMasterObject(2044)
    End Function

    '====================================================================
    ' Procedure Name        :   GetInvoiceResponsiblePerson
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To get the Responsible perosn for Invoice
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 19, 2004
    ' Revisions :
    '=====================================================================
    Private Sub GetInvoiceResponsiblePerson()
        Dim strSQL As String
        Dim drProject As IDataReader
        strSQL = "Exec usp_Sel_tbl_PM_Project " + m_objGlobal.ProjectID.ToString
        drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drProject.Read Then
            Session("InvoiceResponsiblePerson") = CType(CommonFunction.Data.CheckIsDBNull(drProject.Item("TimeSheetAuthenticatorID"), "0"), Integer)
            m_lngRespPerson = CType(CommonFunction.Data.CheckIsDBNull(drProject.Item("TimeSheetAuthenticatorID"), "0"), Long)
        Else
            Session("InvoiceResponsiblePerson") = 0
            m_lngRespPerson = 0
        End If
        CommonFunctions.Data.DisposeDataReader(drProject)
    End Sub

#End Region

#Region "Grid Events"
 'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
    'Commented by TruptiK on 24-Apr-09
    Private Sub m_objGridforItems_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGridforItems.ColumnHeaderTD_BeforePrint
        'If Args.ColumnName.Trim.ToUpper = "DELETE" Then
        '    Dim strSQLQuery As String
        '    Dim drdetails As IDataReader
        '    'Integrated by TruptiK on 8-Apr-09
        '    'Code Added by RajkumarM on 30th April 2007 to disable delete for Positive line items if there 
        '    'is any negative line item present.
        '    strSQLQuery = "EXEC usp_sel_tbl_PM_RFI_Items_RFIItemID " & m_intRFIID
        '    drdetails = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        '    Do While drdetails.Read
        '        blnNegativeEntry = True
        '    Loop
        '    CommonFunctions.Data.DisposeDataReader(drdetails)
            'End of Code Addition by RajkumarM on 30th April 2007 to disable delete for Positive line items if there 
            'End of Integrated by TruptiK
            'is any negative line item present.
        'End If
        'End of commented  by TruptiK
    End Sub
    'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
    Private Sub m_objGridforItems_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridforItems.DataRowTD_BeforePrint
        'Draw the hyperlink for Edit Item
        Dim strRFIID As Double
        Dim strEmployee As String
        ''Commented By Usha Pandit On 08.08.019 For EmployeeName field not exists, so giving page crash EmployeeName not exists
        'strEmployee = CType(Args.DataReader.Item("EmployeeName"), String)
        ''End Of Commented By Usha Pandit On 08.08.019 For EmployeeName field not exists, so giving page crash EmployeeName not exists
        If Args.DataField.ToUpper = "ITEMDESCRIPTION" Then

            If m_blnEditAccess = True Then
                Cancel = True
                Dim strToBeInserted As String
                'Added by NageshM on Date 15th Nov 2005
                'Dim strRFIID As Double
                Dim milestoneID As Integer
                strRFIID = CType(Args.DataReader.Item("RFIItemID"), Double)
                ' milestoneID = CType(Args.DataReader.Item("CustomField4"), Integer)
                If strRFIID = 0 Then
                    milestoneID = CType(Args.DataReader.Item("MilestoneID"), Integer)
                    strToBeInserted = "<td>" + _
                            "<A href='javascript:EditItemForMilestone_OnClick(" + CType(Args.DataReader.Item("RFIItemID"), String) + "," + CType(Args.DataReader.Item("MilestoneID"), String) + ")'>" + _
                            CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item(Args.DataField), ""), String) + _
                            "</A></td>"
                    Args.StringToBeInserted = strToBeInserted
                Else
                    'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                    m_strItemToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("RFIItemID"), String) + CType(Args.DataReader.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
                    'End of addition by MonikaI
                    'End of Addition By NageshM

                    'Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)

                    'strToBeInserted = "<td>" + _
                    '"<A href='javascript:EditItem_OnClick(" + CType(Args.DataReader.Item("RFIItemID"), String) + ")'>" + _
                    'CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item(Args.DataField), ""), String) + _
                    '"</A></td>"

                    'Added And Commented By Vidya J

                    ' strToBeInserted = "<td>" + _
                    ' "<A href=" + "javascript:EditItem_OnClick('" + m_strItemToken + "'," + CType(Args.DataReader.Item("RFIItemID"), String) + ")>" + _
                    'CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item(Args.DataField), ""), String) + _
                    ' "</A></td>"
                    strToBeInserted = "<td>" + _
                    "<A href=" + "javascript:EditItem_OnClick('" + m_strItemToken + "'," + CType(Args.DataReader.Item("RFIItemID"), String) + ")>" + _
                   Server.HtmlEncode(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item(Args.DataField), ""), String)) + _
                    "</A></td>"
                    'End of Added And Commented By Vidya J
                    'End by MonikaI
                    Args.StringToBeInserted = strToBeInserted
                End If
            End If
 'Added by TruptiK on 24-Apr-09
            ''Purpose:-Invoice discount
            'strtotalamount = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item(Args.DataField), ""), String)
            'If strtotalamount = MyBase.GetResourceString("TOTALAMOUNT") Then
            '    flag = 1
            'End If
            'End of addition by TruptiK on 24-Apr-09
            'Added by TruptiK on 24-Apr-09
            'Purpose:-Invoice discount
            Dim RFIAmount As Double
            Dim strsql As String = "select sum(amount) from tbl_PM_RFI_Items WHERE rfiid=" + m_intRFIID.ToString
            strtotalamount = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, MyBase.UseSQL), "0"), Double)
            'Commented And Added By  Usha Pandit On 19.07.2019 For crash if Amount is blank
            'RFIAmount = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Amount"), ""), Double)
            RFIAmount = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Amount"), "0"), Double)
            'End Of Added By  Usha Pandit On 19.07.2019 For crash if Amount is blank
            'strtotalamount = strtotalamount + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Amount"), ""), Double)
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("hid_txttotalAmount", "hid_txttotalAmount", , , , strtotalamount.ToString, , , , , , IsHidden:=True, EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("hid_txtRFIAmount_" + strRFIID.ToString, "hid_txtRFIAmount_" + strRFIID.ToString, , , , RFIAmount.ToString, , , , , , IsHidden:=True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            'End of addition by TruptiK on 24-Apr-09
        End If
        'End If
        'Code Integrated by TruptiK on 8-Apr-09
        'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
        '''' Added by RajkumarM on 30th Apr 2007
        If Args.ColumnName.Trim.ToUpper = "DELETE" Then
            Dim strToBeInserted As String
            If ((blnNegativeEntry = True) And CType(Args.DataReader.Item("Rate"), Double) > 0) Then
                Cancel = True
                strToBeInserted = "<TD align =center ><Input type=checkbox disabled=true></TD>"
                Args.StringToBeInserted = strToBeInserted
            End If
        End If
        '''' End of addition By RajkumarM on Date 30th Apr 2007
        'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
        'End of Integrated by TruptiK

        '        'Args.DataFieldValue.
        '    End If
        'End If
        '''' End of addition By NageshM on Date 15th nov 2005
    End Sub
    Private Sub m_objGridforItems_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objGridforItems.SummaryFunctionsTD_BeforePrint
        If Args.ColIndex <= UBound(arrRFITypeAttributes) Then
            If arrRFITypeAttributes(Args.ColIndex, 0).ToUpper = "ITEMDESCRIPTION" Then
                Cancel = True
                Args.StringToBeInserted = "<td>" + MyBase.GetResourceString("TOTALAMOUNT") + "</td>"
            End If
        End If
    End Sub
#End Region



   
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
       
        m_strToken = ""
        If HttpContext.Current.Request.QueryString("Mode") = "New" Then
            If Request.Form("txtHiddenToken") Is Nothing Then
                m_strToken = Request.QueryString("PKToken") & ""
            Else
                m_strToken = Request.Form("txtHiddenToken") & ""
            End If
        Else
            If Not HttpContext.Current.Request.QueryString("NewPKToken") Is Nothing Then
                m_strToken = Request.QueryString("NewPKToken") & ""
            Else
                If HttpContext.Current.Request.QueryString("PKToken") Is Nothing Then
                    m_strToken = Request.Form("txtHiddenToken") & ""
                Else
                    m_strToken = Request.QueryString("PKToken") & ""
                End If
            End If
        End If

        'Modified By JyotiG
        'Start
        'Issue ID : 6197
        'Date :20-Sep-2006
        'Get the User Type
        If Trim(Request.Form("txtUserType")) <> "" Then
            m_strUserType = Trim(Request.Form("txtUserType"))
        ElseIf Trim(Request.QueryString("UserType")) <> "" Then
            m_strUserType = Trim(Request.QueryString("UserType"))
        End If
        'End
        If HttpContext.Current.Request.QueryString("Flag") <> "Timesheet" Then
            If HttpContext.Current.Request.QueryString("Mode") = "Edit" Then
                'Modified By JyotiG
                'Start
                'Issue ID : 6197
                'Date :20-Sep-2006
                If m_strUserType = "Initiator" Then
                    'End
                    If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                    'Start(JyotiG) Issue ID :6197
                End If
                'End(JyotiG)
                'Modified By JyotiG
                'Start
                'Issue ID : 6197
                'Date :20-Sep-2006
                If m_strUserType = "Approver" Then
                    Dim strPrjId As String
                    Dim strSql As String
                    If Not IsNothing(Request.QueryString("RFIID")) Then
                        m_intRFIID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RFIID")), Integer)
                    End If
                    ''Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                    'strSql = "Select ProjectID from tbl_PM_RFIs where RFIID=" & m_intRFIID
                    strSql = "usp_sel_tbl_PM_RFIs_ProjectID " & m_intRFIID
                    'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                    strPrjId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL), "0"), String)
                    'strPrjId = CType(HttpContext.Current.Session("intProjectID"), String)
                    If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2074, String) + CType(0, String) + CType(strPrjId, String), m_strToken) = False Then
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                End If
                If m_strUserType = "Accounts" Then
                    Dim strPrjId As String
                    Dim strSql As String
                    If Not IsNothing(Request.QueryString("RFIID")) Then
                        m_intRFIID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RFIID")), Integer)
                    End If

                    ''Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                    'strSql = "Select ProjectID from tbl_PM_RFIs where RFIID=" & m_intRFIID
                    strSql = "usp_sel_tbl_PM_RFIs_ProjectID " & m_intRFIID
                    'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                    strPrjId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL), "0"), String)
                    'strPrjId = CType(HttpContext.Current.Session("intProjectID"), String)
                    If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2083, String) + CType(0, String) + CType(strPrjId, String), m_strToken) = False Then
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                End If
                'End
            End If
        End If
        'End of addition by MonikaI
    End Sub

    Private Sub frmRFI_RFI_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles frmRFI_RFI.Load

    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles objMenu.Before_Link_Print
        If m_blnIsProjectOver = True Or m_objAccessRights.Edit = False Then
            Select Case Args.LinkName.ToUpper
                Case "SAVE", "SUBMIT IR", "RE-SUBMIT IR", "PROJECT MILESTONES", "PROJECT DELIVERABLES", "PROJECT EXPENSES", "PROJECT TIMESHEETS", "PROJECT FIXED FEE", "ADD NEW", "DELETE"
                    Cancel = True
            End Select
        End If

    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objAccessRights = Nothing
    End Sub
End Class
