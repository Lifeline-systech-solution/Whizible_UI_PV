Public Partial Class MyArena
    Inherits WebPages.Template.WhizTemplate
    Protected sbHtml As New System.Text.StringBuilder
    Protected strSQL As String = ""
    Protected m_strFrom As String = ""
    Protected blnExpenseWorkflow As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub

    Public Sub PageInit()
        'm_strFrom = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("From"), "")
        'If m_strFrom = "Expenses" Then
        'MyExpenses()
        'Else
        DrawMyArena()
        'End If
    End Sub
    Public Sub DrawMyArena()
        sbHtml.Append("<TABLE valign='top' id='tblSearch'  cellspacing='0' cellpadding='0' Width='99.9%'  class='clsTable'>")
        sbHtml.Append("<TR class='clsTRMenu'><TD align='Left'>Select Dashboard ")

        If Trim(Session("intPostID").ToString) <> "" Then
            strSQL = "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString & "," & Session("intPostID").ToString
        Else
            strSQL = "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString
        End If
        Dim strDashBoardID As String = ""

        strDashBoardID = "../Home/MyArena.aspx?ShortName=TabUI&FromWhere=TABUI|0"

        sbHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", strSQL, 250, strDashBoardID, "OnChange='JavaScript:cboDashboard_OnChange()'", True, True))

        sbHtml.Append("</TD>")
        'sbHtml.Append("<TD align='Right'><A href='JavaScript:Configure_Section()' style='TEXT-DECORATION:none'>Configure Sections</A></TD>") '<img src= '../../Images/DetailView/78.gif' border='0' alt='Configure Sections'>
        sbHtml.Append("</TR></Table>")
        sbHtml.Append("<div ID='PageDiv' height='100%' style='overflow:auto;width:99.9%;'>")
        sbHtml.Append("<table CELLPADDING='0' CELLSPACING='0' BORDER='0' Width='100%' height='100%' style='padding:0px 0px 0px 0px;' >")
        sbHtml.Append("<TR>")
        sbHtml.Append("<TD vAlign=top style='padding:0px 0px 0px 0px; align='left'>")
        sbHtml.Append("<UL style='list-style-type: none;' class='shadetabs' align='left'>")
        sbHtml.Append("<LI class='clsTREven'><a id='li_Arena' name='li_Arena' href='javascript:TabOnClick(0)' onmouseover='javascript:ShowSubTag(0)' ><img src='../../Images/Home/myprofile.gif' border=0 title='My Profile'></a></LI>") '<img src='../../Images/Home/Button1.gif' border=0 title='My Profile'>
        'onmouseover='javascript:TabOnClick(0)'
        sbHtml.Append("<LI class='clsTREven'><a id='li_Arena' name='li_Arena' href='javascript:TabOnClick(1)' onmouseover='javascript:ShowSubTag(1)' ><img src='../../Images/Home/myhome.gif'  border=0 title='My Home'></a></LI>") '<img src='../../Images/Home/Button1.gif' border=0 title='My Home'>
        'onmouseover='javascript:TabOnClick(1)'
        sbHtml.Append("<LI class='clsTREven'><a id='li_Arena' name='li_Arena' href='javascript:TabOnClick(2)' onmouseover='javascript:ShowSubTag(2)' ><img src='../../Images/Home/myalerts.gif'  border=0 title='My Alerts'></a></LI>") '<img src='../../Images/Home/Button1.gif' border=0 title='My Alerts'>
        'onmouseover='javascript:TabOnClick(2)'
        sbHtml.Append("<LI class='clsTREven'><a id='li_Arena' name='li_Arena' href='javascript:TabOnClick(3)' onmouseover='javascript:ShowSubTag(3)' ><img src='../../Images/Home/myleaves.gif'  border=0 title='My Leaves'></a></LI>") '<img src='../../Images/Home/Button1.gif' border=0 title='My Leaves'>
        'onmouseover='javascript:TabOnClick(3)'
        blnExpenseWorkflow = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select isnull(ExpenseWorkflow,0) from tbl_PM_Companyinformation", True), False), False))
        If blnExpenseWorkflow = True Then
            sbHtml.Append("<LI class='clsTREven'><a id='li_Arena' name='li_Arena' href='javascript:TabOnClick(4)' onmouseover='javascript:ShowSubTag(4)' ><img src='../../Images/Home/myExpenses.gif' border=0 title='My Expenses'></a></LI>") '<img src='../../Images/Home/Button1.gif' border=0 title='My Leaves'>
            'onmouseover='javascript:TabOnClick(4)'
        End If
        sbHtml.Append("</UL>")
        sbHtml.Append("</TD>")
        'sbHtml.Append("<TD ID='tdDot1' name='tdDot1' vAlign=top width=1px   background='../../Images/Home/dot2.gif' onclick='javascript:ShowTree()'><a name='aShowTree' id='aShowTree' style=""text-decoration:none;"" href='javascript:HideTree()' ><img ID='ImgShowHide' src='../../Images/ScrollLeft.gif' border=0 /></a></TD>")
        sbHtml.Append("<TD vAlign=top width='99.9%' height='99.9%' id='td_iframe' style='padding:0px 0px 0px 0px;BORDER: black 1px outset;'>")
        sbHtml.Append("<iframe name='frmMain' height='99.9%'  id='frmMain' onLoad='calcHeight()'  src='' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>") 'onmouseover='HideFrame()'
        sbHtml.Append("</TD>")
        sbHtml.Append("</TR></TABLE>")
        sbHtml.Append("</div>")

        CommonFunction.General.WriteHTML(sbHtml.ToString)
        sbHtml = Nothing
    End Sub
End Class