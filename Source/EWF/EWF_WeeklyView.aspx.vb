'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleE
' Module Name           :  EWF_WeeklyView.aspx
' Purpose               :  Expenses Entry Tabular View - Bristlecone Customization
' Description           :  
' Dependencies          :  None
' Author                :  Santosh Kale
' Created               :  Monday, May 22, 2006
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class EWF_WeeklyView
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
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Private m_Date As String
    Protected m_dtStartDateOfWeek As Date
    Protected m_dtEndDateOfWeek As Date
    Protected m_intStartingDayOfWeek As Integer = 0
    Protected m_intCurrentDayOfWeek As Integer = 0

    Protected Const MOVE_NEXT As String = "MOVE_NEXT"
    Protected Const MOVE_PREVIOUS As String = "MOVE_PREV"

    Private m_CurrencyID As String = ""
    Private m_CountryID As String = ""
    Private m_FPID As String = ""

    Private m_DetailsRowCount As Integer = 0

    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objDetailsGrid As New WebPages.Template.GenericGrid
    'Modified by SantoshK on Date July 06,2006 for WhizibleSEM Issue ID.4168
    Protected m_strBrowserName As String
    'End of modification by SantoshK on July 06,2006 Isse ID.4168
#End Region

#Region "Page Load functions"
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
        ' Author                :   PrakashR
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        'Call GetGlobalObject()
        Dim intRowNumber As String
        Dim m_strWhere As String
        'Modified by SantoshK on Date July 06,2006 for WhizibleSEM Issue ID.4168
        ''COMMENTED BY NILESH G ON 17/12/2015 FOR ISSUE ID 2737
        ''    m_strBrowserName = Request.Browser.Browser
        ''  If m_strBrowserName = "IE" Or m_strBrowserName = "Microsoft Internet Explorer" Then
        'End of modification by SantoshK on July 06,2006 Isse ID.4168
        If Request.QueryString("Move") <> "" Then
            m_strWhere = Request.QueryString("Move")
        End If

        'Get the CurrencyID
        If CType(Request("CboCurrency"), String) <> "" Then
            m_CurrencyID = CType(Request("CboCurrency"), String)
        End If

        'Get the CountryID
        If CType(Request("CboCountry"), String) <> "" Then
            m_CountryID = CType(Request("CboCountry"), String)
        End If

        'Get the FPID
        If CType(Request("CboFpCenter"), String) <> "" Then
            m_FPID = CType(Request("CboFpCenter"), String)
        End If

        'Dim cur_Date As Date
        'Get The StartDate From QueryString
        If Request.QueryString("txtDate") <> "" Then
            m_Date = Request("txtDate")
        Else
            m_Date = CType(System.DateTime.Now, String)
        End If

        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        ''m_intStartingDayOfWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select StartingDayofweek from tbl_PM_CompanyInformation", MyBase.UseSQL), "0"))
        m_intStartingDayOfWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_StartingDayofweek", MyBase.UseSQL), "0"))
        ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        m_intStartingDayOfWeek += 1
        If m_intStartingDayOfWeek > 7 Then
            m_intStartingDayOfWeek = 1
        End If

        If m_strWhere = MOVE_PREVIOUS Then
            m_dtStartDateOfWeek = DateAdd(DateInterval.Day, -7, CDate(m_Date))
            m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
        ElseIf m_strWhere = MOVE_NEXT Then
            m_dtStartDateOfWeek = DateAdd(DateInterval.Day, 7, CDate(m_Date))
            m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
        Else
            If Request.QueryString("StartDate") <> "" And Request.QueryString("EndDate") <> "" Then
                m_dtStartDateOfWeek = CType(Request.QueryString("StartDate"), Date)
                m_dtEndDateOfWeek = CType(Request.QueryString("EndDate"), Date)
            Else
                'm_intCurrentDayOfWeek = System.DateTime.Now.DayOfWeek
                Dim dtmStartDate As String
                Dim dtmEndDate As String
                m_intCurrentDayOfWeek = CType(m_Date, Date).DayOfWeek
                CommonFunction.Dates.GetFromAndToDates("1", dtmStartDate, dtmEndDate, CType(m_Date, Date).ToString("dd-MMM-yyyy"))
                m_dtStartDateOfWeek = CType(dtmStartDate, Date)
                m_dtEndDateOfWeek = DateAdd("d", 6, m_dtStartDateOfWeek)
            End If
        End If
        'End If



        If Request.QueryString("Action") = "SAVE" Then
            'Save DATA
            SaveExpenses()
        End If

        If Request.QueryString("Action") = "SAVEDETAILS" Then
            'Save DATA
            SaveDetails()
        End If

        If Request.QueryString("Action") = "DELETEDETAILS" Then
            'Save DATA
            DeleteDetails()
        End If

        If Request.QueryString("Action") = "EditRow" Then
            Return
        End If

        If Request.QueryString("Action") = "EditProject" Then
            'EditProject()
            Return
        End If

        If Request.QueryString("Mode") = "ShowDetails" Then
            DrawDetailsMenu()
            DrawDetailsGrid()
            DrawDetailsMenu()
        Else
            DrawMenu()
            CommonFunctions.General.WriteHTML("<br>")
            WebPages.Template.PageCaption.GetPageCaptions(, "Expense Entry", " (" + m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") + " - " + m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") + ")")
            DrawCommonControls()
            CommonFunctions.General.WriteHTML("<br>")
            DrawGrid()
            DrawMenu()
        End If
        ''COMMENTED BY NILESH G ON 17/12/2015 FOR ISSUE ID 2737
        ''  End If
    End Sub
#End Region

