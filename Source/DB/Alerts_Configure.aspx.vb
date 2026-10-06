'Imports System.Globalization

Public Class Alerts_Configure
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region


    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu

    Private m_blnUseSQL As Boolean
    Private m_Emailid As String = ""
    Dim m_blnTask As Integer
    Dim m_blnReview As Integer
    Dim m_blnHelpRequest As Integer
    Dim m_blnDeliverable As Integer
    Dim m_Task As Integer
    Dim m_Review As Integer
    Dim m_HelpRequest As Integer
    Dim m_Deliverable As Integer

    'Added by MrugajaB on 3rd Jan 2006 for Whiziblesem SP9 
    Dim m_CustomerFlag As Integer
    Protected m_strCustomers As String
    Dim m_blnHelpRequestAfterFlag As Integer
    Dim m_intHelpRequestAfterDays As Integer
    Protected m_lngEntryID As Long
    Protected m_PKToken As String

    'End Addition

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        m_blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

        If Request.QueryString("Action") = "Save" Then

            m_blnTask = CType(Request.QueryString("Task"), Integer)
            m_blnReview = CType(Request.QueryString("Review"), Integer)
            m_blnHelpRequest = CType(Request.QueryString("HelpRequest"), Integer)
            m_blnDeliverable = CType(Request.QueryString("Deliverable"), Integer)

            m_Task = CType(Request.Form("txtTask"), Integer)
            m_Review = CType(Request.Form("txtReview"), Integer)
            m_HelpRequest = CType(Request.Form("txtHelpRequest"), Integer)
            m_Deliverable = CType(Request.Form("txtDeliverable"), Integer)

            'Added by MrugajaB on 3rd Jan 2006 for Whiziblesem SP9 
            m_CustomerFlag = CType(Request.QueryString("Customer"), Integer)
            m_strCustomers = CType(Request.Form("lstCustomer"), String)
            m_blnHelpRequestAfterFlag = CType(Request.QueryString("HelpRequestAfterFlag"), Integer)
            m_intHelpRequestAfterDays = CType(Request.Form("txtHelpRequestAfter"), Integer)

            'End Addition

            SaveDetails()
        End If

        'Added by MrugajaB on 9th Jan 2006
        MyBase.InitializeResources("AppResources.Alerts_Configure", "AppResources")
        'End Addition

    End Sub

    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To Set AlertsDays For Employees
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SrikanthY
        ' Created               : 05 Dec 2006
        ' Revisions             :
        '=====================================================================

        Dim strMenu As String
        Dim drEmail As IDataReader
        Dim drProjectCount As IDataReader
        Dim blnComplete As Boolean
        Dim DueDate As Date
        Dim FlagTo As String = ""
        Dim strContextType As String = ""
        Dim lngContextID As Long
        Dim ConId As Long
        Dim ConType As String

        drEmail = CommonFunctions.Data.GetDataReader("USP_SEL_EMAIL_TBL_PM_EMPLOYEE " + CType(Session("intUserID"), String), m_blnUseSQL)
        If drEmail.Read Then
            m_Emailid = CType(drEmail("Emailid"), String)
        End If


        drProjectCount = CommonFunctions.Data.GetDataReader("USP_SEL_TBL_PM_FLAGFORTRACKING_CONFIGURE " + CType(Session("intUserID"), String), m_blnUseSQL)
        If drProjectCount.Read Then

            m_blnTask = CType(drProjectCount("TaskAlertFlag"), Integer)
            m_blnReview = CType(drProjectCount("ReviewAlertFlag"), Integer)
            m_blnHelpRequest = CType(drProjectCount("HelpRequestAlertFlag"), Integer)
            m_blnDeliverable = CType(drProjectCount("DeliverableAlertFlag"), Integer)

            m_Task = CType(drProjectCount("TaskAlertDays"), Integer)
            m_Review = CType(drProjectCount("ReviewAlertDays"), Integer)
            m_HelpRequest = CType(drProjectCount("HelpRequestAlertDays"), Integer)
            m_Deliverable = CType(drProjectCount("DeliverableAlertDays"), Integer)

            'Added by MrugajaB on 3rd Jan 2006 for Whiziblesem SP9 
            m_CustomerFlag = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("CustomerFlag"), "0"), Integer)
            m_strCustomers = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("CustomerID"), ""), String)

            m_blnHelpRequestAfterFlag = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("HelpRequestAfterFlag"), "0"), Integer)
            m_intHelpRequestAfterDays = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("HelpRequestAfterDays"), "0"), Integer)
            m_lngEntryID = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("EntryID"), "0"), Long)
            'End Addition

        Else

            m_blnTask = 0
            m_blnReview = 0
            m_blnHelpRequest = 0
            m_blnDeliverable = 0

            m_Task = 0
            m_Review = 0
            m_HelpRequest = 0
            m_Deliverable = 0

            'Added by MrugajaB on 3rd Jan 2006 for Whiziblesem SP9 
            m_CustomerFlag = 0
            m_strCustomers = ""
            m_blnHelpRequestAfterFlag = 0
            m_intHelpRequestAfterDays = 0
            m_lngEntryID = 0
            'End Addition
        End If
        ''added by Nilesh g on 3/3/2016 for add PKtoken
        m_PKToken = CommonFunctions.Security.Token.GetToken(CType(m_lngEntryID, String) + CType(m_strCustomers, String) + "0" + "0")
        ''END OF added by Nilesh g on 3/3/2016 for add PKtoken
        Dim arrMenu() As String = {"Save", "Close", "?"}
        Dim arrMenuToolTip() As String = {"Save Alert Details", "Close", "Help"}
        Dim arrCSFunction() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick('Set_Alerts')"}
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)

        With Response
            .Write(strMenu)
            .Write("<BR>")
            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Set Alerts"))
            .Write("<BR>")
            .Write("<div id=divList style='overflow:auto'>")
            .Write("<Table class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)

            .Write("<TR class=clsTREven>")
            .Write("<TD align=Left>Send me the Following Alerts on - " + m_Emailid + "")
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR><TD></TD></TR>")


            .Write("</TABLE>")

            'Added by MrugajaB on 9th Jan 2006

            .Write("<BR>")
            'End Addition

            '.Write("<BR>")

            '******************************************************************************************************
            'Information section for Issue list page
            Dim cObjHelpRequestSectionTitle As New WebPage.Templates.SectionTitle

            With cObjHelpRequestSectionTitle
                'display current Issue ID
                Response.Write(.GetSectionTitle("Help-Desk Related Alerts", "DivHelpRequest", "ShowHideHelpRequest", , "", AllowHideShow:=False))

                'Write ClientsideScript in order to show hide the section
                Response.Write("<SCRIPT Language=javascript>")
                Response.Write(.ClientsideScript)
                Response.Write("</SCRIPT>")
            End With

            .Write("<div id=DivHelpRequest style='overflow:auto'>")
            .Write("<Table class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)


            'Code Added By PradipK on  10 Jan 2007
            'If User has access of EDB then only he can set follwing settings
            ' 1) Alert me immidiately when Help Request is entered by
            ' 2) Alert me if help request from above selected requestor is not resolved/closed

            Dim strsql As String
            Dim blnIsuserAccessEDB As Boolean
            'strsql = "If Exists (Select Top 1 CRMID  from tbl_CRM_Function_CRMs WHERE CRMID=" + CType(Session("intUserID"), String) + ")  select 1  else select 0"
            strsql = "select CRMID from tbl_CRM_Function_CRMS "
            strsql += " WHERE CRMID =" + CType(Session("intUserID"), String)
            strsql += " UNION ALL select departmentHeadID from tbl_pm_departmentmaster Where departmentHeadID = " + CType(Session("intUserID"), String)
            'Code added by PrashantD on 29 May 2007 for CleanUp Activity
            strsql += " UNION ALL  SELECT EmployeeID FROM tbl_CRM_EmployeeAccess WHERE EmployeeID = " + CType(Session("intUserID"), String) + " AND ISNULL(AllowToSeeDashboard,0) = 1"
            'End of addition by PrashantD on 29 May 2007 for CleanUp Activity

            Dim drViewAccess As IDataReader
            drViewAccess = CommonFunctions.Data.GetDataReader(strsql, m_blnUseSQL)
            If drViewAccess.Read Then
                blnIsuserAccessEDB = True
            Else
                blnIsuserAccessEDB = False
            End If
            CommonFunctions.Data.DisposeDataReader(drViewAccess)

            If blnIsuserAccessEDB = True Then

                'Added by MrugajaB on 3rd Jan 2006 for Whiziblesem SP9 
                Response.Write("<TR class=clsTREven><TD>")
                'Added And Commented By Vidya J On 30-11-2015
                'CommonFunctions.HTMLControls.DrawCheckBox("chkCustomer", "chkCustomer", , CType(m_CustomerFlag, Boolean), , , " onpropertychange=""Javascript:chkCustomer_Change()"" ", , , , , , )
                CommonFunctions.HTMLControls.DrawCheckBox("chkCustomer", "chkCustomer", , CType(m_CustomerFlag, Boolean), , , " onchange=""Javascript:chkCustomer_Change()"" ", , , , , , )
                'End Of Added And Commented By Vidya J On 30-11-2015
                Response.Write("&nbsp")

                ''''.Write("Customer </TD>")

                'Added by MrugajaB on 9th Jan 2006
                Response.Write(MyBase.GetResourceString("ALERT_ME_IMMEDIATELY"))
                'End Addition

                If CType(m_CustomerFlag, Boolean) = True Then
                    Response.Write("<TD>")
                    'CommonFunctions.HTMLControls.DrawListBox("lstCustomer", "SELECT CustomerID,CustomerID FROM tbl_PM_Customer", , , m_strCustomers, , False, , "clsComboBox", False, , False)
                    'Response.Write("<A href=""JavaScript:Customer_OnClick()") ' + CType(Args.DataReader("EmployeeID"), String) + "','" + CType(Args.DataReader("EmployeeName"), String).Replace("'", "\'") + "','" + CType(Args.DataReader("ResourcePercentage"), String) + "','" + CType(CommonFunctions.Dates.GetDate(CType(Args.DataReader("JoiningDate"), Date)), String) + "'," + CType(HttpContext.Current.Session("PTagID"), Long).ToString + ")"">") + CType(Args.DataReader("UserName"), String) + 
                    'Response.Write("<A href='JavaScript:Customer_OnClick()'>Customers</A></TD>")
                    ''''.Write(" posts support requests. </TD>")

                    Response.Write("<LABEL id=lblCustomers Style='VISIBILITY:visible;'>")
                    Response.Write("<A href='JavaScript:Customer_OnClick()'>Customers</A>")
                    Response.Write("</LABEL>")
                    'Added by PrashantD on 29 May 2007 for CleanUp Activity
                    Response.Write("&nbsp<LABEL id=lblEmployees>")
                    Response.Write("<A href='JavaScript:Employees_OnClick()'>Employees</A>")
                    Response.Write("</LABEL>")
                    Response.Write("</TD>")
                    'End of addition by PrashantD on 29 May 2007
                Else
                    Response.Write("<TD>")
                    Response.Write("<LABEL id=lblCustomers Style='VISIBILITY:hidden;DISPLAY:none'>")
                    Response.Write("<A href='JavaScript:Customer_OnClick()'>Customers</A>")
                    Response.Write("</LABEL>")
                    Response.Write("&nbsp")
                    'Added by PrashantD on 29 May 2007 for CleanUp Activity
                    Response.Write("&nbsp<LABEL id=lblEmployees Style='VISIBILITY:hidden;DISPLAY:none'>")
                    Response.Write("<A href='JavaScript:Employees_OnClick()'>Employees</A>")
                    Response.Write("</LABEL>")
                    Response.Write("</TD>")
                    'End of addition by PrashantD on 29 May 2007

                End If
                
                Response.Write("</TR><TR class=clsTREven><TD>")
                'Added And Commented By Vidya J On 30-11-2015
                ' CommonFunctions.HTMLControls.DrawCheckBox("chkHelpRequestAfterFlag", "chkHelpRequestAfterFlag", , CType(m_blnHelpRequestAfterFlag, Boolean), , , " onpropertychange=""Javascript:chkHelpRequestAfter_Change()"" ", , , , , , )
                CommonFunctions.HTMLControls.DrawCheckBox("chkHelpRequestAfterFlag", "chkHelpRequestAfterFlag", , CType(m_blnHelpRequestAfterFlag, Boolean), , , " onchange=""Javascript:chkHelpRequestAfter_Change()"" ", , , , , , )

                'End Of Added And Commented By Vidya J On 30-11-2015
                Response.Write("&nbsp")
                ''''.Write("Help Request Not Resolved or Closed for </TD>")

                'Added by MrugajaB on 9th Jan 2006
                Response.Write(MyBase.GetResourceString("ALERT_RESOLVED_CLOSED"))
                'End Addition

                If CType(m_blnHelpRequestAfterFlag, Boolean) = True Then
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    'Added and Commented By Vidya J On 30-11-2015
                    ' CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequestAfter", "txtHelpRequestAfter", , 20, 2, CType(m_intHelpRequestAfterDays, String), "Right", , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)

                    CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequestAfter", "txtHelpRequestAfter", , 23, 2, CType(m_intHelpRequestAfterDays, String), "Right", , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                    'End Of Added and Commented By Vidya J On 30-11-2015
                    'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    Response.Write("&nbsp")
                    ''''.Write(" Days Before Planned End Date. </TD>")
                Else
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    'Added and Commented By Vidya J On 30-11-2015
                    '  CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequestAfter", "txtHelpRequestAfter", , 20, 2, CType(m_intHelpRequestAfterDays, String), "Right", , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                    CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequestAfter", "txtHelpRequestAfter", , 23, 2, CType(m_intHelpRequestAfterDays, String), "Right", , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                    'End Of Added and Commented By Vidya J On 30-11-2015
                    'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    Response.Write("&nbsp")
                    ''''.Write(" Days . </TD>")
                End If

                'Added by MrugajaB on 9th Jan 2006
                Response.Write(MyBase.GetResourceString("DAYS"))
                'End Addition

                Response.Write("</TR>")
                'End Addition
            End If

            Response.Write("<TR class=clsTREven><TD>")
            'End Modification
            'Added and Commented By Vidya J On 30-11-2015
            ' CommonFunctions.HTMLControls.DrawCheckBox("chkHelpRequest", "chkHelpRequest", , CType(m_blnHelpRequest, Boolean), , , " onpropertychange=""Javascript:chkHelpRequest_Change()"" ", , , , , , )
            CommonFunctions.HTMLControls.DrawCheckBox("chkHelpRequest", "chkHelpRequest", , CType(m_blnHelpRequest, Boolean), , , " onchange=""Javascript:chkHelpRequest_Change()"" ", , , , , , )
            'End Of Added and Commented By Vidya J On 30-11-2015
            Response.Write("&nbsp")

            'Added by MrugajaB on 9th Jan 2006
            ''''.Write("Help RchkTask_Changeequest </TD>")
            Response.Write(MyBase.GetResourceString("SEND_ME_REMINDER"))
            'End Addition

            If CType(m_blnHelpRequest, Boolean) = True Then
                Response.Write("<TD>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                'Added and Commented By Vidya J On 30-11-2015
                ' CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequest", "txtHelpRequest", , 20, 2, CType(m_HelpRequest, String), "Right", , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)

                CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequest", "txtHelpRequest", , 23, 2, CType(m_HelpRequest, String), "Right", , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                'End Of Added and Commented By Vidya J On 30-11-2015
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                Response.Write("&nbsp")
                ''''.Write(" Days Before Expected Resolved Date. </TD>")
            Else
                Response.Write("<TD>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                'Added and Commented By Vidya J On 30-11-2015
                'CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequest", "txtHelpRequest", , 20, 2, CType(m_HelpRequest, String), "Right", , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequest", "txtHelpRequest", , 23, 2, CType(m_HelpRequest, String), "Right", , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                'End Of Added and Commented By Vidya J On 30-11-2015
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                Response.Write("&nbsp")
                ''''.Write(" Days Before Expected Resolved Date. </TD>")
            End If

            'Added by MrugajaB on 9th Jan 2006
            Response.Write(MyBase.GetResourceString("DAYS"))
            Response.Write(MyBase.GetResourceString("BEFORE_HELPREQUEST_DUE_DATE"))
            'End Addition

            'Modified by MrugajaB on 9th Jan 2006
            ''''.Write("</TR><TR class=clsTREven><TD>")
            Response.Write("</TR>")

            Response.Write("</TABLE>")
            Response.Write("</div>")
            '.Write("<BR>")

            '*******************************************************************************************
            'Information section for Issue list page
            Dim cObjOtherAlertsSectionTitle As New WebPage.Templates.SectionTitle

            With cObjOtherAlertsSectionTitle
                'display current Issue ID
                Response.Write(.GetSectionTitle("Other Alerts", "DivOtherAlerts", "ShowHideOtherAlerts", , "", AllowHideShow:=False))

                'Write ClientsideScript in order to show hide the section
                Response.Write("<SCRIPT Language=javascript>")
                Response.Write(.ClientsideScript)
                Response.Write("</SCRIPT>")
            End With

            .Write("<div id=DivOtherAlerts Style='OverFlow:auto;'>")

            .Write("<Table class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
            .Write("<TR class=clsTREven><TD>")
            'Added And Commented By Vidya J On 30-11-2015
            '  CommonFunctions.HTMLControls.DrawCheckBox("chkTask", "chkTask", , CType(m_blnTask, Boolean), , , " onpropertychange=""Javascript:chkTask_Change()"" ", , , , , , )
            CommonFunctions.HTMLControls.DrawCheckBox("chkTask", "chkTask", , CType(m_blnTask, Boolean), , , " onchange=""Javascript:chkTask_Change()"" ", , , , , , )
            'End Of  Added And Commented By Vidya J On 30-11-2015
            .Write("&nbsp")
            ''''.Write("Task </TD>")

            'Added by MrugajaB on 9th Jan 2006
            .Write(MyBase.GetResourceString("SEND_ME_REMINDER"))
            'End Addition

            If CType(m_blnTask, Boolean) = True Then
                .Write("<TD>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                'Added and Commented By Vidya J On 30-11-2015
                '  CommonFunctions.HTMLControls.DrawTextBox("txtTask", "txtTask", , 20, 2, CType(m_Task, String), "Right", , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtTask", "txtTask", , 23, 2, CType(m_Task, String), "Right", , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                'End Of Added and Commented By Vidya J On 30-11-2015
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .Write("&nbsp")
                ''''.Write(" Days Before Due Date. </TD>")
            Else
                .Write("<TD>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                'Added and Commented By Vidya J On 30-11-2015
                ' CommonFunctions.HTMLControls.DrawTextBox("txtTask", "txtTask", , 20, 2, CType(m_Task, String), "Right", , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtTask", "txtTask", , 23, 2, CType(m_Task, String), "Right", , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                'End Of Added and Commented By Vidya J On 30-11-2015
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .Write("&nbsp")
                ''''.Write(" Days Before Due Date. </TD>")
            End If

            'Added by MrugajaB on 9th Jan 2006
            .Write(MyBase.GetResourceString("DAYS"))
            .Write(MyBase.GetResourceString("BEFORE_TASK_DUE_DATE"))
            'End Addition

            .Write("</TR><TR class=clsTREven><TD>")
            'Added And Commented By Vidya J On 30-11-2015
            ' CommonFunctions.HTMLControls.DrawCheckBox("chkReview", "chkReview", , CType(m_blnReview, Boolean), , , " onpropertychange=""Javascript:chkReview_Change()"" ", , , , , , )
            CommonFunctions.HTMLControls.DrawCheckBox("chkReview", "chkReview", , CType(m_blnReview, Boolean), , , " onchange=""Javascript:chkReview_Change()"" ", , , , , , )
            'End Of Added And Commented By Vidya J On 30-11-2015
            .Write("&nbsp")
            ''''.Write("Review </TD>")

            'Added by MrugajaB on 9th Jan 2006
            .Write(MyBase.GetResourceString("SEND_ME_REMINDER"))
            'End Addition

            If CType(m_blnReview, Boolean) = True Then
                .Write("<TD>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                'Added and Commented By Vidya J On 30-11-2015
                '   CommonFunctions.HTMLControls.DrawTextBox("txtReview", "txtReview", , 20, 2, CType(m_Review, String), "Right", , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtReview", "txtReview", , 23, 2, CType(m_Review, String), "Right", , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                'End Of Added and Commented By Vidya J On 30-11-2015
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .Write("&nbsp")
                ''''.Write(" Days Before Due Date. </TD>")
            Else
                .Write("<TD>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                'Added and Commented By Vidya J On 30-11-2015
                ' CommonFunctions.HTMLControls.DrawTextBox("txtReview", "txtReview", , 20, 2, CType(m_Review, String), "Right", , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtReview", "txtReview", , 23, 2, CType(m_Review, String), "Right", , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                'End Of Added and Commented By Vidya J On 30-11-2015
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .Write("&nbsp")
                ''''.Write(" Days Before Due Date. </TD>")
            End If

            'Added by MrugajaB on 9th Jan 2006
            .Write(MyBase.GetResourceString("DAYS"))
            .Write(MyBase.GetResourceString("BEFORE_REVIEW_DUE_DATE"))
            'End Addition

            'Modified by MrugajaB on 9th Jan 2006
            .Write("</TR>")
            .Write("<TR class=clsTREven><TD>")
            'End Modification
            'Added and Commented By Vidya J On 30-11-2015
            'CommonFunctions.HTMLControls.DrawCheckBox("chkDeliverable", "chkDeliverable", , CType(m_blnDeliverable, Boolean), , , " onpropertychange=""Javascript:chkDeliverable_Change()"" ", , , , , , )
            CommonFunctions.HTMLControls.DrawCheckBox("chkDeliverable", "chkDeliverable", , CType(m_blnDeliverable, Boolean), , , " onchange=""Javascript:chkDeliverable_Change()"" ", , , , , , )
            'End Of Added and Commented By Vidya J On 30-11-2015
            .Write("&nbsp")

            'Added by MrugajaB on 9th Jan 2006
            ''''.Write("Deliverable </TD>")
            .Write(MyBase.GetResourceString("SEND_ME_REMINDER"))
            'End Addition


            If CType(m_blnDeliverable, Boolean) = True Then
                .Write("<TD>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                'Added and Commented By Vidya J On 30-11-2015
                ' CommonFunctions.HTMLControls.DrawTextBox("txtDeliverable", "txtDeliverable", , 20, 2, CType(m_Deliverable, String), "Right", , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtDeliverable", "txtDeliverable", , 23, 2, CType(m_Deliverable, String), "Right", , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                'End Of Added and Commented By Vidya J On 30-11-2015
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .Write("&nbsp")
                ''''.Write(" Days Before Planned End Date. </TD>")
            Else
                .Write("<TD>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                'Added and Commented By Vidya J On 30-11-2015
                'CommonFunctions.HTMLControls.DrawTextBox("txtDeliverable", "txtDeliverable", , 20, 2, CType(m_Deliverable, String), "Right", , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtDeliverable", "txtDeliverable", , 23, 2, CType(m_Deliverable, String), "Right", , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                'End Of Added and Commented By Vidya J On 30-11-2015
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .Write("&nbsp")
                ''''.Write(" Days Before Planned End Date. </TD>")
            End If

            'Added by MrugajaB on 9th Jan 2006
            .Write(MyBase.GetResourceString("DAYS"))
            .Write(MyBase.GetResourceString("BEFORE_DELIVERABLE_DUE_DATE"))
            'End Addition

            .Write("</TR>")
            .Write("</Table>")
            .Write("</DIV>")
            '*******************************************************************************************
            .Write("</DIV>")
            Response.Write(strMenu)

        End With
        CommonFunctions.Data.DisposeDataReader(drEmail)
        CommonFunctions.Data.DisposeDataReader(drProjectCount)

    End Sub

    Protected Sub SaveDetails()

        Dim strSQL As String

        'Modified by MrugajaB on 3rd Jan 2006 for Whiziblesem SP9
        strSQL = "EXEC USP_INS_TBL_PM_FLAGFORTRACKING_CONFIGURE " & CType(Session("intUserID"), String) & "," & m_blnTask & "," & m_Task & "," & m_blnReview & "," & m_Review & "," & m_blnHelpRequest & "," & m_HelpRequest & "," & m_blnDeliverable & "," & m_Deliverable & "," & m_CustomerFlag & ",'" & m_strCustomers & "'," & m_blnHelpRequestAfterFlag & "," & m_intHelpRequestAfterDays
        'End Modification
        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

    End Sub


End Class
