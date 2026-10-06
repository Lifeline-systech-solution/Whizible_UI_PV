Imports Whizible
Public Class ProjectCharter
    Inherits WebPages.Template.WhizTemplate
    'Private WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected StrInitiatedBy As String
    Protected strMenu As String
    Protected m_strParamDate As String
    Protected insertFlag As Integer = 0
    Protected m_Action As String
    Protected UserName As String
    Protected strDateControlName As String
    Protected strPageName As String
    Protected drRow As String
    Protected strInitiatedDate As String
    Dim strSQL As String


#Region "Member variables"
    Protected m_SBHTML = New StringBuilder
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

    Public Sub PageInit()

      
        WritePageHeader()
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "SAVE" Then
            PerformAction()
        End If
        'TextFilter()
        ' DrawMenuAction()
        'If Trim(MyBase.GetFormValue("countdown")) <> "" Then
        '    m_strParamDate = Trim(FixString(MyBase.GetFormValue("countdown"), 0, False, False))


        'End If


    End Sub
    Protected Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        UserName = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))

        strDateControlName = System.DateTime.Today



        'strPageName = CType(CommonFunction.Data.CheckIsDBNull(drRow("Href"), "").Replace("<TODAYS_DATE>", CommonFunction.Dates.GetDate(Today));




    End Sub
    Protected Sub WritePage()
        '=====================================================================
        ' Function  Name		:	WritePage()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To Link Plotting like Timesheet.....
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	Dipali Vekhande
        ' Created				:	2/05/2016
        ' Revisions				:	
        '=====================================================================
        sbHTML = New StringBuilder


        sbHTML.Append("<div id='divGroupItems' style='OVERFLOW:auto;width:99.9%;valign:top;'>")
        'sbHTML.Append(TabGroups())
        DrawMenuAction()   'To plot Menu On head Of Page
        sbHTML.Append("</div>")

        'If IsFirstHit Then
        Response.Write(sbHTML.ToString)
        'Else
        'Response.Clear()
        'Response.Write(TabGroups())
        'Response.End()
        'End If

        sbHTML = Nothing

    End Sub





    'Public Function TabGroups() As String
    '    Dim sbFavTab As New StringBuilder("")

    '    Dim strPageName As String = ""
    '    Dim strToolTip As String = ""
    '    Dim strTagID As String = ""
    '    Dim strControlItemID As String = ""
    '    Dim strTagName As String = ""
    '    Dim PAGE_SIZE As Integer = 8 ' 7
    '    Dim intStartRecord As Integer = 0
    '    Dim IsModuleAccessible As Boolean = True
    '    Dim hrefClass As String = ""
    '    Dim m_intRowCount As Integer = 0
    '    Dim dblRatio As Double = 0.0

    '    '  m_intPageNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("PageNumber"), "1")

    '    'intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)

    '    Dim dsFAVTAB As DataSet
    '    Dim dsTemp As DataSet

    '    m_strSQL = "usp_sel_PM_Tab" ''& IIf(m_strGroupTabID <> "", m_strGroupTabID, "NULL")

    '    'm_strSQL &= "," & m_lngPostID.ToString
    '    'm_strSQL &= "," & m_GlobalObject.UserID.ToString
    '    'm_strSQL &= "," & m_GlobalObject.LoginType


    '    dsFAVTAB = CommonFunction.Data.GetDataSet(m_strSQL, "FAVTAB", intStartRecord, PAGE_SIZE, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

    '    dsTemp = CommonFunction.Data.GetDataSet(m_strSQL, "FAVTAB", , , CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

    '    m_intRowCount = dsTemp.Tables(0).Rows.Count

    '    If m_intRowCount > 0 Then

    '        dblRatio = m_intRowCount / PAGE_SIZE

    '        If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
    '            m_intPageNumber = 1
    '        End If

    '        With sbFavTab

    '            .Append("<TABLE  cellpadding=0 cellspacing=0 width='100%' class='clsTable'><TR class=clsTRBlank valign=middle>") '+ vbCrLf clsBody


    '            .Append("<TD class='clsTDBlank' width='1%'  align=right style=""valign:bottom;align:right"">") ''
    '            .Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()"" Title=""Previous Pages"" onmouseover=""window.status='Previous Pages';return true;"" onmouseout=""window.status=' ';return true;"">")
    '            '.Append("<Img id='prevLeft' Border=0 src='../../Images/Home/roundleft.gif' align='top'  style=""Margin-bottom:40%;""></A>")
    '            .Append("</Td>")


    '            .Append("<TD style='white-space: nowrap' valign='top' class='mainTabsSectionEasyMenu' >")


    '            For Each drRow As DataRow In dsFAVTAB.Tables(0).Select("1=1", "")


    '                strTagID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ID"), "0"), String)
    '                strTagName = CType(CommonFunction.Data.CheckIsDBNull(drRow("LINK"), ""), String)
    '                strToolTip = strTagName

    '                'If m_strDefaultPageURL = "" Then
    '                '    m_strDefaultPageURL = CType(CommonFunction.Data.CheckIsDBNull(drRow("Href"), ""), String).Replace("<TODAYS_DATE>", CommonFunction.Dates.GetDate(Today))
    '                'End If

    '                'strPageName = CType(CommonFunction.Data.CheckIsDBNull(drRow("Href"), ""), String).Replace("<TODAYS_DATE>", CommonFunction.Dates.GetDate(Today))

    '                'If strTagName.Length > 15 Then
    '                '    strTagName = strTagName.Substring(0, 10) + "...."
    '                'End If

    '                If CType(CommonFunction.Data.CheckIsDBNull(drRow("ID"), "0"), String) = strTagID Then
    '                    hrefClass = "selectedTab"
    '                End If

    '                .Append("<a class='" + hrefClass + "' id='atab1_" + strTagID + "' name='atab1'  style='cursor:hand;' Title='" + strToolTip + "'  onclick='javascript:TabItemOnClick(""" + strPageName + """," + strTagID + ",event)' >" + strTagName + "</a>") ''''border-top:1px solid gray;border-left:1px solid gray;border-bottom:1px solid gray;border-right:0px solid gray;	padding :1px 2px 1px 2px;	width:80px;	text-align:center;	background-image:url(""../../Images/cssImages/Menu.gif"");

    '                hrefClass = ""

    '            Next

    '            .Append("</TD>")


    '            .Append("<TD class='clsTDBlank' align=right width='1%' style=""valign:bottom;text-align:left;"">")
    '            .Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title='Next Pages' onmouseover=""window.status='Next Pages';return true;"" onmouseout=""window.status=' ';return true;"">")
    '            '.Append("<Img id='prevRight' Border=0 src='../../Images/Home/roundright.gif' align='top' style=""Margin-bottom:40%;""></A> ")
    '            .Append("</td>")



    '            .Append("</TR></TABLE>")

    '            'If IsFirstHit Then

    '            '    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
    '            '    .Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", , , , , True, EnableHTMLEncode:=True))
    '            '    .Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))
    '            '    'ended by Yogesh J for HTML encoding Date:05/10/15
    '            'End If

    '        End With
    '        'Else
    '        '    sbFavTab.Append("<TABLE  cellpadding=0 cellspacing=0 width='100%' class='clsTable'><TR  class=clsTRBlank valign=middle>") '+ vbCrLf clsBody
    '        '    sbFavTab.Append("<TD style='white-space: nowrap;align:center;text-align:center;' valign='bottom' class='clsTDBlank'  >")
    '        '    sbFavTab.Append("There are no accessible pages to show in this view.")
    '        '    sbFavTab.Append("</TD>")
    '        '    sbFavTab.Append("</TR></TABLE>")
    '    End If
    '    TabGroups = sbFavTab.ToString

    '    sbFavTab = Nothing
    '    dsFAVTAB = Nothing

    'End Function

    Protected Sub WritePageHeader()
        '====================================================================
        ' Procedure Name       : WritePageHeader
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : WritePageHeader
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : Dipali Vekhande
        ' Created              : April 29, 2016
        ' Revisions            : 
        '=====================================================================


        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, , , "Project Charter", True))
        'WritePage()
        CommonFunctions.General.WriteHTML("<div id='DivMain' name='DivMain' style='overflow:auto;width:99.99%'>")
        WritePage()   'Page Caption
        DrawTable()   'To Plot Table
        MenuTab()
        ' CommonFunctions.General.WriteHTML("<div id='SearchKeyDiv' name='SearchKeyDiv'  style='display:none; height:82px;width:50%' border:1px solid grey; overflow:auto'>")
        CommonFunctions.General.WriteHTML("</div>")
    End Sub


    Public Sub DrawTable()

        '====================================================================
        ' Procedure Name       : DrawTable
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Dispaly the Control in side the table
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : Dipali Vekhande
        ' Created              : April 28, 2016
        ' Revisions            : 
        '=====================================================================

        Dim sbHTML As New StringBuilder("")
        Dim strTempHTML As String = ""
        Dim strQuery As String = ""


        sbHTML.Append("<TABLE Class='clsTable' Width='99.9%' cellpadding=0 cellspacing=0>")
        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD valign='Top' align='Left' style='margin-right:49%;Float:right' title='Project Title'>Project Title</TD>")
        'sbHTML.Append("<B Style='margin-left:30%'>Project Title</B>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("<TD valign='Top'>")
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("textName", "textName", , , , , , , , , , False, , True, True))
        sbHTML.Append("</TD>")
        sbHTML.Append("<TD valign='Top' align='Left' title='Code' style='margin-right:65%;Float:right'>Code</tD>")
        'sbHTML.Append("<B Style='margin-left:6%'>Code</B>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("<TD>")
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("projectCode", "projectCode", , , , , , , , , , False, , True, True))
        sbHTML.Append("</TD></TR><br/>")
        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD  align='Left'  title='Project Description' style='margin-right:35%;Float:right'>Project Description</TD>")
        sbHTML.Append("<TD>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("TEXTDescription", "TEXTDescription", , , , , , , , , 500, , , "margin-top:2%;width:146px", , , , , "onKeyDown='javascript:limitText(this,countdown,500)' onKeyUp='javascript:limitText(this,countdown,500)';", True, True))
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("TEXTDescription", "TEXTDescription", , , , , , , , , 500, , , "margin-top:2%;width:146px", , , , , "onKeyDown='javascript:limitText(this,countdown,500)' onKeyUp='javascript:limitText(this,countdown,500)';", True, True, EnableHTMLEncode:=True))
        ''End of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        sbHTML.Append("</TD>")
        sbHTML.Append("<td style='margin-left:-11%; float: left'><input readonly type='text' name='countdown' Id='countdown'  style='width:'18%' size='3' value='500'></input></td>")
        sbHTML.Append("<TD  align='Left' title='Customer' style='margin-right:52%;Float:right;margin-top:6%'>Customer</TD>")
        'sbHTML.Append("<B Style='margin-left:6%'>Customer</B>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("<TD >")
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("Customer", "Customer", , , , , , , , , , False, "onkeyup='javascript:Unit_ONClick_Project(this.id)' OnBlur='javascript:ValidateText(this.id)';", True, True))
        'sbHTML.Append("<div id='SearchKeyDiv'></div>")
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txthidProjectID", "txthidProjectID", , , , Request.QueryString("Customer"), , , , , , True, , True))

        sbHTML.Append("</TD></TR>")
        'sbHTML.Append("<TR class='clsTREven' style='float: right; margin-right: -38%;'><TD>[Maximaum Character:500]</TD></TR>")
        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD  align='Left' title='Business Need' style='margin-right:44%;Float:right'>Business Need</TD>")
        'sbHTML.Append("<B Style='margin-left:30%'>Business Need </B>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("<TD>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("textBNeed", "textBNeed", , , , , , , , , , , , "margin-top:2%;width:146px", , , , , "onKeyDown='javascript:limitText(this,countdown1,500)' onKeyUp='javascript:limitText(this,countdown1,500)';", True, True))
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("textBNeed", "textBNeed", , , , , , , , , , , , "margin-top:2%;width:146px", , , , , "onKeyDown='javascript:limitText(this,countdown1,500)' onKeyUp='javascript:limitText(this,countdown1,500)';", True, True, EnableHTMLEncode:=True))
        ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        sbHTML.Append("</TD>")
        sbHTML.Append("<td style='margin-left:-11%; float: left'><input readonly type='text' name='countdown1' Id='countdown1'  width='18%' size='3' value='500'></input></td>")
        sbHTML.Append("<TD  align='Left' title='Initiated By' style='margin-right:46%;Float:right;margin-top:6%'>Initiated By</TD>")
        'sbHTML.Append("<B Style='margin-left:6%'>Initiated By</B>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("<td>" + CommonFunction.HTMLControls.DrawTextBox("Initiatedby", "Initiatedby", , , , , , , True, , , False, , True, True) + "</td>")
        sbHTML.Append("</TR>")
        'sbHTML.Append("<TR class='clsTREven' style='float: right; margin-right: -38%;'><TD>[Maximaum Character:500]</TD></TR>")
        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD  align='Left' title='Background' style='margin-right:50%;Float:right'>Background</TD>")
        'sbHTML.Append("<B Style='margin-left:30%'>Background</B>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("<TD>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("textBlack", "textBlack", , , , , , , , , , , , "margin-top:2%;width:146px", , , , , , True, True))
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("textBlack", "textBlack", , , , , , , , , , , , "margin-top:2%;width:146px", , , , , , True, True, EnableHTMLEncode:=True))
        ''End of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        sbHTML.Append("</TD>")
        sbHTML.Append("<TD  align='Left' title='Approved By' style='margin-right:44%;Float:right'>Approved By</TD>")
        'sbHTML.Append("<B Style='margin-left:6%'>Approved By</B>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("<td>" + CommonFunction.HTMLControls.DrawComboBox("strapproved", "usp_Cmd_tbl_PM_EPC_PowerIntensity_For_ProjectCharterDetail", 154, , "disabled ", True, True, , True) + "</td>")
        sbHTML.Append("</TR>")
        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD  align='Left' title='Statement Of Work(SOW)' style='margin-right:21%;Float:right'>Statement Of Work(SOW)</TD>")
        'sbHTML.Append("<B Style='margin-left:30%'>Statement Of Work(SOW)</B>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("<TD>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        '' sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("textSOW", "textSOW", , , , , , , , , , , , "margin-top:2%;width:146px", , , , , , True, True))
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("textSOW", "textSOW", , , , , , , , , , , , "margin-top:2%;width:146px", , , , , , True, True, EnableHTMLEncode:=True))
        ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        sbHTML.Append("</TD>")
        sbHTML.Append("<TD  align='Left' title='Initiation Date'style='margin-right:39%;Float:right'>Initiation Date</TD>")
        'sbHTML.Append("<B Style='margin-left:6%'>Initiation Date</B>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("<td>" + CommonFunction.HTMLControls.DrawDateControl("DateControlName", "DateControlName", , 154, Today.Date, , "frmProjectcharter", , , , True, False, "", True, True, , ) + "</td>")
        sbHTML.Append("</TR>")
        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD  align='Left' title='Constraints and Assumptions' style='margin-right:15%;Float:right' >Constraints and Assumptions</TD>")
        'sbHTML.Append("<B Style='margin-left:30%'>Constraints and Assumptions</B>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("<TD>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtCandA", "txtCandA", , , , , , , , , , , , "margin-top:2%;width:146px", , , , , , True, True))
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtCandA", "txtCandA", , , , , , , , , , , , "margin-top:2%;width:146px", , , , , , True, True, EnableHTMLEncode:=True))
        ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        sbHTML.Append("</TD>")
        sbHTML.Append("<TD  align='Left' title='Approval Date' style='margin-right:40%;Float:right' >Approval Date</TD>")
        'sbHTML.Append("<B Style='margin-left:6%'>Approval Date</B>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("<td>" + CommonFunction.HTMLControls.DrawDateControl("ApprovalDate", "ApprovalDate", , 154, , , "frmProjectcharter", , , , True, False, "", True, True, , ) + "</td>")
        sbHTML.Append("</TR><br/></TABLE>")
        Response.Write(sbHTML.ToString())

    End Sub

    Public Sub MenuTab()
        '====================================================================
        ' Procedure Name       : MenuTag
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Plotting MenuTag
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : Dipali Vekhande
        ' Created              : May 2, 2016
        ' Revisions            : 
        '=====================================================================

        CommonFunctions.General.WriteHTML("<div id='tabs' name='tabs' style='overflow:auto;width:99.99% Margin-top:3%'>")
        CommonFunctions.General.WriteHTML("<Ul>")
        CommonFunctions.General.WriteHTML("<li>")
        CommonFunctions.General.WriteHTML("<a href=""#a"" title='Project Stakeholders'>Project Stakeholders</a>")
        CommonFunctions.General.WriteHTML("</li>")
        CommonFunctions.General.WriteHTML("<li>")
        CommonFunctions.General.WriteHTML("<a href=""#b""  title='SubContrators'>SubContrators</a>")
        CommonFunctions.General.WriteHTML("</li>")
        CommonFunctions.General.WriteHTML("<li>")
        CommonFunctions.General.WriteHTML("<a href=""#c"" title='Consultants'>Consultants</a>")
        CommonFunctions.General.WriteHTML("</li>")
        CommonFunctions.General.WriteHTML("<li>")
        CommonFunctions.General.WriteHTML("<a href=""#d"" title='Pre-resources'>Pre-resources</a>")
        CommonFunctions.General.WriteHTML("</li>")
        CommonFunctions.General.WriteHTML("<li>")
        CommonFunctions.General.WriteHTML("<a href=""#e"" title='Risk'>Risk</a>")
        CommonFunctions.General.WriteHTML("</li>")
        CommonFunctions.General.WriteHTML("<li>")
        CommonFunctions.General.WriteHTML("<a href=""#f"" title='BOQ'>BOQ</a>")
        CommonFunctions.General.WriteHTML("</li>")
        CommonFunctions.General.WriteHTML("<li>")
        CommonFunctions.General.WriteHTML("<a href=""#g"" title='Major Milestones'>Major Milestones</a>")
        CommonFunctions.General.WriteHTML("</li>")
        CommonFunctions.General.WriteHTML("<li>")
        CommonFunctions.General.WriteHTML("<a href=""#h"" title='Ref Documents'>Ref Documents</a>")
        CommonFunctions.General.WriteHTML("</li>")
        CommonFunctions.General.WriteHTML("<li>")
        CommonFunctions.General.WriteHTML("<a href=""#i"" title='Project Cost'>Project Cost</a>")
        CommonFunctions.General.WriteHTML("</li>")
        CommonFunctions.General.WriteHTML("</Ul>")
        CommonFunctions.General.WriteHTML("<div id='a' name='tabs'>")
        'CommonFunctions.General.WriteHTML("<B>Project Stakeholder</B>")
        CommonFunctions.General.WriteHTML("<iframe name='link' scrolling='no' class='iframeLinks' src ='ProjectCharterDetails.aspx' margin-top:'0' margin-bottom:'0' border:'0'  target:'_sel' margin-left:'0' margin-right:'0' style='width: 225%; height:220px;''></iframe>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("<div id='b' name='tabs'>")
        CommonFunctions.General.WriteHTML("<B>SubContrators</B>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("<div id='c' name='tabs' >")
        CommonFunctions.General.WriteHTML("<B>Consultants</B>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("<div id='d' name='tabs' >")
        CommonFunctions.General.WriteHTML("<B>Pre-resources</B>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("<div id='e' name='tabs' >")
        CommonFunctions.General.WriteHTML("<B>Risk </B>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("<div id='f' name='tabs' >")
        CommonFunctions.General.WriteHTML("<B>BOQ</B>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("<div id='g' name='tabs' >")
        CommonFunctions.General.WriteHTML("<B>Major Milestones</B>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("<div id='h' name='tabs' >")
        CommonFunctions.General.WriteHTML("<B>Ref Documents</B>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("<div id='i' name='tabs' >")
        CommonFunctions.General.WriteHTML("<B>Project Cost</B>")
        CommonFunctions.General.WriteHTML("</div>")
        'Response.Write(WriteHTML.ToString())
    End Sub


    Protected Sub DrawMenuAction()

        '====================================================================
        ' Procedure Name       : DrawMenuAction
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Plotting DrewMenuAction
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : Dipali Vekhande
        ' Created              : May 3, 2016
        ' Revisions            : 
        '=====================================================================
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String
        Dim sbSTRHTML As New System.Text.StringBuilder
        Dim strQuery As String
        Dim strActiveTAManager As String


        Dim m_arrMenu() As String = {"Convert to Project", "Send For Approval", "Draft", "Save", "Snapshot", "History", "Send Email", "Reports"}
        Dim m_arrMenuToolTip() As String = {"Convert to Project", "Send For Approval", "Draft", "Save", "Snapshot", "History", "Send Email", "Reports"}
        Dim m_arrCSFunction() As String = {"Convert_Onclick()", "Send_Onclick()", "Draft_Onclick()", " Save_OnClick()", "Snapshot_Onclick()", "Histroy_Onclick()", "Email_Onclick()", "report_Onclick()"}
        arrMenu = m_arrMenu
        arrMenuToolTip = m_arrMenuToolTip
        arrCSFunction = m_arrCSFunction


        'Dim strMenu, strLegend As String
        'Dim arrLegend() As String = {"Mandatory"}
        'Dim arrLegendImage() As String = {"<img src='../../Images/star.gif'>"}
        m_SBHTML = New StringBuilder
        ' For MANDATORY FILED
        m_SBHTML.Append("<table id='tblPL00' CellSpacing=0 width='99.9%' class=clsTable>")
        m_SBHTML.Append("<tr class=clsTRBlank>")
        m_SBHTML.Append("<td align='left' valign='top' class='clsTDBlank' >")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td align='Right' valign='top' >")
        m_SBHTML.Append("<B>(<img src='../../images/star.gif'> Mandatory)</B>")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("</tr>")
        m_SBHTML.Append("</table>")
        'm_SBHTML.Append("<hr style='color:lightblue;height:1px;'/>")

        Response.Write(m_SBHTML.ToString)
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, )

        sbSTRHTML.Append(strMenu)

        'DrawFilters(sbSTRHTML)

        'sbSTRHTML.Append("<br>")

        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

    End Sub

    Protected Sub PerformAction()
        '====================================================================
        ' Procedure Name       : PerformAction
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : To save All page data in DB
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : Dipali Vekhande
        ' Created              : May 4, 2016
        ' Revisions            : 
        '=====================================================================
        Dim strSQL As String


        Dim strProjecttitle, strProjectCode, strProjectDescription, strCustomerID, StrBussinessNeed, StrInitiatedBy, StrBackground, StrApprovedBy, strStateOFWork, strInitiatedDate, strConstratintsAndAssumptions, strApprovalDate As String
        UserName = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))
        strDateControlName = System.DateTime.Today
        strProjecttitle = Request.Form("textName")
        strProjectCode = Request.Form("projectCode")
        strProjectDescription = Request.Form("TEXTDescription")
        strCustomerID = Request.Form("txthidProjectID")
        StrBussinessNeed = Request.Form("textBNeed")
        StrInitiatedBy = Request.Form("Initiatedby")
        StrBackground = Request.Form("textBlack")
        StrApprovedBy = Request.Form("strapproved")
        strStateOFWork = Request.Form("textSOW")
        strInitiatedDate = Request.Form("DateControlName")
        strConstratintsAndAssumptions = Request.Form("txtCandA")
        strApprovalDate = Request.Form("ApprovalDate")
        Try
            strSQL = "usp_Ins_Tbl_PM_EPC_ProjectCharters'" + strProjecttitle + "',"
            strSQL += "'" + strProjectCode + "','" + strProjectDescription + "','" + strCustomerID + "','" + StrBussinessNeed + "','" + UserName + "','" + StrBackground + "','" + StrApprovedBy + "','" + strStateOFWork + "','" + strInitiatedDate + "','" + strConstratintsAndAssumptions + "','" + strApprovalDate + "'"
            If CommonFunction.Data.InsertOrUpdateData(strSQL, True) = -1 Then
                insertFlag = 0            ' insertFlag = 1  BEFORE sa

                'Response.Write("<script>alert('Data Save Successfully!!!!!!');</script>")
            End If
            '" + intProjectID.ToString() + "'
        Catch ex As Exception

            'If CommonFunction.Data.InsertOrUpdateData(strSQL, True) = 0 Then
            '    insertFlag = 0
            '    'Response.Write("<script>alert('Data Save Successfully!!!!!!');</script>")
            'End If

        End Try



        'strSQL = "usp_Ins_Tbl_PM_EPC_ProjectCharters '" + strProjecttitle + "',"
        'strSQL += "'" + strProjectCode + "','" + strProjectDescription + "','" + strCustomerID + "','" + StrBussinessNeed + "','" + StrInitiatedBy + "','" + StrBackground + "','" + StrApprovedBy + "','" + strStateOFWork + "','" + strInitiatedDate + "','" + strConstratintsAndAssumptions + "','" + strApprovalDate + "'"

        'If CommonFunction.Data.InsertOrUpdateData(strSQL, True) = -1 Then
        '    insertFlag = 1
        '    'Response.Write("<script>alert('Data Save Successfully!!!!!!');</script>")
        'End If


        ' CreateQuickTasks(strProjectID, strTaskTypeID, strSubTaskTypeID, strDescription, strWork, strUniqueID)
        'Next
    End Sub
End Class



