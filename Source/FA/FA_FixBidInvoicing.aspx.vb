Public Class FA_FixBidInvoicing
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

#Region " Constants Used in the Class "
    Private Const HELPID As Integer = 381
    Protected Const MODE_LIST As String = "List"
    Protected Const MODE_DETAILS As String = "Details"

    Protected Const ACTION_MILESTONE As String = "Milestone"
    Protected Const ACTION_SAVE As String = "Save"

    Private Enum MenuIndex
        NEW_INVOICE
        SENDMAIL
        NEW_MENUITEM
        SAVE
        BACK
        HELP
    End Enum
    Private Const NUMBER_OF_MENUITEMS As Integer = 6
#End Region

#Region " Class scope Variables Declarations "
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Protected m_strMode As String = ""
    Private m_strAction As String = ""
    Private m_blnSendMail As Boolean = False
    Private m_blnShowPopup As Boolean = False
    Protected m_lngTagId As Long = 0
    Private m_lngProjectId As Long = 0

    'Invoice Information
    Protected m_lngInvoiceId As Long = 0
    Private m_strInvoiceNo As String = ""
    Private m_strDescription As String = ""
    Private m_strAmount As String = ""
    Private m_strDiscount As String = ""
    Private m_lngMilestoneId As Long = 0
    Private m_strDate As String = ""
    Private m_strMilestoneDetails As String = ""
#End Region

