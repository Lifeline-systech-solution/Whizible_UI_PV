Public Class PM_ResourceTaskDetails
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
    End Sub

#End Region


    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As WebPages.Template.GenericGrid
    Private m_blnUseSQL As Boolean

    Dim m_strMileName As String = ""
    Dim m_intMonths As String = ""
    Dim m_dtStartDate As String = ""
    Dim m_intAmount As String = ""
    Dim intResourceId As Integer
    Dim intOver As Integer
    Dim strSql As String
    Dim ResID As String
    Dim Dy As String
    Dim mnt As String
    Dim yr As String
    Dim strMonth As String


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        'Put user code to initialize the page here
        'm_blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

        'm_strMileName = Request.Form("txtMileName")
        'm_intMonths = Request.Form("txtMonths")
        'm_dtStartDate = Request.Form("dtStartDate")
        'm_intAmount = Request.Form("txtAmtPerMonth")

        'If Request.QueryString("Action") = "Generate" Then
        '    GenerateMilestones()
        'End If

        'WriteGrid()

    End Sub

    Private Sub WriteGrid()

        Response.Write("<table cellpadding=0 cellspacing=0 bordercolor=black border=2 width='100%'><tr> <td width='100%'>")
        WriteGridWithProject()

    End Sub
    Private Sub WriteGridWithProject()
        Dim arrActualColumns() As String = {"ProjectName", "TaskName", "StartDate", "EndDate", "Work", "Plannedhrs", "Actualhrs"}
        Dim arrUserFriendlyColumns() As String = {"Project Name", "Task Name", "Start Date", "End Date", "Work", "Planned hrs", "Actual hrs"}
        Dim arrstrTDStyle() As String = {"", "", "", "", "style='text-align=right'", "style='text-align=right'", "style='text-align=right'"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        strSql = " Exec usp_sel_ResourceTaskDetails  "
        strSql = strSql & ResID
        strSql = strSql & "," & Dy
        strSql = strSql & "," & mnt
        strSql = strSql & "," & yr
        strSql = strSql & ",'" & strMonth & "'"

        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            '--Columns in the Grid
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumns
            .NoOfDataColumns = 7
            .ColumnHeaderAlignment = "center"
            .TDStyleArray = arrstrTDStyle
            '.SQL = "usp_CDB_GetProjectProgress " & m_lngLocationID & " ," & intOver & " ," & """" & strFilter & """"
            .SQL = strSql
            .EmptyValueReplacement = ""
            .ColNameToolTipOnEachRow = True
            .DIVHeight = 300
            .DIVID = "divList"
            .DIVStyle = "overflow:auto;width=100%"
            .returnHTML = False
            .UseSQL = MyBase.UseSQL
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGrid = Nothing
        Response.Write("</td></tr></table>")
    End Sub
    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : 
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : JyotiG
        ' Created               : Jul 22 ,2006
        ' Revisions             :
        '=====================================================================


        Dim arrMenu() As String = {"Close", "?"}
        Dim arrMenuToolTip() As String = {"Close", "Help"}
        Dim arrCSFunction() As String = {"Close_OnClick()", "Help_OnClick()"}

        Dim strMenu As String

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)

        ResID = CType(Request.QueryString("ResourceID"), String)
        Dy = CType(Request.QueryString("Day"), String)
        mnt = CType(Request.QueryString("Month"), String)
        yr = CType(Request.QueryString("Year"), String)

        strMonth = MonthName(CType(mnt, Integer), True)

        strMonth = Dy + "-" + strMonth + "-" + yr

        Response.Write(strMenu)
        Response.Write("<BR>")
        Response.Write("<BR>")
        Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Resource Task Details : " + strMonth))
        Response.Write("<div id=divList style='overflow:auto'>")
        Response.Write("<Table class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
        WriteGrid()
        Response.Write("</TABLE>")
        Response.Write("</div>")
        Response.Write("<BR>")
        Response.Write(strMenu)
        ' menu

    End Sub
End Class
