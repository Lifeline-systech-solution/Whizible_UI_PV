Public Partial Class Home_FloatingMenu
    Inherits WebPages.Template.WhizTemplate

    Protected Shared m_strTagID As String = ""
    Protected Shared m_strTemplateID As String = ""
    Protected m_GlobalObject As New WebPages.Template.WhizGlobal
    Protected m_intPageNumber As Integer = 1
    Protected Shared m_lngPostID As Long = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        GetGlobalObject()
    End Sub
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_GlobalObject = MyBase.GlobalObject()

    End Sub
    Protected Sub PageInit()
        Dim strMode As String = ""

        strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        m_strTagID = CommonFunctions.General.CheckIsNothing(Request.QueryString("TagID")).ToString()

        '--- added By purvaj on 25 mar 2009
        '--- if page called from setup module the display favourites for selected module
        If Not Request.Form("hidtxtTemplateID") Is Nothing Then
            m_strTemplateID = CType(Request.Form("hidtxtTemplateID"), String)
        Else
            m_strTemplateID = CommonFunctions.General.CheckIsNothing(Request.QueryString("TemplateID"), "").ToString()
        End If

        'If m_strTemplateID = "" Then
        '    m_strTemplateID = "PM"
        'End If
        '--- end addition purvaj
      
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''CommonFunction.HTMLControls.DrawTextBox("hidtxtTemplateID", "hidtxtTemplateID", , , , m_strTemplateID, , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("hidtxtTemplateID", "hidtxtTemplateID", , , , m_strTemplateID, , , , , , True, EnableHTMLEncode:=True)

        CommonFunctions.General.WriteHTML("<Table border=0 cellspacing=0 cellpadding=0 width='99.9%' class='clsTable' ><TR class='clsTRPageCaption'>")
        If strMode.ToLower() = "goto" Then
            CommonFunctions.General.WriteHTML("<TD align=left>Manage Favorites</TD>")
        End If
        CommonFunctions.General.WriteHTML("<TD align=right> <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Close_Div()"" ><img src='../../Images/home/Close.gif' border=0 /></A></TD></TR></TABLE>")

        Select Case strMode.ToLower()
            Case "goto"
                If CommonFunction.General.CheckIsNothing(Request.QueryString("IsXMLHttp")) = "1" Then
                    Response.Clear()
                    '--- modified by purvaj on 14 Jul 2009 SEM 8.1 New UI, favourites displayed on all the tabs now.
                    '--- m_strTemplateID.ToUpper added
                    Response.Write(DrawFavoriateTabs(m_strTemplateID.ToUpper))
                    Response.End()
                Else
                    CommonFunctions.General.WriteHTML(DrawGotoDiv())
                End If

            Case "views"
                CommonFunctions.General.WriteHTML(DrawViewDiv())
            Case "save"
                PerformFavoriateUpdates()
                PlotFavoriateTabs()
        End Select
    End Sub
    Private Sub PerformFavoriateUpdates()
        Dim strSelectedCheckbox As String = CommonFunction.General.CheckIsNothing(Request.Form("chkField"))
        Dim strOrderNumberList As String = ""
        Dim arrSelectedCB() As String
        Dim i As Integer = 0
        Dim strOrderNumber As String = ""

        Dim strSQL As String = ""

        If strSelectedCheckbox <> "" Then
            arrSelectedCB = strSelectedCheckbox.Split(","c)
            For i = 0 To arrSelectedCB.Length - 1
                strOrderNumber = CommonFunction.General.CheckIsNothing(Request.Form("txtOrderNumber" + arrSelectedCB(i)))
                If strOrderNumber = "" Then
                    strOrderNumber = "0"
                End If
                strOrderNumberList &= strOrderNumber & ","
            Next
        End If

        strSQL = "usp_Upd_Active_InActive_Favorites " & Session("intUserID").ToString

        If strSelectedCheckbox <> "" Then
            strSQL &= ",'" & strSelectedCheckbox & "'"
        Else
            strSQL &= ",NULL"
        End If

        If strOrderNumberList <> "" Then
            strSQL &= ",'" & strOrderNumberList & "'"
        Else
            strSQL &= ",NULL"
        End If

        If m_strTemplateID <> "" Then
            strSQL &= "," & m_strTemplateID
        Else
            strSQL &= ",'PM'"
        End If


        Try
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        Catch

        End Try

    End Sub
    Private Sub PlotFavoriateTabs()
        Dim sbHTML As New StringBuilder
        

        sbHTML.Append("<script language='javascript'>")
        sbHTML.Append("  if (navigator.appName == 'Microsoft Internet Explorer') ")
        sbHTML.Append(" {")
        sbHTML.Append("document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all(""tdTabs"").innerHTML=""" + DrawFavoriateTabs(m_strTemplateID.ToUpper).Replace("""", "\""") + """;")
        sbHTML.Append("document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent[1].frameElement.style.display='none';")
        sbHTML.Append("document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent[1].frameElement.src='';")
        sbHTML.Append("} else {")
        sbHTML.Append("parent.document.getElementById('tdTabs').innerHTML=""" + DrawFavoriateTabs(m_strTemplateID.ToUpper).Replace("""", "\""") + """;")
        sbHTML.Append("window.parent.frames['iFloatingMenu'].frameElement.style.display='none';")
        sbHTML.Append("window.parent.frames['iFloatingMenu'].frameElement.src='';")
        sbHTML.Append("}")

        sbHTML.Append("</script>")



        Response.Write(sbHTML.ToString)

        sbHTML = Nothing
    End Sub
    Public Function DrawFavoriateTabs(Optional ByVal TemplateID As String = "", Optional ByVal BrowserType As String = "") As String
        Dim sbFavTab As New StringBuilder("")

        Dim strPageName As String = ""
        Dim strToolTip As String = ""
        Dim strTagID As String = ""
        Dim strControlItemID As String = ""
        Dim strTagName As String = ""
        Dim PAGE_SIZE As Integer = 7
        Dim intStartRecord As Integer = 0
        Dim IsModuleAccessible As Boolean = True
        Dim m_strBrowserType As String = ""
        Dim hrefClass As String = ""

        Dim m_intRowCount As Integer = 0
        Dim dblRatio As Double = 0.0
        Dim lngCount As Integer = 0

        If HttpContext.Current.Request("browserType") Is Nothing Then
            m_strBrowserType = BrowserType
        Else
            m_strBrowserType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("browserType"), "IE")
        End If

        '-- Added By purvaj on 14 Jul 2009 SEM 8.1 UI Changes
        If TemplateID.ToUpper = "DB" Then '''Or m_strTemplateID.ToUpper = "DB" Then
            PAGE_SIZE = 3
            If m_strBrowserType <> "IE" Then
                PAGE_SIZE = PAGE_SIZE - 1
            End If
        End If

        If TemplateID.ToUpper = "KM" Then
            ''Or m_strTemplateID.ToUpper = "KM" Then
            PAGE_SIZE = 6 '5
            If m_strBrowserType <> "IE" Then
                PAGE_SIZE = PAGE_SIZE - 1
            End If
        End If

        '-- End addition purvaj

        If TemplateID.ToUpper = "PM" Then '''Or m_strTemplateID.ToUpper = "PM" Then
            PAGE_SIZE = 7 '6
            If m_strBrowserType <> "IE" Then
                PAGE_SIZE = PAGE_SIZE - 2
            End If

        End If

        If TemplateID.ToUpper <> "PM" And TemplateID.ToUpper <> "KM" And TemplateID.ToUpper <> "DB" Then
            If m_strBrowserType <> "IE" Then
                PAGE_SIZE = PAGE_SIZE - 2
            End If
        End If


        GetGlobalObject()

        GetPostID()

        m_intPageNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("PageNumber"), "1")

        intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)

        Dim dsFAVTAB As DataSet
        Dim dsTemp As DataSet

        Dim strSQL As String = "usp_Sel_AllOrQuickLinks " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()
        If TemplateID <> "" Then
            strSQL += ",'" + TemplateID + "'"
        Else
            strSQL += ",'" + m_strTemplateID + "'"
        End If

        strSQL += ",1"
        strSQL += "," + m_lngPostID.ToString
        strSQL += "," + m_GlobalObject.ProjectID.ToString
        strSQL += ",N'" + m_GlobalObject.LoginType + "'"
        'If m_strTemplateID = "PM" Then
        '    strSQL += ",'" + m_strTemplateID + "'"
        'Else
        '    strSQL += ",'SM,PRO,RM'"

        'End If

        dsFAVTAB = CommonFunction.Data.GetDataSet(strSQL, "FAVTAB", intStartRecord, PAGE_SIZE, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        dsTemp = CommonFunction.Data.GetDataSet(strSQL, "FAVTAB", , , CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        m_intRowCount = dsTemp.Tables(0).Rows.Count

        If m_intRowCount > 0 Then

            dblRatio = m_intRowCount / PAGE_SIZE

            If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
                m_intPageNumber = 1
            End If

            With sbFavTab


                .Append("<TABLE  cellpadding=0 cellspacing=0 width='100%' class='clsTable'><TR class=clsTRBlank valign=middle>") '+ vbCrLf clsBody
              

                .Append("<TD style='white-space: nowrap' valign='top' class='mainTabsSectionEasyMenu' >")
              
                For Each drRow As DataRow In dsFAVTAB.Tables(0).Select("1=1", "OrderNumber")
                    lngCount += 1

                    If CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), "0"), Long) = 10 And HttpContext.Current.Session("LoginType").ToString = "C" Then
                        Continue For
                    End If

                   
                    strPageName = CType(CommonFunction.Data.CheckIsDBNull(drRow("OptionID"), ""), String)
                    strTagID = CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), ""), String)
                    strControlItemID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ControlItemID"), ""), String)
                    strTagName = CType(CommonFunction.Data.CheckIsDBNull(drRow("OptionName"), ""), String)
                    strToolTip = strTagName
                   
                    If strTagName.Length > 15 Then
                        strTagName = strTagName.Substring(0, 10) + "...."
                    End If

                    If (strTagID = "-1" And TemplateID.ToUpper = "SM") Or (strTagID = "-2" And TemplateID.ToUpper = "PRO") Or (strTagID = "-3" And TemplateID.ToUpper = "RM") Then

                        hrefClass = "selectedTab"
                    End If



                    'If lngCount = PAGE_SIZE Then
                    '    .Append("<label id='atab_" + strTagID + "' name='atab'  style='cursor:pointer;BACKGROUND: url('../../Images/tabimages/tab_left_inactive.gif');width:12%;' Title='" + strToolTip + "'  onclick='javascript:TabItemOnClick(""" + strPageName + """," + strTagID + "," + strControlItemID + ",event)' >" + strTagName + "</label>")
                    '    '.Append("<img style='align:left;vAlign:top;width:99.9%;' src='../../Images/tabimages/tab_left_inactive.gif' />")
                    'Else
                    .Append("<a class='" + hrefClass + "' id='atab_" + strTagID + "' name='atab'  style='cursor:pointer;' Title='" + strToolTip + "'  onclick='javascript:TabItemOnClick(""" + strPageName + """," + strTagID + "," + strControlItemID + ",event)' >" + strTagName + "</a>")
                    'End If


                    hrefClass = ""

                Next

                .Append("</TD>")

                .Append("</TR></TABLE>")

                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                '.Append(CommonFunction.HTMLControls.DrawTextBox("txtFAVPageNumber", "txtFAVPageNumber", , 50, 4, m_intPageNumber.ToString, "right", , , , , True))
                '.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfFAV", "txtNoOfFAV", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True))
                .Append(CommonFunction.HTMLControls.DrawTextBox("txtFAVPageNumber", "txtFAVPageNumber", , 50, 4, m_intPageNumber.ToString, "right", , , , , True, EnableHTMLEncode:=True))
                .Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfFAV", "txtNoOfFAV", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))
            End With
        Else
            sbFavTab.Append("<TABLE  cellpadding=0 cellspacing=0 width='100%' class='clsTable'><TR  class=clsTRBlank valign=middle>") '+ vbCrLf clsBody
            sbFavTab.Append("<TD style='white-space: nowrap;align:center;text-align:center;' valign='bottom' class='clsTDBlank'  >")
            sbFavTab.Append("There are no active favourites to show in this view.")
            sbFavTab.Append("</TD>")
            sbFavTab.Append("</TR></TABLE>")
        End If

        DrawFavoriateTabs = sbFavTab.ToString

        sbFavTab = Nothing
        dsFAVTAB = Nothing

    End Function
    Private Sub GetPostID()

        m_lngPostID = m_GlobalObject.RoleID

        If m_strTemplateID <> "PM" And m_GlobalObject.LoginType.ToUpper = "E" Then
            m_lngPostID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_Employee_Role " + m_GlobalObject.UserID.ToString, MyBase.UseSQL), "0"), Long)
        End If

    End Sub
    Public Shared Function DrawGotoDiv() As String
        Dim strHTML As New StringBuilder
        Dim drViews As IDataReader
        Dim strLinkType As String = ""
        Dim width As String = "99.99%"
        Dim IsChecked As Boolean = False
        Dim OrderNumber As Double = 0
        Dim IsDisabled As Boolean

        Dim strSQL As String = "usp_Sel_AllOrQuickLinks " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()

        '--- modified by purvaj on 25 mar 2009
        '---m_strTemplateID parameter added
        '--- if page called from setup module the display favourites for selected module
        ' If m_strTemplateID = "PM" Then
        strSQL += ",'" + m_strTemplateID + "'"
        'Else
        'strSQL += ",'SM,PRO,RM'"
        'End If
        strSQL += ",NULL"
        strSQL += "," + m_lngPostID.ToString
        strSQL += "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString()
        strSQL += ",N'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "0").ToString() + "'"


        drViews = CommonFunctions.Data.GetDataReader(strSQL, True)

        strHTML.Append("<table id=""TblBX""  class='clsGridTable'cellpadding=0 cellspacing=0 width='" + width + "'>")
        strHTML.Append("<TR class='clsTRBlank'>")
        strHTML.Append("<td align='left' nowrap class='clsTDBlankNEW'>") 'colsapn='2'
        strHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkAll", "chkAll", , , , , "onClick='javascript:SelectAndClearAll_OnClick()'", True))
        strHTML.Append("</td>") '<B>Select/Clear All</B>

        strHTML.Append("<td align='middle' nowrap class='clsTDBlankNEW'>")
        strHTML.Append("<span onclick='applyFilter()' style='cursor:pointer' title='Apply Filter'><Img Border=0  src='../../Images/Check.gif' ><b>Apply</b></span>")
        strHTML.Append("</td>")

        strHTML.Append("</TR>")
        strHTML.Append("</table>")

        strHTML.Append("<div id=""DivMain""  style='overflow:auto;height:400px;width:99.99%;' >")

        strHTML.Append("<table id=""TblXX""  class='clsGridTable'cellpadding=0 cellspacing=1  width='99.99%' >")
        '--- end modification purvaj

        'strHTML.Append("<div id='DivMain' class='ContextMenu' style=""overflow:auto;height:350px;width:99.99%"">")
        'strHTML.Append("<table id='tblKPI' cellspacing='0' cellpadding='3' width=99.99% >")

        While drViews.Read()

            'If strLinkType <> CommonFunctions.Data.CheckIsDBNull(drViews("LinkType")).ToString() And CommonFunctions.Data.CheckIsDBNull(drViews("LinkType")).ToString() <> "" Then
            '    strHTML.Append("<tr>")
            '    strHTML.Append("<td class='CtMn_LeftFill'></td>")
            '    strHTML.Append("<td ><a class='clsLinkChildNavMenu' style=""text-decoration:none;""  ><b><i>")
            '    strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drViews("LinkType")).ToString())
            '    strHTML.Append("</i></b>")
            '    strHTML.Append("</a></td>")
            '    strHTML.Append("</tr>")
            '    strHTML.Append("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td></tr>")
            'End If
            'strHTML.Append("<tr>")
            'strHTML.Append("<td class='CtMn_LeftFill'></td>")
            'strHTML.Append("<td ><a class='clsLinkChildNavMenu' style=""text-decoration:none;"" href=""javascript:ShowFavourites('")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drViews("OptionID")).ToString())
            'strHTML.Append("',")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drViews("TagID"), "0").ToString())
            'strHTML.Append(",")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drViews("ControlItemID"), "0").ToString())
            'strHTML.Append(")"">")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drViews("OptionName")).ToString())
            'strHTML.Append("</a></td>")
            'strHTML.Append("</tr>")
            'strHTML.Append("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td></tr>")
            'strLinkType = CommonFunctions.Data.CheckIsDBNull(drViews("LinkType")).ToString()
            If CommonFunctions.Data.CheckIsDBNull(drViews("TagID"), "0").ToString() <> "0" Then

                If CType(CommonFunction.Data.CheckIsDBNull(drViews("TagID"), "0"), Long) = 10 And HttpContext.Current.Session("LoginType").ToString = "C" Then
                    Continue While
                End If

                IsChecked = CType(CommonFunctions.Data.CheckIsDBNull(drViews("IsActive"), "0"), Boolean)
                OrderNumber = CType(CommonFunctions.Data.CheckIsDBNull(drViews("OrderNumber"), "0"), Double)

                If CType(CommonFunction.Data.CheckIsDBNull(drViews("TagID"), "0"), Long) = 5 Or CType(CommonFunction.Data.CheckIsDBNull(drViews("TagID"), "0"), Long) = 10 _
     Or CType(CommonFunction.Data.CheckIsDBNull(drViews("TagID"), "0"), Long) = 1 Or CType(CommonFunction.Data.CheckIsDBNull(drViews("TagID"), "0"), Long) = 654 Or CType(CommonFunction.Data.CheckIsDBNull(drViews("TagID"), "0"), Long) = 428 Or CType(CommonFunction.Data.CheckIsDBNull(drViews("TagID"), "0"), Long) = 3755 Then
                    IsDisabled = True
                Else
                    IsDisabled = False
                End If

                strHTML.Append("<TR class='clsTRBlank'>")
                strHTML.Append("<td align='left' nowrap class='clsTDBlank'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkField", "chkField", , IsChecked, CommonFunctions.Data.CheckIsDBNull(drViews("TagID"), "0").ToString(), IsDisabled, , True))
                strHTML.Append("</td>")
                '''strHTML.Append("<td align='center' nowrap class='clsTDBlank'>")
                '''strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtOrderNumber" + CommonFunctions.Data.CheckIsDBNull(drViews("TagID"), "0").ToString(), "txtOrderNumber" + CommonFunctions.Data.CheckIsDBNull(drViews("TagID"), "0").ToString(), , 50, 2, IIf(OrderNumber.ToString = "0", "", OrderNumber.ToString), "right", , IsDisabled, , , , "onblur=txtOrderNumber_OnBlur(this) title='Order Number'", True))
                '''strHTML.Append("</td>")
                strHTML.Append("<td align='left' nowrap class='clsTDBlank'>")
                'sbHTML.Append("<td align='left' nowrap >" + strFieldName)
                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drViews("OptionName")).ToString() + "</td>")
                'sbHTML.Append("</td>")


                strHTML.Append("</TR>")

            End If
        End While

        'strHTML.Append("</table>")
        'strHTML.Append("</div>")


        strHTML.Append("</table>")
        '--commented by purvaj
        '''''strHTML.Append("<table id=""TblBX""  class='clsGridTable'cellpadding=0 cellspacing=1 width='" + width + "'>")
        '''''strHTML.Append("<tr class='clsTREven'><td  style='text-align:center;' nowrap colsapn='2' >")
        ''''''sbHTML.Append("<A style = 'text-decoration:none;valign:middle;' HREF='Javascript:applyFilter()' Title='Apply X-Axis Filter' ><Img Border=0  src='../../Images/Check.gif' ><b>Apply</b></A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        ''''''sbHTML.Append("<A style = 'text-decoration:none;valign:middle;' HREF='Javascript:CloseFilter()' Title='Close X-Axis Filter' ><Img Border=0  src='../../Images/delete.gif' ><b>Close</b></A>")
        '''''strHTML.Append("<span onclick='applyFilter()' style='cursor:pointer' title='Apply Filter'><Img Border=0  src='../../Images/Check.gif' ><b>Apply</b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        '''''strHTML.Append("<span onclick='CloseFilter()' style='cursor:pointer' title='Close Filter'><Img Border=0  src='../../Images/delete.gif' ><b>Close</b></span>")

        '''''strHTML.Append("</td>")

        '''''strHTML.Append("</tr>")
        '''''strHTML.Append("</table>")

        strHTML.Append("</div>")



        CommonFunctions.Data.DisposeDataReader(drViews)

        DrawGotoDiv = strHTML.ToString()

        strHTML = Nothing
    End Function

    Public Shared Function DrawViewDiv() As String
        Dim strHTML As New StringBuilder
        Dim drViews As IDataReader
        Dim strSQL As String = ""
        strSQL = "usp_Sel_HomeThemes " & m_strTagID & "," & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")

        drViews = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        strHTML.Append("<div id='DivMain'  style=""overflow:auto;height:350px;width=99.99%"" >")
        strHTML.Append("<table cellspacing='1' cellpadding='0' width=99.99% class='clsGridTable'>")

        While drViews.Read()
            strHTML.Append("<tr class='clsTRBlank'>")
            strHTML.Append("<td class='clsTDBlank'>")
            strHTML.Append("<a style=""text-decoration:none;"" href='javascript:ShowView(")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drViews("ThemeID"), "0").ToString())
            strHTML.Append(",")
            strHTML.Append(m_strTagID)
            strHTML.Append(")'>")
            
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drViews("ThemeName")).ToString())

            strHTML.Append("</a>")
            ''''''''''''''''''''''''''''''''
            strHTML.Append("</td>")
            strHTML.Append("<td class='clsTDBlank'>")

            If CType(CommonFunctions.Data.CheckIsDBNull(drViews("IsDefaultTheme"), "0"), Boolean) Then
                strHTML.Append("<a id='hrefDV' align='right' href='javascript:SetDefaultTheme(0,0)' style='text-decoration:none;cursor:default;'>")
                strHTML.Append("<font color='blue'>")
                strHTML.Append("Set As Default View")
                strHTML.Append("</font>")
            Else
                strHTML.Append("<a id='hrefDV' align='right'    href='javascript:SetDefaultTheme(" + CommonFunctions.Data.CheckIsDBNull(drViews("ThemeID"), "0").ToString() + "," + m_strTagID + ")'>")
                strHTML.Append("Set As Default View")

            End If
            strHTML.Append("</a>")
            strHTML.Append("</td>")
            ''''''''''''''''''''''''''''''''''''''''''''''''
            strHTML.Append("</tr>")
            'strHTML.Append("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td></tr>")
        End While

        strHTML.Append("</table>")
        strHTML.Append("</div>")

        CommonFunctions.Data.DisposeDataReader(drViews)

        DrawViewDiv = strHTML.ToString()

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

    Public Sub New()

    End Sub
End Class