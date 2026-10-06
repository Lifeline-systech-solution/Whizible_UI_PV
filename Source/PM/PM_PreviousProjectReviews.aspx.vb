Public Class PM_PreviousProjectReviews
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

#Region " Initialized Variables "
    Private WithEvents m_objPaging As New WebPages.Template.Paging
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private m_strPReviewType As String = ""
    Private m_strParamMode As String = ""
    Private strSQLQuery As String

    Protected m_strWindowTitle As String
    Private m_strParamStatsID As String = ""
    Private m_strEmployeeID As String
    Private m_intSessionProjectID As Integer
    Private m_strReviewer As String = ""
    Private m_strReviewee As String = ""
    Protected m_lngAppReviewReportID As Long

#End Region

#Region " Page Load Functions "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strWindowTitle = MyBase.GetResourceString("TITLE")
        ''Added  By Shamkant s 31/12/2015
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        'Ended By Shamkant s 31/12/2015
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
        ' Created               : MARCH 29, 2004
        ' Revisions             :
        '=====================================================================
        m_strParamStatsID = CType(Request.QueryString("ReviewStatisticsID"), String)
        m_strParamMode = CType(Request.QueryString("Mode"), String)
        m_intSessionProjectID = CType(Session("intProjectID"), Integer)
        m_lngAppReviewReportID = CommonFunctions.Application.ReviewReportID


        DrawMenu()
        DrawPageHeader()
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
        ' Created               : MARCH 29, 2004
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
        arrClientSideFunctionList.Add("Help_OnClick('40')")

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
        ' Created               : MARCH 29, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
#End Region

#Region " Grid Plotting "
    Private Sub DrawPageHeader()
        Dim drReview As IDataReader
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter
        Dim strHTML As String = ""
        strSQLQuery = "Exec usp_Sel_tbl_PM_ReviewStatistics " & m_strParamStatsID
        drReview = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drReview.Read Then
            m_strPReviewType = CType(CommonFunctions.Data.CheckIsDBNull(drReview("ReviewType"), ""), String)
            m_strReviewer = CType(CommonFunctions.Data.CheckIsDBNull(drReview("ReviewedBy"), ""), String)
            m_strReviewee = CType(CommonFunctions.Data.CheckIsDBNull(drReview("Reviewee"), ""), String)
        End If
        CommonFunctions.Data.DisposeDataReader(drReview)
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeaderFooter.HeaderFooter = "<Table class=clsTable cellspacing=0 cellpadding=0 width='99.9%'> <tr class=clsTRPageHeader> <td style='width:70%'> " + MyBase.GetResourceString("REVIEWER") + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <b>" + m_strReviewer + "</b></td><td style='width:30%;text-align:Right'>" + MyBase.GetResourceString("REVIEWEE") + "<b> " + m_strReviewee + "</b></td></tr>" + _
                                       "<tr class=clsTRPageHeader><td colspan=2>" + MyBase.GetResourceString("REVIEW_TYPE") + "<b> " + m_strPReviewType + "</b></td></tr></table>"

        strHTML = objHeaderFooter.DrawHeaderFooter(, True)
        If strHTML <> "" Then
            CommonFunctions.General.WriteHTML("<BR>" + strHTML)
        End If

    End Sub
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
        ' Created               : MARCH 29, 2004
        ' Revisions             :
        '=====================================================================

        Dim drEmployeeID As IDataReader
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"style='width:40%'", "align=center"}
        Dim arrColRowLinks() As String = {"", "ShowReport_OnClick(ReviewStatisticsID)"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        CommonFunctions.General.WriteHTML("<br>")
        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PREVIOUS_REVIEWS"))
        CommonFunctions.General.WriteHTML("<br><DIV id='PageDiv' style='Overflow:auto;width:100%;Height:80px'>")
        'strSQLQuery = "Exec usp_Sel_tbl_PM_ReviewStatistics " + CStr(m_strParamStatsID)
        strSQLQuery = "Exec usp_Sel_tbl_PM_GetPrevReviewStatisticsID " & m_intSessionProjectID & ", " & m_strParamStatsID & ", '" & CommonFunction.General.BuildQueryString(m_strPReviewType) & "', '" & CommonFunctions.General.BuildQueryString(m_strReviewer) & "', '" & CommonFunctions.General.BuildQueryString(m_strReviewee) & "'"
        ''Plots the Table for Daily Activity .
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add(MyBase.GetResourceString("REVIEW_DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("SHOW_REPORT"))

        arrActualColumnNames.Add("ReviewedDate")
        arrActualColumnNames.Add("ReviewStatisticsID")

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .RowLinkArray = arrColRowLinks
            .NoOfDataColumns = 2
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGrid = Nothing
        CommonFunction.General.WriteHTML("<br></div>")
    End Sub
#End Region

#Region " Event Handling "
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField = "ReviewStatisticsID" Then
            Args.ReplacementValue = MyBase.GetResourceString("SHOW_REPORT")
        End If
    End Sub
#End Region

#Region " Constructor "
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_PreviousProjectReviews", "AppResources")
    End Sub
#End Region


End Class
