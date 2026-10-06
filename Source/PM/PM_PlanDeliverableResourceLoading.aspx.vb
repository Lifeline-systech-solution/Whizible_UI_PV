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
Public Class PM_PlanDeliverableResourceLoading
    Inherits WebPages.Template.WhizTemplate

    'Added By SantoshK
    Public strResourceList As String
    Public m_IntTagID As String
    'Addition Ends


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        m_IntTagID = Request("MasterTagID")
        InitializeComponent()
    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_PlanDeliverableResourceLoading", "AppResources")
    End Sub
#End Region

#Region "Member Variables"
    Protected m_intStartMonth As Integer
    Protected m_intYear As Integer
    Protected m_intResourceID As Integer
    Private m_strHours As String
    Private drMonthlyLoading As IDataReader
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
        Dim strMode As String

        strMode = Request("Mode")

        If strMode = "" Then
            strMode = "Select"
        End If

        strResourceList = Request("ResourceList")
        If strMode = "Select" Then
            m_intLoggedInEmpID = CType(CommonFunctions.General.CheckIsNothing(Session("intUserID")), Integer)

            'Get the Level of the Logged In Employee
            m_intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel")), Integer)

            'Get the ProjectEmployeeRoleID if called from Projects Tab
            If Not IsNothing(Request.QueryString("ProjectEmployeeRoleID")) Then
                m_intProjectEmplyeeRoleID = CType(Request.QueryString("ProjectEmployeeRoleID"), Integer)
            Else
                m_intProjectEmplyeeRoleID = 0
            End If

            ''Get the EmployeeId from the ProjectEmployeeRoleID
            ' If m_intProjectEmplyeeRoleID <> 0 Then
            'Dim strSQLEmpId As String
            'strSQLEmpId = "Select EmployeeId from tbl_pm_projectemployeerole where projectemployeeroleid=" & m_intProjectEmplyeeRoleID
            'm_intResourceID = CType(CommonFunctions.Data.GetDataScalar(strSQLEmpId, MyBase.UseSQL), Integer)
            'Else
            '   m_intResourceID = CType(Request.QueryString("EmployeeID"), Integer)
            'End If

            'Get the Year
            m_intYear = CType(Request.QueryString("Year"), Integer)

            If m_intYear = 0 Then
                m_intYear = DateTime.Now.Year
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

            Dim strQuery As String
            Dim strEmployeeName As String

            'Get the Start Month of financial year

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strQuery = "select Month(FinancialYearStart) as StartMonth from tbl_PM_companyInformation "
            strQuery = "usp_sel_tbl_PM_companyInformation_StartMonth "
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            m_intStartMonth = CType(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), Integer)

            If IsNothing(m_intStartMonth) Then
                m_intStartMonth = 1
            End If

            'Get the employeename

            ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strQuery = "Select UserName from tbl_PM_Employee where EmployeeID=" & m_intResourceID.ToString
            strQuery = "usp_sel_UserName_Tbl_Pm_Employee " & m_intResourceID.ToString
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


            strEmployeeName = CType(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

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
            strResource = MyBase.GetResourceString("RESOURCE") & strEmployeeName
            'end of addition

            'Commented By DipaliS 9 June 2004 and added following
            'WebPages.Template.PageCaption.GetPageCaptions(Nothing, strPageCaption)
            WebPages.Template.PageCaption.GetPageCaptions(Nothing, strPageCaption, strResource)

            CommonFunction.General.WriteHTML("<TABLE class='clsTable'cellpadding=0 cellspacing=0 width='40%' height='10%' id=""TasksTable"" name=""TasksTable"">")
            CommonFunction.General.WriteHTML("<TR class='clsTRODD'>")
            CommonFunction.General.WriteHTML("<Td width='50%' valign=""top"" align=""left"">" & MyBase.GetResourceString("SELECT_RESOURCE") & "</Td>")
            CommonFunction.General.WriteHTML("<Td width='50%' valign=""top"" align=""left"">")
            CommonFunctions.HTMLControls.DrawComboBox("cboResourceNames", strResourceList, , m_intResourceID.ToString, "onchange=""javascript:ResourceNames_OnChange()""", True)
            CommonFunction.General.WriteHTML("</Td>")
            CommonFunction.General.WriteHTML("</TR>")
            CommonFunction.General.WriteHTML("<TABLE>")
            GetMenu()

        Else


            'Get the Logged in Employee's ID
            m_intLoggedInEmpID = CType(CommonFunctions.General.CheckIsNothing(Session("intUserID")), Integer)

            'Get the Level of the Logged In Employee
            m_intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel")), Integer)

            'Get the ProjectEmployeeRoleID if called from Projects Tab
            If Not IsNothing(Request.QueryString("ProjectEmployeeRoleID")) Then
                m_intProjectEmplyeeRoleID = CType(Request.QueryString("ProjectEmployeeRoleID"), Integer)
            Else
                m_intProjectEmplyeeRoleID = 0
            End If

            ''Get the EmployeeId from the ProjectEmployeeRoleID
            ' If m_intProjectEmplyeeRoleID <> 0 Then
            'Dim strSQLEmpId As String
            'strSQLEmpId = "Select EmployeeId from tbl_pm_projectemployeerole where projectemployeeroleid=" & m_intProjectEmplyeeRoleID
            'm_intResourceID = CType(CommonFunctions.Data.GetDataScalar(strSQLEmpId, MyBase.UseSQL), Integer)
            'Else
            '   m_intResourceID = CType(Request.QueryString("EmployeeID"), Integer)
            'End If

            'Get the Year
            m_intYear = CType(Request.QueryString("Year"), Integer)

            If m_intYear = 0 Then
                m_intYear = DateTime.Now.Year
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

            Dim strQuery As String
            Dim strEmployeeName As String

            'Get the Start Month of financial year
            strQuery = "select Month(FinancialYearStart) as StartMonth from tbl_PM_companyInformation "
            m_intStartMonth = CType(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), Integer)

            If IsNothing(m_intStartMonth) Then
                m_intStartMonth = 1
            End If


            m_intResourceID = CType(Request("EmployeeID").ToString, Integer)

            'Get the employeename
            strQuery = "Select UserName from tbl_PM_Employee where EmployeeID=" & m_intResourceID.ToString
            strEmployeeName = CType(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), String)

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
            strResource = MyBase.GetResourceString("RESOURCE") & strEmployeeName
            'end of addition

            'Commented By DipaliS 9 June 2004 and added following
            'WebPages.Template.PageCaption.GetPageCaptions(Nothing, strPageCaption)
            WebPages.Template.PageCaption.GetPageCaptions(Nothing, strPageCaption, strResource)

            CommonFunction.General.WriteHTML("<TABLE class='clsTable'cellpadding=0 cellspacing=0 width='40%' height='10%' id=""TasksTable"" name=""TasksTable"">")
            CommonFunction.General.WriteHTML("<TR class='clsTRODD'>")
            CommonFunction.General.WriteHTML("<Td width='50%' valign=""top"" align=""left"">" & MyBase.GetResourceString("SELECT_RESOURCE") & "</Td>")
            CommonFunction.General.WriteHTML("<Td width='50%' valign=""top"" align=""left"">")
            CommonFunctions.HTMLControls.DrawComboBox("cboResourceNames", strResourceList, , m_intResourceID.ToString, "onchange=""javascript:ResourceNames_OnChange()""", True)
            CommonFunction.General.WriteHTML("</Td>")
            CommonFunction.General.WriteHTML("</TR>")
            CommonFunction.General.WriteHTML("<TABLE>")


            'Response.Write("Select Resource : ")
            'CommonFunctions.HTMLControls.DrawComboBox("cboResourceNames", strResourceList, , m_intResourceID.ToString, "onchange=""javascript:ResourceNames_OnChange()""", True)
            'Response.Write("<BR>")

            GetResourceUtilizationGraph()

            'Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")

            GetResourceUtilization()

            'Code Added 29 May 2004
            'Get the Data for Others Category of Projects only if Level is 2 or 3
            If m_intRoleLevel <> 1 Then
                GetOthersDetails()
            End If

            'End of Addtion

            GetMonthlyLoading()

            GetJobLoading()

            'Response.Write("</DIV>")

            GetMenu()
        End If
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

        'Response.Write("<BR>")

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
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With objSectionTitle
            Response.Write(.GetSectionTitle(strSectionTitle, strSectionTag, ""))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        objSectionTitle = Nothing
        Dim strGrid As String


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

        Dim drForCount As IDataReader

        'Get the Number of rows
        drForCount = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        While drForCount.Read
            m_intNoOfRows = m_intNoOfRows + 1
        End While
        CommonFunctions.Data.DisposeDataReader(drForCount)

        drMonthlyLoading = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        'CommonFunctions.Data.DisposeDataReader(drResourceLoading)
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


        If drMonthlyLoading.Read Then

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
        strHTML.Append("<table class=clsTable  cellspacing=0 cellpadding=0 width=99.9%><tr class=clsTRSectionHeader>")
        strHTML.Append("<td width=65% align=left>" & MyBase.GetResourceString("MONTHLYLOADING") & "</td></tr></table>")

        strHTML.Append("<table width=99.9% border=0 cellspacing=0 cellpadding=0 ><tr class=clsTRColumnHeader><td  align=left>" & MyBase.GetResourceString("BOOKEDHOURS") & "</td>")

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
        If drMonthlyLoading.Read Then

            If Not IsDBNull(drMonthlyLoading.Item(0)) Then

                strHTML.Append("<td class=clsTDEven align=left>" & FormatNumber(drMonthlyLoading.Item(2), 2) & "</td>")

                m_intTotalBugdetedHours = CType(CommonFunctions.General.CheckIsNothing(drMonthlyLoading.Item(2)), Integer)
                m_intTotalHours = 0

                Do While intCount > 0
                    'If greater than zero, then show the hypelink
                    If CDbl(drMonthlyLoading.Item(intIndex)) <= 0 Then
                        strHTML.Append("<td class=clsTDEven align=left>" & FormatNumber(CommonFunctions.General.CheckIsNothing(drMonthlyLoading.Item(intIndex)), 2) & "</td>")
                    Else
                        strHTML.Append("<td class=clsTDEven align=left>" & _
                        "<a href='javascript:LoadDetails(" & intIndex - 2 & ")'>" & FormatNumber(CommonFunctions.General.CheckIsNothing(drMonthlyLoading.Item(intIndex)), 2) & "</a></td>")
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
                    CType(FormatNumber(drMonthlyLoading.Item(intIndex), 2), String) & "</td>")
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

        strHTML.Append("<table CellSpacing=0 Border=0 width=99.9%><tr class=clsTRSectionHeader ><td width=65% align=left>" & MyBase.GetResourceString("JOBLOADING") & "</td></tr></table>")
        strHTML.Append("<table cellSpacing=0 cellPadding=0 width=99.9% border=0><tbody><tr class=clsTRColumnHeader ><td align=left>" & MyBase.GetResourceString("PROJECTNAME") & "</td><td align=left>" & MyBase.GetResourceString("BOOKEDHOURS") & "</td>")

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

        While drMonthlyLoading.Read
            'Booked Hours
            strHTML.Append("<tr><td class=clsTDEven align=left>" & CType(drMonthlyLoading.Item("ProjectName"), String) & "</td>" & _
                "<td class=clsTDEven align=left>" & FormatNumber(drMonthlyLoading("TotalBookedHours"), 2) & "</td>")
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
        End While

        'Code Added By DipaliS 29 May 2004
        If m_intRoleLevel <> 1 Then
            'Append Others Details
            strHTML.Append("<tr><td class=clsTDEven align=left>" & m_strOthersProjectName & "</td>" & _
                        "<td class=clsTDEven align=left>" & m_strOthersBookedHours & "</td>")

            Dim intCountArr As Integer = 0
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
        strHTML.Append("<table cellSpacing=0 cellPadding=0 width=99.9% border=0><tbody><tr class=clsTREven><td>")
        strHTML.Append(MyBase.GetResourceString("FOOTERNOTE")).Replace("<bookhours>", FormatNumber(m_intTotalBugdetedHours, 2)).Replace("<plannedhours>", m_intTotalHours.ToString)
        strHTML.Append("</tr></tbody></table>")
        strHTML.Append("</div>")
        Response.Write(strHTML)

        CommonFunctions.Data.DisposeDataReader(drMonthlyLoading)
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
        If CType(Args.DataReader.Item("TYPE"), String).Trim.ToLower = "non billable" Then
            Dim strToBeInserted As String
            Dim strTotal As String
            Dim strQuery As String = "usp_Sel_GetYearlyTotalCapacity " & CommonFunctions.General.BuildQueryString(m_intYear.ToString) & "," & CommonFunctions.General.BuildQueryString(m_intResourceID.ToString)
            strTotal = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)), String)
            strToBeInserted = "<tr class=clstrEven><td>" & MyBase.GetResourceString("TOTALCAPCITY") & "</td><td align=right>" & strTotal & " " & m_strHours & "</td></tr>"
            strToBeInserted = strToBeInserted + "<tr><td> </td></tr>" + "<tr class=clstrOdd><td colspan=2>" & MyBase.GetResourceString("NOTE") & "</td></tr>"
            Args.StringToBeInserted = strToBeInserted
        End If
    End Sub
    Private Sub m_objGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objGrid.ColumnHeaderTR_BeforePrint
        Cancel = True
    End Sub
#End Region

End Class