#Region " Page Events "
    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim strToEmailID As String = ""
        Dim strCCToEmailID As String = ""
        Dim strFromEmailID As String = ""
        Dim strSubject As String = ""
        Dim strEmailMessage As String = ""

        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        InitPageMenu()

        m_lngTagId = m_objGlobal.TagID
        m_lngProjectId = m_objGlobal.ProjectID
        m_lngInvoiceId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("InvoiceId"), "0"), Long)
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).Trim()
        If m_strMode = "" Then m_strMode = MODE_LIST
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action")).Trim()

        GetSendMailInformation()

        If m_strMode = MODE_DETAILS Then
            GetInvoiceInformation()
            If m_strAction = ACTION_SAVE Then
                SaveInvoiceInformation()
                If m_blnSendMail = True And m_blnShowPopup = False Then
                    CommonFunction.EmailMessages.FAMessages.GetEmailMessage_2(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_lngInvoiceId)
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
                m_strAction = ""
                GetInvoiceInformation()
            ElseIf m_strAction = ACTION_MILESTONE Then
                GetMilestoneInformation()
            End If
        End If
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objMenu = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "FA_FixBidInvoicing : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.NEW_INVOICE) = MyBase.GetResourceString("MENU_NEW_INVOICE")
        m_arrMenuTooltip(MenuIndex.NEW_INVOICE) = MyBase.GetResourceString("MENU_NEW_INVOICE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.NEW_INVOICE) = "NewInvoice_OnClick()"

        m_arrMenuItem(MenuIndex.SENDMAIL) = MyBase.GetResourceString("MENU_SEND_EMAIL")
        m_arrMenuTooltip(MenuIndex.SENDMAIL) = MyBase.GetResourceString("MENU_SEND_EMAIL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SENDMAIL) = "SendMail_OnClick()"

        m_arrMenuItem(MenuIndex.NEW_MENUITEM) = MyBase.GetResourceString("MENU_NEW")
        m_arrMenuTooltip(MenuIndex.NEW_MENUITEM) = MyBase.GetResourceString("MENU_NEW_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.NEW_MENUITEM) = "NewInvoice_OnClick()"

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK")
        m_arrMenuTooltip(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.BACK) = "Back_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick(" & HELPID.ToString() & ")"

        MyBase.InitializeResources("AppResources.FA_FixBidInvoicing", "AppResources")
    End Sub

    Private Sub WritePageLegend()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub

    Public Sub PageInit()
        Dim strMenu As String = ""
        Dim strPageCaption As String = ""
        Dim objHeaderFooter As WebPages.Template.HeaderFooter

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)

        'Display Page Caption
        If m_strMode = MODE_LIST Then
            strPageCaption = MyBase.GetResourceString("LIST_OF_FIX_BID_INVOICES")
            CommonFunctions.General.WriteHTML("<BR>")
        ElseIf m_strMode = MODE_DETAILS Then
            'Display the Page Legend
            WritePageLegend()
            strPageCaption = MyBase.GetResourceString("INVOICE_GENERATION_PROJECT")
        End If
        strPageCaption &= " " & CommonFunctions.General.CheckIsNothing(Session.Item("strProjectName"))
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, strPageCaption, , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        If m_strMode = MODE_LIST Then
            'Display the Page Header
            objHeaderFooter = New WebPages.Template.HeaderFooter
            objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
            objHeaderFooter.DrawHeaderFooter(m_objGlobal)
            objHeaderFooter = Nothing
            CommonFunctions.General.WriteHTML("<br>")
        End If

        'Display the Page Body
        If m_strMode = MODE_LIST Then
            DisplayInvoiceList()
        ElseIf m_strMode = MODE_DETAILS Then
            CommonFunctions.General.WriteHTML("<DIV Id='PageDiv' Style='Overflow:auto;width:100%'>")
            DisplayInvoiceDetails()
            If m_strAction = ACTION_MILESTONE Then                
                CommonFunctions.General.WriteHTML("<BR><BR><TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'>")
                CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD>" & MyBase.GetResourceString("MILESTONE_DETAILS") & "</TD></TR>")
                CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>")
                CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strMilestoneDetails))
                CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")
            End If

            CommonFunctions.General.WriteHTML("</DIV>")
        End If

        If m_strMode = MODE_LIST Then
            'Display the Page Footer
            objHeaderFooter = New WebPages.Template.HeaderFooter
            objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
            objHeaderFooter.DrawHeaderFooter(m_objGlobal)
            objHeaderFooter = Nothing
        End If

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
    End Sub

    Private Sub DisplayInvoiceList()
        '==================================================================================
        ' Procedure Name	:	DisplayInvoiceList
        ' Purpose			:	This procedure displays the List of Fix Bid Invoices. 
        ' Description		:	Used the Generic Grid Object to display the List of Invoices.
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	18-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim arrActualColumns() As String = {"CustomerInvoiceNo", "InvoiceDate", "Description", "Amount", "Paid"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("INVOICE_NO"), _
                                                 MyBase.GetResourceString("DATE"), _
                                                 MyBase.GetResourceString("DESCRIPTION"), _
                                                 MyBase.GetResourceString("AMOUNT") & " $", _
                                                 MyBase.GetResourceString("STATUS")}

        Dim arrRowLink() As String = {"Invoice_OnClick(InvoiceNo)", ""}
        Dim arrTDStyle() As String = {"valign=top", "valign=top NOWRAP", "width='50%'", "align=right valign=top", "valign=top"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        If m_lngProjectId > 0 Then
            'Get the Query to plot the Grid
            strQuery = "EXEC usp_Sel_tbl_PM_Invoice_Project " & m_lngProjectId.ToString()

            'Set the Grid Properties
            With m_objGrid
                .UserFriendlyColumnArray = arrUserFriendlyColumn
                .ActualColumnArray = arrActualColumns
                .RowLinkArray = arrRowLink
                .TDStyleArray = arrTDStyle
                .PrimaryKey = "InvoiceNo"
                .SQL = strQuery
                .UseSQL = MyBase.UseSQL
                .DIVID = "PageDiv"
                .DIVHeight = 420
                .DIVStyle = "overflow:auto;width:100%"
                .NoOfDataColumns = 5
                .EmptyValueReplacement = "&nbsp;"
                .returnHTML = True
                'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                CommonFunctions.General.WriteHTML(.DrawGrid())
            End With
        Else
            CommonFunctions.General.WriteHTML("<DIV Id='PageDiv' Style='Overflow:auto;width:100%'>")
            CommonFunctions.General.WriteHTML("<TABLE class=clsTable width='99.9%' cellpadding=0 cellspacing=0>")
            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD align=center>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECT_PROJECT"))
            CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("</DIV>")
        End If
    End Sub

    Private Sub DisplayInvoiceDetails()
        '==================================================================================
        ' Procedure Name	:	DisplayInvoiceDetails
        ' Purpose			:	This procedure display the Deails of the Information. 
        ' Description		:	The information is shown in Add new and in Update mode.
        '                       If rights allowed then the User can able to add new or modify the existing,
        '                       Invoice.
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	18-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String

        CommonFunctions.General.WriteHTML("<TABLE class='clsTable' cellspacing=0 cellpadding=0 width=99.9%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align='right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("INVOICE_NO"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtInvoiceNo", "txtInvoiceNo", , 290, , m_strInvoiceNo, IsReadonly:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD align='right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DATE"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtDate", "txtDate", , 80, , m_strDate, IsReadonly:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align='right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECT_MILESTONE"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD colspan=3>")
        If m_strAction = ACTION_MILESTONE Or m_lngInvoiceId = 0 Then
            strQuery = "EXEC usp_Sel_tbl_PM_Milestones_Project " & m_lngProjectId.ToString() & ", NULL"
            CommonFunctions.HTMLControls.DrawComboBox("cboMileStoneID", strQuery, 290, m_lngMilestoneId.ToString(), "OnChange=MileStoneChange()", True, , , True)
        Else
            strQuery = "EXEC usp_Sel_tbl_PM_Milestones_Project " & m_lngProjectId.ToString() & ", 1"
            CommonFunctions.HTMLControls.DrawComboBox("cboMileStoneID", strQuery, 290, m_lngMilestoneId.ToString(), "disabled", True, , , True)
        End If
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top align='right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DESCRIPTION"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", widthInPixel:=290, heightInPixel:=50, value:=m_strDescription, IsMandatory:=True)
        CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", widthInPixel:=290, heightInPixel:=50, value:=m_strDescription, IsMandatory:=True, EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD valign=top align='right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("AMOUNT") & "($)")
        CommonFunctions.General.WriteHTML("<BR><BR><BR>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DISCOUNT") & "(%)")
        CommonFunctions.General.WriteHTML("<TD valign=top>")
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtAmount", "txtAmount", , 70, 8, m_strAmount, "Right", IsMandatory:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML("<BR><BR>")
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtDiscount", "txtDiscount", , 70, 8, m_strDiscount, "Right", EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub

