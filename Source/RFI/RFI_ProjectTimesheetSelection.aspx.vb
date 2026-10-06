'''' Integrated and added by NageshM on date 16th Nov 2005
Option Strict Off
Public Class RFI_ProjectTimesheetSelection
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
    Public intRFIID As Integer
    Public strUserType As String
    'Added by PrashantSJ on 09-June-2006 For Project Site wise project timesheet 
    Public mulipleSiteFlag As Integer = 0

    Private m_objGlobal As WebPages.Template.IGlobal
    Private WithEvents m_objGrid As New WebPages.Grid.cGenericGrid
    'End of addition by PrashantSJ on 09-June-2006 For Project Site wise project timesheet 
    'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
    Protected m_strToken As String
    'End of addition by MonikaI


    Public Sub PageInit()
        '=====================================================================
        ' Function Name   :   PageInit
        ' Purpose       :   To Display the timesheet
        ' Description   :   Same as above
        ' Dependencies  :   Resource file for the same
        ' Author        :   VivekP
        ' Created       :   4 May 2005
        ' Revisions     :
        '######### Page Code starts here
        Dim strSQL As String
        Dim strQuery As String
        Dim rsDataReader As IDataReader
        Dim blnIsRateDefined As String = ""
        Dim objMenu As New WebPages.Template.StaticMenu 'To draw the static menu for close and help link
        Dim intTimesheetID As Integer
        Dim intRow As Integer = 0
        Dim strClass As String
        Dim strDivName As String
        Dim checknull As String = 0
        Dim strSQLQuery As String
        Dim datareader As IDataReader
        Dim strtemp As String

        'Added by PrashantSJ on 06-June-2006 for Project Timsheet with Project Site wise changes
        Dim arrMenuList As New ArrayList       'To store the column Headings
        Dim arrClientSideFunctionNames As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim strPageCaption As String = ""
        Dim strPageCaptionDetail As String = "The Application has detected that this timesheet is for the multiple Project-Sites with different currencies OR same currencies with different Rate Method. Following are the details. "
        Dim strIRList As String = ""
        Dim strCancelRequest As String = "0"

        'To draw the close and help link
        GetGlobalObject()
        intTimesheetID = Request.QueryString("TimesheetID")

        intRFIID = Request.QueryString("RFIID")

        strUserType = Request.QueryString("UserType")
        'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
        m_strToken = ""

        If HttpContext.Current.Request.QueryString("PKToken") Is Nothing Then
            m_strToken = Request.Form("txtHiddenToken") & ""
        Else
            m_strToken = Request.QueryString("PKToken") & ""
        End If
        strCancelRequest = CommonFunction.General.CheckIsNothing(Request.QueryString("Cancel"), "0")
        mulipleSiteFlag = CommonFunction.General.CheckIsNothing(Request.QueryString("MultipleSiteFlag"), "0")
        'Added by PrashantSJ on 09-June-2006 For Project Site wise project timesheet 
        If Not Request.QueryString("TimesheetID") Is Nothing And CommonFunction.General.CheckIsNothing(Request.QueryString("MultipleSiteFlag"), "0") <> "1" Then
            strQuery = "usp_Sel_ProjectSite_Timesheetwise " & Session("intProjectID").ToString & "," & intTimesheetID.ToString & ",1"
            mulipleSiteFlag = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)), Integer)
        End If
        'End of addition by PrashantSJ on 09-June-2006 For Project Site wise project timesheet 

        If mulipleSiteFlag = 1 And strCancelRequest <> "1" Then
            arrMenuList.Add("Generate Invoice Item")
            arrMenuList.Add("Back")
            arrMenuList.Add("Close")
            arrMenuToolTipList.Add("Generate Invoice Item")
            arrMenuToolTipList.Add("Back")
            arrMenuToolTipList.Add("Close")
            arrClientSideFunctionNames.Add("CreateInvoiceItem_OnClick('" & m_strToken & "'," & Request.QueryString("TimesheetID").ToString & ")") '," & intRFIID & ",'" & strUserType & "')")
            arrClientSideFunctionNames.Add("Back_OnClick('" & m_strToken & "')")
            arrClientSideFunctionNames.Add("Close_OnClick()")
            arrMenuList.Add("?")
            arrMenuToolTipList.Add("Help")
            arrClientSideFunctionNames.Add("Help_OnClick()")
            strPageCaption = "Project Timesheet : Timesheet ID : " & Request.QueryString("TimesheetID").ToString

        Else

            arrMenuList.Add("Close")
            arrClientSideFunctionNames.Add("Close_OnClick()")
            arrMenuToolTipList.Add("Close")

            arrMenuList.Add("?")
            arrMenuToolTipList.Add("Help")
            arrClientSideFunctionNames.Add("Help_OnClick()")
            strPageCaption = "Project Timesheet "
        End If

        If mulipleSiteFlag <> 1 Or CommonFunction.General.CheckIsNothing(Request.QueryString("MultipleSiteFlag"), "0") = "1" Then
            'End of addition by PrashantSJ on 06-June-2006
            If Request.QueryString("Mode") = "true" Then
                'If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("TimesheetID").ToString + HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                Else
                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Request.QueryString("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
                    'Added and commented by PrashantSJ on 09-June-2006 For Project Site wise project timesheet
                    ' strQuery = " Exec usp_Ins_ProjectTimesheet_RFIItems " & Session("intProjectID").ToString & "," & intRFIID.ToString & "," & intTimesheetID.ToString
                    strQuery = " Exec usp_Ins_ProjectTimesheet_RFIItems " & Session("intProjectID").ToString & "," & intRFIID.ToString & "," & intTimesheetID.ToString & ",'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                    'End of addition by PrashantSJ on 06-June-2006
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

                    strQuery = "usp_Sel_Timesheet_IR_List " & Session("intProjectID").ToString & "," & intTimesheetID.ToString
                    strIRList = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)), String)

                    Response.Write("<script LANGUAGE=javascript>")

                    If CommonFunction.General.CheckIsNothing(Request.QueryString("MultipleSiteFlag"), "0") = "1" Then
                        Response.Write("alert(""Following IRs have been created for all sites for the selected timsheet :" & strIRList & """);")
                    End If

                    'Response.Write("<script LANGUAGE=javascript>")
                    Response.Write("window.opener.location.href=""RFI_RFI.aspx?PKToken=" + m_strToken + "&Mode=Edit&UserType=" & strUserType & "&RFIID=" & intRFIID & """;")
                    'Response.Write("window.opener.location.href=""RFI_RFI.aspx?Mode=Edit&UserType=" & strUserType & "&RFIID=" & intRFIID & """;")
                    Response.Write("window.close();")
                    Response.Write("</script>")
                End If
            Else
                Dim m_strTSID As String
                m_strTSID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("TimesheetID"), "True"), String)
                If m_strTSID = "True" Then
                    If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                Else
                    If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                End If
            End If
        End If

        Response.Write(objMenu.DrawMenu(GetArray(arrMenuList), GetArray(arrClientSideFunctionNames), GetArray(arrMenuToolTipList), True))
        Response.Write("<BR>")

        If mulipleSiteFlag = 1 And strCancelRequest <> "1" Then
            Response.Write("<table CellSpacing='0' width='100%' class='clsTable'><TR class=clsTRPageCaption><TD align=Left><b>" & strPageCaption & "</b></td><tr></tr>")
            Response.Write("<TR class=clsTRSectionHeader><TD align=Left>" & strPageCaptionDetail & "</TD></TR></TABLE>")
        Else
            Response.Write("<table CellSpacing='0' width='100%' class='clsTable'><TR class=clsTRPageCaption><TD align=Left><b>" & strPageCaption & "</b></td></tr></table>")
        End If
        Response.Write("<BR>")
        Response.Write("<DIV STYLE='overflow:auto;height:100%'>")

        If mulipleSiteFlag = 1 And strCancelRequest <> "1" Then
            strPageCaptionDetail = "When you click Generate Invoice Item link, the application will create one IR per site. All IRs will have the same header Information"
            PlotUIForTimeSheetDetails()
            Response.Write("<BR>")
            Response.Write("<table CellSpacing='0' width='100%' class='clsTable'><TR class=clsTRSectionHeader><TD align=Left>" & strPageCaptionDetail & "</td></tr></TABLE>")
        Else

            'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            'strSQLQuery = "SELECT FormatDate FROM tbl_PM_CompanyInformation C , tbl_PM_DateFormats D WHERE C.DateFormatID=D.DateFormatID"
            strSQLQuery = "usp_sel_tbl_PM_CompanyInformation_FormatDate"
            'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query

            datareader = CommonFunction.Data.GetDataReader(strSQLQuery, True)

            If datareader.Read() Then
                strtemp = datareader("FormatDate")
            End If
            CommonFunction.Data.DisposeDataReader(datareader)
            If strtemp = "dd,mmm yyyy" Then
                strtemp = "dd,MMM yyyy"
            End If
            If strtemp = "mmm dd,yyyy" Then
                strtemp = "MMM dd,yyyy"
            End If
            If strtemp = "mm/dd/yyyy" Then
                strtemp = "MM/dd/yyyy"
            End If
            If strtemp = "dd/mm/yyyy" Then
                strtemp = "dd/MM/yyyy"
            End If

            ''' Added By NageshM on Date 16th Nov 2005 
            ' View Name is changed.
            '  strSQL = "SELECT * FROM v_tbl_PM_TimeSheetInvoice WHERE ProjectID=" & Session("intProjectID").ToString & "Order By TimesheetNo"
            ''Added and commented by PrashantSJ on 12-June-2006 For Project Timesheet Project Site wise customization
            ' strSQL = "SELECT * FROM g_tbl_PM_TimeSheetInvoice WHERE ProjectID=" & Session("intProjectID").ToString & "Order By TimesheetNo"
            strSQL = "usp_Sel_Timsheet_IR_Billing " & Session("intProjectID").ToString & "," & intRFIID.ToString
            '   'End of addition by PrashantSJ on 12-June-2006

            ' strSQL = "SELECT * FROM v_tbl_PM_TimeSheetInvoice WHERE ProjectID=23"
            rsDataReader = CommonFunction.Data.GetDataReader(strSQL, True)

            Response.Write("<Table width='100%' cellspacing=0 cellpadding=0  class='clsTable' ><TR class='clsTRColumnHeader'><TD align=center><b>Timesheet ID</b></TD>")
            Response.Write("<TD  align=center><b>From Date</b></TD>")
            Response.Write("<TD  align=center><b>To Date</b></TD>")
            Response.Write("<TD  align=center><b>Created Date</b></TD>")
            Response.Write("</TR>")
            'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("txtHiddenToken", "txtHiddenToken", , , , m_strToken, , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            'End of addition by MonikaI

            While rsDataReader.Read()
                checknull = 1
                intRow = intRow + 1
                If intRow Mod 2 = 0 Then
                    strClass = "clsTDEven"
                Else
                    strClass = "clsTDOdd"
                End If
                Response.Write("<TR>")
                Response.Write("<TD class=" + strClass + " align=center><A STYLE=TEXT-DECORATION:NONE Href =" + "JavaScript:Status_OnClick('" + m_strToken + "'," & rsDataReader("TimesheetNo") & ")><U>" + rsDataReader("TimesheetNo").ToString() + "</U></A></TD>")
                Response.Write("<TD class=" + strClass + " align=center>" + CType(CommonFunction.Dates.GetDate(rsDataReader("FromDate")), Date).ToString(strtemp) + "</TD>")
                Response.Write("<TD class=" + strClass + " align=center>" + CType(CommonFunction.Dates.GetDate(rsDataReader("ToDate")), Date).ToString(strtemp) + "</TD>")
                Response.Write("<TD class=" + strClass + " align=center>" + CType(CommonFunction.Dates.GetDate(rsDataReader("CreatedDate")), Date).ToString(strtemp) + "</TD>")
                'Response.Write("<TD class=" + strClass + ">" + rsDataReader("NoOfIssues").ToString() + "</TD>")
                Response.Write("</TR>")

                strQuery = "usp_Sel_Timsheet_IR_Billing " & Session("intProjectID").ToString & "," & intRFIID.ToString & "," & CType(rsDataReader("TimesheetNo"), Integer)
                blnIsRateDefined = CType(CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL), String)

                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                CommonFunctions.HTMLControls.DrawTextBox("txtHidIsRateDefined" + rsDataReader("TimesheetNo").ToString, "txtHidIsRateDefined" + rsDataReader("TimesheetNo").ToString, , , , blnIsRateDefined, , , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            End While
            If checknull = 0 Then
                Response.Write("<TR>")
                Response.Write("<TD class='clsTDOdd' COLSPAN=4><CENTER>There are no items to show in this view.</CENTER></TD>")
                Response.Write("</TR>")

            End If
            Response.Write("</TABLE>")
            CommonFunction.Data.DisposeDataReader(rsDataReader)
            CommonFunction.Data.DisposeDataReader(datareader)
        End If
        Response.Write("</DIV>")

        If mulipleSiteFlag <> 1 Or strCancelRequest = "1" Then
            Response.Write("<BR>")
            Response.Write("<BR>")
            Response.Write("<BR>")
            Response.Write("<BR>")
            Response.Write("<BR>")
            Response.Write("<BR>")
            Response.Write("<BR>")
            Response.Write("<BR>")
        End If

        If checknull = 0 Then
            'Response.Write("<BR>")
            Response.Write("<BR>")
            Response.Write("<BR>")
            Response.Write("<BR>")
            Response.Write("<BR>")
            Response.Write("<BR>")
            Response.Write("<BR>")
        End If

        Response.Write(objMenu.DrawMenu(GetArray(arrMenuList), GetArray(arrClientSideFunctionNames), GetArray(arrMenuToolTipList), True))
    End Sub

    Public Sub New()

        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
    'Added by PrashantSJ on 06-June-2006 for Project Timsheet with Project Site wise changes
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
    '====================================================================
    ' Procedure Name        :   PlotUIForTimesheetDetails
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   None
    ' Description           :   Plots the UI for Issue Details
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   PrashantSJ
    ' Created               :   June 06, 2006
    ' Revisions             :
    '=====================================================================
    Private Function PlotUIForTimeSheetDetails() As String
        Dim arrUFN() As String = {"Project Site", "Site Currency", "Rate Method", "Is Rate Defined"}
        Dim arrAN() As String = {"SiteName", "CurrencyCode", "RateMethod", "IsRateDefined"}
        Dim strSectionTitle As String = "The Application has detected that this timesheet is for the multiple Project-Sites with different currencies. Following are the details. "
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        ' Response.Write("<DIV STYLE='overflow:auto;width:100%;height:200px>")
        ' plot the grid here
        With m_objGrid
            .NoOfDataColumns = 4
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrUFN
            .ColNameToolTipOnEachRow = True
            .SQL = "usp_Sel_ProjectSite_Timesheetwise " & Session("intProjectID").ToString & "," & Request.QueryString("TimeSheetID").ToString & ",NULL," & intRFIID.ToString
            .UseSQL = True
            '.DIVID = "divList"
            '.DIVStyle = "overflow:auto;width:100%;"
            '.DIVHeight = 240
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write(.DrawGrid())
        End With
        'Response.Write("</DIV>")

        m_objGrid = Nothing
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
    'End of Addition by PrashantSJ on 06-June-2006

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint

        If Args.ColIndex = 3 Then
            Cancel = True
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 3 Then
            Cancel = True
            Args.StringToBeInserted += "<TD align='right'>" + CommonFunction.HTMLControls.DrawCheckBox("chkHidRate", "chkHidRate", , , Args.DataReader("IsRateDefined").ToString, , , , , , , True) + "</TD>"

        End If
    End Sub
End Class
