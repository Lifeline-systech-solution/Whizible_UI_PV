Option Strict Off

Partial Public Class DetailView
    Inherits WebPages.Template.WhizTemplate
    ''added by nilesh g on 11/8/2016 for PKtoken
    Protected m_objGlobal As WebPages.Template.IGlobal
    Protected m_lngTagId As Long = 0
    Protected m_objAccessRights As WebPages.Security.cAccessRights
    ''end of added by nilesh g on 11/8/2016 for PKtoken
    Protected WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Protected m_intMenuGroupID As Integer = 0
    Protected m_intDesignMode As Integer = 0
    Protected m_strShortName As String = ""
    Protected m_intShowMarquee As Integer = 0
    Protected m_intItemCount As Integer = 0
    Protected m_strMode As String = ""
    Protected m_PKtoken As String = ""
    Protected m_PKToken_MenuGroupID As String = ""
    Protected m_PKToken_PKTokenBack As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub
    'Added By Vidya J ON 2 Feb 2016
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_OpenPage_Onclick(CTReportID As String, MenuGroupID As String, EmployeeID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        CTReportID = Utilities.Security.SecurityBuilder.CheckUserInput(CTReportID, 2, True, False, False)
        MenuGroupID = Utilities.Security.SecurityBuilder.CheckUserInput(MenuGroupID, 2, True, False, False)
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim m_PKToken_OpenPage_Onclick As String
        m_PKToken_OpenPage_Onclick = CommonFunctions.Security.Token.GetToken(CType(CTReportID, String) + CType(EmployeeID, String) + "0" + "0" + CType(MenuGroupID, String))

        Return m_PKToken_OpenPage_Onclick
    End Function

    'End Of Added By Vidya J ON 2 Feb 2016



    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : To Initialize the Page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Jul 29, 2008
        ' Revisions             :
        '=====================================================================

        ' Dim blnValidate_HTTP_REFERER As Boolean = CommonFunction.General.GetFrameworkSettings("GENERAL_VALIDATE_HTTP_REFERER", "Enabled")
        ''  Commented By Vidya J ON 2-2-2016
        'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '    Response.Write(vbCrLf + "<script>")
        '    Response.Write(vbCrLf + "		if (window.opener == null)")
        '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '    If strRedirectToPage.Trim = "" Then
        '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '    Else
        '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        '    End If
        '    Response.Write(vbCrLf + "</script>")
        'End If
        Dim MyUrl As Uri = Request.UrlReferrer
        Dim intcontrolItemID As Integer
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("IsXMLHTTP"), 0) = 1 Then
            m_strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Mode"), "")
            If m_strMode <> "" Then
                intcontrolItemID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("ControlItemID"), 0)
                AddRemoveFavourites(intcontrolItemID, m_strMode)
            End If
        Else
            InitVariables()
            'If Not Request.QueryString("PKTokenBack") Is Nothing Then
            '    m_PKToken_PKTokenBack = Request.QueryString("PKTokenBack").ToString
            'End If
            'If (m_PKToken_PKTokenBack <> "") Then
            '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_PKToken_MenuGroupID, String) + "0" + "0", m_PKToken_PKTokenBack) = False) Then
            '        ''   Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Multiple Tasks", 0, 0, "Query ID", "0")
            '        'Token is Invalid now redirect to the Invalid Access Page
            '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            '    End If
            'End If
            ' ''End Of Added By Vidya J ON 2 Feb 2016 



            Draw_HiddenControls()
            Draw_Page()

        End If
    End Sub

    Private Sub InitVariables()
        '=====================================================================
        ' Procedure Name        : InitVariables()
        ' Purpose               : To Initialize the Variables
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Jul 29, 2008
        ' Revisions             :
        '=====================================================================

        ''ADDED BY NILESH G ON 18/8/2016 PURPOSE : PKTOKEN CHECKING
        If Not Request.QueryString("MenuGroupID") Is Nothing Then
            m_PKToken_MenuGroupID = Request.QueryString("MenuGroupID").ToString
        End If
        If Not Request.QueryString("PKToken") Is Nothing Then
            m_PKtoken = Request.QueryString("PKToken").ToString
        End If
        'If (m_PKtoken <> "" Or HttpContext.Current.Session("intUserID") <> 0) And _
        '(CommonFunctions.Security.Token.ValidateToken(CType(m_PKToken_MenuGroupID, String) + CType(Session("intUserID"), String) + "0" + "0", m_PKtoken) = False) Then

        '    'If ((m_PKtoken <> "" And HttpContext.Current.Session("intUserID") <> 0) And (m_PKtoken = "" And HttpContext.Current.Session("intUserID") <> 0)) And _
        '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        'End If

        ''END OF ADDED BY NILESH G ON 18/8/2016 PURPOSE : PKTOKEN CHECKING
        Dim strSQL As String = ""

        'If IsPostBack() Then
        '    m_intMenuGroupID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("MenuGroupID"))
        'Else
        '    m_intMenuGroupID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MenuGroupID"))
        'End If

        'If Not HttpContext.Current.Request.QueryString("MenuGroupID") Is Nothing Then
        '    m_intMenuGroupID = HttpContext.Current.Request.QueryString("MenuGroupID")
        '    HttpContext.Current.Session("MenuGroupID") = m_intMenuGroupID
        'ElseIf Not HttpContext.Current.Session("MenuGroupID") Is Nothing Then
        '    m_intMenuGroupID = HttpContext.Current.Session("MenuGroupID")
        'Else

        'End If
        If Not HttpContext.Current.Request.QueryString("MenuGroupID") Is Nothing Then
            m_intMenuGroupID = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MenuGroupID"), "0"))
        ElseIf Not HttpContext.Current.Request.Form("MenuGroupID") Is Nothing Then
            m_intMenuGroupID = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("MenuGroupID"), "0"))
        ElseIf Not HttpContext.Current.Session("MenuGroupID") Is Nothing Then
            m_intMenuGroupID = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("MenuGroupID"), "0"))
        End If

        If Not HttpContext.Current.Request.QueryString("ShowMarquee") Is Nothing Then
            m_intShowMarquee = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowMarquee"), "0"))
        ElseIf Not HttpContext.Current.Request.Form("") Is Nothing Then
            m_intShowMarquee = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ShowMarquee"), "0"))
        End If

        If CommonFunctions.General.GetApplicationKeySetting("Environment") = "D" Then
            If Not HttpContext.Current.Request.QueryString("IsDesignMode") Is Nothing Then
                m_intDesignMode = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IsDesignMode"), "0"))
            ElseIf Not HttpContext.Current.Request.Form("txtDesignMode") Is Nothing Then
                m_intDesignMode = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtDesignMode"), "0"))
            End If
        End If
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''m_strShortName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ISNULL(ShortName,'') FROM tbl_UI_ControlMenuGroup WHERE MenuGroupID = " + m_intMenuGroupID.ToString, True), ""), "")
        m_strShortName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_UI_ControlMenuGroup_ShortName " + m_intMenuGroupID.ToString, True), ""), "")
        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        If m_intMenuGroupID = 0 Then
            HttpContext.Current.Response.Redirect("../Home/HRHome.aspx")
        End If
        HttpContext.Current.Session("MenuGroupID") = m_intMenuGroupID.ToString
    End Sub

    Protected Sub Draw_Page()
        '=====================================================================
        ' Procedure Name        : Draw_Page()
        ' Purpose               : To generate the UI and
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Jul 29, 2008
        ' Revisions             :
        '=====================================================================
        Dim sbHtml As New System.Text.StringBuilder
        Dim drMenu, drMenuGroup As IDataReader
        Dim strMenu As String = ""
        Dim strSQL As String = ""
        Dim strGroupName As String = ""
        Dim strMenuGroupDescription As String = ""
        Dim strPageURL As String = ""
        Dim strImagePath As String = ""
        Dim strToolTip As String = ""
        Dim strItemDescription As String = ""
        Dim strControlItem As String = ""
        Dim intMenuCount As Integer = 0
        Dim strControlItemCount As String = "0"
        Dim intMidPointofRecords As Integer = 0
        Dim strGroupingOn As String = ""
        Dim strPreviousGroupingName As String = ""
        Dim intPageWidth, intPageHeight As Integer
        Dim strToBeInsertedInDynamicFunction As String = ""
        Dim strControlItemID As String = ""

        'Dim strOrderNumber, strRowNumber As String
        'Dim blnIsSecondOrder As Boolean = False
        Dim strProcess As String = ""
        Dim strPreviousProcess As String = ""
        Dim blnIsFirstRecord As Boolean = True
        Dim blnIsGroupedOnProcess As Boolean = False
        Dim strTagID As String = "0"
        Dim strInsertAfterControlItem As String = ""
        Dim strHeaderHtml As String = ""
        'Added By PiyushB on 4-Sep-2008
        Dim Cancel As Boolean = False
        'Purpose : To check number of licenses available
        Dim objHRHome_Event As HRHome_Event
        Dim objMenuItem As Menuitem_Home

        'Added By SujitG on 05 Sep 2008
        'Purpose : To show update link HTML
        Dim blnShowLastUpdateRecord As Boolean
        Dim intlastUpdationType As Integer = 0
        Dim strLastUpdationHTML As String = ""
        Dim strlastUpdateValueQuery As String = ""
        Dim strPlaceholder As String = ""
        Dim strLastUpdationSP As String = ""
        Dim intPlaceHolderCount As Integer = 0
        Dim drReplacePlaceHolder As IDataReader
        Dim intCount As Integer = 0
        Dim strPrimaryKeySQL As String = ""
        Dim intPrimaryKeyValue As String = ""
        Dim strPKToken As String = ""
        Dim strCountHTML As String = ""
        Dim strControlMenuItemID As String = "0"

        'End of Addition By SujitG on 05 Sep 2008
        objHRHome_Event = New HRHome_Event
        objMenuItem = New Menuitem_Home
        'Addition Ended By PiyushB on 4-Sep-2008
        strMenu = DrawMenu()
        CommonFunction.General.WriteHTML(strMenu)
        sbHtml.Append("<div ID=PageDiv style='overflow:auto;width:100%;'>") 'height:480px
        sbHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left>")

        strSQL = "Usp_Sel_tbl_UI_ControlMenuGroup " + m_intMenuGroupID.ToString
        drMenuGroup = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drMenuGroup.Read Then
            strGroupName = CommonFunction.Data.CheckIsDBNull(drMenuGroup("MenuGroup")).ToString
            strMenuGroupDescription = CommonFunction.Data.CheckIsDBNull(drMenuGroup("MenuGroupDescription")).ToString
            strControlItemCount = CommonFunction.Data.CheckIsDBNull(drMenuGroup("ControlItemCount"), "0").ToString
            blnIsGroupedOnProcess = CommonFunction.Data.CheckIsDBNull(drMenuGroup("IsGroupedOnProcess"), False)
            If strControlItemCount Is Nothing Or strControlItemCount = "" Then
                strControlItemCount = "0"
            End If
            If (CType(strControlItemCount, Double) / 2) = 0 Then
                intMidPointofRecords = CInt((CType(strControlItemCount, Double) / 2))
            Else
                intMidPointofRecords = ((CType(strControlItemCount, Integer) + 1) / 2)
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drMenuGroup)


        sbHtml.Append(strGroupName)

        If m_intDesignMode = 1 Then
            sbHtml.Append("<A href='JavaScript:Section_GridView(" & m_intMenuGroupID.ToString & ")' style='TEXT-DECORATION:none'><img src= '../../Images/cssImages/Link Images/Configure.gif' height=11 border=0 alt='Configure Sections'></A>")
        End If
        sbHtml.Append("</TD></TR></Table><BR>")
        strSQL = "Usp_Sel_tbl_UI_ControlMenuItem " + m_intMenuGroupID.ToString + ", 0,NULL," & CommonFunction.General.CheckIsNothing(Session("intUserID"), "0")
        drMenu = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        sbHtml.Append("<table width='100%' class='clsTable' border='0' cellpadding='0'>") '  border='1' cellpadding='2' cellspacing='1'
        sbHtml.Append("<tr><td align='left' valign='top' width='33.33%'><table width='95%'  border='0' cellpadding='5'>")

        'Dim objNavMenuNode As CommonEngines.HashTables.NavMenuNodes

        'Dim objNavMenuNode() As Boolean
        'objNavMenuNode = CommonEngines.HashTables.GetHashTableObject.GetHashTableRoleAccessCacheRole("122")

        'Dim objPlotControl() As CommonEngines.HashTables.UIControlTagMaster
        'objPlotControl = CommonEngines.HashTables.GetHashTableObject.GetHashTableControlTagMasterCPObject(1232)

        Dim objAccess As New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPages.Template.WhizGlobal 'If using Whiz 2 then use objGlobal As New WebPages.Template.Global
        'objGlobal.LCID = MyBase.CurrentThreadUICultureID
        'objGlobal.UseHashTable = True
        'objAccess.GetAccess(objGlobal)

        While drMenu.Read
            'Added by SujitG on 05 Sep 2008
            objMenuItem.UpdateLinkHTML = ""
            intPlaceHolderCount = 0
            strPrimaryKeySQL = ""
            strCountHTML = ""
            'End of addition by SujitG on 05 Sep 2008
            strControlMenuItemID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("FavControlItemID"), "0"), "0")
            objMenuItem.ControlItem = CommonFunction.Data.CheckIsDBNull(drMenu("ControlItem")).ToString
            objMenuItem.ItemDescription = CommonFunction.Data.CheckIsDBNull(drMenu("ItemDescription")).ToString
            objMenuItem.SystemControlItem = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("SystemControlItem")), "").ToString
            objMenuItem.PageURL = CommonFunction.Data.CheckIsDBNull(drMenu("PageURL")).ToString
            objMenuItem.ImageName = "../../Images/DetailView/" + CommonFunction.Data.CheckIsDBNull(drMenu("ImageName")).ToString
            objMenuItem.ToolTip = CommonFunction.Data.CheckIsDBNull(drMenu("ToolTip")).ToString
            objMenuItem.GroupingOn = CommonFunction.Data.CheckIsDBNull(drMenu("GroupingOn")).ToString
            objMenuItem.PageWidth = CInt(CommonFunction.Data.CheckIsDBNull(drMenu("PageWidth"), "0")).ToString
            objMenuItem.PageHeight = CInt(CommonFunction.Data.CheckIsDBNull(drMenu("PageHeight"), "0")).ToString
            objMenuItem.ToBeInsertedInDynamicFunction = CommonFunction.Data.CheckIsDBNull(drMenu("ToBeInsertedInDynamicFunction")).ToString
            objMenuItem.ControlItemID = CommonFunction.Data.CheckIsDBNull(drMenu("ControlItemID")).ToString
            objMenuItem.Process = CommonFunction.Data.CheckIsDBNull(drMenu("Process")).ToString
            objMenuItem.TagID = CommonFunction.Data.CheckIsDBNull(drMenu("TagID"), "0").ToString
            objMenuItem.ApplyTagSecurity = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ApplyTagSecurity"), "True"), "True").ToString, Boolean)
            objMenuItem.InsertAfterControlItem = CommonFunction.Data.CheckIsDBNull(drMenu("InsertAfterControlItem")).ToString

            'Added by SujitG on 09 Sep 2008 
            objMenuItem.ShowLastUpdated = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ShowLastUpdated")), "0"))
            objMenuItem.LastUpdationType = CInt(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdationType")), "0"))
            objMenuItem.LastUpdatePrimaryKeySQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdatePrimaryKeySQL")), "")
            objMenuItem.LastUpdateHTML = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdateHTML")), "")
            objMenuItem.LastUpdateValueQuery = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdateValueQuery")), "")
            objMenuItem.countSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("CountSQL")), "")
            'End of addition by SujitG on 09 Sep 2008

            If objMenuItem.LastUpdatePrimaryKeySQL <> "" Then
                objMenuItem.LastUpdatePrimaryKeySQL = HRCommonfunction.ReplacePlaceHolders(objMenuItem.LastUpdatePrimaryKeySQL)
                objMenuItem.PrimaryKeyValue = CInt(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(objMenuItem.LastUpdatePrimaryKeySQL, True), "0"))
            End If

            'Added by SujitG on 05 Sep 2008 
            If objMenuItem.ShowLastUpdated = True Then
                objMenuItem.LastUpdateHTML = Draw_LastUpdateLink(objMenuItem)
            End If
            'End of addition by SujitG on 05 Sep 2008

            'Added by SujitG on 09 Sep 2008
            objHRHome_Event.Before_LastUpdateLinkPrint(objMenuItem, Cancel)
            'End of addition by SujitG on 09 Sep 2008
            Call Replace_PKToken(objMenuItem)




            objHRHome_Event.BeforeControlMenuPlot(objMenuItem, Cancel)

            objGlobal.LCID = MyBase.CurrentThreadUICultureID
            objGlobal.UseHashTable = True
            objGlobal.TagID = CType(objMenuItem.TagID, Long)
            objGlobal.UserID = CType(HttpContext.Current.Session("intUserID"), Long)
            objGlobal.RoleID = CType(HttpContext.Current.Session("intPostID"), Long)
            objGlobal.LoginType = CType(HttpContext.Current.Session("LoginType"), String)
            'Added by KapilGK for User Group Access
            objGlobal.ProjectID = Nothing

            objGlobal.ParentTagID = 0
            If objMenuItem.ApplyTagSecurity Then
                objAccess.GetAccess(objGlobal)
            End If
            If objMenuItem.ToBeInsertedInDynamicFunction <> "" Then
                objMenuItem.ToBeInsertedInDynamicFunction = CommonFunction.General.BuildQueryString(objMenuItem.ToBeInsertedInDynamicFunction)
            End If
            'If strGroupingOn <> strPreviousGroupingName Then
            '    sbHtml.Append("<tr><td colspan='2'><font fontFamily:'Verdana, Arial'; color='#003091' size='-1'><b>")
            '    sbHtml.Append(strGroupingOn)
            '    sbHtml.Append("</b></font></td></tr>")
            '    strPreviousGroupingName = strGroupingOn
            'End If

            If objMenuItem.Process <> strPreviousProcess And blnIsFirstRecord And blnIsGroupedOnProcess Then
                Dim cObjFilterDetails As New WebPage.Templates.SectionTitle
                sbHtml.Append("<tr><td colspan='3'><font fontFamily:'Verdana, Arial'; color='#003091' size='-1'><b>")
                sbHtml.Append("<Img Border=0 style='cursor:hand' id=img_" + objMenuItem.Process + " src='../../Images/minus.gif' onclick=""javascript:ShowGrid('" + objMenuItem.Process + "')"" /> ")
                sbHtml.Append(objMenuItem.Process)
                sbHtml.Append("</b></font></td></tr>")
                strPreviousProcess = objMenuItem.Process
                blnIsFirstRecord = False
            End If

            If objMenuItem.Process <> strPreviousProcess And blnIsGroupedOnProcess Then
                sbHtml.Append("</table></td><td align='left' valign='top' width='33.33%'><table width='95%' class='clsTable' border='0' cellpadding='5'>")
                sbHtml.Append("<tr><td colspan='3'><font fontFamily:'Verdana, Arial'; color='#003091' size='-1'><b>")
                sbHtml.Append("<Img Border=0 style='cursor:hand' id=img_" + objMenuItem.Process + " src='../../Images/minus.gif' onclick=""javascript:ShowGrid('" + objMenuItem.Process + "')"" /> ")
                sbHtml.Append(objMenuItem.Process)
                sbHtml.Append("</b></font></td></tr>")
                strPreviousProcess = objMenuItem.Process
            End If

            If objMenuItem.GroupingOn <> strPreviousGroupingName Then
                'Added by KapilGK on 13-Aug-2008 Remove header if no item is accessible
                strHeaderHtml = "<tr name=trItem_" + objMenuItem.Process + " id=trItem_" + objMenuItem.Process + " ><td colspan='3'><font fontFamily:'Verdana, Arial'; color='#003091' size='-1'>"
                strHeaderHtml += objMenuItem.GroupingOn
                strHeaderHtml += "</font><hr></td></tr>"
                'End of addition By KapilGK
                'sbHtml.Append("<tr name=trItem_" + strProcess + " id=trItem_" + strProcess + " ><td colspan='3'><font fontFamily:'Verdana, Arial'; color='#003091' size='-1'>")
                'sbHtml.Append(strGroupingOn)
                'sbHtml.Append("</font><hr></td></tr>")
                strPreviousGroupingName = objMenuItem.GroupingOn
            End If

            If objMenuItem.ApplyTagSecurity = False Or objAccess.Access Then
                If strHeaderHtml <> "" Then
                    sbHtml.Append(strHeaderHtml)
                    strHeaderHtml = ""
                End If
                sbHtml.Append("<tr name=trItem_" + objMenuItem.Process + " id=trItem_" + objMenuItem.Process + " >")
                sbHtml.Append("<td valign=top width=35>")

                If objMenuItem.ToBeInsertedInDynamicFunction = "" Then
                    sbHtml.Append("<a HREF=""Javascript:OpenPage_Onclick('" + objMenuItem.PageURL + "'," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + "," + strControlMenuItemID.ToString + "," + objMenuItem.TagID.ToString + ")"">")
                Else
                    sbHtml.Append("<a HREF=""Javascript:Function_Onclick_" + objMenuItem.ControlItemID + "()"">")
                    sbHtml.Append("<script>function Function_Onclick_" + objMenuItem.ControlItemID + "(){" + vbCrLf)
                    sbHtml.Append(objMenuItem.ToBeInsertedInDynamicFunction + vbCrLf)
                    sbHtml.Append(" OpenPage_Onclick('" + objMenuItem.PageURL + "'," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + "," + strControlMenuItemID.ToString + "," + objMenuItem.TagID.ToString + ")")
                    sbHtml.Append("}</script>")
                End If

                'sbHtml.Append("<img src='" + strImagePath + "' alt='" + strToolTip + "' width=35 height=35 vspace=1 border=0></a></td>")
                'sbHtml.Append("<img src='" + objMenuItem.ImageName + "' alt='" + objMenuItem.ToolTip + "' vspace=1 border=0></a></td>")
                sbHtml.Append("<img src='" + objMenuItem.ImageName + "' alt='" + objMenuItem.ToolTip + "' vspace=1 border=0 onmouseover=' this.border=1 ' onmousedown=' this.border=2 ' onmouseout=' this.border=0 '></a></td>")
                sbHtml.Append("<td valign=top>")

                '<a HREF=""Javascript:OpenPage_Onclick('" + strPageURL + "'," + intPageHeight.ToString + ",'" + strToBeInsertedInDynamicFunction + "')"">")

                sbHtml.Append("<table width=100%>")
                sbHtml.Append("<tr><td valign=top>")

                If objMenuItem.ToBeInsertedInDynamicFunction = "" Then
                    sbHtml.Append("<a HREF=""Javascript:OpenPage_Onclick('" + objMenuItem.PageURL + "'," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + "," + strControlMenuItemID.ToString + "," + objMenuItem.TagID.ToString + ")"" Title='" + objMenuItem.ToolTip + "' >")
                Else
                    sbHtml.Append("<a HREF=""Javascript:Function_Onclick_" + objMenuItem.ControlItemID + "()"" Title='" + objMenuItem.ToolTip + "'>")
                    sbHtml.Append("<script>function Function_Onclick_" + objMenuItem.ControlItemID + "(){" + vbCrLf)
                    sbHtml.Append(objMenuItem.ToBeInsertedInDynamicFunction + vbCrLf)
                    sbHtml.Append(" OpenPage_Onclick('" + objMenuItem.PageURL + "'," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + "," + strControlMenuItemID.ToString + "," + objMenuItem.TagID.ToString + ")")
                    sbHtml.Append("}</script>")
                End If
                sbHtml.Append("<font fontFamily:'Verdana, Arial'; size='2'>")
                'sbHtml.Append(objMenuItem.ControlItem)
                sbHtml.Append(objMenuItem.SystemControlItem)
                sbHtml.Append("</font>")
                sbHtml.Append("</a>")
                If objMenuItem.countSQL <> "" Then
                    Try
                        objMenuItem.countSQL = HRCommonfunction.ReplacePlaceHolders(objMenuItem.countSQL)
                        strCountHTML = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(objMenuItem.countSQL, True), "")
                    Catch ex As Exception
                        strCountHTML = ""
                    End Try
                End If
                If strCountHTML <> "" Then
                    sbHtml.Append("<font fontFamily:'Verdana, Arial';color=red; size='-2'>")
                    sbHtml.Append(strCountHTML)
                    sbHtml.Append("</font>")
                End If

                sbHtml.Append("</td><td valign=top align='right'>")
                If objMenuItem.InsertAfterControlItem <> "" Then
                    objMenuItem.InsertAfterControlItem = HRCommonfunction.ReplacePlaceHolders(objMenuItem.InsertAfterControlItem)
                    sbHtml.Append(objMenuItem.InsertAfterControlItem)
                End If
                sbHtml.Append("</td></tr></table>")

                'Added by SujitG on 05 Sep 2008
                If objMenuItem.UpdateLinkHTML <> "" Then
                    'sbHtml.AppendLine("<br>")
                    sbHtml.Append("<font fontFamily:'Verdana, Arial'; size='-12' color='Indigo'>")
                    sbHtml.Append(objMenuItem.UpdateLinkHTML)
                    sbHtml.Append("</font>")
                End If
                'End of addition by SujitG on 05 Sep 2008
                If m_intDesignMode = 1 Then
                    sbHtml.Append("<A href='JavaScript:Configure_Item(" & objMenuItem.ControlItemID & "," & m_intMenuGroupID.ToString & ")' style='TEXT-DECORATION:none'><img src= '../../Images/cssImages/Link Images/Configure.gif' height=11 border=0 alt='Configure Menu Item'></A>")
                End If

                'sbHtml.Append("<br>")
                sbHtml.Append("<font fontFamily:'Verdana, Arial'; size='-2'>")
                sbHtml.Append(objMenuItem.ItemDescription)
                sbHtml.Append("</font>")
                sbHtml.Append("</td>")
                'sbHtml.Append("<td valign='top' align='right'>")
                ''--- If condition added. if page is called from analytics then do not show add favourite link
                'If m_intMenuGroupID <> 1 Then
                '    If strControlMenuItemID <> "0" And strControlMenuItemID <> "" Then
                '        sbHtml.Append("<img id='imgFav" + objMenuItem.ControlItemID.ToString + "' border=0 src='../../Images/Home/RemoveFavorite.gif' title='Remove from favourites' style='cursor:hand;' onclick='addRemoveFavorites(" + objMenuItem.ControlItemID.ToString + ",""D"")'>")
                '    Else
                '        sbHtml.Append("<img id='imgFav" + objMenuItem.ControlItemID.ToString + "' border=0 src='../../Images/Home/AddFavorite.gif' title='Add to favourites' style='cursor:hand;' onclick='addRemoveFavorites(" + objMenuItem.ControlItemID.ToString + ",""A"")'>")
                '    End If
                'End If
                'sbHtml.Append("</td>")
                sbHtml.Append("</tr>")
            End If

            intMenuCount += 1

            If intMidPointofRecords = intMenuCount And Not blnIsGroupedOnProcess Then
                sbHtml.Append("</table></td><td align='left' valign='top' width='50%'><table width='95%' border='0' cellpadding='0'>") ' border='1' cellpadding='2' cellspacing='1'
            End If

        End While
        CommonFunction.Data.DisposeDataReader(drMenu)
        sbHtml.Append("</td></tr></table>")
        sbHtml.Append("</td></tr></table>")
        sbHtml.Append("</Div>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)
        CommonFunction.General.WriteHTML(strMenu)
        sbHtml = Nothing

    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Jul 29, 2008
        ' Revisions             :
        '=====================================================================

        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        ' Modified By nitinVs on 23 Mar 2009 to hide home link for Project Analytics group 
        'If m_intMenuGroupID <> 1 And m_intMenuGroupID <> 2 And m_intMenuGroupID <> 16 Then
        '    ArrTopMenuCaptionsList.Add("Home")
        '    ArrTopMenuToolTipsList.Add("Home")
        '    ArrTopMenuFunctionsList.Add("Home_OnClick()")
        'End If
        ' End Modification By nitinVs on 23 Mar 2009 to hide home link for Project Analytics group 

        If CommonFunctions.General.GetApplicationKeySetting("Environment") = "D" Then
            If m_intDesignMode = 0 Then
                ArrTopMenuCaptionsList.Add("Open In Design mode")
                ArrTopMenuToolTipsList.Add("Open In Design mode")
                ArrTopMenuFunctionsList.Add("DesignMode_OnClick(1)")
            Else
                ArrTopMenuCaptionsList.Add("Open In User mode")
                ArrTopMenuToolTipsList.Add("Open In User mode")
                ArrTopMenuFunctionsList.Add("DesignMode_OnClick(0)")
            End If

        End If

        ' Modified By nitinVs on 23 Mar 2009 to hide home link for Project Analytics group 
        'If m_intMenuGroupID <> 1 And m_intMenuGroupID <> 2 And m_intMenuGroupID <> 16 Then
        '    ArrTopMenuCaptionsList.Add("Back")
        '    ArrTopMenuToolTipsList.Add("Back")
        '    ArrTopMenuFunctionsList.Add("Back_OnClick()")
        'End If
        ' End Modification By nitinVs on 23 Mar 2009 to hide home link for Project Analytics group 


        'ArrTopMenuCaptionsList.Add("?")
        'ArrTopMenuToolTipsList.Add("Help")
        'ArrTopMenuFunctionsList.Add("Help_OnClick('Home')")

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)



        'Dim arrMenu() As String = {"Home", "<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>"}
        'Dim arrMenuToolTip() As String = {"Home", "Help"}
        'Dim arrClientSideFunctions() As String = {"Home_OnClick()", "OpenHelpPage('Home')"}
        'm_objMenu = New WebPage.Templates.StaticMenu
        'DrawMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
    End Function

    Private Sub Draw_HiddenControls()
        '=====================================================================
        ' Procedure Name        : Draw_HiddenControls
        ' Purpose               : Draws Hidden controls 
        ' Description           : 
        ' Parameters Passed     : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Jul 29, 2008
        ' Revisions             :
        '=====================================================================
        CommonFunction.General.WriteHTML("<div>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("MenuGroupID", "MenuGroupID", , , , m_intMenuGroupID.ToString, , , , , , True, , True))
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("ShowMarquee", "ShowMarquee", , , , m_intShowMarquee.ToString, , , , , , True, , True))
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtDesignMode", "txtDesignMode", , , , m_intDesignMode.ToString, , , , , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("MenuGroupID", "MenuGroupID", , , , m_intMenuGroupID.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("ShowMarquee", "ShowMarquee", , , , m_intShowMarquee.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtDesignMode", "txtDesignMode", , , , m_intDesignMode.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        CommonFunction.General.WriteHTML("</div>")
    End Sub

    Private Function Draw_LastUpdateLink(ByVal objMenuItem) As String

        '=====================================================================
        ' Function Name        : Draw_LastUpdateLink()
        ' Purpose               : To Draw Last update Link
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SujitG
        ' Created               : Sep 09, 2008
        ' Revisions             :
        '=====================================================================
        Dim strLastUpdationHTML As String = ""
        Dim strlastUpdateValueQuery As String = ""
        Dim strPlaceholder As String = ""
        Dim strLastUpdationSP As String = ""
        Dim intPlaceHolderCount As Integer = 0
        Dim drReplacePlaceHolder As IDataReader
        Dim intCount As Integer = 0
        Dim strPrimaryKeySQL As String = ""
        Dim intPrimaryKeyValue As String = ""
        Dim strPKToken As String = ""

        strPrimaryKeySQL = objMenuItem.LastUpdatePrimaryKeySQL
        Try


            If objMenuItem.LastUpdationType = 1 Then
                strLastUpdationHTML = objMenuItem.LastUpdateHTML
                strlastUpdateValueQuery = objMenuItem.LastUpdateValueQuery
                strlastUpdateValueQuery = HRCommonfunction.ReplacePlaceHolders(strlastUpdateValueQuery)

                While strLastUpdationHTML.IndexOf("<PLACEHOLDER" + (intPlaceHolderCount + 1).ToString + ">") > 0
                    intPlaceHolderCount = intPlaceHolderCount + 1
                End While

                If intPlaceHolderCount > 0 Then
                    Dim arrPlaceholder(intPlaceHolderCount - 1)
                    drReplacePlaceHolder = CommonFunction.Data.GetDataReader(strlastUpdateValueQuery, True)
                    If drReplacePlaceHolder.Read() Then
                        For intCount = 0 To intPlaceHolderCount - 1
                            strLastUpdationHTML = strLastUpdationHTML.Replace("<PLACEHOLDER" + (intCount + 1).ToString + ">", CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drReplacePlaceHolder(intCount)), ""))
                        Next
                    End If
                    CommonFunction.Data.DisposeDataReader(drReplacePlaceHolder)
                End If

                'If strLastUpdationHTML.Contains("<PKToken>") Then
                '    strPrimaryKeySQL = HRCommonfunction.ReplacePlaceHolders(strPrimaryKeySQL)
                '    If strPrimaryKeySQL <> "" Then
                '        intPrimaryKeyValue = objMenuItem.PrimaryKeyValue
                '        objMenuItem.PKToken = CommonFunctions.Security.Token.GetToken(CType(intPrimaryKeyValue, String) + HttpContext.Current.Session("intUserID").ToString + objMenuItem.TagID.ToString + "0")
                '        strLastUpdationHTML = strLastUpdationHTML.Replace("<PKToken>", objMenuItem.PKToken)
                '    End If
                'End If
            ElseIf objMenuItem.LastUpdationType = 2 Then
                strLastUpdationSP = objMenuItem.LastUpdateHTML
                strLastUpdationSP = HRCommonfunction.ReplacePlaceHolders(strLastUpdationSP)
                strLastUpdationHTML = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strLastUpdationSP, True), ""), "")

                'If strLastUpdationHTML.Contains("<PKToken>") Then
                '    strPrimaryKeySQL = HRCommonfunction.ReplacePlaceHolders(strPrimaryKeySQL)
                '    If strPrimaryKeySQL <> "" Then
                '        intPrimaryKeyValue = objMenuItem.PrimaryKeyValue
                '        'If objMenuItem.TagID.ToString = "2294" Then
                '        'objMenuItem.PKToken = CommonFunctions.Security.Token.GetToken(CType(intPrimaryKeyValue, String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
                '        'Else
                '        objMenuItem.PKToken = CommonFunctions.Security.Token.GetToken(CType(intPrimaryKeyValue, String) + HttpContext.Current.Session("intUserID").ToString + objMenuItem.TagID.ToString + "0")
                '        'End If
                '        strLastUpdationHTML = strLastUpdationHTML.Replace("<PKToken>", objMenuItem.PKToken)
                '    End If
                'End If
            End If
        Catch ex As Exception
            strLastUpdationHTML = ""
        End Try
        Return strLastUpdationHTML
    End Function

    Private Function Replace_PKToken(ByVal objMenuItem) As String
        If objMenuItem.LastUpdationType = 1 Then ' CommonFunction.Constants.UpdateLink.HTML Then
            If objMenuItem.LastUpdateHTML.Contains("<PKToken>") Then
                objMenuItem.PKToken = CommonFunctions.Security.Token.GetToken(CType(objMenuItem.PrimaryKeyValue, String) + HttpContext.Current.Session("intUserID").ToString + objMenuItem.TagID.ToString + "0")
                objMenuItem.LastUpdateHTML = objMenuItem.LastUpdateHTML.Replace("<PKToken>", objMenuItem.PKToken)
            End If
        ElseIf objMenuItem.LastUpdationType = 2 Then ' CommonFunction.Constants.UpdateLink.STOREDPROCEDURE Then
            If objMenuItem.LastUpdateHTML.Contains("<PKToken>") Then
                objMenuItem.PKToken = CommonFunctions.Security.Token.GetToken(CType(objMenuItem.PrimaryKeyValue, String) + HttpContext.Current.Session("intUserID").ToString + objMenuItem.TagID.ToString + "0")
                objMenuItem.LastUpdateHTML = objMenuItem.LastUpdateHTML.Replace("<PKToken>", objMenuItem.PKToken)
            End If
        End If
        objMenuItem.UpdateLinkHTML = objMenuItem.LastUpdateHTML
    End Function

    Public Sub AddRemoveFavourites(ByVal intControlItemID As Integer, ByVal strmode As String)

        Dim strHTML As New System.Text.StringBuilder
        Dim dr As IDataReader

        CommonFunction.Data.InsertOrUpdateData("usp_INS_UPD_ControlMenuItem_Favorites " + intControlItemID.ToString + "," + Session("intUserID").ToString + ",'" + m_strMode.ToString + "','S'", True)

        'dr = CommonFunction.Data.GetDataReader("usp_SEL_ControlMenuItem_Favorites " + Session("intUserID").ToString, True)
        'strHTML.Append("<table CELLPADDING='0' CELLSPACING='0' BORDER='0' Width='100%' class='clsTable' >")
        'strHTML.Append("<TR class='clsTREven'>")
        'strHTML.Append("<TD align='left'>")
        'While dr.Read()
        '    strHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("ControlItem"), ""), ""))
        'End While
        'strHTML.Append("</TD></TR></table>")
        'CommonFunction.Data.DisposeDataReader(dr)
        'strHTML.Append(PlotFavourites("My Favourites", 10, 0, False, 1, 800))
        'Response.Clear()
        'Response.Write(strHTML.ToString)
        'Response.End()
    End Sub
End Class