#Region " Database Related Procedures "
    Private Sub GetSendMailInformation()
        '==================================================================================
        ' Procedure Name	:	GetSendMailInformation
        ' Purpose			:	This procedure Fetches the Two Flags related to Email messages from Database. 
        ' Description		:	The Flags are 'Send Mails' and 'Show Popup'.
        '                       These falgs are used to send the mails. And also to show the 
        '                       'Send Mail' Menu link.
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	18-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim drEmail As IDataReader

        strQuery = "usp_Sel_tbl_PM_EmailMessages 2"
        drEmail = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
            If drEmail.Read() Then
                m_blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                m_blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmail)
    End Sub

    Private Sub GetMilestoneInformation()
        '==================================================================================
        ' Procedure Name	:	GetMilestoneInformation
        ' Purpose			:	This procedure Fetches the milestone related information from the Database.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	18-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim drMilestone As IDataReader

        strQuery = "Exec usp_Sel_tbl_PM_MileStone " & m_lngMilestoneId.ToString()
        drMilestone = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drMilestone) <> "" Then
            If drMilestone.Read() Then
                m_strAmount = drMilestone.Item("BillAmount").ToString()
                m_strMilestoneDetails = drMilestone.Item("Comments").ToString()
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drMilestone)
    End Sub

    Private Sub GetInvoiceInformation()
        '==================================================================================
        ' Procedure Name	:	GetInvoiceInformation
        ' Purpose			:	This procedure Fetches the invoice related information from the Database.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	18-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim drInvoice As IDataReader

        If m_strAction = ACTION_SAVE Then
            m_strInvoiceNo = MyBase.FixString(MyBase.GetFormValue("txtInvoiceNo"), 0, False, True)
            m_strInvoiceNo = CommonFunctions.General.UnBuildQueryString(m_strInvoiceNo)
            m_strDescription = MyBase.FixString(MyBase.GetFormValue("txtDescription"), 200, False, True)
            m_strDescription = CommonFunctions.General.UnBuildQueryString(m_strDescription)
            m_strAmount = MyBase.FixString(MyBase.GetFormValue("txtAmount"), 0, True, True)
            m_strDiscount = MyBase.FixString(MyBase.GetFormValue("txtDiscount"), 0, False, False)
            m_lngMilestoneId = CType(MyBase.FixString(MyBase.GetFormValue("cboMileStoneID"), 0, True, True), Long)
            m_strDate = MyBase.FixString(MyBase.GetFormValue("txtDate"), 0, False, False)
        Else
            If m_lngInvoiceId = 0 Then
                m_strInvoiceNo = ""
                m_strDescription = ""
                m_strAmount = ""
                m_strDiscount = ""
                If m_strAction = ACTION_MILESTONE Then
                    m_lngMilestoneId = CType(MyBase.FixString(MyBase.GetFormValue("cboMileStoneID"), 0, True, True), Long)
                Else
                    m_lngMilestoneId = 0
                End If
                m_strDate = CommonFunctions.Dates.GetDate(Now())
            Else
                strQuery = "EXEC usp_Sel_tbl_PM_Invoice_InvoiceWise " & m_lngInvoiceId.ToString()
                drInvoice = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drInvoice) <> "" Then
                    If drInvoice.Read() Then
                        m_strInvoiceNo = drInvoice.Item("CustomerInvoiceNo").ToString()
                        m_strInvoiceNo = CommonFunctions.General.UnBuildQueryString(m_strInvoiceNo)
                        m_strDescription = drInvoice.Item("Description").ToString()
                        m_strDescription = CommonFunctions.General.UnBuildQueryString(m_strDescription)
                        m_strAmount = drInvoice.Item("Amount").ToString()
                        m_strDiscount = drInvoice.Item("Discount").ToString()
                        m_lngMilestoneId = CType(CommonFunctions.Data.CheckIsDBNull(drInvoice.Item("MileStoneID"), "0"), Long)
                        m_strDate = CommonFunctions.Data.CheckIsDBNull(drInvoice.Item("InvoiceDate")).ToString()
                        If m_strDate <> "" Then
                            m_strDate = CommonFunctions.Dates.GetDate(CType(m_strDate, Date))
                        End If
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drInvoice)
            End If
        End If
    End Sub

    Private Sub SaveInvoiceInformation()
        '==================================================================================
        ' Procedure Name	:	SaveInvoiceInformation
        ' Purpose			:	This procedure stores the invoice details in the Database.
        ' Description		:	Depending upon the invoice id, the details are inserted or updated.
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	18-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim drInvoice As IDataReader

        If m_lngInvoiceId = 0 Then
            strQuery = "EXEC usp_Ins_tbl_PM_Invoice_FixBid " & m_strAmount
            If m_lngMilestoneId = 0 Then
                strQuery &= ", NULL"
            Else
                strQuery &= ", " & m_lngMilestoneId.ToString()
            End If
            strQuery &= ", " & m_lngProjectId.ToString()
            If m_strDiscount = "" Then m_strDiscount = "0"
            strQuery &= ", " & m_strDiscount
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strDescription) & "'"
            strQuery &= ", " & m_objGlobal.UserID.ToString()
            drInvoice = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drInvoice) <> "" Then
                If drInvoice.Read() Then
                    m_strInvoiceNo = drInvoice.Item(0).ToString()
                    m_lngInvoiceId = CType(CommonFunctions.Data.CheckIsDBNull(drInvoice.Item(1)), Long)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drInvoice)
        Else
            strQuery = "EXEC usp_Upd_tbl_PM_Invoice_FixBid " & m_lngInvoiceId.ToString()
            strQuery &= ", " & m_strAmount
            If m_strDiscount = "" Then m_strDiscount = "0"
            strQuery &= ", " & m_strDiscount
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strDescription) & "'"
            If m_lngMilestoneId = 0 Then
                strQuery &= ", NULL"
            Else
                strQuery &= ", " & m_lngMilestoneId.ToString()
            End If
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If
    End Sub
