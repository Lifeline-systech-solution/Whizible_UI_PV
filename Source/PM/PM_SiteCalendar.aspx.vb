#Region "Imports"
Imports System.Text
#End Region
'=====================================================================
' Module Name       :     PM_ResourceLoadingDailyBreakUp

' Purpose           :     Display the Daily BreakUp of the   

' Description       :     Same as Above  

' Dependencies      :     Resource File For the same

' Author            :     DipaliS

' Created           :     May 21, 2004

' Revisions :
'=====================================================================

Public Class PM_SiteCalendar
    Inherits WebPages.Template.WhizTemplate
#Region " Variable Declaration"

    ''Added by Vidya J on 1 Feb 2016 for PkToken Validation
    Protected m_PKTokenValue As String = ""
    Protected m_YearValue As String = ""
    Protected m_MonthValue As String = ""
    ''End of Addition by Vidya J on 1 Feb 2016


#End Region
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        ''Added By Vidya J ON 1 Feb 2016
        If Not Request.QueryString("PKToken") Is Nothing Then
            m_PKTokenValue = Request.QueryString("PKToken").ToString
        End If
        If Not Request.QueryString("Year") Is Nothing Then
            m_YearValue = Trim(Request.QueryString("Year").ToString)
        End If
        If Not Request.QueryString("Month") Is Nothing Then
            m_MonthValue = Trim(Request.QueryString("Month").ToString)
        End If
        If Request.QueryString("Year") IsNot Nothing Then
            If m_PKTokenValue <> "" Then

                If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(m_YearValue, String) + CType(m_MonthValue, String) + CType(0, String) + CType(0, String), m_PKTokenValue) = False) Then

                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_YearValue, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If

            End If
        End If
        ''End Of Addition By Vidya J ON 1 Feb 2016
       
        InitializeComponent()

      
    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        'MyBase.InitializeResources("AppResources.PM_ResourceLoadingDailyBreakUp", "AppResources")
    End Sub
#End Region

#Region "Member Variables"
    Protected m_intYear As Integer
    Protected m_intResourceID As Integer
    Protected m_intMonth As Integer
    Private m_intRowCount As Integer
    Protected m_strImageForAllProject As String
    Protected m_strImageForOtherProjects As String
    Protected m_strImage As String
    Protected m_strMonthName As String
    Protected m_strHours As String
    'Code Added 29 May 2004
    Private m_intLoggedInEmpID As Integer
    Protected m_intRoleLevel As Integer
    Private m_strProjectFilters As String

    '##### Code added by Amitd on 20th Sep 2004
    Protected m_SiteID As Integer
    Dim strSQL As String
    Protected m_strHolidayList As String
    Protected m_strWeekEnds As String
    Protected m_NormalDays As String

    '##### End Addition
    'code added by DipaliS 6 Oct 2004
    Protected m_strFromTimeSheet As String = ""
    'End Addition by DipaliS
    'Code Added by DipaliS 14 Oct 2004
    Private m_strTimeSheetNo As String
    'End addition by DipaliS
#End Region

#Region "Constants"
    Public Const GRAPH_DIRECTORY As String = "../../images/DB_GRAPHS/"
    Private m_intGraphWidth As Integer = 400
    Protected WithEvents frmPM_SiteCalendar As System.Web.UI.HtmlControls.HtmlForm
    Private m_intGraphHeight As Integer = 250
    Protected strProjectID As String = ""
#End Region