#Region "XMLXTTP functions"
    Public Sub writeResponse()
        Dim intloopCounter As Integer
        Dim drCostHead As IDataReader
        Dim intRowNo As Integer
        Dim dtmTodaysDate As Date

        dtmTodaysDate = Date.Today()

        intRowNo = CType(Request.QueryString("RowNumber"), Integer)
        drCostHead = CommonFunctions.Data.GetDataReader("usp_sel_Expenses_forEmployee_Weekly " + CType(Session("intuserID"), String) + ",'" + CType(m_dtStartDateOfWeek, String) + "','" + CType(m_dtEndDateOfWeek, String) + "'," + CType(intRowNo, String), MyBase.UseSQL)

        intloopCounter = 0
        If Request.QueryString("Action") = "EditRow" Then
            Response.Clear()
            While drCostHead.Read()
                CommonFunctions.General.WriteHTML(CType(drCostHead("CostHead"), String))
                Response.Write("<ELEMENT_SEPERATOR>")

                'Commented and modified by MonikaI on 13th Oct 2006 IssueID : 6668
                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_1", "txtDay_" + intRowNo.ToString + "_1", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency1"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), 2), String) + "</A>")
                'End If

                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_2", "txtDay_" + intRowNo.ToString + "_2", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency2"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_3", "txtDay_" + intRowNo.ToString + "_3", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency3"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_4", "txtDay_" + intRowNo.ToString + "_4", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency4"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_5", "txtDay_" + intRowNo.ToString + "_5", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency5"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_6", "txtDay_" + intRowNo.ToString + "_6", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency6"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_7", "txtDay_" + intRowNo.ToString + "_7", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency7"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), 2), String) + "</A>")
                'End If

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_1", "txtDay_" + intRowNo.ToString + "_1", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency1"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), 2), String) + "</A>")
                'End If

                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_2", "txtDay_" + intRowNo.ToString + "_2", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency2"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), 2), String) + "</A>")
                'End If

                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_3", "txtDay_" + intRowNo.ToString + "_3", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency3"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), 2), String) + "</A>")
                'End If

                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_4", "txtDay_" + intRowNo.ToString + "_4", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency4"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), 2), String) + "</A>")
                'End If

                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_5", "txtDay_" + intRowNo.ToString + "_5", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency5"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), 2), String) + "</A>")
                'End If

                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_6", "txtDay_" + intRowNo.ToString + "_6", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency6"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), 2), String) + "</A>")
                'End If

                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_7", "txtDay_" + intRowNo.ToString + "_7", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency7"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), 2), String) + "</A>")
                'End If

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day1"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_1", "txtDay_" + intRowNo.ToString + "_1", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency1"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), 2), String) + "</A>")
                End If

                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day2"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_2", "txtDay_" + intRowNo.ToString + "_2", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency2"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), 2), String) + "</A>")
                End If
                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day3"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_3", "txtDay_" + intRowNo.ToString + "_3", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency3"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), 2), String) + "</A>")
                End If
                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day4"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_4", "txtDay_" + intRowNo.ToString + "_4", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency4"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), 2), String) + "</A>")
                End If
                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day5"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_5", "txtDay_" + intRowNo.ToString + "_5", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency5"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), 2), String) + "</A>")
                End If
                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day6"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_6", "txtDay_" + intRowNo.ToString + "_6", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency6"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), 2), String) + "</A>")
                End If
                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day7"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_7", "txtDay_" + intRowNo.ToString + "_7", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency7"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), 2), String) + "</A>")
                End If

                'End of modification by MonikaI

                Response.Write("<ELEMENT_SEPERATOR>")
                intloopCounter += 1
            End While

        End If

        CommonFunctions.Data.DisposeDataReader(drCostHead)
    End Sub

    Public Sub EditProject()
        Dim intloopCounter As Integer
        Dim drCostHead As IDataReader
        Dim intRowNo As Integer
        Dim intCount As Integer
        Dim strProjectID As String

        Dim strRows As String
        Dim arrRowIds() As String

        Dim dtmTodaysDate As Date

        dtmTodaysDate = Date.Today()

        strRows = CType(Request.QueryString("RowIDS"), String)
        strProjectID = CType(Request.QueryString("ProjectID"), String)
        arrRowIds = strRows.Split(CType(",", Char))

        If Request.QueryString("Action") = "EditProject" Then
            Response.Clear()
            ' For intCount = 0 To arrRowIds.Length() - 1
            'If arrRowIds(intCount) <> "" Then
            drCostHead = CommonFunctions.Data.GetDataReader("usp_sel_Expenses_forEmployee_Weekly " + CType(Session("intuserID"), String) + ",'" + CType(m_dtStartDateOfWeek, String) + "','" + CType(m_dtEndDateOfWeek, String) + "',NULL," + strProjectID, MyBase.UseSQL)

            intloopCounter = 0
            While drCostHead.Read()
                intRowNo = CType(drCostHead("RowNo"), Integer)
                CommonFunctions.General.WriteHTML(CType(drCostHead("CostHead"), String))
                Response.Write("<ELEMENT_SEPERATOR>")

                'Commented and modified by MonikaI on 13th Oct 2006 IssueID : 6668
                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_1", "txtDay_" + intRowNo.ToString + "_1", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency1"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_2", "txtDay_" + intRowNo.ToString + "_2", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency2"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_3", "txtDay_" + intRowNo.ToString + "_3", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency3"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_4", "txtDay_" + intRowNo.ToString + "_4", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency4"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_5", "txtDay_" + intRowNo.ToString + "_5", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency5"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_6", "txtDay_" + intRowNo.ToString + "_6", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency6"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek), dtmTodaysDate) < 0) Or (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)) > 0) Then
                '        CommonFunctions.General.WriteHTML("")
                '    Else
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_7", "txtDay_" + intRowNo.ToString + "_7", , 50, 7, , "right")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency7"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), 2), String) + "</A>")
                'End If

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_1", "txtDay_" + intRowNo.ToString + "_1", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency1"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_2", "txtDay_" + intRowNo.ToString + "_2", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency2"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_3", "txtDay_" + intRowNo.ToString + "_3", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency3"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_4", "txtDay_" + intRowNo.ToString + "_4", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency4"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_5", "txtDay_" + intRowNo.ToString + "_5", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency5"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_6", "txtDay_" + intRowNo.ToString + "_6", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency6"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), 2), String) + "</A>")
                'End If
                'Response.Write("<ELEMENT_SEPERATOR>")

                'If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), String) = "" Then
                '    If (DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek), dtmTodaysDate) >= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("EndDate"), ""), Date), DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)) <= 0) And (DateDiff(DateInterval.Day, CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("StartDate"), ""), Date), DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)) >= 0) Then
                '        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_7", "txtDay_" + intRowNo.ToString + "_7", , 50, 7, , "right")
                '    Else
                '        CommonFunctions.General.WriteHTML("")
                '    End If
                'Else
                '    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency7"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), 2), String) + "</A>")
                'End If

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day1"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_1", "txtDay_" + intRowNo.ToString + "_1", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency1"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), 2), String) + "</A>")
                End If
                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day2"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_2", "txtDay_" + intRowNo.ToString + "_2", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency2"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), 2), String) + "</A>")
                End If
                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day3"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_3", "txtDay_" + intRowNo.ToString + "_3", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency3"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), 2), String) + "</A>")
                End If
                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day4"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_4", "txtDay_" + intRowNo.ToString + "_4", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency4"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), 2), String) + "</A>")
                End If
                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day5"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_5", "txtDay_" + intRowNo.ToString + "_5", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency5"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), 2), String) + "</A>")
                End If
                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day6"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_6", "txtDay_" + intRowNo.ToString + "_6", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency6"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), 2), String) + "</A>")
                End If
                Response.Write("<ELEMENT_SEPERATOR>")

                If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), String) = "" Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Day7"), ""), String) = "" Then
                        CommonFunctions.General.WriteHTML("")
                    Else
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDay_" + intRowNo.ToString + "_7", "txtDay_" + intRowNo.ToString + "_7", , 50, 7, , "right", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    End If
                Else
                    CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency7"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), 2), String) + "</A>")
                End If

                'End of modification by MonikaI
                Response.Write("<ELEMENT_SEPERATOR>")
                Response.Write("<ROW_SEPERATOR>")
                intloopCounter += 1
            End While

        End If
        CommonFunctions.Data.DisposeDataReader(drCostHead)
        'Next
        'End If
    End Sub
