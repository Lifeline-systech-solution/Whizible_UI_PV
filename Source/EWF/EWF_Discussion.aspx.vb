'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleE
' Module Name           :  EWF_Discussion.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class EWF_Discussion
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

#Region "Member Variables"
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0

    Protected m_strMode As String
    Private m_strAction As String
    Protected m_lngExpenseEntryID As Long = 0
    Protected m_strtxtComments As String = ""
    Protected m_blnShowDisabled As Boolean
    Protected m_strComments As String = ""
    Private m_strUserName As String
    Protected m_strWindowTitle As String
    Private WithEvents m_objGrid As New WebPage.Templates.GenericGrid

#End Region

#Region "Constants"

    Protected CONST_DISCUSSION As String = "DISCUSS"
    Protected CONST_ACTION_SAVE As String = "SAVE"

#End Region

#Region "Functions and Sub-Procedures"

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   NitinVS
        ' Created               :   4 Jun 2005 
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()

        Dim objHeader As WebPage.Templates.HeaderFooter

        m_strMode = Request.QueryString("Mode") + ""

        If m_strMode = "" Then m_strMode = CONST_DISCUSSION 'default mode

        If Request.QueryString("ExpensesEntryID") <> "" Then
            m_lngExpenseEntryID = CType(Request.QueryString("ExpensesEntryID"), Long)
        End If

        If Request.QueryString("txtComments") <> "" Then
            m_strtxtComments = CType(Request.QueryString("txtComments"), String)
        End If

        If Request.QueryString("Comments") <> "" Then
            m_strComments = CType(Request.QueryString("Comments"), String)

            m_strComments = Replace(m_strComments, "'", "\'")
        End If


        m_strAction = Request.QueryString("Action") + ""
        m_strUserName = Session("strUserName").ToString + ""

        m_blnShowDisabled = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("showdisabled"), "0"), Boolean)



        'Modified By ShraddhaM on 21,Sep 2006 For SP7 Issue ID : 6197
        Dim m_lngExpensesEntryID As Long
        Dim m_strPKToken_Discussion As String
        If m_strMode.ToUpper = "VIEW" Then
            m_lngExpensesEntryID = CType(Trim(Request.QueryString("ExpensesEntryID")), Long)
            m_strPKToken_Discussion = CType(Trim(Request.QueryString("PkToken")), String)
            If IsNothing(m_lngExpensesEntryID) Then m_lngExpensesEntryID = 0

            If CType(m_strPKToken_Discussion, String) <> "0" Then
                If Request.QueryString("PkToken") Is Nothing Then
                    m_strPKToken_Discussion = Request.Form("txtPkToken").ToString
                Else
                    m_strPKToken_Discussion = Request.QueryString("PkToken").ToString
                End If
            End If

            m_lngTagId = CType(Trim(Request.QueryString("MasterTagID")), Long)

            If ((m_strPKToken_Discussion = "") And (m_lngExpensesEntryID <> 0)) Or _
                ((m_lngExpensesEntryID <> 0) And _
                (CommonFunctions.Security.Token.ValidateToken(CType(m_lngExpensesEntryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String), m_strPKToken_Discussion) = False)) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Expense Discussion", 0, m_lngTagId, "Expense ID", CType(m_lngExpensesEntryID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        'Ended By ShraddhaM on 21,Sep 2006 For SP7 Issue ID : 6197

        Select Case m_strMode
            Case CONST_DISCUSSION


                ' Draw Upper Menu
                DrawMenu()

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                'initialize the resource file for Discussion page.
                MyBase.InitializeResources("AppResources.EWF_Discussion", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_DISCUSS"))
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_DISCUSS") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen for discussion page
                Call plotScreenForDiscussion(m_lngExpenseEntryID)

            Case "VIEW"
                'initialize the resource file for Discussion page.
                MyBase.InitializeResources("AppResources.EWF_Discussion", "AppResources")

                DrawMenu()
                Call plotScreenForDiscussion(m_lngExpenseEntryID)

        End Select
        'draw lower menu
        General.WriteHTML("<BR>")
        DrawMenu()



    End Sub

    Private Sub DrawMenu()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.EWF_Discussion", "AppResources")

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        If m_strMode = CONST_DISCUSSION Then
            arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
        End If

        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('EWF_DISCUSSION')")

        'copy all the element to string array
        Dim arrstrMenu(arrMenu.Count - 1) As String
        Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
        Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
        arrMenu.CopyTo(arrstrMenu)
        arrMenuToolTip.CopyTo(arrstrMenuToolTip)
        arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrClientSideFunctions = Nothing


        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

        'draw upper menu
        General.WriteHTML(strMenu)
    End Sub
    '=====================================================================
    ' Procedure Name		:	plotScreenForDiscussion
    ' Parameters Passed		:	lngIssueID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page for discussion page.
    ' Description			:	This procedure will plot the screen to for discussion page with text area
    '                           for the comments. Here grid of previous comments with date and username is also
    '                           plotted.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 9 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenForDiscussion(ByVal lngIssueID As Long)
        Dim strSQL As String
        Dim strDate As String
        Dim strComments As String

        'get the current date 
        strDate = CommonFunction.Dates.CGetDateTime(Date.Now) + ""
        If m_strAction = "" Then
            strComments = MyBase.GetFormValue("txtComments") + ""
        Else
            strComments = ""
        End If

        If m_strMode = CONST_DISCUSSION Then
            'plot the controls
            General.WriteHTML("<Div id='DivBody' width=100% height=90% style='overflow: auto;' >")
            General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0 >")

            'display the textarea for comments
            General.WriteHTML("<TR class='clsTREven' >")
            General.WriteHTML("<TD align='right' valign='top' >" + MyBase.GetResourceString("CAP_COMMENTS") + "&nbsp</TD>")
            General.WriteHTML("<TD align='left'>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'General.WriteHTML(HTMLControls.DrawTextArea("txtComments", "txtComments", , , , "frmDiscussion", , , 380, 100, 7000, strComments.Trim, , , m_blnShowDisabled, , , , , True, True) + "</TD>")
            General.WriteHTML(HTMLControls.DrawTextArea("txtComments", "txtComments", , , , "frmDiscussion", , , 380, 100, 7000, strComments.Trim, , , m_blnShowDisabled, , , , , True, True, EnableHTMLEncode:=True))
            General.WriteHTML("</TD>")
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            General.WriteHTML("</TR>")

            General.WriteHTML("</Table>")
            General.WriteHTML("<BR>")

        End If

        'plot the grid for previous comments
        Dim arrColHeader() As String = {MyBase.GetResourceString("CAP_USER_NAME"), MyBase.GetResourceString("CAP_DATE"), MyBase.GetResourceString("CAP_STATUS"), MyBase.GetResourceString("COL_COMMENTS")}
        Dim arrAN() As String = {"EmployeeName", "LastUpdatedDate", "Status", "Comments"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'create the SP for grid data without sorting 
        strSQL = "Exec Usp_Sel_tbl_PM_ExpenseEntry_Status_History_Comments " + m_lngExpenseEntryID.ToString

        'create Grid object and set the properties
        'm_objGrid = New WebPage.Templates.GenericGrid
        With m_objGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 250
            .DIVStyle = "overflow:auto; width:100% "
            .NoOfDataColumns = 4
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .EmptyValueReplacement = "-"
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            'plot the grid 
            .DrawGrid()
        End With
        m_objGrid = Nothing

        'close the body Div
        General.WriteHTML("</Div>")
    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub


#End Region

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        If Args.DataField.ToUpper = "LASTUPDATEDDATE" Then
            Args.ShowTimeWithDate = True
        End If
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class
