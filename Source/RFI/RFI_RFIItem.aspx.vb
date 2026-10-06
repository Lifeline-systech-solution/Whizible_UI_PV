'=====================================================================
' Module Name   :       RFI_RFIItem
' Purpose       :       The Page for Configuring RFI Item Attributes
' Description   :       Same as above
' Dependencies  :       None
' Author        :       DipaliS
' Created       :       July 30 , 2004
' Revisions     :
'=====================================================================
Public Class RFI_RFIItem
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
    'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
    Protected m_strToken As String
    'End of addition by MonikaI
    Protected m_strMode As String
    Private m_strAction As String
    Protected m_strPageTitle As String
    Protected m_intRFIItemID As Integer
    Protected m_intRFIID As Integer
    Protected m_intRFITypeID As Integer
    Protected m_strBaseCurrencyCode As String
    Protected m_strLocalCurrencyCode As String
    Protected m_strBillingCurrencyCode As String
    'Integrated by TruptiK on 24-Apr-2007
    'Added by PrashantSJ on 17th July 2006 For Bristlecon
    'Purpose:  To Store the Company Currency related information in IR items  table
    Protected m_strCompanyBaseCurrencyCode As String
    'End of addition by PrashantSJ on 17th July 2006 For Bristlecon
    'End of integration by TruptiK
    Protected m_dblStandard_BillingToBaseConversionRate As Double
    Protected m_dblStandard_LocalToBaseConversionRate As Double
    'Purpose:  To Store the Company Currency related information in IR items  table
    Protected m_dblstandared_CompanyBaseConversionRate As Double
    'End of addition by PrashantSJ on 17th July 2006 For Bristlecon
    Private arrRFITypeAttributes(,) As String
    Private m_strItemDescription As String = ""
    Private m_dblQuantity As Double
    Private m_dblRate As Double
    Protected m_dblAmount As Double
    Private m_dblCustomField1 As Double
    Private m_dblCustomField2 As Double
    Private m_dblCustomField3 As Double
    Private m_strCustomField4 As String = ""
    Private m_intOrderNumber As Integer
    Protected m_dblBaseCurrencyAmount As Double
    Protected m_dblLocalCurrencyAmount As Double
    Protected m_dblBillingToBaseConversionRate As Double
    Protected m_dblLocalToBaseConversionRate As Double
    'Integrated by TruptiK on 24-Apr-2007
    'Added by PrashantSJ on 17th July 2006 For Bristlecon
    'Purpose:  To Store the Company Currency related information in IR items  table
    Protected m_dblCompanyBaseCurrencyAmount As Double
    Protected m_dblCompanyBaseConversionRate As Double
    Protected WithEvents objMenu As WebPages.Template.StaticMenu
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_blnIsProjectOver As Boolean
    'End of addition by PrashantSJ on 17th July 2006 For Bristlecon
    'End of integration by TruptiK on 24-Apr-2007
    Private m_intProjectID As Integer
    Private strValidation As String
    'Integrated by SavitaS on 16 Mar 2006 for IssueID-2836
    'Added By GaneshG on 7 Mar 06
    Protected m_dblBalanceBillAmount As Double
    Private m_strItem As String
    Private m_strtoken1 As String
    'End Addition
    'End Integration
    'Integrated by TruptiK on 8-Apr-09
    'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
    '''Code added by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
    Private m_IsDiscount As Boolean = False
    Protected m_fltTotalAmount As String
    Private m_blnDiscountSelected As Boolean = False
    Protected m_intTimesheetID As Integer
    '''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
    'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
    'End of integration by TruptiK
#End Region

#Region "Constants "
    Private Const intTagID As Integer = 825
#End Region

