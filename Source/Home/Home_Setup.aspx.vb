Public Class Home_Setup
    Inherits WebPages.Template.WhizTemplate
#Region "Member variables"

    Protected sbHTML As StringBuilder
    Protected m_strDefaultPageURL As String = ""
    Protected m_strSQL As String = ""
    Protected dsGroupTab As DataSet
    Protected dsTabItems As DataSet
    Protected m_strGroupTabID As String = ""
    Protected IsFirstHit As Boolean
    Protected m_strTabGroupItemID As String = ""
    Protected m_objAccess As New WebPage.Templates.AccessRights
    Protected m_GlobalObject As New WebPages.Template.WhizGlobal
    Protected RecordCount As Integer = 0

    Protected IsAccessForNode As Boolean
    Protected m_strSearchText As String = ""

    Protected m_intPageNumber As Integer = 0
    Protected m_intRowCount As Integer = 0
    Protected dblRatio As Double = 0.0
    Protected dsTemp As DataSet
    Private strPagecaption As String = ""
    Protected m_strLinkOptions As String = ""
    Protected m_strIsXMLHTTP As String = ""
    Protected m_strMode As String = ""
    Protected m_strFavTagID As String = ""
    Protected argCB As CommonFunctions.HTMLControls.WAF_DropDown
    Protected m_strProjectID As String = ""
    Protected m_strDefaultTagID As String = ""
    Protected m_strControlItemID As String = ""
    Protected m_strIsFavXMLHTTP As String = ""
    Protected m_InsControlItemID As String = ""
    Protected m_FirstTagCIID As String = ""
    Protected m_strTemplateID As String = ""

    'Added By Amol Changle On: 08 May 2009
    'Purpose:To use New/Old tree
    Protected m_intUseNewUITree As Integer = 0
    'End Addition

    'Protected m_strAction As String = ""
    'Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
