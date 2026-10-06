Public Class FA_InvoiceGeneration
    Inherits WebPages.Template.WhizTemplate

#Region " Variable Declaration "
    Private m_strHowToGenerate As String
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
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
    Protected m_intProjectID As Integer
    Protected m_strSessionUserID As String

    Protected m_blnIsFooter As Boolean = False   'True id body holds footer
    Protected m_blnIsHeader As Boolean = False   'True id body holds header

    Private intTimeSheetNo As String
    Private m_dblHourSum As Double = 0
    Private m_dateToGroup As String = ""
    Private m_strEmployeeName As String = ""
    Private m_dblGrandHourTotal As Double = 0

    Private WithEvents m_objGridCustomers As New WebPage.Templates.GenericGrid
    Private WithEvents m_objGridPayments As New WebPage.Templates.GenericGrid
    'Private WithEvents m_objGridTimesheetDetails As New WebPage.Templates.GenericGrid
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccess As WebPages.Security.cAccessRights
#End Region

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

#Region " Page Init & Constructor "

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.FA_InvoiceGeneration", "AppResources")
    End Sub

    Public Sub PageInit()

        Dim intChecked As Integer
        Dim intInvoiceNo As String
        Dim strSelectedInvoices As String = ""
        Dim intErrorID As Integer
        Dim drCompanyInformation, drError, drTagMaster, drCustomerTimeSheet As IDataReader
        Dim strSQL As String
        Dim drErrorID As IDataReader

        m_strSessionLoginType = CType(Session("LoginType"), String)
        m_strSessionIsCreatedByCustomer = CType(Session("IsCreatedByCustomer"), String)
        m_strSessionCustomerCreatedLoginID = CType(Session("CustomerCreatedLoginID"), String)
        m_strSessionPostID = CType(Session("intPostID"), String)
        m_strHowToGenerate = Request.QueryString("HowToGenerate")
        m_strWhatToShow = Request.QueryString("WhatToShow")

        m_intProjectID = CType(Request("ProjectID"), Integer)

        If m_intProjectID = Nothing Then m_intProjectID = 0

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


        If m_strWhatToShow = "Invoice" Then
            'check for the how to generate invoice
            Dim strSelectedTimeSheets As String
            Select Case Trim(m_strHowToGenerate)

                Case "One" 'generate one invoice for all selected time sheets.

                    If Split(MyBase.GetFormValue("chkInvoice"), ",").Length > 0 Then
                        'for loop to construct the selected TimeSheet Number list
                        For intChecked = 0 To Split(MyBase.GetFormValue("chkInvoice"), ",").Length - 1

                            intTimeSheetNo = Split(MyBase.GetFormValue("chkInvoice"), ",")(intChecked)
                            strSelectedTimeSheets = strSelectedTimeSheets & intTimeSheetNo & ","

                        Next
                        'Remove the last quama from the list

                        strSelectedTimeSheets = Left(strSelectedTimeSheets, Len(Trim(strSelectedTimeSheets)) - 1)
                        'Execute the stored procedure to generate the invoice from the selected
                        'time sheet
                        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                        ''  Dim objNullCheck As Object = CommonFunction.Data.GetDataScalar("select LastInvoiceNumber  from tbl_PM_CompanyInformation", MyBase.UseSQL)
                        Dim objNullCheck As Object = CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_LastInvoiceNumber", MyBase.UseSQL)
                        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                        If IsDBNull(objNullCheck) Then
                            CommonFunction.Data.GetDataScalar("Update tbl_PM_CompanyInformation set LastInvoiceNumber = 0", MyBase.UseSQL)
                        End If

                        strSQL = "DECLARE @intErrorID int " + vbCrLf
                        strSQL = strSQL + "Exec usp_GenerateInvoiceNew '" + strSelectedTimeSheets + "', " + CStr(m_objGlobal.UserID) + ", @intErrorID OUTPUT" + vbCrLf
                        strSQL = strSQL + "Select 'ErrorID' =  @intErrorID"

                        drErrorID = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                        Do
                            Try
                                If drErrorID.Read Then
                                    intErrorID = CType(CommonFunction.Data.CheckIsDBNull(drErrorID("ErrorID"), "0"), Integer)
                                    Exit Do
                                End If
                            Catch e As Exception

                            End Try
                        Loop While drErrorID.NextResult
                        CommonFunction.Data.DisposeDataReader(drErrorID)

                        Select Case intErrorID
                            Case 0
                                Call SendMailToCustomer(intTimeSheetNo, 2)
                                CommonFunctions.General.WriteHTML("<Script Language=Javascript>")
                                CommonFunctions.General.WriteHTML("alert('" + MyBase.GetResourceString("INVOICE_SUCCESS") + "');")
                                CommonFunctions.General.WriteHTML("</SCRIPT>")
                            Case 1
                                CommonFunctions.General.WriteHTML("<Script Language=Javascript>")
                                'modified by HarshK on 06/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
                                CommonFunctions.General.WriteHTML("alert(""" + MyBase.GetResourceString("INVOICE_ERROR") + """);")
                                'End modified by HarshK on 06/09/05 for sp4 issueid 136
                                CommonFunctions.General.WriteHTML("</SCRIPT>")
                            Case 2
                                CommonFunctions.General.WriteHTML("<Script Language=Javascript>")
                                CommonFunctions.General.WriteHTML("alert('" + MyBase.GetResourceString("INVOICE_FAILED") + "');")
                                CommonFunctions.General.WriteHTML("</SCRIPT>")
                        End Select
                        strSelectedTimeSheets = ""
                    End If

                Case "Seperate" 'Generate Seperate invoices for all selected time sheets.
                    If Split(MyBase.GetFormValue("chkInvoice"), ",").Length > 0 Then

                        'for loop to construct the selected TimeSheet Number list
                        For intChecked = 0 To Split(MyBase.GetFormValue("chkInvoice"), ",").Length - 1

                            intTimeSheetNo = Split(MyBase.GetFormValue("chkInvoice"), ",")(intChecked)
                            strSQL = "DECLARE @intErrorID int " + vbCrLf
                            strSQL = strSQL + "Exec usp_GenerateInvoiceNew '" + intTimeSheetNo + "', " + CStr(m_objGlobal.UserID) + ", @intErrorID OUTPUT" + vbCrLf
                            strSQL = strSQL + "Select 'ErrorID' =  @intErrorID"

                            drErrorID = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

                            Do
                                Try
                                    If drErrorID.Read Then
                                        intErrorID = CType(CommonFunction.Data.CheckIsDBNull(drErrorID("ErrorID"), "0"), Integer)
                                        Exit Do
                                    End If
                                Catch e As Exception

                                End Try
                            Loop While drErrorID.NextResult
                            CommonFunction.Data.DisposeDataReader(drErrorID)
                            'intErrorID = CType(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), Integer)

                            Select Case intErrorID
                                Case 0
                                    'Response.Write "Send"	
                                    'Send mail to the customer 
                                    Call SendMailToCustomer(intTimeSheetNo, 2)
                                    CommonFunctions.General.WriteHTML("<Script Language=Javascript>")
                                    CommonFunctions.General.WriteHTML("alert('" + MyBase.GetResourceString("INVOICE_SUCCESS") + "');")
                                    CommonFunctions.General.WriteHTML("</SCRIPT>")
                                Case 1
                                    CommonFunctions.General.WriteHTML("<Script Language=Javascript>")
                                    'modified by HarshK on 06/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
                                    CommonFunctions.General.WriteHTML("alert(""" + MyBase.GetResourceString("INVOICE_ERROR") + """);")
                                    'End modified by HarshK on 05/09/05 for sp4 issueid 136
                                    CommonFunctions.General.WriteHTML("</SCRIPT>")
                                Case 2
                                    CommonFunctions.General.WriteHTML("<Script Language=Javascript>")
                                    CommonFunctions.General.WriteHTML("alert('" + MyBase.GetResourceString("INVOICE_FAILED") + "');")
                                    CommonFunctions.General.WriteHTML("</SCRIPT>")
                            End Select


                        Next
                        If intErrorID = 0 Then
                            'Send mail to the customer 	
                            Call SendMailToCustomer(intTimeSheetNo, 2)
                        End If
                    End If
            End Select
        End If

        DrawMenu("Top")
        CommonFunctions.General.WriteHTML("<br>")
        DrawPageCaptionHeaderNFooter("Header")
        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto;width:100%'>")
        'This condition displays only the list of customers.
        'If m_strWhatToShow = "TSDetails" Then
        'DrawDetailsPageAndGrid()
        If m_strWhatToShow = "Invoice" Then
            DrawInvoiceDetailsGrid()
        ElseIf m_strSessionLoginType = "E" And m_strWhatToShow <> "Invoice" Then
            DrawProjectGrid()
        End If
        CommonFunction.General.WriteHTML("</div>")
        DrawPageCaptionHeaderNFooter("Footer")
        DrawMenu("Bottom")

        m_objGlobal = Nothing
        m_objAccess = Nothing
        m_objMenu = Nothing

    End Sub

#End Region

#Region " Grid and Page Plotting "

    'Private Sub DrawDetailsPageAndGrid()
    '    '=====================================================================
    '    ' Procedure Name        : DrawDetailsPageandGrid()	
    '    ' Purpose               : To plot Timesheet details.
    '    ' Description           : same as above
    '    ' Parameters Passed     : None
    '    ' Returns               : None
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : PrasannaP
    '    ' Created               : March 17, 2004
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim drTimeSheet, drTS, drPN As IDataReader
    '    Dim strTimeSheetToDisplay, strFromDate, strToDate, tmpProjectID As String
    '    Dim strProjectName As String = ""
    '    Dim strSubProjectName As String = ""
    '    Dim strFromCustomer As String = ""

    '    strTimeSheetToDisplay = Request("TimeSheetNo")

    '    If m_blnSubProjectLevelInvoiceing Then
    '        drTimeSheet = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_TimeSheetInvoice NULL, NULL, " & strTimeSheetToDisplay, MyBase.UseSQL)
    '        If drTimeSheet.Read Then
    '            strSubProjectName = CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("SubProjectName"), "0"), String)
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(drTimeSheet)
    '    End If

    '    drTS = CommonFunctions.Data.GetDataReader("Select FromDate,ToDate,ProjectID From tbl_PM_TimeSheetInvoice Where TimeSheetNo=" & strTimeSheetToDisplay, MyBase.UseSQL)
    '    If drTS.Read Then
    '        strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(drTS(0), "-"), String)
    '        strToDate = CType(CommonFunctions.Data.CheckIsDBNull(drTS(1), "-"), String)
    '        tmpProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drTS(2), "-"), String)
    '        CommonFunction.Data.DisposeDataReader(drTS)
    '        If strProjectName = "" Then
    '            'TODO: Convert to Stored Procedure -> PrasannaP
    '            drPN = CommonFunctions.Data.GetDataReader("Select ProjectName From tbl_PM_Project Where ProjectID=" & tmpProjectID, MyBase.UseSQL)
    '            If drPN.Read Then
    '                strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(drPN(0), "0"), String)
    '            End If
    '            CommonFunctions.Data.DisposeDataReader(drPN)
    '        End If

    '    End If

    '    strTimeSheetToDisplay = Request("TimeSheetNo")
    '    CommonFunctions.General.WriteHTML("<br><TABLE class=clsTable width='100%' cellspacing=0>")
    '    CommonFunctions.General.WriteHTML("<TR><TD class=clsTDColumnHeader>" + MyBase.GetResourceString("PROJECT_NAME") + "</TD><TD class=clsTDColumnHeader>" + MyBase.GetResourceString("FROM_DATE") + "</TD><TD class=clsTDColumnHeader>" + MyBase.GetResourceString("TO_DATE") + "</TD><TD class=clsTDColumnHeader>" + MyBase.GetResourceString("TODAY") + "</TD></TR>")
    '    CommonFunctions.General.WriteHTML("<tr><TD class=clsTDEven><B>" & strProjectName & "</B></TD><TD class=clsTDEven><B>" & strFromDate & "</B></TD><TD class=clsTDEven><B>" & strToDate & "</B></TD><TD class=clsTDEven><B>" & CommonFunctions.Dates.CGetDate(Date.Today()) & "</B></TD></TR>")
    '    CommonFunctions.General.WriteHTML("</TABLE><BR>")

    '    If m_blnSubProjectLevelInvoiceing Then
    '        CommonFunction.General.WriteHTML("<TABLE class=clsTable width='100%' cellspacing=0>")
    '        CommonFunction.General.WriteHTML("<TR>")
    '        CommonFunction.General.WriteHTML("<TD class=clsTDOdd>" & m_strSubProjectCaption & ": <B>")
    '        If strSubProjectName <> "" Then
    '            CommonFunction.General.WriteHTML(strSubProjectName & "</B></TD>")
    '        Else
    '            CommonFunction.General.WriteHTML("N/A</TD>")
    '        End If
    '        CommonFunction.General.WriteHTML("</TR>")
    '        CommonFunction.General.WriteHTML("</TABLE><BR>")
    '    End If

    '    If m_blnSubProjectLevelInvoiceing Then
    '        CommonFunction.General.WriteHTML("<TABLE class=clsTable width='100%' cellspacing=0>")
    '        CommonFunction.General.WriteHTML("<TR>")
    '        CommonFunction.General.WriteHTML("<TD class=clsTDOdd>" & m_strSubProjectCaption & ": <B>")
    '        If strSubProjectName <> "" Then
    '            CommonFunction.General.WriteHTML(strSubProjectName & "</B></TD>")
    '        Else
    '            CommonFunction.General.WriteHTML("N/A</TD>")
    '        End If
    '        CommonFunction.General.WriteHTML("</TR>")
    '        CommonFunction.General.WriteHTML("</TABLE><BR>")
    '    End If

    '    'drTimeSheet = CommonFunctions.Data.GetDataReader("usp_Sel_TimeSheetForGivenTimeSheetNo " & strTimeSheetToDisplay, MyBase.UseSQL)
    '    Dim arrColumnHeadingList() As String = {"Dummy", MyBase.GetResourceString("PROGRAMMER_DATE"), MyBase.GetResourceString("TASK_NAME"), MyBase.GetResourceString("DESCRIPTION"), MyBase.GetResourceString("HOURS")}
    '    Dim arrActualColumnNames() As String = {"EmployeeName", "EntryDate", "Task", "Description", "Duration"}
    '    'To store the link details while clicking on Links in grid
    '    Dim arrSummmary() As String = {"", "", "", "", "SUM"}
    '    Dim arrGrouping() As String = {"0"}
    '    Dim strHTML As String = ""

    '    CommonFunctions.General.WriteHTML("<br>")

    '    With m_objGridTimesheetDetails
    '        .ActualColumnArray = arrActualColumnNames
    '        .UserFriendlyColumnArray = arrColumnHeadingList
    '        .NoOfDataColumns = 5
    '        .DIVStyle = "overflow:none"
    '        .ColNameToolTipOnEachRow = True
    '        .DIVID = "DivList"
    '        .GroupOnColumn = arrGrouping
    '        .DIVHeight = 0
    '        .SQL = "Exec usp_Sel_TimeSheetForGivenTimeSheetNo " & strTimeSheetToDisplay
    '        .ColNameToolTipOnEachRow = True
    '        .ShowSummaryFunctions = True
    '        .SummaryFunctions = arrSummmary
    '        .UseSQL = MyBase.UseSQL
    '        .PrimaryKey = "TimeSheetID"
    '        .DrawGrid()
    '    End With
    '    m_objGridTimesheetDetails = Nothing
    '    CommonFunctions.General.WriteHTML("<br>")

    '    strFromCustomer = Request("FromCustomer")
    '    If m_strWhatToShow = "TSDetails" And CInt(strFromCustomer) = 1 Then

    '        intTimeSheetNo = Request("TimeSheetNo")
    '        'Response.Write intTimeSheetNo
    '        strHTML = strHTML & "<TABLE CellSpacing=0 width='100%' class=clsTable><TR>"
    '        strHTML = strHTML & "<TD class=clsTDPageHeader align=right>"
    '        strHTML = strHTML & "&nbsp;|&nbsp;<A STYLE=TEXT-DECORATION:NONE Href =" & Chr(34) & "JavaScript:SendClick(" & intTimeSheetNo & ")" & Chr(34) & "><B>" + MyBase.GetResourceString("SEND") + "&nbsp;|&nbsp;</B></A>"
    '        strHTML = strHTML & "</TD></TR></TABLE><BR>"

    '        strHTML = strHTML & "<TABLE width='100%' class=clsTable cellspacing=0><TR align=center>"
    '        strHTML = strHTML & "<TD class=clsTDColumnHeader align=center colspan=2><Input TYPE=radio name=optAuthenticate Checked Value='Authenticate' Language=VBScript OnClick=optAuthenticate_OnClick('Autheticate')><Font Face=Verdana Size=1><B>Authenticate</B></FONT>"
    '        strHTML = strHTML & "<Input TYPE=radio name=optAuthenticate Value='Decline' Language=VBScript OnClick=optAuthenticate_OnClick('Decline')><Font Face=Verdana Size=1><B>Decline</B></FONT>"
    '        strHTML = strHTML & "</TD></TR><TR>"
    '        strHTML = strHTML & "<TD class=clsTDOdd align=left valign=Top>Comment</TD><TD class=clsTDOdd align=center><Textarea name='txtareaAuthenticate' align=center maxlength=200 class=clsTextArea style='width:420px;height:100'></Textarea>"
    '        'strHTML=strHTML & "<A Href='JavaScript:Open_Box()'><img Border=0 valign=Top src='../../images/zoomin.gif' alt='Double click the text area to add more text'></img></a>"
    '        strHTML = strHTML & "</TD></TR></TABLE>"
    '    End If

    'End Sub

    Private Sub DrawInvoiceDetailsGrid()
        '=====================================================================
        ' Procedure Name        : DrawInvoiceDetailsGrid()	
        ' Purpose               : To plot list of customers invoice details.
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
        Dim arrColumnHeadingList() As String = {MyBase.GetResourceString("TIME_SHEET_NO"), m_strSubProjectCaption, MyBase.GetResourceString("CREATED_DATE"), MyBase.GetResourceString("FROM_DATE"), MyBase.GetResourceString("TO_DATE"), MyBase.GetResourceString("GENERATE_INVOICE")}
        Dim arrActualColumnNames() As String = {"TimeSheetNo", "SubProjectName", "CreatedDate", "FromDate", "ToDate"}
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"", "", "", "", "", "", "", ""}
        Dim arrColRowLinks() As String = {"ShowDetails(TimeSheetNo)", "", "", "", ""}
        Dim arrColCheckBoxes() As String = {"", "", "", "", "", "chkInvoice"}
        Dim strHTML As String = ""
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        CommonFunctions.General.WriteHTML("<br>")

        With m_objGridPayments
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .NoOfDataColumns = 5
            .DIVStyle = "overflow:none"
            .CheckBoxIDArray = arrColCheckBoxes
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .RowLinkArray = arrColRowLinks
            .SQL = "EXEC usp_Get_Project_TimeSheet " + CStr(m_intProjectID)
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .PrimaryKey = "TimeSheetNo"
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGridPayments = Nothing
        CommonFunctions.General.WriteHTML("<br>")
    End Sub

    Private Sub DrawProjectGrid()
        '=====================================================================
        ' Procedure Name        : DrawrGrid()	
        ' Purpose               : To plot the invoice details grid.
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
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"style='width:60%'", "align=left"}
        Dim arrColRowLinks() As String = {"Project_OnSelect(ProjectID)"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        CommonFunctions.General.WriteHTML("<br>")

        arrColumnHeadingList.Add(MyBase.GetResourceString("PROJECT_NAME"))
        'arrColumnHeadingList.Add(MyBase.GetResourceString("SHOW_DETAILS"))

        arrActualColumnNames.Add("ProjectName")
        'arrActualColumnNames.Add("ProjectID")


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
            If m_strSessionLoginType = "E" Then
                .SQL = "EXEC usp_Sel_Projects_ToGenrateInvoice " & m_strSessionPostID & "," & m_objGlobal.UserID
            Else
                .SQL = "EXEC usp_Sel_Projects_ToGenrateInvoice Null,Null," & m_objGlobal.UserID
            End If
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .PrimaryKey = "ProjectID"
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGridCustomers = Nothing
        CommonFunctions.General.WriteHTML("<br>")

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
        Dim arrMenuCaptionsList As New ArrayList
        'Stores the captions of the Menu

        Dim arrMenuToolTipsList As New ArrayList
        'Stores the Tooltips of the Menu items

        Dim arrClientSideFunctionList As New ArrayList
        'Stores the client side function name for the menu item

        Dim strMenu As String
        'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu

        If m_objAccess.Add = True And m_strWhatToShow = "Invoice" Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("GENERATE_INVOICE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GENERATE_TOOLTIP"))
            arrClientSideFunctionList.Add("GenerateInvoice()")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_TOOLTIP_BACK"))
            arrClientSideFunctionList.Add("Back_OnClick()")

        End If

        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('349')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

#End Region

#Region " Events "

    Private Sub m_objGridCustomers_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridCustomers.DataRowTD_BeforePrint
        If Args.ColumnName = MyBase.GetResourceString("SHOW_DETAILS") Then
            Args.ReplacementValue = MyBase.GetResourceString("SELECT_PROJECT")
        End If
    End Sub

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If m_objAccess.Add = False And Args.LinkName = MyBase.GetResourceString("GENERATE_INVOICE") Then
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
        If m_objAccess.Add = False And Args.ColumnName = MyBase.GetResourceString("GENERATE_INVOICE") Then
            Cancel = True
        End If
    End Sub

    Private Sub m_objGridPayments_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGridPayments.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 1 And m_blnSubProjectLevelInvoiceing = False Then
            Cancel = True
        End If
        If m_objAccess.Add = False And Args.ColumnName = MyBase.GetResourceString("GENERATE_INVOICE") Then
            Cancel = True
        End If
    End Sub

    'Private Sub m_objGridTimesheetDetails_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridTimesheetDetails.DataRowTD_BeforePrint
    '    If Args.ColIndex = 4 Then
    '        m_dblHourSum = m_dblHourSum + CDbl(Args.DataFieldValue)
    '    End If
    'End Sub

    'Private Sub m_objGridTimesheetDetails_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGridTimesheetDetails.ColumnHeaderTD_BeforePrint
    '    If Args.ColIndex = 0 Then
    '        Args.ColumnName = ""
    '    End If
    'End Sub


    'Private Sub m_objGridTimesheetDetails_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGridTimesheetDetails.DataRowTR_BeforePrint
    '    Dim strTemp As String = ""
    '    strTemp = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String)
    '    If strTemp <> m_strEmployeeName And m_strEmployeeName <> "" Then
    '        Args.StringToBeInserted = "<TR class=clsTRSectionHeader><TD align=left class='' ></TD><TD align=left class='' ><FONT color=blue>" + MyBase.GetResourceString("TOTAL") + " " + m_strEmployeeName + "</font></TD><TD align=right class='' ></TD><TD align=right class='' ></TD><TD align=right class='' ><B><FONT color=blue>" + FormatNumber(CStr(m_dblHourSum), 2) + "</font></B></TD></TR>"
    '        m_dblGrandHourTotal = m_dblGrandHourTotal + m_dblHourSum
    '        m_dblHourSum = 0
    '    End If
    '    m_strEmployeeName = strTemp
    'End Sub

    'Private Sub m_objGridTimesheetDetails_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGridTimesheetDetails.SummaryFunctionsTR_BeforePrint
    '    Cancel = True
    '    m_dblGrandHourTotal = m_dblGrandHourTotal + m_dblHourSum
    '    Args.StringToBeInserted = "<TR class=clsTRSectionHeader><TD align=right class='' ></TD><TD align=left class='' ><FONT color=blue>" + MyBase.GetResourceString("TOTAL") + " " + m_strEmployeeName + "</Font></TD><TD align=right class='' ></TD><TD align=right class='' ></TD><TD align=right class='' ><B><FONT color=blue>" + FormatNumber(CStr(m_dblHourSum), 2) + "</font></B></TD></TR>" & _
    '                              "<TR class=clsTRSectionHeader><TD align=right class='' ></TD><TD align=left class='' ><FONT color=blue>" + MyBase.GetResourceString("GRAND_TOTAL") + "</Font></TD><TD align=right class='' ></TD><TD align=right class='' ></TD><TD align=right class='' ><B><FONT color=blue>" + FormatNumber(m_dblGrandHourTotal, 2) + "</font></B></TD></TR>"
    '    m_dblHourSum = 0
    'End Sub
#End Region

#Region " Generic and Email Related functions "
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

    Sub SendMailToCustomer(ByVal intTimeSheetNo As String, ByVal intFlag As Integer)

        Dim drEmailMessage, drInvoiceNo As IDataReader
        '1=TimeSheet
        '2=Invoice	
        'Start
        If intFlag = 1 Then
            drEmailMessage = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 6", MyBase.UseSQL)
            If drEmailMessage.Read Then
                If CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean) = False Then
                    CommonFunctions.Data.DisposeDataReader(drEmailMessage)
                    Exit Sub
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drEmailMessage)
        Else
            drEmailMessage = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 7", MyBase.UseSQL)
            If drEmailMessage.Read Then
                If CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean) = False Then
                    CommonFunctions.Data.DisposeDataReader(drEmailMessage)
                    Exit Sub
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drEmailMessage)
        End If
        'end

        Dim drCustomerEmail, drProject, drFManager As IDataReader
        Dim strMessage, strInvoiceNumber, strFMName As String
        Dim strSite, strProjectName, strProjectManager, strSubject, strFromMail, strMailTo, strCustomerName As String


        'get the email id's from project customer contact table to send the mail
        drCustomerEmail = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_CustomerEmailIDForTimeSheet " & intTimeSheetNo, MyBase.UseSQL)
        While drCustomerEmail.Read

            ' Get the email ID of the contact person.
            If CType(CommonFunctions.Data.CheckIsDBNull(drCustomerEmail("EmailID"), ""), String) <> "" Then
                strMailTo = strMailTo & CType(CommonFunctions.Data.CheckIsDBNull(drCustomerEmail("EmailID"), ""), String) & "; "
            End If

            ' Get the name of the contact person.
            If CType(CommonFunctions.Data.CheckIsDBNull(drCustomerEmail("ContactPerson"), ""), String) <> "" Then
                strCustomerName = strCustomerName & CType(CommonFunctions.Data.CheckIsDBNull(drCustomerEmail("ContactPerson"), ""), String) & ", "
            End If

        End While

        CommonFunctions.Data.DisposeDataReader(drCustomerEmail)

        strFromMail = CommonFunction.EmailMessages.funcGetCompanyMailID

        drProject = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_ProjectNameFromTimeSheet " & intTimeSheetNo, MyBase.UseSQL)
        If drProject.Read Then
            strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(drProject(0), "-"), String)
            strProjectManager = CType(CommonFunctions.Data.CheckIsDBNull(drProject(1), "-"), String)
        End If
        CommonFunctions.Data.DisposeDataReader(drProject)

        strSite = Request.ServerVariables("SERVER_NAME")

        If intFlag = 1 Then
            'Message Id 6 : For the Timesheet
            strMessage = CommonFunction.EmailMessages.funcGetEmailMessage(6, strSubject)
        Else
            'Message Id 7 : For the Invoice
            strMessage = CommonFunction.EmailMessages.funcGetEmailMessage(7, strSubject)
            CommonFunction.EmailMessages.funcGetCompanyMailID()

            If intTimeSheetNo <> "" Then
                drInvoiceNo = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_PM_InvoiceNumberForTimesheet " & intTimeSheetNo, MyBase.UseSQL)
                If drInvoiceNo.Read Then
                    strInvoiceNumber = "(No." & CType(CommonFunctions.Data.CheckIsDBNull(drInvoiceNo(0), "0"), String) & ")"
                End If
                CommonFunction.Data.DisposeDataReader(drInvoiceNo)
            End If
            strSubject = Replace(strSubject, "<INVOICE NUMBER>", strInvoiceNumber)
            strMessage = Replace(strMessage, "<INVOICE NUMBER>", strInvoiceNumber)
        End If

        drFManager = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Employee " & m_objGlobal.UserID, MyBase.UseSQL)
        If drFManager.Read Then
            strFMName = CType(CommonFunctions.Data.CheckIsDBNull(drFManager(1), "0"), String)
        End If
        CommonFunctions.Data.DisposeDataReader(drFManager)

        strMessage = Replace(strMessage, "<NAME>", strCustomerName)
        strSubject = Replace(strSubject, "<PROJECT_NAME>", strProjectName)
        strMessage = Replace(strMessage, "<SITE>", strSite)
        strMessage = Replace(strMessage, "<SENDER_NAME>", strFMName)

        CommonFunction.Emails.AppSendEmail(strMailTo, strFromMail, strSubject, strMessage)

    End Sub
#End Region

End Class
