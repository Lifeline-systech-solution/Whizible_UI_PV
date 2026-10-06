#Region "Imports"
Imports System.Text
#End Region
'=====================================================================
' Module Name       :   PM_ResourceHistory

' Purpose           :   Provides the UI for yearly Resource Loading

' Description       :   Same as Above

' Dependencies      :   Resource File PM_ResourceHistory.resx

' Author            :   DipaliS

' Created           :   May 20, 2004

' Revisions         :
'=====================================================================
Public Class PM_ResourceHistory
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.

        ' ''commented by nilesh g on 31/12/2015 for Security
        'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '    Response.Write(vbCrLf + "<script>")
        '    Response.Write(vbCrLf + "		if (window.opener == null)")
        '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '    If strRedirectToPage.Trim = "" Then
        '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '    Else
        '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        '    End If
        '    Response.Write(vbCrLf + "</script>")
        'End If
        ' ''end of commented by nilesh g on 31/12/2015 for Security
        InitializeComponent()
    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_ResourceHistory", "AppResources")
    End Sub
#End Region

#Region "Member Variables"
    Protected m_intStartMonth As Integer
    Protected m_intYear As Integer
    Protected m_intResourceID As Integer
    Private m_strHours As String
    'Code Commented and added by SwatiC on 19 Jun 2007 for Performance Issue
    'Private drMonthlyLoading As IDataReader
    Private dsMonthlyLoading As DataSet
    Private drMonthlyLoading As DataRow
    'End of Code addition by SwatiC on 19 Jun 2007 for Performance Issue
    Private m_intTotalBugdetedHours As Integer
    Private m_intTotalHours As Double
    Private m_intNoOfRows As Integer = 0
    Private m_strImage As String
    Private WithEvents m_objGrid As WebPages.Template.AdvancedGrid
    'Code Added 29 May
    Private m_intLoggedInEmpID As Integer
    Private m_strOthersProjectName As String
    Private m_strOthersBookedHours As String
    Private m_strOthersHours(12) As String
    Private m_intRoleLevel As Integer
    Private m_strProjectFilters As String
    'End Of Addition
    ''Code added by SwatiC on 3 July 2007 for Whiz7.0
    Private m_strOpenProjectName As String
    Private m_strOpenBookedHours As String
    Private m_strOpenHours(12) As String
    ''End of Code addition by SwatiC on 3 July 2007 for Whiz7.0
#End Region

#Region "Constants"
    Public Const GRAPH_DIRECTORY As String = "../../images/DB_GRAPHS/"
    Private Const m_intGraphWidth As Integer = 400
    Private Const m_intGraphHeight As Integer = 250
#End Region

