Imports Whizible
Public Class MB_InheritMetrics_Corporate
    Inherits WebPage.Templates.WhizTemplate

    Protected m_intCnt As Integer = 1
    Protected m_intMetricCategory As String
    Protected m_strMetricFlt As String
    Protected m_action As String = ""

    Private m_strAlphaNumericPagingSQL As String
    Private m_strAlphabet As String = "-1"
    Private m_intPageNumber As Integer = 1
    Protected m_intTotalNoOfRows As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ''Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 
    End Sub
    Protected Sub InitPage()
        '=====================================================================
        ' Procedure Name        : InitPage()	
        ' Purpose               : To call all the procudures 
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        '=====================================================================
        m_intMetricCategory = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CategoryID"), "0")
        If m_intMetricCategory = "0" Then
            m_intMetricCategory = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCategory"), "0")
        End If
        If m_intMetricCategory = "" Then
            m_intMetricCategory = "0"
        End If
        m_strMetricFlt = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MetricName"), "")
        If m_strMetricFlt = "" Then
            m_strMetricFlt = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtMetricFlt"), "")
        End If
        m_action = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "")
        m_intPageNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PageNumber"), 1)
        With Response
            ' menu
            .Write(GetMenu(False))
            ' page caption 
            WebPage.Templates.PageCaption.GetPageCaptions(, "Inherit Metrics")
            .Write("<BR>" + vbCrLf)
            DrawFilter()
            .Write("<br>")
            WritePaging()
            .Write("<br>")
            DrawPage()
            '.Write(GetMenu(False))

            If m_action.ToUpper = "SAVE" Then
                PerformAction()
            End If
        End With
    End Sub
    Private Function GetMenu(ByVal IgnorePaging As Boolean) As String
        '=====================================================================
        ' Procedure Name        : GetMenu()	
        ' Purpose               : To get the menu for current mode
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : string of menu
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        '=====================================================================

        Dim strSQL As String = ""
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), ""}
        Dim arrImages() As String = {"../../Images/cssImages/Link images/save.gif", "../../Images/cssImages/Link images/close.gif", "../../Images/cssImages/Link images/help.gif"}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrCSFunction() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick(2128)"}

        Return WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, True, , , arrImages)


    End Function
    Private Sub WritePaging()
        '=====================================================================
        ' Procedure Name        : WritePaging
        ' Description           : To write the paging for the request grid
        ' Purpose               : 
        ' Parameters Passed     : SQL for paging
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        '=====================================================================

        Dim PagingSQL As String
        Dim intRecordCount As Integer
        Dim strPaging As String = ""
        PagingSQL = "usp_tbl_Sel_Metric_Project_BreakUp_Mapping_paging " & Session("intProjectID").ToString & "," & IIf(m_intMetricCategory = "0", "NULL", m_intMetricCategory) & "," & IIf(m_strMetricFlt = "", "null", "'" & CommonFunction.General.BuildQueryString(m_strMetricFlt) & "'")

        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)
        If Math.Ceiling(m_intTotalNoOfRows / 10) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            ''''Commented And Added By Vaijat K On 06/10/2015
            '''strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            ''''End Added By Vaijat K On 06/10/2015
        Else
            ''''Commented And Added By Vaijat K On 06/10/2015
            '''strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            ''''End Added By Vaijat K On 06/10/2015
        End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 10)).ToString + ">"

        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 10)).ToString
        strPaging += "|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All<B></A>"
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 10)).ToString, returnHTML:=True, DisplayNone:=True)
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 10)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        ''''End Added By Vaijat K On 06/10/2015
        If Trim(strPaging & "") <> "" Then
            Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
        End If

    End Sub
    Private Sub DrawFilter()
        '=====================================================================
        ' Procedure Name        : DrawFilter()	
        ' Purpose               : To write the Filters 
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ArchanaN
        ' Created Date          : 6-Apr-2010
        '=====================================================================
        Dim sbHTML As New System.Text.StringBuilder("")
        sbHTML.Append("<DIV id=divFilter style='overflow:auto;'>")
        sbHTML.Append("<Table width='100%' cellpadding=0 cellspacing=0 >")
        sbHTML.Append("<Tr class=clsTRBlank>")
        'Modified(valign=top to middle) By Bharat T on 15th-Oct-2015
        sbHTML.Append("<TD valign=middle align=Right><b>Metric Category</b>&nbsp;&nbsp;</td>")
        sbHTML.Append("<TD valign=middle align=Left>" & CommonFunction.HTMLControls.DrawComboBox("cboCategory", "select CategoryID,CategoryName from tbl_PRS_MetricCategory Order By 2", 150, m_intMetricCategory, "onchange=FilterOnChange()", True, True) & "</TD>")
        sbHTML.Append("<TD valign=middle align=Right><b>Metric Name</b>&nbsp;&nbsp;</td>")
        ''''Commented And Added By Vaijat K On 06/10/2015
        ''sbHTML.Append("<TD valign=top align=Left>" & CommonFunction.HTMLControls.DrawTextBox("txtMetricFlt", "txtMetricFlt", , 150, 500, m_strMetricFlt, ToBeInserted:="onKeyPress=txtName_OnKeyPress()", returnHTML:=True) & "</TD>")
        sbHTML.Append("<TD valign=middle align=Left>" & CommonFunction.HTMLControls.DrawTextBox("txtMetricFlt", "txtMetricFlt", , 150, 500, m_strMetricFlt, ToBeInserted:="onKeyPress=txtName_OnKeyPress()", returnHTML:=True, EnableHTMLEncode:=True) & "</TD>")
        'End of Modified By Bharat T on 15th-Oct-2015
        ''''End Added By Vaijat K On 06/10/2015
        sbHTML.Append("</table>")
        sbHTML.Append("</div>")
        CommonFunction.General.WriteHTML(sbHTML.ToString)

    End Sub

    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page 
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ArchanaN
        ' Created Date          : 6-Apr-2010
        '=====================================================================
        Dim drRead As IDataReader
        Dim strSQL As String = ""
        'Dim intMetricProjectMappingID As Integer
        Dim intMetricID As Integer
        Dim strMetricName As String = ""
        Dim StrGuidelines As String = ""
        Dim dblUCL As Double
        Dim dblLCL As Double
        Dim dblUSL As Double = 0
        Dim dblLSL As Double = 0
        Dim dblTarget As Double = 0
        Dim strFormula As String = ""
        Dim blnSelect As Boolean
        Dim blnIsApplicable As Boolean = False
        Dim blnIsDelApplicable As Boolean = False
        Dim blnIsMileApplicable As Boolean = False
        Dim blnIsPhaseApplicable As Boolean = False
        Dim intGraphType As Integer = "2"
        Dim blnSelectAll As Boolean
        Dim blnIsDisabled As Boolean = False
        Dim blnIsChecked As Boolean = False
        Dim sbHTML As New System.Text.StringBuilder("")
        Dim ReadCount As Integer


        If m_strMetricFlt = "" Then
            m_strMetricFlt = "NULL"
        Else
            m_strMetricFlt = "'" & CommonFunction.General.BuildQueryString(m_strMetricFlt) & "'"
        End If
        strSQL = "usp_tbl_Sel_Metric_Project_BreakUp_Mapping " & Session("intProjectID").ToString & "," & IIf(m_intMetricCategory = "0", "NULL", m_intMetricCategory) & "," & m_strMetricFlt & "," & m_intPageNumber.ToString
        drRead = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        'Added By Bharat T on 15th-Oct-2015
        'sbHTML.Append("<DIV id=divList style='width:99.9%;height:600;overflow:scroll'>")
        sbHTML.Append("<DIV id=divList style='width:99.9%;height:465;overflow:auto'>")
        'Ended By Bharat T on 15th-Oct-2015
        sbHTML.Append("<Table id='divTblGrid' border=1 class='clsGridTable' width='100%' cellpadding=0 cellspacing=0 style=""height:20;overflow:auto;BORDER-BOTTOM: #000000 1px solid;BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid;BORDER-RIGHT: #000000 1px solid; "">")
        sbHTML.Append("<THead class='clsTRColumnHeader'>")

        sbHTML.Append("<TH class='FixedTD' style=""BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid;"" valign=top align=center width=3%>" & CommonFunction.HTMLControls.DrawCheckBox("chkSelectAll", "chkSelectAll", , blnSelectAll, blnSelectAll, , "onClick='SelectAll_Onclick()'", True) & "</TH>")
        sbHTML.Append("<TH class='FixedTD' style=""BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid;"" valign=top align=Left width=20%>Metric Name</TH>")
        sbHTML.Append("<TH class='FixedTD' style=""BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid;"" valign=top align=right width=7%>UCL</TH>")
        sbHTML.Append("<TH class='FixedTD' style=""BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid;"" valign=top align=right width=7%>LCL</TH>")
        sbHTML.Append("<TH class='FixedTD' style=""BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid;"" valign=top align=left width=30%>Guidelines</TH>")
        sbHTML.Append("<TH class='FixedTD' style=""BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid;"" valign=top align=left width=30%>Formula</TH>")
        sbHTML.Append("<TH class='FixedTD' style=""BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid;"" valign=top align=center width=10%>Applicable for P/M/D</TH>")

        sbHTML.Append("</THead>")
        'sbHTML.Append("</table>")
        'sbHTML.Append("</div>")

        'sbHTML.Append("<Table id='divTbl' class=clsTable width='100%' cellpadding=0 cellspacing=0 style=""height:600;overflow:auto;BORDER-BOTTOM: #000000 1px solid;BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid;BORDER-RIGHT: #000000 1px solid; "">")
        'sbHTML.Append("<DIV id=div2 style='width:99.9%;height:700;overflow:scroll'>")
        If m_intPageNumber > 1 Then
            For ReadCount = 1 To (10 * (m_intPageNumber - 1))
                drRead.Read()
            Next
        End If

        While drRead.Read
            strMetricName = CommonFunction.Data.CheckIsDBNull(drRead("Name"), "")
            StrGuidelines = CommonFunction.Data.CheckIsDBNull(drRead("Guidelines"), "")
            dblUCL = CommonFunction.Data.CheckIsDBNull(drRead("Above"), 0)
            dblLCL = CommonFunction.Data.CheckIsDBNull(drRead("Below"), 0)
            intMetricID = CommonFunction.Data.CheckIsDBNull(drRead("MetricID"), 0)
            strFormula = CommonFunction.Data.CheckIsDBNull(drRead("UDFormula"), "")
            blnIsApplicable = CType(CommonFunction.Data.CheckIsDBNull(drRead("IsEnableForPMD"), 0), Boolean)

            If blnIsApplicable = True Then
                blnIsChecked = True
                blnIsDelApplicable = True
                blnIsPhaseApplicable = True
                blnIsMileApplicable = True
                blnIsDisabled = False
            Else
                blnIsDisabled = True
                blnIsChecked = False
            End If

            sbHTML.Append("<Tr class='clsTREvenRow'>")
            sbHTML.Append("<TD width=3% valign=top style=""BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid;BORDER-RIGHT: #000000 1px solid; "" align=center>")
            sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkSelect_" + m_intCnt.ToString, "chkSelect_" + m_intCnt.ToString, , blnSelect, blnSelect, , "onClick='Select_Onclick(" & m_intCnt.ToString & ")'", True))
            ''''Commented And Added By Vaijat K On 06/10/2015
            ' ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtpk_" + m_intCnt.ToString, "txtpk_" + m_intCnt.ToString, , , , 0, IsHidden:=True))
            ' ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txUCL_" + m_intCnt.ToString, "txUCL_" + m_intCnt.ToString, , , , dblUCL.ToString, IsHidden:=True))
            ' ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txLCL_" + m_intCnt.ToString, "txLCL_" + m_intCnt.ToString, , , , dblLCL.ToString, IsHidden:=True))
            ' ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtMetricID_" + m_intCnt.ToString, "txtMetricID_" + m_intCnt.ToString, , , , intMetricID.ToString, IsHidden:=True))

            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtpk_" + m_intCnt.ToString, "txtpk_" + m_intCnt.ToString, , , , 0, IsHidden:=True, EnableHTMLEncode:=True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txUCL_" + m_intCnt.ToString, "txUCL_" + m_intCnt.ToString, , , , dblUCL.ToString, IsHidden:=True, EnableHTMLEncode:=True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txLCL_" + m_intCnt.ToString, "txLCL_" + m_intCnt.ToString, , , , dblLCL.ToString, IsHidden:=True, EnableHTMLEncode:=True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtMetricID_" + m_intCnt.ToString, "txtMetricID_" + m_intCnt.ToString, , , , intMetricID.ToString, IsHidden:=True, EnableHTMLEncode:=True))

            ''''End Added By Vaijat K On 06/10/2015
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD valign=top style=""BORDER-TOP: #000000 1px solid;BORDER-LEFT: #000000 1px solid; "" width=20% align=Left>" & strMetricName & "</TD>")
            sbHTML.Append("<TD valign=top style=""BORDER-TOP: #000000 1px solid; "" align=right width=7% >" & dblUCL & "</TD>")
            sbHTML.Append("<TD valign=top style=""BORDER-TOP: #000000 1px solid; "" align=right width=7%>" & dblLCL & "</TD>")
            sbHTML.Append("<TD valign=top style=""BORDER-TOP: #000000 1px solid; "" align=left width=30%>" & IIf(StrGuidelines = "", "&nbsp;", StrGuidelines) & "</TD>")
            sbHTML.Append("<TD valign=top style=""BORDER-TOP: #000000 1px solid; "" align=left width=30%>" & IIf(strFormula = "", "&nbsp;", strFormula) & "</TD>")
            sbHTML.Append("<TD valign=top style=""BORDER-TOP: #000000 1px solid;  BORDER-RIGHT: #000000 1px solid;"" align=center width=10%>")
            sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkApplicable_" & m_intCnt.ToString, "chkApplicable_" & m_intCnt.ToString, , blnIsApplicable, blnIsApplicable, True, , True))
            sbHTML.Append("</TD>")
            sbHTML.Append("</Tr>")
            ' sbHTML.Append("<Tr  class='clsTREven'><td style=""BORDER-RIGHT: #000000 1px solid;  BORDER-LEFT: #000000 1px solid;"" height=10%>&nbsp;</td>")
            'sbHTML.Append("<td colspan=7 style=""BORDER-RIGHT: #000000 1px solid;  BORDER-LEFT: #000000 1px solid; "" height=7%>&nbsp;</td></tr>")

            sbHTML.Append("<Tr id='trProjLevel_" & m_intCnt.ToString & "'  class=clsTRSectionHeader>")
            sbHTML.Append("<TD style=""BORDER-RIGHT: #000000 1px solid; BORDER-LEFT: #000000 1px solid;"">&nbsp;</TD>")
            sbHTML.Append("<TD colspan=6 style=""BORDER-LEFT: #000000 1px solid; BORDER-RIGHT: #000000 1px solid;"" >&nbsp;&nbsp;&nbsp;&nbsp;")
            sbHTML.Append("<font style='FONT-SIZE: 9px; MARGIN: 2px; FONT-FAMILY: ""Verdana, Arial"" ;font-weight: bold'>")
            ''''Commented And Added By Vaijat K On 06/10/2015
            ' ''sbHTML.Append("<b>USL</b> " & CommonFunction.HTMLControls.DrawTextBox("txtUSL_" & m_intCnt.ToString, "txtUSL_" & m_intCnt.ToString, , 60, 8, dblUSL.ToString, "right", returnHTML:=True) & "&nbsp;&nbsp;")
            ' ''sbHTML.Append("<b>LSL</b> " & CommonFunction.HTMLControls.DrawTextBox("txtLSL_" & m_intCnt.ToString, "txtLSL_" & m_intCnt.ToString, , 60, 8, dblUSL.ToString, "right", returnHTML:=True) & "&nbsp;&nbsp;")
            ' ''sbHTML.Append("<b>Target</b> " & CommonFunction.HTMLControls.DrawTextBox("txtTarget_" & m_intCnt.ToString, "txtTarget_" & m_intCnt.ToString, , 60, 8, dblTarget.ToString, "right", returnHTML:=True) & "&nbsp;&nbsp;")

            sbHTML.Append("<b>USL</b> " & CommonFunction.HTMLControls.DrawTextBox("txtUSL_" & m_intCnt.ToString, "txtUSL_" & m_intCnt.ToString, , 60, 8, dblUSL.ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) & "&nbsp;&nbsp;")
            sbHTML.Append("<b>LSL</b> " & CommonFunction.HTMLControls.DrawTextBox("txtLSL_" & m_intCnt.ToString, "txtLSL_" & m_intCnt.ToString, , 60, 8, dblUSL.ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) & "&nbsp;&nbsp;")
            sbHTML.Append("<b>Target</b> " & CommonFunction.HTMLControls.DrawTextBox("txtTarget_" & m_intCnt.ToString, "txtTarget_" & m_intCnt.ToString, , 60, 8, dblTarget.ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) & "&nbsp;&nbsp;")
            ''''End Added By Vaijat K On 06/10/2015
            sbHTML.Append("<b>Graph Type</b> " & CommonFunction.HTMLControls.DrawComboBox("cboGraphType_" & m_intCnt.ToString, "usp_SEL_GraphType_Metrics ", 150, intGraphType.ToString, , True, ReturnAsHTML:=True) & "&nbsp;&nbsp;<b>Applicable for</b>&nbsp;&nbsp;")
            sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkDelApplicable_" & m_intCnt.ToString, "chkDelApplicable_" & m_intCnt.ToString, , blnIsChecked, blnIsDelApplicable, blnIsDisabled, "onclick=Attributes_onChecked(" & m_intCnt.ToString & ")", True) & "<b> Deliverable</b>" & "&nbsp;&nbsp;")
            sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkPhaseApplicable_" & m_intCnt.ToString, "chkPhaseApplicable_" & m_intCnt.ToString, , blnIsChecked, blnIsPhaseApplicable, blnIsDisabled, "onclick=Attributes_onChecked(" & m_intCnt.ToString & ")", True) & "<b> Phase</b>" & "&nbsp;&nbsp;")
            sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkMileApplicable_" & m_intCnt.ToString, "chkMileApplicable_" & m_intCnt.ToString, , blnIsChecked, blnIsMileApplicable, blnIsDisabled, "onclick=Attributes_onChecked(" & m_intCnt.ToString & ")", True) & "<b> Milestone</b></TD>")
            sbHTML.Append("</font>")

            sbHTML.Append("</Tr>")
            m_intCnt += 1
        End While
        If m_intCnt = 1 Then
            sbHTML.Append("<Tr class=clsTROdd>")
            sbHTML.Append("<td colspan = 7 align=center>")
            sbHTML.Append("There are no items to show in this view.")
            sbHTML.Append("</TD>")

        End If
        sbHTML.Append("</Table>")
        sbHTML.Append("</Div>")
        CommonFunction.General.WriteHTML(sbHTML.ToString)
    End Sub

    Private Sub PerformAction()
        Dim strMetricName As String = ""
        Dim StrGuidelines As String = ""
        Dim intMetricProjectMappingID As Integer
        Dim intMetricID As Integer = 0
        Dim dblUSL As Double = 0
        Dim dblLSL As Double = 0
        Dim dblTarget As Double = 0
        Dim blnIsApplicable As Boolean = False
        Dim blnIsDelApplicable As Boolean = False
        Dim blnIsMileApplicable As Boolean = False
        Dim blnIsPhaseApplicable As Boolean = False
        Dim intGraphType As String = "2"
        Dim sbHTML As New System.Text.StringBuilder("")
        Dim strSQL As String = ""
        Dim intCnt As Integer = 0
        Dim blnIsSelected As Boolean


        While intCnt < m_intCnt
            blnIsSelected = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelect_" + intCnt.ToString), 0)
            If blnIsSelected = True Then
                intMetricProjectMappingID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtpk_" + intCnt.ToString), 0)
                intMetricID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtMetricID_" + intCnt.ToString), 0)
                'Commented and Added By Chakshuta H ON 25th Feb 2015 Purpose::JLTAsia Issue Fixing
                ''dblUSL = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUSL_" + intCnt.ToString), 0)
                ''dblLSL = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtLSL_" + intCnt.ToString), 0)
                ''dblTarget = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtTarget_" + intCnt.ToString), 0)
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUSL_" + intCnt.ToString), 0) = "" Then
                    dblUSL = 0
                Else
                    dblUSL = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUSL_" + intCnt.ToString), 0)
                End If
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtLSL_" + intCnt.ToString), 0) = "" Then
                    dblLSL = 0
                Else
                    dblLSL = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtLSL_" + intCnt.ToString), 0)
                End If
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtTarget_" + intCnt.ToString), 0) = "" Then
                    dblTarget = 0
                Else
                    dblTarget = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtTarget_" + intCnt.ToString), 0)
                End If
                'Ended By Chakshuta H ON 25th Feb 2015
                intGraphType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboGraphType_" + intCnt.ToString), "0")
                blnIsDelApplicable = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelApplicable_" + intCnt.ToString), 0)
                blnIsPhaseApplicable = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkPhaseApplicable_" + intCnt.ToString), 0)
                blnIsMileApplicable = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkMileApplicable_" + intCnt.ToString), 0)


                strSQL = "usp_ins_tbl_MET_Metric_Project_BreakUp_Mapping_FromCorporate "
                strSQL = strSQL + intMetricProjectMappingID.ToString
                strSQL = strSQL + ","
                strSQL = strSQL + Session("intProjectID").ToString
                strSQL = strSQL + ","
                strSQL = strSQL + intMetricID.ToString
                strSQL = strSQL + ","
                strSQL = strSQL + IIf(blnIsPhaseApplicable = True, 1, 0).ToString
                strSQL = strSQL + ","
                strSQL = strSQL + IIf(blnIsMileApplicable = True, 1, 0).ToString
                strSQL = strSQL + ","
                strSQL = strSQL + IIf(blnIsDelApplicable = True, 1, 0).ToString
                strSQL = strSQL + ","
                strSQL = strSQL + IIf(intGraphType = "0" Or intGraphType = "", "NULL", intGraphType.ToString)
                strSQL = strSQL + ","
                strSQL = strSQL + "'" + CommonFunction.General.BuildQueryString(Session("strUserName")) + "'"
                strSQL = strSQL + ","
                strSQL = strSQL + dblUSL.ToString
                strSQL = strSQL + ","
                strSQL = strSQL + dblTarget.ToString
                strSQL = strSQL + ","
                strSQL = strSQL + dblLSL.ToString
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            End If
            intCnt = intCnt + 1
        End While

        sbHTML.Append("<Script language = javascript>")
        'Commnted and added by Chetan M on 18 May 2020 for IssueID = 24419
        'sbHTML.Append("refreshParent('frmCommonPage', 'MB_ProjectMeasurement_CommonPage.aspx','../METRICS/MB_ProjectMeasurement_CommonPage.aspx?SubTagID=3360');")
        sbHTML.Append("refreshParent('frmCommonPage', 'MB_ProjectMeasurement_CommonPage.aspx','../METRICS/MB_ProjectMeasurement_CommonPage.aspx?SubTagID=2502');")
        'End of Commnted and added by Chetan M on 18 May 2020 for IssueID = 24419
        sbHTML.Append(" window.close();")
        sbHTML.Append("</script>")
        CommonFunction.General.WriteHTML(sbHTML.ToString)
    End Sub
End Class