#End Region

#Region "Constructor"
    Public Sub New()

        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.EWF_WeeklyView", "AppResources")
    End Sub
#End Region

#Region "Plot Page"
    Private Sub DrawMenu()
        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        arrClientSideFunctionList.Add("Save_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_PREVIOUS_WEEK"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_PREVIOUS_WEEK_TOOLTIP"))
        arrClientSideFunctionList.Add("PreviousWeek_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_NEXT_WEEK"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_NEXT_WEEK_TOOLTIP"))
        arrClientSideFunctionList.Add("NextWeek_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
        arrClientSideFunctionList.Add("Back_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('EWF_WeeklyView')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Sub DrawDetailsMenu()
        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        arrClientSideFunctionList.Add("SaveDetails_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DELETE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP"))
        arrClientSideFunctionList.Add("DeleteDetails_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('EWF_WeeklyView')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Sub DrawCommonControls()
        CommonFunctions.General.WriteHTML("<Table cellSpacing='1' cellPadding='0' width='99.9%' border='0'>")
        CommonFunctions.General.WriteHTML("<tbody>")
        CommonFunctions.General.WriteHTML("<tr>")

        'Currency
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabel' align='left'><B>" + MyBase.GetResourceString("CURRENCY") + " </B></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabelLeft' align='left'>")
        CommonFunctions.HTMLControls.DrawComboBox("CboCurrency", "usp_sel_currency_for_ExpenseEntry ", 150, m_CurrencyID, , True, )
        CommonFunctions.General.WriteHTML("<IMG src=""../../Images/Star.gif"" border=0></TD>")

        'Country
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabel' align='left'><B>" + MyBase.GetResourceString("COUNTRY") + " </B></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabelLeft' align='left'>")
        CommonFunctions.HTMLControls.DrawComboBox("CboCountry", "usp_sel_country_for_ExpenseEntry ", 150, m_CountryID, , True, )
        CommonFunctions.General.WriteHTML("<IMG src=""../../Images/Star.gif"" border=0></TD>")
        'CommonFunctions.General.WriteHTML("</tr>")

        'Finanace Processing Center
        'CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabel' align='left'><B>" + MyBase.GetResourceString("FPCENTER") + " </B></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabelLeft' align='left'>")
        CommonFunctions.HTMLControls.DrawComboBox("CboFpCenter", "usp_sel_FPCenter_for_ExpenseEntry ", 150, m_FPID, , True, )
        CommonFunctions.General.WriteHTML("<IMG src=""../../Images/Star.gif"" border=0></TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</tbody>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub

    Private Sub DrawDetailsGrid()
        Dim dtmEntryDate As String
        Dim strEmployeeID As String
        Dim strProjectID As String
        Dim strCostHeadID As String
        'Dim drDetails As IDataReader
        Dim strSQL As String

        dtmEntryDate = CType(Request("hidEntryDate"), String)
        strEmployeeID = CType(Request("hidEmployeeID"), String)
        strProjectID = CType(Request("hidProjectID"), String)
        strCostHeadID = CType(Request("hidCostHeadID"), String)

        'strSQL = "SELECT ExpensesEntryID,tbl_PM_Expenses.ProjectID,tbl_CNF_CostHeads.CostHead,SubItemID as CostHeadID,Amount, " + _
        '         "CurrencyID,IsBillable,tbl_PM_Expenses.[Description],CountryID,FPCenterID,PaymentMode ," + _
        '         " ( CASE When Exists( SELECT ExpensesEntryID FROM tbl_PM_ExpenseEntry_Status " + _
        '         " WHERE ActionTaken not in( 'Draft','REJECTED' ) AND " + _
        '         " ExpensesEntryID = tbl_PM_Expenses.ExpensesEntryID ) then  1 else 0 END ) as IsSubmitted ," + _
        '         " (SELECT TOP 1 UserCanOverRide FROM  tbl_PM_WorkOrderCostsDetails WHERE WorkOrderCostID = (SELECT WorkOrderCostID FROM tbl_PM_WorkOrderCosts WHERE CostHeadID =" + strCostHeadID + " AND ProjectID= " + strProjectID + ")" + _
        '         " AND ((DATEDIFF(DD,StartDate,'" + m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") + "' )>=0 AND DATEDIFF(DD,EndDate,'" + m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") + "')<=0) " + _
        '         " OR (DATEDIFF(DD,StartDate,'" + m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") + "')>=0 AND DATEDIFF(DD,EndDate,'" + m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") + "')<=0))) As UserCanOverRide " + _
        '         " FROM tbl_PM_Expenses LEFT JOIN tbl_CNF_CostHeads " + _
        '         " ON tbl_CNF_CostHeads.CostHeadID = tbl_PM_Expenses.SubItemID " + _
        '         " WHERE EntryDate ='" + dtmEntryDate + "' AND " + _
        '         " EmployeeID = " + strEmployeeID + " AND " + _
        '         " tbl_PM_Expenses.ProjectID = " + strProjectID + " And SubItemID = " + strCostHeadID

        strSQL = " usp_sel_Expenses_Details_Weekly " + strCostHeadID + "," + strProjectID + ",'" + m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") + "','" + m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") + "','" + dtmEntryDate + "'," + strEmployeeID

        'drDetails = CommonFunctions.Data.GetDataReader("SELECT * FROM tbl_PM_Expenses WHERE EntryDate ='" + dtmEntryDate + "' AND EmployeeID = " + strEmployeeID + " AND ProjectID = " + strProjectID + " AND SubItemID = " + strCostHeadID, MyBase.UseSQL)
        'CommonFunctions.Data.DisposeDataReader(drDetails)


        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList

        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=center"}
        Dim arrColRowLinks() As String = {"", "", "", "", "", "", "", "", "", "", ""}
        Dim arrCheckBoxArray() As String = {"", "", "", "", "", "", "", "", "", "", "chkDelete"}

        Dim arrLegend() As String = {"All fields are Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        '##### Get Page Title from Reosrces and Display
        'CommonFunctions.General.WriteHTML("<br>")
        WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        ''WebPages.Template.PageCaption.GetPageCaptions(, "Expense Details ", "<FONT color=black>Project : </FONT>" + CType(CommonFunctions.Data.GetDataScalar("SELECT ProjectName From tbl_PM_Project WHERE ProjectID =" + strProjectID, MyBase.UseSQL), String) + " <FONT color=black> Date : </FONT> " + dtmEntryDate)
        WebPages.Template.PageCaption.GetPageCaptions(, "Expense Details ", "<FONT color=black>Project : </FONT>" + CType(CommonFunctions.Data.GetDataScalar("usp_sel_ProjectName_tbl_PM_Project " + strProjectID, MyBase.UseSQL), String) + " <FONT color=black> Date : </FONT> " + dtmEntryDate)
        ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        'WebPages.Template.PageCaption.GetPageCaptions(, "<FONT color=blue>Project : </FONT>" + CType(CommonFunctions.Data.GetDataScalar("SELECT ProjectName From tbl_PM_Project WHERE ProjectID =" + strProjectID, MyBase.UseSQL), String) + " <FONT color=blue> Date : </FONT> " + dtmEntryDate, )
        CommonFunctions.General.WriteHTML("<br><DIV id=DivList style='Overflow:auto;width=100%;Height:300'>")


        '##### Get Column Headings from Resources 
        arrColumnHeadingList.Add("Cost Head")
        arrColumnHeadingList.Add("Currency")
        arrColumnHeadingList.Add("Amount")
        arrColumnHeadingList.Add("Billable")
        arrColumnHeadingList.Add("Description")
        arrColumnHeadingList.Add("Country")
        arrColumnHeadingList.Add("Finance Processing Center")
        arrColumnHeadingList.Add("Mode of Payment")
        arrColumnHeadingList.Add("Delete")
        '##### End 

        '##### Actual Column Names List
        arrActualColumnNames.Add("CostHead")
        arrActualColumnNames.Add("CurrencyID")
        arrActualColumnNames.Add("Amount")
        arrActualColumnNames.Add("IsBillable")
        arrActualColumnNames.Add("Description")
        arrActualColumnNames.Add("CountryID")
        arrActualColumnNames.Add("FPCenterID")
        arrActualColumnNames.Add("PaymentMode")
        arrActualColumnNames.Add("ExpensesEntryID")
        '##### End


        With m_objDetailsGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .CheckBoxIDArray = arrCheckBoxArray
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 9
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .SQL = strSQL
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .EmptyValueReplacement = ""
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        m_objDetailsGrid = Nothing
        CommonFunction.General.WriteHTML("<br></div>")

        'Draw 4 Hidden COntrols for EntryDate,EmployeeID,ProjectID,CostHeadID

        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("hidEntryDate", "hidEntryDate", , , , dtmEntryDate, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("hidEmployeeID", "hidEmployeeID", , , , strEmployeeID, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("hidProjectID", "hidProjectID", , , , strProjectID, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("hidCostHeadID", "hidCostHeadID", , , , strCostHeadID, , , , , , True, EnableHTMLEncode:=True)

        'Total DetailsrowCount in the hidden field
        CommonFunctions.HTMLControls.DrawTextBox("txthidDetailsRowCount", "txthidDetailsRowCount", , , , m_DetailsRowCount.ToString, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
    End Sub

    Private Sub DrawGrid()
        Dim strWeekDay As String
        Dim strColumnValue As String
        Dim drCostHead As IDataReader
        drCostHead = CommonFunctions.Data.GetDataReader("usp_sel_Expenses_forEmployee_Weekly " + CType(Session("intuserID"), String) + ",'" + CType(m_dtStartDateOfWeek, String) + "','" + CType(m_dtEndDateOfWeek, String) + "'", MyBase.UseSQL)

        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:430px'>")
        CommonFunctions.General.WriteHTML("<Table class='clsGridTable' cellpadding=0 cellspacing=1 width='99.9%' border='0'>")
        CommonFunctions.General.WriteHTML("<tbody>")

        'Display Heading
        CommonFunctions.General.WriteHTML("<THead class='clsTRColumnHeader'>")
        'CommonFunctions.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        'CommonFunctions.General.WriteHTML("Project Name")
        'CommonFunctions.General.WriteHTML("</TH>")
        CommonFunctions.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        CommonFunctions.General.WriteHTML("Cost Head")
        CommonFunctions.General.WriteHTML("</TH>")
        CommonFunctions.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        strWeekDay = WeekdayName(1, True, CType(m_intStartingDayOfWeek, Microsoft.VisualBasic.FirstDayOfWeek))
        strColumnValue = strWeekDay + "<br>[" + GetShortDate(DateAdd(DateInterval.Day, 0, m_dtStartDateOfWeek)) + "]"
        CommonFunctions.General.WriteHTML(strColumnValue)
        CommonFunctions.General.WriteHTML("</TH>")
        CommonFunctions.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        strWeekDay = WeekdayName(2, True, CType(m_intStartingDayOfWeek, Microsoft.VisualBasic.FirstDayOfWeek))
        strColumnValue = strWeekDay + "<br>[" + GetShortDate(DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek)) + "]"
        CommonFunctions.General.WriteHTML(strColumnValue)
        CommonFunctions.General.WriteHTML("</TH>")
        CommonFunctions.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        strWeekDay = WeekdayName(3, True, CType(m_intStartingDayOfWeek, Microsoft.VisualBasic.FirstDayOfWeek))
        strColumnValue = strWeekDay + "<br>[" + GetShortDate(DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek)) + "]"
        CommonFunctions.General.WriteHTML(strColumnValue)
        CommonFunctions.General.WriteHTML("</TH>")
        CommonFunctions.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        strWeekDay = WeekdayName(4, True, CType(m_intStartingDayOfWeek, Microsoft.VisualBasic.FirstDayOfWeek))
        strColumnValue = strWeekDay + "<br>[" + GetShortDate(DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek)) + "]"
        CommonFunctions.General.WriteHTML(strColumnValue)
        CommonFunctions.General.WriteHTML("</TH>")
        CommonFunctions.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        strWeekDay = WeekdayName(5, True, CType(m_intStartingDayOfWeek, Microsoft.VisualBasic.FirstDayOfWeek))
        strColumnValue = strWeekDay + "<br>[" + GetShortDate(DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek)) + "]"
        CommonFunctions.General.WriteHTML(strColumnValue)
        CommonFunctions.General.WriteHTML("</TH>")
        CommonFunctions.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        strWeekDay = WeekdayName(6, True, CType(m_intStartingDayOfWeek, Microsoft.VisualBasic.FirstDayOfWeek))
        strColumnValue = strWeekDay + "<br>[" + GetShortDate(DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek)) + "]"
        CommonFunctions.General.WriteHTML(strColumnValue)
        CommonFunctions.General.WriteHTML("</TH>")
        CommonFunctions.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        strWeekDay = WeekdayName(7, True, CType(m_intStartingDayOfWeek, Microsoft.VisualBasic.FirstDayOfWeek))
        strColumnValue = strWeekDay + "<br>[" + GetShortDate(DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)) + "]"
        CommonFunctions.General.WriteHTML(strColumnValue)
        CommonFunctions.General.WriteHTML("</TH>")
        CommonFunctions.General.WriteHTML("</THead>")

        Dim strTRClass As String
        Dim strProjectName As String
        Dim intRowCounter As Integer
        Dim intColCounter As Integer

        Dim strRows As String
        Dim strLastProjectID As String

        strTRClass = "clsTROdd"
        strProjectName = ""
        intRowCounter = 1
        intColCounter = 1

        'There are Now items to show
        If drCostHead.RecordsAffected = 0 Then
            CommonFunctions.General.WriteHTML("<TR class='clsTREvenRow'><TD align=Center colspan=8>There are no items to show in this view.</TD></TR>")
            'Draw Grid
        Else
            While drCostHead.Read()
                intColCounter = 1
                If strProjectName <> CType(drCostHead("ProjectName"), String) Then
                    'Printing ProjectName in Group Header
                    CommonFunctions.General.WriteHTML("<tr class=clsTRGroupHeader valign=top>")
                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=Left colspan=7 id=tdGroupHeader_" + intRowCounter.ToString + " name=tdGroupHeader_" + intRowCounter.ToString + ">")
                    CommonFunctions.General.WriteHTML(CType(drCostHead("ProjectName"), String))
                    CommonFunctions.General.WriteHTML("</TD>")
                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=Left><A href='javascript:EditProject(" + CType(drCostHead("ProjectID"), String) + ")' Title='Add Expenses to this Project'>Edit Project</A>")
                    CommonFunctions.General.WriteHTML("</TD>")
                    CommonFunctions.General.WriteHTML("</TR>")

                    CommonFunctions.General.WriteHTML("<tr class='" + strTRClass + "' valign=top id='tr_" + intRowCounter.ToString + "' name='tr_" + intRowCounter.ToString + "'>")
                    'Cost Head
                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=Left id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " onClick='javascript:EditRow(" + intRowCounter.ToString + ")' >")
                    CommonFunctions.General.WriteHTML(CType(drCostHead("CostHead"), String))
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay1", "txtDay1", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency1"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay2", "txtDay2", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency2"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay3", "txtDay3", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency3"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay4", "txtDay4", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency4"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay5", "txtDay5", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency5"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay6", "txtDay6", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency6"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay7", "txtDay7", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency7"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1
                    CommonFunctions.General.WriteHTML("</TR>")
                    'Drawing Hidden COntrols for ProjectiD,CostheadID,IsBillable
                    'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    CommonFunctions.HTMLControls.DrawTextBox("txthidProjectID_" + intRowCounter.ToString, "txthidProjectID_" + intRowCounter.ToString, , , , CType(drCostHead("ProjectID"), String), , , , , , True, EnableHTMLEncode:=True)
                    CommonFunctions.HTMLControls.DrawTextBox("txthidCostHead_" + intRowCounter.ToString, "txthidCostHead_" + intRowCounter.ToString, , , , CType(drCostHead("CostHead"), String), , , , , , True, EnableHTMLEncode:=True)
                    CommonFunctions.HTMLControls.DrawTextBox("txthidCostHeadID_" + intRowCounter.ToString, "txthidCostHeadID_" + intRowCounter.ToString, , , , CType(drCostHead("CostHeadID"), String), , , , , , True, EnableHTMLEncode:=True)
                    CommonFunctions.HTMLControls.DrawTextBox("txthidIsBillable_" + intRowCounter.ToString, "txthidIsBillable_" + intRowCounter.ToString, , , , CType(CheckIsDBNull(drCostHead("Billable1"), ""), String), , , , , , True, EnableHTMLEncode:=True)
                    'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    'Drwa TextBox for Storing RowIDS fr Each Project
                    If strRows <> "" Then
                        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txthidRowsforProject_" + strLastProjectID, "txthidRowsforProject_" + strLastProjectID, , , , strRows, , , , , , True, EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        strRows = ""
                    End If
                Else
                    CommonFunctions.General.WriteHTML("<tr class='" + strTRClass + "' valign=top id='tr_" + intRowCounter.ToString + "' name='tr_" + intRowCounter.ToString + "' >")
                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=Left  id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " onClick='javascript:EditRow(" + intRowCounter.ToString + ")'>")
                    CommonFunctions.General.WriteHTML(CType(drCostHead("CostHead"), String))
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay1", "txtDay1", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency1"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("1"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay2", "txtDay2", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency2"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("2"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay3", "txtDay3", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency3"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("3"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay4", "txtDay4", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency4"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("4"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay5", "txtDay5", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency5"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("5"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay6", "txtDay6", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency6"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("6"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1

                    CommonFunctions.General.WriteHTML("<TD   nowrap  align=right id=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " name=td_" + intRowCounter.ToString + "_" + intColCounter.ToString + " >")
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), String) = "" Then
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDay7", "txtDay7", , 50)
                    Else
                        CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drCostHead("Currency7"), ""), String) + "&nbsp;&nbsp;&nbsp;<A href='javascript:ShowExpense(""" + DateAdd(DateInterval.Day, intColCounter - 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + """," + CType(Session("intUserID"), String) + "," + CType(drCostHead("ProjectID"), String) + "," + CType(drCostHead("CostHeadID"), String) + ")'>" + CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drCostHead("7"), ""), 2), String) + "</A>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")
                    intColCounter += 1
                    CommonFunctions.General.WriteHTML("</TR>")
                    'Drawing Hidden COntrols for ProjectiD,CostheadID,IsBillable
                    'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    CommonFunctions.HTMLControls.DrawTextBox("txthidProjectID_" + intRowCounter.ToString, "txthidProjectID_" + intRowCounter.ToString, , , , CType(drCostHead("ProjectID"), String), , , , , , True, EnableHTMLEncode:=True)
                    CommonFunctions.HTMLControls.DrawTextBox("txthidCostHeadID_" + intRowCounter.ToString, "txthidCostHeadID_" + intRowCounter.ToString, , , , CType(drCostHead("CostHeadID"), String), , , , , , True, EnableHTMLEncode:=True)
                    CommonFunctions.HTMLControls.DrawTextBox("txthidCostHead_" + intRowCounter.ToString, "txthidCostHead_" + intRowCounter.ToString, , , , CType(drCostHead("CostHead"), String), , , , , , True, EnableHTMLEncode:=True)
                    CommonFunctions.HTMLControls.DrawTextBox("txthidIsBillable_" + intRowCounter.ToString, "txthidIsBillable_" + intRowCounter.ToString, , , , CType(CheckIsDBNull(drCostHead("Billable1"), ""), String), , , , , , True, EnableHTMLEncode:=True)
                    'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                End If

                If strTRClass = "clsTROdd" Then
                    strTRClass = "clsTREven"
                Else
                    strTRClass = "clsTROdd"
                End If
                strProjectName = CType(drCostHead("ProjectName"), String)
                strRows = strRows + "," + intRowCounter.ToString
                intRowCounter += 1
                strLastProjectID = CType(drCostHead("ProjectID"), String)
            End While
        End If
        'Draw Hidden for lastProject
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidRowsforProject_" + strLastProjectID, "txthidRowsforProject_" + strLastProjectID, , , , strRows, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        strRows = ""

        CommonFunctions.General.WriteHTML("</tbody>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.General.WriteHTML("</div>")

        'Draw the Note In the Page Footer
        Dim arrLegend() As String = {"<FONT Color=blue>Note : </FONT>Future date Entries are not allowed"}
        Dim arrLegendImage() As String = {""}
        WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("hid_RowsCount", "hid_RowsCount", , , , CType(intRowCounter - 1, String), , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.Data.DisposeDataReader(drCostHead)
    End Sub
#End Region

#Region "Save data"
    Private Sub SaveExpenses()
        '=====================================================================
        ' Purpose               : Save Expenses
        ' Author                : SantoshK
        ' Created               : 22 May 2006
        '=====================================================================
        Dim intNoOfRows As Integer
        Dim intRowCount As Integer
        Dim intColCount As Integer
        Dim fltValue As Double

        Dim strProjectID As String
        Dim strCostheadID As String
        Dim strDescription As String
        Dim intIsBillable As Integer
        Dim drBillable As IDataReader

        intNoOfRows = CType(Request("hid_RowsCount"), Integer)
        'Commented And Added By Usha Pandit On 11.02.2021 For Save taking time due to un-necessary db roundtrip for empty rows
        'For intRowCount = 1 To intNoOfRows
        '    'Added by MonikaI on 18th Oct 2006. To handle multiple entries, in the same week, under one CostHead. 
        '    drBillable = CommonFunctions.Data.GetDataReader("usp_sel_Expenses_forEmployee_Weekly " + CType(Session("intuserID"), String) + ",'" + CType(m_dtStartDateOfWeek, String) + "','" + CType(m_dtEndDateOfWeek, String) + "'," + CType(intRowCount, String), MyBase.UseSQL)
        '    'End by MonikaI
        '    If drBillable.Read Then
        '        For intColCount = 1 To 7
        '            If CType(Request("txtDay_" + intRowCount.ToString + "_" + intColCount.ToString), String) <> "" Then
        '                fltValue = CType(Request("txtDay_" + intRowCount.ToString + "_" + intColCount.ToString), Double)
        '                strProjectID = CType(Request("txthidProjectID_" + intRowCount.ToString), String)
        '                strCostheadID = CType(Request("txthidCostHeadID_" + intRowCount.ToString), String)
        '                'Code commented by PrashantD on 26 Jun 2007 for IssueID 12377
        '                'strDescription = Server.HtmlEncode(CType(Request("txthidCostHead_" + intRowCount.ToString), String))
        '                strDescription = CType(Request("txthidCostHead_" + intRowCount.ToString), String)
        '                'End of addition by PrashantD on 26 Jun 2007
        '                'By MonikaI
        '                If CType(CheckIsDBNull(drBillable("Billable" + intColCount.ToString), ""), String) = "" Then
        '                    intIsBillable = 0
        '                Else
        '                    intIsBillable = CType(drBillable("Billable" + intColCount.ToString), Integer)
        '                End If
        '                'End by MonikaI
        '                'code commented and added by PrashantD on 8 March 2007 for IssueID 11091
        '                'CommonFunctions.Data.InsertOrUpdateData("usp_ins_tbl_PM_Expenses_for_ExpenseEntry '" + DateAdd(DateInterval.Day, intColCount - 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + "'," + strProjectID + "," + strCostheadID + "," + CType(fltValue, String) + "," + CType(Session("intUserID"), String) + ",'" + strDescription + "', ''," + m_CurrencyID + "," + m_CountryID + "," + m_FPID + ",'" + CType(Date.Today(), String) + "'," + CType(intIsBillable, String) + ", '0'", MyBase.UseSQL)
        '                CommonFunctions.Data.InsertOrUpdateData("usp_ins_tbl_PM_Expenses_for_ExpenseEntry '" + DateAdd(DateInterval.Day, intColCount - 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + "'," + strProjectID + "," + strCostheadID + "," + CType(fltValue, String) + "," + CType(Session("intUserID"), String) + ",'" + CommonFunction.General.BuildQueryString(strDescription) + "', ''," + m_CurrencyID + "," + m_CountryID + "," + m_FPID + ",'" + CType(Date.Today(), String) + "'," + CType(intIsBillable, String) + ", '0'", MyBase.UseSQL)
        '            End If
        '        Next
        '    End If
        '    CommonFunction.Data.DisposeDataReader(drBillable)
        'Next

        For intRowCount = 1 To intNoOfRows
            If CType(Request("txtDay_" + intRowCount.ToString + "_" + "1"), String) = "" _
                And CType(Request("txtDay_" + intRowCount.ToString + "_" + "2"), String) = "" _
                And CType(Request("txtDay_" + intRowCount.ToString + "_" + "3"), String) = "" _
                And CType(Request("txtDay_" + intRowCount.ToString + "_" + "4"), String) = "" _
                And CType(Request("txtDay_" + intRowCount.ToString + "_" + "5"), String) = "" _
                And CType(Request("txtDay_" + intRowCount.ToString + "_" + "6"), String) = "" _
                And CType(Request("txtDay_" + intRowCount.ToString + "_" + "7"), String) = "" Then

            Else
                'Added by MonikaI on 18th Oct 2006. To handle multiple entries, in the same week, under one CostHead. 
                drBillable = CommonFunctions.Data.GetDataReader("usp_sel_Expenses_forEmployee_Weekly " + CType(Session("intuserID"), String) + ",'" + CType(m_dtStartDateOfWeek, String) + "','" + CType(m_dtEndDateOfWeek, String) + "'," + CType(intRowCount, String), MyBase.UseSQL)
                'End by MonikaI
                If drBillable.Read Then
                    For intColCount = 1 To 7
                        If CType(Request("txtDay_" + intRowCount.ToString + "_" + intColCount.ToString), String) <> "" Then
                            fltValue = CType(Request("txtDay_" + intRowCount.ToString + "_" + intColCount.ToString), Double)
                            strProjectID = CType(Request("txthidProjectID_" + intRowCount.ToString), String)
                            strCostheadID = CType(Request("txthidCostHeadID_" + intRowCount.ToString), String)
                            'Code commented by PrashantD on 26 Jun 2007 for IssueID 12377
                            'strDescription = Server.HtmlEncode(CType(Request("txthidCostHead_" + intRowCount.ToString), String))
                            strDescription = CType(Request("txthidCostHead_" + intRowCount.ToString), String)
                            'End of addition by PrashantD on 26 Jun 2007
                            'By MonikaI
                            If CType(CheckIsDBNull(drBillable("Billable" + intColCount.ToString), ""), String) = "" Then
                                intIsBillable = 0
                            Else
                                intIsBillable = CType(drBillable("Billable" + intColCount.ToString), Integer)
                            End If
                            'End by MonikaI
                            'code commented and added by PrashantD on 8 March 2007 for IssueID 11091
                            'CommonFunctions.Data.InsertOrUpdateData("usp_ins_tbl_PM_Expenses_for_ExpenseEntry '" + DateAdd(DateInterval.Day, intColCount - 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + "'," + strProjectID + "," + strCostheadID + "," + CType(fltValue, String) + "," + CType(Session("intUserID"), String) + ",'" + strDescription + "', ''," + m_CurrencyID + "," + m_CountryID + "," + m_FPID + ",'" + CType(Date.Today(), String) + "'," + CType(intIsBillable, String) + ", '0'", MyBase.UseSQL)
                            CommonFunctions.Data.InsertOrUpdateData("usp_ins_tbl_PM_Expenses_for_ExpenseEntry '" + DateAdd(DateInterval.Day, intColCount - 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") + "'," + strProjectID + "," + strCostheadID + "," + CType(fltValue, String) + "," + CType(Session("intUserID"), String) + ",'" + CommonFunction.General.BuildQueryString(strDescription) + "', ''," + m_CurrencyID + "," + m_CountryID + "," + m_FPID + ",'" + CType(Date.Today(), String) + "'," + CType(intIsBillable, String) + ", '0'", MyBase.UseSQL)
                        End If
                    Next
                End If
                CommonFunction.Data.DisposeDataReader(drBillable)
            End If

        Next

    End Sub

    Private Sub SaveDetails()
        '=====================================================================
        ' Purpose               : Save the Details after clicking on link 
        ' Author                : SantoshK
        ' Created               : 22 May 2006
        '=====================================================================
        Dim intDetailsRowCount As Integer
        Dim intRowCounter As Integer
        Dim strExpenseEntryID As String

        Dim dblAmount As Double
        Dim intCurrencyID As Integer
        Dim strDescription As String
        Dim intCountryID As Integer
        Dim intFPID As Integer
        Dim intPaymentMode As Integer
        Dim blnIsBillable As Boolean
        Dim strSQL As String

        intDetailsRowCount = CType(Request("txthidDetailsRowCount"), Integer)
        For intRowCounter = 1 To intDetailsRowCount
            strExpenseEntryID = CType(CommonFunctions.General.CheckIsNothing(Request("txthidExpenseEntry_" + intRowCounter.ToString), ""), String)

            dblAmount = CType(CommonFunctions.General.CheckIsNothing(Request("txtAmount_" + strExpenseEntryID), ""), Double)
            intCurrencyID = CType(CommonFunctions.General.CheckIsNothing(Request("cboDeailsCurrencyID_" + strExpenseEntryID), ""), Integer)
            'Code commented and added by PrashantD on 26 Jun 2007 for IssueID 12377
            'strDescription = Server.HtmlEncode(CType(CommonFunctions.General.CheckIsNothing(Request("txtDescription_" + strExpenseEntryID), ""), String))
            strDescription = CType(CommonFunctions.General.CheckIsNothing(Request("txtDescription_" + strExpenseEntryID), ""), String)
            'End of addition by PrashantD on 26 Jun 2007 for IssueID 12377
            strDescription = strDescription.Replace("'", "''")
            intCountryID = CType(CommonFunctions.General.CheckIsNothing(Request("cboDeailsCountryID_" + strExpenseEntryID), ""), Integer)
            intFPID = CType(CommonFunctions.General.CheckIsNothing(Request("cboDeailsFPID_" + strExpenseEntryID), ""), Integer)
            If CommonFunctions.General.CheckIsNothing(Request("cboPaymentMode_" + strExpenseEntryID), "") <> "" Then
                intPaymentMode = CType(CommonFunctions.General.CheckIsNothing(Request("cboPaymentMode_" + strExpenseEntryID), "0"), Integer)
            Else
                intPaymentMode = 0
            End If
            blnIsBillable = CType(CommonFunctions.General.CheckIsNothing(Request("chkIsBillable_" + strExpenseEntryID), "0"), Boolean)


            strSQL = "Update tbl_PM_Expenses SET "
            strSQL += " AMOUNT = " + dblAmount.ToString
            strSQL += " , CountryID = " + intCountryID.ToString
            strSQL += " , CurrencyID = " + intCurrencyID.ToString
            strSQL += " , FPCenterID = " + intFPID.ToString
            strSQL += "  , PaymentMode = '" + intPaymentMode.ToString + "' "
            strSQL += ", Description = '" + strDescription + "' "
            strSQL += " , IsBillable = " + CType(IIf(blnIsBillable = True, 1, 0), String)
            strSQL += " , Advance = '0' "
            strSQL += " WHERE ExpensesEntryID = " + strExpenseEntryID

            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        Next

    End Sub
#End Region

#Region "Delete Details"
    Private Sub DeleteDetails()
        Dim m_strExpenseEntryID As String
        Dim arrIDs() As String
        Dim lenArray As Integer

        If CType(Request.Form("chkDelete"), String) <> "" Then
            m_strExpenseEntryID = CType(Request.Form("chkDelete"), String)

            arrIDs = m_strExpenseEntryID.Split(CType(",", Char))
            'Now Insert Into Table
            For lenArray = 0 To arrIDs.Length - 1
                If (arrIDs(lenArray) <> "") Then
                    CommonFunctions.Data.InsertOrUpdateData("DELETE FROM tbl_PM_Expenses WHERE ExpensesEntryID = " + arrIDs(lenArray), MyBase.UseSQL)
                End If
            Next
        End If
    End Sub
#End Region

#Region "General functions"
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
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function

    Private Function StartDateOfWeek(ByVal m_intCurrentDayOfWeek As Integer, ByVal m_intStartingDayOfWeek As Integer) As Date
        Dim tempDate As Date
        Dim intWD As Integer = Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Tuesday)

        Select Case m_intStartingDayOfWeek
            Case 1
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Sunday) - 1), System.DateTime.Now)
            Case 2
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Monday) - 1), System.DateTime.Now)
            Case 3
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Tuesday) - 1), System.DateTime.Now)
            Case 4
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Wednesday) - 1), System.DateTime.Now)
            Case 5
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Thursday) - 1), System.DateTime.Now)
            Case 6
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Friday) - 1), System.DateTime.Now)
            Case 7
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Saturday) - 1), System.DateTime.Now)
        End Select
        Return tempDate
    End Function

    Private Function GetShortDate(ByVal dTDate As Date) As String
        '=====================================================================
        ' Function Name         : GetShortDate()	
        ' Purpose               : returns Short date eg Wed [Nov 30]
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim intDate As Integer
        Dim strMonth As String

        intDate = Day(dTDate)
        strMonth = MonthName(Month(dTDate), True)

        Return (strMonth + " " + CStr(intDate))
    End Function
#End Region

#Region "Grid Events"
    Private Sub m_objDetailsGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objDetailsGrid.DataRowTD_BeforePrint
        Dim m_blnIsSubmitted As Boolean
        Dim m_blnUserCanOverRide As Boolean
        Dim m_blnIsRejected As Boolean
        Dim strInsert As String = ""

        'Commented and modified by MonikaI on 16th Oct 2006
        'm_blnIsSubmitted = CType(Args.DataReader("IsSubmitted"), Boolean)
        m_blnIsSubmitted = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsSubmitted"), "0"), Boolean)
        'End by MonikaI

        'shraddhaM
        ' m_blnIsRejected = CType(Args.DataReader("IsRejected"), Boolean)

        'Commented and modified by MonikaI on 16th Oct 2006
        'm_blnUserCanOverRide = CType(Args.DataReader("UserCanOverRide"), Boolean)
        m_blnUserCanOverRide = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("UserCanOverRide"), "0"), Boolean)
        'End by MonikaI

        If m_blnIsSubmitted = True Then
            strInsert = " disabled"
        End If
        'If m_blnIsRejected = True Then
        'strInsert = "enabled"

        'End If


        'Amount
        If Args.ColumnName = "Amount" Then
            Cancel = True
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawTextBox("txtAmount_" + CType(Args.DataReader("ExpensesEntryID"), String), "txtAmount_" + CType(Args.DataReader("ExpensesEntryID"), String), , 50, 7, CType(Args.DataFieldValue, String), "right", , m_blnIsSubmitted, , , , , True, EnableHTMLEncode:=True) + "</td>"
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        End If

        'Currency
        If Args.ColumnName = "Currency" Then
            Cancel = True
            'Modified by MrugajaB on 19th July 2006 for WhizibleSEM SP7
            'Purpose: Currency combo width should be same as list page ,modified width from 50 to 150
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawComboBox("cboDeailsCurrencyID_" + CType(Args.DataReader("ExpensesEntryID"), String), "usp_sel_currency_for_ExpenseEntry", 150, CType(Args.DataFieldValue, String), strInsert, True, True) + "</td>"
            'End Modification
        End If

        'IsBillable
        If Args.ColumnName = "Billable" Then
            Cancel = True
            Dim isChecked As Boolean

            If CType(Args.DataFieldValue, String) = "1" Then
                isChecked = True
            Else
                isChecked = False
            End If

            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkIsBillable_" + CType(Args.DataReader("ExpensesEntryID"), String), "chkIsBillable_" + CType(Args.DataReader("ExpensesEntryID"), String), , isChecked, CType(Args.DataReader("ExpensesEntryID"), String), CType(IIf(m_blnUserCanOverRide, m_blnIsSubmitted, True), Boolean), , True) + "</td>"
        End If

        'Description
        If Args.ColumnName = "Description" Then
            Cancel = True
            'CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", MyBase.GetResourceString("DESCRIPTION"), , , "DA", , , 545, 80, , Server.HtmlEncode(Trim(m_strDescription)), , , , , , , , True)
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawTextArea("txtDescription_" + CType(Args.DataReader("ExpensesEntryID"), String), "txtDescription_" + CType(Args.DataReader("ExpensesEntryID"), String), "Description", , , "Expenses", , , 120, 50, , CType(Args.DataReader("Description"), String), , , , , , , strInsert, True) + "</td>"
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawTextArea("txtDescription_" + CType(Args.DataReader("ExpensesEntryID"), String), "txtDescription_" + CType(Args.DataReader("ExpensesEntryID"), String), "Description", , , "Expenses", , , 120, 50, , CType(Args.DataReader("Description"), String), , , , , , , strInsert, True, EnableHTMLEncode:=True) + "</td>"
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawTextArea("txtDescription_" + CType(Args.DataReader("ExpensesEntryID"), String), "txtDescription_" + CType(Args.DataReader("ExpensesEntryID"), String), "Description", , , , , , 100, 100, 2000, CType(Args.DataReader("Description"), String), , , , , , , strInsert, True) + "</td>"
        End If

        'Country
        If Args.ColumnName = "Country" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawComboBox("cboDeailsCountryID_" + CType(Args.DataReader("ExpensesEntryID"), String), "usp_sel_country_for_ExpenseEntry", 100, CType(Args.DataFieldValue, String), strInsert, True, True) + "</td>"
        End If

        'Finance processing Center
        If Args.ColumnName = "Finance Processing Center" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawComboBox("cboDeailsFPID_" + CType(Args.DataReader("ExpensesEntryID"), String), "usp_sel_FPCenter_for_ExpenseEntry", 100, CType(Args.DataFieldValue, String), strInsert, True, True) + "</td>"
        End If

        'Payment Mode
        If Args.ColumnName = "Mode of Payment" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawComboBox("cboPaymentMode_" + CType(Args.DataReader("ExpensesEntryID"), String), "usp_sel_PaymentMode_for_ExpenseEntry", 100, CType(Args.DataFieldValue, String), strInsert, True, True) + "</td>"
        End If

        Dim IsUsed As Boolean = False
        IsUsed = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsUsed"), "0"), "0"), Boolean)

        'Delete
        If Args.ColumnName = "Delete" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , CType(Args.DataReader("ExpensesEntryID"), String), IsUsed, , True) + "</td>"
        End If
    End Sub

    Private Sub m_objDetailsGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objDetailsGrid.DataRowTR_BeforePrint
        m_DetailsRowCount += 1
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidExpenseEntry_" + m_DetailsRowCount.ToString, "txthidExpenseEntry_" + m_DetailsRowCount.ToString, , , , CType(Args.DataReader("ExpensesEntryID"), String), , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
    End Sub
#End Region
End Class