#Region "Procedures"
    Public Sub PageInit()

        '######### Page Code starts here

        Dim m_intProjectEmplyeeRoleID As Integer

        'Get the Logged in Employee's ID
        m_intLoggedInEmpID = CType(CommonFunctions.General.CheckIsNothing(Session("intUserID")), Integer)

        'Get the Level of the Logged In Employee
        m_intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel")), Integer)

        'Get the ProjectEmployeeRoleID if called from Projects Tab
        If Not IsNothing(Request.QueryString("ProjectEmployeeRoleID")) Then
            m_intProjectEmplyeeRoleID = CType(Request.QueryString("ProjectEmployeeRoleID"), Integer)
            'Added by PrashantD on 8 May 2007 for CleanUp Activity
        ElseIf Not IsNothing(Request.Form("ProjectEmployeeRoleID")) Then
            m_intProjectEmplyeeRoleID = CType(Request.Form("ProjectEmployeeRoleID"), Integer)
            'End of addition by PrashantD on 8 May 2007
        Else
            m_intProjectEmplyeeRoleID = 0
        End If
        'Added by PrashantD on 8 May 2007 for CleanUp Activity
        ' Added by NitinVS on 13 July 2007 for WhizibleSEM 7 When called from Assign Task page crash occurs
        If m_intProjectEmplyeeRoleID = 0 Then
            m_intResourceID = CType(Request.QueryString("EmployeeID"), Integer)

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''m_intProjectEmplyeeRoleID = CType(CommonFunction.Data.GetDataScalar("SELECT ProjectEmployeeRoleID FROM Tbl_PM_ProjectEmployeeRole WHERE EmployeeID =" + m_intResourceID.ToString() + " AND ProjectID = " + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectId"), "0"), String), MyBase.UseSQL), Integer)
            m_intProjectEmplyeeRoleID = CType(CommonFunction.Data.GetDataScalar("usp_sel_Tbl_PM_ProjectEmployeeRole_ProjectEmployeeRoleID " + m_intResourceID.ToString() + "," + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectId"), "0"), String), MyBase.UseSQL), Integer)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        End If
        'End Addition By NitinVS on 13 July 2007 for WhizibleSEM 7 
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=ProjectEmployeeRoleID value=" + m_intProjectEmplyeeRoleID.ToString + ">")
        'End of addition by PrashantD on 8 May 2007

        'Following block of code is being moved here. by PrashantD on 9 May 2007
        'Modified and Added by PrashantD on 9 May 2007 for CleanUp Activity
        Dim strQuery As String = ""
        Dim strEmployeeName As String = ""
        Dim strUserName As String = ""
        Dim strRoleDescription As String = ""
        'End of addition by PrashantD on 9 May 2007 for CleanUp Activity

        'Get the Start Month of financial year

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "SELECT Month(FinancialYearStart) as StartMonth from tbl_PM_companyInformation WITH (NOLOCk)"
        strQuery = "usp_sel_tbl_PM_companyInformation_StartMonth"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_intStartMonth = CType(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), Integer)

        If IsNothing(m_intStartMonth) Then
            m_intStartMonth = 1
        End If

        'Get the employeename
        ' Commented and Added By MahendraV On 10:22 AM 8/21/2007 For WhizibleSEM 7.0
        ' At Resource level in Resource Allocation ,To show page caption 
        ' Start_MV_8/21/2007

        ' strQuery = "usp_Sel_tbl_PM_Employee_ProjectEmployeeRoleID " & m_intProjectEmplyeeRoleID.ToString

        If m_intProjectEmplyeeRoleID = 0 Then
            strQuery = "usp_Sel_tbl_PM_Employee_ProjectEmployeeInfo " & m_intResourceID.ToString
        Else
            strQuery = "usp_Sel_tbl_PM_Employee_ProjectEmployeeRoleID " & m_intProjectEmplyeeRoleID.ToString
        End If
        ' End_MV_8/21/2007

        Dim dr As IDataReader
        'strEmployeeName = CType(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), String)
        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If dr.Read() Then
            strEmployeeName = dr("EmployeeName").ToString
            strUserName = dr("UserName").ToString
            strRoleDescription = dr("RoleDescription").ToString
            m_intResourceID = CType(dr("EmployeeID"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(dr)
        'End of moved from PrashantD on 9 May 2007

        'commented by PrashantD on 9 May 2007
        'Get the EmployeeId from the ProjectEmployeeRoleID
        'If m_intProjectEmplyeeRoleID <> 0 Then
        '    Dim strSQLEmpId As String
        '    strSQLEmpId = "Select EmployeeId from tbl_pm_projectemployeerole where projectemployeeroleid=" & m_intProjectEmplyeeRoleID
        '    m_intResourceID = CType(CommonFunctions.Data.GetDataScalar(strSQLEmpId, MyBase.UseSQL), Integer)
        'Else
        '    m_intResourceID = CType(Request.QueryString("EmployeeID"), Integer)
        'End If
        'End of comment by PrashantD on 9 May 2007

        'Get the Year
        m_intYear = CType(Request.QueryString("Year"), Integer)

        If m_intYear = 0 Then
            'Modified By MrugajaB on 22 March 2005
            'Purpose: When Resource Loading Page gets loaded for the first time, 
            'it was showing data for next financial year and not current financial year
            'So change is made so that if current month is Jan ,Feb Or march and year is say 2005 
            'then data will be shown for 2004-2005 and if month is between April and december 
            'then data will be shown for 2005-2006


            'm_intYear = DateTime.Now.Year

            If DateTime.Now.Month >= 1 And DateTime.Now.Month <= 3 Then
                m_intYear = DateTime.Now.Year - 1
            Else
                m_intYear = DateTime.Now.Year
            End If
            'End Modification

        End If

        'Get the String 'hrs' from resource file
        m_strHours = " " & MyBase.GetResourceString("HOURS")


        'If middle level then apply filter for Projects
        If m_intRoleLevel = 2 Then
            'Apply Role Access Filter for Project List
            m_strProjectFilters = ""
            Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            If strFilter <> "" Then
                m_strProjectFilters += strFilter
            End If

            'Code Commented By DipaliS  15 July 2004 and added the following
            'm_strProjectFilters = m_strProjectFilters.Replace("ProjectID IN ", "")
            Dim strRemove As String = "ProjectID IN"
            m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
            'End Addition
            m_strProjectFilters = m_strProjectFilters.Replace("'", "")
        End If

        GetMenu()

        Response.Write("<BR>")



        Dim strPageCaption As String

        'Get the Page Caption depending upon the Financial Year Start
        If m_intStartMonth = 1 Then
            strPageCaption = MyBase.GetResourceString("PAGE_CAPTIONFORYAR")
            'Commented By DipaliS 9 June 2004 and added following
            'strPageCaption = strPageCaption.Replace("<start>", m_intYear.ToString) & strEmployeeName
            strPageCaption = strPageCaption.Replace("<start>", m_intYear.ToString)
        Else
            strPageCaption = MyBase.GetResourceString("PAGE_CAPTIONFORRANGE")
            'Commented By DipaliS 9 June 2004 and added following
            'strPageCaption = strPageCaption.Replace("<start>", m_intYear.ToString).Replace("<end>", (m_intYear + 1).ToString) & strEmployeeName
            strPageCaption = strPageCaption.Replace("<start>", m_intYear.ToString).Replace("<end>", (m_intYear + 1).ToString)
        End If

        'Code Added 9 June 2004
        Dim strResource As String
        strResource = MyBase.GetResourceString("RESOURCE") + " : " + strUserName + " - " + strEmployeeName + "[" + strRoleDescription + "]"
        'end of addition

        'Commented By DipaliS 9 June 2004 and added following
        'WebPages.Template.PageCaption.GetPageCaptions(Nothing, strPageCaption)
        WebPages.Template.PageCaption.GetPageCaptions(Nothing, strPageCaption, strResource)

        GetResourceUtilizationGraph()

        Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")

        GetResourceUtilization()
        'Code added by SwatiC on 3 July 2007 for Whiz7.0
        GetOpenDetails()
        'End of Code addition by SwatiC on 3 July 2007 for Whiz7.0

        'Code Added 29 May 2004
        'Get the Data for Others Category of Projects only if Level is 2 or 3
        If m_intRoleLevel <> 1 Then
            GetOthersDetails()
        End If

        'End of Addtion

        GetMonthlyLoading()

        GetJobLoading()

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
    ' Created               :       May 20, 2004
    ' Revisions :
    '=====================================================================
    Private Sub GetMenu()
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PREYEAR"), MyBase.GetResourceString("MENU_NEXTYEAR"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuClientFun() As String = {"Previous_OnClick()", "Next_OnClick()", "Close_OnClick()", "Help_OnClick(1616)"}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PREYEAR_TOOLTIP"), MyBase.GetResourceString("MENU_NEXTYEAR_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim objMenu As WebPages.Template.StaticMenu
        objMenu = New WebPages.Template.StaticMenu
        objMenu.DrawMenu(arrMenu, arrMenuClientFun, arrMenuToolTip, False)
        objMenu = Nothing
    End Sub
    '====================================================================
    ' Procedure Name        :       GetResourceUtilization
    ' Parameters Passed     :       None
    ' Returns               :       None
    ' Parameters Affected   :       None
    ' Purpose               :       Displays the Data for Resource utilization
    ' Description           :       Same as above
    ' Assumptions           :       None
    ' Dependencies          :       None
    ' Author                :       DipaliS
    ' Created               :       May 20, 2004
    ' Revisions :
    '=====================================================================
    Private Sub GetResourceUtilization()

        Response.Write("<BR>")

        'Dim drResourceLoading As IDataReader
        Dim strSQL As String = "usp_Sel_ResourceLoading " & m_intYear & "," & m_intResourceID & ",1"
        'drResourceLoading = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        Dim strHTML As StringBuilder
        strHTML = New StringBuilder

        Dim intTotal As Double

        strHTML.Append("<TABLE class=clsTable cellpadding=0 cellspacing=0><TR><TD width=70%>")

        ''Draw the Section Header
        Dim objSectionTitle As New WebPages.Template.SectionTitle

        Dim strSectionTitle As String = MyBase.GetResourceString("RES_UTILIZATION")
        Dim strSectionTag As String = "divResUtilization"
        'Dim strFunctionName As String = "ShowHide_divResUtilization"

        With objSectionTitle
            Response.Write(.GetSectionTitle(strSectionTitle, strSectionTag, ""))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        objSectionTitle = Nothing
        Dim strGrid As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        m_objGrid = New WebPages.Template.AdvancedGrid

        Dim arrActualColumnArray() As String = {"Type", _
                                                "Hours"}

        Dim arrUserFriendlyArray() As String = {"", ""}

        m_objGrid.ActualColumnArray = arrActualColumnArray
        m_objGrid.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGrid.UseSQL = MyBase.UseSQL
        m_objGrid.SQL = strSQL
        m_objGrid.NoOfDataColumns = 2
        m_objGrid.DIVStyle = "'overflow:auto;height=100%;width:50%;'"
        m_objGrid.returnHTML = True
        'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        m_objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strGrid = m_objGrid.DrawGrid()
        m_objGrid = Nothing

        strHTML.Append("<DIV Id=" + strSectionTag + " overflow:auto;width:50%>")
        strHTML.Append(strGrid)
        strHTML.Append("</DIV>")
        strHTML.Append("</TD>")
        strHTML.Append("<TD width=80%>" & m_strImage & "</TD></TR></TABLE><BR>")
        Response.Write(strHTML)

        'If level is 2 then apply filter for projects
        If m_intRoleLevel <> 2 Then
            strSQL = "usp_Sel_ResourceLoading " & m_intYear.ToString & "," & m_intResourceID.ToString & ",0," & _
                                            m_intLoggedInEmpID.ToString & "," & m_intRoleLevel
        Else
            strSQL = "usp_Sel_ResourceLoading " & m_intYear.ToString & "," & m_intResourceID.ToString & ",0," & _
                                            m_intLoggedInEmpID.ToString & "," & m_intRoleLevel & ",'" & m_strProjectFilters & "'"
        End If

        ''''Code commented and added by SwatiC on 18 Jun 2007 for Performance Issue
        'Dim drForCount As IDataReader

        'Get the Number of rows
        'drForCount = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        'While drForCount.Read
        '    m_intNoOfRows = m_intNoOfRows + 1
        'End While
        'CommonFunctions.Data.DisposeDataReader(drForCount)

        'drMonthlyLoading = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        dsMonthlyLoading = CommonFunctions.Data.GetDataSet(strSQL, "MonthlyLoading", , , MyBase.UseSQL)
        m_intNoOfRows = dsMonthlyLoading.Tables(0).Rows.Count

        'CommonFunctions.Data.DisposeDataReader(drResourceLoading)
        '''''End of Code commentation and addition by SwatiC on 18 jun 2007
    End Sub
    '====================================================================
    ' Procedure Name        :       GetResourceUtilizationGraph
    ' Parameters Passed     :       None
    ' Returns               :       None
    ' Parameters Affected   :       None
    ' Purpose               :       Gets the Graph for Resource utilization
    ' Description           :       Same as above
    ' Assumptions           :       None
    ' Dependencies          :       None
    ' Author                :       DipaliS
    ' Created               :       May 20, 2004
    ' Revisions :
    '=====================================================================
    Private Sub GetResourceUtilizationGraph()
        Dim strForGraph As String = "usp_Sel_ResourceLoading " & m_intYear & "," & m_intResourceID & ",1"
        Dim strFileName As String
        strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
        CreateGraph(strForGraph, "PIE", strFileName, "", 2)
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY + strFileName + ".png")) Then
            m_strImage = "<IMG HEIGHT=" + m_intGraphHeight.ToString + " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strFileName + ".png" & "'>"
        Else
            m_strImage = "<IMG src='..\..\images\NoPreview.gif'>"
        End If
    End Sub

    Private Sub GetOpenDetails()
        '====================================================================
        ' Procedure Name        :      GetOpenDetails
        ' Parameters Passed     :      None
        ' Returns               :      None 
        ' Parameters Affected   :      None 
        ' Purpose               :      To get the Details of Other Projects 
        ' Description           :      Same as above
        ' Assumptions           :      None
        ' Dependencies          :      None
        ' Author                :      DipaliS
        ' Created               :      May 29, 2004
        ' Revisions             :      
        '=====================================================================
        Dim intCount As Integer
        Dim intIndex As Integer
        Dim intArrayCount As Integer = 0

        'Private m_strOpenProjectName As String
        'Private m_strOpenBookedHours As String
        'Private m_strOpenHours(12) As String

        ''''Code commented and added by SwatiC on 18 Jun 2007 for Performance Issue
        'If drMonthlyLoading.Read Then
        drMonthlyLoading = Nothing
        drMonthlyLoading = dsMonthlyLoading.Tables(0).Rows(0)
        If Not (drMonthlyLoading Is Nothing) Then
            '''''End of Code addition by SwatiC on 18 Jun 2007 for Performance Issue
            'Booked Hours
            m_strOpenProjectName = CType(drMonthlyLoading.Item("ProjectName"), String)
            m_strOpenBookedHours = FormatNumber(drMonthlyLoading("TotalBookedHours"), 2)

            intCount = 12
            intIndex = m_intStartMonth + 2

            'Show the Monthly loading
            Do While intCount > 0
                m_strOpenHours(intArrayCount) = FormatNumber(drMonthlyLoading.Item(intIndex), 2)
                intIndex = intIndex + 1
                If intIndex = 15 Then
                    intIndex = 3
                End If
                intCount = intCount - 1
                intArrayCount = intArrayCount + 1
            Loop
        End If
    End Sub
    'Code Added 29 May 2004
    '====================================================================
    ' Procedure Name        :      GetOthersDetails
    ' Parameters Passed     :      None
    ' Returns               :      None 
    ' Parameters Affected   :      None 
    ' Purpose               :      To get the Details of Other Projects 
    ' Description           :      Same as above
    ' Assumptions           :      None
    ' Dependencies          :      None
    ' Author                :      DipaliS
    ' Created               :      May 29, 2004
    ' Revisions             :      
    '=====================================================================
    Private Sub GetOthersDetails()
        Dim intCount As Integer
        Dim intIndex As Integer
        Dim intArrayCount As Integer = 0

        ''''Code commented and added by SwatiC on 18 Jun 2007 for Performance Issue
        'If drMonthlyLoading.Read Then
        drMonthlyLoading = Nothing
        drMonthlyLoading = dsMonthlyLoading.Tables(0).Rows(1)
        If Not (drMonthlyLoading Is Nothing) Then
            '''''End of Code addition by SwatiC on 18 Jun 2007 for Performance Issue
            'Booked Hours
            m_strOthersProjectName = CType(drMonthlyLoading.Item("ProjectName"), String)
            m_strOthersBookedHours = FormatNumber(drMonthlyLoading("TotalBookedHours"), 2)

            intCount = 12
            intIndex = m_intStartMonth + 2

            'Show the Monthly loading
            Do While intCount > 0
                m_strOthersHours(intArrayCount) = FormatNumber(drMonthlyLoading.Item(intIndex), 2)
                intIndex = intIndex + 1
                If intIndex = 15 Then
                    intIndex = 3
                End If
                intCount = intCount - 1
                intArrayCount = intArrayCount + 1
            Loop
        End If
    End Sub
    'end of Addition
    '====================================================================
    ' Procedure Name        :       GetMonthlyLoading
    ' Parameters Passed     :       None
    ' Returns               :       None
    ' Parameters Affected   :       None
    ' Purpose               :       Displays the Data for Monthly Resource utilization
    ' Description           :       Same as above
    ' Assumptions           :       None
    ' Dependencies          :       None
    ' Author                :       DipaliS
    ' Created               :       May 20, 2004
    ' Revisions :
    '=====================================================================
    Private Sub GetMonthlyLoading()
        'Code Commented By DipaliS for Adding Others Category 
        'Dim strSQL As String = "usp_Sel_ResourceLoading " & m_intYear.ToString & "," & m_intResourceID.ToString

        'Removed the code before this for Others Category of Projects

        Dim strHTML As StringBuilder
        strHTML = New StringBuilder

        strHTML.Append("<div id=divList style=" & """overflow:auto;Height:100%""" & ">")
        strHTML.Append("<table class=clsGridTable  cellspacing=1 cellpadding=0 width=99.9%><tr class=clsTRSectionHeader>")
        strHTML.Append("<td width=65% align=left>" & MyBase.GetResourceString("MONTHLYLOADING") & " (Financial Year)</td></tr></table>")

        '''''Code commented and added by SwatiC on 18 Jun 2007 for Performance Issue
        'To remove Booked hrs Column
        'strHTML.Append("<table width=99.9% border=0 cellspacing=0 cellpadding=0 ><tr class=clsTRColumnHeader><td  align=left>" & MyBase.GetResourceString("BOOKEDHOURS") & "</td>")
        strHTML.Append("<table width=99.9% border=0 cellspacing=1 cellpadding=0 ><tr class=clsTRColumnHeader><td  align=left>&nbsp;</td>")
        '''End of Code addition by SwatiC on 18 Jun 2007 for Performance Issue

        Dim intCount As Integer = 12
        Dim intIndex As Integer = m_intStartMonth

        'Write the Month Names like Jan,Feb etc
        Do While intCount > 0
            strHTML.Append("<td align=left>" & GetMonthName(intIndex) & "</td>")
            intIndex = intIndex + 1
            If intIndex = 13 Then
                intIndex = 1
            End If
            intCount = intCount - 1
        Loop

        strHTML.Append("</tr>")
        strHTML.Append("<tr>")

        intCount = 12
        intIndex = m_intStartMonth + 2

        'Dispaly the Booked Hours
        ''''Code commented and added by SwatiC on 18 Jun 2007 for Performance Issue
        'If drMonthlyLoading.Read Then
        drMonthlyLoading = Nothing
        If CType(dsMonthlyLoading.Tables(0).Rows(1).Item("ProjectID"), Integer) = -1 Then
            drMonthlyLoading = dsMonthlyLoading.Tables(0).Rows(2)
        Else
            drMonthlyLoading = dsMonthlyLoading.Tables(0).Rows(1)
        End If

        If Not (drMonthlyLoading Is Nothing) Then
            ''''End of Code addition by SwatiC on 18 Jun 2007 for Performance Issue
            If Not IsDBNull(drMonthlyLoading.Item(0)) Then
                '''''Code commented and added by SwatiC on 18 Jun 2007 for Performance Issue
                'strHTML.Append("<td class=clsTDEven align=left>" & FormatNumber(drMonthlyLoading.Item(2), 2) & "</td>")
                strHTML.Append("<td class=clsTDEven align=left>&nbsp;</td>")
                ''''Code addition  by SwatiC on 18 Jun 2007 for Performance Issue
                m_intTotalBugdetedHours = CType(CommonFunctions.General.CheckIsNothing(drMonthlyLoading.Item(2)), Integer)
                m_intTotalHours = 0

                Do While intCount > 0
                    'If greater than zero, then show the hypelink
                    If CDbl(drMonthlyLoading.Item(intIndex)) <= 0 Then
                        strHTML.Append("<td class=clsTDEven align=left>" & FormatNumber(CommonFunctions.General.CheckIsNothing(drMonthlyLoading.Item(intIndex)), 2) & "</td>")
                    Else
                        'Code commented and added by Swati C on 21 Jun 2007 to add m_intYear and m_intStartMonth two parameters
                        strHTML.Append("<td class=clsTDEven align=left>" & _
                        "<a href='javascript:LoadDetails(" & intIndex - 2 & "," & m_intYear.ToString & "," & m_intStartMonth.ToString & ")'>" & FormatNumber(CommonFunctions.General.CheckIsNothing(drMonthlyLoading.Item(intIndex)), 2) & "</a></td>")
                        '"<a href='javascript:LoadDetails(" & intIndex - 2")'>" & FormatNumber(CommonFunctions.General.CheckIsNothing(drMonthlyLoading.Item(intIndex)), 2) & "</a></td>")
                        'End of code addition by SwatiC on 22 jun 2007
                    End If

                    If Not IsDBNull(drMonthlyLoading.Item(intIndex)) Then
                        m_intTotalHours = m_intTotalHours + CDbl(CommonFunctions.General.CheckIsNothing(drMonthlyLoading.Item(intIndex)))
                    End If

                    intIndex = intIndex + 1
                    If intIndex = 15 Then
                        intIndex = 3
                    End If
                    intCount = intCount - 1
                Loop

                strHTML.Append("</tr>")
                strHTML.Append("<tr><td class=clsTDEven align=left><b>" & MyBase.GetResourceString("RESOURCEUTILPER") & "</b></td>")

                intCount = 12
                intIndex = m_intStartMonth + 2 + 12

                'Display the Resource utilization %
                Do While intCount > 0
                    strHTML.Append("<td class=clsTDEven align=left>" & _
                    CType(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drMonthlyLoading.Item(intIndex), "0.00"), 2), String) & "</td>")
                    intIndex = intIndex + 1
                    If intIndex = 27 Then
                        intIndex = 15
                    End If
                    intCount = intCount - 1
                Loop

                strHTML.Append("</tr><tr></table><br>")

                Response.Write(strHTML)
            End If
        End If

    End Sub
    '====================================================================
    ' Procedure Name        :       GetJobLoading
    ' Parameters Passed     :       None
    ' Returns               :       None
    ' Parameters Affected   :       None
    ' Purpose               :       Displays the Data for Job Loading
    ' Description           :       Same as above
    ' Assumptions           :       None
    ' Dependencies          :       None
    ' Author                :       DipaliS
    ' Created               :       May 20, 2004
    ' Revisions :
    '=====================================================================
    Private Sub GetJobLoading()
        Dim strHTML As New System.Text.StringBuilder

        strHTML.Append("<table CellSpacing=1 Border=0 width=99.9%><tr class=clsTRSectionHeader ><td width=65% align=left><B>" & MyBase.GetResourceString("JOBLOADING") & "</b></td></tr></table>")
        strHTML.Append("<table cellSpacing=1 cellPadding=0 width=99.9% border=0><tbody><tr class=clsTRColumnHeader ><td align=left>" & MyBase.GetResourceString("PROJECTNAME") & "</td>") '<td align=left>" & MyBase.GetResourceString("BOOKEDHOURS") & "</td>")

        Dim intCount As Integer
        Dim intIndex As Integer

        intCount = 12
        intIndex = m_intStartMonth

        'Show the Month Names
        Do While intCount > 0
            strHTML.Append("<td align=left>" & GetMonthName(intIndex) & "</td>")

            intIndex = intIndex + 1
            If intIndex = 13 Then
                intIndex = 1
            End If
            intCount = intCount - 1
        Loop

        strHTML.Append("</tr>")

        Dim intTotalCount As Integer
        intTotalCount = m_intNoOfRows

        '''''Code commented and added  by SwatiC on 18 Jun 2007 for Performance Issue
        Dim intCnt As Integer
        intCount = 0
        'While drMonthlyLoading.Read
        Dim intTempProjectID As Integer
        While intCnt < m_intNoOfRows
            'drMonthlyLoading = dsMonthlyLoading.Tables(0).Rows(intCnt + 1)
            ' Dim intTempProjectID As Integer
            intTempProjectID = CType(dsMonthlyLoading.Tables(0).Rows(intCnt).Item("ProjectID"), Integer)
            ' Commented and Modified By MahendraV on 11:37 AM 8/21/2007 For WhizibleSEM 7.0
            ' For Performance Issue
            ' Start_MV_8/21/2007


            'While intTempProjectID <= 0
            '    'Modified By SwatiC on 11:23 AM 8/20/2007 For WhizibleSEM 7.0
            '    If m_intNoOfRows - 1 > intCnt Then
            '        ' End of Modification By SwatiC
            '        intCnt = intCnt + 1
            '        intTempProjectID = CType(dsMonthlyLoading.Tables(0).Rows(intCnt).Item("ProjectID"), Integer)
            '        'Modified By SwatiC on 11:23 AM 8/20/2007 For WhizibleSEM 7.0
            '    Else
            '        Exit While
            '    End If
            '    ' End of Modification By SwatiC
            'End While


            If Not (intTempProjectID <= 0) Then
                drMonthlyLoading = dsMonthlyLoading.Tables(0).Rows(intCnt)
                intCnt = intCnt + 1
                '''''End of Code addition by SwatiC on 18 Jun 2007 for Performance Issue
                'Booked Hours
                strHTML.Append("<tr><td class=clsTDEven align=left>" & CType(drMonthlyLoading.Item("ProjectName"), String) & "</td>")
                '& _"<td class=clsTDEven align=left>" & FormatNumber(drMonthlyLoading("TotalBookedHours"), 2) & "</td>")
                intCount = 12
                intIndex = m_intStartMonth + 2

                'Show the Monthly loading
                Do While intCount > 0
                    strHTML.Append("<td class=clsTDEven align=left>" & FormatNumber(drMonthlyLoading.Item(intIndex), 2) & "</td>")
                    intIndex = intIndex + 1
                    If intIndex = 15 Then
                        intIndex = 3
                    End If
                    intCount = intCount - 1
                Loop
                strHTML.Append("</tr>")

                ' Else
                'Exit While
            End If
            intCnt = intCnt + 1
        End While
        ' End_MV_8/21/2007
        Dim intCountArr As Integer = 0

        ''Code added by SwatiC on 3 July 2007 for Whiz7.0
        'Append Open Details
        strHTML.Append("<tr><td class=clsTDEven align=left>" & m_strOpenProjectName & "</td>")
        '& _"<td class=clsTDEven align=left>" & m_strOthersBookedHours & "</td>")
        'Show the Monthly loading
        Do While intCountArr < 12
            strHTML.Append("<td class=clsTDEven align=left>" & m_strOpenHours(intCountArr) & "</td>")
            intCountArr = intCountArr + 1
        Loop

        strHTML.Append("</tr>")
        'End of Code added by SwatiC on 3 July 2007 for Whiz7.0

        'Code Added By DipaliS 29 May 2004
        If m_intRoleLevel <> 1 Then
            'Append Others Details
            strHTML.Append("<tr><td class=clsTDEven align=left>" & m_strOthersProjectName & "</td>")
            '& _"<td class=clsTDEven align=left>" & m_strOthersBookedHours & "</td>")

            'Dim intCountArr As Integer = 0
            intCountArr = 0
            'Show the Monthly loading
            Do While intCountArr < 12
                strHTML.Append("<td class=clsTDEven align=left>" & m_strOthersHours(intCountArr) & "</td>")
                intCountArr = intCountArr + 1
            Loop

            strHTML.Append("</tr>")
            'End Addition
        End If

        'Note
        strHTML.Append("</tbody></table><BR>")
        ''''Code commented by SwatiC on 18 Jun 2007 for Performance Issue
        'To remove Booked Hours Footer Note
        'strHTML.Append("<table cellSpacing=0 cellPadding=0 width=99.9% border=0><tbody><tr class=clsTREven><td>")
        'strHTML.Append(MyBase.GetResourceString("FOOTERNOTE")).Replace("<bookhours>", FormatNumber(m_intTotalBugdetedHours, 2)).Replace("<plannedhours>", m_intTotalHours.ToString)
        'strHTML.Append("</tr></tbody></table>")
        '''''End of Code commentation by SwatiC on 18 Jun 2007 for Performance Issue
        strHTML.Append("</div>")
        Response.Write(strHTML)

        ''''Code commented and added by SwatiC on 18 Jun 2007 for Performance Issue
        'CommonFunctions.Data.DisposeDataReader(drMonthlyLoading)
        dsMonthlyLoading.Dispose()
        '''''End of Code addition by SwatiC on 18 Jun 2007 for Performance Issue
    End Sub
    '=====================================================================
    ' Procedure Name        : CreateGraph()
    ' Purpose               : To create the graph control
    ' Description           : Same as above
    ' Parameters Passed     : Graph Type ID
    ' Returns               : 
    ' Parameters Affected   : 
    ' Assumptions           : 
    ' Dependencies          : 
    ' Author                : DipaliS
    ' Created               : May 21,2004
    ' Revisions             : 
    '=====================================================================
    Private Sub CreateGraph(ByVal strSQLQueryForGraph As String, ByVal strChartType As String, ByVal strImageFileName As String, ByVal strGraphTitle As String, ByVal intNoOfColumns As Integer)

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
            .SQL = strSQLQueryForGraph
            .GenerateImage()

        End With
        objGraph = Nothing
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
    Private Function GetMonthName(ByVal MonthIndex As Integer) As String
        Select Case MonthIndex
            Case 1
                Return (MyBase.GetResourceString("JAN"))
            Case 2
                Return (MyBase.GetResourceString("FEB"))
            Case 3
                Return (MyBase.GetResourceString("MARCH"))
            Case 4
                Return (MyBase.GetResourceString("APRIL"))
            Case 5
                Return (MyBase.GetResourceString("MAY"))
            Case 6
                Return (MyBase.GetResourceString("JUNE"))
            Case 7
                Return (MyBase.GetResourceString("JULY"))
            Case 8
                Return (MyBase.GetResourceString("AUGUST"))
            Case 9
                Return (MyBase.GetResourceString("SEPTEMBER"))
            Case 10
                Return (MyBase.GetResourceString("OCTOBER"))
            Case 11
                Return (MyBase.GetResourceString("NOVEMBER"))
            Case 12
                Return (MyBase.GetResourceString("DECEMBER"))
        End Select
    End Function
#End Region

#Region "Grid Events"
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 1 Then
            Args.ReplacementValue = CType(Args.DataReader("Hours"), String) & m_strHours
        End If
    End Sub

    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        If CType(Args.DataReader.Item("TYPE"), String).Trim.ToLower = "non billable allocation" Then
            Dim strToBeInserted As String
            '    Dim strTotal As String
            '    Dim strQuery As String = "usp_Sel_GetYearlyTotalCapacity " & CommonFunctions.General.BuildQueryString(m_intYear.ToString) & "," & CommonFunctions.General.BuildQueryString(m_intResourceID.ToString)
            '    strTotal = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)), String)
            '    '''Code Commented and added by SwatiC on 20 Jun 2007 for performance Issue
            '    'strToBeInserted = "<tr class=clstrEven><td>" & MyBase.GetResourceString("TOTALCAPCITY") & "</td><td align=right>" & strTotal & " " & m_strHours & "</td></tr>"
            '    'strToBeInserted = strToBeInserted + "<tr><td> </td></tr>" + "<tr class=clstrOdd><td colspan=2>" & MyBase.GetResourceString("NOTE") & "</td></tr>"
            'strToBeInserted = "<tr><td> </td></tr>" + "<tr class=clstrOdd><td colspan=2>" & "Note: The 'Install Capacity' is the annual working hours excluding holidays and weekends for the selected year " & "</td></tr>"
            '--- Modified By Purvaj on 11Dec 2008 for Whiziblesem 8.0
            'Modified by TruptiK on 16-Apr-09
            'strToBeInserted = "<tr><td> </td></tr>" + "<tr class=clstrOdd><td colspan=2>" & "Note: The 'Install Capacity' is working hours for current financial year excluding Leaves and Holidays" & "</td></tr>"
            strToBeInserted = "<tr><td> </td></tr>" + "<tr class=clstrOdd><td colspan=2>" & "Note: The 'Install Capacity' is working hours for current financial year excluding Leaves" & "</td></tr>"
            'end of modification by TruptiK on 16-Apr-09
            '    '''End of Code addition by SwatiC on 20 Jun 2007 for performance Issue
            Args.StringToBeInserted = strToBeInserted
        End If
    End Sub
    Private Sub m_objGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objGrid.ColumnHeaderTR_BeforePrint
        Cancel = True
    End Sub
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ''Added by Shamkant S  on 16/02/2016 to validate Token
        If (Request.QueryString("Token") <> "" And Request.QueryString("EmployeeID") <> "" And Request.QueryString("Year") <> "") Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + CType(Request.QueryString("Year"), String) + "0" + "0", Request.QueryString("Token")) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("EmployeeID"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


            End If

        End If
        ''End of addiotion by Shamkant S  on 16/02/2016 to validate Token
    End Sub


    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        If CType(Args.DataReader.Item("TYPE"), String).Trim.ToLower = "available for allocation" Then
            Dim strToBeInserted As String
            Dim strTotal As String
            Dim strQuery As String = "usp_Sel_GetYearlyTotalCapacity " & CommonFunctions.General.BuildQueryString(m_intYear.ToString) & "," & CommonFunctions.General.BuildQueryString(m_intResourceID.ToString)
            strTotal = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)), String)
            strToBeInserted = "<tr class=clsTREvenRow><td>Install Capacity</td><td align=right>" & strTotal & " " & m_strHours & "</td></tr>"
            Args.StringToBeInserted = strToBeInserted
        End If
    End Sub

    ''Added by Dhanashri S on 31 Mar 2016 Purpose:to generate and validate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateLoadDetailsToken(Month As String, Year As String, FinMonth As String, FinYear As String, ResourceID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(Month, String) + CType(Year, String) + CType(FinMonth, String) + CType(FinYear, String) + CType(ResourceID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Addition by Dhanashri S on 31 Mar 2016
End Class
