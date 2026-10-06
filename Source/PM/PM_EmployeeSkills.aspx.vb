Public Class PM_EmployeeSkills
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
        ''Added by Yogesh J on on 02 Mar 2016 to validate Token
        If Request.QueryString("PageType") = "Skills" And Request.QueryString("FromWhere") = "PM" Then
            If Request.QueryString("UserName") IsNot Nothing And Request.QueryString("PKToken") IsNot Nothing And Request.QueryString("Date") IsNot Nothing Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("UserName"), String) + CType(Request.QueryString("Date"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then

                    ' Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_YearValue, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If
        '  End of addition by Yogesh J on 02-Mar-2016 to validate Token 
    End Sub

#End Region

#Region " Initialized Variables "
    Private WithEvents m_objPaging As New WebPages.Template.Paging
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Private m_strParamUserName As String
    Private strSQLQuery As String

    Protected m_strWindowTitle As String
    Private m_strEmployeeID As String

#End Region

#Region " Page Load Functions "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strWindowTitle = MyBase.GetResourceString("EMPLOYEE_SKILL")
    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 25, 2004
        ' Revisions             :
        '=====================================================================

        m_strParamUserName = CType(Request.QueryString("UserName"), String)
        DrawMenu()
        DrawGrid()
        DrawMenu()
    End Sub
#End Region

#Region " Plots the Menu "
    Private Sub DrawMenu()
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
        ' Created               : Feb 25, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim strPageAlphabets As String

        m_objMenu = New WebPages.Template.StaticMenu

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("TOOLTIP_MENU_HELP"))
        arrClientSideFunctionList.Add("Help_OnClick('100')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
        strPageAlphabets = ""
    End Sub
#End Region

#Region " Generic Functions "
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
#End Region

#Region " Grid Plotting "
    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()	
        ' Purpose               : Plots the grid on the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 25, 2004
        ' Revisions             :
        '=====================================================================

        Dim drEmployeeID As IDataReader
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"style='width:40%'", "align=center", "align=center"}
        Dim arrColRowLinks() As String = {"", "", ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        drEmployeeID = CommonFunctions.Data.GetDataReader("usp_Sel_GetEmployeeID '" + CommonFunction.General.BuildQueryString(m_strParamUserName) + "'", MyBase.UseSQL)
        If drEmployeeID.Read Then
            m_strEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(drEmployeeID("EmployeeID"), "0"), String)
        End If
        CommonFunctions.Data.DisposeDataReader(drEmployeeID)

        '' Set EmployeeID to 0 if not found so that no error occurs.
        If m_strEmployeeID = "" Then m_strEmployeeID = "0"
        CommonFunctions.General.WriteHTML("<br>")
        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("SKILLS_SET_OF") + m_strParamUserName)
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:80px'>")
        strSQLQuery = "usp_Sel_tbl_PM_EmployeeSkillMatrix NULL,NULL,NULL," + m_strEmployeeID
        CommonFunctions.General.WriteHTML("<br><DIV id=DivList style='Overflow:auto;width=100%;Height:230'>")

        ''Plots the Table for Daily Activity .
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add(MyBase.GetResourceString("SKILL"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("YEAR"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("MONTH"))

        arrActualColumnNames.Add("Tool")
        arrActualColumnNames.Add("YearsOfExperience")
        arrActualColumnNames.Add("MonthsOfExperience")

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 3
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGrid = Nothing
        CommonFunction.General.WriteHTML("<br></div>")
        CommonFunction.General.WriteHTML("</div>")
    End Sub
#End Region

#Region " Event Handling "
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'If Args.ColumnName = ""
        Dim strYearOfExp As String
        Dim strMonthOfExp As String
        If Args.DataField = "YearsOfExperience" Then
            strYearOfExp = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("YearsOfExperience"), "-"), String)
            If strYearOfExp = "1" Then
                Args.ReplacementValue = strYearOfExp & " year"
            ElseIf strYearOfExp = "0" Then
                Args.ReplacementValue = "-"
            ElseIf strYearOfExp <> "-" Then
                Args.ReplacementValue = strYearOfExp & " years"
            End If
        End If
        If Args.DataField = "MonthsOfExperience" Then
            strMonthOfExp = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MonthsOfExperience"), "-"), String)
            If strYearOfExp = "1" Then
                Args.ReplacementValue = strMonthOfExp & " month"
            ElseIf strMonthOfExp = "0" Then
                Args.ReplacementValue = "-"
            ElseIf strMonthOfExp <> "-" Then
                Args.ReplacementValue = strMonthOfExp & " months"
            End If
        End If

    End Sub
#End Region

#Region " Constructor "
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_EmployeeSkills", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region


End Class