#Region "Member Functions"
    Public Sub PageInit()
        '######### Page Code starts here
        GetGlobalObject()
        GetTagAccessRights()

        m_intProjectID = CType(Session("intProjectID"), Integer)
        ' Get the current mode (NEW/EDIT).
        If Trim(Request.QueryString("Mode")) <> "" Then
            m_strMode = Trim(Request.QueryString("Mode"))
        Else
            m_strMode = "New"
        End If

        ' Get the action to be performed (VIEW/SAVE).
        If Trim(Request.QueryString("Action")) <> "" Then
            m_strAction = Trim(Request.QueryString("Action"))
        Else
            m_strAction = "View"
        End If

        ' Get the page title.
        m_strPageTitle = MyBase.GetResourceString("WINDOW_TITLE")

        ' If the page is not visited for the first time, then get the previous settings.
        If Request.Form("txtUseFormContents") <> "" Then

            ' Get the RFI Item ID.
            m_intRFIItemID = CType(Request.Form("txtRFIItemID"), Integer)

            m_intRFIID = CType(Request.Form("txtRFIID"), Integer)
            m_intRFITypeID = CType(Request.Form("txtRFITypeID"), Integer)

            ' Get the currency information.		
            m_strBaseCurrencyCode = Request.Form("txtBaseCurrencyCode")
            'Commented by TruptiK on 23-Jun-2007
            ' m_strLocalCurrencyCode = Request.Form("txtLocalCurrencyCode")
            'End by Trupti
            m_strBillingCurrencyCode = Request.Form("txtBillingCurrencyCode")
            m_dblStandard_BillingToBaseConversionRate = CType(Request.Form("txtStandard_BillingToBaseConversionRate"), Double)
            m_dblStandard_LocalToBaseConversionRate = CType(Request.Form("txtStandard_LocalToBaseConversionRate"), Double)
            'Integrated by TruptiK on 24-Apr-2007
            'Added by PrashantSJ on 18th July 2006 For Bristlecon
            'Purpose:  To Store the Company Currency related information in IR items  table
            m_strCompanyBaseCurrencyCode = Request.Form("txtCompanyBaseCurrencyCode")
            m_dblstandared_CompanyBaseConversionRate = CType(Request.Form("txtStandard_CompanyBaseConversionRate"), Double)
            ' If the page is visited for the first time, then...		
        Else
            Dim drDetails As IDataReader
            Dim strSQLQuery As String
            ' Get the base currency information.	
            strSQLQuery = "Exec usp_InvoiceDB_GetBaseCurrencyInfo"
            drDetails = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drDetails.Read Then
                If Trim(CType(drDetails.Item("CurrencyCode"), String) & "") <> "" Then
                    m_strBaseCurrencyCode = Trim(CType(drDetails.Item("CurrencyCode"), String) & "")
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drDetails)
            'Integrated by TruptiK on 24-Apr-207
            'Added by PrashantSJ on 18th July 2006 For Bristlecon
            'Purpose:  To Store the Company Currency related information in IR items  table
            'strSQLQuery = " usp_Sel_tbl_PM_CurrencyMaster_GetCompanyBaseCurrency NULL," & m_intRFIID.ToString
            'm_strCompanyBaseCurrencyCode = CType(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), ""), String) & ""

            'End of addition by PrashantSJ on 18th July 2006 For Bristlecon
            'End of integration by TruptiK
            ' Get the local currency information.	
            'Commented by TruptiK on 23-Jun-2007
            'strSQLQuery = "Exec usp_Sel_tbl_PM_CurrencyMaster_GetLocalCurrency"
            'drDetails = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            'If drDetails.Read Then
            '    If Trim(CType(drDetails.Item("CurrencyCode"), String) & "") <> "" Then
            '        m_strLocalCurrencyCode = Trim(CType(drDetails.Item("CurrencyCode"), String) & "")
            '    End If
            'End If
            'CommonFunctions.Data.DisposeDataReader(drDetails)
            'end by Trupti

            m_intRFIID = CType(Request.QueryString("RFIID"), Integer)
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFIs " & m_intRFIID
            drDetails = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drDetails.Read Then
                m_intRFITypeID = CType(drDetails.Item("RFITypeID"), Integer)
                m_strBillingCurrencyCode = Trim(CType(drDetails.Item("BillingCurrencyCode"), String) & "")
                m_dblStandard_BillingToBaseConversionRate = CType(drDetails.Item("BillingToBaseConversionRate"), Double)
                m_dblStandard_LocalToBaseConversionRate = CType(drDetails.Item("LocalToBaseConversionRate"), Double)
                'Integrated by TruptiK on 24-Apr-2007
                'Added by PrashantSJ on 18th July 2006 For Bristlecon
                'Purpose:  To Store the Company Currency related information in IR items  table
                m_dblstandared_CompanyBaseConversionRate = CType(CommonFunction.Data.CheckIsDBNull(drDetails.Item("CompanyBaseCurrencyConversionRate"), "0"), Double)
                m_strCompanyBaseCurrencyCode = Trim(CType(drDetails.Item("CompanyBaseCurrencyCode"), String) & "")
                'End of addition by PrashantSJ on 18th July 2006 For Bristlecon
                'End of integration by TruptiK
            End If
            CommonFunctions.Data.DisposeDataReader(drDetails)

            ' Get the RFI Item ID.
            m_intRFIItemID = CType(Request.QueryString("RFIItemID"), Integer)

        End If


        ' Get the attributes related to the current RFI Type.
        Call GetRFITypeAttributes(m_intRFITypeID)


        'Integrated by TruptiK on 8-Apr-09
        'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
        '''Code Commented and added by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
        'm_blnDiscountSelected = CType(CommonFunctions.Data.GetDataScalar("Usp_Sel_PiTech_IR_DiscountSelected " & m_intRFITypeID, MyBase.UseSQL), Boolean)
        '''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
        'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
        'End of integration by TruptiK

        If m_strAction = "Save" Then

            ' Build Query to insert/update the RFI Item record.
            Dim strSQLQuery As String
            strSQLQuery = "Exec usp_Ins_tbl_PM_RFI_Items "

            ' For "Edit" mode pass the RFIItemID. For "New" mode pass NULL.
            If m_intRFIItemID <> 0 Then
                strSQLQuery = strSQLQuery & m_intRFIItemID
            Else
                strSQLQuery = strSQLQuery & "NULL"
            End If

            ' RFI ID.
            strSQLQuery = strSQLQuery & ", " & m_intRFIID

            ' Item Description.
            If Trim(Request.Form("txtItemDescription")) <> "" Then
                strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Left(Trim(Request.Form("txtItemDescription")), 2000)) & "'"
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Quantity.
            If Trim(Request.Form("txtQuantity")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & FormatNumber(Request.Form("txtQuantity"), , , , TriState.False)
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Rate.
            If Trim(Request.Form("txtRate")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & FormatNumber(Request.Form("txtRate"), , , , TriState.False)
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Custom Field 1.
            If Trim(Request.Form("txtCustomField1")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & FormatNumber(Request.Form("txtCustomField1"), , , , TriState.False)
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Custom Field 2.
            If Trim(Request.Form("txtCustomField2")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & FormatNumber(Request.Form("txtCustomField2"), , , , TriState.False)
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Custom Field 3.
            If Trim(Request.Form("txtCustomField3")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & FormatNumber(Request.Form("txtCustomField3"), , , , TriState.False)
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Custom Field 4.
            If Trim(Request.Form("txtCustomField4")) <> "" Then
                strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Left(Trim(Request.Form("txtCustomField4")), 500)) & "'"
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Order Number.
            If Trim(Request.Form("txtOrderNumber")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & Request.Form("txtOrderNumber")
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Base Currency Amount.
            If Trim(Request.Form("txtBaseCurrencyAmount")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & FormatNumber(Request.Form("txtBaseCurrencyAmount"), , , , TriState.False)
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Local Currency Amount.
            'If Trim(Request.Form("txtLocalCurrencyAmount")) <> "" Then
            'strSQLQuery = strSQLQuery & ", " & FormatNumber(Request.Form("txtLocalCurrencyAmount"), , , , TriState.False)
            'Else
            strSQLQuery = strSQLQuery & ", 0"
            'End If

            ' Billing To Base Conversion Rate.
            If Trim(Request.Form("txtBillingToBaseConversionRate")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & Request.Form("txtBillingToBaseConversionRate")
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Local To Base Conversion Rate.
            'If Trim(Request.Form("txtLocalToBaseConversionRate")) <> "" Then

            'strSQLQuery = strSQLQuery & ", " & Request.Form("txtLocalToBaseConversionRate")
            'Else
            strSQLQuery = strSQLQuery & ", 0"
            ' End If
            'Integrated by TruptiK 25-Apr-2007
            'Added by PrashantSJ on 18th July 2006 For Bristlecon
            'Purpose:  To Store the Company Currency related information in IR items  table
            ' Company Base Currency Amount.
            If Trim(Request.Form("txtCompanyBaseCurrencyAmount")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & FormatNumber(Request.Form("txtCompanyBaseCurrencyAmount"), , , , TriState.False)
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If

            ' Company Base Currency Conversion Rate.
            If Trim(Request.Form("txtCompanyBaseConversionRate")) <> "" Then
                strSQLQuery = strSQLQuery & ", " & Request.Form("txtCompanyBaseConversionRate")
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If
            'End of integration by TruptiK
            'End of addition by PrashantSJ on 18th July 2006 For Bristlecon
            ' Created By (for audit trail).				
            strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Trim(CType(Session("strUserName"), String))) & "'"
            'Code Integrated by TruptiK on 8-Apr-09
            'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
            '''Code added by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
            strSQLQuery = strSQLQuery & "," & CommonFunctions.General.CheckIsNothing(Request.Form("chkIsDiscount"), "0")
            '''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 

            'End of Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
            'End of integration by TruptiK
            ' Save record.
            CommonFunctions.Data.InsertOrUpdateData(strsqlquery, MyBase.UseSQL)

            Dim strScript As String
            strScript = "<script>" + vbCrLf
            strScript += "var objtxtChecklistInstanceID=GetParentObjectReference('frmRFI_RFI','txtChecklistInstanceID');" + vbCrLf
            strScript += "var objCustomer=GetParentObjectReference('frmRFI_RFI','cboCustomerID');" + vbCrLf
            strScript += "var objRFIType=GetParentObjectReference('frmRFI_RFI','cboRFITypeID');" + vbCrLf
            strScript += "var objBilling=GetParentObjectReference('frmRFI_RFI','cboBillingCurrencyID');" + vbCrLf
            strScript += "var objParent=GetParentFormReference('frmRFI_RFI');" + vbCrLf
            strScript += "objCustomer.disabled = false;" + vbCrLf
            strScript += "objRFIType.disabled = false;" + vbCrLf
            strScript += "objBilling.disabled = false;" + vbCrLf
            'If action is copy, then append new RFI ID
            strScript += "if(objParent.action.indexOf(""Action=Copy"")!=-1)" + vbCrLf
            'Commented and modified by TruptiK on 8-May-2007
            'strScript += "objParent.action=replaceSubstring(replaceSubstring(replaceSubstring(replaceSubstring(objParent.action, ""&Action=Save&"", ""&""),""Mode=New"",""Mode=Edit""), ""&Action=Copy&"", ""&""), ""RFIID="", """")+" + """&RFIID=" + m_intRFIID.ToString + """;" + vbCrLf
            strScript += "objParent.action=replaceSubstring(replaceSubstring(replaceSubstring(replaceSubstring(replaceSubstring(objParent.action, ""&Action=Save&"", ""&""),""Mode=New"",""Mode=Edit""), ""&Action=Copy&"", ""&""),""RFIID="", """"),""PKToken="","""")+ " + """&PKToken=" + m_strtoken1 + """+" + """&RFIID=" + m_intRFIID.ToString + """;" + vbCrLf
            'strScript += "objParent.action=replaceSubstring(replaceSubstring(replaceSubstring(replaceSubstring(replaceSubstring(replaceSubstring(objParent.action,""&Action=FixedFee&"",""&""), ""&Action=Save&"", ""&""),""Mode=New"",""Mode=Edit""), ""&Action=Copy&"", ""&""),""RFIID="", """"),""PKToken="","""")+ " + """&PKToken=" + m_strtoken1 + """+" + """&RFIID=" + m_intRFIID.ToString + """;" + vbCrLf

            'End of modification by TruptiK on 8-May-2007
            strScript += "else" + vbCrLf
            strScript += "objParent.action=replaceSubstring(replaceSubstring(replaceSubstring(objParent.action, ""&Action=Save&"", ""&""), ""&Action=Copy&"", ""&""), ""&RFIID=0&"", ""&RFIID=" + m_intRFIID.ToString + "&"");" + vbCrLf
            strScript += "objParent.action=replaceSubstring(objParent.action,""&Action=FixedFee&"",""&"");"
            strScript += "objParent.submit();" + vbCrLf

            If m_intRFIItemID <> 0 Then
                strScript += "window.close();" + vbCrLf
            End If

            strScript += "</script>" + vbCrLf
            Response.Write(strScript)


            m_strMode = "New"
            m_intRFIItemID = 0
        End If

        Dim m_sSQL As String
        Dim drRFI As IDataReader
        m_sSQL = "usp_sel_tbl_PM_Project_TaskCaseStructure " & m_intProjectID
        drRFI = CommonFunction.Data.GetDataReader(m_sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drRFI.Read() Then
            m_blnIsProjectOver = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRFI("Over"), "0"), "0"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(drRFI)

        PlotUI()

    End Sub

    '=====================================================================
    ' Procedure Name		:	GetRFITypeAttributes
    ' Purpose				:	To get the attributes related to the specified RFI Type.
    ' Description			:	Same as above.
    ' Parameters Passed		:	intRFITypeID		:- The RFI Type ID.	
    ' Parameters Affected	:	None.
    ' Returns				:	No return values.
    ' Assumptions			:	None.
    ' Dependencies			:	None.
    ' Author				:	DipaliS
    ' Created				:	30 July 2004
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
    ' Procedure Name        :   PlotUI
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To Plot the UI for RFI Items
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 30, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub PlotUI()
        PlotHiddenControls()
        ' RETRIEVE THE DETAILS OF THE RFI ITEM.
        '--------------------------------------							
        If m_intRFIItemID <> 0 Then
            Dim strSQLQuery As String
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFI_Items " & m_intRFIItemID
            Dim drDetails As IDataReader
            drDetails = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drDetails.Read Then
                m_strItemDescription = Trim(CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("ItemDescription")), String) & "")
                m_dblQuantity = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("Quantity"), "0"), Double)
                m_dblRate = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("Rate"), "0"), Double)
                m_dblAmount = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("Amount"), "0"), Double)
                m_dblCustomField1 = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("CustomField1"), "0"), Double)
                m_dblCustomField2 = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("CustomField2"), "0"), Double)
                m_dblCustomField3 = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("CustomField3"), "0"), Double)
                m_strCustomField4 = Trim(CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("CustomField4"), ""), String) & "")
                m_intOrderNumber = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("OrderNumber"), "0"), Integer)
                m_dblBaseCurrencyAmount = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("BaseCurrencyAmount"), "0"), Double)
                'commented by TruptiK on 23-Jun-2007
                'm_dblLocalCurrencyAmount = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("LocalCurrencyAmount"), "0"), Double)
                'Integrated by TruptiK on 25-Apr-2007
                'Added by PrashantSJ on 18th July 2006 For Bristlecon
                'Purpose:  To Store the Company Currency related information in IR items  table
                m_dblCompanyBaseCurrencyAmount = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("CompanyBaseCurrencyAmount"), "0"), Double)
                m_dblCompanyBaseConversionRate = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("CompanyBaseCurrencyConversionRate"), "0"), Double)
                'End of addition by PrashantSJ on 18th July 2006 For Bristlecon
                'End of integration by TruptiK
                m_dblBillingToBaseConversionRate = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("BillingToBaseConversionRate"), "0"), Double)
                'm_dblLocalToBaseConversionRate = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("LocalToBaseConversionRate"), "0"), Double)
                'Integrated by SavitaS on 16 Mar 2006 for IssueID-2836
                'Code Integrated by TruptiK on 8-Apr-09
                'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
                '''Code added by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
                m_IsDiscount = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("IsDiscountItem"), "0"), Boolean)
                m_intTimesheetID = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("ProjectTimesheetID"), "0"), Integer)
                '''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
                'End of Code addition by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
                'End of integration by TruptiK
                'Added by GaneshG on 7 Mar 06
                If Not IsDBNull(drDetails.Item("MilestoneID")) Then
                    m_strItem = "MILESTONE"
                ElseIf Not IsDBNull(drDetails.Item("DeliverableID")) Then
                    m_strItem = "DELIVERABLE"
                Else
                    m_strItem = ""
                End If
                'End Addition by GaneshG
                'End Integration by SavitaS

            End If
            CommonFunctions.Data.DisposeDataReader(drDetails)
            ' The Default values (in case of new RFI).
            'Integrated by SavitaS on 16 Mar 2006 for IssueID-2836
            'Added by GaneshG on 7 Mar 06
            If CommonFunction.General.CheckIsNothing(m_strItem, "") <> "" Then
                strSQLQuery = "Exec usp_Sel_BalanceBillAmount_of_RFIItem " & m_intRFIItemID
                drDetails = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDetails.Read Then
                    m_dblBalanceBillAmount = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("BalanceBillAmount"), "0"), Double)
                End If
            End If

            CommonFunctions.Data.DisposeDataReader(drDetails)
            'End Addition By GaneshG
            'End Integration by SavitaS

        Else

            m_dblAmount = 0

            m_intOrderNumber = 0
            Dim strSQLQuery As String
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFI_Items_GetNextOrderNumber " & m_intRFIID
            m_intOrderNumber = CType(CommonFunctions.Data.GetDataScalar(strsqlquery, MyBase.UseSQL), Integer)


            m_dblBillingToBaseConversionRate = m_dblStandard_BillingToBaseConversionRate
            m_dblLocalToBaseConversionRate = m_dblStandard_LocalToBaseConversionRate
            'Integrated by TruptiK on 25-Apr-2007
            'Added by PrashantSJ on 18th July 2006 For Bristlecon
            'Purpose:  To Store the Company Currency related information in IR items  table
            m_dblCompanyBaseConversionRate = m_dblstandared_CompanyBaseConversionRate
            'End of addition by PrashantSJ on 18th July 2006 For Bristlecon
            'End of integration by TruptiK
        End If

        GetMenu()

        'Legend
        Dim objLegend As WebPages.Template.PageLegends
        objLegend = New WebPages.Template.PageLegends
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        objLegend.DrawPageLegends(Nothing, arrLegendImage, arrLegend)
        objLegend = Nothing

        'Caption
        WebPages.Template.PageCaption.GetPageCaptions(Nothing, m_strPageTitle)

        'Page Div
        Response.Write("<div id=PageDiv Style=""OVERFLOW: Auto; WIDTH:100%;HEIGHT:100%"">")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<table cellspacing=0 class=clsTable width=99.9%><COL width=30%><COL width=70%>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Dim strHTML As String
        Dim intCounter As Integer
        Dim strFieldName As String
        Dim strUserFriendlyCaption As String
        Dim blnIsMandatory As Boolean
        Dim strSPName As String
        Dim intControlTypeID As Integer
        Dim strValidationScript As String
        For intCounter = 0 To UBound(arrRFITypeAttributes)
            strFieldName = arrRFITypeAttributes(intCounter, 0)
            strUserFriendlyCaption = arrRFITypeAttributes(intCounter, 1)
            blnIsMandatory = CType(CommonFunctions.General.CheckIsNothing(arrRFITypeAttributes(intCounter, 2), "false"), Boolean)
            strSPName = arrRFITypeAttributes(intCounter, 4)
            intControlTypeID = CType(CommonFunctions.General.CheckIsNothing(arrRFITypeAttributes(intCounter, 3), "0"), Integer)
            ' If Stored Procedure is used for populating any of the controls, then hanldle the place holders that may appear in the SP.
            strSPName = Replace(strSPName & "", "<PROJECT_ID>", m_intProjectID.ToString)
            strHTML += "<tr class=clsTREven><td valign=top align=right>"
            strHTML += strUserFriendlyCaption
            If strFieldName = "Rate" Or strFieldName = "Amount" Then strHTML += "(" + m_strBillingCurrencyCode + ")"
            strHTML += "</td><td valign=top >"
            If blnIsMandatory = True And strFieldName <> "Amount" Then
                strValidation += "if (disallowBlank(objtxt" + strFieldName + ",""" + MyBase.GetResourceString("MSG_BLANK").Replace("<name>", strUserFriendlyCaption) + """,true))" + vbCrLf
                strValidation += "	return  false;	" + vbCrLf
            End If
            Select Case strFieldName
                Case "ItemDescription"
                    ' Validation - Max length.
                    strValidation += "if (disallowMaxlengthViolation(objtxtItemDescription,2000,""" + MyBase.GetResourceString("MSG_DESC_MAX").Replace("<name>", strUserFriendlyCaption) + """,true))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf
                    'Modified By ShraddhaM on 27 July 2006
                    'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    'strHTML += CommonFunctions.HTMLControls.DrawTextArea("txtItemDescription", "txtItemDescription", , , , , , , , 50, , m_strItemDescription, , "width=90%", , , , , , True, blnIsMandatory, , , , , , "soft", )
                    strHTML += CommonFunctions.HTMLControls.DrawTextArea("txtItemDescription", "txtItemDescription", , , , , , , , 50, , m_strItemDescription, , "width=90%", , , , , , True, blnIsMandatory, , , , , , "soft", EnableHTMLEncode:=True)
                    'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    'Code Integrated by TruptiK on 8-Apr-09
                    'Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
                    '''Code added by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
                Case "IsDiscountItem"
                    'If m_intTimesheetID > 0 Then
                    '    strHTML += CommonFunctions.HTMLControls.DrawCheckBox("chkIsDisCount", "chkIsDisCount", , m_IsDiscount, "1", True, , True)
                    'Else
                    strHTML += CommonFunctions.HTMLControls.DrawCheckBox("chkIsDisCount", "chkIsDisCount", , m_IsDiscount, "1", , , True)
                    'End If
                    '''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
                    'End of Code addition by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
                    'End of integration by TruptiK

                Case "Quantity"
                    strValidation += "if (disallowNegativeNumeric(objtxtQuantity,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption) + """,true))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf
                    strValidation += "if (disallowMinValueViolation(objtxtQuantity,0,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption) + """,true,false))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf
                    'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtQuantity", "txtQuantity", , 100, 7, m_dblQuantity.ToString, "right", , , , , , "onchange=""Javascript:txtQuantity_OnChange()""", True, blnIsMandatory, EnableHTMLEncode:=True)
                    'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                Case "Rate"
                    ''Code Commented and added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
                    'strValidation += "if (disallowNegativeNumeric(objtxtRate,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption) + """,true))" + vbCrLf
                    'strValidation += "	return  false;	" + vbCrLf
                    'strValidation += "if (disallowMinValueViolation(objtxtRate,0,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption) + """,true,false))" + vbCrLf
                    'strValidation += "	return  false;	" + vbCrLf
                    'If CommonFunction.General.CheckIsNothing(m_strItem, "") <> "" Then
                    '    strValidation += "if(objtxtRate.value > dblBalanceBillAmount)" + vbCrLf
                    '    strValidation += "{ alert('Please enter the rate equal to or less than Balance Amount:" & m_dblBalanceBillAmount & "');" + vbCrLf
                    '    strValidation += "	objtxtRate.focus(); return  false};	" + vbCrLf
                    'End If
                    'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRate", "txtRate", , 100, 12, m_dblRate.ToString, "right", , , , , , "onchange=""Javascript:txtRate_OnChange()""", True, blnIsMandatory)
                    'strHTML += "(Billing Currency)</td></tr>"
                    'Code Integrated by TruptiK on 8-Apr-09
                    '''Code added by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
                    strValidation += "var ObjCheckDiscount = GetObjectReference('frmRFI_RFIItem','chkIsDisCount');" + vbCrLf
                    strValidation += "if (ObjCheckDiscount){" + vbCrLf
                    strValidation += "if (ObjCheckDiscount.checked == true){ " + vbCrLf
                    strValidation += "if ((parseFloat(objtxtRate.value) - 0) >= 0){" + vbCrLf
                    strValidation += "alert('Please enter a negative numeric value for " + strUserFriendlyCaption + ".');" + vbCrLf
                    'strValidation += "objtxtRate.value="""";" + vbCrLf
                    strValidation += "objtxtRate.focus();" + vbCrLf
                    strValidation += "return false;" + vbCrLf
                    strValidation += "}}" + vbCrLf
                    strValidation += "else {" + vbCrLf
                    '''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
                    'End of integration by TruptiK
                    strValidation += "if (disallowNegativeNumeric(objtxtRate,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption) + """,true))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf
                    strValidation += "if (disallowMinValueViolation(objtxtRate,0,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption) + """,true,false))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf
                    'Integrated by SavitaS on 16 Mar 2006 for IssueID-2836
                    'Added by GaneshG on 7 Mar 06
                    If CommonFunction.General.CheckIsNothing(m_strItem, "") <> "" Then
                        strValidation += "if(objtxtRate.value > dblBalanceBillAmount)" + vbCrLf
                        strValidation += "{ alert('Please enter the rate equal to or less than Balance Amount:" & m_dblBalanceBillAmount & "');" + vbCrLf
                        strValidation += "	objtxtRate.focus(); return  false};	" + vbCrLf
                    End If
                    'End Addition by GaneshG
                    'Code Integrated by TruptiK on 8-Apr-09
                    '''Code added by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
                    strValidation += "}}"
                    strValidation += "else {" + vbCrLf
                    strValidation += "if (disallowNegativeNumeric(objtxtRate,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption) + """,true))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf
                    strValidation += "if (disallowMinValueViolation(objtxtRate,0,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption) + """,true,false))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf
                    If CommonFunction.General.CheckIsNothing(m_strItem, "") <> "" Then
                        strValidation += "if(objtxtRate.value > dblBalanceBillAmount)" + vbCrLf
                        strValidation += "{ alert('Please enter the rate equal to or less than Balance Amount:" & m_dblBalanceBillAmount & "');" + vbCrLf
                        strValidation += "	objtxtRate.focus(); return  false};	" + vbCrLf
                    End If
                    strValidation += "}"
                    '''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
                    'End of integration by TruptiK
                    'Modified by GaneshG on 9 Mar 06 For IssueID - 22553
                    'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRate", "txtRate", , 100, 7, m_dblRate.ToString, "right", , , , , , "onchange=""Javascript:txtRate_OnChange()""", True, blnIsMandatory)
                    'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRate", "txtRate", , 100, 12, m_dblRate.ToString, "right", , , , , , "onchange=""Javascript:txtRate_OnChange()""", True, blnIsMandatory, EnableHTMLEncode:=True)
                    'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    'Added by TruptiK on 25-Apr-2007
                    strHTML += "(Billing Currency)</td></tr>"
                    'End of addition by TruptiK on 25-Apr-2007
                    'End Modification by GaneshG 
                    'End Integration by SavitaS
                    'Code Integrated by TruptiK on 8-Apr-09
                    '''Code added by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
                    'If m_blnDiscountSelected = True Then
                    'strHTML += "[<I>If Discount is selected then " + strUserFriendlyCaption + " should be Negative.</I>]"
                    'End If
                    '''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 

                    'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRate", "txtRate", , 100, 7, m_dblRate.ToString, "right", , , , , , "onchange=""Javascript:txtRate_OnChange()""", True, blnIsMandatory)
                Case "Amount"
                    'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtBillingCurrencyAmount", "txtBillingCurrencyAmount", , 100, 10, FormatNumber(m_dblAmount, 2, , , TriState.False), "right", , , True, , , "onpropertychange=""javascript:txtBillingCurrencyAmount_OnPropertyChange()""", True, True)
                    'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtBillingCurrencyAmount", "txtBillingCurrencyAmount", , 100, 10, FormatNumber(m_dblAmount, 2, , , TriState.False), "right", , , True, , , "onChange=""javascript:txtBillingCurrencyAmount_OnChange()""", True, True, EnableHTMLEncode:=True)
                    'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    strHTML += "(Billing Currency)</td></tr>"
                    strHTML += "<tr class=clsTREven"
                    If m_strBillingCurrencyCode = m_strBaseCurrencyCode Then strHTML += " style='display:none; visibility:hidden' "

                    strHTML += "><td valign=top align=right></td>"
                    strHTML += "<td valign=top >"
                    strHTML += "<LABEL style='width:100'>" + MyBase.GetResourceString("STANDARDRATE")
                    strHTML += "</LABEL>: 1 "
                    'Added and commented by PrashantSJ on 5th June 2007 For WhizibleSEM 7.0 Build 3
                    ' strHTML += m_strBaseCurrencyCode + " = "
                    strHTML += m_strBillingCurrencyCode + " = "
                    'strHTML += FormatNumber(m_dblStandard_BillingToBaseConversionRate, 5, , , TriState.False) + " " + m_strBillingCurrencyCode
                    strHTML += m_dblStandard_BillingToBaseConversionRate.ToString + " " + m_strBaseCurrencyCode

                    strHTML += "<br>"
                    strHTML += "<LABEL style='width:100'>" + MyBase.GetResourceString("APPLIEDRATE")
                    strHTML += "</LABEL>: 1 "
                    'strHTML += m_strBaseCurrencyCode + " = "
                    strHTML += m_strBillingCurrencyCode + " = "
                    strHTML += "<LABEL id=lblBillingToBaseConversionRate>"
                    If m_dblBillingToBaseConversionRate <> m_dblStandard_BillingToBaseConversionRate Then
                        strHTML += "<FONT color=red>" & m_dblBillingToBaseConversionRate.ToString & "</FONT>"
                    Else
                        strHTML += m_dblBillingToBaseConversionRate.ToString
                    End If
                    '                                    strHTML += "</LABEL>" + " " + m_strBillingCurrencyCode
                    strHTML += "</LABEL>" + " " + m_strBaseCurrencyCode
                    'End of comment and addition by PrashantSJ on 5th June 2007
                    'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtBillingToBaseConversionRate", "txtBillingToBaseConversionRate", , , , FormatNumber(m_dblBillingToBaseConversionRate, 2, , , TriState.False).ToString, , , , , , True, EnableHTMLEncode:=True)
                    'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    strHTML += "</td></tr>"

                    'Not Blank
                    strValidation += "if (disallowBlank(objtxtBaseCurrencyAmount,""" + MyBase.GetResourceString("MSG_BLANK").Replace("<name>", strUserFriendlyCaption + "(" + m_strBaseCurrencyCode + ")") + """,true))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf
                    'Integrated by TruptiK on 8-Apr-09
                    'Code Commented and added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
                    '''Code Commented and added by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
                    'Positive Numeric
                    'strValidation += "if (disallowNegativeNumeric(objtxtBaseCurrencyAmount,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strBaseCurrencyCode + ")") + """,true))" + vbCrLf
                    'strValidation += "	return  false;	" + vbCrLf
                    strValidation += "var ObjCheckDiscount = GetObjectReference('frmRFI_RFIItem','chkIsDisCount');" + vbCrLf
                    strValidation += "if (ObjCheckDiscount){" + vbCrLf
                    strValidation += "if (ObjCheckDiscount.checked == true){ " + vbCrLf
                    strValidation += "if ((parseFloat(objtxtBaseCurrencyAmount.value) - 0) >= 0){" + vbCrLf
                    strValidation += "alert('Please enter a negative numeric value for " + strUserFriendlyCaption + ".');" + vbCrLf
                    'strValidation += "objtxtBaseCurrencyAmount.value="""";" + vbCrLf
                    strValidation += "var ObjtxtRate = GetObjectReference('frmRFI_RFIItem','txtRate');" + vbCrLf
                    strValidation += "if (ObjtxtRate){ObjtxtRate.focus();}" + vbCrLf

                    'strValidation += "objtxtBaseCurrencyAmount.focus();" + vbCrLf
                    strValidation += "return false;" + vbCrLf
                    strValidation += "}}" + vbCrLf
                    strValidation += "else {" + vbCrLf

                    'Positive Numeric
                    strValidation += "if (disallowNegativeNumeric(objtxtBaseCurrencyAmount,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strBaseCurrencyCode + ")") + """,true))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf

                    'Greater than 0
                    strValidation += "if (disallowMinValueViolation(objtxtBaseCurrencyAmount,0,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strBaseCurrencyCode + ")") + """,true,false))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf

                    strValidation += "}}"
                    strValidation += "else {" + vbCrLf

                    ''Positive Numeric

                    strValidation += "if (disallowNegativeNumeric(objtxtBaseCurrencyAmount,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strBaseCurrencyCode + ")") + """,true))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf

                    strValidation += "if (disallowMinValueViolation(objtxtBaseCurrencyAmount,0,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strBaseCurrencyCode + ")") + """,true,false))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf
                    strValidation += ""

                    strValidation += "}"

                    '''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
                    'End of Code addition by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
                    'End of integration by TruptiK
                    strHTML += "<tr class=clsTREven"

                    If m_strBillingCurrencyCode = m_strBaseCurrencyCode Then strHTML += " style='display:none; visibility:hidden'"
                    strHTML += " ><td valign=top align=right>" + strUserFriendlyCaption + " " + "(" + m_strBaseCurrencyCode + ")"
                    strHTML += "</td><td valign=top >"
                    'tRUPTI
                    'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtBaseCurrencyAmount", "txtBaseCurrencyAmount", , 100, 10, FormatNumber(m_dblBaseCurrencyAmount, 2, , , TriState.False), "right", , , , , , "onchange=""javascript:txtBaseCurrencyAmount_OnChange()""", True, True)
                    'strHTML += "</td></tr>"
                    'Integrated by TruptiK on 25-Apr-2007
                    ''Added by PrashantSJ on 21st July 2006 
                    ''Purpose: Base currency amount text box will be read only
                    'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtBaseCurrencyAmount", "txtBaseCurrencyAmount", , 100, 10, FormatNumber(m_dblBaseCurrencyAmount, 2, , , TriState.False), "right", , , True, , , "onchange=""javascript:txtBaseCurrencyAmount_OnChange()""", True, True, EnableHTMLEncode:=True)
                    'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

                    strHTML += "(Corporate Base Currency)</td></tr>"
                    'Commented by TruptiK on 23-Jun-2007
                    'strHTML += "<tr class=clsTREven"
                    'If m_strBaseCurrencyCode = m_strLocalCurrencyCode Then strHTML += " style='display:none; visibility:hidden'"
                    'strHTML += "><td valign=top align=right></td>"
                    'strHTML += "<td valign=top>"
                    'strHTML += "<LABEL style='width:100'>" + MyBase.GetResourceString("STANDARDRATE")
                    'strHTML += "</LABEL>: 1 "
                    ''Added and commented by PrashantSJ on 5th June 2007 For WhizibleSEM 7.0 Build 3
                    ''strHTML += m_strBaseCurrencyCode + " = "
                    'strHTML += m_strLocalCurrencyCode + " = "
                    ''strHTML += FormatNumber(m_dblStandard_LocalToBaseConversionRate, 5, , , TriState.False) + " " + m_strLocalCurrencyCode
                    'strHTML += FormatNumber(m_dblStandard_LocalToBaseConversionRate, 5, , , TriState.False) + " " + m_strBaseCurrencyCode
                    'End by trupti
                    'End of modification by TruptiK on 25-Apr-2007
                    'strHTML += "<br>"
                    'strHTML += "<LABEL style='width:100'>" + MyBase.GetResourceString("APPLIEDRATE")
                    'strHTML += "</LABEL>: 1 "
                    'commented and Modified by TruptiK on 25-Apr-2007

                    'strHTML += m_strBaseCurrencyCode + " = "
                    'strHTML += m_strLocalCurrencyCode + " = "
                    'strHTML += "<LABEL id=lblLocalToBaseConversionRate>"
                    'If FormatNumber(m_dblLocalToBaseConversionRate, 5) <> FormatNumber(m_dblStandard_LocalToBaseConversionRate, 5) Then
                    '    strHTML += "<FONT color=red>" & FormatNumber(m_dblLocalToBaseConversionRate, 5, , , TriState.False) & "</FONT>"
                    'Else
                    '    strHTML += FormatNumber(m_dblLocalToBaseConversionRate, 5, , , TriState.False)
                    'End If

                    ''strHTML += "</LABEL>" + " " + m_strLocalCurrencyCode
                    'strHTML += "</LABEL>" + " " + m_strBaseCurrencyCode
                    ''End of comment and addition by PrashantSJ on 5th June 2007
                    'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtLocalToBaseConversionRate", "txtLocalToBaseConversionRate", , , , m_dblLocalToBaseConversionRate.ToString, , , , , , True)
                    'strHTML += "</td></tr>"
                    'End of commented by TruptiK 

                    'Not Blank
                    'Commented by TruptiK on 23-Jun-2007
                    'strValidation += "if (disallowBlank(objtxtLocalCurrencyAmount,""" + MyBase.GetResourceString("MSG_BLANK").Replace("<name>", strUserFriendlyCaption + "(" + m_strLocalCurrencyCode + ")") + """,true))" + vbCrLf
                    'strValidation += "	return  false;	" + vbCrLf

                    ''Positive Numeric
                    'strValidation += "if (disallowNegativeNumeric(objtxtLocalCurrencyAmount,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strLocalCurrencyCode + ")") + """,true))" + vbCrLf
                    'strValidation += "	return  false;	" + vbCrLf

                    ''Greater than 0
                    'strValidation += "if (disallowMinValueViolation(objtxtLocalCurrencyAmount,0,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strLocalCurrencyCode + ")") + """,true,false))" + vbCrLf
                    'strValidation += "	return  false;	" + vbCrLf


                    ' strHTML += "<tr class=clsTREven>"

                    'If m_strBaseCurrencyCode = m_strLocalCurrencyCode Then strHTML += " style='display:none; visibility:hidden'"
                    'strHTML += "><td valign=top align=right>" + strUserFriendlyCaption + " " + "(" + m_strLocalCurrencyCode + ")"
                    'strHTML += "</td><td valign=top >"
                    'Integrated by TruptiK on 25-Apr-2007
                    ''Added by PrashantSJ on 21st July 2006 
                    ''Purpose: Local currency amount text box will be read only
                    'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtLocalCurrencyAmount", "txtLocalCurrencyAmount", , 100, 10, FormatNumber(m_dblLocalCurrencyAmount, 2, , , TriState.False), "right", , , True, , , "onchange=""javascript:txtLocalCurrencyAmount_OnChange()""", True, True)
                    'strHTML += "(Corporate Local Currency) </td></tr>"
                    'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtLocalCurrencyAmount", "txtLocalCurrencyAmount", , 100, 10, FormatNumber(m_dblLocalCurrencyAmount, 2, , , TriState.False), "right", , , , , , "onchange=""javascript:txtLocalCurrencyAmount_OnChange()""", True, True)
                Case "CustomField1"
                    'Numeric
                    strValidation += "if (disallowNonNumeric(objtxtCustomField1,""" + MyBase.GetResourceString("MSG_NUM").Replace("<name>", strUserFriendlyCaption) + """,true))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf

                    If intControlTypeID = 2 Then
                        strHTML += CommonFunctions.HTMLControls.DrawComboBox("txtCustomField1", strSPName, 100, m_dblCustomField1.ToString, , True, True, , blnIsMandatory) + " "
                    Else
                        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtCustomField1", "txtCustomField1", , 100, 10, m_dblCustomField1.ToString, "right", , , , , , , True, blnIsMandatory, EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    End If
                Case "CustomField2"
                    'Numeric
                    strValidation += "if (disallowNonNumeric(objtxtCustomField2,""" + MyBase.GetResourceString("MSG_NUM").Replace("<name>", strUserFriendlyCaption) + """,true))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf

                    If intControlTypeID = 2 Then
                        strHTML += CommonFunctions.HTMLControls.DrawComboBox("txtCustomField2", strSPName, 100, m_dblCustomField2.ToString, , True, True, , blnIsMandatory) + " "
                    Else
                        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtCustomField2", "txtCustomField2", , 100, 10, m_dblCustomField2.ToString, "right", , , , , , , True, blnIsMandatory, EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    End If
                Case "CustomField3"
                    'Numeric
                    strValidation += "if (disallowNonNumeric(objtxtCustomField3,""" + MyBase.GetResourceString("MSG_NUM").Replace("<name>", strUserFriendlyCaption) + """,true))" + vbCrLf
                    strValidation += "	return  false;	" + vbCrLf

                    If intControlTypeID = 2 Then
                        strHTML += CommonFunctions.HTMLControls.DrawComboBox("txtCustomField3", strSPName, 100, m_dblCustomField3.ToString, , , True, , blnIsMandatory) + " "
                    Else
                        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtCustomField3", "txtCustomField3", , 100, 10, m_dblCustomField3.ToString, "right", , , , , , , True, blnIsMandatory, EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    End If

                Case "CustomField4"
                    If intControlTypeID = 2 Then
                        strHTML += CommonFunctions.HTMLControls.DrawComboBox("txtCustomField4", strSPName, , m_strCustomField4, , , True, , blnIsMandatory) + " "
                    Else
                        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtCustomField4", "txtCustomField4", , , 500, m_strCustomField4, , "width=90%", , , , , , True, blnIsMandatory, EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    End If

            End Select
            strHTML += "</td></tr>"
        Next
        strHTML += "<tr class=clsTREven><td valign=top align=right>"
        strHTML += MyBase.GetResourceString("SEQ")
        strHTML += "</td><td>"
        'strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber", "txtOrderNumber", , 50, 4, m_intOrderNumber.ToString, "right", , , , , , , "onblur = ""javascript:txtOrderNumber_Onblur()""", True, True)
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber", "txtOrderNumber", , 50, 4, m_intOrderNumber.ToString, "right", , , , , , "onblur = ""javascript:txtOrderNumber_Onchange()""", True, True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        'pRASHANT
        Dim sSql As String = ""
        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'sSql = "Select OrderNumber From tbl_PM_RFI_Items WHERE RFIID=" + m_intRFIID.ToString + " AND OrderNumber NOT IN (" + m_intOrderNumber.ToString + ")"
        sSql = "usp_sel_tbl_PM_RFI_Items_OrderNumber " + m_intRFIID.ToString + "," + m_intOrderNumber.ToString
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        strHTML += CommonFunctions.HTMLControls.DrawComboBox("cmbHidOrderNumber", sSql, , , , , True, , , , True, )
        ' strHTML += "</td></tr></table></div>"
        strHTML += "</td></tr></table>"

        Response.Write(strHTML)
        ''''''''''''''''''Added by PrashantSJ on 02 Aug 2006 
        ''Purpose: To add Company base curreny amount in collapse form
        Dim strCollapse As String = ""
        Dim ObjCompanyBaseAmountSection As New WebPage.Templates.SectionTitle
        With ObjCompanyBaseAmountSection
            strCollapse += .GetSectionTitle("Company Base Currency Amount", "DivCompanyBaseAmountSection", "HideShowCompanyBaseAmountSection", , , , , , , , , , , )

            'Write ClientsideScript in order to show hide the section
            strCollapse += "<SCRIPT Language=javascript>"
            strCollapse += .ClientsideScript
            strCollapse += "</SCRIPT>"
        End With

        Response.Write("<div id=DivCompanyBaseAmountSection Style=""OVERFLOW: Auto; WIDTH:100%;"">")
        Response.Write("<table cellspacing=0 class=clsTable width=100%><COL width=30%><COL width=70%>")
        strCollapse += "<tr class=clsTREven"

        If m_strBillingCurrencyCode = m_strCompanyBaseCurrencyCode Then strCollapse += " style='display:none; visibility:hidden' "
        strCollapse += "><td valign=top align=right></td>"
        strCollapse += "<td valign=top >"
        strCollapse += "<LABEL style='width:100'>" + MyBase.GetResourceString("STANDARDRATE")
        strCollapse += "</LABEL>: 1 "
        'tRUPTI

        'eND
        'Added and commented by PrashantSJ on 5th June 2007 For WhizibleSEM 7.0 Build 3
        'strCollapse += m_strCompanyBaseCurrencyCode + " = "
        strCollapse += m_strBillingCurrencyCode + " = "
        'strCollapse += FormatNumber(m_dblstandared_CompanyBaseConversionRate, 5, , , TriState.False) + " " + m_strBillingCurrencyCode
        strCollapse += m_dblstandared_CompanyBaseConversionRate.ToString + " " + m_strCompanyBaseCurrencyCode

        strCollapse += "<br>"
        strCollapse += "<LABEL style='width:100'>" + MyBase.GetResourceString("APPLIEDRATE")
        strCollapse += "</LABEL>: 1 "
        'strCollapse += m_strCompanyBaseCurrencyCode + " = "
        strCollapse += m_strBillingCurrencyCode + " = "
        strCollapse += "<LABEL id=lblCompanyBaseConversionRate>"
        If m_dblCompanyBaseConversionRate <> m_dblstandared_CompanyBaseConversionRate Then
            strCollapse += "<FONT color=red>" & m_dblCompanyBaseConversionRate.ToString & "</FONT>"
        Else
            strCollapse += m_dblCompanyBaseConversionRate.ToString
        End If

        'strCollapse += "</LABEL>" + " " + m_strBillingCurrencyCode
        strCollapse += "</LABEL>" + " " + m_strCompanyBaseCurrencyCode
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strCollapse += CommonFunctions.HTMLControls.DrawTextBox("txtCompanyBaseConversionRate", "txtCompanyBaseConversionRate", , , , FormatNumber(m_dblCompanyBaseConversionRate, 2, , , TriState.False).ToString, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strCollapse += "</td></tr>"

        'Not Blank
        strValidation += "if (disallowBlank(objtxtCompanyBaseCurrencyAmount,""" + MyBase.GetResourceString("MSG_BLANK").Replace("<name>", strUserFriendlyCaption + "(" + m_strCompanyBaseCurrencyCode + ")") + """,true))" + vbCrLf
        strValidation += "	return  false;	" + vbCrLf
        'Integrated by TruptiK on 8-Apr-09
        'Code Commented and added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
        '''Code Commented and added by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
        'Positive Numeric
        '        strValidation += "if (disallowNegativeNumeric(objtxtCompanyBaseCurrencyAmount,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strCompanyBaseCurrencyCode + ")") + """,true))" + vbCrLf
        '       strValidation += "	return  false;	" + vbCrLf

        'Greater than 0
        '      strValidation += "if (disallowMinValueViolation(objtxtCompanyBaseCurrencyAmount,0,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strCompanyBaseCurrencyCode + ")") + """,true,false))" + vbCrLf
        '     strValidation += "	return  false;	" + vbCrLf


        strValidation += "var ObjCheckDiscount = GetObjectReference('frmRFI_RFIItem','chkIsDisCount');" + vbCrLf
        strValidation += "if (ObjCheckDiscount){" + vbCrLf
        strValidation += "if (ObjCheckDiscount.checked == true){ " + vbCrLf
        strValidation += "if ((parseFloat(objtxtCompanyBaseCurrencyAmount.value) - 0) >= 0){" + vbCrLf
        strValidation += "alert('Please enter a negative numeric value for " + strUserFriendlyCaption + ".');" + vbCrLf
        'strValidation += "objtxtBaseCurrencyAmount.value="""";" + vbCrLf
        strValidation += "var ObjtxtRate = GetObjectReference('frmRFI_RFIItem','txtRate');" + vbCrLf
        strValidation += "if (ObjtxtRate){ObjtxtRate.focus();}" + vbCrLf

        'strValidation += "objtxtBaseCurrencyAmount.focus();" + vbCrLf
        strValidation += "return false;" + vbCrLf
        strValidation += "}}" + vbCrLf
        strValidation += "else {" + vbCrLf

        'Positive Numeric
        strValidation += "if (disallowNegativeNumeric(objtxtCompanyBaseCurrencyAmount,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strCompanyBaseCurrencyCode + ")") + """,true))" + vbCrLf
        strValidation += "	return  false;	" + vbCrLf

        'Greater than 0
        strValidation += "if (disallowMinValueViolation(objtxtCompanyBaseCurrencyAmount,0,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strCompanyBaseCurrencyCode + ")") + """,true,false))" + vbCrLf
        strValidation += "	return  false;	" + vbCrLf

        strValidation += "}}"
        strValidation += "else {" + vbCrLf
        ''Positive Numeric

        strValidation += "if (disallowNegativeNumeric(objtxtCompanyBaseCurrencyAmount,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strCompanyBaseCurrencyCode + ")") + """,true))" + vbCrLf
        strValidation += "	return  false;	" + vbCrLf

        strValidation += "if (disallowMinValueViolation(objtxtCompanyBaseCurrencyAmount,0,""" + MyBase.GetResourceString("MSG_POS").Replace("<name>", strUserFriendlyCaption + "(" + m_strCompanyBaseCurrencyCode + ")") + """,true,false))" + vbCrLf
        strValidation += "	return  false;	" + vbCrLf

        strValidation += ""
        strValidation += "}"
        '''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 

        'End of Code addition by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
        'End of integration by TruptiK

        strCollapse += "<tr class=clsTREven"
        If m_strBillingCurrencyCode = m_strCompanyBaseCurrencyCode Then strCollapse += " style='display:none; visibility:hidden'"
        strCollapse += " ><td valign=top align=right>" + strUserFriendlyCaption + " " + "(" + m_strCompanyBaseCurrencyCode + ")"
        strCollapse += "</td><td valign=top >"
        'Integrated by TruptiK on 25-Apr-2007
        ''Added by PrashantSJ on 21st July 2006 
        ''Purpose: Company Base currency amount text box will be read only
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strCollapse += CommonFunctions.HTMLControls.DrawTextBox("txtCompanyBaseCurrencyAmount", "txtCompanyBaseCurrencyAmount", , 100, 10, FormatNumber(m_dblCompanyBaseCurrencyAmount, 2, , , TriState.False), "right", , , True, , , "onchange=""javascript:txtCompanyBaseCurrencyAmount_OnChange()""", True, True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strCollapse += "(Company Base Currency)</td></tr>"

        If m_strBillingCurrencyCode = m_strCompanyBaseCurrencyCode Then
            strCollapse += "<tr class=clsTREven><td valign=top align=center> There are no items to show in this view. </td></tr>"
        End If

        strCollapse += "</table>"
        strCollapse += "</DIV>"
        '''''''''''''''01 Aug 2006 

        Response.Write(strCollapse)
        Response.Write("</DIV>")
        ''End of addition by PrashantSJ on 02 Aug 2006
        'End of integration by TruptiK

        Dim strControls As String
        strControls = "<script>" + vbCrLf + "var objtxtItemDescription=GetObjectReference('frmRFI_RFIItem','txtItemDescription');" + vbCrLf
        strControls += "var objtxtQuantity=GetObjectReference('frmRFI_RFIItem','txtQuantity');" + vbCrLf
        strControls += "var objtxtRate=GetObjectReference('frmRFI_RFIItem','txtRate');" + vbCrLf
        strControls += "var objtxtBaseCurrencyAmount=GetObjectReference('frmRFI_RFIItem','txtBaseCurrencyAmount');" + vbCrLf
        'Commented by TruptiK on 23-Jun-2007
        'strControls += "var objtxtLocalCurrencyAmount=GetObjectReference('frmRFI_RFIItem','txtLocalCurrencyAmount');" + vbCrLf
        'End of commented by TruptiK
        'Integrated by TruptiK on 25-Apr-2007
        'Added by PrashantSJ on 18th July 2006 For Bristlecon
        'Purpose:  To Store the Company Currency related information in IR items  table
        strControls += "var objtxtCompanyBaseCurrencyAmount=GetObjectReference('frmRFI_RFIItem','txtCompanyBaseCurrencyAmount');" + vbCrLf
        'End of addition by PrashantSJ on 18th July 2006 For Bristlecon
        'End of integration by TruptiK
        strControls += "var objtxtBillingCurrencyAmount=GetObjectReference('frmRFI_RFIItem','txtBillingCurrencyAmount');" + vbCrLf
        strControls += "var objtxtCustomField1=GetObjectReference('frmRFI_RFIItem','txtCustomField1');" + vbCrLf
        strControls += "var objtxtCustomField2=GetObjectReference('frmRFI_RFIItem','txtCustomField2');" + vbCrLf
        strControls += "var objtxtCustomField3=GetObjectReference('frmRFI_RFIItem','txtCustomField3');" + vbCrLf
        strControls += "var objtxtCustomField4=GetObjectReference('frmRFI_RFIItem','txtCustomField4');" + vbCrLf + "</script>" + vbCrLf
        Response.Write(strControls)

        Response.Write("<script>" + vbCrLf + "function Validate()" + vbCrLf + "{" + vbCrLf + strValidation + vbCrLf + "}" + vbCrLf + "</script>")

        Response.Write("<BR>")
        GetMenu()

    End Sub

    Public Sub New()
        ' Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.RFI_RFIItems", "AppResources")
    End Sub

    '====================================================================
    ' Procedure Name        :   PlotHiddenControls
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To plot the hidden controls required for the page
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 30, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub PlotHiddenControls()
        Dim strHTML As String
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strHTML = CommonFunctions.HTMLControls.DrawTextBox("txtUseFormContents", "txtUseFormContents", , , , "1", , , , , , True, , True, EnableHTMLEncode:=True)
        Dim StrSql As String
        'Integrated by TruptiK on 8-Apr-09
        '''Code added by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
        If m_intRFIItemID <> 0 Then

            'StrSql = "SELECT SUM(ISNULL(Amount,0)) Amount FROM tbl_PM_RFI_Items where RFIID = " & m_intRFIID.ToString & "  AND RFIItemID <> " & m_intRFIItemID.ToString
            StrSql = "usp_sel_tbl_PM_RFI_Items_Amount " & m_intRFIID.ToString & "," & m_intRFIItemID.ToString
        Else
            'StrSql = "SELECT SUM(ISNULL(Amount,0)) Amount FROM tbl_PM_RFI_Items where RFIID = " & m_intRFIID.ToString
            StrSql = "usp_sel_tbl_PM_RFI_Items_Amount_null " & m_intRFIID.ToString
        End If
        m_fltTotalAmount = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(StrSql, MyBase.UseSQL), "0"), String)
        '''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
        'End of integration by TruptiK
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtBaseCurrencyCode", "txtBaseCurrencyCode", , , , m_strBaseCurrencyCode, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtBillingCurrencyCode", "txtBillingCurrencyCode", , , , m_strBillingCurrencyCode, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtLocalCurrencyCode", "txtLocalCurrencyCode", , , , m_strLocalCurrencyCode, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtStandard_BillingToBaseConversionRate", "txtStandard_BillingToBaseConversionRate", , , , FormatNumber(m_dblStandard_BillingToBaseConversionRate, 2, , , TriState.False).ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtStandard_LocalToBaseConversionRate", "txtStandard_LocalToBaseConversionRate", , , , m_dblStandard_LocalToBaseConversionRate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        'Integrated by TruptiK on 25-Apr-2007
        'Added by PrashantSJ on 18th July 2006 For Bristlecon
        'Purpose:  To Store the Company Currency related information in IR items  table
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtCompanyBaseCurrencyCode", "txtCompanyBaseCurrencyCode", , , , m_strCompanyBaseCurrencyCode, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtStandard_CompanyBaseConversionRate", "txtStandard_CompanyBaseConversionRate", , , , FormatNumber(m_dblstandared_CompanyBaseConversionRate, 2, , , TriState.False).ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        'End of addition by PrashantSJ on 18th July 2006 For Bristlecon
        'End of integration by TruptiK
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRFIID", "txtRFIID", , , , m_intRFIID.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRFITypeID", "txtRFITypeID", , , , m_intRFITypeID.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRFIItemID", "txtRFIItemID", , , , m_intRFIItemID.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtHiddenToken", "txtHiddenToken", , , , m_strToken, , , , , , True, , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        'End of addition by MonikaI
        Response.Write(strHTML)
    End Sub

    '====================================================================
    ' Procedure Name        :   GetMenu
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To plot the Menu
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 30, 2004
    ' Revisions :
    '=====================================================================

    Private Sub GetMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        'Display the static menu
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips


        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
        ArrClientSideFunctionsList.Add("Save_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))

        If m_intRFIItemID <> 0 Then
            If AuditTrailExists(intTagID, m_intRFIItemID, m_intProjectID) Then
                ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_SHOWHISTORY"))
                ArrClientSideFunctionsList.Add("ShowHistory_OnClick(" & intTagID & "," & m_intRFIItemID & "," & m_intProjectID & ")")
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_SHOWHISTORY_TOOLTIP"))
            End If
        End If

        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))

        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        'TODO
        ArrClientSideFunctionsList.Add("Help_OnClick('RFI_ITEM')")
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

        MyBase.InitializeResources("AppResources.RFI_RFIItem", "AppResources")
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
    ' Created				:	30 July 2004
    ' Revisions				:
    '=====================================================================

    Private Function AuditTrailExists(ByVal TagID As Integer, ByVal RFIITEMID As Integer, ByVal ProjectID As Long) As Boolean
        Dim drAT As IDataReader
        Dim result As Boolean

        Dim strSQLQuery As String
        strSQLQuery = "Exec usp_Sel_tbl_PM_AuditTrail " & TagID & ", " & RFIITEMID & ", " & ProjectID
        drAT = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drAT.Read Then
            result = True
        End If

        CommonFunctions.Data.DisposeDataReader(drAT)
        Return result

    End Function



#End Region

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
        'Added by TruptiK on 9-May-2007
        m_strtoken1 = CommonFunctions.Security.Token.GetToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
        'End of addition by TruptiK on 9-May-2007
        m_strToken = ""

        If HttpContext.Current.Request.QueryString("PKToken") Is Nothing Then
            m_strToken = Request.Form("txtHiddenToken") & ""
        Else
            m_strToken = Request.QueryString("PKToken") & ""
        End If

        If Trim(Request.QueryString("Mode")) = "New" Then
            If CommonFunctions.Security.Token.ValidateToken(CType(0, String) + HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        ElseIf Trim(Request.QueryString("Mode")) = "Edit" Then
            If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIItemID").ToString + HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

        'End of addition by MonikaI
    End Sub
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
    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Private Sub objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles objMenu.Before_Link_Print
        If m_blnIsProjectOver = True Or m_objAccessRights.Edit = False Then
            Select Case Args.LinkName.ToUpper
                Case "SAVE"
                    Cancel = True
            End Select
        End If
    End Sub
End Class
