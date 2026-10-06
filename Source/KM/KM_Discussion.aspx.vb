Imports System.Web.HttpUtility
Imports System.Reflection

Public Class KM_Discussion
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Private m_strPageTitle As String = ""
    Private m_strAction As String
    Private m_strUserName As String
    Private WithEvents m_objGrid As New WebPage.Templates.GenericGrid
    Private WithEvents m_objGrid_History As New WebPage.Templates.GenericGrid
    Private WithEvents m_objGrid_HistoryDetails As New WebPage.Templates.GenericGrid

    Protected m_strToken As String
    Protected m_strMode As String
    Protected m_strProcedureID As String
    Protected m_strVersionID As String
    Protected m_From As String = ""
    Protected m_lngProcedureID As Long = 0
    Protected CONST_DISCUSSION As String = "DISCUSS"
    Protected CONST_ACTION_SAVE As String = "SAVE"
    Protected CONST_HISTORY As String = "HISTORY"
    Protected m_FromWhere As String = ""

    ''Added By Chakshuta H on 11th-Aug-2016
    Private m_blnValidate As Boolean = True
    ''End of Added By Chakshuta H on 11th-Aug-2016

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        InitPage()
    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name		:	PageInit
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To draw all controls on the page
        ' Description			:	This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML bady tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SuchitraP
        ' Created				:	Mar 23 2009
        ' Revisions				:	
        '=====================================================================

        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strArticleName As String
        'Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
        If Request.QueryString("FromWhere") = "Discussion" Or Request.QueryString("FromWhere") = "TopTen" Or Request.QueryString("FromWhere") = "LatestFeatured" Or Request.QueryString("FromWhere") = "MyArticle" Then
            If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID").ToString <> "0") And Request.QueryString("Action") <> "SAVE" Then
                m_blnValidate = False
            ElseIf Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProcedureID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
                m_blnValidate = False
            End If
            If m_blnValidate = False Then
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        'End Of Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
        If CType(m_strToken, String) <> "0" Then
            If Request.QueryString("PKToken") Is Nothing Then
                m_strToken = Request.Form("txtPkToken").ToString
            Else
                'Commented and added by Chetan M on 10 Nov 2020 for Issue ID = 28178 You are not authorized issue
                'm_strToken = Request.QueryString("PKToken").ToString
                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Request.QueryString("ProcedureID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
                'End of Commented and added by Chetan M on 10 Nov 2020 for Issue ID = 28178 You are not authorized issue
            End If
        End If

        If Not Request.QueryString("ProcedureID") Is Nothing Then
            m_lngProcedureID = CType(Request.QueryString("ProcedureID"), Long)
        End If

        If Not Request.QueryString("VersionID") Is Nothing Then
            m_strVersionID = CType(Request.QueryString("VersionID"), Long)
        End If
        If CommonFunction.General.CheckIsNothing(Request.QueryString("From"), "") <> "" Then
            m_From = Request.QueryString("From").ToUpper
        Else
            m_From = ""
        End If

        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_DISCUSSION 'default mode

        m_strAction = Request.QueryString("Action") + ""
        m_strUserName = Session("strUserName").ToString + ""

        'Added by AbhijeetC on 11 Nov 2009
        If Not Request.QueryString("Fromwhere") Is Nothing Then
            m_FromWhere = Request.QueryString("Fromwhere").ToString
        End If
        'End of Addition by AbhijeetC on 11 Nov 2009

        Select Case m_strMode
            Case CONST_DISCUSSION

                If m_strAction <> "" Then
                    'update the data
                    Call performDiscussionThreadAction(m_lngProcedureID)

                End If

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add("Save") : arrMenuToolTip.Add("Save") : arrClientSideFunctions.Add("Save_OnClick()")
                arrMenu.Add("Close") : arrMenuToolTip.Add("Close") : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add("?") : arrMenuToolTip.Add("Help") : arrClientSideFunctions.Add("Help_OnClick('KM_DISCUSSION')")

                ' copy all the element to string array
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
                CommonFunction.General.WriteHTML(strMenu)
                CommonFunction.General.WriteHTML("<BR>")

                'Display the PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                CommonFunction.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)


                'draw page caption 
                strArticleName = CType(CommonFunction.Data.GetDataScalar("SELECT ProcedureTitle FROM tbl_KM_CodeHeadings WHERE ProcedureID =" + CType(m_lngProcedureID, String), True), String)
                'Commented And Added By Bharat T on 24th-nov-2015 for SEM Upgrade Project module issue solving
                'WebPage.Templates.PageCaption.GetPageCaptions(, "Discussion Thread", "Article : " + strArticleName)
                WebPage.Templates.PageCaption.GetPageCaptions(, "Discussion Thread", "Article : " + HttpUtility.HtmlEncode(strArticleName))
                'End of Commented And Added By Bharat T on 24th-nov-2015 for SEM Upgrade Project module issue solving
                CommonFunction.General.WriteHTML("<BR>")


                Call plotScreenForDiscussion(m_lngProcedureID)

            Case CONST_HISTORY
                If m_strAction.ToUpper = "ROLLBACK" Then
                    Call performRollBack()
                End If
                Call showHistoryScreen(m_lngProcedureID)

            Case "EditHistory"
                Call showHistoryDetailsScreen(m_lngProcedureID)

        End Select
        'draw lower menu
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML(strMenu)


        ''Added by Dhanashri S on 29 Mar 2016
        'If (Request.QueryString("PKCommentToken") <> "" And Request.QueryString("ProcedureID") <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProcedureID"), String) + "0" + "0", Request.QueryString("PKCommentToken")) = False) Then

        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("ProcedureID"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        ' ''End of Addition by Dhanashri S on 29 MAr 2016

        ' ''Added by Dhanashri S on 29 Mar 2016
        'If (Request.QueryString("PKDiscussionToken") <> "" And Request.QueryString("ProcedureID") <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProcedureID"), String) + "0" + "0", Request.QueryString("PKDiscussionToken")) = False) Then

        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("ProcedureID"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        ' ''End of Addition by Dhanashri S on 29 MAr 2016
        ' ''Added By Vidya J On 29 Mar 2016
        'If (Request.QueryString("PKToken") <> "" And Request.QueryString("ProcedureID") <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProcedureID"), String), Request.QueryString("PKToken")) = False) Then

        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("ProcedureID"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        ''End Of Addtion By Vidya J On 26 Mar 2016
    End Sub
    Private Sub performRollBack()

        Dim strSQL As String
        Dim drPageDetails As IDataReader

        Dim strTitle As String = ""
        Dim strContents As String = ""
        Dim strLabels As String = ""
        Dim strSynopsis As String = ""
        Dim strEditUserIDs As String = ""
        Dim strViewUserIDs As String = ""
        Dim RestrictView As Boolean = False
        Dim RestrictEdit As Boolean = False

        strSQL = "usp_sel_tbl_KM_CodeHeadings_History " & m_lngProcedureID.ToString & "," & m_strVersionID

        drPageDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
        If drPageDetails.Read Then
            strTitle = drPageDetails("ProcedureTitle")
            strSynopsis = CommonFunction.Data.CheckIsDBNull(drPageDetails("Synopsis"), "")
            strLabels = CommonFunction.Data.CheckIsDBNull(drPageDetails("Keywords"), "")
            strContents = CommonFunction.Data.CheckIsDBNull(drPageDetails("ProcedureCode"), "")
            m_strVersionID = CommonFunction.Data.CheckIsDBNull(drPageDetails("ProcedureID"), "0")

            RestrictView = IIf(drPageDetails("RestrictViewAccess") Is DBNull.Value, False, drPageDetails("RestrictViewAccess"))
            RestrictEdit = IIf(drPageDetails("RestrictEditAccess") Is DBNull.Value, False, drPageDetails("RestrictEditAccess"))
        End If

        CommonFunction.Data.DisposeDataReader(drPageDetails)

        strTitle = strTitle.Replace("'", "''")
        strContents = strContents.Replace("'", "''")
        strLabels = strLabels.Replace("'", "''")
        strSynopsis = strSynopsis.Replace("'", "''")
        strSQL = " usp_Upd_tbl_KM_CodeHeadings_RollBack " & m_lngProcedureID.ToString & "," & Session("intUserID").ToString & ",N'" & strTitle & "',N'" & strContents & "',N'" & strLabels & "','" & strSynopsis & "'"
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

        CommonFunction.General.WriteHTML("<script language='javascript'>")
        CommonFunction.General.WriteHTML(" window.close(); ")

        If m_From = "KA" Then
            CommonFunction.General.WriteHTML(" window.opener.location.href= '../General/CommonList.aspx?MasterTagID=3992' ; ")
        Else
            CommonFunction.General.WriteHTML(" window.opener.location.href= '../KM/KM_MyPage.aspx?PageNumber=&txtSearch=&Fromwhere=Search&Mode=Edit&Myflag=2&EditClick=1&SpaceID=0&ActionLink=&PrimaryKey=&PageID=" & m_lngProcedureID.ToString & "'; ")
        End If

        CommonFunction.General.WriteHTML("</script>")


    End Sub
    Private Sub InitPage()
        Dim strflag As String

        strflag = Request.QueryString("PageTitle")

        Select Case strflag
            Case "1"
                m_strPageTitle = "Discussion Thread"
            Case "2"
                m_strPageTitle = "Versions"
        End Select

    End Sub
    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
        CommonFunction.General.WriteHTML("<LINK href='tabcontent.css' type=text/css rel=stylesheet>")
    End Sub

    Private Sub plotScreenForDiscussion(ByVal lngProcedureID As Long)
        Dim strSQL As String
        Dim strDate As String
        Dim strComments As String
        Dim strCurrentHours As String
        Dim strCurrentTime As String


        'get the current date 
        strDate = CommonFunctions.Dates.CGetDateTime(Date.Now) + ""

        If m_strAction = "" Then
            strComments = Request.Form("txtComments") + ""
        Else
            strComments = ""
        End If

        'plot the controls
        CommonFunction.General.WriteHTML("<Div id='DivBody' width=100% height=90% style='overflow: auto;' >")
        CommonFunction.General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0 >")

        'display user Name
        CommonFunction.General.WriteHTML("<TR class='clsTREven' >")
        CommonFunction.General.WriteHTML("<TD align='right' width=30% >User Name &nbsp;</TD>")
        CommonFunction.General.WriteHTML("<TD align='left'>" + m_strUserName.Trim + "</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        'display date
        CommonFunction.General.WriteHTML("<TR class='clsTREven' >")
        CommonFunction.General.WriteHTML("<TD align='right'>Date &nbsp;</TD>")
        CommonFunction.General.WriteHTML("<TD align='left'>" + strDate.Trim + "</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        'display the textarea for comments
        CommonFunction.General.WriteHTML("<TR class='clsTREven' >")
        CommonFunction.General.WriteHTML("<TD align='right' valign='top' > Comments &nbsp;</TD>")
        CommonFunction.General.WriteHTML("<TD align='left'>")

        ''commented and added by RohiniK on 10 Nov 09
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextArea("txtComments", "txtComments", , , , "frmKMDiscussion", , , 380, 100, 7000, strComments.Trim, , , , , , , , True, True) + "</TD>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextArea("txtComments", "txtComments", , , , "frmKMDiscussion", , , 380, 100, 7000, strComments.Trim, , , , , , , "onchange='ShowLength()' onKeyUp='ShowLength()'", True, True) + "</TD>")
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextArea("txtComments", "txtComments", , , , "frmKMDiscussion", , , 380, 100, 7000, strComments.Trim, , , , , , , "onchange='ShowLength()' onKeyUp='ShowLength()'", True, True, EnableHTMLEncode:=True) + "</TD>")
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''end of comment and addition by RohiniK on 10 Nov 09
        CommonFunction.General.WriteHTML("</TR>")

        ''added by RohiniK on 10 Nov 09
        CommonFunction.General.WriteHTML("<TR class='clsTREven'><TD></TD><TD align='left'>")
        CommonFunction.General.WriteHTML("<span valign='top' id='Spnlength'>0</span> of 7000 chars are entered")
        CommonFunction.General.WriteHTML("</span>")
        CommonFunction.General.WriteHTML("</TD></TR>")
        ''end of addition by RohiniK on 10 Nov 09

        CommonFunction.General.WriteHTML("</Table>")
        CommonFunction.General.WriteHTML("<BR>")

        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strToken, , , , , , , , , , , , True, ))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strToken, , , , , , , , , , , , True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'plot the grid for previous comments
        Dim arrColHeader() As String = {"User Name", "Date", "Comments"}
        Dim arrAN() As String = {"UserName", "DiscussionDate", "Comments"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        strSQL = "Exec usp_Sel_tbl_KM_Discussion " + m_lngProcedureID.ToString
        With m_objGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 200
            ''Commented and Added by Dhanashri S on 3 Dec 2015 For IssueID:2573
            ''.DIVStyle = "overflow:auto; width:100% ;"
            .DIVStyle = "overflow:auto; width:100% ; height:260px !important"
            ''End of Comment and Addition by Dhanashri S
            .NoOfDataColumns = 3
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .EmptyValueReplacement = "-"
            .SQL = strSQL
            .UseSQL = True
            'plot the grid 
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            .DrawGrid()
        End With
        m_objGrid = Nothing

        CommonFunction.General.WriteHTML("</Div>")

    End Sub
    Private Sub performDiscussionThreadAction(ByVal lngProcedureID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strDate As String
        Dim strComments As String
        Dim blnSendEMail As Boolean
        Dim blnDisplayMsg As Boolean
        Dim strFromEmailID As String
        Dim strToEmailID As String
        Dim strSubject As String
        Dim strEmailMsg As String
        Dim strCCToEmailId As String

        'get values from the page cotrols
        strComments = Request.Form("txtComments") + ""

        Select Case m_strAction
            Case CONST_ACTION_SAVE
                'insert new record for discussion comments
                strSQL = "Usp_Ins_tbl_KM_Discussion " + lngProcedureID.ToString + ",'" + CommonFunction.General.BuildQueryString(m_strUserName.Trim) + "','" + CommonFunction.General.BuildQueryString(strComments.Trim) + "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)

                'Added by AbhijeetC on 11 Nov 2009
                CommonFunction.General.WriteHTML("<script language='javascript'>")
                CommonFunction.General.WriteHTML(" window.close(); ")

                If m_FromWhere.ToUpper = "LATESTFEATURED" Then
                    CommonFunction.General.WriteHTML(" window.opener.location.href= '../KM/KM_List.aspx?Fromwhere=LatestFeatured&SelectedList=1&SelectList=1' ; ")
                ElseIf m_FromWhere.ToUpper = "DISCUSSION" Then
                    'Commented And Added By Usha Pandit On 29.07.2020 For redirection issue
                    'UnCommented By Reshm chavan On 22.09.2021 For redirection issue
                    CommonFunction.General.WriteHTML(" window.opener.location.href= '../KM/KM_PageView.aspx?ActionLink=&Fromwhere=Search&Mode=Edit&txtSearch=&PageID=" & m_lngProcedureID.ToString & "' ; ")
                    'CommonFunction.General.WriteHTML(" window.opener.location.href= '../KM/KM_MYPAGE.ASPX?MODE=EDIT&From=KA&Myflag=0&PageID=" & m_lngProcedureID.ToString & "' ; ")
                    'End Of Added By Usha Pandit On 29.07.2020 For redirection issue
                ElseIf m_FromWhere.ToUpper = "TOPTEN" Then
                    CommonFunction.General.WriteHTML(" window.opener.location.href= '../KM/KM_List.aspx?Fromwhere=TopTen&SelectedList=2&SelectList=2' ; ")
                ElseIf m_FromWhere.ToUpper = "MYARTICLE" Then
                    CommonFunction.General.WriteHTML(" window.opener.location.href= '../KM/KM_List.aspx?PageNumber=1&Fromwhere=MyArticle&SelectedList=4&SelectList=4&Tab=MY&SubTab=My Pages' ; ")
                ElseIf m_FromWhere.ToUpper = "KA" Then
                    CommonFunction.General.WriteHTML(" window.opener.location.href= '../KM/KM_MYPAGE.ASPX?MODE=EDIT&From=KA&Myflag=0&PageID=" & m_lngProcedureID.ToString & "' ; ")
                End If

                CommonFunction.General.WriteHTML("</script>")
                'End of Addition by AbhijeetC on 11 Nov 2009
        End Select


    End Sub

    Private Sub showHistoryScreen(ByVal lngProcedureID As Long)
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strsql As String
        Dim drArticle As IDataReader
        Dim strCreator As String
        Dim strQuery As String
        Dim drHistory As IDataReader

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        arrMenu.Add("Close") : arrMenuToolTip.Add("Close") : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add("?") : arrMenuToolTip.Add("Help") : arrClientSideFunctions.Add("Help_OnClick('KM_VERSIONS')")

        ' copy all the element to string array
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
        CommonFunction.General.WriteHTML(strMenu)
        CommonFunction.General.WriteHTML("<BR>")

        'draw page caption 
        strsql = "usp_Sel_tbl_KM_CodeHeadings_My NULL," + CType(m_lngProcedureID, String)
        drArticle = CommonFunction.Data.GetDataReader(strsql, True)
        If drArticle.Read Then
            strCreator = CType(CommonFunction.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID = " + drArticle("ProgrammerID").ToString, True), String)
            'Commented and Added By Bharat T on 1st-Dec-2015
            'WebPage.Templates.PageCaption.GetPageCaptions(, "Versions", " " + drArticle("ProcedureTitle").ToString + " by (" + strCreator + ")")
            WebPage.Templates.PageCaption.GetPageCaptions(, "Versions", " " + HttpUtility.HtmlEncode(drArticle("ProcedureTitle")).ToString + " by (" + strCreator + ")")
            'End of Commented and Added By Bharat T on 1st-Dec-2015
        End If

        CommonFunction.Data.DisposeDataReader(drArticle)

        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<Div id='DivBody' width=100% height=90% style='overflow: auto;' >")

        Dim IsPresent As String
        IsPresent = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT 1 FROM tbl_KM_CodeHeadings_History WHERE ArticleID =" + m_lngProcedureID.ToString, True), "0"), String)
        strQuery = "usp_sel_tbl_KM_CodeHeadings_History " + CType(m_lngProcedureID, String) + ",NULL"

        If IsPresent = "1" Then
            Dim arrColHeader() As String = {"Version No", "Modified By", "Modified Date", "Get This Version"}
            Dim arrAN() As String = {"ProcedureID", "ModifiedBy", "ModifiedDate", ""}
            Dim arrRowLink() As String = {"Version_OnClick(ArticleID,ProcedureID)", "", "", "Rollback_OnClick(ArticleID,ProcedureID)"}
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            Dim arrIgnoreHtml() As String = {"0"}
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            With m_objGrid_History
                .ActualColumnArray = arrAN
                .UserFriendlyColumnArray = arrColHeader
                .RowLinkArray = arrRowLink
                .ColNameToolTipOnEachRow = True
                .DIVID = "DivList"
                .DIVHeight = 400 '200 '' modified by RohiniK on 10 Nov 09
                ''Commented and Added by Dhanashri S on 3 Dec 2015 For IssueID:2573
                ''.DIVStyle = "overflow:auto; width:100% ;"
                .DIVStyle = "overflow:auto; width:100% ; height:560px !important"
                ''End of Comment and Addition by Dhanashri S on 3 Dec 2015
                .NoOfDataColumns = 3
                .PrinterFriendlyVersion = False
                .VerticalDisplay = False
                .ColNameToolTipOnEachRow = True
                .returnHTML = False
                .EmptyValueReplacement = "-"
                .SQL = strQuery
                .UseSQL = True
                'plot the grid 
                'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                .IgnoreHTMLEncode = arrIgnoreHtml
                'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

                .DrawGrid()
            End With
            m_objGrid_History = Nothing
        Else
            CommonFunction.General.WriteHTML("<Table class='clsGridTable' cellpadding=0 cellspacing=1 width='99.9%'>")

            strQuery = "SELECT * FROM tbl_KM_CodeHeadings WHERE ProcedureID = " + CType(m_lngProcedureID, String)
            drHistory = CommonFunction.Data.GetDataReader(strQuery, True)

            If drHistory.Read Then
                strCreator = ""
                strCreator = CType(CommonFunction.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID = " + drHistory("ProgrammerID").ToString, True), String)

                CommonFunction.General.WriteHTML("<THead class='clsTRColumnHeader' >")
                CommonFunction.General.WriteHTML("<TH  class='divListTag' align='right' width=30% >Version No</TH>")
                CommonFunction.General.WriteHTML("<TH  class='divListTag' align='left'>Created By</TH>")
                CommonFunction.General.WriteHTML("<TH  class='divListTag' align='left' valign='top' >Created Date</TH>")
                CommonFunction.General.WriteHTML("</THead>")

                CommonFunction.General.WriteHTML("<TR class='clsTREven' >")
                CommonFunction.General.WriteHTML("<TD align='right'><A href='Javascript:Version_OnClick(" + drHistory("ProcedureID").ToString + ",0)'>0</A></TD>")
                CommonFunction.General.WriteHTML("<TD align='left'> " + Server.HtmlEncode(strCreator) + " </TD>")
                CommonFunction.General.WriteHTML("<TD align='left'>" + drHistory("DateCreated").ToString + "</TD>")
                CommonFunction.General.WriteHTML("</TR>")
            End If

            CommonFunction.Data.DisposeDataReader(drHistory)

            CommonFunction.General.WriteHTML("</Table>")
        End If
        CommonFunction.General.WriteHTML("</Div>")
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML(strMenu)
    End Sub

    Private Sub showHistoryDetailsScreen(ByVal lngProcedureID As Long)
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strsql As String
        Dim drArticle As IDataReader
        Dim strCreator As String
        Dim strQuery As String = ""
        Dim drHistory As IDataReader

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        arrMenu.Add("Back") : arrMenuToolTip.Add("Back") : arrClientSideFunctions.Add("Back_OnClick()")
        arrMenu.Add("Close") : arrMenuToolTip.Add("Close") : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add("?") : arrMenuToolTip.Add("Help") : arrClientSideFunctions.Add("Help_OnClick()")

        ' copy all the element to string array
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
        CommonFunction.General.WriteHTML(strMenu)
        CommonFunction.General.WriteHTML("<BR>")

        'draw page caption 
        strsql = "usp_Sel_tbl_KM_CodeHeadings_My NULL," + CType(m_lngProcedureID, String)
        drArticle = CommonFunction.Data.GetDataReader(strsql, True)
        If drArticle.Read Then
            strCreator = CType(CommonFunction.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID = " + drArticle("ProgrammerID").ToString, True), String)
            WebPage.Templates.PageCaption.GetPageCaptions(, "Versions", " " + drArticle("ProcedureTitle").ToString + " by (" + strCreator + ")")
        End If

        CommonFunction.Data.DisposeDataReader(drArticle)

        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<Div id='DivBody' width=100% height=90% style='overflow: auto;' >")
        CommonFunction.General.WriteHTML("<Table class='clsGridTable' cellpadding=0 cellspacing=1 width='99.9%'>")

        strQuery = "usp_sel_tbl_KM_CodeHeadings_History " + CType(m_lngProcedureID, String)
        drHistory = CommonFunction.Data.GetDataReader(strQuery, True)

        If drHistory.Read Then
            'display Article name
            CommonFunction.General.WriteHTML("<TR class='clsTRColumnHeader' >")
            CommonFunction.General.WriteHTML("<TD align='right' width=30% >Article Name</TD>")
            'display synopsis
            CommonFunction.General.WriteHTML("<TD align='right'>Synopsis</TD>")
            'display article content
            CommonFunction.General.WriteHTML("<TD align='right' valign='top' >Article Content</TD>")
            'display keywords
            CommonFunction.General.WriteHTML("<TD align='right' valign='top' >Keywords</TD>")
            CommonFunction.General.WriteHTML("</TR>")

            CommonFunction.General.WriteHTML("<TR class='clsTREven' >")
            CommonFunction.General.WriteHTML("<TD align='left'>" + Server.HtmlEncode(drHistory("ProcedureTitle").ToString) + "</TD>")
            CommonFunction.General.WriteHTML("<TD align='left'>" + Server.HtmlEncode(drHistory("Synopsis").ToString) + "</TD>")
            CommonFunction.General.WriteHTML("<TD align='left'>" + Server.HtmlEncode(drHistory("ProcedureCode").ToString) + "</TD>")
            CommonFunction.General.WriteHTML("<TD align='left'>" + Server.HtmlEncode(drHistory("Keywords").ToString) + "</TD>")

            CommonFunction.General.WriteHTML("</TR>")
        End If

        CommonFunction.General.WriteHTML("</Table>")
        CommonFunction.General.WriteHTML("</Div>")
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML(strMenu)

        CommonFunction.Data.DisposeDataReader(drHistory)

    End Sub



    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "DATE" Then
            Cancel = True
            Args.StringToBeInserted = "<td  vAlign=top title=""Date"">" + CommonFunctions.Dates.CGetDateTime(Args.DataReader("DiscussionDate").ToString) + "</td>"
        End If
    End Sub

    Private Sub m_objGrid_History_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid_History.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "GET THIS VERSION" Then
            Cancel = True
            Args.StringToBeInserted = "<td><a href='Javascript:Rollback_OnClick(" + Args.DataReader("ArticleID").ToString + "," + Args.DataReader("ProcedureID").ToString + ")'>Get This Version</a></td>"
        End If
    End Sub
    'Added By Chakshuta H on 11th-Aug-2016 
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateVersionToken(PageID As String, EmployeeId As String, VersionID As String) As String
        Try
            Dim m_PKToken_Article As String
            m_PKToken_Article = CommonFunctions.Security.Token.GetToken(CType(PageID, String) + CType(EmployeeId, String) + "0" + "0" + CType(VersionID, String))

            Return m_PKToken_Article
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    'End Of Added By Chakshuta H on 11th-Aug-2016 
End Class
