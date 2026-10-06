Partial Public Class KM_Home
    Inherits WebPages.Template.WhizTemplate
    Private strHtml As New System.Text.StringBuilder
    Protected strSelectList As String = ""
    Private strtxtSearch As String = ""
    Private strVersionID As String = ""
    Private strAddAccess As String
    Private strEditAccess As String
    Private strDeleteAccess As String
    Private strViewAccess As String
    Private blnflag As Boolean
    Protected strProductLineID As String = ""
    Protected strProductIDs As String = ""
    Protected strProductversionIDs As String = ""
    Protected DisplayStyleProd As String = "0"
    Protected DisplayStyleProdVer As String = "0"
    Private strDispProductID() As String
    Private strDispProductVerID() As String
    Private cnt1 As Integer
    Private cnt2 As Integer
    Private strDispProd As String
    Private strDispProdVer As String
    Protected m_objAccess As New WebPage.Templates.AccessRights
    Protected m_GlobalObject As New WebPages.Template.WhizGlobal
    Protected m_strIsFavXMLHTTP As String = ""
    Protected m_strTemplateID As String = "KM"
    Protected m_searchin As String = "Text"
    Protected m_strProjectID As String = ""




    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        GetGlobalObject()
        m_strProjectID = m_GlobalObject.ProjectID.ToString

    End Sub
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_GlobalObject = MyBase.GlobalObject()
    End Sub
    Public Sub WritePage()

        m_strIsFavXMLHTTP = CommonFunction.General.CheckIsNothing(Request("IsFavXMLHTTP"))

        If m_strIsFavXMLHTTP = "1" Then
            Response.Clear()
            '---Modified by purvaj on 14 Jul 2009 Favourites displayed in all the tabs.
            Response.Write((New Home_FloatingMenu).DrawFavoriateTabs(m_strTemplateID.ToUpper)) '"PM"
            '--- End modifiaction purvaj
            Response.End()
            Exit Sub
        End If



        Dim drAccess As IDataReader

        If CommonFunction.General.CheckIsNothing(Request.QueryString("SelectList"), "") <> "" Then
            strSelectList = Request.QueryString("SelectList").ToString
        Else
            strSelectList = Request.Form("hidSelectList").ToString
        End If
        m_searchin = CommonFunction.General.CheckIsNothing(Request.QueryString("Search"), "Text")

        If CommonFunction.General.CheckIsNothing(Request.Form("txtSearch"), "") <> "" Then
            strtxtSearch = Request.Form("txtSearch").ToString
            'ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("txtSearch"), "") <> "" Then
            '    strtxtSearch = Request.QueryString("txtSearch").ToString
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("VersionNumber"), "") <> "" Then
            strVersionID = Request.QueryString("VersionNumber")
        End If

        drAccess = CommonFunction.Data.GetDataReader("usp_Check_Role_Access 2349," + HttpContext.Current.Session("intPostID").ToString + "," + HttpContext.Current.Session("intUserID").ToString + "," + HttpContext.Current.Session("LoginType").ToString, MyBase.UseSQL)
        If drAccess.Read Then
            strAddAccess = drAccess("A").ToString
            strEditAccess = drAccess("E").ToString
            strDeleteAccess = drAccess("D").ToString
            strViewAccess = drAccess("V").ToString
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("DisplayStyleProd"), "") <> "" Then
            DisplayStyleProd = Request.QueryString("DisplayStyleProd")
            strDispProductID = DisplayStyleProd.Split("|")
            For cnt1 = 0 To strDispProductID.Length - 1
                If strDispProductID(0) = "x" Then
                    DisplayStyleProd = ""
                End If
                strDispProd = strDispProductID(1)
                Exit For
            Next
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("DisplayStyleProdVer"), "") <> "" Then
            DisplayStyleProdVer = Request.QueryString("DisplayStyleProdVer")
            strDispProductVerID = DisplayStyleProdVer.Split("|")
            For cnt2 = 0 To strDispProductVerID.Length - 1
                If strDispProductVerID(0) = "y" Then
                    DisplayStyleProdVer = ""
                End If
                strDispProdVer = strDispProductVerID(1)
                Exit For
            Next
        End If


        If strAddAccess = "0" And strEditAccess = "0" And strDeleteAccess = "0" And strViewAccess = "0" Then
            blnflag = True
        End If


        Call DrawHeader()
        Call DrawHomePage()

        CommonFunction.Data.DisposeDataReader(drAccess)

    End Sub
    Private Sub DrawHomePage()
        Dim strStyleSheet As String
        Dim strColor As String
        Dim strSQl_ProductLine As String
        Dim strSQL_Product As String
        Dim strSQL_ProductVersion As String
      
        Dim IsProductLinePresent As String
        Dim IsProduct As String
        Dim strSQL As String
        Dim IsProductExecution As String
        '--- Added By purvaj on 21 jul 09 SEM 8.1 New ui show module icons  in the left
        Dim strNavigationMenu As String = ""
        Dim objSystemModulesAry() As CommonEngines.HashTables.SystemModules
        Dim strImage As String = ""
        Dim intCount As Integer = 0
        Dim strBackGroundImage As String = ""
        '-- End addition purvaj

        Dim strIsCreatedByCustomer As String = "0"
        If CType(Session("IsCreatedByCustomer"), Boolean) Then
            strIsCreatedByCustomer = "1"
        Else
            strIsCreatedByCustomer = "0"
        End If

        strStyleSheet = CommonFunction.Data.GetDataScalar("usp_get_StyleSheet " + HttpContext.Current.Session("intUserID").ToString + ",N'" + HttpContext.Current.Session("LoginType").ToString + "'," + strIsCreatedByCustomer, MyBase.UseSQL)

        If strStyleSheet = "StyleSheetChanakya.css" Then
            strColor = "MenuDefault.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_BrickRed.css" Then
            strColor = "Menured.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_BurntSienna.css" Then
            strColor = "MenuBurntSienna.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_Green.css" Then
            strColor = "MenuGreen.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_Purple.css" Then
            strColor = "MenuPurple.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_GYellow.css" Then
            strColor = "MenuYellow.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_turquoise.css" Then
            strColor = "MenuTurquoise.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_black.css" Then
            strColor = "MenuGray.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_white.css" Then
            strColor = "MenuClassic.gif"
        Else
            strColor = "MenuDefault.gif"
        End If

        ''HEIGHT:450px;
        strHtml.Append("<DIV Id=divPage Style='WIDTH:99.99%;vertical-align:top;'>" + vbCrLf)
       
        strHtml.Append("<table id=tblMain name=tblMain class='clsTable' CellSpacing='0' CellPadding=0  width=99.99% height='99.99%' border='1'>" + vbCrLf)
        ''HEIGHT: 5px;
        'strHtml.Append("<tr id=trMain name=trMain style='PADDING-RIGHT: 2pt;PADDING-LEFT: 2pt;FONT-SIZE: 8pt;PADDING-BOTTOM: 2pt;MARGIN: 2pt;PADDING-TOP: 2pt;BACKGROUND-REPEAT: repeat;FONT-FAMILY: Verdana, Arial;'>" + vbCrLf)
        strHtml.Append("<tr id=trMain name=trMain >" + vbCrLf)
        strHtml.Append("<td id=tdMainLeft name=tdMainLeft style='border-right:solid 1px #989898;' valign=top width='200px'>" + vbCrLf)

        '''strHtml.Append("<table id=tblSearch name=tblSearch class='clsTable' CellSpacing='0' CellPadding=0  width=100% >" + vbCrLf)

        '''strHtml.Append("<tr id=trLeft2 name=trLeft2 >" + vbCrLf)
        '''strHtml.Append("<td nowrap id=tdLeft2 name=tdLeft2 align='left' style='font-weight :lighter ; font-family:Tahoma ;  font-size:11px;'>" + vbCrLf)
        '''strHtml.Append(CommonFunction.HTMLControls.DrawTextBox("txtsearch", "txtsearch", "clsTextBox", 120, 200, strtxtSearch, "left", , , , , , "onkeypress=javascript:textSearch_OnKeyPress(event) style='height:20px;'", True) + vbCrLf)
        '''''strHtml.Append("<a href='javascript:Go_OnClick()'><Img Border=0 alt='Search Pages' src='../../Images/Home/Search.gif' /></a>" + vbCrLf)
        '''strHtml.Append("&nbsp;<input type='button' value='Search' style='height:22px;' onclick='javascript:Go_OnClick()' text='Search' title='Search'>")

        '''strHtml.Append("</td>" + vbCrLf)
        ''''''
        '''strHtml.Append("</tr >")
        ''''''
        '''strHtml.Append("</Table>")
        strHtml.Append("<TABLE cellSpacing=0 cellPadding=1 valign='top' width='100%' align=center class='clsTable' border='0'>")
        strHtml.Append("<tr >")
        strHtml.Append("<TD valign='top'>")
        strHtml.Append(DrawKMTree())
        strHtml.Append("</td>" + vbCrLf)

        strHtml.Append("</tr>")

        strHtml.Append("<tr>")
        strHtml.Append("<td vAlign=top>")
        strHtml.Append(GetModules())
        strHtml.Append("</td>")
        strHtml.Append("</tr>")

        strHtml.Append("</table>")

        '--- Added By purvaj on 21 jul 09 SEM 8.1 New ui show module icons  in the left
        strHtml.Append("</td>")
        strHtml.Append("<td style='vertical-align:bottom;display:none;' id='tblLeftNavigation'  height='100%' >")
        If CType(MyBase.DefaultUILCID, Integer) = MyBase.CurrentThreadUICultureID Then
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
        Else
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules" + MyBase.CurrentThreadUICultureID.ToString)
            If objSystemModulesAry Is Nothing Then
                objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
            End If
        End If

        strHtml.Append("<TABLE cellSpacing=0 cellPadding=0 width='100%' height='100%' align=center class='clsTable' border='0'>")
        ''Added and commented by PrashantSJ on 21st Aug 2009
        'strHtml.Append("<tr valign=top style='text-align:center;background-attachment: fixed;background-image:url(""../../Images/Home/" + strColor.ToString + """) ;background-position:Left; '>")
        strHtml.Append("<tr valign=top class='clsTRGroupHeader' style='text-align:center;'>")
        ''Added and commented by PrashantSJ on 21st Aug 2009
        strHtml.Append("<td valign='middle' align=center style='border-bottom:1px solid gray;cursor:pointer;' onclick='javascript:HideTree()' text='Navigation Pane' class='clsMenu'> ")
        'm_sBHTML.Append("<A valign='middle' style='text-decoration:none;' Title='Navigation Pane' class='clsMenu' href='javascript:HideTree()'><img src='../../Images/Home/NavigationPane.gif' border=0></a>")
        strHtml.Append("<img src='../../Images/Home/NavigationPane.gif' border=0>")
        strHtml.Append("</td>")
        strHtml.Append("</tr>")
        For intCount = 0 To objSystemModulesAry.Length - 1
            If Not objSystemModulesAry Is Nothing Then
                ''And GetTagAccessRights(objSystemModulesAry(intCount).ModuleTagID, True)
                If Not objSystemModulesAry(intCount).HideModuleNameOnTab And (objSystemModulesAry(intCount).ShortName.ToUpper <> "BTS" And objSystemModulesAry(intCount).ShortName <> "DT" And objSystemModulesAry(intCount).ShortName <> "SU") Then

                    Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, objSystemModulesAry(intCount).ModuleTagID, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString)
                    'Create the object of GetAccess class
                    Dim objGetAccess As New WebPage.Templates.AccessRights
                    'Call method get access to get the access
                    objGetAccess.GetAccess(objGlobal, True)

                    If Not objGetAccess.Access Or (objSystemModulesAry(intCount).ShortName = "SM" And CType(Session("IsCreatedByCustomer"), Boolean) = True) Then
                        Continue For
                    End If

                    If objSystemModulesAry(intCount).ShortName.ToUpper = "PM" Then
                        strImage = "../../Images/dc.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SM" Then
                        strImage = "../../Images/cssImages/Link images/config.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "FA" Then
                        strImage = "../../Images/RDB_Outstanding2.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "RM" Then
                        strImage = "../../Images/cssImages/WF_UserStage_Old.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "MR" Then
                        strImage = "../../Images/cssImages/Link images/graph.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "PRO" Then
                        strImage = "../../Images/TimeSheet.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SU" Then
                        strImage = "../../Images/cssImages/Link images/config.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "CRM" Then
                        strImage = "../../Images/template.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "KM" Then
                        strImage = "../../Images/bs.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "DB" Then
                        strImage = "../../Images/Home/home.jpg"
                    End If

                    ''Added and commented by PrashantSJ on 21st Aug 2009
                    'strHtml.Append("<tr class=clsTREven style='text-align:center;background-attachment: fixed;background-image:url(""../../Images/Home/" + strColor.ToString + """) ;background-position:Left;'>") 'class=clsTREven
                    strHtml.Append("<tr valign=bottom class='clsTRGroupHeader' style='text-align:center;background-attachment: fixed;'>")
                    ''Added and commented by PrashantSJ on 21st Aug 2009
                    strHtml.Append("<td style='border-bottom:1px solid gray;'>")
                    'strHtml.Append("<A style='text-decoration:none;' Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ToolTip)) & "' class='clsMenu' href='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'><img src='" + strImage + "' border=0 style=""vertical-align:bottom;align:left;""></a>")
                    strHtml.Append("<A valign=bottom style='text-decoration:none;' onmouseover='this.style.backgroundColor=""#FFD695""' onmouseout='this.style.backgroundColor=""""' Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ToolTip)) & "' class='clsMenu' href='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'><img src='" + strImage + "' border=0 style=""vertical-align:bottom;align:left;""></a>")
                    strHtml.Append("</td>")
                    strHtml.Append("</tr>")
                End If
            End If
        Next
        strHtml.Append("</table>")
        '-- End addition purvaj


        strHtml.Append("</td>" + vbCrLf)

        ' allow resource to open close the menu.
        'strHtml.Append("<TD ID='tdDot1' name='tdDot1' vAlign=top width=1px   background='../../Images/Home/dot2.gif' onclick='javascript:ShowTree()'><a name='aShowTree' id='aShowTree' style=""text-decoration:none;"" href='javascript:HideTree()' ><img ID='ImgShowHide' src='../../Images/ScrollLeft.gif' border=0 /></a></TD>")
        strHtml.Append("<TD ID='tdDot1' title='Show / Hide Tree' name='tdDot1' class='clsTDScroll' onclick='javascript:HideTree()' onmouseover='SetRollOverTD(this,event,1)' onmouseout='SetRollOverTD(this,event,2)' style='cursor:hand;align:center;vAlign:center;' >")
        strHtml.Append("<img ID='ImgShowHide' title='Show / Hide Tree' src='../../Images/Home/LeftMove.gif' border=0 style=""vertical-align:middle;align:center;padding-left:0px;padding-bottom:0px;padding-right:0px;padding-top:0px;""/>")
        strHtml.Append("</TD>")


        strHtml.Append("<td id=tdMainRight valign=top name=tdMainRight height='99.99%' width='99.99%'>" + vbCrLf)
        If strSelectList = "1" Then
            'strHtml.Append(KM_List.FeaturedArticle_NewUI())
            strHtml.Append("<iframe name='iTabDetails' id='iTabDetails'   src='../Km/Km_List.aspx?Fromwhere=LatestFeatured&SelectList=1&txtSearch=" + IIf(m_searchin = "Text", HttpContext.Current.Server.UrlEncode(strtxtSearch), "") + "' scrolling='yes' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;height:100%;background-color:#FBFBFB'>" + vbCrLf)
            strHtml.Append("</iframe>" + vbCrLf)
        ElseIf strSelectList = "2" Then
            strHtml.Append("<iframe name='iTabDetails' id='iTabDetails'   src='../Km/Km_List.aspx?Fromwhere=TopTen&SelectList=2&txtSearch=" + IIf(m_searchin = "Text", HttpContext.Current.Server.UrlEncode(strtxtSearch), "") + "' scrolling='yes' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;height:100%;background-color:#FBFBFB'>" + vbCrLf)
            strHtml.Append("</iframe>" + vbCrLf)
        ElseIf strSelectList = "3" Then
            strHtml.Append("<iframe name='iTabDetails' id='iTabDetails'   src='../Km/Km_List.aspx?Fromwhere=Search&SelectList=3&txtSearch=" + IIf(m_searchin = "Text", HttpContext.Current.Server.UrlEncode(strtxtSearch), "") + "' scrolling='yes' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;height:100%;background-color:#FBFBFB'>" + vbCrLf)
            strHtml.Append("</iframe>" + vbCrLf)
        ElseIf strSelectList = "4" Then
            strHtml.Append("<iframe name='iTabDetails' id='iTabDetails'   src='../km/KM_List.aspx?PageNumber=1&Fromwhere=MyArticle&Tab=MY&Subtab=MY PAGES&SelectList=4&txtSearch=" + IIf(m_searchin = "Text", HttpContext.Current.Server.UrlEncode(strtxtSearch), "") + "' scrolling='yes' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;height:100%;background-color:#FBFBFB'>" + vbCrLf)
            strHtml.Append("</iframe>" + vbCrLf)
        ElseIf strSelectList = "5" Then
            strHtml.Append("<iframe name='iTabDetails' id='iTabDetails'   src='../km/KM_List.aspx?PageNumber=1&Fromwhere=MySpace&Tab=MY&Subtab=MY SPACES&SelectList=5&txtSearch=" + IIf(m_searchin = "Text", HttpContext.Current.Server.UrlEncode(strtxtSearch), "") + "' scrolling='yes' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;height:100%;background-color:#FBFBFB'>" + vbCrLf)
            strHtml.Append("</iframe>" + vbCrLf)
        ElseIf strSelectList = "6" Then
            strHtml.Append("<iframe name='iTabDetails' id='iTabDetails'   src='../km/KM_List.aspx?PageNumber=1&Fromwhere=MyTeam&Tab=MY&Subtab=MY TEAMS&SelectList=6&txtSearch=" + IIf(m_searchin = "Text", HttpContext.Current.Server.UrlEncode(strtxtSearch), "") + "' scrolling='yes' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;height:100%;background-color:#FBFBFB'>" + vbCrLf)
            strHtml.Append("</iframe>" + vbCrLf)
        ElseIf strSelectList = "8" Then
            If blnflag = True Then
                strHtml.Append("<iframe name='iTabDetails' id='iTabDetails'   src='../General/CommonPage.aspx?MasterTagID=1836' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;height:100%;background-color:#FBFBFB'>" + vbCrLf)
                strHtml.Append("</iframe>" + vbCrLf)
            Else
                strHtml.Append("<iframe name='iTabDetails' id='iTabDetails'   src='../General/CommonPage.aspx?MasterTagID=2349&FromWhere=SM&PagingAlphabet=&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&ProductVersionID_PK=" + strVersionID + "' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;height:100%;background-color:#FBFBFB'>" + vbCrLf)
                strHtml.Append("</iframe>" + vbCrLf)
            End If
        ElseIf strSelectList = "9" Then
            strHtml.Append("<iframe name='iTabDetails' id='iTabDetails'   src='../km/KM_List.aspx?Tab=MY&Subtab=MY STATISTICS&SelectList=6&txtSearch=" + IIf(m_searchin = "Text", HttpContext.Current.Server.UrlEncode(strtxtSearch), "") + "' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;height:100%;background-color:#FBFBFB'>" + vbCrLf)
            strHtml.Append("</iframe>" + vbCrLf)
        End If
        'strHtml.Append("<iframe name='iTabDetails' id='iTabDetails' onLoad='calcHeight()'  src='' scrolling='yes' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;'>" + vbCrLf)
        'strHtml.Append("</iframe>" + vbCrLf)
        strHtml.Append("</td>" + vbCrLf)
        strHtml.Append("</tr>" + vbCrLf)
        strHtml.Append("</table>" + vbCrLf)
        strHtml.Append("</div>" + vbCrLf)

        Response.Write(strHtml.ToString)

        CommonFunction.General.WriteHTML("<input type=hidden name=hidSelectList id=hidSelectList value=" + Request.QueryString("SelectList") + ">" + vbCrLf)
        'strProductLineID
        CommonFunction.General.WriteHTML("<input type=hidden name=hidProductLineID id=hidProductLineID value=" + strProductLineID + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidProductVersionIDs id=hidProductVersionIDs value=" + strProductversionIDs + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidProductIDs id=hidProductIDs value=" + strProductIDs + ">" + vbCrLf)


        DrawKMTree()
    End Sub
    Private Function GetModules() As String
        '=====================================================================
        ' Function  Name		:	GetModules()
        ' Parameters Passed		:	TagID
        ' Returns				:	To return system modules 
        ' Parameters Affected	:	None
        ' Purpose				:	To return system modules 
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	June 26 2009
        ' Revisions				:	
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Dim intCount As Integer = 0
        Dim strImage As String = ""
        Dim strModuleList As String = ""

        Dim objSystemModulesAry() As CommonEngines.HashTables.SystemModules

        If CType(MyBase.DefaultUILCID, Integer) = MyBase.CurrentThreadUICultureID Then
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
        Else
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules" + MyBase.CurrentThreadUICultureID.ToString)
            If objSystemModulesAry Is Nothing Then
                objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
            End If
        End If

        If Not objSystemModulesAry Is Nothing Then
            strHTML.Append("<div id='trGM' style='width:100%;'>")
            strHTML.Append("<Table border=0 cellspacing=0 cellpadding=0 width='99.9%' class='clsTable' valign='bottom'>")
            strHTML.Append("<TR  >")
            strHTML.Append("<Td  style='height:3%;' class='clsTDScroll' align='center' colspan='2' title='Enlarge/Shrink module bar' onclick='javascript:ShowHideModules(this)' style='cursor:hand;' onmouseover='SetRollOverTD(this,event,1)' onmouseout='SetRollOverTD(this,event,2)'>")
            strHTML.Append("...<img id='imgUpDown' alt='Enlarge/Shrink module bar' src='../../Images/Sort_down.gif' border=0 style=""vertical-align:middle;align:center;"" />...")
            strHTML.Append("</Td>")
            strHTML.Append("</TR>")
            strHTML.Append("<TR  id='trModuleBar' class='clsTRMenu' style='display:none;'>")
            strHTML.Append("<Td id='tdModuleBar' align='center' colspan='2' >")
            strHTML.Append("</Td>")
            strHTML.Append("</TR>")


            For intCount = 0 To objSystemModulesAry.Length - 1
                ''And GetTagAccessRights(objSystemModulesAry(intCount).ModuleTagID, True) 
                If Not objSystemModulesAry(intCount).HideModuleNameOnTab And (objSystemModulesAry(intCount).ShortName.ToUpper <> "BTS" And objSystemModulesAry(intCount).ShortName <> "DT" And objSystemModulesAry(intCount).ShortName <> "SU") Then
                    Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, objSystemModulesAry(intCount).ModuleTagID, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString)
                    'Create the object of GetAccess class
                    Dim objGetAccess As New WebPage.Templates.AccessRights
                    'Call method get access to get the access
                    objGetAccess.GetAccess(objGlobal, True)

                    If Not objGetAccess.Access Or (objSystemModulesAry(intCount).ShortName = "SM" And CType(Session("IsCreatedByCustomer"), Boolean) = True) Then
                        Continue For
                    End If

                    If objSystemModulesAry(intCount).ShortName.ToUpper = "PM" Then
                        strImage = "../../Images/dc.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SM" Then
                        strImage = "../../Images/cssImages/Link images/config.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "FA" Then
                        strImage = "../../Images/RDB_Outstanding2.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "RM" Then
                        strImage = "../../Images/cssImages/WF_UserStage_Old.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "MR" Then
                        strImage = "../../Images/cssImages/Link images/graph.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "PRO" Then
                        strImage = "../../Images/TimeSheet.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SU" Then
                        strImage = "../../Images/cssImages/Link images/config.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "CRM" Then
                        strImage = "../../Images/template.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "KM" Then
                        strImage = "../../Images/bs.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "DB" Then
                        strImage = "../../Images/Home/home.jpg"
                    End If

                    strModuleList += "<A style='text-decoration:none;' Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ToolTip)) & "' onmouseover='this.style.backgroundColor=""#FFD695""' onmouseout='this.style.backgroundColor=""""' class='clsMenu' href='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'><img src='" + strImage + "' border=0 style=""vertical-align:bottom;align:left;""></a>" ''+ "&nbsp;&nbsp;"
                    If CType(Session("strActiveModule"), String) = objSystemModulesAry(intCount).ShortName Then
                        strHTML.Append("<TR class='clsTRMenuMouseOver' id='trModules' name='trModules' >")
                    Else
                        strHTML.Append("<TR class='clsTRMenu' id='trModules' name='trModules' onmouseover='javascript:ModulesOnMouseOver(this)' onmouseout='javascript:ModulesOnMouseOut(this)'>")
                    End If


                    strHTML.Append("<Td align='left' style='height:15%;width:10%'>")
                    strHTML.Append("<img src='" + strImage + "' border=0 style=""vertical-align:bottom;align:left;"">")
                    strHTML.Append("</Td>")

                    strHTML.Append("<Td align='left' onclick='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")' style='cursor:hand;text-align:left;width:90%;height:15%;' id='iMenu'>")
                    'strHTML.Append("<A class='Menu' style='TEXT-DECORATION:NONE' onmouseover='this.style.backgroundColor='#FFD695'' onmouseout='this.style.backgroundColor='''  Title='Configuration' >")



                    strHTML.Append("<A style='text-decoration:none;width:170px;' class='clsMenu'")
                    '''If CType(Session("strActiveModule"), String) = objSystemModulesAry(intCount).ShortName Then
                    '''    'strHTML.Append(" class='clsSelected' ")
                    '''    ' strHTML.Append(" class='clsSelected' ") ''clsLinkSelectedNavMenu

                    '''Else
                    '''    strHTML.Append(" class='clsMenu' ")
                    '''End If

                    strHTML.Append(" Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ToolTip)) & "' ")
                    strHTML.Append(" href='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'>")

                    'strHTML.Append("<b>")
                    ''Tahoma
                    'If CType(Session("strActiveModule"), String) = objSystemModulesAry(intCount).ShortName Then
                    '    strHTML.Append("<i>")
                    '    strHTML.Append(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ModuleName)))
                    '    strHTML.Append("</i>")
                    'Else
                    strHTML.Append(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ModuleName)))
                    'End If
                    'strHTML.Append("</b>")

                    strHTML.Append("</A>")
                    strHTML.Append("</Td>")
                    strHTML.Append("</TR>")
                End If
            Next
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidTxtModules", "hidTxtModules", , , , strModuleList, , , , , , True, , True))
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidTxtModules", "hidTxtModules", , , , strModuleList, , , , , , True, , True, EnableHTMLEncode:=True))
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            strHTML.Append("</Table>")
            strHTML.Append("</div>")
        End If
        GetModules = strHTML.ToString
        objSystemModulesAry = Nothing
        strHTML = Nothing
    End Function
    Private Function GetTagAccessRights(ByVal lngTagID As Long, Optional ByVal IsModuleAccess As Boolean = True) As Boolean
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
        Dim m_objAccess As New WebPage.Templates.AccessRights

        Dim IsAccessForNode As Boolean

        If lngTagID <= 0 Then
            IsAccessForNode = True
        Else
            m_GlobalObject.TagID = lngTagID
            'Get the Access Rights 

            m_objAccess.GetAccess(m_GlobalObject, IsModuleAccess)

            If IsModuleAccess Then
                Return m_objAccess.Access()
            End If

            If m_objAccess.Add = True OrElse m_objAccess.Delete = True OrElse m_objAccess.Edit = True OrElse m_objAccess.View Then
                IsAccessForNode = True
            Else
                IsAccessForNode = False
            End If
        End If

        Return IsAccessForNode

    End Function
    Protected Function DrawKMTree() As StringBuilder
        Dim strScript As New StringBuilder()
        Dim IsProductLinePresent As Long
        Dim strSearch = CommonFunction.General.CheckIsNothing(Request.Form("txtSearch"), "")

        strScript.Append("<script type='text/javascript'>")
        strScript.Append(vbCrLf)
        strScript.Append("var Tree = new Array;")
        strScript.Append("var NewTree=new Array; ")
        strScript.Append(vbCrLf)
        strScript.Append("// nodeId | parentNodeId | nodeName | nodeUrl |Tooltip |IsParent |TreeNodeImagePath")
        strScript.Append(vbCrLf)
        strScript.Append("Tree[0]=""-1|0|Knowledge||Knowledge|-1|page.gif|-1"";")


        strScript.Append(vbCrLf)
        strScript.Append("Tree[1]=""-2|-1|Navigation||Knowledge|-1|page.gif|-1"";")
        strScript.Append(vbCrLf)

        strScript.Append(vbCrLf)
        strScript.Append("Tree[2]=""-3|-2|Home|javascript:Home_OnClick()|Knowledge|-1|page.gif|0"";")
        strScript.Append(vbCrLf)

        strScript.Append("Tree[3]=""-4|-2|Top 10 Articles|javascript:TopTen_OnClick()|Knowledge|-1|page.gif|0"";")
        strScript.Append(vbCrLf)

        strScript.Append("Tree[4]=""-5|-2|My Articles|javascript:MyArticle_OnClick()|Knowledge|-1|page.gif|0"";")
        strScript.Append(vbCrLf)

        strScript.Append("Tree[5]=""-6|-2|My Spaces|javascript:MySpace_OnClick()|Knowledge|-1|page.gif|0"";")
        strScript.Append(vbCrLf)

        strScript.Append("Tree[6]=""-7|-2|My Team's|javascript:MyTeam_OnClick()|Knowledge|-1|page.gif|0"";")
        strScript.Append(vbCrLf)

        strScript.Append("Tree[7]=""-8|-2|Statistics|javascript:Statistics_OnClick()|Knowledge|-1|page.gif|0"";")
        strScript.Append(vbCrLf)


        Dim cntProductTree As Long = 9
        Dim arropenproductLines As String = ""
        If CommonFunction.Application.EnableProductExecution = True And HttpContext.Current.Session("LoginType").ToString = "E" Then

            Dim objProductDs As DataSet
            If strSearch <> "" And m_searchin = "Tree" Then
                objProductDs = CommonFunction.Data.GetDataSet(" usp_SEL_KM_ProductTree '" + CommonFunction.General.BuildQueryString(strSearch) + "'", MyBase.UseSQL)
            Else
                objProductDs = CommonFunction.Data.GetDataSet(" usp_SEL_KM_ProductTree ", MyBase.UseSQL)
            End If


            strScript.Append("Tree[8]=""-10|-1|Product Collateral||Knowledge|-1|page.gif|-1"";")
            arropenproductLines += "-10"
            strScript.Append(vbCrLf)

            For Each drProductLine As DataRow In objProductDs.Tables(0).Rows

                strScript.Append("Tree[").Append(cntProductTree).Append("]=""-100").Append(drProductLine("ProductLineID").ToString).Append("|-10|")
                strScript.Append(drProductLine("ProductLine").ToString())
                strScript.Append("||Knowledge|-1|page.gif|-1"";")
                strScript.Append(vbCrLf)
                arropenproductLines += "," + "-100" + drProductLine("ProductLineID").ToString
                cntProductTree += 1

                For Each drProduct As DataRow In objProductDs.Tables(1).Select("ProductLineID = " + drProductLine("ProductLineID").ToString())
                    strScript.Append("Tree[")
                    strScript.Append(cntProductTree)
                    strScript.Append("]=""-200")
                    strScript.Append(drProduct("ProductID").ToString)
                    strScript.Append("|-100")
                    strScript.Append(drProductLine("ProductLineID").ToString)
                    strScript.Append("|")
                    strScript.Append(drProduct("Product").ToString())
                    strScript.Append("||Knowledge|-1|page.gif|-1"";")
                    strScript.Append(vbCrLf)
                    arropenproductLines += "," + "-200" + drProduct("ProductID").ToString
                    cntProductTree += 1
                    
                    For Each drProductVersion As DataRow In objProductDs.Tables(2).Select("ProductID= " + drProduct("ProductID").ToString)

                        strScript.Append("Tree[")
                        strScript.Append(cntProductTree)
                        strScript.Append("]=""-300")
                        strScript.Append(drProductVersion("ProductVersionID").ToString)
                        strScript.Append("|-200")
                        strScript.Append(drProduct("ProductID").ToString)
                        strScript.Append("|")
                        strScript.Append(drProductVersion("ProductVersion").ToString())
                        strScript.Append("|")
                        strScript.Append("javascript:ProdVersion_OnClick(" + drProductLine("ProductLineID").ToString() + "," + drProduct("ProductID").ToString + "," + drProductVersion("ProductVersionID").ToString + ")")
                        strScript.Append("|Knowledge|-1|page.gif|0"";")
                        strScript.Append(vbCrLf)
                        arropenproductLines += "," + "-300" + drProductVersion("ProductVersionID").ToString
                        cntProductTree += 1
                    Next

                Next

            Next
            objProductDs.Dispose()

        End If

        strScript.Append("</script> " + vbCrLf)

        ''strScript.Append(" <div id='tree' style='overflow:auto;height:99.99%;width:200px'>" + vbCrLf)
        strScript.Append(" <div id='tree' valign='top' style='overflow:auto;width: 200px;'>" + vbCrLf)
        strScript.Append(" </div> " + vbCrLf)

        strScript.Append(" <script type='text/javascript'>" + vbCrLf)
        'strScript.Append(" <!--" + vbCrLf)
        strScript.Append("  var objfrm;" + vbCrLf)
        strScript.Append(" var objdivlist;" + vbCrLf)
        strScript.Append("  objfrm = GetFormReference('frmTree'); " + vbCrLf)
        strScript.Append(" objdivlist=GetObjectReference('frmTree','tree'); " + vbCrLf)
        strScript.Append(" if(navigator.appName != 'Microsoft Internet Explorer')" + vbCrLf)
        strScript.Append(" { " + vbCrLf)
        ' strScript.Append(" objdivlist.style.overflow='auto'; " + vbCrLf)
        'strScript.Append(" objdivlist.style.height=520; " + vbCrLf)
        'strScript.Append(" objdivlist.style.height=520; " + vbCrLf)
        strScript.Append(" }" + vbCrLf)

        strScript.Append("EndIndex = Tree.length; " + vbCrLf)

        strScript.Append("HTML=createSearchTree(Tree,'');")

        strScript.Append("objdivlist.innerHTML=HTML;")

        strScript.Append(" " + vbCrLf)
        strScript.Append(" oc(-1,1,'page.gif');")
        strScript.Append(" " + vbCrLf)
        strScript.Append(" oc(-2,1,'page.gif');")
        strScript.Append(" " + vbCrLf)
        If strSearch = "" Then
            strScript.Append(" oc(-10,1,'page.gif');")
            strScript.Append(" " + vbCrLf)
        End If


        For Each productline As String In arropenproductLines.Split(","c)
            If productline <> "" Then
                strScript.Append(" oc(")
                strScript.Append(productline)
                strScript.Append(",1,'page.gif');")
                strScript.Append(" " + vbCrLf)
            End If
        Next

        strScript.Append("</script> " + vbCrLf)


        Return strScript
    End Function

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
        Dim strDashBoardID As String = ""
        sbH.Append("<div id='divHeader' style='width:100%;valign:top;'>")

        sbH.Append("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0   class='clsGridTable' width=100%  style=""BORDER-BOTTOM: black 1px outset; "">")
        sbH.Append("<TR class='clsTRBlank'>")

        sbH.Append("<TD class='clsTDBlank'  style=""valign:bottom;align:left"" >")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''sbH.Append(CommonFunction.HTMLControls.DrawTextBox("txtsearch", "txtsearch", "clsTextBox", 120, 200, strtxtSearch, "left", , , , , , "onkeypress=javascript:textSearch_OnKeyPress(event) style='height:20px;'", True) + vbCrLf)
        sbH.Append(CommonFunction.HTMLControls.DrawTextBox("txtsearch", "txtsearch", "clsTextBox", 120, 200, strtxtSearch, "left", , , , , , "onkeypress=javascript:textSearch_OnKeyPress(event) style='height:20px;'", True, EnableHTMLEncode:=True) + vbCrLf)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''strHtml.Append("<a href='javascript:Go_OnClick()'><Img Border=0 alt='Search Pages' src='../../Images/Home/Search.gif' /></a>" + vbCrLf)
        sbH.Append("&nbsp;<input type='button' value='Search Tree' style='height:22px;' onclick='javascript:Go_OnClick(1)' text='Search Tree' title='Search Tree'>")
        sbH.Append("&nbsp;<input type='button' value='Search Text' style='height:22px;' onclick='javascript:Go_OnClick(2)' text='Search Text' title='Search Text'>")
        sbH.Append("</Td>")

        sbH.Append("<TD class='clsTDBlank'  style=""valign:bottom;align:right"">") ''
        sbH.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousFAV()"" Title=""Previous Favorites"" onmouseover=""window.status='Previous Favorites';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbH.Append("<Img id='prevLeft' Border=0 src='../../Images/Home/roundleft.gif' align='top'></A>")
        sbH.Append("</Td>")
        sbH.Append("<TD id='tdTabs' class='clsTDBlank'  style=""valign :bottom;align:right;white-space:nowrap;"">")
        sbH.Append((New Home_FloatingMenu).DrawFavoriateTabs("KM", Request.Browser.Browser.ToString))

        sbH.Append("</Td>")
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


        '''''''''''''''PrashantSJ 20th May 2009

        sbH.Append("<TD class='clsTDBlank'  style=""valign:bottom;text-align:left;"">")
        sbH.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextFAV()"" Title=""Next Favorites"" onmouseover=""window.status='Next Favorites';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbH.Append("<Img id='prevRight' Border=0 src='../../Images/Home/roundright.gif' align='top'></A>&nbsp;&nbsp; ")
        sbH.Append("<a href=""#""  title='Manage Favourites' onclick='javascript:ShowFloatingmenu(""GoTo"",event)' style=""text-decoration:none;vertical-align:bottom;""><img src='../../Images/Home/Favorites.gif' border=0 style=""vertical-align:top""></a>") '&nbsp;&nbsp;&nbsp;")
        sbH.Append("</td>")

        '''--ElseIf m_strTemplateID.ToUpper = "DB" Then

        '''''''''''''''''End modification purvaj

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

End Class