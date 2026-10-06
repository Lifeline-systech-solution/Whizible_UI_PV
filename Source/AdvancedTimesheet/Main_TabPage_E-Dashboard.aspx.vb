Public Class Main_TabPage_EDashboard
    Inherits WebPages.Template.WhizTemplate
#Region "Member variables"
    Protected sbHTML As StringBuilder
    Protected m_strDefaultPageURL As String = ""
    Protected m_strSQL As String = ""
    Protected dsGroupTab As DataSet
    Protected dsTabItems As DataSet
    Private dsTemp As DataSet
    Protected m_strGroupTabID As String = ""
    Protected IsFirstHit As Boolean
    Protected m_strTabGroupItemID As String = ""
    Protected m_objAccess As New WebPage.Templates.AccessRights
    Protected m_GlobalObject As New WebPages.Template.WhizGlobal
    Protected RecordCount As Integer = 0

    Protected IsAccessForNode As Boolean

    Protected m_intPageNumber As Integer = 0
    Protected m_intRowCount As Integer = 0
    Protected dblRatio As Double = 0.0
    Protected m_strIsXMLHTTP As String = ""
    Protected m_lngPostID As Long = 0

#End Region
#Region "CONSTANTS"
    Protected Const PAGE_SIZE As Integer = 5
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


    End Sub
    Protected Sub PageInit()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        Initialize_Variables()

        DrawHiddenFields()

        WritePage()



        DisposeNotUsedObjects()

    End Sub
    Protected Function DrawOfficeUI()
        Dim sbHTML1 As New StringBuilder

        sbHTML1.Append("<TABLE id=Attachment cellspacing=1 cellpadding=1 width='20%'  class='clstable'><TR class='clsTREven'>")
        sbHTML1.Append("<TD align=center noWrap width='30%' >")
        sbHTML1.Append("<TABLE  cellSpacing=0 cellPadding=0 border=0 class='clsTable'><TR> ")
        sbHTML1.Append("<TD align=center noWrap >")
        sbHTML1.Append("<A valign='top' class='navtabMenu' style='text-decoration:none;' href='#'><Img Border=0 src='../../Images/cssImages/Link images/Save.gif' /></A>")
        sbHTML1.Append("</td>")
        sbHTML1.Append("<TD align=center noWrap >")
        sbHTML1.Append("<A valign='top' class='navtabMenu' style='text-decoration:none;' href='#'><Img Border=0 src='../../Images/cssImages/Link images/help.gif'/></A>")
        sbHTML1.Append("</td>")
        sbHTML1.Append("<TD align=center noWrap >")
        sbHTML1.Append("<A valign='top' class='navtabMenu' style='text-decoration:none;' href='#'><Img Border=0 src='../../Images/cssImages/Link images/Filter.gif'/></A>")
        sbHTML1.Append("</td>")
        sbHTML1.Append("</TR></TABLE>")
        sbHTML1.Append("<br>My Timesheet")
        sbHTML1.Append("</td>")
        sbHTML1.Append("</TR></TABLE>")
        Return sbHTML1.ToString

        sbHTML1 = Nothing

    End Function

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
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtGroupTabID", "txtGroupTabID", , , , m_strGroupTabID, , , , , , True, , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:05/10/15
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
        m_strIsXMLHTTP = CType(CommonFunction.General.CheckIsNothing(Request("IsXMLHTTP"), ""), String)
        'm_strSQL = "usp_Sel_tbl_SEM_TabGroups "
        'dsGroupTab = CommonFunction.Data.GetDataSet(m_strSQL, "GroupTab", , , MyBase.UseSQL)

        If m_strIsXMLHTTP = "" Then
            IsFirstHit = True
        End If

        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("txtPageNumber")) <> "" Then
            m_intPageNumber = CType(Request.Form("txtPageNumber"), Integer)
        Else
            m_intPageNumber = 1
        End If

        m_lngPostID = m_GlobalObject.RoleID

        If m_GlobalObject.LoginType.ToUpper = "E" Then
            m_lngPostID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_Employee_Role " + m_GlobalObject.UserID.ToString, MyBase.UseSQL), "0"), Long)
        End If

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

        'If m_strFromWhere.ToUpper = "ALERTS" Then
        '    Call PlotTabMenu()
        'Else
        '    sbHTML.Append(CommonFunction.MultipleWindowTabs.GenerateTabSections(strDefaultPageURL, m_strMasterTagID, ProjectID, PKToken, "iTabDetails") + vbCrLf)
        'End If

        'sbHTML.Append("<iframe name='iTabDetails' id='iTabDetails' onLoad='calcHeight()'  src='' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>" + vbCrLf)
        'sbHTML.Append("<input type=hidden name='hidMasterTagID' id='hidMasterTagID' value=" + m_strMasterTagID + ">")

        'sbHTML.Append("<input type=hidden name='hidDefaultPageURL' id='hidDefaultPageURL' value='" + strDefaultPageURL + "'>")
        'sbHTML.Append("<input type=hidden name='hidProjectID' id='hidProjectID' value='" + ProjectID + "'>")
        'sbHTML.Append("<input type=hidden name='hidPKToken' id='hidPKToken' value='" + PKToken + "'>")

        ''added by SUchitraP on 22-Aug-2008 for Alert Change
        'sbHTML.Append("<input type=hidden name='hidFromWhere' id='hidFromWhere' value='" + m_strFromWhere + "'>")
        ''End by SuchitraP
        sbHTML.Append("<div id='divGroupItems' style='OVERFLOW:auto;width:99.9%;valign:top;'>")
        sbHTML.Append(DrawTabGroups())
        'sbHTML.Append("<iframe name='frmSub' id='frmSub' onLoad='calcHeight()'  src='" + m_strDefaultPageURL + "' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>" + vbCrLf)
        'sbHTML.Append("<input type=hidden name='hidDefaultPageURL' id='hidDefaultPageURL' value='" + m_strDefaultPageURL + "'>")
        sbHTML.Append("</div>")

        If IsFirstHit Then
            Response.Write(sbHTML.ToString)
        Else
            Response.Clear()
            Response.Write(DrawTabGroups())
            Response.End()
        End If

        sbHTML = Nothing

    End Sub
    Private Function DrawTabGroups1() As String
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
        Dim strTempHREF As String = ""


        'm_sBHTML.Append("<ul id=tabnav style='valign:top;'>")
        'For Each drRow As DataRow In dsGroupTab.Tables(0).Rows

        '    If m_strGroupTabID = "" And CType(CommonFunction.Data.CheckIsDBNull(drRow("IsDefaultGroup"), "0"), Boolean) Then
        '        m_strGroupTabID = CType(CommonFunction.Data.CheckIsDBNull(drRow("TabGroupID"), "0"), String)
        '    End If

        '    If CType(CommonFunction.Data.CheckIsDBNull(drRow("TabGroupID"), "0"), String) = m_strGroupTabID Then
        '        m_sBHTML.Append("<li class=tabSelected ><a title='" + CType(CommonFunction.Data.CheckIsDBNull(drRow("ToolTip"), ""), String) + "' href='#'>" + CType(CommonFunction.Data.CheckIsDBNull(drRow("TabGroupCaption"), ""), String) + "</a>")
        '        m_sBHTML.Append("</li>")
        '        m_strGroupTabID = CType(CommonFunction.Data.CheckIsDBNull(drRow("TabGroupID"), "0"), String)
        '    Else
        '        m_sBHTML.Append("<li ><a title='" + CType(CommonFunction.Data.CheckIsDBNull(drRow("ToolTip"), ""), String) + "' href='javascript:TabGroupOnClick(" + CType(CommonFunction.Data.CheckIsDBNull(drRow("TabGroupID"), ""), String) + ")'>" + CType(CommonFunction.Data.CheckIsDBNull(drRow("TabGroupCaption"), ""), String) + "</A></li>")
        '    End If
        'Next
        'm_sBHTML.Append("</ul>")


        m_strSQL = "usp_show_RoleLevel_Dashboard " ''& IIf(m_strGroupTabID <> "", m_strGroupTabID, "NULL")

        'm_strSQL &= "," & m_lngPostID.ToString
        m_strSQL &= " " & m_GlobalObject.RoleID.ToString
        'm_strSQL &= "," & m_GlobalObject.LoginType

        dsTemp = CommonFunction.Data.GetDataSet(m_strSQL, "TEMP", , , MyBase.UseSQL)


        m_intRowCount = dsTemp.Tables(0).Rows.Count

        Dim intStartRecord As Integer = 0

        intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)

        dsTabItems = CommonFunction.Data.GetDataSet(m_strSQL, "TabItem", intStartRecord, PAGE_SIZE, MyBase.UseSQL)

        dblRatio = m_intRowCount / PAGE_SIZE

        If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
            m_intPageNumber = 1
        End If
        ' RecordCount = dsTabItems.Tables(0).Rows.Count
        m_sBHTML.Append("<TABLE border=0 width=100% cellspacing=0 class='clsBody'>")
        m_sBHTML.Append("<tr class='clsTRBlank'>")
        m_sBHTML.Append("<td class='clsTDBlank' align='left'>")
        m_sBHTML.Append("<ul id=subtabnav>")
        For Each drRow As DataRow In dsTabItems.Tables(0).Rows

            ' If GetTagAccessRights(CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), 0), Long)) Then

            If m_strTabGroupItemID = "" Then
                m_strTabGroupItemID = CType(CommonFunction.Data.CheckIsDBNull(drRow("DashboardID"), "0"), String)
            End If

            If CType(CommonFunction.Data.CheckIsDBNull(drRow("DashboardID"), "0"), String) = m_strTabGroupItemID Then
                m_sBHTML.Append("<li class=tabSelected >")
                m_sBHTML.Append("<a valign='middle' title='" + CType(CommonFunction.Data.CheckIsDBNull(drRow("Description"), ""), String) + "' >")
                If CType(CommonFunction.Data.CheckIsDBNull(drRow("ImageName"), ""), String) <> "" Then
                    m_sBHTML.Append("<img align='middle' valign='bottom' border=0 src='" + CType(CommonFunction.Data.CheckIsDBNull(drRow("ImageName"), ""), String) + "' />")
                End If
                m_sBHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("Description"), ""), String))

                m_sBHTML.Append("</a>")
                m_sBHTML.Append("</li>")
                m_strDefaultPageURL = CType(CommonFunction.Data.CheckIsDBNull(drRow("PageName"), ""), String).Replace("<TODAYS_DATE>", CommonFunction.Dates.GetDate(Today))
            Else
                strTempHREF = CType(CommonFunction.Data.CheckIsDBNull(drRow("PageName"), ""), String).Replace("<TODAYS_DATE>", CommonFunction.Dates.GetDate(Today))

                m_sBHTML.Append("<li>")
                m_sBHTML.Append("<a title='" + CType(CommonFunction.Data.CheckIsDBNull(drRow("ToolTip"), ""), String) + "' href='javascript:TabItemOnClick(" + CType(CommonFunction.Data.CheckIsDBNull(drRow("DashboardID"), ""), String) + "," + CType(CommonFunction.Data.CheckIsDBNull(drRow("DashboardID"), ""), String) + ")'>")
                'm_sBHTML.Append("<a title='" + CType(CommonFunction.Data.CheckIsDBNull(drRow("ToolTip"), ""), String) + "' href='javascript:TabItemOnClick(""" + strTempHREF + """)'>")

                If CType(CommonFunction.Data.CheckIsDBNull(drRow("ImageName"), ""), String) <> "" Then
                    m_sBHTML.Append("<img border=0 src='" + CType(CommonFunction.Data.CheckIsDBNull(drRow("ImageName"), ""), String) + "' />")
                End If
                m_sBHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("Description"), ""), String))
                m_sBHTML.Append("</a>")
                m_sBHTML.Append("</li>")
            End If

            ' End If
        Next


        m_sBHTML.Append("</ul>")

        m_sBHTML.Append("</td>")
        m_sBHTML.Append("<td class='clsTDBlank' align='left'>")

        If m_intRowCount > PAGE_SIZE Then

            m_sBHTML.Append("<A align='right' style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()"" Title=""Previous tabs"" onmouseover=""window.status='Previous tabs';return true;"" onmouseout=""window.status=' ';return true;"">")
            m_sBHTML.Append("<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>")
            m_sBHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            m_sBHTML.Append("<A align='right' style='TEXT-DECORATION:NONE;text-align:right;vertical-align:bottom' HREF=""Javascript:ShowNextPage()"" Title=""Next tabs"" onmouseover=""window.status='Next tabs';return true;"" onmouseout=""window.status=' ';return true;"">")
            m_sBHTML.Append("<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A>")

            If m_intPageNumber = -1 Or dblRatio = 0 Then


                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 150, 4, "", "right", , , , , True, , True, EnableHTMLEncode:=True))
            Else
                m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 150, 4, m_intPageNumber.ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
            End If

            m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:05/10/15
        End If

        m_sBHTML.Append("</td>")
        m_sBHTML.Append("</tr>")
        m_sBHTML.Append("</table>")

        Return m_sBHTML.ToString


        m_sBHTML = Nothing
    End Function
    Public Function DrawTabGroups() As String
        Dim sbFavTab As New StringBuilder("")

        Dim strPageName As String = ""
        Dim strToolTip As String = ""
        Dim strTagID As String = ""
        Dim strControlItemID As String = ""
        Dim strTagName As String = ""
        Dim PAGE_SIZE As Integer = 8 ' 7
        Dim intStartRecord As Integer = 0
        Dim IsModuleAccessible As Boolean = True

        Dim hrefClass As String = ""

        Dim m_intRowCount As Integer = 0
        Dim dblRatio As Double = 0.0





        '  m_intPageNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("PageNumber"), "1")

        intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)

        Dim dsFAVTAB As DataSet
        Dim dsTemp As DataSet

        m_strSQL = "usp_show_RoleLevel_Dashboard " ''& IIf(m_strGroupTabID <> "", m_strGroupTabID, "NULL")

        'm_strSQL &= "," & m_lngPostID.ToString
        m_strSQL &= " " & m_GlobalObject.RoleID.ToString
        'm_strSQL &= "," & m_GlobalObject.LoginType


        dsFAVTAB = CommonFunction.Data.GetDataSet(m_strSQL, "FAVTAB", intStartRecord, PAGE_SIZE, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        dsTemp = CommonFunction.Data.GetDataSet(m_strSQL, "FAVTAB", , , CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        m_intRowCount = dsTemp.Tables(0).Rows.Count

        If m_intRowCount > 0 Then

            dblRatio = m_intRowCount / PAGE_SIZE

            If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
                m_intPageNumber = 1
            End If

            With sbFavTab

                .Append("<TABLE  cellpadding=0 cellspacing=0 width='100%' class='clsTable'><TR class=clsTRBlank valign=middle>") '+ vbCrLf clsBody


                .Append("<TD class='clsTDBlank' width='1%'  align=right style=""valign:bottom;align:right"">") ''
                .Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()"" Title=""Previous Pages"" onmouseover=""window.status='Previous Pages';return true;"" onmouseout=""window.status=' ';return true;"">")
                .Append("<Img id='prevLeft' Border=0 src='../../Images/Home/roundleft.gif' align='top'></A>")
                .Append("</Td>")


                .Append("<TD style='white-space: nowrap' valign='top' class='mainTabsSectionEasyMenu' >")


                For Each drRow As DataRow In dsFAVTAB.Tables(0).Select("1=1", "OrderNo")

                    If m_strTabGroupItemID = "" Then
                        m_strTabGroupItemID = CType(CommonFunction.Data.CheckIsDBNull(drRow("DashboardID"), "0"), String)
                    End If

                    strTagID = CType(CommonFunction.Data.CheckIsDBNull(drRow("UniqueID"), "0"), String)
                    strTagName = CType(CommonFunction.Data.CheckIsDBNull(drRow("Description"), ""), String)
                    strToolTip = strTagName


                    If m_strDefaultPageURL = "" Then
                        m_strDefaultPageURL = CType(CommonFunction.Data.CheckIsDBNull(drRow("PageName"), ""), String).Replace("<TODAYS_DATE>", CommonFunction.Dates.GetDate(Today))
                    End If

                    strPageName = CType(CommonFunction.Data.CheckIsDBNull(drRow("PageName"), ""), String).Replace("<TODAYS_DATE>", CommonFunction.Dates.GetDate(Today))

                    If strTagName.Length > 15 Then
                        strTagName = strTagName.Substring(0, 10) + "...."
                    End If

                    If CType(CommonFunction.Data.CheckIsDBNull(drRow("DashboardID"), "0"), String) = m_strTabGroupItemID Then
                        hrefClass = "selectedTab"
                    End If

                    .Append("<a class='" + hrefClass + "' id='atab1_" + strTagID + "' name='atab1'  style='cursor:hand;' Title='" + strToolTip + "'  onclick='javascript:TabItemOnClick(""" + strPageName + """," + strTagID + ",event)' >" + strTagName + "</a>") ''''border-top:1px solid gray;border-left:1px solid gray;border-bottom:1px solid gray;border-right:0px solid gray;	padding :1px 2px 1px 2px;	width:80px;	text-align:center;	background-image:url(""../../Images/cssImages/Menu.gif"");

                    hrefClass = ""

                Next

                .Append("</TD>")


                .Append("<TD class='clsTDBlank' align=right width='1%' style=""valign:bottom;text-align:left;"">")
                .Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title='Next Pages' onmouseover=""window.status='Next Pages';return true;"" onmouseout=""window.status=' ';return true;"">")
                .Append("<Img id='prevRight' Border=0 src='../../Images/Home/roundright.gif' align='top'></A> ")
                .Append("</td>")



                .Append("</TR></TABLE>")

                If IsFirstHit Then


                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    .Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", , , , , True, EnableHTMLEncode:=True))
                    .Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15

                End If

            End With
        Else
            sbFavTab.Append("<TABLE  cellpadding=0 cellspacing=0 width='100%' class='clsTable'><TR  class=clsTRBlank valign=middle>") '+ vbCrLf clsBody
            sbFavTab.Append("<TD style='white-space: nowrap;align:center;text-align:center;' valign='bottom' class='clsTDBlank'  >")
            sbFavTab.Append("There are no accessible pages to show in this view.")
            sbFavTab.Append("</TD>")
            sbFavTab.Append("</TR></TABLE>")
        End If

        DrawTabGroups = sbFavTab.ToString

        sbFavTab = Nothing
        dsFAVTAB = Nothing

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
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, lngTagID, m_lngPostID, CType(Session("intUserID"), Integer), Session("LoginType").ToString)
        'Create the object of GetAccess class
        Dim objGetAccess As New WebPage.Templates.AccessRights
        'Call method get access to get the access

        Dim IsAccessForNode As Boolean

        If lngTagID <= 0 Then
            IsAccessForNode = True
        Else
            ' m_GlobalObject.TagID = lngTagID
            'Get the Access Rights 

            objGetAccess.GetAccess(objGlobal, IsModuleAccess)

            If IsModuleAccess Then
                Return objGetAccess.Access()
            End If

            If objGetAccess.Add = True OrElse objGetAccess.Delete = True OrElse objGetAccess.Edit = True OrElse objGetAccess.View Then
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
End Class