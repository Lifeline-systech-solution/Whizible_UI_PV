Public Class KM_Team
    Inherits WebPages.Template.WhizTemplate
#Region " Constant Variables "
    Protected Const ACTION_SAVE As String = "SAVE"
    Protected Const MODE_NEW As String = "NEW"
    Protected Const MODE_EDIT As String = "EDIT"
#End Region
#Region " Global Variables "
    Protected m_intTeamID As Integer = 0
    Protected m_strMode As String = "EDIT"
    Protected m_strAction As String = ""
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_lngUserId As Long = 0
    Private m_lngPostId As Long = 0
    Protected m_strFrom As String
    Protected m_strtxtSearch As String = ""
    Protected blnflag As Boolean
    Protected m_strPagingNumber As String = ""
    Protected strTeamNameDB As String = ""
    Private drTeamName As IDataReader
    Protected strflag As String = "1"
    Protected m_strFromWhere As String
    Protected m_strActionLink As String
    Protected m_strPrimaryKey As String
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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        InitPage()

    End Sub
    Private Sub PlotHiddenControls()
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.HTMLControls.DrawTextBox("txtPK", "txtPK", , , , CStr(m_intTeamID), IsHidden:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtPK", "txtPK", , , , CStr(m_intTeamID), IsHidden:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        CommonFunction.General.WriteHTML("<input type=hidden name=hidFromwhere id=hidFromwhere value=" + m_strFromWhere + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtSearch id=hidtxtSearch value=" + Request.QueryString("txtSearch") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtPageNumber id=hidtxtPageNumber value=" + Request.QueryString("PageNumber") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidTeamName id=hidTeamName value='" + strTeamNameDB + "'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidActionLink id=hidActionLink value=" + Request.QueryString("ActionLink") + ">" + vbCrLf)
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidFrom' id='hidFrom' value='" + m_strFrom + "'>")
    End Sub
    Private Sub InitPage()

        If Not Request("Action") Is Nothing Then
            m_strAction = CStr(Request("Action"))
        End If

        If Not Request("TeamID") Is Nothing Then
            m_intTeamID = CInt(Request("TeamID"))
        Else
            If Not Request("txtPK") Is Nothing Then
                m_intTeamID = CInt(Request("txtPK"))
            End If
        End If
        If Not Request("Mode") Is Nothing Then
            m_strMode = CStr(Request("Mode"))
        End If

        m_lngUserId = Session("intUserID")
        m_lngPostId = Session("intPostID")

        'If Not Request.QueryString("From") Is Nothing Then
        '    If Request.QueryString("From").ToUpper = "MANAGE" Then
        '        m_strFrom = Request.QueryString("From")
        '    Else
        '        m_strFrom = Request.QueryString("From")
        '    End If
        'Else
        '    m_strFrom = Request.Form("hidFrom")
        'End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("From"), "") <> "" Then
            m_strFromWhere = ""
            m_strFrom = Request.QueryString("From")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidFrom"), "") <> "" Then
            m_strFromWhere = ""
            m_strFrom = Request.Form("hidFrom")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("txtSearch"), "") <> "" Then
            m_strtxtSearch = Request.QueryString("txtSearch")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtSearch"), "") <> "" Then
            m_strtxtSearch = Request.Form("hidtxtSearch")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("PageNumber"), "") <> "" Then
            m_strPagingNumber = Request.QueryString("PageNumber")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtPageNumber"), "") <> "" Then
            m_strPagingNumber = Request.Form("hidtxtPageNumber")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Fromwhere"), "") <> "" Then
            m_strFrom = ""
            m_strFromWhere = Request.QueryString("Fromwhere")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidFromwhere"), "") <> "" Then
            m_strFrom = ""
            m_strFromWhere = Request.Form("hidFromwhere")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("ActionLink"), "") <> "" Then
            m_strActionLink = Request.QueryString("ActionLink")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidActionLink"), "") <> "" Then
            m_strActionLink = Request.Form("hidActionLink")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("PrimaryKey"), "") <> "" Then
            m_strPrimaryKey = Request.QueryString("PrimaryKey")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidPrimaryKey"), "") <> "" Then
            m_strPrimaryKey = Request.Form("hidPrimaryKey")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Myflag"), "") <> "" Then
            strflag = Request.QueryString("Myflag")
        End If


        'drTeamName = CommonFunction.Data.GetDataReader("SELECT TeamName FROM tbl_KM_Team WHERE AuthorID=" + HttpContext.Current.Session("intUserID").ToString + " ORDER BY 1 ", MyBase.UseSQL)
        'To check duplication accross all logins
        drTeamName = CommonFunction.Data.GetDataReader("SELECT LTRIM(RTRIM(TeamName)) TeamName FROM tbl_KM_Team ORDER BY 1 ", MyBase.UseSQL)
        While drTeamName.Read
            strTeamNameDB = strTeamNameDB + "," + drTeamName("TeamName").ToString
        End While

        '  strTeamNameDB = strTeamNameDB.Replace("'", "@") + ","
        'Commented by Shamkant S on 20 nov 2015
        strTeamNameDB = Server.HtmlEncode(strTeamNameDB.Replace("'", "@") + ",")

        CommonFunction.Data.DisposeDataReader(drTeamName)

    End Sub
    Private Sub PerformAction()
        Dim strSQL As String


        If m_strAction = ACTION_SAVE Then
            Dim strTitle As String = ""
            Dim strEditUserIDs As String = ""
            Dim strViewUserIDs As String = ""
            Dim strDescription As String = ""
            Dim blnRestrictEdit As Boolean = False
            Dim blnRestrictView As Boolean = False

            strTitle = CommonFunctions.General.BuildQueryString(Request.Form("txtTitle"))
            strDescription = CommonFunctions.General.BuildQueryString(Request.Form("txtDescription"))

            If Not Request("chkEdit") Is Nothing Then
                strEditUserIDs = Request("txtEditUserIDs")
                blnRestrictEdit = True
            End If
            If Not Request("chkView") Is Nothing Then
                strViewUserIDs = Request("txtViewUserIDs")
                blnRestrictView = True
            End If

            strSQL = " usp_InsUpd_tbl_KM_Team " & m_intTeamID & "," & m_lngUserId.ToString & ",N'" & strTitle & "'," & CStr(IIf(blnRestrictEdit, 1, 0)) & ",'" & strEditUserIDs & "'," & CStr(IIf(blnRestrictView, 1, 0)) & ",'" & strViewUserIDs & "','" & strDescription & "'"
            m_intTeamID = CommonFunctions.Data.GetDataScalar(strSQL, True)
            m_strMode = MODE_EDIT

        ElseIf m_strAction.ToUpper = "DELETE_SPACES" Then
            Dim strPageIDs As String
            strPageIDs = Request("chkDelete")
            strSQL = " usp_del_tbl_KM_TeamSpaces " & m_intTeamID & ",'" & strPageIDs & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        End If
    End Sub
    Public Sub WritePage()
        Dim strSQL As String
        Dim drPageDetails As IDataReader
        Dim strLabels As String = ""
        Dim strSpaceName As String = ""
        Dim strMenu As String = ""
        Dim strTeamDescription As String = ""
        Dim blnRestrictView As Boolean = False
        Dim blnRestrictEdit As Boolean = False
        PerformAction()
        strMenu = InitializeMenu()
        CommonFunctions.General.WriteHTML(strMenu)

        PlotLegends()
        Response.Write("<br>")
        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, "Team", , , True))
        Response.Write("<br>")

        Response.Write("<DIV Id=divMain Style='OVERFLOW:auto; WIDTH:100%'>")
        Response.Write("<TABLE class='clsTable' CellSpacing=0  width=99.99%>")

        If m_intTeamID <> 0 Then
            strSQL = "usp_Sel_tbl_KM_Team_My Null," & m_intTeamID.ToString
            drPageDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drPageDetails.Read Then
                strSpaceName = drPageDetails("TeamName")
                strTeamDescription = CommonFunction.Data.CheckIsDBNull(drPageDetails("Description"), "")
                blnRestrictView = IIf(drPageDetails("RestrictViewAccess") Is DBNull.Value, False, drPageDetails("RestrictViewAccess"))
                blnRestrictEdit = IIf(drPageDetails("RestrictEditAccess") Is DBNull.Value, False, drPageDetails("RestrictEditAccess"))
            End If
            CommonFunction.Data.DisposeDataReader(drPageDetails)

        End If

        CommonFunctions.General.WriteHTML("<tr class=clsTRBody><td align=Right>Team Name</td><td>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '' CommonFunctions.HTMLControls.DrawTextBox("txtTitle", "txtTitle", maxLength:=50, value:=strSpaceName, widthInPixel:=400, IsDisabled:=IIf(m_strMode.ToUpper = "VIEW", True, False), IsMandatory:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtTitle", "txtTitle", maxLength:=50, value:=strSpaceName, widthInPixel:=400, IsDisabled:=IIf(m_strMode.ToUpper = "VIEW", True, False), IsMandatory:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("<tr class=clsTRBody><td align=right valign=top>Description</td><td>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", value:=strTeamDescription, maxLength:=1000, widthInPixel:=400, heightInPixel:=100, IsMandatory:=True, MandatoryImagePath:="../../Images/Star.gif")
        CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", value:=strTeamDescription, maxLength:=1000, widthInPixel:=400, heightInPixel:=100, IsMandatory:=True, MandatoryImagePath:="../../Images/Star.gif", EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        CommonFunctions.General.WriteHTML("</td></tr>")

        If m_strMode.ToUpper <> "VIEW" Then

            'CommonFunctions.General.WriteHTML("<tr class='clsTREven'><TD colspan=2>")
            PlotAccessBlock(blnRestrictEdit, blnRestrictView)
            'CommonFunctions.General.WriteHTML("</td></tr>")
        End If


        CommonFunctions.General.WriteHTML("</TABLE>")


        PlotHiddenControls()
        If m_intTeamID > 0 Then
            PlotSpaces()
        End If

        CommonFunctions.General.WriteHTML("</DIV>")
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub
    Private Sub PlotSpaces()
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        CommonFunctions.General.WriteHTML("<br>")

        With cObjSectionTitle
            Response.Write(.GetSectionTitle("Spaces included in above team", "DivTeamSpaces", "ShowHideTeamSpaces", , ))

            Response.Write("<SCRIPT Language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")

        End With

        cObjSectionTitle = Nothing


        CommonFunctions.General.WriteHTML("<DIV Id=DivTeamSpaces >")
        CommonFunctions.General.WriteHTML("<TABLE class='clsTable' CellSpacing=0  width=99.99%>")

        PlotSpaceList(m_strMode)
        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("</Div>")

    End Sub

    Private Sub PlotSpaceList(ByVal strMode As String)
        Dim strSQL As String
        Dim drSpaces As IDataReader
        Dim blnOddEven As Boolean = False
        Dim strTRClass As String
        Dim strSearchText As String = ""
        'Dim strListHeadCaption As String
        Dim strEditFunctionName As String
        Dim strQuery As String
        Dim strEditAccess As String = ""
        Dim strProgrammerID As String = ""
        Dim drEditAccess As IDataReader
        Dim dbTeamIDForSpace As String = ""


        strSQL = "usp_Sel_tbl_KM_TeamSpaces " & m_intTeamID


        CommonFunctions.General.WriteHTML("<Table ID=tblList width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")

        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH colspan=3 ALIGN='Left' class='divListTag' WIDTH=90%>Space Name</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='Left' class='divListTag' WIDTH=90%>Submitted By</TH>")

        If m_strMode.ToUpper = "EDIT" Then
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Delete</TH>")
        End If
        CommonFunctions.General.WriteHTML("</THEAD>")

        drSpaces = CommonFunctions.Data.GetDataReader(strSQL, True)
        While drSpaces.Read()
          
            strTRClass = "clsTREven"

            strQuery = ""
            strEditAccess = ""
            strProgrammerID = ""

            strQuery = "usp_Get_EditAccess_Space " + drSpaces("SpaceID").ToString + "," + HttpContext.Current.Session("intUserID").ToString
            drEditAccess = CommonFunction.Data.GetDataReader(strQuery, True)
            If drEditAccess.Read() Then
                strEditAccess = drEditAccess("IsPresent").ToString
            End If

            If drEditAccess.NextResult() Then
                If drEditAccess.Read() Then
                    strProgrammerID = drEditAccess("AuthorID").ToString
                End If
            End If

            CommonFunction.Data.DisposeDataReader(drEditAccess)

            dbTeamIDForSpace = CommonFunction.Data.GetDataScalar("SELECT ISNULL(TeamID,0) FROM tbl_Km_Space WHERE SpaceID =" + drSpaces("SpaceID").ToString, MyBase.UseSQL)
           
            CommonFunctions.General.WriteHTML("<Tr class=" & strTRClass & ">")
            If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                CommonFunctions.General.WriteHTML("<td colspan=3 WIDTH=90%><a href='javascript:Space_OnClick(" & drSpaces("SpaceID") & ",""Edit"",""" & CommonFunction.Data.CheckIsDBNull(drSpaces("TeamID"), "" & dbTeamIDForSpace & "") & """)'>" & drSpaces("SpaceName") & "</a>")
            Else
                CommonFunctions.General.WriteHTML("<td colspan=3 WIDTH=90%><a href='javascript:Space_OnClick(" & drSpaces("SpaceID") & ",""View"",""" & CommonFunction.Data.CheckIsDBNull(drSpaces("TeamID"), "" & dbTeamIDForSpace & "") & """)'>" & drSpaces("SpaceName") & "</a>")
            End If

            'CommonFunctions.General.WriteHTML("<td colspan=3 WIDTH=90%>" & drSpaces("SpaceName"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td>")
            CommonFunctions.General.WriteHTML(drSpaces("Author"))
            CommonFunctions.General.WriteHTML("</td>")

            If m_strMode.ToUpper = "EDIT" Then
                CommonFunctions.General.WriteHTML("<td WIDTH=10% align=center>")
                CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", Value:=drSpaces("SpaceID"))
                CommonFunctions.General.WriteHTML("</td>")
            End If
            CommonFunctions.General.WriteHTML("</tr>")

            'CommonFunctions.General.WriteHTML("<tr class=" & strTRClass & "><td >&nbsp;&nbsp;&nbsp;</td>")
            'CommonFunctions.General.WriteHTML("<td colspan=2>" & drPages("Keywords") & "</td><td>&nbsp;</td></tr>")



        End While
        CommonFunction.Data.DisposeDataReader(drSpaces)

        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("</DIV>")


    End Sub
    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag("Space")
    End Sub
    Private Sub PlotAccessBlock(ByVal blnRestrictEdit As Boolean, ByVal blnRestrictView As Boolean)
        Dim strEditUsers As String = ""
        Dim strEditUserIDs As String = ""

        Dim strViewUsers As String = ""
        Dim strViewUserIDs As String = ""

        Dim strSQL As String
        Dim drAccessUsers As IDataReader

        If m_intTeamID > 0 And (blnRestrictEdit = True Or blnRestrictView = True) Then
            strSQL = "Exec usp_Sel_tbl_KM_Teams_RestrictedUserGroups " & m_intTeamID
            drAccessUsers = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drAccessUsers.Read Then
                strEditUsers = drAccessUsers("EditUsers")
                strEditUserIDs = drAccessUsers("EditUserIDs")
                strViewUsers = drAccessUsers("ViewUsers")
                strViewUserIDs = drAccessUsers("ViewUserIDs")
            End If
            CommonFunction.Data.DisposeDataReader(drAccessUsers)

        End If
        'Response.Write("<TABLE valign=bottom class='clsTable'  CellSpacing='0' CellPadding=0  width=100% height=100%>")

        'CommonFunctions.General.WriteHTML("<tr class='clsTREven'><TD id='TD_Left'style='width:50%;border:1px solid #ccc;' valign='top'>")

        'Response.Write("<TABLE valign=bottom class='clsTable'  CellSpacing='0' CellPadding=0  width=100% height=100%>")

        CommonFunctions.General.WriteHTML("<tr class='clsTRBody'><td align=right valign=top>Allow View&nbsp;</td><td>")
        CommonFunctions.HTMLControls.DrawCheckBox("chkView", "chkView", , blnRestrictView, ToBeInserted:="Onclick=""ShowHideTr('tr_ViewUsers',this)""")
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("<tr id='tr_ViewUsers' class='clsTRBody'><td align=right valign=top><a Href=""javascript:UserSelection_Onclick('View')"">Users</a></td><td>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ' CommonFunctions.HTMLControls.DrawTextArea("txtViewUsers", "txtViewUsers", "Users", value:=strViewUsers, widthInPixel:=280, heightInPixel:=100, IsReadonly:=True)
        'CommonFunctions.HTMLControls.DrawTextBox("txtViewUserIDs", "txtViewUserIDs", value:=strViewUserIDs, IsHidden:=True)
        CommonFunctions.HTMLControls.DrawTextArea("txtViewUsers", "txtViewUsers", "Users", value:=strViewUsers, widthInPixel:=280, heightInPixel:=100, IsReadonly:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtViewUserIDs", "txtViewUserIDs", value:=strViewUserIDs, IsHidden:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
               CommonFunctions.General.WriteHTML("</td></tr>")

        'CommonFunctions.General.WriteHTML("<TD id='TD_Right'style='width:50%;border:1px solid #ccc;' valign='top'>")

        'Response.Write("<TABLE valign=bottom class='clsTable'  CellSpacing='0' CellPadding=0  width=100% height=100%>")

        CommonFunctions.General.WriteHTML("<tr class='clsTRBody'><td align=right valign=top>Allow Edit&nbsp;</td><td align=left valign=top>")
        CommonFunctions.HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnRestrictEdit, TobeInserted:="Onclick=""ShowHideTr('tr_EditUsers',this)""")
        CommonFunctions.General.WriteHTML("</td></tr>")


        CommonFunctions.General.WriteHTML("<tr id='tr_EditUsers' class='clsTRBody'><td align=right valign=top><a Href=""javascript:UserSelection_Onclick('Edit')"">Users</a></td><td>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '' CommonFunctions.HTMLControls.DrawTextArea("txtEditUsers", "txtEditUsers", "Users", value:=strEditUsers, widthInPixel:=280, heightInPixel:=100, IsReadonly:=True)
        '' CommonFunctions.HTMLControls.DrawTextBox("txtEditUserIDs", "txtEditUserIDs", value:=strEditUserIDs, IsHidden:=True)
        CommonFunctions.HTMLControls.DrawTextArea("txtEditUsers", "txtEditUsers", "Users", value:=strEditUsers, widthInPixel:=280, heightInPixel:=100, IsReadonly:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtEditUserIDs", "txtEditUserIDs", value:=strEditUserIDs, IsHidden:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        
        CommonFunctions.General.WriteHTML("</td></tr>")

    End Sub

    Private Sub PlotLegends()
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

        If m_strMode.ToUpper = "EDIT" Then
            If m_intTeamID > 0 Then 'And m_strFrom.ToUpper <> "SEARCH" Then
                'Addition by SuchitraP on 25-Aug-2008 for Adding New Space under MyTeam
                ArrMenuCaptionsList.Add("Add New Space")
                ArrMenuToolTipsList.Add("Add New Space")
                ArrClientSideFunctionsList.Add("AddNewSpace_OnClick()")
                'End by SuchitraP

                ArrMenuCaptionsList.Add("Add Existing Space")
                ArrMenuToolTipsList.Add("Add Existing Space")
                ArrClientSideFunctionsList.Add("AddSpace_OnClick('" + m_strFromWhere + "')")

                ArrMenuCaptionsList.Add("Delete Space")
                ArrMenuToolTipsList.Add("Delete Space")
                ArrClientSideFunctionsList.Add("DeleteSpace_OnClick()")
            Else
                ArrMenuCaptionsList.Add("Add Space")
                ArrMenuToolTipsList.Add("Add Space")
                ArrClientSideFunctionsList.Add("AddSpace_OnClick('" + m_strFromWhere + "')")

                ArrMenuCaptionsList.Add("Delete Space")
                ArrMenuToolTipsList.Add("Delete Space")
                ArrClientSideFunctionsList.Add("DeleteSpace_OnClick()")
            End If

            'ArrMenuCaptionsList.Add("Select All")
            'ArrMenuToolTipsList.Add("Select All")
            'ArrClientSideFunctionsList.Add("SelectAll_OnClick('frmKMTeam','chkDelete')")

            'ArrMenuCaptionsList.Add("Clear All")
            'ArrMenuToolTipsList.Add("Clear All")
            'ArrClientSideFunctionsList.Add("ClearAll_OnClick('frmKMTeam','chkDelete')")

            ArrMenuCaptionsList.Add("Save")
            ArrMenuToolTipsList.Add("Save")
            ArrClientSideFunctionsList.Add("Save_OnClick()")

           
           
        ElseIf m_strMode.ToUpper = "ADD_NEW" Then
            ArrMenuCaptionsList.Add("Save")
            ArrMenuToolTipsList.Add("Save")
            ArrClientSideFunctionsList.Add("Save_OnClick()")
        End If

        'ArrMenuCaptionsList.Add("Close")
        'ArrMenuToolTipsList.Add("Close")
        'ArrClientSideFunctionsList.Add("Close_OnClick()")


        ArrMenuCaptionsList.Add("Back")
        ArrMenuToolTipsList.Add("Back")
        If Not m_strFromWhere Is Nothing And m_strFromWhere <> "" Then
            ArrClientSideFunctionsList.Add("Back_OnClick('" + m_strFromWhere + "')")
        Else
            ArrClientSideFunctionsList.Add("Back_OnClick('" + m_strFrom + "')")
        End If


        ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("Help_OnClick('3961')")

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

    ''Added by Dhanashri S on 29 Mar 2016 Purpose:to generate and validate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateSpaceToken(SpaceID As String, EmployeeId As String, TeamID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(SpaceID, String) + CType(EmployeeId, String) + "0" + "0" + CType(TeamID, String))

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateAddNewSpaceToken(TeamID As String, EmployeeId As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(TeamID, String) + CType(EmployeeId, String) + "0" + "0")

        Return m_PKToken_Request_Multiple
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateAddSpaceToken(TeamID As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_AddSpace As String
            m_PKToken_AddSpace = CommonFunctions.Security.Token.GetToken(CType(TeamID, String) + CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_AddSpace
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Addition by Dhanashri S on 29 Mar 2016
End Class