#Region "Procedures"
    Public Sub PageInit()
        '######### Page Code starts here

        'Code Added by DipaliS 6 Oct 2004
        If Not IsNothing(Request.QueryString("FromTimeSheet")) Then
            m_strFromTimeSheet = Request.QueryString("FromTimeSheet")
        Else
            m_strFromTimeSheet = ""
        End If

        'End addition by DipaliS
        'Code Added 29 May
        m_intLoggedInEmpID = 61
        m_intRoleLevel = 1
        'End if addition

        'Get the Year,ResourceID and Month
        m_intYear = CType(Request.QueryString("Year"), Integer)
        m_intResourceID = 61
        m_intMonth = CType(Request.QueryString("Month"), Integer)


        '##### Code Added By AmitD on 20 Sep 2004
        m_SiteID = CType(Request.QueryString("SiteID"),Integer)
        '##### End Addition


        'Code Added by DipaliS 7 Oct 2004


        If Session("intProjectID") Is Nothing Then
            strProjectID = CType(Request.QueryString("ProjectID"), String)
        Else
            strProjectID = CType(Session("intProjectID"), String)
        End If

        If (m_SiteID = 0 Or IsNothing(m_SiteID)) And m_strFromTimeSheet = "1" Then
            'Set the First site as default
            Dim strSQLForSite As String

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQLForSite = "Select TOP 1 ProjectSiteID from tbl_PM_ProjectSites Where ProjectID=" + CType(strProjectID, String) + " order by Name"
            strSQLForSite = "usp_sel_tbl_PM_ProjectSites_ProjectSiteID " + CType(strProjectID, String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            m_SiteID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQlForSite, MyBase.UseSQL), "0"), Integer)
        End If
        'End addition by DipaliS

        '##### Get the Holiday List 
        Dim drGetHolidayList As IDataReader
        Dim intStartingDayofWeek As Integer
        Dim intWeekDays As Integer
        Dim intTotalWeekEnds As Integer
        Dim i As Integer


        m_strHolidayList = ""
        m_strWeekEnds = ""
        m_NormalDays = ""

        'Modified by Anju
        'Purpose: If calendar is called from project timesheet View Site Calendar link then 
        '           display onky frozen calendar changes
        If m_strFromTimeSheet = "1" Then
            If m_intMonth <> 0 And m_intYear <> 0 Then
                'strSQL = "SELECT *, Day(Date) as Day from tbl_PM_ProjectSiteCalendar WHERE Freeze = 1 AND SiteID = " + CType(m_SiteID, String) + " AND Month(Date)=" + CType(m_intMonth, String) + " AND Year(Date)=" + CType(m_intYear, String) '+ " AND Holiday = 1"
                strSQL = "usp_sel_tbl_PM_ProjectSiteCalendar_Day_Freeze " + CType(m_SiteID, String) + "," + CType(m_intMonth, String) + "," + CType(m_intYear, String) '+ " AND Holiday = 1"
            Else
                'strSQL = "SELECT *, Day(Date) as Day from tbl_PM_ProjectSiteCalendar WHERE Freeze = 1 AND SiteID = " + CType(m_SiteID, String) + " AND Month(Date)=" + CType(Month(Now()), String) + " AND Year(Date)=" + CType(Year(Now()), String) '+ " AND Holiday = 1"
                strSQL = "usp_sel_tbl_PM_ProjectSiteCalendar_Day_Freeze " + CType(m_SiteID, String) + "," + CType(Month(Now()), String) + "," + CType(Year(Now()), String) '+ " AND Holiday = 1"

            End If
        Else
            If m_intMonth <> 0 And m_intYear <> 0 Then
                'strSQL = "SELECT *, Day(Date) as Day from tbl_PM_ProjectSiteCalendar WHERE SiteID = " + CType(m_SiteID, String) + " AND Month(Date)=" + CType(m_intMonth, String) + " AND Year(Date)=" + CType(m_intYear, String) '+ " AND Holiday = 1"
                strSQL = "usp_sel_tbl_PM_ProjectSiteCalendar_Day " + CType(m_SiteID, String) + "," + CType(m_intMonth, String) + "," + CType(m_intYear, String) '+ " AND Holiday = 1"
            Else
                'strSQL = "SELECT *, Day(Date) as Day from tbl_PM_ProjectSiteCalendar WHERE SiteID = " + CType(m_SiteID, String) + " AND Month(Date)=" + CType(Month(Now()), String) + " AND Year(Date)=" + CType(Year(Now()), String) '+ " AND Holiday = 1"
                strSQL = "usp_sel_tbl_PM_ProjectSiteCalendar_Day " + CType(m_SiteID, String) + "," + CType(Month(Now()), String) + "," + CType(Year(Now()), String) '+ " AND Holiday = 1"
            End If
        End If
        drGetHolidayList = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        'Added by DipaliS 14 Oct 2004
        'Purpose    :   If called from timesheet then show only those calendar details which are 
        'used for Update Resource TimeSheet
        'Get All the Days in form of comma seperated string from the intermediate table
        Dim strDates As String = ","
        If m_strFromTimeSheet = "1" Then
            If Not IsNothing(Request.QueryString("TimeSheetID")) Then
                m_strTimeSheetNo = Request.QueryString("TimeSheetID")
            Else
                m_strTimeSheetNo = "0"
            End If

            Dim drInter As IDataReader
            Dim strInterSQL As String
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strInterSQL = "SELECT *, Day(Date) as Day FROM Tbl_PM_SiteCal_Intermediate Where TimeSheetNo=" + m_strTimeSheetNo
            strInterSQL = "usp_sel_Tbl_PM_SiteCal_Intermediate_Day " + m_strTimeSheetNo
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            drInter = CommonFunction.Data.GetDataReader(strInterSQL, MyBase.UseSQL)
            While drInter.Read
                strDates += CType(CommonFunctions.Data.CheckIsDBNull(drInter("Day"), ""), String) + ","
            End While
            CommonFunction.Data.DisposeDataReader(drInter)
        End If
        'End addition by DipaliS

        While drGetHolidayList.Read
            'Code Added by DipaliS 14 oct 2004
            If m_strFromTimeSheet = "1" Then
                'No entries in the intermediate table
                If strDates = "," Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("Holiday"), "0"), Boolean) = True Then
                        ' added by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry on 28 Jun 2006
                        'Code Commenetd by SavitaS for Bristlecone IssueID 2355 on 12 June 2006
                        'Comment removed by JyotiG
                        'Start_JG_11788_21-Mar-2007
                        'Issue : 1. Go to Projects > Project Management > Project Sites.
                        '2. Open a site in edit mode and click the Site Calendar link.
                        '3. Click a date link (select a working day) and set it as a holiday and save. The date is dispalyed in red color.
                        '4. Click the Freeze Site Details link.
                        '5. Now go to Monitor & Control > Timesheet link, open a timesheet in edit mode and click the 'View Site Calendar' link.
                        '6. Holiday is not displayed in Red color.
                        m_strHolidayList = m_strHolidayList + CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("Day"), ""), String) + ","
                        'End_JG_11788_21-Mar-2007
                        'End Comment by SavitaS
                        'end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry 28 Jun 2006
                    Else
                        m_NormalDays = m_NormalDays + CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("Day"), ""), String) + ","
                    End If
                Else
                    If strDates.IndexOf("," + CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("Day"), ""), String) + ",") > -1 Then
                        If CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("Holiday"), "0"), Boolean) = True Then
                            m_strHolidayList = m_strHolidayList + CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("Day"), ""), String) + ","
                        Else
                            m_NormalDays = m_NormalDays + CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("Day"), ""), String) + ","
                        End If
                    End If
                End If
            Else
                'End addition
                If CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("Holiday"), "0"), Boolean) = True Then
                    m_strHolidayList = m_strHolidayList + CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("Day"), ""), String) + ","
                Else
                    m_NormalDays = m_NormalDays + CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("Day"), ""), String) + ","
                End If
                'Code added by DipaliS 14 Oct 2004
            End If
            'end addition

        End While

        ' added by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry on 28 Jun 2006
 	'If m_strHolidayList <> "" Then
        '    If Right(m_strHolidayList, 1) = "," Then
        '        m_strHolidayList = Left(m_strHolidayList, Len(m_strHolidayList) - 1)
        '    End If
        'End If
        '---------------------------------------------------------------------------------------
        'Added by SavitaS for Bristlecone IssueID 2355 on 12 June 2006
        'Issue :In site calendar, althogh date is marked as holiday, the color does not change. 
        Dim strGetHolidays As String = ""
        Dim drHolidays As IDataReader

        Dim strPID As String = ""
        If Session("intProjectID") Is Nothing Then
            strPID = CType(Request.QueryString("ProjectID"), String)
        Else
            strPID = CType(Session("intProjectID"), String)
        End If

        If m_intMonth <> 0 And m_intYear <> 0 Then
            'Modified by TruptiK on 10-Apr-2008
            'Purpose:-Added one more parameter to sp siteid.
            'strGetHolidays = "Exec usp_GetOULevelHolidays " & strPID & "," & CType(m_intMonth, String) & "," & CType(m_intYear, String)
            strGetHolidays = "Exec usp_GetOULevelHolidays " & strPID & "," & CType(m_intMonth, String) & "," & CType(m_intYear, String) & "," & CType(m_SiteID, String)
        Else
            'strGetHolidays = "Exec usp_GetOULevelHolidays " & strPID & "," & CType(Month(Now()), String) & "," & CType(Year(Now()), String)
            strGetHolidays = "Exec usp_GetOULevelHolidays " & strPID & "," & CType(Month(Now()), String) & "," & CType(Year(Now()), String) & "," & CType(m_SiteID, String)
        End If
        'End of modification by TruptiK on 10-Apr-2008
        drHolidays = CommonFunctions.Data.GetDataReader(strGetHolidays, MyBase.UseSQL)
        While drHolidays.Read
            m_strHolidayList = m_strHolidayList + CType(CommonFunctions.Data.CheckIsDBNull(drHolidays("Day"), ""), String) + ","

        End While
        CommonFunctions.Data.DisposeDataReader(drHolidays)
        If m_strHolidayList <> "" Then
            If Right(m_strHolidayList, 1) = "," Then
                m_strHolidayList = Left(m_strHolidayList, Len(m_strHolidayList) - 1)
            End If
        End If
        'End Addition by SavitaS for Bristlecone IssueID 2355 on 12 June 2006
        '---------------------------------------------------------------------------------------
        ' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry 28 Jun 2006
        If m_NormalDays <> "" Then
            If Right(m_NormalDays, 1) = "," Then
                m_NormalDays = Left(m_NormalDays, Len(m_NormalDays) - 1)
            End If
        End If

        CommonFunctions.Data.DisposeDataReader(drGetHolidayList)

        ' Code added by SwapnilR on 15 Nov 2004
        ' Purpose : For the issue of Rave custmization project in which holidays on site calender are
        '           displayed as per the site.  Starting day of week and weekdays are to be considered
        '           instead of Company information

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT StartingDayOfWeek, WeekDays FROM tbl_PM_ProjectSites WHERE ProjectID = " + strProjectID + " AND ProjectSiteID = " + CType(m_SiteID, String)
        strSQL = "usp_sel_tbl_PM_ProjectSites_StartingDayOfWeek_WeekDays " + strProjectID + "," + CType(m_SiteID, String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        ' End of code addtion
        drGetHolidayList = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drGetHolidayList.Read Then
            intStartingDayofWeek = CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("StartingDayOfWeek"), "0"), Integer)
            intWeekDays = CType(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList("WeekDays"), "0"), Integer)
        End If

        CommonFunctions.Data.DisposeDataReader(drGetHolidayList)
        intTotalWeekEnds = 7 - CType(intWeekDays, Integer)


        'Modified By SantoshK
        'Date 30 Sep 2004
        'Changed Logic
        If intTotalWeekEnds <> 0 Then
            ''dhn
            ''Commented & added by Dipali V On 21st April  2021 For Weekend Days should be proper
            For i = 1 To intTotalWeekEnds
                'For i = 1 To intTotalWeekEnds + 1
                ''End of Commented & added by Dipali V On 21st April  2021 For Weekend Days should be proper
                If (intStartingDayofWeek - i) < 0 Then
                    m_strWeekEnds = m_strWeekEnds + CType((7 + (intStartingDayofWeek - i)), String) + ","
                Else
                    m_strWeekEnds = m_strWeekEnds + CType((intStartingDayofWeek - i), String) + ","
                End If


            Next
        End If
        'Modification Ends

        If m_strWeekEnds <> "" Then
            If Right(m_strWeekEnds, 1) = "," Then
                m_strWeekEnds = Left(m_strWeekEnds, Len(m_strWeekEnds) - 1)
            End If
        End If
        '##### End Addition

        m_strHours = " "

        If m_intYear = 0 Then
            m_intYear = DateTime.Now.Year
        End If

        If m_intMonth = 0 Then
            m_intMonth = DateTime.Now.Month
        End If

        m_strMonthName = GetMonthName(m_intMonth)



        Dim strQuery As String
        Dim strEmployeeName As String

        GetMenu()
        Response.Write("<BR>")

        'Write the client side array containing the Name of WeekDays
        GetWeekDayArray()



        'Page Caption
        WebPages.Template.PageCaption.GetPageCaptions(Nothing, "Site Calendar")

        Response.Write("<BR>")

        'Code Added by DipaliS 7 Oct 2004
        'Purpose : To Show the combo for Site if accesses from the timesheet
        If m_strFromTimeSheet = "1" Then
            Dim strHTML As String
            Dim strSQLForSite As String

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQLForSite = "Select ProjectSiteID,Name from tbl_PM_ProjectSites Where ProjectID=" + CType(strProjectID, String) + " order by Name"
            strSQLForSite = "usp_sel_tbl_PM_ProjectSites_ProjectSiteID_Name " + CType(strProjectID, String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168

            strHTML += "<TABLE class=clsTable width=99.9%><TR class=clsTREven><TD> Site "
            strHTML += CommonFunction.HTMLControls.DrawComboBox("cboSite", strSQLForSite, 200, m_SiteID.ToString, "onChange=Site_OnChange();", False, True)
            strHTML += "</TD></TR></TABLE>"
            Response.Write(strHTML)

        End If
        'End addition by DipaliS

        Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")

        GetPageUI()



        Response.Write("</DIV>")

        GetMenu()

    End Sub

    '====================================================================
    ' Procedure Name        :       GetMenu
    ' Parameters Passed     :       None
    ' Returns               :       None
    ' Parameters Affected   :       None
    ' Purpose               :       Displays the Static menu for the page
    ' Description           :       Same as above
    ' Assumptions           :       None
    ' Dependencies          :       None
    ' Author                :       DipaliS
    ' Created               :       May 21, 2004
    ' Revisions :
    '=====================================================================
    Private Sub GetMenu()
        'Commented by Lakshmi as Freeze Site Details link is available from the main page..i.e Project Site
        'Dim arrMenu() As String = {" Freeze Site Details ", " Previous Month ", " Next Month ", " Close ", " ? "}
        'Dim arrMenuClientFun() As String = {"FreezeDetails_OnClick()", "Previous_OnClick()", "Next_OnClick()", "Close_OnClick()", "Help_OnClick(1616)"}
        'Dim arrMenuToolTip() As String = {" Freeze Site Details ", " Previous Month ", " Next Month ", " Close ", " Help "}
        Dim arrMenu() As String = {"<font color='#cc0000'>Previous Month</font>", "<font color='#cc0000'>Next Month</font>", " Close ", " ? "}
        'Modification by PrachiK on 5 Mar 2005 for IssueID 17462
        'Purpose:The parent page of Project Site does not refreshes when the site calender is changed.
        Dim arrMenuClientFun() As String = {"Previous_OnClick()", "Next_OnClick()", "CloseOnClick()", "Help_OnClick('PM_VIEWCALENDER')"}
        'Modification ended
        Dim arrMenuToolTip() As String = {" Previous Month ", " Next Month ", " Close ", " Help "}
        Dim objMenu As WebPages.Template.StaticMenu
        objMenu = New WebPages.Template.StaticMenu
        objMenu.DrawMenu(arrMenu, arrMenuClientFun, arrMenuToolTip, False)
        objMenu = Nothing
    End Sub




    '====================================================================
    ' Procedure Name        :   GetWeekDayArray
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   Write the Clent side array for Names of Days in Week
    ' Description           :   None
    ' Assumptions           :   Resource file for the ame exists
    ' Dependencies          :   Same as above
    ' Author                :   DipaliS
    ' Created               :   May 23, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetWeekDayArray()
        Response.Write(" <SCRIPT LANGUAGE=javascript>	" & vbCrLf)
        Response.Write(" var arrWeekDays=new Array(" & vbCrLf)
        Response.Write("""" & "Sun" & """" & "," & vbCrLf)
        Response.Write("""" & "Mon" & """" & "," & vbCrLf)
        Response.Write("""" & "Tue" & """" & "," & vbCrLf)
        Response.Write("""" & "Wed" & """" & "," & vbCrLf)
        Response.Write("""" & "Thu" & """" & "," & vbCrLf)
        Response.Write("""" & "Fri" & """" & "," & vbCrLf)
        Response.Write("""" & "Sat" & """" & ")" & vbCrLf)
        Response.Write("</Script>")
    End Sub
    Private Sub GetPageUI()
        Dim strHTML As StringBuilder
        Dim strSQL As String


        strHTML = New StringBuilder
        'strHTML.Append("<table class=clsBorderTable height=458 cellSpacing=0 cellPadding=0 width=100% align=center border=1><tbody><tr><td vAlign=top height=288>")

        'Get the Projects Listing
        strHTML.Append("<table cellSpacing=0 cellPadding=0 width=99.9% border=1><tbody><tr class=clsTRSectionHeader>")

        'Commented & Added by GokulP on 15 Sept 2009 for IssueID : 33186
        'strHTML.Append("<td  height=22 class=clsTDSelected valign=top >&nbsp; </td><td  height=22  id=tdSchedule" & " valign=top></td>")
        strHTML.Append("<td  height=22  id=tdSchedule" & " valign=top></td>")
        'End of Comment & Addition by GokulP on 15 Sept 2009 for IssueID : 33186

        strHTML.Append("</tr></table>")

        ' strHTML.Append("</tbody></tr></td> </table>")

        Response.Write(strHTML)
    End Sub


#End Region

#Region "Functions"
    '====================================================================
    ' Procedure Name    :   GetMonthName
    ' Parameters Passed :   MonthIndex
    ' Returns           :   Name of Month
    ' Parameters Affected : None
    ' Purpose           :   To Get the Month Name from Resource File
    ' Description       :   Same as above
    ' Assumptions       :   Resource file for same exists
    ' Dependencies      :   none
    ' Author            :   DipaliS
    ' Created           :   May 21, 2004
    ' Revisions :
    '=====================================================================
    Protected Function GetMonthName(ByVal MonthIndex As Integer) As String
        Dim strMonthName As String
        MyBase.InitializeResources("AppResources.PM_ResourceHistory", "AppResources")
        Select Case MonthIndex
            Case 1
                strMonthName = "Jan" '(MyBase.GetResourceString("JAN"))
            Case 2
                strMonthName = "Feb" '(MyBase.GetResourceString("FEB"))
            Case 3
                strMonthName = "Mar" '(MyBase.GetResourceString("MARCH"))
            Case 4
                strMonthName = "Apr" '(MyBase.GetResourceString("APRIL"))
            Case 5
                strMonthName = "May" '(MyBase.GetResourceString("MAY"))
            Case 6
                strMonthName = "Jun " '(MyBase.GetResourceString("JUNE"))
            Case 7
                strMonthName = "Jul " '(MyBase.GetResourceString("JULY"))
            Case 8
                strMonthName = "Aug" '(MyBase.GetResourceString("AUGUST"))
            Case 9
                strMonthName = "Sep" '(MyBase.GetResourceString("SEPTEMBER"))
            Case 10
                strMonthName = "Oct" '(MyBase.GetResourceString("OCTOBER"))
            Case 11
                strMonthName = "Nov" '(MyBase.GetResourceString("NOVEMBER"))
            Case 12
                strMonthName = "Dec" '(MyBase.GetResourceString("DECEMBER"))
        End Select

        Return strMonthName
    End Function
    '====================================================================
    ' Procedure Name    :   GetPrevisousMonthName
    ' Parameters Passed :   None
    ' Returns           :   Name of Month
    ' Parameters Affected : None
    ' Purpose           :   To Get the Month Name of previous month from Resource File
    ' Description       :   Same as above
    ' Assumptions       :   Resource file for same exists
    ' Dependencies      :   none
    ' Author            :   DipaliS
    ' Created           :   May 21, 2004
    ' Revisions :
    '=====================================================================
    Protected Function GetPrevisousMonthName() As String
        Return GetMonthName(m_intMonth - 1)
    End Function
    '====================================================================
    ' Procedure Name    :   GetNextMonthName
    ' Parameters Passed :   None
    ' Returns           :   Name of Month
    ' Parameters Affected : None
    ' Purpose           :   To Get the Month Name of next month from Resource File
    ' Description       :   Same as above
    ' Assumptions       :   Resource file for same exists
    ' Dependencies      :   none
    ' Author            :   DipaliS
    ' Created           :   May 21, 2004
    ' Revisions :
    '=====================================================================
    Protected Function GetNextMonthName() As String
        Return GetMonthName(m_intMonth + 1)
    End Function
#End Region
    ''Added by Yogesh J on01-Mar-2016 for to generate  Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_SiteCalendarDetails(EmpDate As String, EmployeeID As String, SiteID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(EmpDate, String) + CType(SiteID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 01-Mar-2016
End Class
