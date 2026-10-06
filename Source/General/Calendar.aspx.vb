Public Class Calendar
    Inherits WebPage.Templates.WhizTemplate


    Protected WithEvents Calendar1 As System.Web.UI.WebControls.Calendar
    Protected WithEvents lnkBtnClearAndClose As System.Web.UI.WebControls.LinkButton
    Protected WithEvents Literal1 As System.Web.UI.WebControls.Literal
    Protected WithEvents LinkJan As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkFeb As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkMar As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkApr As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkMay As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkJun As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkJul As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkAug As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkSep As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkOct As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkNov As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkDec As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkYearM5 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkYearM4 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkYearM3 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkYearM2 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkYearM1 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkYearP1 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkYearP2 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkYearP3 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkYearP4 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkYearP5 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents cboYears As System.Web.UI.WebControls.DropDownList
    Private arrControlsMonths() As String = {"LinkJan", "LinkFeb", "LinkMar", "LinkApr", "LinkMay", "LinkJun", "LinkJul", "LinkAug", "LinkSep", "LinkOct", "LinkNov", "LinkDec"}
    'added by SachinR   on 09 Sep 2004
    Private m_intDayCounter As Integer = 0
    Private m_intNoOfWorkingDays As Integer

    ''Remove the Condition of checking Broweser  CommonFunctions.General.IsClientBrowserIE = True
    ''For Browser Compatiblity Isuue

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        ''Commented by Nilesh g on 26/10/2016 Purpose:Solved crash
        ''MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        '' Added By Vaijat K ON 28-Feb-2017 For Mastercard Security
        For intCount As Integer = 0 To HttpContext.Current.Request.QueryString.Count - 1
            Dim strKey As String = HttpContext.Current.Request.QueryString.GetKey(intCount)
            'Dim strValue As String = CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.QueryString.Get(intCount))
            Dim strValue As String = HttpContext.Current.Request.QueryString.Get(intCount)
            If strValue = Nothing Then strValue = ""
            If strKey = Nothing Then Continue For

            'If strKey.ToUpper() = "MODE" Then
            If strValue.ToUpper() = "DELETE" Or strValue.ToUpper() = "UPDATE_CHECKLIST" Or strValue.ToUpper() = "UPDATE" Then

            Else
                'Check apply security parameter of this function and application level settings (ApplyWebSecurity)
                If strKey <> "_VIEWSTATE" And strKey <> "__VIEWSTATEENCRYPTED" And strKey <> "__VIEWSTATE" Then

                    Dim FormCollection = System.Web.HttpContext.Current.Request.QueryString
                    Dim propInfo = FormCollection.[GetType]().GetProperty("IsReadOnly", System.Reflection.BindingFlags.Instance Or System.Reflection.BindingFlags.NonPublic)
                    propInfo.SetValue(FormCollection, False, New Object() {})
                    'add parameter into the hash table
                    FormCollection(strKey) = HttpUtility.HtmlEncode(Utilities.Security.SecurityBuilder.CheckUserInput(strValue, 2, True, True, True))

                End If
            End If
            ''End Added By Vaijat K ON 28-Feb-2017 For Mastercard Security
            'End If


        Next


        '' Added By Vidya Jadhav ON 3 Aug 2016 Purpose::SBI LIfe NextGen Upgarde
        ''Added By Aniruddh Gujar on 13-Jul-2016 Purpose::RED Colour Issue
        Dim strSQL As String = ""           'Stores the SQL string 
        Dim drAppSettings As IDataReader    'data reader for storing the resultset of application settings.
        strSQL = "usp_SEL_Tbl_PM_CompanyInformation "
        drAppSettings = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drAppSettings.Read Then
            CommonFunction.Application.StartDayOfWeek = CType(CommonFunction.Data.CheckIsDBNull(drAppSettings("StartingDayOfWeek"), "0"), Integer)
        End If
        ''End of Added By Aniruddh Gujar on 13-Jul-2016 Purpose::RED Colour Issue
        ''End of Added By Vidya Jadhav ON 3 Aug 2016 Purpose::SBI LIfe NextGen Upgarde
        'Put user code to initialize the page here
        Dim strToolTip As String = ""
        Dim strdval As String = Request.QueryString("dateval").ToString
        lnkBtnClearAndClose.CssClass = "Menu"

        'added by SachinR   on 21 Oct 2004
        'Issue - 13517
        m_intNoOfWorkingDays = 5
        'addition end

        'Calendar1.TitleStyle.CssClass = "clsTRPageCaption"
        'Calendar1.DayHeaderStyle.CssClass = "clsTRColumnHeader"
        'Calendar1.NextPrevStyle.CssClass = "Menu"
        'Calendar1.OtherMonthDayStyle.CssClass = "clsTROdd"
        'Calendar1.CssClass = "clsTREven"

        If IsPostBack = False Then
            If strdval = "None" Then
                Calendar1.TodaysDate = Now().Date

            Else
                Calendar1.SelectedDate = CDate(strdval)
                Calendar1.TodaysDate = CDate(strdval)
            End If

            'added by SachinR   on 07 Sep 2004
            Calendar1.FirstDayOfWeek = CType(CommonFunction.Application.StartDayOfWeek, System.Web.UI.WebControls.FirstDayOfWeek)
            'Calendar1.WeekendDayStyle.ForeColor = System.Drawing.Color.Red
            'Calendar1.WeekendDayStyle.BackColor = System.Drawing.Color.AntiqueWhite
            'addition end

            'FillMonthsComboBox Method
            Call FillYearsComboBox()
            cboYears.SelectedIndex = Calendar1.TodaysDate.Year - 1900
            SetYearLinks(Calendar1.SelectedDate.Year)
            If strdval = "None" Then
                CType(FindControl("Link" + Now().Date.ToString("MMM")), LinkButton).Font.Italic = True
                CType(FindControl("Link" + Now().Date.ToString("MMM")), LinkButton).ForeColor = System.Drawing.Color.Red
            Else
                CType(FindControl("Link" + Calendar1.SelectedDate.ToString("MMM")), LinkButton).Font.Italic = True
                CType(FindControl("Link" + Calendar1.SelectedDate.ToString("MMM")), LinkButton).ForeColor = System.Drawing.Color.Red
            End If


        End If
    End Sub

    Private Sub SetYearLinks(ByVal intYear As Integer)
        If intYear = 1 Then
            intYear = CInt(Now.ToString("yyyy"))
        End If
        Dim strToolTip As String = ""
        LinkYearM5.Text = GetYear(intYear, -5, strToolTip)
        LinkYearM5.ToolTip = strToolTip
        LinkYearM4.Text = GetYear(intYear, -4, strToolTip)
        LinkYearM4.ToolTip = strToolTip
        LinkYearM3.Text = GetYear(intYear, -3, strToolTip)
        LinkYearM3.ToolTip = strToolTip
        LinkYearM2.Text = GetYear(intYear, -2, strToolTip)
        LinkYearM2.ToolTip = strToolTip
        LinkYearM1.Text = GetYear(intYear, -1, strToolTip)
        LinkYearM1.ToolTip = strToolTip
        LinkYearP1.Text = GetYear(intYear, +1, strToolTip)
        LinkYearP1.ToolTip = strToolTip
        LinkYearP2.Text = GetYear(intYear, +2, strToolTip)
        LinkYearP2.ToolTip = strToolTip
        LinkYearP3.Text = GetYear(intYear, +3, strToolTip)
        LinkYearP3.ToolTip = strToolTip
        LinkYearP4.Text = GetYear(intYear, +4, strToolTip)
        LinkYearP4.ToolTip = strToolTip
        LinkYearP5.Text = GetYear(intYear, +5, strToolTip)
        LinkYearP5.ToolTip = strToolTip
    End Sub

    Private Sub Calendar1_SelectionChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Calendar1.SelectionChanged
        Dim strjscript As String = "<script language=""javascript"">"
        'strjscript &= "var objDate=GetObjectReference('" + HttpContext.Current.Request.QueryString("formname") + "','" + HttpContext.Current.Request.QueryString("datefield") + "');"
        'strjscript &= "alert(window.opener);"
        Select Case HttpContext.Current.Request.QueryString("FromWhere") & ""
            Case ""
                strjscript &= "window.opener.document.forms['" & _
                HttpContext.Current.Request.QueryString("formname") & "'].elements['" & HttpContext.Current.Request.QueryString("datefield") & "'].value = '" & _
                CommonFunction.Dates.GetDate(Calendar1.SelectedDate) & "';"

                'Added By NileshD on 17 Nov 2005 for ReqId WAF3_PB_12
                'Modified BY NileshD on 5 Dec 2005 for ReqId WAF3_PB_12
                If CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled") = True And UCase(HttpContext.Current.Request.QueryString("formname") & "") <> "FRMADVFILTERS" Then
                    strjscript &= "window.opener.document.forms['" & _
                                    HttpContext.Current.Request.QueryString("formname") & "'].elements['FFE29587WHIZ_" & HttpContext.Current.Request.QueryString("datefield") & "'].value = '" & _
                                    CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(CommonFunction.Dates.GetDate(Calendar1.SelectedDate)) & "';"
                    strjscript &= "window.opener.document.forms['" & _
                                  HttpContext.Current.Request.QueryString("formname") & "'].elements['FFE29587WHIZ_" & HttpContext.Current.Request.QueryString("datefield") & "'].focus();"
                End If
                'End of Modification BY NileshD on 5 Dec 2005 for ReqId WAF3_PB_12
                'end of addition By NileshD on 17 Nov 2005 for ReqId WAF3_PB_12
                strjscript = strjscript & "window.close();</script" & ">" 'Don't Ask, Tool Bug
                Literal1.Text = strjscript
            Case "DA"
                strjscript &= "window.opener.document.forms['" & _
                HttpContext.Current.Request.QueryString("formname") & "'].elements['" & HttpContext.Current.Request.QueryString("datefield") & "'].value = '" & _
                CommonFunction.Dates.GetDate(Calendar1.SelectedDate) & "'; refreshParent('DA','PM_DailyActivity.aspx','PM_DailyActivity.aspx?FromWhere=DA');window.close();"
                strjscript = strjscript & "</script" & ">" 'Don't Ask, Tool Bug
                Literal1.Text = strjscript
                'Added by NitinVS on 6 Dec 2005 for WhizibleSEM SP5 IssueID 672
            Case "DV"
                strjscript &= "window.opener.document.forms['" & _
                HttpContext.Current.Request.QueryString("formname") & "'].elements['" & HttpContext.Current.Request.QueryString("datefield") & "'].value = '" & _
                CommonFunction.Dates.GetDate(Calendar1.SelectedDate) & "'; refreshParent('frmDailyActivityWeeklyView','DailyActivityWeeklyView.aspx','DailyActivityWeeklyView.aspx?SelectedDate=" + CommonFunction.Dates.GetDate(Calendar1.SelectedDate) + "');window.close();"
                strjscript = strjscript & "</script" & ">" 'Don't Ask, Tool Bug
                Literal1.Text = strjscript
                'End Addition by NitinVS on 6 Dec 2005 for WhizibleSEM SP5 IssueID 672

                'Added by MrugajaB on 20th March 2006 for WhizibleSEM 6.0 Expense WorkFlow - Issue ID.2886
            Case "EWFLIST"
                strjscript &= "window.opener.document.forms['" & _
                HttpContext.Current.Request.QueryString("formname") & "'].elements['" & HttpContext.Current.Request.QueryString("datefield") & "'].value = '" & _
                CommonFunction.Dates.GetDate(Calendar1.SelectedDate) & "'; refreshParent('frmEWF','EWF_ExpenseEntryList.aspx','EWF_ExpenseEntryList.aspx?SelectedDate=" + CommonFunction.Dates.GetDate(Calendar1.SelectedDate) + "');window.close();"
                strjscript = strjscript & "</script" & ">" 'Don't Ask, Tool Bug
                Literal1.Text = strjscript

            Case "EWF"
                strjscript &= "window.opener.document.forms['" & _
                HttpContext.Current.Request.QueryString("formname") & "'].elements['" & HttpContext.Current.Request.QueryString("datefield") & "'].value = '" & _
                CommonFunction.Dates.GetDate(Calendar1.SelectedDate) & "'; refreshParent('frmEWF_ExpenseEntry','EWF_ExpenseEntry.aspx','EWF_ExpenseEntry.aspx?Mode=ADD_NEW&SelectedDate=" + CommonFunction.Dates.GetDate(Calendar1.SelectedDate) + "');window.close();"
                strjscript = strjscript & "</script" & ">" 'Don't Ask, Tool Bug
                Literal1.Text = strjscript
                'End Addition
            Case "DB"
                strjscript &= "window.opener.document.forms['" & _
                HttpContext.Current.Request.QueryString("formname") & "'].elements['" & HttpContext.Current.Request.QueryString("datefield") & "'].value = '" & _
                CommonFunction.Dates.GetDate(Calendar1.SelectedDate) & "'; refreshParent('frmSLAReport','DB_IssueSLA.aspx','DB_IssueSLA.aspx?Mode=" + HttpContext.Current.Request.QueryString("Mode") + "&View=" + HttpContext.Current.Request.QueryString("View") + "&ID=" + HttpContext.Current.Request.QueryString("ID") + "&From=" + HttpContext.Current.Request.QueryString("From") + "&SelectedDate=" + CommonFunction.Dates.GetDate(Calendar1.SelectedDate) + "');window.close();"
                strjscript = strjscript & "</script" & ">" 'Don't Ask, Tool Bug
                Literal1.Text = strjscript
                'End Addition by NitinVS on 6 Dec 2005 for WhizibleSEM SP5 IssueID 672

                'Added By KapilGK on 18-Sep-07 for Quick Task
            Case "QT"
                strjscript &= "window.opener.document.forms['" & _
                HttpContext.Current.Request.QueryString("formname") & "'].elements['" & HttpContext.Current.Request.QueryString("datefield") & "'].value = '" & _
                CommonFunction.Dates.GetDate(Calendar1.SelectedDate) & "'; refreshParent('frmRT_QuickTasks','RT_QuickTasks.aspx','RT_QuickTasks.aspx'); window.close();"
                strjscript = strjscript & "</script" & ">" 'Don't Ask, Tool Bug
                Literal1.Text = strjscript
                'Added By KapilGK on 18-Sep-07 for Quick Task

        End Select
        'HttpContext.Current.Request.QueryString("formname") & ".value = '" & _
        '"objDate.value = '" & _
    End Sub
    Private Sub FillYearsComboBox()
        Dim lngYearStart As Long
        'Added By NileshD on 17 Nov 2005 for ReqId WAF3_PB_12
        If CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled") = True Then
            For lngYearStart = 1900 To 2099
                cboYears.Items.Add(lngYearStart.ToString)
            Next
        Else
            For lngYearStart = 1900 To 2101
                cboYears.Items.Add(lngYearStart.ToString)
            Next
        End If

        'end of addition By NileshD on 17 Nov 2005 for ReqId WAF3_PB_12
    End Sub

    Private Sub cboYears_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboYears.SelectedIndexChanged
        Dim strSelectedMonth As String
        Dim intControlsCounter As Integer
        For intControlsCounter = 0 To arrControlsMonths.Length - 1
            If CType(FindControl(arrControlsMonths(intControlsCounter)), LinkButton).Font.Italic = True Then
                strSelectedMonth = arrControlsMonths(intControlsCounter).Substring(4)
            End If
        Next
        Dim strSelectedYear As String = cboYears.Items(cboYears.SelectedIndex).ToString
        Dim strDate As String = Calendar1.SelectedDate.Day.ToString + "-" + strSelectedMonth + "-" + strSelectedYear
        If IsDate(strDate) Then
            Calendar1.VisibleDate = CDate(strDate)
            Calendar1.TodaysDate = Calendar1.VisibleDate
        Else
            strDate = "1-" + strSelectedMonth + " - " + strSelectedYear
            Calendar1.VisibleDate = CDate(strDate)
            Calendar1.TodaysDate = Calendar1.VisibleDate
        End If

        ResetBorderStyle()

        CType(FindControl("Link" + Calendar1.VisibleDate.ToString("MMM")), LinkButton).Font.Italic = True
        CType(FindControl("Link" + Calendar1.VisibleDate.ToString("MMM")), LinkButton).ForeColor = System.Drawing.Color.Red

        SetYearLinks(CInt(cboYears.Items(cboYears.SelectedIndex).ToString))

    End Sub

    Private Sub Calendar1_VisibleMonthChanged(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MonthChangedEventArgs) Handles Calendar1.VisibleMonthChanged

        SetYearLinks(Calendar1.VisibleDate.Year)
        ResetBorderStyle()
        CType(FindControl("Link" + Calendar1.VisibleDate.ToString("MMM")), LinkButton).Font.Italic = True
        CType(FindControl("Link" + Calendar1.VisibleDate.ToString("MMM")), LinkButton).ForeColor = System.Drawing.Color.Red


        cboYears.SelectedIndex = CType(Calendar1.VisibleDate.Year, Integer) - 1900
        Dim strDate As String = Calendar1.SelectedDate.Day.ToString

        Dim intControlsCounter As Integer
        For intControlsCounter = 0 To arrControlsMonths.Length - 1
            If CType(FindControl(arrControlsMonths(intControlsCounter)), LinkButton).Font.Italic = True Then
                strDate = strDate + "-" + arrControlsMonths(intControlsCounter).Substring(4)
            End If
        Next

        strDate = strDate + "-" + cboYears.SelectedItem.ToString
        If IsDate(strDate) = True Then
            Calendar1.VisibleDate = CDate(strDate)
            Calendar1.TodaysDate = Calendar1.VisibleDate
        Else
            Calendar1.TodaysDate = Calendar1.VisibleDate
        End If
    End Sub

    Private Sub lnkBtnClearAndClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lnkBtnClearAndClose.Click
        Dim strjscript As String = "<script language=""javascript"">"
        strjscript &= "window.opener.document.forms['" & _
        HttpContext.Current.Request.QueryString("formname") & "'].elements['" & HttpContext.Current.Request.QueryString("datefield") & "'].value =''" & ";"
        'Added By NileshD on 17 Nov 2005 for ReqId WAF3_PB_12
        'Modified BY NileshD on 5 Dec 2005 for ReqId WAF3_PB_12
        If CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled") = True And UCase(HttpContext.Current.Request.QueryString("formname") & "") <> "FRMADVFILTERS" Then
            strjscript &= "window.opener.document.forms['" & _
               HttpContext.Current.Request.QueryString("formname") & "'].elements['FFE29587WHIZ_" & HttpContext.Current.Request.QueryString("datefield") & "'].value =''" & ";"
            strjscript &= "window.opener.document.forms['" & _
              HttpContext.Current.Request.QueryString("formname") & "'].elements['FFE29587WHIZ_" & HttpContext.Current.Request.QueryString("datefield") & "'].focus();"
        End If
        'End of Modification BY NileshD on 5 Dec 2005 for ReqId WAF3_PB_12
        'end of addition By NileshD on 17 Nov 2005 for ReqId WAF3_PB_12
        strjscript = strjscript & "window.close();</script" & ">" 'Don't Ask, Tool Bug
        Literal1.Text = strjscript
    End Sub

    Sub New()
    End Sub

    Private Sub LinkJan_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LinkJan.Click, LinkFeb.Click, LinkMar.Click, LinkApr.Click, LinkMay.Click, LinkJun.Click, LinkJul.Click, LinkAug.Click, LinkSep.Click, LinkOct.Click, LinkNov.Click, LinkDec.Click
        ResetBorderStyle()
        CType(sender, LinkButton).Font.Italic = True
        CType(sender, LinkButton).ForeColor = System.Drawing.Color.Red

        Dim strSelectedYear As String = cboYears.Items(cboYears.SelectedIndex).ToString
        Dim strDate As String = Calendar1.SelectedDate.Day.ToString + "-" + CType(sender, LinkButton).Text + "-" + strSelectedYear
        If IsDate(strDate) Then
            Calendar1.VisibleDate = CDate(strDate)
            Calendar1.TodaysDate = Calendar1.VisibleDate
        Else
            strDate = "1-" + CType(sender, LinkButton).Text + " - " + strSelectedYear
            Calendar1.VisibleDate = CDate(strDate)
            Calendar1.TodaysDate = Calendar1.VisibleDate
        End If
        Calendar1.SelectedDayStyle.ForeColor = System.Drawing.Color.Red

    End Sub

    Private Function GetYear(ByVal intYear As Integer, ByVal intPrevNext As Integer, ByRef strToolTip As String) As String
        'Added By NileshD on 17 Nov 2005 for ReqId WAF3_PB_12
        If CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled") = True Then
            If intYear > 2094 Then
                If (intYear + intPrevNext) > 2099 Then
                    Return ""
                End If
            ElseIf intYear < 1905 Then
                If (intYear + intPrevNext) < 1900 Then
                    Return ""
                End If
            End If
        Else
            If intYear > 2096 Then
                If (intYear + intPrevNext) > 2101 Then
                    Return ""
                End If
            ElseIf intYear < 1905 Then
                If (intYear + intPrevNext) < 1900 Then
                    Return ""
                End If
            End If
        End If
        'end of addition By NileshD on 17 Nov 2005 for ReqId WAF3_PB_12
        strToolTip = CType((intYear + intPrevNext), String)
        Return CType((intYear + intPrevNext), String).Substring(2)

    End Function

    Private Sub ResetBorderStyle()
        LinkJan.Font.Italic = False
        LinkJan.ForeColor = System.Drawing.Color.Black
        LinkFeb.Font.Italic = False
        LinkFeb.ForeColor = System.Drawing.Color.Black
        LinkMar.Font.Italic = False
        LinkMar.ForeColor = System.Drawing.Color.Black
        LinkApr.Font.Italic = False
        LinkApr.ForeColor = System.Drawing.Color.Black
        LinkMay.Font.Italic = False
        LinkMay.ForeColor = System.Drawing.Color.Black
        LinkJun.Font.Italic = False
        LinkJun.ForeColor = System.Drawing.Color.Black
        LinkJul.Font.Italic = False
        LinkJul.ForeColor = System.Drawing.Color.Black
        LinkAug.Font.Italic = False
        LinkAug.ForeColor = System.Drawing.Color.Black
        LinkSep.Font.Italic = False
        LinkSep.ForeColor = System.Drawing.Color.Black
        LinkOct.Font.Italic = False
        LinkOct.ForeColor = System.Drawing.Color.Black
        LinkNov.Font.Italic = False
        LinkNov.ForeColor = System.Drawing.Color.Black
        LinkNov.Font.Italic = False
        LinkNov.ForeColor = System.Drawing.Color.Black
    End Sub
    Private Sub LinkYearM5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LinkYearM5.Click, LinkYearM4.Click, LinkYearM3.Click, LinkYearM2.Click, LinkYearM1.Click, LinkYearP5.Click, LinkYearP4.Click, LinkYearP3.Click, LinkYearP2.Click, LinkYearP1.Click
        If CType(sender, LinkButton).ID.Substring(8, 1) = "M" Then
            cboYears.SelectedIndex = (Calendar1.TodaysDate.Year - CInt(CType(sender, LinkButton).ID.Substring(9)) - 1900)
        Else
            cboYears.SelectedIndex = (Calendar1.TodaysDate.Year + CInt(CType(sender, LinkButton).ID.Substring(9)) - 1900)
        End If

        Dim strSelectedMonth As String = Calendar1.TodaysDate.ToString("MMM")
        Dim strSelectedYear As String = CStr(cboYears.SelectedIndex + 1900)
        Dim strDate As String = Calendar1.SelectedDate.Day.ToString + "-" + strSelectedMonth + "-" + strSelectedYear

        If IsDate(strDate) = True Then
            Calendar1.VisibleDate = CDate(strDate)
            Calendar1.TodaysDate = Calendar1.VisibleDate
        Else
            strDate = "1-" + strSelectedMonth + " - " + strSelectedYear
            Calendar1.VisibleDate = CDate(strDate)
            Calendar1.TodaysDate = Calendar1.VisibleDate
        End If

        SetYearLinks(Calendar1.VisibleDate.Year)
        Calendar1.SelectedDayStyle.ForeColor = System.Drawing.Color.Red

    End Sub

    'added by SachinR   on 09 Sep 2004
    'purpose    :   Here week ends are shown in the red color.A counter is declared globally and increamented
    '               for each day of week printed.It is checked against the no of working days, when it is greater 
    '               than no of working days then mark day as week end
    Private Sub Calendar1_DayRender(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DayRenderEventArgs) Handles Calendar1.DayRender
        ''Added By Aniruddh Gujar on 13-Jul-2016 Purpose::RED Colour Issue
        Dim strTempStartDayofWeek
        ''End of Added By Aniruddh Gujar on 13-Jul-2016 Purpose::RED Colour Issue
        With e.Day
            ''Added By Aniruddh Gujar on 13-Jul-2016 Purpose::RED Colour Issue
            strTempStartDayofWeek = CType(CommonFunction.Application.StartDayOfWeek, System.DayOfWeek)
            If strTempStartDayofWeek = 7 Then
                strTempStartDayofWeek = 0
            End If
            ''End of Added By Aniruddh Gujar on 13-Jul-2016 Purpose::RED Colour Issue


            ''Commented And Added By Vidya Jadhav ON 16 Aug 2016 
            '  If .Date.DayOfWeek = CType(CommonFunction.Application.StartDayOfWeek, System.DayOfWeek) Then
            If .Date.DayOfWeek = CType(strTempStartDayofWeek, System.DayOfWeek) Then
                ''End of Added By Vidya Jadhav ON 16 Aug 2016  
                m_intDayCounter = 0
            End If
            m_intDayCounter += 1

            If .IsOtherMonth = False Then
                If m_intDayCounter > m_intNoOfWorkingDays Then
                    e.Cell.ForeColor = System.Drawing.Color.Red
                End If
            End If
        End With
    End Sub

End Class