#End Region

#Region " Grid / Menu Event Handlers "
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        Select Case Args.MenuColIndex
            Case MenuIndex.NEW_INVOICE
                If m_strMode <> MODE_LIST Then
                    Cancel = True
                ElseIf m_objAccessRights.Add = False Then
                    Cancel = True
                End If

            Case MenuIndex.NEW_MENUITEM
                If m_strMode = MODE_LIST Then
                    Cancel = True
                Else
                    If m_objAccessRights.Add = False Then Cancel = True
                End If

            Case MenuIndex.SENDMAIL
                If m_strMode = MODE_LIST Then
                    Cancel = True
                Else
                    If m_lngInvoiceId = 0 Or m_strAction = ACTION_MILESTONE Then
                        Cancel = True
                    Else
                        If m_blnSendMail = False Or m_blnShowPopup = False Then Cancel = True
                    End If
                End If

            Case MenuIndex.SAVE
                If m_strMode = MODE_LIST Then
                    Cancel = True
                Else
                    If (((m_lngInvoiceId <> 0 Or m_strAction <> ACTION_MILESTONE Or m_strAction <> ACTION_SAVE) And m_objAccessRights.Edit = True) Or _
                                        ((m_lngInvoiceId = 0 Or m_strAction = ACTION_MILESTONE Or m_strAction = ACTION_SAVE) And m_objAccessRights.Add = True)) Then
                    Else
                        Cancel = True
                    End If
                End If

            Case MenuIndex.BACK
                If m_strMode = MODE_LIST Then
                    Cancel = True
                End If

            Case MenuIndex.HELP
                'Nothing
        End Select
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 3 Then   'Amount
            Args.DataFieldValue = FormatCurrency(Args.DataFieldValue, 2)
        End If
    End Sub
#End Region

End Class
