Imports CommonFunctions

Public Class FA_TeamBilling
    Inherits WebPages.Template.WhizTemplate

    Protected Const CONST_MODE_LIST As String = "LIST"
    Protected Const CONST_MODE_INVOICE As String = "INVOICE"
    Protected Const CONST_ACTION_DELETE As String = "DELETE"
    Protected Const CONST_ACTION_EXCLUDE As String = "EXCLUDE"
    Protected Const CONST_ACTION_SAVE As String = "SAVE"

    Protected m_strWindowTitle As String
    Protected m_strMode As String
    Protected m_strAction As String
    Protected m_strSortOrder As String
    Protected m_strOrderBy As String
    Protected m_strInvoiceNo As String
    Protected m_strMasterTagID As String
    Protected m_strFromWhere As String
    Private m_strProjectID As String
    Private m_strUserID As String

    Private m_blnAddAccess As Boolean
    Private m_blnDelAccess As Boolean
    Private m_blnEditAccess As Boolean
    Private WithEvents m_objGrid As WebPage.Templates.GenericGrid

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

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'initialize the resource file for Team billing page.
        MyBase.InitializeResources("AppResources.FA_TeamBilling", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_BILLING")
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 18 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim strHeaderFooter As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccess As WebPage.Templates.AccessRights

        m_strMode = Request.QueryString("Mode") + ""
        m_strAction = Request.QueryString("Action") + ""
        m_strMasterTagID = Request.QueryString("MasterTagID") + ""
        m_strFromWhere = Request.QueryString("FromWhere") + ""
        m_strSortOrder = Request.QueryString("SortOrder") + ""
        m_strOrderBy = Request.QueryString("OrderBy") + ""
        m_strInvoiceNo = Request.QueryString("InvoiceNo") + ""
        m_strUserID = Session("intUserID").ToString + ""

        If m_strMode = "" Then m_strMode = CONST_MODE_LIST
        If m_strSortOrder = "" Then m_strSortOrder = "ASC"
        If m_strOrderBy = "" Then m_strOrderBy = "InvoiceNo"

        'get the access settings for the user
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject
        objAccess = New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add
        m_blnDelAccess = objAccess.Delete
        m_blnEditAccess = objAccess.Edit
        objAccess = Nothing

        m_strProjectID = ""
        If objGlobal.ProjectID > 0 Then
            m_strProjectID = objGlobal.ProjectID.ToString + ""
        End If
        'm_strProjectID = Session("intProjectID").ToString + ""

        If m_strProjectID <> "" Then

            Select Case m_strMode.ToUpper
                Case CONST_MODE_LIST

                    If m_strAction <> "" Then
                        Call performListAction()
                    End If

                    'initialize the resource file for standard menu.
                    MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                    arrMenu = New System.Collections.ArrayList
                    arrMenuToolTip = New System.Collections.ArrayList
                    arrClientSideFunctions = New System.Collections.ArrayList

                    If m_blnAddAccess = True Then
                        arrMenu.Add(MyBase.GetResourceString("MENU_ADDNEW")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP")) : arrClientSideFunctions.Add("AddNew_OnClick()")
                    End If
                    If m_blnDelAccess = True Then
                        arrMenu.Add(MyBase.GetResourceString("MENU_SELECTALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")) : arrClientSideFunctions.Add("SelectAll_OnClick()")
                        arrMenu.Add(MyBase.GetResourceString("MENU_DELETE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP")) : arrClientSideFunctions.Add("Delete_OnClick()")
                    End If
                    arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('590')")

                    'copy all the element to string array
                    Dim arrstrMenu(arrMenu.Count - 1) As String
                    Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                    Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                    arrMenu.CopyTo(arrstrMenu)
                    arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                    arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                    arrMenu = Nothing
                    arrMenuToolTip = Nothing
                    arrClientSideFunctions = Nothing

                    'draw upper menu
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                    General.WriteHTML(strMenu)
                    General.WriteHTML("<BR>")

                    'initialize the resource file for team billing page.
                    MyBase.InitializeResources("AppResources.FA_TeamBilling", "AppResources")

                    'draw page caption 
                    'WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_BILLING"))
                    WebPage.Templates.PageCaption.GetPageCaptions((objGlobal))
                    General.WriteHTML("<BR>")

                    'draw page description
                    objHeader = New WebPage.Templates.HeaderFooter
                    'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_BILLING") + ""
                    objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
                    strHeaderFooter = objHeader.DrawHeaderFooter(objGlobal, True) + ""
                    If strHeaderFooter <> "" Then
                        General.WriteHTML(strHeaderFooter)
                        General.WriteHTML("<BR>")
                    End If
                    objHeader = Nothing

                    'plot the grid to display the list of invoices
                    Call plotInvoiceListGrid()

                    General.WriteHTML("<BR>")
                    General.WriteHTML(strMenu)

                Case CONST_MODE_INVOICE

                    If m_strAction <> "" Then
                        'update data for given action
                        Call performInvoiceAction()
                    End If

                    'initialize the resource file for standard menu.
                    MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                    arrMenu = New System.Collections.ArrayList
                    arrMenuToolTip = New System.Collections.ArrayList
                    arrClientSideFunctions = New System.Collections.ArrayList

                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_BACK")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP")) : arrClientSideFunctions.Add("Back_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('590')")

                    'copy all the element to string array
                    Dim arrstrMenu(arrMenu.Count - 1) As String
                    Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                    Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                    arrMenu.CopyTo(arrstrMenu)
                    arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                    arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                    arrMenu = Nothing
                    arrMenuToolTip = Nothing
                    arrClientSideFunctions = Nothing

                    'draw upper menu
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                    General.WriteHTML(strMenu)

                    'Display the (* Mandatory) PageLegends 
                    Dim strarrLegend() As String = {"Mandatory"}
                    Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                    General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                    'initialize the resource file for team billing page.
                    MyBase.InitializeResources("AppResources.FA_TeamBilling", "AppResources")

                    'draw page caption 
                    WebPage.Templates.PageCaption.GetPageCaptions((objGlobal))
                    General.WriteHTML("<BR>")

                    'draw page description
                    objHeader = New WebPage.Templates.HeaderFooter
                    objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER
                    strHeaderFooter = objHeader.DrawHeaderFooter(objGlobal, True) + ""
                    If strHeaderFooter <> "" Then
                        General.WriteHTML(strHeaderFooter)
                        General.WriteHTML("<BR>")
                    End If
                    objHeader = Nothing
                    objGlobal = Nothing

                    'plot grid for the list of resources for the invoice
                    Call plotResourceListgrid()

                    General.WriteHTML("<BR>")
                    General.WriteHTML(strMenu)

            End Select
        Else
            General.WriteHTML("<Div id='PageDiv' width=100% style='overflow: auto;'>")
            General.WriteHTML("<Table width=99.9% class='clsTable' cellpadding=0 cellspacing=0>")
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='center'>" + MyBase.GetResourceString("MSG_SELECT_PROJECT") + "</TD>")
            General.WriteHTML("</TR>")
            General.WriteHTML("</Table>")
            General.WriteHTML("</Div>")
        End If
        objGlobal = Nothing
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotInvoiceListGrid
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the grid for thelist of invoices of current project
    ' Description			:	this procedure uses grid object to plot the list of the invoices 
    '                           for the current project.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 18 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotInvoiceListGrid()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strCustomerID As String
        Dim strCustomerName As String
        Dim strProjectName As String
        Dim arrlstColHeader As ArrayList
        Dim arrlstAN As ArrayList
        Dim arrlstRowLink As ArrayList
        Dim arrlstCheckBox As ArrayList
        Dim arrlstTDStyle As ArrayList

        arrlstColHeader = New ArrayList
        arrlstAN = New ArrayList
        arrlstRowLink = New ArrayList
        arrlstCheckBox = New ArrayList
        arrlstTDStyle = New ArrayList

        arrlstColHeader.Add(MyBase.GetResourceString("COL_INVOICE_NO")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_INVOICE_DATE")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_MONTHLY_FEE")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_AMOUNT"))
        arrlstAN.Add("InvoiceNo") : arrlstAN.Add("InvoiceDate") : arrlstAN.Add("Rate") : arrlstAN.Add("Amount")
        arrlstRowLink.Add("Invoice_OnClick(InvoiceNo)") : arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("")
        arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("")
        arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='right'") : arrlstTDStyle.Add("align='right'")
        'if user has delete access then only show delete column with delete checkbox
        If m_blnDelAccess = True Then
            arrlstColHeader.Add(MyBase.GetResourceString("COL_DELETE"))
            arrlstAN.Add("")
            arrlstRowLink.Add("")
            arrlstCheckBox.Add("chkDelete")
            arrlstTDStyle.Add("align='center'")
        End If

        Dim arrColHeader(arrlstColHeader.Count) As String
        Dim arrAN(arrlstAN.Count) As String
        Dim arrRowLink(arrlstRowLink.Count) As String
        Dim arrCheckBox(arrlstCheckBox.Count) As String
        Dim arrTDStyle(arrlstTDStyle.Count) As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        arrlstColHeader.CopyTo(arrColHeader)
        arrlstAN.CopyTo(arrAN)
        arrlstRowLink.CopyTo(arrRowLink)
        arrlstCheckBox.CopyTo(arrCheckBox)
        arrlstTDStyle.CopyTo(arrTDStyle)

        arrlstColHeader = Nothing
        arrlstAN = Nothing
        arrlstRowLink = Nothing
        arrlstCheckBox = Nothing
        arrlstTDStyle = Nothing

        'create the SP for grid data without sorting 
        strSQL = "usp_Sel_tbl_PM_Invoice_TeamBilling " + m_strProjectID.ToString + ",'ORDER BY " + General.BuildQueryString(m_strOrderBy.Trim) + " " + General.BuildQueryString(m_strSortOrder.Trim) + "'"

        'create Grid object and set the properties
        m_objGrid = New WebPage.Templates.GenericGrid
        With m_objGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            .RowLinkArray = arrRowLink
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "InvoiceNo"
            .ClientSideSortFunctionName = "Sort_OnClick"
            .DIVID = "PageDiv"
            .DIVHeight = 400
            .DIVStyle = "overflow: auto"
            .NoOfDataColumns = 4
            .SortOrder = m_strSortOrder
            .SortBy = m_strOrderBy
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .EmptyValueReplacement = "-"
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            'plot the grid 
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        'get the total no of rows plotted and store it in the hidden textbox
        Dim i As Integer = 0
        i = m_objGrid.NoOfRows
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("hdtxtRowCount", "hdtxtRowCount", , , , i.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        m_objGrid = Nothing

    End Sub

    'Here if user has edit access then only show the link in the first column 
    'else the link will be disabled
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 0 Then
            If m_blnEditAccess = True Then
                Args.StringToBeInserted = "<TD align='left'><A href='javascript:Invoice_OnClick(" + Args.DataReader("InvoiceNo").ToString + ")'>" + Args.DataReader("InvoiceNo").ToString + " " + Args.DataReader("CustomerInvoiceNo").ToString + "</A></TD>"
            Else
                Args.StringToBeInserted = "<TD align='left'>" + Args.DataReader("InvoiceNo").ToString + " " + Args.DataReader("CustomerInvoiceNo").ToString + "</TD>"
            End If
            Cancel = True
        End If
    End Sub

    '=====================================================================
    ' Procedure Name		:	performListAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To perform the action based onthe action given.
    ' Description			:	this procedure will delete the records for the selected invoices
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 18 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performListAction()
        Dim strSQL As String
        Dim strInvoiceIDList As String
        Dim arrID() As String

        Select Case m_strAction.ToUpper
            Case CONST_ACTION_DELETE
                'Delete selected invoices
                'get the list of ID of the selected 
                strInvoiceIDList = MyBase.GetFormValue("chkDelete") + ""

                If strInvoiceIDList <> "" Then
                    arrID = Split(strInvoiceIDList, ",")
                    Dim i As Integer
                    For i = 0 To arrID.Length - 1
                        If arrID(i) <> "" Then
                            strSQL = "usp_Del_tbl_PM_Invoice_TeamBilling " + arrID(i).Trim
                            Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                        End If
                    Next
                End If
        End Select
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotResourceListgrid
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the grid for the list of resources of current project.
    ' Description			:	this procedure uses grid object to plot the list of the resources 
    '                           for the current project.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 18 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotResourceListgrid()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim objDrInvoiceDate As IDataReader
        Dim blnRecordFound As Boolean = False
        Dim intRowCount As Integer
        Dim strInvoiceDetailID As String
        Dim strEmployeeID As String
        Dim strResourcePercentage As String
        Dim strClientSideScript As String
        Dim intCntr As Integer
        Dim strFromDate As String
        Dim strToDate As String
        Dim blnIsChecked As Boolean = False

        'if no invoice id specified meance it is add new mode else it is Edit mode
        'set the Sp to be used in edit or add new mode
        If m_strInvoiceNo <> "" Then
            strSQL = "usp_Sel_tbl_PM_InvoiceDetails_TeamBilling " + m_strInvoiceNo.Trim + "," + m_strProjectID.Trim
        Else
            strSQL = "usp_Sel_tbl_PM_InvoiceDetails_TeamBilling NULL," + m_strProjectID.Trim
        End If

        'plot the grid 
        General.WriteHTML("<Div id='PageDiv' width=100% style='overflow:auto;'>")
        General.WriteHTML("<Table width=99.9% class='clsTable' cellpadding=0 cellspacing=0>")

        'display column headers
        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_RESOURCE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_FROM_DATE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_TO_DATE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_MONTHLY_FEE") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_BILLING") + "</TD>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("COL_EXCLUDE") + "</TD>")
        General.WriteHTML("</TR>")

        'create client side script to fill the array
        strClientSideScript = ""
        'get the data and display
        intRowCount = 0
        intCntr = 0
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDr.Read
            blnRecordFound = True

            strInvoiceDetailID = Data.CheckIsDBNull(objDr("InvoiceDetailID"), "0").ToString
            strEmployeeID = Data.CheckIsDBNull(objDr("EmployeeID"), "0").ToString
            strResourcePercentage = Data.CheckIsDBNull(objDr("ResourcePercentage"), "0").ToString
            strFromDate = Dates.GetDate(CType(objDr("FromDate"), Date)) + ""
            strToDate = Dates.GetDate(CType(objDr("ToDate"), Date)) + ""

            If Not (m_strInvoiceNo <> "" And strInvoiceDetailID = "0") Then

                'create client side array and SQL to get the data to fill the array
                'records will be taken for each employeeID
                strSQL = "SELECT A.EmployeeID, A.FromDate, A.ToDate FROM tbl_PM_InvoiceDetails A LEFT OUTER JOIN tbl_PM_Invoice B ON A.InvoiceNo = B.InvoiceNo "
                strSQL += "WHERE A.ProjectID = " + m_strProjectID.Trim + " AND A.EmployeeID = " + strEmployeeID + " "
                strSQL += " AND B.InvoiceType = 'F' AND A.InvoiceNo <> "
                If m_strInvoiceNo <> "" Then
                    strSQL += m_strInvoiceNo
                Else
                    strSQL += "0"
                End If

                objDrInvoiceDate = Data.GetDataReader(strSQL, MyBase.UseSQL)
                While objDrInvoiceDate.Read
                    strClientSideScript += "strDateArray[" + intCntr.ToString + "][0]='" + Data.CheckIsDBNull(objDrInvoiceDate("EmployeeID"), "").ToString + "';"
                    strClientSideScript += "strDateArray[" + intCntr.ToString + "][1]='" + Dates.GetDate(CType(objDrInvoiceDate("FromDate"), Date)) + "';"
                    strClientSideScript += "strDateArray[" + intCntr.ToString + "][2]='" + Dates.GetDate(CType(objDrInvoiceDate("ToDate"), Date)) + "';" + vbCrLf
                    intCntr += 1
                End While
                Data.DisposeDataReader(objDrInvoiceDate)

                If intRowCount Mod 2 = 0 Then
                    General.WriteHTML("<TR class='clsTROdd'>")
                Else
                    General.WriteHTML("<TR class='clsTREven'>")
                End If

                General.WriteHTML("<TD align='left'>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                General.WriteHTML(HTMLControls.DrawTextBox("txtResourcePercentage" + strEmployeeID, "txtResourcePercentage", , , , strResourcePercentage, , , , , , True, , True, EnableHTMLEncode:=True))
                General.WriteHTML(HTMLControls.DrawTextBox("txtInvoiceDetailID" + strEmployeeID, "txtInvoiceDetailID", , , , strInvoiceDetailID, , , , , , True, , True, EnableHTMLEncode:=True))
                General.WriteHTML(HTMLControls.DrawTextBox("txtEmployeeID", "txtEmployeeID", , , , strEmployeeID, , , , , , True, , True, EnableHTMLEncode:=True))
                General.WriteHTML(HTMLControls.DrawTextBox("txtUserName" + strEmployeeID, "txtUserName", , , , Data.CheckIsDBNull(objDr("UserName"), "").ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                General.WriteHTML(Data.CheckIsDBNull(objDr("UserName"), "").ToString)
                General.WriteHTML("</TD>")

                General.WriteHTML("<TD align='left'>")
                General.WriteHTML(HTMLControls.DrawDateControl("txtFromDate" + strEmployeeID, "txtFromDate" + strEmployeeID, , 80, strFromDate, , "frmFA_TeamBilling", , , , , True, , True, True))
                General.WriteHTML("</TD>")

                General.WriteHTML("<TD align='left'>")
                General.WriteHTML(HTMLControls.DrawDateControl("txtToDate" + strEmployeeID, "txtToDate" + strEmployeeID, , 80, strToDate, , "frmFA_TeamBilling", , , , , True, , True, True))
                General.WriteHTML("</TD>")

                General.WriteHTML("<TD align='left'>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                General.WriteHTML(HTMLControls.DrawTextBox("txtMonthlyFee" + strEmployeeID, "txtMonthlyFee", , 100, 10, Data.CheckIsDBNull(objDr("MonthlyFee"), "").ToString, "right", , , , , , , True, True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                General.WriteHTML("</TD>")

                General.WriteHTML("<TD align='left'>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                General.WriteHTML(HTMLControls.DrawTextBox("txtBillingPercentage" + strEmployeeID, "txtBillingPercentage", , 100, 10, Data.CheckIsDBNull(objDr("Billingpercentage"), "").ToString, "right", , , , , , , True, True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                General.WriteHTML("</TD>")

                General.WriteHTML("<TD align='center'>")
                blnIsChecked = False
                If m_strInvoiceNo <> "" And strInvoiceDetailID = "" Then blnIsChecked = True
                General.WriteHTML(HTMLControls.DrawCheckBox("chkExclude" + strEmployeeID, "chkExclude", , blnIsChecked, strEmployeeID, , , True))
                General.WriteHTML("</TD>")

                General.WriteHTML("</TR>")
                intRowCount += 1
            End If
        End While
        Data.DisposeDataReader(objDr)

        If blnRecordFound = False Then
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='center' colspan=6 >" + MyBase.GetResourceString("MSG_NODATAFOUND") + "</TD>")
            General.WriteHTML("</TR>")
        End If
        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

        'write client side script to declare and fill the array
        General.WriteHTML("<Script language=javascript>")
        General.WriteHTML("var i;")
        General.WriteHTML("var strDateArray = new Array(" + intCntr.ToString + ");")
        General.WriteHTML("for(i=0;i<" + intCntr.ToString + ";i++)")
        General.WriteHTML("{ strDateArray[i] = new Array(3); }")
        General.WriteHTML(strClientSideScript)
        General.WriteHTML("</Script>")

    End Sub

    '=====================================================================
    ' Procedure Name		:	performInvoiceAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To perform the action.
    ' Description			:	Here data will be updated to insert new invoice or update
    '                           exsiting invoice.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 19 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performInvoiceAction()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strTemp As String
        Dim arrEmpID() As String
        Dim strInvoiceDetailID As String
        Dim strEmpID As String
        Dim strFromDate As String
        Dim strToDate As String
        Dim dblResourcePercentage As Double
        Dim dblBillingPercentage As Double
        Dim dblMonthlyFee As Double
        Dim dblBilledHours As Double
        Dim dblTotalHours As Double
        Dim dblAmount As Double

        Select Case m_strAction.ToUpper

            Case CONST_ACTION_SAVE

                'insert new invoice as no invoice no is given
                If m_strInvoiceNo = "" Then
                    strSQL = "usp_Ins_tbl_PM_Invoice_TeamBilling " + m_strProjectID.Trim + "," + m_strUserID.Trim
                    objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If objDr.Read Then
                        m_strInvoiceNo = Data.CheckIsDBNull(objDr("InvoiceNo"), "").ToString
                    End If
                    Data.DisposeDataReader(objDr)
                End If

                dblResourcePercentage = 0.0
                dblBilledHours = 0.0
                dblTotalHours = 0.0

                'insert invoice details
                If m_strInvoiceNo <> "" Then

                    strTemp = MyBase.GetFormValue("txtEmployeeID") + ""
                    If strTemp <> "" Then

                        arrEmpID = Split(strTemp, ",")

                        Dim i As Integer
                        For i = 0 To arrEmpID.Length - 1

                            strEmpID = arrEmpID(i).Trim + ""
                            strInvoiceDetailID = MyBase.GetFormValue("txtInvoiceDetailID" + strEmpID) + ""

                            ' If the invoice detail item should be included in the invoice, then...
                            If MyBase.GetFormValue("chkExclude" + strEmpID.Trim) = "" Then

                                strFromDate = MyBase.GetFormValue("txtFromDate" + strEmpID) + ""
                                strToDate = MyBase.GetFormValue("txtToDate" + strEmpID) + ""
                                dblResourcePercentage = CType(MyBase.GetFormValue("txtResourcePercentage" + strEmpID), Double)
                                dblBillingPercentage = CType(MyBase.GetFormValue("txtBillingPercentage" + strEmpID), Double)
                                dblMonthlyFee = CType(MyBase.GetFormValue("txtMonthlyFee" + strEmpID), Double)

                                strSQL = "usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " + strEmpID.Trim + ",NULL,NULL,NULL,'" + strFromDate + "','" + strToDate + "',NULL,1,1"
                                objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
                                If objDr.Read Then
                                    dblTotalHours = CType(Data.CheckIsDBNull(objDr("TotalHours"), "0"), Double)
                                    dblBilledHours = (dblTotalHours * dblResourcePercentage) / 100
                                End If
                                Data.DisposeDataReader(objDr)

                                dblAmount = (dblMonthlyFee * dblBillingPercentage) / 100
                                dblAmount = Math.Round(dblAmount, 2)

                                ' Build the Insert/Update Query.
                                strSQL = "usp_Ins_tbl_PM_InvoiceDetails_TeamBilling "
                                If strInvoiceDetailID = "" Or strInvoiceDetailID = "0" Then
                                    strSQL += "NULL"
                                Else
                                    strSQL += strInvoiceDetailID.Trim
                                End If
                                strSQL += "," + m_strInvoiceNo.Trim + "," + m_strProjectID.Trim + "," + strEmpID + "," + dblMonthlyFee.ToString + "," + dblBilledHours.ToString
                                strSQL += "," + dblAmount.ToString + "," + dblBillingPercentage.ToString + ",'" + strFromDate + "','" + strToDate + "'"

                                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                            Else
                                ' If the invoice detail item should be excluded from the invoice, then...
                                If strInvoiceDetailID <> "0" And strInvoiceDetailID <> "" Then
                                    strSQL = "usp_Del_tbl_PM_InvoiceDetails_TeamBilling " + strInvoiceDetailID.Trim
                                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                                End If
                            End If

                        Next

                    End If
                End If

        End Select
    End Sub

End Class