#End Region
#Region "Costants"
    Protected Const PAGE_SIZE As Integer = 10
    Private Const DEFAULT_TAGID As Long = 32
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub
    Protected Sub PageInit()

        'm_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action")).ToString()

        'Call PerformAction()

        Initialize_Variables()

        DrawHiddenFields()

        'Call DrawProjectSelectionDiv()

        If m_strIsFavXMLHTTP = "1" And m_strMode <> "" Then
            AddRemoveFavourites()

            Response.Clear()
            Response.Write((New Home_FloatingMenu).DrawFavoriateTabs(m_strTemplateID))
            Response.End()
            Exit Sub
        End If

        GetDatabasValues()

        DrawHeader()

        WritePage()

        DisposeNotUsedObjects()

    End Sub


    Protected Sub DrawHiddenFields()
        '=====================================================================
        ' Proce  Name	    	:	DrawHiddenFields
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw hidden fields
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Feb 11 2009
        ' Revisions				:	
        '=====================================================================
        '' Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtGroupTabID", "txtGroupTabID", , , , m_strGroupTabID, , , , , , True, , True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtGroupTabID", "txtGroupTabID", , , , m_strGroupTabID, , , , , , True, , True, EnableHTMLEncode:=True))
        If m_strTemplateID = "" Then
            m_strTemplateID = "SM"
        End If
        ''Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtTemplateID", "txtTemplateID", , , , m_strTemplateID, , , , , , True, , True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtTemplateID", "txtTemplateID", , , , m_strTemplateID, , , , , , True, , True, EnableHTMLEncode:=True))
    End Sub
    Protected Sub DisposeNotUsedObjects()
        '=====================================================================
        ' Function  Name		:	DisposeNotUsedObjects
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To destroy not used objects
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================
        dsGroupTab = Nothing
        dsTabItems = Nothing
        m_objAccess = Nothing
        m_GlobalObject = Nothing
        argCB = Nothing
    End Sub
    Protected Sub Initialize_Variables()
        '=====================================================================
        ' Function  Name		:	Initialize_Variables
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To Persists the state of the page 
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================
        GetGlobalObject()

        If Not Request("GroupTabID") Is Nothing Then
            m_strGroupTabID = CType(Request("GroupTabID"), String)
        Else
            m_strGroupTabID = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtGroupTabID"), ""), String)
        End If

        m_strTabGroupItemID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("TabGroupItemID"), ""), String)

        m_strSearchText = CommonFunction.General.CheckIsNothing(Request.Form("txtSearch"))

        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("txtPageNumber")) <> "" Then
            m_intPageNumber = CType(Request.Form("txtPageNumber"), Integer)
        Else
            m_intPageNumber = 1
        End If

        m_strLinkOptions = CommonFunction.General.CheckIsNothing(Request.Form("cboLinkOptions"), "")

        m_strIsXMLHTTP = CommonFunction.General.CheckIsNothing(Request("IsXMLHTTP"))
        m_strMode = CommonFunction.General.CheckIsNothing(Request("Mode"))
        m_strFavTagID = CommonFunction.General.CheckIsNothing(Request("FavTagID"))
        m_strProjectID = m_GlobalObject.ProjectID.ToString
        m_strIsFavXMLHTTP = CommonFunction.General.CheckIsNothing(Request("IsFavXMLHTTP"))

        m_strDefaultTagID = CommonFunctions.General.CheckIsNothing(Request("hidDefaultTagID"), "0").ToString()
        m_strControlItemID = CommonFunctions.General.CheckIsNothing(Request("hidDefaultControlItemID"), "0").ToString()

        If GetTagAccessRights(CType(m_strDefaultTagID, Long)) Then
            m_strDefaultPageURL = CommonFunctions.General.CheckIsNothing(Request("hidDefaultPageURL"), "").ToString()
        Else
            m_strDefaultPageURL = ""
        End If

        If m_strTemplateID = "" Then
            m_strTemplateID = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtTemplateID"), ""), String)
        End If
        'Added By Amol Changle On: 11 May 2009
        'Purpose: To select whether to use New/Old UI tree
        m_intUseNewUITree = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_Sel_UseNewUITree", True), "0"), "0").ToString(), Integer)
        'End Addition
    End Sub
    Private Sub GetDatabasValues()

   
        m_strSQL = "usp_Sel_AccessibleProjectTags_setup "

        If m_strSearchText <> "" Then
            m_strSQL += "N'" & CommonFunction.General.BuildQueryString(m_strSearchText) & "'"
        Else
            m_strSQL += " NULL"
        End If

        'If m_strLinkOptions <> "" Then
        '    m_strSQL = m_strSQL + "," + m_strLinkOptions
        'Else
        m_strSQL = m_strSQL + ",NULL"
        'End If

        m_strSQL = m_strSQL + "," & m_GlobalObject.UserID.ToString
        m_strSQL = m_strSQL + "," & m_GlobalObject.RoleID.ToString
        m_strSQL = m_strSQL + "," & m_GlobalObject.ProjectID.ToString
        m_strSQL = m_strSQL + ",'" & m_GlobalObject.LoginType & "'"
        m_strSQL = m_strSQL + ",'" & m_strTemplateID.ToString & "'"

        'Added By Amol Changle On: 07 May 2009
        'Purpose: To plot old tree, last parameter passed as TreeType='O'
        If CType(m_intUseNewUITree, Boolean) Then
            m_strSQL = m_strSQL + ",'N'"
        Else
            m_strSQL = m_strSQL + ",'O'"
        End If
        'End Addition

        dsTemp = CommonFunction.Data.GetDataSet(m_strSQL, "TEMP", , , MyBase.UseSQL)

        m_intRowCount = dsTemp.Tables(0).Rows.Count


        Dim intStartRecord As Integer = 0

        intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)


        'If m_intPageNumber = -1 Then
        dsGroupTab = CommonFunction.Data.GetDataSet(m_strSQL, "GroupTab", , , MyBase.UseSQL)
        'Else
        'dsGroupTab = CommonFunction.Data.GetDataSet(m_strSQL, "GroupTab", intStartRecord, PAGE_SIZE, MyBase.UseSQL)
        ' End If
        Dim strScript As New StringBuilder
        Dim strTagID As String

        strScript.Append("<script language=javascript>")
        strScript.Append(vbCrLf)
        strScript.Append("var Tree = new Array;")
        strScript.Append(vbCrLf)
        If dsGroupTab.Tables(0).Rows.Count > 0 Then
            For intIndex As Integer = 0 To dsGroupTab.Tables(0).Rows.Count - 1
                strTagID = CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intIndex)("TagID"), "0").ToString()
                strScript.Append("Tree[")
                strScript.Append(intIndex.ToString())
                strScript.Append("]=""")
                strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intIndex)("TagID"), "0").ToString())
                strScript.Append("|")
                strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intIndex)("ParentTagID"), "0").ToString())
                strScript.Append("|")
                strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intIndex)("TagDescription"), "").ToString())
                strScript.Append("|")
                If Not CType(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intIndex)("IsParent"), "0"), Boolean) Then
                    strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intIndex)("PageName"), "").ToString())
                End If
                strScript.Append("|")
                strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intIndex)("ParentTagName"), "").ToString())
                strScript.Append("|")
                strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intIndex)("ControlItemID"), "0").ToString())
                strScript.Append("|page.gif")
                If CType(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intIndex)("IsParent"), "0"), Boolean) Then
                    strScript.Append("|-1"";")
                Else
                    strScript.Append("|0"";")
                End If
                strScript.Append(vbCrLf)
            Next
        End If
        strScript.Append("</script>")
        strScript.Append(vbCrLf)

        CommonFunctions.General.WriteHTML(strScript.ToString())
        strScript = Nothing


        'For Each drRow As DataRow In dsGroupTab.Tables(0).Rows
        '    If CType(CommonFunction.Data.CheckIsDBNull(drRow("ControlItemID")), String) <> "" And CType(CommonFunction.Data.CheckIsDBNull(drRow("ControlItemID")), String) <> "0" Then
        '        m_FirstTagCIID = CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID")), String)
        '    End If
        '    Exit For
        'Next
    End Sub
    Protected Sub DrawHeader()
        '=====================================================================
        ' Function  Name		:	DrawHeader()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw page header
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	March 05th, 2009
        ' Revisions				:	
        '=====================================================================

        Dim m_sBHTML As New StringBuilder
        Dim strRightCaption As String = ""
        Dim sbH As New StringBuilder("")

        sbH.Append("<div id='divHeader' style='width:100%;valign:top;'>")

        sbH.Append("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0   class='clsGridTable' width=100%  style=""BORDER-BOTTOM: black 1px outset; "">")
        sbH.Append("<TR class='clsTRBlank'><TD class='clsTDBlank' width='15%' style=""valign:bottom;align:left"" >")

        sbH.Append(CommonFunction.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 150, 20, m_strSearchText, , "vertical-align:bottom", , , , , "onkeyup=txtSearch_OnKeyup(event) title='Search Pages'", True, , ))
        sbH.Append("&nbsp;<a href='#' onclick='javascript:Search_OnClick(event)'><Img Border=0 alt='Search Pages' src='../../Images/Home/Search.gif' /></a>")
        sbH.Append("</Td>")
       
        sbH.Append("<TD class='clsTDBlank' width='5%' style=""valign:bottom;align:left"">")
        sbH.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousFAV()"" Title=""Previous Favorites"" onmouseover=""window.status='Previous Favorites';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbH.Append("<Img Border=0 src='../../Images/Home/roundleft.gif' align='top'></A>")
        sbH.Append("</Td>")

        'Commented and Added by Dhanashri S on 16 Mar 2015
        ''sbH.Append("<TD id='tdTabs' class='clsTDBlank' width='77%' style=""valign:bottom;align:left;white-space: nowrap"">")
        sbH.Append("<TD id='tdTabs' class='clsTDBlank' width='50%' style=""valign:bottom;align:left;white-space: nowrap"">")
        'End of Addition by Dhanashri S

        sbH.Append((New Home_FloatingMenu).DrawFavoriateTabs(m_strTemplateID))
        sbH.Append("</Td>")
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

      
        sbH.Append("<TD class='clsTDBlank'  style=""valign:bottom;text-align:left;width:3%"">")

        sbH.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextFAV()"" Title=""Next Favorites"" onmouseover=""window.status='Next Favorites';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbH.Append("<Img Border=0 src='../../Images/Home/roundright.gif' align='top'></A>&nbsp;&nbsp; ")


        sbH.Append("<a href=""#""  title='Manage Favourites' onclick='javascript:ShowFloatingmenu(""GoTo"",event)' style=""text-decoration:none;vertical-align:bottom;""><img src='../../Images/Home/Favorites.gif' border=0 style=""vertical-align:top""></a>") '&nbsp;&nbsp;&nbsp;")

        sbH.Append("</td>")
        '''''''''''''''''
        sbH.Append("</tr>")
        sbH.Append("</table>")


        sbH.Append("</div>")

        If m_strIsFavXMLHTTP = "1" Then
            Response.Clear()
            Response.Write(sbH.ToString)
            Response.End()
        Else
            Response.Write(sbH.ToString)
        End If

        sbH = Nothing
        m_sBHTML = Nothing
        sbH = Nothing

    End Sub
    Protected Sub WritePage()
        '=====================================================================
        ' Function  Name		:	WritePage()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To Persists the state of the page 
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================
        sbHTML = New StringBuilder


        'Response.Write("<div id='divMain' style='OVERFLOW:auto;width:99.9%;valign:top;'>")
        Response.Write("<div id='divMain' style='width:99.9%;valign:top;'>")

        Response.Write("<div id='divTab' style='OVERFLOW:auto;width:99.9%;valign:top;'>")
        DrawTabGroups()
        Response.Write("</div>")
        'sbHTML.Append("<iframe name='frmMain' id='frmMain' onLoad='calcHeight()'  src='" + m_strDefaultPageURL + "' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>" + vbCrLf)
        '        Response.Write("<input type=hidden name='hidDefaultPageURL' id='hidDefaultPageURL' value='" + m_strDefaultPageURL + "'>")
        Response.Write("</div>")

        'If IsFirstHit Then
        '    Response.Write(sbHTML.ToString)
        'Else
        '    Response.Clear()
        'Response.Write(sbHTML.ToString)
        'Response.End()
        'End If

        sbHTML = Nothing

    End Sub
    Private Sub DrawTabGroups()
        '=====================================================================
        ' Function  Name		:	DrawTabGroups()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw the tab groups i.e. Tasks planning,Timesheet Entry etc.
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Feb 11 2009
        ' Revisions				:	
        '=====================================================================
        Dim m_sBHTML As New StringBuilder
        Dim strDefaultGroupTabID As String = ""
        Dim strParentTagName As String = ""

        dblRatio = m_intRowCount / PAGE_SIZE

        If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
            m_intPageNumber = 1
        End If


        m_sBHTML.Append("<TABLE cellSpacing=0 cellPadding=3 width='100%' align=center border=0 >")
        m_sBHTML.Append("<TBODY>")
        m_sBHTML.Append("<tr>")
        m_sBHTML.Append("<TD id='tdTree' name='tdTree'  vAlign=top noWrap width=155 style='BORDER-RIGHT: blue 1px outset; BORDER-TOP: blue 1px outset;BORDER-LEFT: blue 1px outset; BORDER-BOTTOM: blue 1px outset;' >")
        'm_sBHTML.Append("<a style=""text-decoration:none;"" href='javascript:HideTree()' >Hide</a>")
        '''''Commented by purvaj on  29 May 2009 new / old tree functionality added
        ''''m_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB' height=514px>")
        ''' End comment purvaj

        If m_InsControlItemID <> "" Then
            m_sBHTML.Append("<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()'  style=""vertical-align:top;"" ><img id=imgFav border=0 src='../../Images/Home/favorites-.gif' title='Remove From favourites' /></a>")
        Else
            m_sBHTML.Append("<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()'  style=""vertical-align:top;"" ><img id=imgFav border=0 src='../../Images/Home/fav+.gif' title='Add To favourites' /></a>")
        End If
        If CType(m_intUseNewUITree, Boolean) Then
            m_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB' style=""width:200px;height:514px;background-color:White"">")
        Else
            m_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB' style=""width:200px;height:99.99%;background-color:White"">")
        End If

        ''' Commented by purvaj on 29 May 2009 new / old tree functionality added 
        '''''If m_InsControlItemID <> "" Then

        '''''    m_sBHTML.Append("<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()' title='Remove From favourites' style=""vertical-align:top;"" ><img id=imgFav border=0 src='../../Images/Home/favorites-.gif' /></a>")
        '''''Else

        '''''    m_sBHTML.Append("<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()' title='Add To favourites' style=""vertical-align:top;"" ><img id=imgFav border=0 src='../../Images/Home/favorites+.gif'  /></a>")
        '''''End If

        '''''''nav
        '''''' m_sBHTML.Append("<UL id=parentnav width='155'>")
        '''''For Each drRow As DataRow In dsGroupTab.Tables(0).Rows
        '''''    If strParentTagName <> CType(CommonFunction.Data.CheckIsDBNull(drRow("ParentTagName"), ""), String) Then
        '''''        If strParentTagName <> "" Then
        '''''            'Commented By Amol Changle On: 19 Mar 2009 
        '''''            'm_sBHTML.Append("</ul>")
        '''''            m_sBHTML.Append("</div>")
        '''''            'm_sBHTML.Append("<br/>")
        '''''            m_sBHTML.Append("<div style=""height:1px;"">&nbsp;</div>")
        '''''            'End Comments
        '''''        Else
        '''''            m_sBHTML.Append("<br />")
        '''''        End If

        '''''        '   m_sBHTML.Append("<LI align='left'>")
        '''''        m_sBHTML.Append("<a align='left' class='clstagGroup' >") ' clsLinkSelectedNavMenu
        '''''        m_sBHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("ParentTagName"), ""), String))
        '''''        m_sBHTML.Append("</a>")
        '''''        '   m_sBHTML.Append("</LI>")


        '''''        'Commented By Amol Changle On: 19 Mar 2009 
        '''''        ' m_sBHTML.Append("<UL id=nav>")
        '''''        m_sBHTML.Append("<div style=""border:solid 1px black;"">")
        '''''        'End Comments


        '''''    End If
        '''''    '  If GetTagAccessRights(CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), "0"), Long)) Then

        '''''    'Commented By Amol Changle On: 19 Mar 2009 
        '''''    'm_sBHTML.Append("<LI style='list-style-type:disc;'>")
        '''''    'End Comments

        '''''    ''PrashantSJ on 10th March
        '''''    'If CType(CommonFunction.Data.CheckIsDBNull(drRow("ControlItemID"), ""), String) = "" Then
        '''''    '    m_sBHTML.Append("<img border=0 src='../../Images/Home/AddFavorite.gif' title='Add to favourites' style='cursor:hand;' onclick='addRemoveFavorites(" + CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), "0"), String) + ",""A"")'>&nbsp;")
        '''''    'Else
        '''''    '    m_sBHTML.Append("<img border=0 src='../../Images/Home/RemoveFavorite.gif' title='Remove from favourites' style='cursor:hand;' onclick='addRemoveFavorites(" + CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), "0"), String) + ",""D"")'>&nbsp;")
        '''''    'End If

        '''''    'Added By Amol Changle On: 19 Mar 2009
        '''''    m_sBHTML.Append("<div style=""height:20px;"">")
        '''''    m_sBHTML.Append("&nbsp;<img style=""vertical-align:middle;""  src='../../Images/Home/TabItem.gif' border=0>&nbsp;")
        '''''    'End Addition

        '''''    'If m_GlobalObject.ProjectID.ToString <> "0" Or DEFAULT_TAGID = CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), "0"), Long) Then
        '''''    If CType(CommonFunction.Data.CheckIsDBNull(drRow("ControlItemID"), ""), String) <> "" Then
        '''''        m_sBHTML.Append("<A class='clsLinkChildNavMenu' style=""text-decoration:none;"" href='javascript:TabItemOnClick(""" + CType(CommonFunction.Data.CheckIsDBNull(drRow("PageName"), ""), String) + """," + CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), ""), String) + "," + CType(CommonFunction.Data.CheckIsDBNull(drRow("ControlItemID"), ""), String) + ") ' onmouseover='javascript:TablItem_onmouseover(this)' onmouseout='javascript:TablItem_onmouseout(this)'>")
        '''''    Else
        '''''        m_sBHTML.Append("<A  class='clsLinkChildNavMenu' style=""text-decoration:none;"" href='javascript:TabItemOnClick(""" + CType(CommonFunction.Data.CheckIsDBNull(drRow("PageName"), ""), String) + """," + CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), ""), String) + ",0) ' onmouseover='javascript:TablItem_onmouseover(this)' onmouseout='javascript:TablItem_onmouseout(this)'>")
        '''''    End If
        '''''    'If m_strDefaultPageURL = "" Then
        '''''    If m_strTemplateID = "PRO" Then
        '''''        m_strDefaultPageURL = "../Home/HRHome.aspx?ShortName=PRO&FromWhere=PRO&SearchText=" + HttpContext.Current.Server.UrlDecode(m_strSearchText)
        '''''    End If

        '''''    If m_strTemplateID = "SM" Then
        '''''        m_strDefaultPageURL = "../Home/HRHome.aspx?ShortName=SM&FromWhere=SM&SearchText=" + HttpContext.Current.Server.UrlDecode(m_strSearchText)
        '''''    End If

        '''''    If m_strTemplateID = "RM" Then
        '''''        m_strDefaultPageURL = "../Home/HRHome.aspx?ShortName=RM&FromWhere=RM&SearchText=" + HttpContext.Current.Server.UrlDecode(m_strSearchText)
        '''''    End If

        '''''    m_strDefaultTagID = CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), ""), String)
        '''''    m_strControlItemID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ControlItemID"), ""), String)
        '''''    'End If
        '''''    'Else
        '''''    'm_sBHTML.Append("<A class='clsLinkChildNavMenu' href='#' style='text-decoration:none;cursor:default;'>")
        '''''    'End If

        '''''    m_sBHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("TagDescription"), ""), String))

        '''''    m_sBHTML.Append("</A>")

        '''''    'Added By Amol Changle On: 19 Mar 2009
        '''''    m_sBHTML.Append("</div>")

        '''''    'Commented By Amol Changle On: 19 Mar 2009 
        '''''    'm_sBHTML.Append("</LI>")
        '''''    'End Comments

        '''''    'If DEFAULT_TAGID = CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), "0"), Long) Then
        '''''    '    m_strDefaultPageURL = CType(CommonFunction.Data.CheckIsDBNull(drRow("PageName"), ""), String)
        '''''    '    m_strDefaultTagID = CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), ""), String)
        '''''    '    m_strControlItemID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ControlItemID"), ""), String)
        '''''    'End If
        '''''    '  End If
        '''''    strParentTagName = CType(CommonFunction.Data.CheckIsDBNull(drRow("ParentTagName"), ""), String)
        '''''Next

        ''''''Added By Amol Changle On: 19 Mar 2009
        '''''If dsGroupTab.Tables(0).Rows.Count > 0 Then
        '''''    m_sBHTML.Append("</div>")
        '''''End If
        ''''''End Addition

        '''''' end comment purvaj on 29 May 2009
        m_sBHTML.Append("</div>")

        '''If dsTemp.Tables(0).Rows.Count > PAGE_SIZE Then
        'Added By Amol Changle On: 07 May 2009
        If CType(m_intUseNewUITree, Boolean) Then

            m_sBHTML.Append("<span style=""text-align:left;width:49.99%;vertical-align:bottom""><A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()"" Title=""Previous Records"" onmouseover=""window.status='Previous Records';return true;"" onmouseout=""window.status=' ';return true;"">")
            m_sBHTML.Append("<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A></span>")

            m_sBHTML.Append("<span style=""text-align:right;width:49.99%;vertical-align:bottom""><A style='TEXT-DECORATION:NONE;text-align:right;vertical-align:bottom' HREF=""Javascript:ShowNextPage()"" Title=""Next Records"" onmouseover=""window.status='Next Records';return true;"" onmouseout=""window.status=' ';return true;"">")
            m_sBHTML.Append("<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A></span> ")
            '''' Commented by purvaj on 29 May 2009 new/old ui tree functionality added
            '''If m_intPageNumber = -1 Or dblRatio = 0 Then
            '''    m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 150, 4, "", "right", , , , , True, , True))
            '''Else
            '''    m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 150, 4, m_intPageNumber.ToString, "right", , , , , True, , True))
            '''End If

            '''m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True))
            ''' End comment purvaj

            ' m_sBHTML.Append("</LI>")
        End If
        m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 150, 4, "1", "right", , , , , True, , True))

        ' m_sBHTML.Append("</ul>")

        m_sBHTML.Append("</td>")
        'm_sBHTML.Append("<TD ID='tdDot0' name='tdDot0' width=1px></TD>")
        m_sBHTML.Append("<TD ID='tdDot1' name='tdDot1' vAlign=top width=1px   background='../../Images/Home/dot2.gif' onclick='javascript:ShowTree()'><a name='aShowTree' id='aShowTree' style=""text-decoration:none;"" href='javascript:HideTree()' ><img ID='ImgShowHide' src='../../Images/ScrollLeft.gif' border=0 /></a></TD>")
        'm_sBHTML.Append("<TD ID='tdDot2' name='tdDot2' width=2px></TD>")
        m_sBHTML.Append("<TD vAlign=top width='100%'>")
        m_sBHTML.Append("<iframe name='frmMain' id='frmMain' onLoad='calcHeight()' src='' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;BORDER-RIGHT: blue 1px outset; BORDER-TOP: blue 1px outset;BORDER-LEFT: blue 1px outset; BORDER-BOTTOM: blue 1px outset;' ></iframe>")
        m_sBHTML.Append("</TD>")
        m_sBHTML.Append("</TR></TBODY></TABLE>")


        'm_sBHTML.Append("<input type=hidden name='hidDefaultPageURL' id='hidDefaultPageURL' value='" + m_strDefaultPageURL + "'>")
        'm_sBHTML.Append("<input type=hidden name='hidDefaultTagID' id='hidDefaultTagID' value='" + m_strDefaultTagID + "'>")
        ' m_sBHTML.Append("<input type=hidden name='hidDefaultControlItemID' id='hidDefaultControlItemID' value='" + m_strControlItemID + "'>")

        m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidDefaultPageURL", "hidDefaultPageURL", , , , m_strDefaultPageURL, returnHTML:=True, DisplayNone:=True))
        m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidDefaultTagID", "hidDefaultTagID", , , , m_strDefaultTagID, returnHTML:=True, DisplayNone:=True))
        m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidDefaultControlItemID", "hidDefaultControlItemID", , , , m_strControlItemID, returnHTML:=True, DisplayNone:=True))

        If m_strIsXMLHTTP = "1" Then
            Response.Clear()
            Response.Write(m_sBHTML.ToString)
            Response.End()
        Else
            Response.Write(m_sBHTML.ToString)
        End If

        m_sBHTML = Nothing
    End Sub
    Private Function GetTagAccessRights(ByVal lngTagID As Long) As Boolean
        '=====================================================================
        ' Function  Name		:	GetTagAccessRights()
        ' Parameters Passed		:	TagID
        ' Returns				:	boolean value whether tag is accessable or not
        ' Parameters Affected	:	None
        ' Purpose				:	To verify whether tag is accessable or not
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Feb 11 2009
        ' Revisions				:	
        '=====================================================================
        If lngTagID = 0 Then
            IsAccessForNode = True
        Else
            m_GlobalObject.TagID = lngTagID
            'Get the Access Rights 

            m_objAccess.GetAccess(m_GlobalObject)

            If m_objAccess.Add = True OrElse m_objAccess.Delete = True OrElse m_objAccess.Edit = True OrElse m_objAccess.View Then
                IsAccessForNode = True
            Else
                IsAccessForNode = False
            End If
        End If

        Return IsAccessForNode

    End Function
    '=====================================================================
    ' Procedure Name        : GetGlobalObject()	
    ' Purpose               : Function To Fill Global Object
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : July 29, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_GlobalObject = MyBase.GlobalObject()
    End Sub
    Public Sub AddRemoveFavourites()
        m_InsControlItemID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_INS_UPD_ControlMenuItem_Favorites " + m_strFavTagID + "," + m_GlobalObject.UserID.ToString + ",'" + m_strMode.ToString + "'", True)), String)
    End Sub

    'Private Sub DrawProjectSelectionDiv()
    '    '=====================================================================
    '    ' Procedure Name        : DrawProjectSelectionGrid()	
    '    ' Purpose               : Procedure to draw project selection Div
    '    ' Description           : same as above
    '    ' Parameters Passed     : None
    '    ' Returns               : None
    '    ' Parameters Affected   : None
    '    ' Assumptions           : None
    '    ' Dependencies          : None
    '    ' Author                : Amol Changle
    '    ' Created               : 17 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder
    '    Dim strSQL As New StringBuilder
    '    Dim drProject As IDataReader

    '    strSQL.Append("usp_Sel_AccessibleProjectLists_Home ")
    '    strSQL.Append(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString())
    '    strSQL.Append(",'")
    '    strSQL.Append(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "E").ToString())
    '    strSQL.Append("',")
    '    strSQL.Append(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intRoleLevel"), "0").ToString())
    '    strSQL.Append(",1,NULL,")
    '    strSQL.Append(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString())

    '    drProject = CommonFunctions.Data.GetDataReader(strSQL.ToString(), True)

    '    strHTML.Append("<div id='PopUp' style='height:400;position:absolute;z-index:1000;width:65%;left:20;top:30;BORDER: black 3px solid; BACKGROUND-COLOR: #ffffff;display:none;' class ='clsDivPopup'>")
    '    strHTML.Append(GenerateMenu())
    '    strHTML.Append("<div id='InnerPopUp' style='height:93%;width:99%;overflow:auto;position:absolute;' >")

    '    While drProject.Read()
    '        strHTML.Append("<span style='BORDER: #317082 2px solid; BACKGROUND-COLOR: #ffffff;width:100%;' onclick=""javascript:SelectProject(" + CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0").ToString() + ")"">")
    '        strHTML.Append("<table border=0 cellspacing=0 cellpadding=0 class='clsTable' width=100%>")
    '        strHTML.Append("<tr>")
    '        strHTML.Append("<td align=right>")
    '        strHTML.Append("<b>Project Code: </b>&nbsp;")
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=left>")
    '        strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectCode")))
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=right>")
    '        strHTML.Append("<b>Project Name: </b>&nbsp;")
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=left>")
    '        strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName")))
    '        strHTML.Append("</td>")
    '        strHTML.Append("</tr>")
    '        strHTML.Append("<tr>")
    '        strHTML.Append("<td align=right>")
    '        strHTML.Append("<b>Start Date: </b>&nbsp;")
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=left>")
    '        If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedStartDate")).ToString() = "" Then
    '            strHTML.Append("&nbsp;")
    '        Else
    '            strHTML.Append(CommonFunctions.Dates.CGetDate(drProject("ExpectedStartDate")))
    '        End If
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=right>")
    '        strHTML.Append("<b>End Date: </b>&nbsp;")
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=left>")
    '        If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedEndDate")).ToString() = "" Then
    '            strHTML.Append("&nbsp;")
    '        Else
    '            strHTML.Append(CommonFunctions.Dates.CGetDate(drProject("ExpectedEndDate")))
    '        End If
    '        strHTML.Append("</td>")
    '        strHTML.Append("</tr>")
    '        strHTML.Append("</table>")
    '        strHTML.Append("</span>")
    '    End While

    '    strHTML.Append("</div></div>")

    '    CommonFunctions.General.WriteHTML(strHTML.ToString())

    '    strSQL = Nothing
    '    strHTML = Nothing
    '    CommonFunctions.Data.DisposeDataReader(drProject)
    'End Sub

    'Private Sub PerformAction()
    '    '=====================================================================
    '    ' Procedure Name        : PerformAction()	
    '    ' Purpose               : Procedure to perform actions
    '    ' Description           : same as above
    '    ' Parameters Passed     : None
    '    ' Returns               : None
    '    ' Parameters Affected   : None
    '    ' Assumptions           : None
    '    ' Dependencies          : None
    '    ' Author                : Amol Changle
    '    ' Created               : 17 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================



    '    Select Case m_strAction.ToLower()

    '        Case "selectproject"
    '            Dim strProjectID As String = ""
    '            Dim strProjectName As String = ""

    '            strProjectID = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")).ToString()

    '            If strProjectID <> "" Then
    '                Session("intProjectID") = strProjectID
    '                strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ProjectName FROM tbl_PM_Project WITH (NOLOCK) WHERE ProjectID = " + strProjectID, True), "0"), String)
    '                Session("strProjectName") = strProjectName
    '                Session("intPostID") = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_EmployeeRoleOnProject " + CType(HttpContext.Current.Session("intUserID"), String) + "," + strProjectID + "," + CType(Context.Session("LoginType"), String), True), "0"), String)
    '            End If

    '            Dim strScript As New System.Text.StringBuilder
    '            strScript.Append("<Script language=javascript>" + vbCrLf)
    '            strScript.Append("window.parent.frames(0).location.href=window.parent.frames(0).location.href;" + vbCrLf)
    '            strScript.Append("</Script>" + vbCrLf)
    '            HttpContext.Current.Response.Write(strScript.ToString)
    '    End Select

    'End Sub

    'Private Function GenerateMenu() As String
    '    '=====================================================================
    '    ' function Name         : GenerateTopMenu()	
    '    ' Purpose               : To generate top and bottom menu
    '    ' Description           : same as above
    '    ' Parameters Passed     : none
    '    ' Returns               : none
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 9:57 AM 9/17/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim ArrTopMenuCaptionsList As New ArrayList
    '    Dim ArrTopMenuToolTipsList As New ArrayList
    '    Dim ArrTopMenuFunctionsList As New ArrayList

    '    ArrTopMenuCaptionsList.Add("<img src='../../Images/cssImages/Link Images/Close.gif'> Close")
    '    ArrTopMenuToolTipsList.Add("Close")
    '    ArrTopMenuFunctionsList.Add("CloseDiv_OnClick()")


    '    Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
    '    ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
    '    ArrTopMenuCaptionsList = Nothing

    '    Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
    '    ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
    '    ArrTopMenuToolTipsList = Nothing

    '    Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
    '    ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
    '    ArrTopMenuFunctionsList = Nothing
    '    Return m_objMenu.DrawMenuWithEvents(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)
    'End Function
End Class