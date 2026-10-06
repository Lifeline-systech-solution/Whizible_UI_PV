Public Class PM_WeeklyStatusReport
    Inherits WebPages.Template.WhizTemplate
#Region " Variable Declaration"

    ''Added by Vidya J on 1 Feb 2016 for PkToken Validation
    
    Protected m_PKToken As String
    Protected m_TimeSheetNo As String
    ''End of Addition by Vidya J on 1 Feb 2016
    ''Added by Dhanashri S on 11 Aug 2016
    Protected m_EmployeeID As String
    Protected m_blnValidate As Boolean = "True"
    Protected m_strToken_WSR_Constant As String = ""
    ''End of Addition by Dhanashri S on 11 Aug 2016

#End Region
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowWSR(TimeSheetNo As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_ShowWSR As String
            m_PKToken_ShowWSR = CommonFunctions.Security.Token.GetToken(CType(TimeSheetNo, String) + CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_ShowWSR
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
      
        InitializeComponent()
        ''Added By Vidya J ON 1 Feb 2016
        'If Not Request.QueryString("PKTokenValue") Is Nothing Then
        '    m_PKToken = Request.QueryString("PKTokenValue").ToString
        'End If
        If Not Request.QueryString("PKToken") Is Nothing Then
            m_PKToken = Request.QueryString("PKToken").ToString
        End If
        If Not Request.QueryString("TimeSheetNo") Is Nothing Then
            m_TimeSheetNo = Request.QueryString("TimeSheetNo").ToString
        End If
        ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        If Not Request.QueryString("EmployeeID") Is Nothing Then
            m_EmployeeID = Request.QueryString("EmployeeID").ToString
        End If
        ''End of Addition by Dhanashri S on 11 Aug 2016
        'If m_PKToken <> "" And m_TimeSheetNo <> "" Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_TimeSheetNo, String) + CType(m_EmployeeID, String) + CType(0, String) + CType(0, String), m_PKToken) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_TimeSheetNo, String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        ''ADDED BY NILESH G ON 22/8/2016 PURPOSE : PKTOKEN GENERATION
        If Request.QueryString("FromWhere") <> "Timesheet" Then
            If (m_TimeSheetNo <> "") Then
                If (((m_PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0"))) Then
                    m_blnValidate = "False"
                ElseIf (m_EmployeeID <> "") Then
                    If (CommonFunctions.Security.Token.ValidateToken(CType(m_TimeSheetNo, String) + CType(m_EmployeeID, String) + CType(0, String) + CType(0, String), m_PKToken) = False) Then
                        m_blnValidate = "False"
                    End If
                ElseIf (CommonFunctions.Security.Token.ValidateToken(CType(m_TimeSheetNo, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken) = False) Then
                    m_blnValidate = "False"
                End If
            End If
            ''END OF ADDED BY NILESH G ON 22/8/2016 PURPOSE : PKTOKEN GENERATION
            If (m_blnValidate = "False") Then
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End Of Addition By Vidya J ON 1 Feb 2016
    End Sub

#End Region

    Private m_strFromDate As String = ""
    Private m_strToDate As String = ""
    Private m_intTimeSheetNo As Integer

    Private m_strHighLights As String = ""
    Private m_strActivities As String = ""
    Private m_strSuggetions As String = ""
    Private m_strIssues As String = ""
    Private m_strSleepage As String = ""

    'Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format
    Private m_GrandTotal As Double = 0
    'End Of Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format

    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
    Protected m_strToken_WSR As String
    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197    

    Private WithEvents objProjectwiseWSR As New WebPages.Template.GenericGrid
    Private WithEvents objProjectInformationGrid As New WebPages.Template.GenericGrid
    Private WithEvents objActivitiesGrid As New WebPage.Templates.GenericGrid



    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : to build the page - main procedure which builds the page
        '                         
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 17, 2004
        ' Revisions             :
        '=====================================================================

        Call SetVariables()

        '' START : Added By ParagD On 14-Sept-2006 : Security Issue 6197
        If (m_strToken_WSR_Constant = "1049") Then
            If (Trim(m_strToken_WSR & "") <> "" And CommonFunctions.Security.Token.ValidateToken(CStr(m_intTimeSheetNo) + CType(Session("intUserID"), String) + "0" + "1049", m_strToken_WSR) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Project Timesheet WSR", 1049, 0, "Timesheet No", CType(m_intTimeSheetNo, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If


        '' END : Added By ParagD On 14-Sept-2006 : Security Issue 6197

        'If TimeSheetNo is no passed as a queryString parameter
        If m_intTimeSheetNo = 0 Then 'No Timesheet Number
            Response.Write(GenerateMenu() + "<BR>")
            Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGECAPTION")))
            Response.Write("<BR>")
            Call GenerateProjectwiseWSR() 'Display projectwise WSR
            Response.Write("<BR>" + GenerateMenu())
        Else 'For a specific TimeSheetNo

            'Added By VivekP On 16 Sep 2005 For WhizibleSEM SP4
            Response.Write(GenerateMenu() + "<BR>")
            'End Of Addition On 16 Sep 2005 For WhizibleSEM SP4

            Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGECAPTIONFORTIMESHEET")))
            Response.Write("<BR>")

            Call GenerateProjectInformationGrid() 'ProjectInformation
            Call GetWSROtherAttributes() 'Get other attributes for the timesheet
            Call DisplayHighlights() 'Highlights for the timesheet

            Response.Write("<TABLE cellspacing=0 class=clsTable Width='99.9%'>")
            Response.Write("<TR class=clsTREven><TD width=100%><B>" + MyBase.GetResourceString("ACTIVITIES") + "</TD></TR>")
            Response.Write("</TABLE><BR>")

            Call DisplayActivitiesGrid() 'Activities in the timesheet
            Call DisplayWSROtherAttributes() 'Other attributes 

            'Added By VivekP On 16 Sep 2005 For WhizibleSEM SP4
            Response.Write("<BR>" + GenerateMenu())
            'End Of Addition On 16 Sep 2005 For WhizibleSEM SP4
        End If

    End Sub

    Private Function GenerateMenu() As String
        '=====================================================================
        ' Function Name         : GenerateMenu()	
        ' Purpose               : To generate Menu for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 19, 2004
        ' Revisions             :
        '=====================================================================

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        'Added By VivekP On 16 Sep 2005 For WhizibleSEM SP4
        'Close
        'Added and Modified By VarunA on 21-June-2007 Whizible Regression Project Issue-13040
        If HttpContext.Current.Request.QueryString("FromWhere") <> "PM" Then
            ArrMenuCaptionsList.Add("Close")
            ArrMenuToolTipsList.Add("Close")
            ArrClientSideFunctionsList.Add("Close_OnClick()")
            'End Of Addition On 16 Sep 2005 For WhizibleSEM SP4  
        End If
        'End By VarunA on 21-June-2007 Issue-13040

        'Help 
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('WKLY_STATUS_REPORT')")

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

        MyBase.InitializeResources("AppResources.PM_WeeklyStatusReport", "AppResources")

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)

    End Function 'Menu generation


    Private Sub DisplayWSROtherAttributes()
        '=====================================================================
        ' Procedure Name        : DisplayWSROtherAttributes()	
        ' Purpose               : to display other attributes of WSR at the end of the page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 17, 2004
        ' Revisions             :
        '=====================================================================
        ' Added By Purvaj on 25 sept 2008 for Firefox Issue
        Response.Write("<DIV id='DivOtherAttributes' width='99.9%' Height='150px'>")
        'End addition By Purvaj on 25 sept 2008 for Firefox Issue
        Response.Write("<BR><TABLE width='99.9%' class=clsTable cellspacing=0 cellpadding=0>")

        Response.Write("<TR class=clsTREven><TD valign=top width='30%' align=right><b>" + MyBase.GetResourceString("SLIPPAGE") + " : </b></TD>")
        Response.Write("<TD  align=Left>" + m_strSleepage + "</TD></TR>")

        Response.Write("<TR class=clsTREven><TD valign=top  width='30%' align=right><b>" + MyBase.GetResourceString("ISSUES") + " : </b></TD>")
        Response.Write("<TD  align=Left>" + m_strIssues + "</TD></TR>")

        Response.Write("<TR class=clsTREven><TD valign=top width='30%' align=right><b>" + MyBase.GetResourceString("SUGGESTIONS") + " : </b></TD>")
        Response.Write("<TD  align=Left>" + m_strSuggetions + "</TD></TR>")

        Dim Interval As Double
        Interval = DateDiff(DateInterval.Day, CType(m_strFromDate, Date), CType(m_strToDate, Date))

        Response.Write("<TR class=clsTREven><TD  align=right width='30%'><b>" + MyBase.GetResourceString("NEXTPERIOD") + " : </TD><TD> " + CommonFunction.Dates.CGetDate(DateAdd(DateInterval.Day, Interval, CType(m_strFromDate, Date))).ToString + " To " + CommonFunction.Dates.CGetDate(DateAdd(DateInterval.Day, Interval, CType(m_strToDate, Date))).ToString + "<b></TD></TR>")

        Response.Write("<TR class=clsTREven><TD valign=top  width='30%' align=right><b>" + MyBase.GetResourceString("NOTES") + " : </TD><TD align=Left>" + m_strActivities + "</TD></TR>")

        Response.Write("</TABLE>")
        'PURVA
        Response.Write("</DIV>")
        'PURVA

    End Sub

    Private Sub DisplayActivitiesGrid()
        '=====================================================================
        ' Procedure Name        : DisplayActivitiesGrid()	
        ' Purpose               : to display status of activities planned in the WSR Period
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 17, 2004
        ' Revisions             :
        '=====================================================================

        Dim ArrActualColumnNames() As String = {"Task", "WorkHrs", "Status"}
        Dim ArrUserFriendlyColumnNames() As String = {MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("TOTALTIMESHEETHOURS"), MyBase.GetResourceString("STATUS")}
        Dim ArrSummaryFunctions() As String = {"", "SUM", ""}

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        With objActivitiesGrid
            .ActualColumnArray = ArrActualColumnNames
            .UserFriendlyColumnArray = ArrUserFriendlyColumnNames
            .SQL = "usp_sel_WSR_Activities " + m_intTimeSheetNo.ToString
            .UseSQL = MyBase.UseSQL
            .NoOfDataColumns = 3
            .SummaryFunctions = ArrSummaryFunctions
            .ShowSummaryFunctions = True
            .DIVHeight = 150 '100      ' modified By Purvaj on 25 sept 2008 for Firefox Issue
            .DIVStyle = "scrollbar:none"
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With

        objActivitiesGrid = Nothing
    End Sub

    Private Sub DisplayHighlights()
        '=====================================================================
        ' Procedure Name        : DisplayHighlights()	
        ' Purpose               : to display Highlights of the WSR
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 17, 2004
        ' Revisions             :
        '=====================================================================

        Response.Write("<BR><TABLE cellspacing=0 width='99.9%' class=clsTable>")
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD valign=top align=Left Width='20%'><b>HighLights:</b></TD>")
        Response.Write("<TD align=Left>" + m_strHighLights + "</TD>")
        Response.Write("</TR>")
        Response.Write("</TABLE>")
        Response.Write("<BR>")
    End Sub

    Private Sub GetWSROtherAttributes()
        '=====================================================================
        ' Procedure Name        : GetWSROtherAttributes()	
        ' Purpose               : to get other attributes of WSR 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 17, 2004
        ' Revisions             :
        '=====================================================================

        Dim drWSROtherAttributes As IDataReader
        drWSROtherAttributes = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_WSROtherAttributes " + m_intTimeSheetNo.ToString, MyBase.UseSQL)
        If drWSROtherAttributes.Read Then
            ''Commented and Added by Dhanashri S on 28 Nov 2015
            'm_strHighLights = drWSROtherAttributes("Highlights").ToString
            'm_strActivities = drWSROtherAttributes("Activities").ToString
            'm_strSuggetions = drWSROtherAttributes("Suggetion").ToString
            'm_strIssues = drWSROtherAttributes("Issues").ToString
            'm_strSleepage = drWSROtherAttributes("Sleepage").ToString


            m_strHighLights = System.Web.HttpUtility.HtmlEncode(drWSROtherAttributes("Highlights").ToString())
            m_strActivities = System.Web.HttpUtility.HtmlEncode(drWSROtherAttributes("Activities").ToString)
            m_strSuggetions = System.Web.HttpUtility.HtmlEncode(drWSROtherAttributes("Suggetion").ToString)
            m_strIssues = System.Web.HttpUtility.HtmlEncode(drWSROtherAttributes("Issues").ToString)
            m_strSleepage = System.Web.HttpUtility.HtmlEncode(drWSROtherAttributes("Sleepage").ToString)
            ''End of Comment and Addition by Dhanashri S on 28 Nov 2015
        End If
        CommonFunction.Data.DisposeDataReader(drWSROtherAttributes)
    End Sub

    Private Sub GenerateProjectInformationGrid()
        '=====================================================================
        ' Procedure Name        : GenerateProjectInformationGrid()	
        ' Purpose               : to display project information grid for WSR
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 17, 2004
        ' Revisions             :
        '=====================================================================

        Dim ArrActualColumnNames() As String = {"CustomerName", "CreatedDate", "ProjectName", "FromDate", "ToDate", "CompanyID", "Subject"}
        Dim ArrUserFriendlyColumnNames() As String = {MyBase.GetResourceString("TO"), MyBase.GetResourceString("CREATEDDATE"), MyBase.GetResourceString("PROJECTNAME"), MyBase.GetResourceString("FROMDATE"), MyBase.GetResourceString("TODATE"), MyBase.GetResourceString("FROM"), MyBase.GetResourceString("SUBJECT")}

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        With objProjectInformationGrid
            .ActualColumnArray = ArrActualColumnNames
            .UserFriendlyColumnArray = ArrUserFriendlyColumnNames
            .SQL = "usp_sel_WSR_ProjectInformationGrid " + m_intTimeSheetNo.ToString
            .UseSQL = MyBase.UseSQL
            .NoOfDataColumns = 7
            .VerticalDisplay = True
            .DIVHeight = 150 '100      ' modified By Purvaj on 25 sept 2008 for Firefox Issue
            .DIVStyle = "scrollbar:none"
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With
    End Sub

    Private Sub GenerateProjectwiseWSR()
        '=====================================================================
        ' Procedure Name        : GenerateProjectwiseWSR()	
        ' Purpose               : to display projectwise WSR grid (When no TimeSheetNo)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 17, 2004
        ' Revisions             :
        '=====================================================================

        Dim GridSQL As String
        'Added and commented by PrashantD on 14 Sept 2007
        'GridSQL = "usp_sel_WeeklyStatusReport " + Session("intUserID").ToString
        GridSQL = "usp_sel_WeeklyStatusReport " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "'"

        'End of addition by PrashantD on 14 Sept 2007

        Dim ArrActualColumnNames() As String = {"ProjectName", "WSR", "TimeSheet", "CreatedDate", "FromDate", "ToDate", "TotalTimeSheetHours"}
        Dim ArrUserFriendlyColumnNames() As String = {MyBase.GetResourceString("PROJECTNAME"), "<IMG border=0 src=../../Images/StatusReport.gif>", "<IMG border=0 src=../../Images/TimeSheet.gif>", MyBase.GetResourceString("CREATEDDATE"), MyBase.GetResourceString("FROMDATE"), MyBase.GetResourceString("TODATE"), MyBase.GetResourceString("TOTALTIMESHEETHOURS")}
        Dim ArrGroupOnColumn() As String = {"1"}
        Dim ArrIgnoreHTMLEncode() As String = {"", "1", "1"}
        Dim ArrRowLinks() As String = {"", "ShowWSR(TimeSheetNo)", "ShowTimeSheet(TimeSheetNo)", "", "", "", ""}

        With objProjectwiseWSR
            .ActualColumnArray = ArrActualColumnNames
            .UserFriendlyColumnArray = ArrUserFriendlyColumnNames
            .UseSQL = MyBase.UseSQL
            .SQL = GridSQL
            .DIVID = "ProjectwiseWSR"
            .DIVHeight = 450
            .DIVStyle = "overflow:auto;width:100%"
            .NoOfDataColumns = 7
            .GroupOnColumn = ArrGroupOnColumn
            .IgnoreHTMLEncode = ArrIgnoreHTMLEncode
            .RowLinkArray = ArrRowLinks
            .DrawGrid()
        End With
    End Sub

    Public Sub New()
        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : constructor of the page
        ' Description           : applies security and initializes the resource file.
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 17, 2004
        ' Revisions             :
        '=====================================================================

        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()        
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.PM_WeeklyStatusReport", "AppResources")
    End Sub

    Private Sub SetVariables()
        '=====================================================================
        ' Procedure Name        : SetVariables()	
        ' Purpose               : set the values of the variables being used in this page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 17, 2004
        ' Revisions             :
        '=====================================================================

        If Not Request.QueryString("TimeSheetNo") Is Nothing Then
            m_intTimeSheetNo = CType(Request.QueryString("TimeSheetNo"), Integer)
        End If

        If Not Request.QueryString("FromDate") Is Nothing Then
            m_strFromDate = Request.QueryString("FromDate").ToString
        End If

        If Not Request.QueryString("ToDate") Is Nothing Then
            m_strToDate = Request.QueryString("ToDate").ToString
        End If

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        If Request.QueryString("PKToken") <> "" Then
            m_strToken_WSR = Request.QueryString("PKToken")
        Else
            ''Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
            m_strToken_WSR_Constant = "1049"
            ''m_strToken_WSR = CommonFunctions.Security.Token.GetToken(CStr(m_intTimeSheetNo) + CType(Session("intUserID"), String) + "0" + "1049")
            m_strToken_WSR = CommonFunctions.Security.Token.GetToken(CStr(m_intTimeSheetNo) + CType(Session("intUserID"), String) + "0" + CStr(m_strToken_WSR_Constant))
            ''//End of Addition by Dhanashri S on 11 Aug 2016
        End If
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

    End Sub

    Private Sub objProjectInformationGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objProjectInformationGrid.DataRowTR_BeforePrint
        '=====================================================================
        ' Procedure Name        : objProjectInformationGrid_DataRowTR_BeforePrint()	
        ' Purpose               : To get fromdate and todate of the specified TimesheetNo.
        ' Description           : Overwrite the querystring parameter values, when TimesheetNo is passed.
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 17, 2004
        ' Revisions             :
        '=====================================================================

        m_strFromDate = Args.DataReader("Fromdate").ToString
        m_strToDate = Args.DataReader("Todate").ToString
    End Sub
    'Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format
    Private Sub objActivitiesGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objActivitiesGrid.DataRowTR_BeforePrint
        '=====================================================================
        ' Procedure Name        : objActivitiesGrid_DataRowTR_BeforePrint()	
        ' Purpose               : For getting work hours in HH:MM from decimal format.
        ' Description           : For getting work hours in HH:MM from decimal format
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Usha Pandit
        ' Created               : Nov 25, 2020
        ' Revisions             :
        '=====================================================================

        m_GrandTotal += CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("WorkHrs"), "0") + "',2)", True)
    End Sub
    'End Of Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format
    Private Sub objActivitiesGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles objActivitiesGrid.SummaryFunctionsTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.StringToBeInserted = "<TD>" + MyBase.GetResourceString("GRANDTOTAL") + "</TD>"
            Cancel = True
        End If
        'Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format
        If Args.ColIndex = 1 Then
            'Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
            'Args.StringToBeInserted = "<TD>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(m_GrandTotal, 2).ToString + "',1)", True) + "</TD>"
            Args.StringToBeInserted = "<TD>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_GrandTotal.ToString + "',1)", True) + "</TD>"
            'End OF Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
            Cancel = True
        End If
        'End Of Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
    'Added BY nitinVS on 19 Apr 2007 for WhizbleSEM SP 8 Regression Fixes 

    Private Sub objProjectwiseWSR_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objProjectwiseWSR.DataRowTD_BeforePrint
        If Args.ColIndex = 2 Then
            Args.EnableLink = False
            Args.ApplyHTMLEncode = False
            Args.DataFieldValue = "<A href=""JavaScript:ShowTimeSheet('" + Args.DataReader("TimeSheetNo").ToString() + "', '" + CommonFunctions.Security.Token.GetToken(Args.DataReader("TimeSheetNo").ToString + CType(Session("intUserID"), String) + "0" + "42") + "')""><IMG border=0 title='Show TimeSheet' src=../../Images/TimeSheet.gif></A>"

        End If
    End Sub
    ' End Addition By nitinVS on 19 Apr 2007 for WhizbleSEM SP 8 Regression Fixes 

End Class
