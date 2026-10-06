Public Class FA_PaymentReceipts
    Inherits WebPages.Template.WhizTemplate
    Private m_strHowToGenerate As String
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Protected m_strSessionUserID As String

    Protected m_blnIsFooter As Boolean = False   'True id body holds footer
    Protected m_blnIsHeader As Boolean = False   'True id body holds header


    Private m_strSessionLoginType As String
    Private m_strSessionIsCreatedByCustomer As String
    Private m_strSessionCustomerCreatedLoginID As String
    Private m_strSessionPostID As String
    Private m_strWhatToShow As String
    Private drCustomerInvoice As IDataReader
    Private m_strSQLQuery As String = ""
    Private m_blnSubProjectLevelInvoiceing As Boolean

    Private m_strSubProjectCaption As String = ""
    Private m_blnAddAccess As Boolean
    Private WithEvents m_objGridCustomers As New WebPage.Templates.GenericGrid
    Private WithEvents m_objGridPayments As New WebPage.Templates.GenericGrid
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccess As WebPages.Security.cAccessRights


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

    Public Sub PageInit()

        Dim intChecked As Integer
        Dim intInvoiceNo As String
        Dim strSelectedInvoices As String = ""
        Dim intErrorID As Integer
        Dim drTagMaster, drGetAccess, drError, drCompanyInformation As IDataReader
        Dim strSQL As String

        m_strSessionUserID = Request.QueryString("CustomerID")
        m_strSessionLoginType = CType(Session("LoginType"), String)
        m_strSessionIsCreatedByCustomer = CType(Session("IsCreatedByCustomer"), String)
        m_strSessionCustomerCreatedLoginID = CType(Session("CustomerCreatedLoginID"), String)
        m_strSessionPostID = CType(Session("intPostID"), String)
        m_strHowToGenerate = Request.QueryString("HowToGenerate")
        m_strWhatToShow = Request.QueryString("WhatToShow")

        GetGlobalObject()
        m_objAccess = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccess.GetAccess()

        If m_strSessionLoginType = "C" Then
            m_strSessionUserID = CType(Session("intUserID"), String)
        End If

        drCompanyInformation = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_CompanyInformation", MyBase.UseSQL)
        If drCompanyInformation.Read Then
            m_blnSubProjectLevelInvoiceing = CType(CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("SubProjectLevelInvoiceing"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(drCompanyInformation)

        If m_blnSubProjectLevelInvoiceing Then
            ' Get the caption to be displayed.
            drTagMaster = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_UI_TagMaster 661", MyBase.UseSQL)
            If drTagMaster.Read Then
                m_strSubProjectCaption = CType(CommonFunctions.Data.CheckIsDBNull(drTagMaster("TagDescription"), ""), String)
                If UCase(Right(m_strSubProjectCaption, 1)) = "S" Then
                    m_strSubProjectCaption = Left(m_strSubProjectCaption, Len(m_strSubProjectCaption) - 1)
                End If
            Else
                m_strSubProjectCaption = MyBase.GetResourceString("WORK_ORDER")
            End If
            CommonFunctions.Data.DisposeDataReader(drTagMaster)
        End If


        If m_strHowToGenerate = "Paid" Then

            If Split(MyBase.GetFormValue("chkPayment"), ",").Length > 0 Then
                'for loop to construct the selected TimeSheet Number list
                For intChecked = 0 To Split(MyBase.GetFormValue("chkPayment"), ",").Length - 1
                    intInvoiceNo = Split(MyBase.GetFormValue("chkPayment"), ",")(intChecked)
                    strSelectedInvoices = strSelectedInvoices & intInvoiceNo & ","
                Next
                'Remove the last comma from the list
                strSelectedInvoices = Left(strSelectedInvoices, Len(Trim(strSelectedInvoices)) - 1)
                'Execute the stored procedure to generate the invoice from the selected
                'time sheet
                CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_Invoice '" + strSelectedInvoices + "'", MyBase.UseSQL)
                strSelectedInvoices = ""
            End If
        End If

        If m_strHowToGenerate = "Delete" Then

            If Split(MyBase.GetFormValue("chkDelete"), ",").Length > 0 Then
                Dim strMsg As String = ""

                'for loop to construct the selected TimeSheet Number list

                For intChecked = 0 To Split(MyBase.GetFormValue("chkDelete"), ",").Length - 1
                    intInvoiceNo = Split(MyBase.GetFormValue("chkDelete"), ",")(intChecked)
                    If Trim(intInvoiceNo) <> "" Then
                        strSQL = "DECLARE @intErrorID int " & vbCrLf
                        strSQL = strSQL + "Exec usp_Del_Invoice " + Trim(intInvoiceNo) + ", @intErrorID OUTPUT" & vbCrLf
                        strSQL = strSQL + " Select 'ErrorID' =  @intErrorID" & vbCrLf
                        drError = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                        If drError.Read Then
                            intErrorID = CType(CommonFunctions.Data.CheckIsDBNull(drError("ErrorID"), "0"), Integer)
                        End If
                        If intErrorID = 0 Then
                            strMsg = strMsg & Replace(MyBase.GetResourceString("CONFIRM_DELETE"), "<=>", CStr(intInvoiceNo)) & "\n"
                        Else
                            strMsg = strMsg & MyBase.GetResourceString("PROBLEM_DELETE") & intInvoiceNo & "\n"
                        End If
                        CommonFunctions.Data.DisposeDataReader(drError)
                    End If
                Next

                Response.Write("<Script Language=Javascript> " & vbCrLf)
                Response.Write("alert('" & strMsg & "');")
                Response.Write("</SCRIPT>")
            End If

        End If

        DrawMenu("Top")
        CommonFunctions.General.WriteHTML("<br>")
        DrawPageCaptionHeaderNFooter("Header")
        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto;width:100%;Height:450px'>")
        'This condition displays only the list of customers.
        If m_strSessionLoginType = "E" And m_strWhatToShow <> "Payment" Then
            DrawCustomerGrid()
        ElseIf m_strWhatToShow = "Payment" Then
            DrawPaymentDetailsGrid()
        End If
        CommonFunction.General.WriteHTML("</div>")
        DrawPageCaptionHeaderNFooter("Footer")
        DrawMenu("Bottom")

        m_objGlobal = Nothing
        m_objAccess = Nothing
        m_objMenu = Nothing

    End Sub
    Private Sub DrawPaymentDetailsGrid()
        '=====================================================================
        ' Procedure Name        : DrawPaymentDetailsGrid()	
        ' Purpose               : To plot list of customers payment details.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 16, 2004
        ' Revisions             :
        '=====================================================================
        Dim drDailyActivity As IDataReader
        'Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrColumnHeadingList() As String = {MyBase.GetResourceString("INVOICE_NO"), m_strSubProjectCaption, MyBase.GetResourceString("INVOICE_DATE"), MyBase.GetResourceString("PROJECT"), MyBase.GetResourceString("AMOUNT_PAID"), MyBase.GetResourceString("AMOUNT_OUTSTD"), MyBase.GetResourceString("PAID"), MyBase.GetResourceString("DELETE")}
        'Dim arrActualColumnNames As New ArrayList
        Dim arrActualColumnNames() As String = {"CustomerInvoiceNo", "SubProjectName", "InvoiceDate", "ProjectName", "Amount", "Amount", "", ""}
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"", "", "", "", "", "", "", ""}
        Dim arrColRowLinks() As String = {"ShowInvoice(InvoiceNo)", "", "", "", "", ""}
        'Dim arrColCheckBoxes As New ArrayList
        Dim arrColCheckBoxes() As String = {"", "", "", "", "", "", "chkPayment", "chkDelete"}
        Dim arrSummaryFunctions() As String = {"", "", "", "", "SUM", "SUM", "", ""}
        Dim strHTML As String = ""


        Dim strFireOnLoad As String = ""
        Dim drGetAccess As IDataReader
        Dim strDeleteAccess, strViewAccess As Boolean
        Dim dblPaidAmount As Double = 0
        Dim dblOutstandingAmount As Double = 0
        'Dim strArrClsForTR As String() = {"clsTREven", "clsTROdd"}
        Dim intClassCounter As Integer = 1
        Dim intNoColumns As Integer = 0
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        CommonFunctions.Data.DisposeDataReader(drGetAccess)

        CommonFunctions.General.WriteHTML("<br>")

        With m_objGridPayments
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .NoOfDataColumns = 6
            .DIVStyle = "overflow:none"
            .CheckBoxIDArray = arrColCheckBoxes
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .RowLinkArray = arrColRowLinks
            .SQL = m_strSQLQuery
            .ColNameToolTipOnEachRow = True
            .ShowSummaryFunctions = True
            .SummaryFunctions = arrSummaryFunctions
            .UseSQL = True
            .PrimaryKey = "InvoiceNo"
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGridPayments = Nothing
        CommonFunctions.General.WriteHTML("<br>")


    End Sub
    Private Sub DrawCustomerGrid()
        '=====================================================================
        ' Procedure Name        : DrawCustomerGrid()	
        ' Purpose               : To plot list of customers on the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 16, 2004
        ' Revisions             :
        '=====================================================================
        Dim drDailyActivity As IDataReader
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"style='width:60%'", "align=left"}
        Dim arrColRowLinks() As String = {"Customer_OnSelect(Customer)"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Code for filtering.
        'm_strDefaultSortField = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"))
        'm_strDefaultSortField = CommonFunctions.General.UnBuildQueryString(m_strDefaultSortField)
        'm_strDefaultSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"))
        'm_strDefaultSortOrder = CommonFunctions.General.UnBuildQueryString(m_strDefaultSortOrder)
        'If m_strDefaultSortField = "" Then m_strDefaultSortField = "TaskName"
        'If m_strDefaultSortOrder = "" Then m_strDefaultSortOrder = "ASC"
        'strSQLQuery = strSQLQuery + " ORDER BY " + m_strDefaultSortField + " " + m_strDefaultSortOrder + "', '" + m_strPageNumber + "'"

        CommonFunctions.General.WriteHTML("<br>")

        'Plots the Table for Daily Activity .
        '-------------------------------------------------------------------

        arrColumnHeadingList.Add(MyBase.GetResourceString("CUSTOMER_NAME"))
       
        arrActualColumnNames.Add("CustomerName")


        With m_objGridCustomers
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 1
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .RowLinkArray = arrColRowLinks
            .SQL = "EXEC usp_Sel_tbl_PM_Customer"
            .ColNameToolTipOnEachRow = True
            '.SortBy = m_strDefaultSortField
            '.SortOrder = m_strDefaultSortOrder
            '.ClientSideSortFunctionName = "Sort_OnClick"
            .UseSQL = True
            .PrimaryKey = "Customer"
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGridCustomers = Nothing
        CommonFunctions.General.WriteHTML("<br>")

        'CommonFunctions.HTMLControls.DrawTextBox("txthidPageNo_TaskSelection", "txthidPageNo_TaskSelection", , , , m_strPageNumber, , , , , , True)
        'CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strDefaultSortField, , , , , , True)
        'CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strDefaultSortOrder, , , , , , True)

    End Sub
    Private Sub DrawPageCaptionHeaderNFooter(ByVal strPosition As String)
        '=====================================================================
        ' Procedure Name        : DrawPageCaptionHeaderNFooter()	
        ' Purpose               : To plot the page caption
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 16, 2004
        ' Revisions             :
        '=====================================================================
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter
        Dim strHTML As String = ""

        If strPosition <> "Footer" Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        End If

        If strPosition = "Header" Then
            objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
            strHTML = objHeaderFooter.DrawHeaderFooter(m_objGlobal, True)
            If strHTML <> "" Then
                CommonFunctions.General.WriteHTML("<BR>" + strHTML)
                m_blnIsHeader = True
            End If
        End If
        If strPosition = "Footer" Then
            objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
            strHTML = objHeaderFooter.DrawHeaderFooter(m_objGlobal, True)
            If strHTML <> "" Then
                CommonFunctions.General.WriteHTML("<BR>" + strHTML + "<BR>")
                m_blnIsFooter = True
            End If
        End If

        objHeaderFooter = Nothing

    End Sub
    Private Sub DrawMenu(ByVal strLocation As String)

        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 16, 2004
        ' Revisions             :
        '=====================================================================
        Dim drGetAccess As IDataReader

        Dim arrMenuCaptionsList As New ArrayList
        'Stores the captions of the Menu

        Dim arrMenuToolTipsList As New ArrayList
        'Stores the Tooltips of the Menu items

        Dim arrClientSideFunctionList As New ArrayList
        'Stores the client side function name for the menu item

        Dim strMenu As String
        'Used to store the Menu List as HTML

        'Dim strPageAlphabets As String

        m_objMenu = New WebPages.Template.StaticMenu

        'This code is for the Page links on the top.

        'If strLocation = "Top" Then
        'strLinkQuery = strLinkQuery & " ORDER BY " & m_strSortByField & " " & m_strAscOrDesc & "'"
        'strLinkQuery = strLinkQuery & ", '-1'"
        'strPageAlphabets = m_objPaging.DrawPagingWithEvents(m_strPageNumber, strLinkQuery, "Select ", , "TaskName", True)
        'If strPageAlphabets = "" Then m_strPageNumber = "-1"
        'End If
        'Execute the SP to get the selected customers invoices			

        If m_strWhatToShow = "Payment" Then
            If m_strSessionLoginType = "E" Then
                m_strSQLQuery = "usp_Sel_tbl_PM_Invoice " & m_strSessionUserID
            ElseIf m_strSessionLoginType = "C" And m_strSessionIsCreatedByCustomer = "" Then
                m_strSQLQuery = "usp_Sel_tbl_PM_Invoice " & m_strSessionUserID
            Else
                m_strSQLQuery = "usp_Sel_CustomerInvoiceForCustomerCreatedLogin " & m_strSessionUserID & "," & m_strSessionCustomerCreatedLoginID
            End If

            drCustomerInvoice = CommonFunctions.Data.GetDataReader(m_strSQLQuery, MyBase.UseSQL)

            If drCustomerInvoice.Read Then
                'To apply the access machanism				
                drGetAccess = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_UI_NodeAccess 350," & m_strSessionPostID, MyBase.UseSQL)
                If drGetAccess.Read Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("A"), "0"), Boolean) = True Then
                        'If Session("intPostID")=ROLE_FINANCE_MANAGER  or Session("intPostID")= ROLE_CHIEF_FINANCE_OFFICER Or Session("intPostID")=ROLE_ACCOUNT_PERSON or Session("intPostID")=ROLE_CUSTOMER Then
                        arrMenuCaptionsList.Add(MyBase.GetResourceString("PAID"))
                        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_PAID_TOOLTIP"))
                        arrClientSideFunctionList.Add("Paid()")
                    End If
                    If CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("D"), "0"), Boolean) = True Then
                        arrMenuCaptionsList.Add(MyBase.GetResourceString("DELETE"))
                        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP"))
                        arrClientSideFunctionList.Add("DeleteInvoice()")
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drGetAccess)
                CommonFunctions.Data.DisposeDataReader(drCustomerInvoice)
            End If

            arrMenuCaptionsList.Add(MyBase.GetResourceString("BACK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
            arrClientSideFunctionList.Add("Back_OnClick()")

        End If

        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('PR')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
        'strPageAlphabets = ""

    End Sub

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.FA_PaymentReceipts", "AppResources")
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
        ' Created               : Feb 24, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub m_objGridCustomers_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridCustomers.DataRowTD_BeforePrint
        If Args.ColumnName = MyBase.GetResourceString("SHOW_DETAILS") Then
            Args.ReplacementValue = MyBase.GetResourceString("SELECT_CUSTOMER")
        End If
    End Sub

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If m_objAccess.Add = False And Args.LinkName = MyBase.GetResourceString("PAID") Then
            Cancel = True
        End If
        If m_objAccess.Delete = False And Args.LinkName = MyBase.GetResourceString("DELETE") Then
            Cancel = True
        End If
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub m_objGridPayments_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridPayments.DataRowTD_BeforePrint
        If Args.ColIndex = 1 And m_blnSubProjectLevelInvoiceing = False Then
            Cancel = True
        End If
        If m_objAccess.Delete = False And Args.ColumnName = MyBase.GetResourceString("DELETE") Then
            Cancel = True
        End If
        If m_objAccess.Add = False And Args.ColumnName = MyBase.GetResourceString("PAID") Then
            Cancel = True
        End If

        If Args.ColIndex = 4 Then
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Paid"), "0"), Boolean) = False Then
                Args.ReplacementValue = "0.00"
            End If
        End If

        If Args.ColIndex = 5 Then
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Paid"), "0"), Boolean) = True Then
                Args.ReplacementValue = "0.00"
            End If
        End If

        If Args.ColIndex = 6 Then
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Paid"), "0"), Boolean) = True Then
                Args.IsCheckBoxDisabled = True
            End If
        End If

    End Sub

    Private Sub m_objGridPayments_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGridPayments.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 1 And m_blnSubProjectLevelInvoiceing = False Then
            Cancel = True
        End If
        If m_objAccess.Delete = False And Args.ColumnName = MyBase.GetResourceString("DELETE") Then
            Cancel = True
        End If
        If m_objAccess.Add = False And Args.ColumnName = MyBase.GetResourceString("PAID") Then
            Cancel = True
        End If
    End Sub

    Private Sub m_objGridPayments_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objGridPayments.SummaryFunctionsTD_BeforePrint
        If Args.ColIndex = 1 And m_blnSubProjectLevelInvoiceing = False Then
            Cancel = True
        End If
    End Sub
End Class

