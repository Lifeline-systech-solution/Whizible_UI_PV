Public Class IB_ValidationRules
    Inherits WebPage.Templates.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    '=====================================================================
    ' Page Name             : PM_MapReviewTasks
    ' Purpose               : Mapping Review tasks to Mpp tasks.
    ' Description           : 
    ' Parameters Passed     : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : AbhijeetD
    ' Created               : Feb 24th, 2004
    ' Revisions             : 
    '=====================================================================

    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private m_strclsTRColHeader As String = "'clsTRColumnHeader'"
    Private m_strClsTREven As String = "'clsTREven'"
    Private m_strClsTROdd As String = "'clsTROdd'"
    Private m_blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
    Private m_strAction As String
    Private m_strRules As String = ""



    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strRules = CommonFunctions.General.CheckIsNothing(Request.QueryString("Rules"))
        'Render a hidden control for action: used for identifying the action to be taken after postback
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunction.HTMLControls.DrawTextBox("hdAction", "hdAction", , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit
        ' Purpose               : Entry to the page
        ' Description           : Called from within the <Form> Tag
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 25th Feb 2004
        ' Revisions             :
        '=====================================================================
        If MyBase.Page.IsPostBack Then
            Select Case m_strAction.ToUpper
                Case "SAVE"
            End Select
        End If
        'Plot the page
        DrawPage()
    End Sub

    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Renders the UI
        ' Description           : This function generates the html for the page
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 24th Feb 2004
        ' Revisions             :
        '=====================================================================

        Dim strMenu As String

        '-- TOP Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<br>")

        '-- Draw Page Caption
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), , , True))
        Response.Write("<BR>")

        Response.Write("<DIV ID='divList' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
        'Plot the grid for Validation Rules
        DrawGrid()
        Response.Write("</DIV>")

        '-- BOTTOM Menu
        Response.Write("<br>" + strMenu)

        '-- Dispose the objects
        DisposeObjects()
    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 24th Feb, 2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.IB_ValidationRules", "AppResources")

        'Dim arrMenu() As String = {"<A class='Menu' Href ='#' onClick=" + Chr(34) + "SetValidation()" + Chr(34) + ">" + "<B>" + MyBase.GetResourceString("MENU_SET_VALIDATION") + "</B></A>", "<A class='Menu' Href ='#' onClick=" + Chr(34) + "Close_OnClick()" + Chr(34) + ">" + "<B>" + MyBase.GetResourceString("MENU_CLOSE") + "</B></A>"}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SET_VALIDATION"), MyBase.GetResourceString("MENU_CLOSE")}
        'Dim arrClientSideFunctions() As String = {"", ""}
        'Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Dim strMenu As String = ""
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        strMenu &= "<Table class=clsTable cellspacing=0 cellpadding=0 width='99.9%'>"
        strMenu &= "<TR class=clsTRMenu><TD align=Right>"
        strMenu &= "&nbsp;|&nbsp;"
        strMenu &= "<A class='Menu' style='' HREF='#' onclick='SetValidation()' "
        strMenu &= "Title='" & MyBase.GetResourceString("MENU_SET_VALIDATION") & "' >" & MyBase.GetResourceString("MENU_SET_VALIDATION") & "</A>"
        strMenu &= "&nbsp;|&nbsp;"
        strMenu &= "<A class='Menu' style='' HREF='#' onclick='Close_OnClick()' "
        strMenu &= "Title='" & MyBase.GetResourceString("MENU_CLOSE") & "' >" & MyBase.GetResourceString("MENU_CLOSE") & "</A>"
        strMenu &= "&nbsp;|&nbsp;"
        strMenu &= "</TD></TR></TABLE>"

        Return strMenu
    End Function

    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid
        ' Purpose               : Render the UI for showing validation rules
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 25th Feb 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim arrstrActualList() As String = {"ValidationDescription", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("VALIDATION_RULE"), MyBase.GetResourceString("APPLY")}
        Dim arrCheckBox() As String = {"", "chkApply"}
        Dim arrstrTDStyle() As String = {" align=left noWrap ", " align=center "}
        Dim strGRID As String
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:07/10/15
        strSQL = "EXEC usp_Sel_tbl_UI_Validation "

        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrstrTDStyle
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .PrimaryKey = "ValidationID"
            .ColumnHeaderAlignment = "center"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQL
            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL

            strGRID = .DrawGrid()
        End With
        Response.Write(strGRID)
    End Sub

    Public Sub PlotPageHeader()
        '=====================================================================
        ' Procedure Name        : PlotPageHeader
        ' Purpose               : Plot Page Header
        ' Description           : Renders the standard page header. Called from above the <body> tag
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 24th Feb 2004
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.IB_ValidationRules", "AppResources")
        CommonFunction.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION"))
    End Sub

    Private Sub DisposeObjects()
        '=====================================================================
        ' Procedure Name        : DisposeObjects
        ' Purpose               : Dispose Objects
        ' Description           : Dispose the objects allocated with memory
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 1st Mar 2004
        ' Revisions             :
        '=====================================================================
        m_objGrid = Nothing
        m_objMenu = Nothing
    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        If CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_IS_DATE Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_GREATER_THAN_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_LESS_THAN_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_EQUAL_TO_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_NOT_EQUAL_TO_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_GREATER_THAN_OR_EQUAL_TO_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_LESS_THAN_OR_EQUAL_TO_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_IS_DUPLICATE Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_IS_DUPLICATE_MATCH_CASE Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_MIN_LENGTH Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_IS_INTEGER Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_IS_POSITIVE_INTEGER Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) > 28 Then
            Cancel = True
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 1 Then
            If InStr("," & m_strRules, "," & Args.DataReader.Item("ValidationID").ToString() & ",", CompareMethod.Text) > 0 Then
                Args.IsCheckBoxChecked = True
            End If
        End If
    End Sub
End Class
