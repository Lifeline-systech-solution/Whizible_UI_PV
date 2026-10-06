Public Class KM_PageView
    Inherits WebPages.Template.WhizTemplate
#Region " Global Variables "
    Protected m_strPageTitle As String = ""
    Private m_intPageID As Integer = 0
    Protected m_strPageSubject As String = "My Page"
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_lngUserId As Long = 0
    Private m_lngPostId As Long = 0
    Protected m_strFromWhere As String = ""
    Protected m_strtxtSearch As String = ""
    Protected m_strmode As String = ""
    Protected m_strPagingNumber As String = ""
    Protected m_strSpaceID As String
    Protected m_strActionLink As String
    Protected m_PKToken_PageOnClick As String
    ''Added By Chakshuta H on 11th-Aug-2016
    Private m_blnValidate As Boolean = True
    ''End of Added By Chakshuta H on 11th-Aug-2016
#End Region
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
    ''Added By Chakshuta H on 11th-Aug-2016  to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken(ArticleID As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(ArticleID, String) + CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''Added by Vidya J on 29-Mar-2016  to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateEditToken(SpaceID As String, EmployeeID As String, PageID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(SpaceID, String) + CType(EmployeeID, String) + "0" + "0" + CType(PageID, String))

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''Added by NILESH G ON 24/8/2016   to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateEditToken1(SpaceID As String, EmployeeID As String, PageID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(PageID, String) + CType(EmployeeID, String) + "0" + "0" + CType(SpaceID, String))

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Vidya J on 29-Mar-2016
    ''End of Added By Chakshuta H on 11th-Aug-2016
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        InitPage()
    End Sub

    Private Sub InitPage()
        m_strPageTitle = "Article"
        m_strPageSubject = "My Page"
        If Not Request("PageID") Is Nothing Then
            m_intPageID = CInt(Request("PageID"))
        End If

        m_lngUserId = Session("intUserID")
        m_lngPostId = Session("intPostID")

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Fromwhere"), "") <> "" Then
            m_strFromWhere = Request.QueryString("Fromwhere")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidFromwhere"), "") <> "" Then
            m_strFromWhere = Request.Form("hidFromwhere")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("txtSearch"), "") <> "" Then
            m_strtxtSearch = Request.QueryString("txtSearch")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtSearch"), "") <> "" Then
            m_strtxtSearch = Request.Form("hidtxtSearch")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") <> "" Then
            m_strmode = Request.QueryString("Mode")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidMode"), "") <> "" Then
            m_strmode = Request.Form("hidMode")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("PageNumber"), "") <> "" Then
            m_strPagingNumber = Request.QueryString("PageNumber")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtPageNumber"), "") <> "" Then
            m_strPagingNumber = Request.Form("hidtxtPageNumber")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("SpaceID"), "") <> "" Then
            m_strSpaceID = Request.QueryString("SpaceID")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidSpaceID"), "") <> "" Then
            m_strSpaceID = Request.Form("hidSpaceID").ToString
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("ActionLink"), "") <> "" Then
            m_strActionLink = Request.QueryString("ActionLink")
        End If
        ''Added By Vidya J On 29-Mar-2016
        'If Not Request.QueryString("PkToken") Is Nothing Then
        '    m_PKToken_PageOnClick = Request.QueryString("PkToken").ToString
        'End If

        'If m_PKToken_PageOnClick <> "" And m_strSpaceID = 0 Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngUserId, String) + CType(m_strSpaceID, String) + CType(m_intPageID, String) + CType(0, String) + CType(0, String), m_PKToken_PageOnClick) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_intPageID, String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If

        'If m_PKToken_PageOnClick <> "" And m_strSpaceID <> 0 Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngUserId, String) + CType(m_strSpaceID, String) + CType(m_intPageID, String) + CType(0, String) + CType(0, String), m_PKToken_PageOnClick) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_intPageID, String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        ''End Of Added By Vidya J On 29-Mar-2016
        ''Commented and added by Nilesh g on 11/11/2016 Purpose:Issue Fixing 
        'Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
        'If (Request.QueryString("FromWhere")) = "MyTeam" Then
        '    'If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID").ToString <> "0") And Request.QueryString("Action") <> "SAVE" Then
        '    '    m_blnValidate = False
        '    'Else
        '    If Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("SpaceID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0" + CType(Request.QueryString("PageID"), String), Request.QueryString("PKToken")) = False) Then
        '        m_blnValidate = False
        '    End If
        '    If m_blnValidate = False Then
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        'End Of Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
        ''end of Commented and added by Nilesh g on 11/11/2016 Purpose:Issue Fixing 
    End Sub
    Public Sub WritePage()
        Dim strSQL As String
        Dim drPageDetails As IDataReader
        Dim strContents As String
        Dim strLabels As String = ""
        Dim strMenu As String = ""
        'Addition by SuchitraP on 25-Aug-2008 to display edit link only if that user has Edit Access for that article
        Dim strEditAccess As String
        Dim strProgrammerID As String
        Dim drEditAccess As IDataReader
        Dim strAuthor As String
        'End of addition by SuchitraP

        Dim strAttachments As String
        Dim PKToken_ProcedureID As String
        Dim strRating As String
        Dim counter As Integer
        Dim flag As Integer
        Dim strRatingNew As String
        Dim tempRating As Double
        'Addded by AbhijeetC on 11 Nov 2009
        Dim intNoOfDiscusions As Integer

        ' strMenu = InitializeMenu()
        'CommonFunctions.General.WriteHTML(strMenu)
        ' PlotPageLegend()


        If m_intPageID <> 0 Then
            strSQL = "usp_Sel_tbl_KM_CodeHeadings_My Null," & m_intPageID.ToString
            drPageDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drPageDetails.Read Then
                ' Commented And Added By Bharat T on 24th-nov-2015 for SEM Upgrade Project module issue solving
                'm_strPageSubject = drPageDetails("ProcedureTitle")
                'strContents = CommonFunction.Data.CheckIsDBNull(drPageDetails("ProcedureCode"), "")
                m_strPageSubject = HttpUtility.HtmlEncode(drPageDetails("ProcedureTitle"))
                'strContents = HttpUtility.HtmlEncode(CommonFunction.Data.CheckIsDBNull(drPageDetails("ProcedureCode"), ""))
                strContents = CommonFunction.Data.CheckIsDBNull(drPageDetails("ProcedureCode"), "")
                'End of Commented And Added By Bharat T on 24th-nov-2015 for SEM Upgrade Project module issue solving
                strLabels = CommonFunction.Data.CheckIsDBNull(drPageDetails("Keywords"), "")
                strAuthor = CommonFunction.Data.CheckIsDBNull(drPageDetails("Author"), "")
                'Addded by AbhijeetC on 11 Nov 2009
                intNoOfDiscusions = CommonFunction.Data.CheckIsDBNull(drPageDetails("NoOfDiscussions"), "")
                'End of addition by AbhijeetC on 11 Nov 2009
            End If
            CommonFunction.Data.DisposeDataReader(drPageDetails)
        End If

       
        'CommonFunctions.General.WriteHTML("<Tr class=clsTREven> <td>Title</td>")
        'CommonFunctions.General.WriteHTML("<td  >" & m_strPageSubject & "</td></tr>")
        'Addition by SuchitraP on 25-Aug-2008 to display edit link only if that user has Edit Access for that article
        strSQL = ""
        strSQL = "usp_Get_EditAccess " + m_intPageID.ToString + "," + m_lngUserId.ToString
        drEditAccess = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drEditAccess.Read() Then
            strEditAccess = drEditAccess("IsPresent").ToString
        End If

        If drEditAccess.NextResult() Then
            If drEditAccess.Read() Then
                strProgrammerID = drEditAccess("ProgrammerID").ToString
            End If
        End If

        CommonFunction.Data.DisposeDataReader(drEditAccess)
        Response.Write("<TABLE class='clsTable' width=100%>")
        Response.Write("<TR class='clsTRMenu'><TD align=right >")

        If strEditAccess = "1" Or strProgrammerID = m_lngUserId.ToString Then
            Response.Write("<A class='Menu' id='Edit' HREF=""Javascript:Edit_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Edit"" >Edit</A> | ")
            ''Else
            ''    Response.Write("<A class='Menu' id='Edit' HREF=""Javascript:Edit_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Edit"" >Edit</A> | ")
        End If

        'If m_strFromWhere.ToUpper <> "MYSPACE" And m_strFromWhere.ToUpper <> "MYSPACEEDIT" And m_strFromWhere.ToUpper <> "SEARCH" And m_strFromWhere.ToUpper <> "MYTEAMEDIT" And m_strFromWhere.ToUpper <> "MYTEAM" Then
        '    Response.Write("&nbsp;&nbsp;&nbsp;<A id='Back' HREF=""Javascript:Back_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Back"" ><B>Back</B></A>")
        'End If

        'If m_strmode.ToUpper = "VIEW" And m_strFromWhere.ToUpper <> "SEARCH" And m_strFromWhere.ToUpper <> "MYTEAMEDIT" And m_strFromWhere.ToUpper <> "MYTEAM" And m_strFromWhere.ToUpper <> "MYSPACEEDIT" Then
        '    Response.Write("&nbsp;&nbsp;&nbsp;<A id='Back' HREF=""Javascript:Back_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Back"" ><B>Back</B></A>")
        'ElseIf m_strmode.ToUpper = "EDIT" And m_strFromWhere.ToUpper = "SEARCH" Then
        '    Response.Write("&nbsp;&nbsp;&nbsp;<A id='Back' HREF=""Javascript:Back_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Back"" ><B>Back</B></A>")
        'End If

        'If m_strFromWhere.ToUpper = "MYSPACEEDIT" Then
        '    Response.Write("&nbsp;&nbsp;&nbsp;<A id='Close' HREF=""Javascript:Close_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Close"" ><B>Close</B></A>")
        'ElseIf m_strFromWhere.ToUpper = "SEARCH" And m_strmode.ToUpper <> "EDIT" Then
        '    Response.Write("&nbsp;&nbsp;&nbsp;<A id='Close' HREF=""Javascript:Close_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Close"" ><B>Close</B></A>")
        'ElseIf m_strFromWhere.ToUpper = "MYTEAMEDIT" Then
        '    Response.Write("&nbsp;&nbsp;&nbsp;<A id='Close' HREF=""Javascript:Close_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Close"" ><B>Close</B></A>")
        'ElseIf m_strFromWhere.ToUpper = "MYTEAM" Then
        '    Response.Write("&nbsp;&nbsp;&nbsp;<A id='Close' HREF=""Javascript:Close_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Close"" ><B>Close</B></A>")
        'End If

        If m_strFromWhere.ToUpper = "TOPTEN" Then
            Response.Write("<A class='Menu' id='Back' HREF=""Javascript:Back_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Back"" >Back</A>")
        ElseIf m_strFromWhere.ToUpper = "SEARCH" And (m_strSpaceID Is Nothing Or m_strSpaceID = "NULL") Then
            Response.Write("<A class='Menu' id='Back' HREF=""Javascript:Back_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Back"" >Back</A>")
        ElseIf m_strFromWhere.ToUpper = "SEARCH" And m_strSpaceID = "0" Then
            Response.Write("<A class='Menu' id='Close' HREF=""Javascript:Close_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Close"" >Close</A>")
        ElseIf m_strFromWhere.ToUpper = "MYSPACE" And m_strSpaceID Is Nothing Then
            Response.Write("<A class='Menu' id='Back' HREF=""Javascript:Back_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Back"" >Back</A>")
        ElseIf m_strFromWhere.ToUpper = "MYSPACEEDIT" Then
            Response.Write("<A class='Menu' id='Close' HREF=""Javascript:Close_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Close"" >Close</A>")
        ElseIf m_strFromWhere.ToUpper = "MYTEAM" Then
            Response.Write("<A class='Menu' id='Close' HREF=""Javascript:Close_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Close"" >Close</A>")
        ElseIf m_strFromWhere.ToUpper = "MYARTICLE" Then
            Response.Write("<A class='Menu' id='Back' HREF=""Javascript:Back_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Back"" >Back</A>")
        ElseIf m_strFromWhere.ToUpper = "LATESTFEATURED" Then
            Response.Write("<A class='Menu' id='Back' HREF=""Javascript:Back_OnClick(" + m_intPageID.ToString + ",'" + m_strFromWhere + "')"" Title=""Back"" >Back</A>")

        End If

        Response.Write("</TD></TR>")
        Response.Write("</TABLE>")
        Response.Write("<br>")

        '  Response.Write("<DIV Id=divMain Style='HEIGHT:99.99%; WIDTH:100%'>")
        'Commented by Shamkant S on 16 Nov
        'Commented And Added By Vaijat K ON 03/12/2015 IssueID-2597
        'Response.Write("<DIV Id=divMain Style='WIDTH:100%;overflow:auto;Position:absolute'>")
        Response.Write("<DIV Id=divMain Style='WIDTH:100%;overflow:auto'>")
        'Ended
        Response.Write("<TABLE class='clsTable' border='0' CellSpacing='0' CellPadding=0  width=100%>")
        'End of addition by SuchitraP
        'strAuthor = CommonFunction.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee E INNER JOIN tbl_KM_CodeHeadings CH ON E.EmployeeID = CH.ProgrammerID WHERE ProcedureID =" + m_intPageID.ToString, MyBase.UseSQL)

        'Response.Write("<TR class=clsTREven><TD align=center style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;'><b> Article Name : </b> " & m_strPageSubject & " <br> by " + strAuthor + " </TD></TR>")
        'Added By Chakshuta H on 11th-Aug-2016
        'PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(m_intPageID.ToString)
        PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(m_intPageID.ToString + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
        'End Of Added By Chakshuta H on 11th-Aug-2016

        strAttachments = CommonFunction.Data.GetDataScalar("IF EXISTS(SELECT ProcedureID FROM tbl_KM_Attachments WHERE ProcedureID = " + m_intPageID.ToString + ") SELECT 1", True)
        'Commented and Modified by AbhijeetC on 11 Nov 2009
        'If strAttachments = "1" Then
        '    Response.Write("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left ><A title='Attachment' href=""JavaScript:Document_OnClick('" + m_intPageID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Attachment.gif'></A>&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + m_intPageID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><b> Article Name : </b> " & m_strPageSubject & " <br> by " + strAuthor + "</TD>")
        'Else
        '    Response.Write("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left >&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + m_intPageID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><b> Article Name : </b> " & m_strPageSubject & " <br> by " + strAuthor + "</TD>")
        'End If

        If strAttachments = "1" Then
            If Trim(intNoOfDiscusions.ToString & "") <> "" And Trim(intNoOfDiscusions.ToString & "") <> "0" Then
                Response.Write("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left ><A title='Attachment' href=""JavaScript:Document_OnClick('" + m_intPageID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Attachment.gif'></A>&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + m_intPageID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'>(" + intNoOfDiscusions.ToString + ")</A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><b> Article Name : </b> " & m_strPageSubject & " <br> by " + strAuthor + "</TD>")
            Else
                Response.Write("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left ><A title='Attachment' href=""JavaScript:Document_OnClick('" + m_intPageID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Attachment.gif'></A>&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + m_intPageID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><b> Article Name : </b> " & m_strPageSubject & " <br> by " + strAuthor + "</TD>")
            End If
        Else
            If Trim(intNoOfDiscusions.ToString & "") <> "" And Trim(intNoOfDiscusions.ToString & "") <> "0" Then
                Response.Write("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left >&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + m_intPageID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'>(" + intNoOfDiscusions.ToString + ")</A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><b> Article Name : </b> " & m_strPageSubject & " <br> by " + strAuthor + "</TD>")
            Else
                Response.Write("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left >&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + m_intPageID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><b> Article Name : </b> " & m_strPageSubject & " <br> by " + strAuthor + "</TD>")
            End If
        End If

        'End of Comment and Modification by Abhijeetc on 11 Nov 2009

        strRating = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT AVG(Rating) AS Rating FROM tbl_KM_ArticleRating WHERE ProcedureID=" + m_intPageID.ToString, True), "")
        'End If

        If strRating.LastIndexOf(".") <> "-1" Then
            strRatingNew = strRating.Substring(0, strRating.LastIndexOf("."))
        Else
            strRatingNew = strRating
        End If

        If strRating <> "" Then
            Response.Write("<TD style='width:10%;' style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=right>Rating&nbsp;</TD>")

            For counter = 0 To 5
                If CType(strRatingNew, Integer) <> counter Then
                    Response.Write("<TD style='width:1%;' align=left>")
                    Response.Write("<img id='imgstaron'  SRC=""../../Images/star_on.gif"" BORDER=""0""  width=""16"" height=""16"">")
                    Response.Write("</TD>")
                Else
                    tempRating = CType(strRating, Double) - CType(strRatingNew, Double)
                    If tempRating < 0.5 And tempRating <> 0.0 Then
                        Response.Write("<TD style='width:1%;' align=left>")
                        Response.Write("<img id='imgstaron'  SRC=""../../Images/starl5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                        Response.Write("</TD>")
                    ElseIf tempRating = 0.5 Then
                        Response.Write("<TD style='width:1%;' align=left>")
                        Response.Write("<img id='imgstaron'  SRC=""../../Images/stare5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                        Response.Write("</TD>")
                    ElseIf tempRating > 0.5 Then
                        Response.Write("<TD style='width:1%;' align=left>")
                        Response.Write("<img id='imgstaron'  SRC=""../../Images/starg5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                        Response.Write("</TD>")
                    ElseIf tempRating = 0.0 And CType(strRating, Double) <> 5.0 Then
                        Response.Write("<TD style='width:1%;' align=left>")
                        Response.Write("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                        Response.Write("</TD>")
                    End If
                    flag = strRatingNew + 2
                    Exit For
                End If
            Next

            For counter = flag To 5
                Response.Write("<TD style='width:1%;' align=left>")
                Response.Write("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                Response.Write("</TD>")
            Next
        Else
            'Response.Write("<TD style='width:15%;' colspan=6 align=right>&nbsp;</TD>")
            Response.Write("<TD style='width:10%;' align=right><font style='width:10%;' style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;'> Rating&nbsp;</font></TD>")
            For counter = 0 To 4
                Response.Write("<TD style='width:1%;' align=left>")
                Response.Write("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                Response.Write("</TD>")
            Next
        End If

        Response.Write("<TD style='width:10%;' nowrap align=left>&nbsp;<a class='clsLinkChildNavMenu' href='Javascript:RateArticle(" + m_intPageID.ToString + ")'>Rate Article</a></TD>")

        Response.Write("</TR>")


        Response.Write("<TR ><TD style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' colspan=9>" & strContents & "</TD></TR>")
        'Response.Write("<TR><TD class=clsTDHelp>" & strLabels & "</TD></TR>")

        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("<input type=hidden name=hidFromwhere id=hidFromwhere value=" + Request.QueryString("Fromwhere") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtSearch id=hidtxtSearch value=" + Request.QueryString("txtSearch") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidMode id=hidMode value=" + Request.QueryString("Mode") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtPageNumber id=hidtxtPageNumber value=" + Request.QueryString("PageNumber") + ">" + vbCrLf)
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidSpaceID' id='hidSpaceID' value='" + Request.QueryString("SpaceID") + "'>")

        CommonFunctions.General.WriteHTML("</DIV>")


        'CommonFunctions.General.WriteHTML(strMenu)

    End Sub
    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub
    Private Sub PlotPageLegend()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;Mandatory"
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends)
    End Sub
    Private Function InitializeMenu() As String
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        Dim strMenu As String = ""

        ArrMenuCaptionsList.Add("Help")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("Help_OnClick('KM')")

        ArrMenuCaptionsList.Add("Close")
        ArrMenuToolTipsList.Add("Close")
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        m_objMenu = New WebPage.Templates.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        m_objMenu = Nothing
        Return strMenu

    End Function
End Class
