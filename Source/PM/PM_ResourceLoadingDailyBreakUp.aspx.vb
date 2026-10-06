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

Public Class PM_ResourceLoadingDailyBreakUp
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

#Region "Constructor"
    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_ResourceLoadingDailyBreakUp", "AppResources")
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
#End Region

#Region "Constants"
    Public Const GRAPH_DIRECTORY As String = "../../images/DB_GRAPHS/"
    Private m_intGraphWidth As Integer = 400
    Private m_intGraphHeight As Integer = 250
#End Region

#Region "Procedures"
    Public Sub PageInit()
        '######### Page Code starts here
        'Code Added 29 May
        m_intLoggedInEmpID = CType(CommonFunctions.General.CheckIsNothing(Session("intUserID")), Integer)
        m_intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel")), Integer)
        'End if addition

        'Get the Year,ResourceID and Month
        m_intYear = CType(Request.QueryString("Year"), Integer)
        m_intResourceID = CType(Request.QueryString("ResourceID"), Integer)
        m_intMonth = CType(Request.QueryString("Month"), Integer)
        m_strHours = " " & MyBase.GetResourceString("HOURS")

        If m_intYear = 0 Then
            m_intYear = DateTime.Now.Year
        End If

        If m_intMonth = 0 Then
            m_intMonth = DateTime.Now.Month
        End If
        
        m_strMonthName = GetMonthName(m_intMonth)

        'If middle level then apply filter for Projects
        If m_intRoleLevel = 2 Then
            'Apply Role Access Filter for Project List
            m_strProjectFilters = ""
            Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            If strFilter <> "" Then
                m_strProjectFilters += strFilter
            End If
            'Code Commented By DipaliS 15 July and added the following
            'm_strProjectFilters = m_strProjectFilters.Replace("ProjectID IN ", "")
            Dim strRemove As String = "ProjectID IN"
            m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
            'End Addition
            m_strProjectFilters = m_strProjectFilters.Replace("'", "")
        End If

        Dim strQuery As String
        Dim strEmployeeName As String

        GetMenu()
        Response.Write("<BR>")

        'Write the client side array containing the Name of WeekDays
        GetWeekDayArray()


        'Get the client side array containing the values for Dialy BreakUp for the resource
        '''Code commented by SwatiC on 19Jun 2007 for performance Issue
        'GetDailyBreakUpClientSideArray()
        '''End of Code commentation by SwatiC on 19Jun 2007 for performance Issue

        'Get the employeename
        'With (NOLOCK) added by SwatiC on 19 Jun 2007 for performance Issue

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "Select UserName from tbl_PM_Employee WITH (NOLOCK) where EmployeeID=" & m_intResourceID.ToString
        strQuery = "usp_sel_tbl_PM_Employee_UserNameForEmployeeID " & m_intResourceID.ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        strEmployeeName = CType(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), String)

        'Page Caption
        WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("PAGE_CAPTION"))

        Response.Write("<BR>")

        Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")

        GetPageUI()

        Response.Write("<BR>")

        Response.Write("</DIV>")

        GetMenu()
        'Code added by SwatiC on 22 Jun 2007 -- For Financial Year Consideration
        'To Store the financial year date range. 'm_intYear
        Dim strFinancialyDates As String
        Dim intFinYear As Integer
        Dim intFinMonth As Integer

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("FinMonth"), "") <> "" And CommonFunctions.General.CheckIsNothing(Request.QueryString("FinYear"), "") <> "" Then
            intFinYear = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("FinYear"), ""), Integer)
            intFinMonth = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("FinMonth"), ""), Integer)
            strFinancialyDates = intFinMonth.ToString + "," + intFinYear.ToString + "," + (intFinMonth - 1).ToString + "," + (intFinYear + 1).ToString
        Else
            strFinancialyDates = Request.Form("txtHiddenFinDateRange")
        End If

        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFinDateRange", "txtHiddenFinDateRange", , , , strFinancialyDates, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        'End of Code addition by SwatiC on 22 Jun 2007 -- For Financial Year Consideration


        ''Added by Dhanashri S on 31 Mar 2016

        'If (Request.QueryString("PKLoadDetailsToken") <> "" And Request.QueryString("Month") <> "" And Request.QueryString("Year") <> "" And Request.QueryString("FinMonth") <> "" And Request.QueryString("FinYear") <> "" And Request.QueryString("ResourceID") <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("Month"), String) + CType(Request.QueryString("Year"), String) + CType(Request.QueryString("FinMonth"), String) + CType(Request.QueryString("FinYear"), String) + CType(Request.QueryString("ResourceID"), String) + "0" + "0", Request.QueryString("PKLoadDetailsToken")) = False) Then

        '        'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If

        If (Request.QueryString("Month") <> "" And Request.QueryString("Year") <> "" And Request.QueryString("FinMonth") <> "" And Request.QueryString("FinYear") <> "" And Request.QueryString("ResourceID") <> "") Then
            If (((Request.QueryString("PkToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("Month"), String) + CType(Request.QueryString("Year"), String) + CType(Request.QueryString("FinMonth"), String) + CType(Request.QueryString("FinYear"), String) + CType(Request.QueryString("ResourceID"), String) + "0" + "0", Request.QueryString("PkToken")) = False)) Then
                'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

        ''End of Addition by Dhanashri S on 31 MAr 2016
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
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PREMONTH"), MyBase.GetResourceString("MENU_NEXTMONTH"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuClientFun() As String = {"Previous_OnClick()", "Next_OnClick()", "Close_OnClick()", "Help_OnClick(1616)"}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PREMONTH_TOOLTIP"), MyBase.GetResourceString("MENU_NEXTMONTH_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim objMenu As WebPages.Template.StaticMenu
        objMenu = New WebPages.Template.StaticMenu
        objMenu.DrawMenu(arrMenu, arrMenuClientFun, arrMenuToolTip, False)
        objMenu = Nothing
    End Sub
    '====================================================================
    ' Procedure Name        :  GetDailyBreakUpClientSideArray
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   Create a client side array to store daily breakup of all projects 
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                : DipaliS
    ' Created               : May 21, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetDailyBreakUpClientSideArray()
        'Code Coomented by SwatiC on 19 Jun 2007 for Performance Issue
        'Dim intIndex As Integer
        'Dim intDays As Integer
        'Dim strSQL As String
        'Dim drResourceLoading As IDataReader
        'Dim drNumberOfRows As IDataReader

        ''Get the Number of rows
        ''Code Commented 29 May
        ''strSQL = "usp_Sel_ResourceLoadingDailyBreakup  " & m_intMonth & "," & m_intYear & "," & m_intResourceID 

        ''If Level is 2 then apply project level filter
        'If m_intRoleLevel <> 2 Then
        '    strSQL = "usp_Sel_ResourceLoadingDailyBreakup  " & m_intMonth & "," & m_intYear & "," & m_intResourceID & _
        '                 ",0," & m_intLoggedInEmpID & "," & m_intRoleLevel
        'Else
        '    strSQL = "usp_Sel_ResourceLoadingDailyBreakup  " & m_intMonth & "," & m_intYear & "," & m_intResourceID & _
        '                             ",0," & m_intLoggedInEmpID & "," & m_intRoleLevel & ",'" & m_strProjectFilters & "'"
        'End If

        'drNumberOfRows = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        'While drNumberOfRows.Read
        '    m_intRowCount = m_intRowCount + 1
        'End While
        'CommonFunctions.Data.DisposeDataReader(drNumberOfRows)

        'drResourceLoading = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        'If m_intRowCount > 0 Then
        '    Response.Write(" <SCRIPT LANGUAGE=javascript>	" & vbCrLf)
        '    Response.Write(" var arrScheduleDetails=new Array(" & m_intRowCount & ");" & vbCrLf)

        '    Response.Write(" for(var count=0;count<arrScheduleDetails.length;count++)" & vbCrLf)
        '    Response.Write("arrScheduleDetails[count]=new Array(32);" & vbCrLf)

        '    'Added By MrugajaB on 23rd March,2005
        '    'Purpose:Declaring array which stores actual work hours for an employee for specified month
        '    Response.Write(" var arrDADetails=new Array(" & m_intRowCount & ");" & vbCrLf)
        '    Response.Write(" for(var count=0;count<arrDADetails.length;count++)" & vbCrLf)
        '    Response.Write("arrDADetails[count]=new Array(32);" & vbCrLf)
        '    'End Addition

        '    For intIndex = 0 To m_intRowCount - 1
        '        If drResourceLoading.Read Then
        '            'Write the BookedHours,AllocatedHours,Total Working Hours

        '            'Code Added 29 May
        '            'If level 2 and 3 write total values for Other Projects
        '            If intIndex = 0 And m_intRoleLevel <> 1 Then
        '                Response.Write(" var intOtherBookedHours; " & vbCrLf)
        '                Response.Write(" intOtherBookedHours= " & FormatNumber(drResourceLoading.Item("TotalBookedHours"), 2) & ";" & vbCrLf)
        '                Response.Write(" var intOtherAllocatedHours ;" & vbCrLf)

        '                ''Added By MrugajaB on 29th March 2005 for displaying Daily Booked Hours for Other Projects
        '                Response.Write(" var intOtherBookedHoursDaily ;" & vbCrLf)
        '                Response.Write(" intOtherBookedHoursDaily= " & FormatNumber(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("BookedHoursDaily"), "0"), 2) & ";" & vbCrLf)

        '                '' START : Commented and Integrated By ParagD On 3-Oct-2006
        '                ''Response.Write(" intOtherAllocatedHours= " & FormatNumber(drResourceLoading.Item("Total"), 2) & ";" & vbCrLf)
        '                ''Response.Write(" intOtherTotalWorkingHours= " & FormatNumber(drResourceLoading.Item("WorkingHours"), 2) & ";" & vbCrLf)

        '                Response.Write(" intOtherAllocatedHours= " & drResourceLoading.Item("Total").ToString & ";" & vbCrLf)
        '                'Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
        '                Response.Write(" var intOtherTotalWorkingHours ;" & vbCrLf)
        '                'End of Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
        '                Response.Write(" intOtherTotalWorkingHours= " & drResourceLoading.Item("WorkingHours").ToString & ";" & vbCrLf)
        '                'End of Commented and Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
        '                '' END : Commented and Integrated By ParagD On 3-Oct-2006

        '                'End Addition
        '            End If
        '            'End of Addition

        '            'Code Commented 29 May

        '            'If intIndex = 0 Then
        '            'Write the total values for All Project
        '            Response.Write(" var intBookedHours; " & vbCrLf)
        '            Response.Write(" var intAllocatedHours ;" & vbCrLf)
        '            Response.Write(" var intAllBookedHoursDaily ;" & vbCrLf)
        '            If (intIndex = 1 And m_intRoleLevel <> 1) Or (intIndex = 0 And m_intRoleLevel = 1) Then

        '                Response.Write(" intBookedHours= " & FormatNumber(drResourceLoading.Item("TotalBookedHours"), 2) & ";" & vbCrLf)

        '                Response.Write(" intAllocatedHours= " & FormatNumber(drResourceLoading.Item("Total"), 2) & ";" & vbCrLf)
        '                Response.Write(" intTotalWorkingHours= " & FormatNumber(drResourceLoading.Item("WorkingHours"), 2) & ";" & vbCrLf)
        '                'Added By MrugajaB on 29th March 2005 for displaying Daily Booked Hours for All Projects
        '                Response.Write(" intAllBookedHoursDaily= " & FormatNumber(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("BookedHoursDaily"), "0"), 2) & ";" & vbCrLf)
        '                'End Addition

        '                '' START : Commented and Integrated By ParagD On 3-Oct-2006
        '                'Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
        '                Response.Write(" var intTotalWorkingHours ;" & vbCrLf)
        '                'End of Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
        '                Response.Write(" intTotalWorkingHours= " & drResourceLoading.Item("WorkingHours").ToString & ";" & vbCrLf)
        '                'End of Commented and Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
        '                '' END : Commented and Integrated By ParagD On 3-Oct-2006
        '            End If

        '            'Write the value by reading from the datareader
        '            For intDays = 1 To 31
        '                Response.Write("arrScheduleDetails[" & intIndex & "][" & intDays & "]=" & CType(drResourceLoading.Item(intDays + 2), String) & "   " & ";" & vbCrLf)
        '            Next


        '            'Added By MrugajaB on 23rd March,2005
        '            'Purpose:Initializing array with actual work hour values for an employee for specified month
        '            For intDays = 1 To 31
        '                Response.Write("arrDADetails[" & intIndex & "][" & intDays & "]=" & CType(drResourceLoading.Item(intDays + 40), String) & "   " & ";" & vbCrLf)
        '            Next
        '            'End Addition

        '        End If
        '    Next

        'End If
        'Response.Write("</Script>")
        'End of Code Coomentation by SwatiC on 19 Jun 2007 for Performance Issue
    End Sub
    '====================================================================
    ' Procedure Name        :      GetPageUI
    ' Parameters Passed     :       None
    ' Returns               :       None
    ' Parameters Affected   :       None
    ' Purpose               :       Writes the HTML for the page
    ' Description           :       Same as above
    ' Assumptions           :       None
    ' Dependencies          :       None
    ' Author                :       DipaliS
    ' Created               :       May 21, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetPageUI()
        Dim strHTML As StringBuilder
        Dim strSQL As String
        strHTML = New StringBuilder

        ''Code Coomented and added by SwatiC on 19 Jun 2007 for Performance Issue
        'Dim drResourceLoading As IDataReader

        'Code added by SwatiC on 19 jun 2007
        'logic of GetDailyBreakUpClientSideArray() is moved here 
        ''''''''''''''''''''''''''''****************************************'''''''''''''''''''''''''''''
        Dim dsResourceLoading As DataSet
        Dim drResourceLoading As DataRow
        Dim intIndex As Integer
        Dim intDays As Integer

        'If Level is 2 then apply project level filter       
        If m_intRoleLevel <> 2 Then
            strSQL = "usp_Sel_ResourceLoadingDailyBreakup  " & m_intMonth & "," & m_intYear & "," & m_intResourceID & _
                         ",0," & m_intLoggedInEmpID & "," & m_intRoleLevel
        Else
            strSQL = "usp_Sel_ResourceLoadingDailyBreakup  " & m_intMonth & "," & m_intYear & "," & m_intResourceID & _
                                     ",0," & m_intLoggedInEmpID & "," & m_intRoleLevel & ",'" & m_strProjectFilters & "'"
        End If


        dsResourceLoading = CommonFunctions.Data.GetDataSet(strSQL, "ResourceLoading", , , MyBase.UseSQL)
        m_intRowCount = dsResourceLoading.Tables(0).Rows.Count

        If m_intRowCount > 0 Then
            Response.Write(" <SCRIPT LANGUAGE=javascript>	" & vbCrLf)
            Response.Write(" var arrScheduleDetails=new Array(" & m_intRowCount & ");" & vbCrLf)

            Response.Write(" for(var count=0;count<arrScheduleDetails.length;count++)" & vbCrLf)
            Response.Write("arrScheduleDetails[count]=new Array(32);" & vbCrLf)

            'Added By MrugajaB on 23rd March,2005
            'Purpose:Declaring array which stores actual work hours for an employee for specified month
            Response.Write(" var arrDADetails=new Array(" & m_intRowCount & ");" & vbCrLf)
            Response.Write(" for(var count=0;count<arrDADetails.length;count++)" & vbCrLf)
            Response.Write("arrDADetails[count]=new Array(32);" & vbCrLf)
            'End Addition

            For intIndex = 0 To m_intRowCount - 1

                drResourceLoading = dsResourceLoading.Tables(0).Rows(intIndex)
                'Write the BookedHours,0,Total Working Hours
                'Code Added 29 May

                'If level 2 and 3 write total values for Other Projects
                'If intIndex = 0 And m_intRoleLevel <> 1 Then
                If (CType(drResourceLoading.Item("ProjectID"), String) = "-1") Then
                    Response.Write(" var intOtherBookedHours; " & vbCrLf)
                    Response.Write(" intOtherBookedHours= '" & FormatNumber(drResourceLoading.Item("TotalBookedHours"), 2) & "';" & vbCrLf)
                    Response.Write(" var intOtherAllocatedHours ;" & vbCrLf)

                    ''Added By MrugajaB on 29th March 2005 for displaying Daily Booked Hours for Other Projects
                    Response.Write(" var intOtherBookedHoursDaily ;" & vbCrLf)
                    Response.Write(" intOtherBookedHoursDaily= '" & FormatNumber(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("BookedHoursDaily"), "0"), 2) & "';" & vbCrLf)

                    '' START : Commented and Integrated By ParagD On 3-Oct-2006
                    ''Response.Write(" intOtherAllocatedHours= " & FormatNumber(drResourceLoading.Item("Total"), 2) & ";" & vbCrLf)
                    ''Response.Write(" intOtherTotalWorkingHours= " & FormatNumber(drResourceLoading.Item("WorkingHours"), 2) & ";" & vbCrLf)

                    Response.Write(" intOtherAllocatedHours= " & drResourceLoading.Item("Total").ToString & ";" & vbCrLf)
                    'Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
                    Response.Write(" var intOtherTotalWorkingHours ;" & vbCrLf)
                    'End of Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
                    Response.Write(" intOtherTotalWorkingHours= " & drResourceLoading.Item("WorkingHours").ToString & ";" & vbCrLf)
                    'End of Commented and Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
                    '' END : Commented and Integrated By ParagD On 3-Oct-2006

                    'End Addition
                End If
                'End of Addition

                'Code Commented 29 May

                'If intIndex = 0 Then
                'Write the total values for All Project
                Response.Write(" var intBookedHours; " & vbCrLf)
                Response.Write(" var intAllocatedHours ;" & vbCrLf)
                Response.Write(" var intAllBookedHoursDaily ;" & vbCrLf)
                'Code Commented and Added by SwatiC on 30 Jun 2007 for Whiz7.0
                'If (intIndex = 1 And m_intRoleLevel <> 1) Or (intIndex = 0 And m_intRoleLevel = 1) Then
                If (CType(drResourceLoading.Item("ProjectID"), String) = "0") Then
                    'End of Code Addition by SwatiC on 30 Jun 2007 for Whiz7.0

                    ' Modified by ArchanaN on 24 Oct 2007
                    ' Purpose : JavaScript Error when any of the hours include comma in the value. 
                    Response.Write(" intBookedHours= '" & FormatNumber(drResourceLoading.Item("TotalBookedHours"), 2) & "';" & vbCrLf)

                    Response.Write(" intAllocatedHours= '" & FormatNumber(drResourceLoading.Item("Total"), 2) & "';" & vbCrLf)
                    Response.Write(" intTotalWorkingHours= '" & FormatNumber(drResourceLoading.Item("WorkingHours"), 2) & "';" & vbCrLf)
                    'Added By MrugajaB on 29th March 2005 for displaying Daily Booked Hours for All Projects
                    Response.Write(" intAllBookedHoursDaily= '" & FormatNumber(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("BookedHoursDaily"), "0"), 2) & "';" & vbCrLf)
                    'End Addition

                    '' START : Commented and Integrated By ParagD On 3-Oct-2006
                    'Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
                    Response.Write(" var intTotalWorkingHours ;" & vbCrLf)
                    'End of Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
                    Response.Write(" intTotalWorkingHours= " & drResourceLoading.Item("WorkingHours").ToString & ";" & vbCrLf)
                    'End of Commented and Added by SavitaS on 31 July 2006 for Sierra IssueID 2921
                    '' END : Commented and Integrated By ParagD On 3-Oct-2006
                End If


                Response.Write(" var intOpenBookedHours; " & vbCrLf)
                Response.Write(" var intOpenAllocatedHours ;" & vbCrLf)
                Response.Write(" var intAllBookedOpen ;" & vbCrLf)
              
                'Code Added by SwatiC on 30 Jun 2007 for Whiz7.0
                If (CType(drResourceLoading.Item("ProjectID"), String) = "-2") Then
                    'Response.Write(" intOpenBookedHours= " & FormatNumber(drResourceLoading.Item("TotalBookedHours"), 2) & ";" & vbCrLf)

                    Response.Write(" intOpenAllocatedHours= '" & FormatNumber(drResourceLoading.Item("Total"), 2) & "';" & vbCrLf)
                    'Response.Write(" intAllBookedOpen= " & FormatNumber(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("BookedHoursDaily"), "0"), 2) & ";" & vbCrLf)
                    'Response.Write(" var intTotalWorkingHoursOpen ;" & vbCrLf)
                    'Response.Write(" intTotalWorkingHoursOpen= " & drResourceLoading.Item("WorkingHours").ToString & ";" & vbCrLf)
                End If
                'End of Code Addition by SwatiC on 30 Jun 2007 for Whiz7.0

                'Write the value by reading from the datareader
                For intDays = 1 To 31
                    Response.Write("arrScheduleDetails[" & intIndex & "][" & intDays & "]=" & CType(drResourceLoading.Item(intDays + 2), String) & "   " & ";" & vbCrLf)
                Next

                'Added By MrugajaB on 23rd March,2005
                'Purpose:Initializing array with actual work hour values for an employee for specified month
                For intDays = 1 To 31
                    Response.Write("arrDADetails[" & intIndex & "][" & intDays & "]=" & CType(drResourceLoading.Item(intDays + 40), String) & "   " & ";" & vbCrLf)
                Next
                'End Addition

            Next
        End If

        Response.Write("</Script>")

        ''''''''''''''''''''''''''''''''*************************************'''''''''''''''''''''''''''
        'End of code additiobn by SwatiC on 19 jun


        'Code commented 29 May
        'Code commented by SwatiC on 19 jun 2007
        'strSQL = "usp_Sel_ResourceLoadingDailyBreakup  " & m_intMonth & "," & m_intYear & "," & m_intResourceID
        'If m_intRoleLevel <> 2 Then
        '    strSQL = "usp_Sel_ResourceLoadingDailyBreakup  " & m_intMonth & "," & m_intYear & "," & m_intResourceID & _
        '                 ",0," & m_intLoggedInEmpID & "," & m_intRoleLevel
        'Else
        '    strSQL = "usp_Sel_ResourceLoadingDailyBreakup  " & m_intMonth & "," & m_intYear & "," & m_intResourceID & _
        '                             ",0," & m_intLoggedInEmpID & "," & m_intRoleLevel & ",'" & m_strProjectFilters & "'"
        'End If

        'Get the Number of rows
        'Dim drNumberOfRows As IDataReader
        'drNumberOfRows = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        'While drNumberOfRows.Read
        '    m_intRowCount = m_intRowCount + 1
        'End While
        'CommonFunctions.Data.DisposeDataReader(drNumberOfRows)
        'End of code commentation by SwatiC on 19 jun 2007

        Dim strFileName As String

        'Code commented by SwatiC on 19 jun 2007
        'drResourceLoading = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        strHTML.Append("<table class=clsBorderTable height=458 cellSpacing=0 cellPadding=0 width=99.9% align=center border=0><tbody><tr><td vAlign=top height=288>")

        'Get the Projects Listing
        strHTML.Append("<table cellSpacing=0 cellPadding=0 width=99.9% border=0><tbody><tr class=clsTRSectionHeader>")
        strHTML.Append("<td width=30%>" & MyBase.GetResourceString("PROJECTS") & "</td></tr><tr><td>")
        strHTML.Append("<DIV STYLE=" & """overflow: auto; height:180;""" & "><TABLE  width=99.9% cellspacing=0 cellpadding=0>")

        Dim intArrayCount As Integer = 0
        Dim strImageDetails(m_intRowCount) As String
        Dim strProjectIDs(m_intRowCount) As String


        ''Code Added  by SwatiC on 19 jun 2007
        intIndex = 0
        Dim dsGraphData As DataSet
        Dim dRGraphData As DataRow
        Dim RowArray(2) As DataRow
        If m_intRoleLevel <> 1 Then
            strSQL = "usp_Sel_ResourceLoadingDailyBreakup " & m_intMonth & "," & m_intYear & "," & m_intResourceID & ",2," & m_intLoggedInEmpID & _
                     "," & m_intRoleLevel
        End If

        If m_intRoleLevel <> 1 Then
            dsGraphData = CommonFunctions.Data.GetDataSet("usp_Sel_ResourceLoadingDailyBreakupChart_New " & m_intMonth & "," & m_intYear & "," & m_intResourceID & ",'" & Replace(strSQL, "'", "''") & ",'," & m_intLoggedInEmpID.ToString & "," & m_intRoleLevel.ToString & ",'" & Session("LoginType").ToString & "','" & m_strProjectFilters & "'", "Graph", , , MyBase.UseSQL)
        Else
            dsGraphData = CommonFunctions.Data.GetDataSet("usp_Sel_ResourceLoadingDailyBreakupChart_New " & m_intMonth & "," & m_intYear & "," & m_intResourceID & ",NULL," & m_intLoggedInEmpID.ToString & ",NULL,NULL,NULL", "Graph", , , MyBase.UseSQL)
        End If
        ''End of Code Addition by SwatiC on 19 jun 2007

        For intIndex = 0 To m_intRowCount - 1
            ''Code Commented and added by SwatiC on 19 jun 2007 
            'If drResourceLoading.Read Then
            drResourceLoading = dsResourceLoading.Tables(0).Rows(intIndex)
            ''End of Code addition by SwatiC on 19 jun 2007 

            'Code Commented and Added by SwatiC on 30 Jun 2007 for Whiz7.0
            'Write the link for particular project and create the graph for the same
            'If (intIndex <> 0 And intIndex <> 1 And m_intRoleLevel <> 1) Or (m_intRoleLevel = 1 And intIndex <> 0) Then
            If (intIndex <> 1 And intIndex <> 2 And m_intRoleLevel <> 1) Or (m_intRoleLevel = 1 And intIndex <> 1) Then 'Or (CType(drResourceLoading.Item("ProjectID"), String) <> "-2") Then
                'End of Code addition by SwatiC on 30 Jun 2007 for Whiz7.0

                ''Code Commented and added by SwatiC on 19 jun 2007 
                'strSQL = "usp_Sel_ResourceLoadingDailyBreakupChart " & m_intMonth & "," & m_intYear & "," & m_intResourceID & "," & CType(drResourceLoading.Item("ProjectID"), String)
                RowArray = dsGraphData.Tables(0).Select("ProjectID=" & CType(drResourceLoading.Item("ProjectID"), String))
                ''End of Code addition by SwatiC on 19 jun 2007 
                strFileName = CommonFunction.FileDirectory.GetUniqueFileName()
                ''Code Commented and added by SwatiC on 19 jun 2007 
                'CreateGraph(strSQL, "PIE", strFileName, "", 2)
                CreateGraph(RowArray, "PIE", strFileName, "", 2)
                ''End of Code addition by SwatiC on 19 jun 2007 
                If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY + strFileName + ".png")) Then
                    m_strImage = "<IMG HEIGHT=" + m_intGraphHeight.ToString + " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strFileName + ".png" + "'>"
                Else
                    m_strImage = "<IMG src='..\..\images\NoPreview.gif'>"
                End If
                'Add to array the ProjectID and the Image File name to be written to client side
                strImageDetails(intArrayCount) = m_strImage
                strProjectIDs(intArrayCount) = CType(drResourceLoading.Item("ProjectID"), String)
                intArrayCount = intArrayCount + 1

            End If

            'append the code for link

            '' START : Commented and Integrated By ParagD On 3-Oct-2006

            'Commented and Modified by SavitaS on 31 July 2006 for Sierra IssueID 2921
            'Modified By Mrugaja on 23rd March,2005
            'Purpose:To display daily booked hours in resource calender
            '  strHTML.Append("<tr class=clsTREven><td width=100%><LI style=" & """list-style-image: url('../images/dc.gif'); cursor: default; list-style-type: disc""" & ">" & _
            '"<A class=clsLeafNormal id='' title='' href=" & """javascript:" & "DisplaySchedule(" & CType(drResourceLoading.Item("ProjectID"), String) & "," & intindex & ",'" & CType(drResourceLoading.Item("ProjectName"), String).Replace(" ", "&nbsp;") & _
            '  "'," & FormatNumber(drResourceLoading.Item("TotalBookedHours"), 2) & "," & FormatNumber(drResourceLoading.Item("Total"), 2) & "," & _
            ''  CType(drResourceLoading.Item("WorkingHours"), String) & "," & CType(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("BookedHoursDaily"), "0"), String) & ")""" & ">" & CType(drResourceLoading.Item("ProjectName"), String) & "</A></LI></td></tr>")

            ''Code Commented and added by SwatiC on 19 jun 2007 
            'To handel Single Quotes

            '       strHTML.Append("<tr class=clsTREven><td width=100%><LI style=" & """list-style-image: url('../images/dc.gif'); cursor: default; list-style-type: disc""" & ">" & _
            '"<A class=clsLeafNormal id='' title='' href=" & """javascript:" & "DisplaySchedule(" & CType(drResourceLoading.Item("ProjectID"), String) & "," & intIndex & ",'" & CType(drResourceLoading.Item("ProjectName"), String).Replace(" ", "&nbsp;") & _
            '  "'," & CType(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("TotalBookedHours"), "0"), String) & "," & CType(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("Total"), "0"), String) & "," & _
            '  CType(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("WorkingHours"), "0"), String) & ")""" & ">" & CType(drResourceLoading.Item("ProjectName"), String) & "</A></LI></td></tr>")

            strHTML.Append("<tr class=clsTREven><td width=100%><LI style=" & """list-style-image: url('../images/dc.gif'); cursor: default; list-style-type: disc""" & ">" & _
     "<A class=clsLeafNormal id='' title='' href=" & """javascript:" & "DisplaySchedule(" & CType(drResourceLoading.Item("ProjectID"), String) & "," & intIndex & ",'" & Replace(CType(drResourceLoading.Item("ProjectName"), String).Replace(" ", "&nbsp;"), "'", "\'") & _
       "'," & CType(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("TotalBookedHours"), "0"), String) & "," & CType(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("Total"), "0"), String) & "," & _
       CType(CommonFunction.Data.CheckIsDBNull(drResourceLoading.Item("WorkingHours"), "0"), String) & ")""" & ">" & CType(drResourceLoading.Item("ProjectName"), String) & "</A></LI></td></tr>")
            '''End of Code addition by SwatiC on 19 jun 2007 
            'End of Commented and Modified by SavitaS on 31 July 2006 for Sierra IssueID 2921

            '' END : Commented and Integrated By ParagD On 3-Oct-2006

            'End Modification

            'If intindex = 0 Then

            'Code Commented and Added by SwatiC on 30 Jun 2007 for Whiz7.0
            'If (m_intRoleLevel = 1 And intIndex = 0) Or (m_intRoleLevel <> 1 And intIndex = 1) Then
            If (m_intRoleLevel = 1 And intIndex = 1) Or (m_intRoleLevel <> 1 And intIndex = 2) Then
                ''End of Code Addition by SwatiC on 30 Jun 2007 for Whiz7.0
                strHTML.Append("<tr><td>&nbsp;&nbsp</td></tr>")
            End If

            '''Code Commented by SwatiC on 19 jun 2007  
            'End If
            '''End of Code Commentation by SwatiC on 19 jun 2007 
        Next

        strHTML.Append("</table></div></td></tr>")
        'if 
        '            RowArray = dsGraphData.Tables(0).Select("ProjectID=-2")
        '        '''End of Code addition by SwatiC on 19 jun 2007 
        '        strFileName = CommonFunction.FileDirectory.GetUniqueFileName()
        '        CreateGraph(RowArray, "PIE", strFileName, "", 2)
        '        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY + strFileName + ".png")) Then
        '            m_strImageForOtherProjects = "<IMG HEIGHT=" + m_intGraphHeight.ToString + " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strFileName + ".png" + "'>"
        '        Else
        '            m_strImageForOtherProjects = "<IMG src='..\..\images\NoPreview.gif'>"
        '        End If
        '        End If
        'Write the link for All Projects and create the graph for the same
        '''Code Commented and added by SwatiC on 19 jun 2007 
        'strSQL = "usp_Sel_ResourceLoadingDailyBreakup " & m_intMonth & "," & m_intYear & "," & m_intResourceID & ",1"
        RowArray = dsGraphData.Tables(0).Select("ProjectID=0")
        '''End of Code addition by SwatiC on 19 jun 2007 
        strFileName = CommonFunction.FileDirectory.GetUniqueFileName()
        CreateGraph(RowArray, "PIE", strFileName, "", 2)
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY + strFileName + ".png")) Then
            m_strImageForAllProject = "<IMG HEIGHT=" + m_intGraphHeight.ToString + " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strFileName + ".png" + "'>"
        Else
            m_strImageForAllProject = "<IMG src='..\..\images\NoPreview.gif'>"
        End If

        'create the graph for other projects
        'strSQL = "usp_Sel_ResourceLoadingDailyBreakup " & m_intMonth & "," & m_intYear & "," & m_intResourceID & ",1"
        If m_intRoleLevel <> 1 Then
            ''Code Commented and added by SwatiC on 19 jun 2007 
            '    strSQL = "usp_Sel_ResourceLoadingDailyBreakup " & m_intMonth & "," & m_intYear & "," & m_intResourceID & ",2," & m_intLoggedInEmpID & _
            '             "," & m_intRoleLevel & ",'" & m_strProjectFilters & "'"

            RowArray = dsGraphData.Tables(0).Select("ProjectID=-1")
            '''End of Code addition by SwatiC on 19 jun 2007 
            strFileName = CommonFunction.FileDirectory.GetUniqueFileName()
            CreateGraph(RowArray, "PIE", strFileName, "", 2)
            If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY + strFileName + ".png")) Then
                m_strImageForOtherProjects = "<IMG HEIGHT=" + m_intGraphHeight.ToString + " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strFileName + ".png" + "'>"
            Else
                m_strImageForOtherProjects = "<IMG src='..\..\images\NoPreview.gif'>"
            End If
        End If

        strHTML.Append("<tr class=clsTRSectionHeader><td id=tdGraphHeading>" & MyBase.GetResourceString("RESOURCEUTILIZATION") & "</td></tr>")

        '''Code Commented and added by SwatiC on 19 jun 2007 
        'CommonFunctions.Data.DisposeDataReader(drResourceLoading)
        dsResourceLoading.Dispose()
        ''''End of Code addition by SwatiC on 19 jun 2007 

        'Write the TD tag which will contain the data for Calendar
        strHTML.Append("<tr><td width=30% id=tdUtilization>" & m_strImage & "</td></tr></table></td>")
        strHTML.Append("<td  height=22 class=clsTDSelected valign=top >&nbsp; </td><td  height=22  id=tdSchedule" & " valign=top></td>")
        strHTML.Append("</tr></table></div>")

        'Write the client side array for ProjectIDs and Image file named generated for the graph 
        'of the respective project
        strHTML.Append("<SCRIPT LANGUAGE=javascript>")
        strHTML.Append(" var arrProjectIDs = new Array(")
        Dim intCount As Integer
        'Added by PrashantD on 24 Oct 2007
        'Purpose: Javascript error occurs if intArrayCount is 1
        If intArrayCount = 1 Then
            strHTML.Append("1); arrProjectIDs[0]=" + strProjectIDs(0) + ";")

        Else

            For intCount = 0 To intArrayCount - 1
                If intCount = intArrayCount - 1 Then
                    strHTML.Append(strProjectIDs(intCount) & ");")
                Else
                    strHTML.Append(strProjectIDs(intCount) & ",")
                End If
            Next
        End If
        strHTML.Append(" var arrImages = new Array(")
        If intArrayCount = 1 Then
            strHTML.Append("1); arrImages[0]=""" + strImageDetails(0) + """;")
        Else
            For intCount = 0 To intArrayCount - 1
                If intCount = intArrayCount - 1 Then
                    strHTML.Append("""" & strImageDetails(intCount) & """" & ");")
                Else
                    strHTML.Append("""" & strImageDetails(intCount) & """" & ",")
                End If
            Next
        End If

        strHTML.Append("</SCRIPT>")

        Response.Write(strHTML)
        '''End of Code commentation and addition by SwatiC on 19 jun 2007 for Performance Issue
    End Sub
    '''Code Commented and added by SwatiC on 19 jun 2007 for Performance Issue
    'Private Sub CreateGraph(ByVal strSQLQueryForGraph As String, ByVal strChartType As String, ByVal strImageFileName As String, ByVal strGraphTitle As String, ByVal intNoOfColumns As Integer)
    Private Sub CreateGraph(ByVal RowArray() As DataRow, ByVal strChartType As String, ByVal strImageFileName As String, ByVal strGraphTitle As String, ByVal intNoOfColumns As Integer)
        '''End of Code addition by SwatiC on 19 jun 2007 for Performance Issue
        '=====================================================================
        ' Procedure Name        : CreateGraph()
        ' Purpose               : To create the graph control
        ' Description           : Same as above
        ' Parameters Passed     : Graph Type ID
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : DipaliS
        ' Created               : May 21,2004
        ' Revisions             : 
        '=====================================================================

        Dim objGraph As Graph.Graph
        Dim blnShowLegends As Boolean = False
        Dim blnShowExplodedPie As Boolean = True
        Dim strItemName As String = ""
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath, strPalleteStyle As String

        Dim intCount As Integer


        '-- Setting some main Graph Properties

        '-- Build Array for specifying the Chart Type for each column
        ReDim arrstrChartType(intNoOfColumns - 1)

        For intCount = 0 To intNoOfColumns - 1
            arrstrChartType(intCount) = strChartType
        Next

        blnShowLegends = True

        '''Code added by SwatiC on 19 Jun 2007 For Performance Issue
        Dim Column As DataColumn
        Dim Table As DataTable = New DataTable("GraphTable")
        Dim dataSet As DataSet = New DataSet("Graph")
        Dim Row As DataRow
        Dim tempRow As DataRow


        Column = New DataColumn
        Column.ColumnName = "Type"
        Column.DataType = System.Type.GetType("System.String")
        Table.Columns.Add(Column)

        Column = New DataColumn
        Column.ColumnName = "Hours"
        Column.DataType = System.Type.GetType("System.Double")
        Table.Columns.Add(Column)

        For Each Row In RowArray
            tempRow = Table.NewRow()
            tempRow("Type") = Row("Type")
            tempRow("Hours") = Row("Hours")
            Table.Rows.Add(tempRow)
        Next

        dataSet.Tables.Add(Table)
        '''End of Code addition by SwatiC on 19 Jun 2007 For Performance Issue

        ' create the graph for the item values
        objGraph = New Graph.Graph
        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString
            .VirtualImagePath = ""
            .Enable3D = blnEnable3D
            .ChartType = arrstrChartType 'GetChartType(ItemID, SQL, m_intGraphID, m_blnUseSQL)
            .ShowExplodedPie = blnShowExplodedPie
            .BorderStyle = "FrameTitle5"
            .GraphTitle = strGraphTitle
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            .GraphTitleColor = "white"
            .Width = m_intGraphWidth
            .Height = m_intGraphHeight
            .ShowExplodedPie = False
            .ChartBackColor = "PaleGoldenRod"
            strPalleteStyle = "EARTHTONES"
            .ChartAreaColor = "GoldenRod"
            .PalleteStyle = strPalleteStyle

            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
            .LegendCaptionColor = "black"
            .BorderColor = "Blue"
            .ShowLegends = blnShowLegends
            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            '''Code Commented and added by SwatiC on 19 Jun 2007 For Performance Issue
            '.SQL = strSQLQueryForGraph
            .DataSet = dataSet
            '''End of Code addition by SwatiC on 19 Jun 2007 For Performance Issue
            ' return the graph control
            .GenerateImage()
        End With
        objGraph = Nothing
        dataSet.Dispose()
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
        Response.Write("""" & MyBase.GetResourceString("SUN") & """" & "," & vbCrLf)
        Response.Write("""" & MyBase.GetResourceString("MON") & """" & "," & vbCrLf)
        Response.Write("""" & MyBase.GetResourceString("TUE") & """" & "," & vbCrLf)
        Response.Write("""" & MyBase.GetResourceString("WED") & """" & "," & vbCrLf)
        Response.Write("""" & MyBase.GetResourceString("THU") & """" & "," & vbCrLf)
        Response.Write("""" & MyBase.GetResourceString("FRI") & """" & "," & vbCrLf)
        Response.Write("""" & MyBase.GetResourceString("SAT") & """" & ")" & vbCrLf)
        Response.Write("</Script>")
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
                strMonthName = (MyBase.GetResourceString("JAN"))
            Case 2
                strMonthName = (MyBase.GetResourceString("FEB"))
            Case 3
                strMonthName = (MyBase.GetResourceString("MARCH"))
            Case 4
                strMonthName = (MyBase.GetResourceString("APRIL"))
            Case 5
                strMonthName = (MyBase.GetResourceString("MAY"))
            Case 6
                strMonthName = (MyBase.GetResourceString("JUNE"))
            Case 7
                strMonthName = (MyBase.GetResourceString("JULY"))
            Case 8
                strMonthName = (MyBase.GetResourceString("AUGUST"))
            Case 9
                strMonthName = (MyBase.GetResourceString("SEPTEMBER"))
            Case 10
                strMonthName = (MyBase.GetResourceString("OCTOBER"))
            Case 11
                strMonthName = (MyBase.GetResourceString("NOVEMBER"))
            Case 12
                strMonthName = (MyBase.GetResourceString("DECEMBER"))
        End Select
        MyBase.InitializeResources("AppResources.PM_ResourceLoadingDailyBreakUp", "AppResources")
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
        'Code Commented and added by SwatiC on 22 Jun 2007 -- For Financial Year Consideration
        'Return GetMonthName(m_intMonth - 1)
        If m_intMonth = 1 Then
            Return GetMonthName(12)
        Else
            Return GetMonthName(m_intMonth - 1)
        End If
        'End of addition by SwatiC on 22 Jun 2007
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
        'Code Commented and added by SwatiC on 22 Jun 2007 -- For Financial Year Consideration
        'Return GetMonthName(m_intMonth + 1)
        If m_intMonth = 12 Then
            Return GetMonthName(1)
        Else
            Return GetMonthName(m_intMonth + 1)
        End If
        'End of addition by SwatiC on 22 Jun 2007
    End Function
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class
