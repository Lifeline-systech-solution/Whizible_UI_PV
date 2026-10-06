Public Class Test_Case_History
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
#Region "Variables"
    Private m_strSQL As String
    Private m_strSelectedTestCaseID As String
    Private m_strParentPageTestCaseID As String
    Private m_strRevisionIDs As String = ""
    Private m_strRevisionTitles As String = ""
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Private Sub InitializeVariables()
        m_strSelectedTestCaseID = Request.QueryString("ProjectTestCaseID")
        m_strParentPageTestCaseID = Request.QueryString("ProjectTestCaseID")
        If Not m_strParentPageTestCaseID Is Nothing Then
            CommonFunction.General.WriteHTML("<INPUT Type=hidden name=hidParentPageTestCaseID value=" + m_strParentPageTestCaseID + ">")
        Else
            CommonFunction.General.WriteHTML("<INPUT Type=hidden name=hidParentPageTestCaseID value=" + Request.Form("hidParentPageTestCaseID") + ">")
            m_strParentPageTestCaseID = Request.Form("hidParentPageTestCaseID")
        End If
        'm_strRevisionIDs = Request.Form("hidRevisionIDs")


        If m_strSelectedTestCaseID Is Nothing Then
            m_strSelectedTestCaseID = Request.Form("cboRevision")
        End If
        If m_strSelectedTestCaseID = "" Then
            m_strSelectedTestCaseID = "0"
        End If





    End Sub
    Private Sub DrawPageFilters()
        '=====================================================================
        ' Procedure Name        : DrawPageFiltersPaging()
        ' Purpose               : Plotting Page Filters controls and calling Numeric Paging function.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : 5 Dec, 2006
        ' Revisions             :
        '=====================================================================

        'Filter Div
        Dim drRevision As IDataReader

        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunction.General.WriteHTML("<TD  align=Left width='1%'><A href='Javascript:showHide_divFilter()'>")
        CommonFunction.General.WriteHTML("<Img Border=0 id=pageFilterImg Src='../../Images/minus.gif' title=''></A></TD>")
        CommonFunction.General.WriteHTML("<TD> " + MyBase.GetResourceString("LBL_FILTER") + "</TD>")
        CommonFunction.General.WriteHTML("</TR></TABLE>")

        CommonFunction.General.WriteHTML("<DIV id=pageFilterDiv>")

        CommonFunction.General.WriteHTML("<TABLE ID='PageFilter' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        'Test Set Combo 
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_REVISION"))
        CommonFunction.General.WriteHTML("</TD><TD>")
        drRevision = CommonFunction.Data.GetDataReader("usp_Sel_Combo_TestCaseHistory " + Session("intProjectID").ToString + "," + m_strParentPageTestCaseID, MyBase.UseSQL)
        CommonFunction.General.WriteHTML("<SELECT onchange=Revision_onChange() id=cboRevision name=cboRevision class=clsComboBox style='width:200px ' ><FONT size=1>")
        CommonFunction.General.WriteHTML("<OPTION value =''></OPTION>")
        While drRevision.Read
            If drRevision("ProjectTestCaseID").ToString = m_strSelectedTestCaseID Then
                CommonFunction.General.WriteHTML("<OPTION selected value='" + drRevision("ProjectTestCaseID").ToString + "'>")
            Else
                CommonFunction.General.WriteHTML("<OPTION value='" + drRevision("ProjectTestCaseID").ToString + "'>")
            End If
            m_strRevisionIDs += drRevision("ProjectTestCaseID").ToString + ","
            m_strRevisionTitles += drRevision("Revision").ToString + ","
            CommonFunction.General.WriteHTML(drRevision("Revision").ToString + "</OPTION>")
        End While
        m_strRevisionIDs = m_strRevisionIDs.Substring(0, m_strRevisionIDs.Length - 1)
        m_strRevisionTitles = m_strRevisionTitles.Substring(0, m_strRevisionTitles.Length - 1)

        CommonFunction.Data.DisposeDataReader(drRevision)
        CommonFunction.General.WriteHTML("</FONT></SELECT>")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR></TABLE></DIV>")
        'CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidRevisionIDs id=hidRevisionIDs value=" + m_strRevisionIDs + ">")
    End Sub

    Protected Sub PageInit()
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection

        MyBase.InitializeResources("AppResources.Test_Case_History", "AppResources")
        InitializeVariables()
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")} '{"Save", "Close", "Help"}
        Dim arrCSFunction() As String = {"Close_OnClick()", "Help_OnClick('TCM')"}
        'upper menu
        Response.Write(WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip))

        CommonFunction.General.WriteHTML("<BR>")
        DrawPageFilters()
        CommonFunction.General.WriteHTML("<BR>")
        Call DrawPage()

        'bottom menu
        CommonFunction.General.WriteHTML("<BR>")
        Response.Write(WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip))
    End Sub
    Private Sub DrawPage()
        If m_strSelectedTestCaseID <> "0" Then
            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''m_strSQL = "SELECT * FROM v_tbl_TCM_TestCaseResponses_history WHERE TestCaseID=" + m_strSelectedTestCaseID
            m_strSQL = "usp_sel_v_tbl_TCM_TestCaseResponses_history_TestCaseID " + m_strSelectedTestCaseID
        Else
            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''m_strSQL = "SELECT * FROM v_tbl_TCM_TestCaseResponses_history WHERE TestCaseID in (" + m_strRevisionIDs + ")  "
            m_strSQL = "usp_sel_v_tbl_TCM_TestCaseResponses_history_TestCID '" + m_strRevisionIDs + "'"
            'Response.Write("</form></body></html>")
            'Response.End()
        End If

        Dim dr As IDataReader
        Dim strHoldTestCaseID As String = ""
        Dim m_strArrRevisionTitles As String() = m_strRevisionTitles.Split(CChar(","))
        Dim m_strArrRevisionIDs As String() = m_strRevisionIDs.Split(CChar(","))
        Dim arrCounter As Integer = 0

        Dim strCss As String = "clsTREven"
        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        '' dr = CommonFunction.Data.GetDataReader("SELECT TOP 1 TestCaseCode FROM tbl_TCM_ProjectTestCaseDetails_published WHERE ProjectTestCaseID in (" + m_strRevisionIDs + ")", MyBase.UseSQL)
        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_TCM_ProjectTestCaseDetails_published_TestCaseCode '" + m_strRevisionIDs + "'", MyBase.UseSQL)
        If Not dr.Read Then
            Response.Write("</form></body></html>")
            Response.End()
        End If
        'Test Case Title
        ''CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        ''CommonFunction.General.WriteHTML("<TR class=clsTRSectionHeader>")
        ''CommonFunction.General.WriteHTML("<TD> " + MyBase.GetResourceString("LBL_TEST_CASE_CODE") + " " + dr("TestCaseCode").ToString + "</TD></TR></TABLE>")

        'Page Caption and Test Case Title
        Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("LBL_TEST_CASE_HISTORY"), MyBase.GetResourceString("LBL_TEST_CASE_CODE") + " " + dr("TestCaseCode").ToString))
        Response.Write("<BR>")



        CommonFunction.Data.DisposeDataReader(dr)

        'dr = CommonFunction.Data.GetDataReader(m_strSQL + " ORDER BY TestCaseID DESC,TestCaseResponseID DESC", MyBase.UseSQL)
        dr = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        CommonFunction.General.WriteHTML("<DIV Id=divPage Style='HEIGHT:500px;OVERFLOW:auto; WIDTH:100%'>")
        CommonFunction.General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")
        'Setting arCounter's position
        While arrCounter < m_strArrRevisionIDs.Length And m_strSelectedTestCaseID <> "0"
            If m_strArrRevisionIDs(arrCounter) = m_strSelectedTestCaseID Then
                Exit While
            End If
            arrCounter += 1
        End While
        While dr.Read
            If strHoldTestCaseID = "" Or strHoldTestCaseID <> dr("TestCaseID").ToString Then

                If m_strSelectedTestCaseID <> "0" Then
                    CommonFunction.General.WriteHTML("<TR class=clsTRSectionHeader>")
                    CommonFunction.General.WriteHTML("<TD> " + m_strArrRevisionTitles(arrCounter) + "</TD></TR>")
                    strHoldTestCaseID = m_strArrRevisionIDs(arrCounter)
                    'arrCounter += 1
                Else
                    arrCounter = 0
                    While arrCounter < m_strArrRevisionIDs.Length
                        If m_strArrRevisionIDs(arrCounter) = dr("TestCaseID").ToString Then
                            Exit While
                        End If
                        arrCounter += 1
                    End While
                    If arrCounter < m_strArrRevisionIDs.Length Then
                        CommonFunction.General.WriteHTML("<TR class=clsTRSectionHeader>")
                        CommonFunction.General.WriteHTML("<TD> " + m_strArrRevisionTitles(arrCounter) + "</TD></TR>")
                        strHoldTestCaseID = m_strArrRevisionIDs(arrCounter)
                    End If

                End If

            End If

            CommonFunction.General.WriteHTML("<TR class=" + strCss + ">")

            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML("<TABLE class='clsTable' width=99.9% cellspacing=0 cellpadding=0>")

            CommonFunction.General.WriteHTML("<TR class=" + strCss + ">")

            'Test Session
            CommonFunction.General.WriteHTML("<TD width=90px align=right><B> " + MyBase.GetResourceString("LBL_TEST_SESSION") + " </B></TD>")
            CommonFunction.General.WriteHTML("<TD>" + dr("Title").ToString + "</TD>")
            CommonFunction.General.WriteHTML("</TR><TR class=" + strCss + ">")

            'Result
            CommonFunction.General.WriteHTML("<TD width=90px align=right><B>" + MyBase.GetResourceString("LBL_RESULT") + " </B></TD>")
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML("<table class=clsTable cellspacing=0 cellpadding=0>")
            CommonFunction.General.WriteHTML("<TR class=" + strCss + "><TD>")
            CommonFunction.General.WriteHTML(dr("TestResult").ToString + "&nbsp;&nbsp;</TD>")
            CommonFunction.General.WriteHTML("<TD bgcolor='" + dr("ColorCode").ToString + "' width=10px ><TD>")
            'Issue Details
            If Not IsDBNull(dr("IssueID")) Then
                CommonFunction.General.WriteHTML("<TD><A href='JavaScript:showIssueDetails_onClick(" + dr("IssueID").ToString + ",""" + CommonFunctions.Security.Token.GetToken(CType(dr("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0") + """" + _
                  ")' Title='Click here to open Issue Details' >" + MyBase.GetResourceString("LNK_ISSUE_DETAILS") + "</A></TD>")

            End If
            CommonFunction.General.WriteHTML("</TR></Table>")


            CommonFunction.General.WriteHTML("</TR><TR class=" + strCss + ">")

            'Notes
            CommonFunction.General.WriteHTML("<TD width=90px valign=top align=right><B>" + MyBase.GetResourceString("LBL_NOTES") + " </B></TD>")
            CommonFunction.General.WriteHTML("<TD>" + dr("Notes").ToString + "</TD>")
            CommonFunction.General.WriteHTML("</TR><TR class=" + strCss + ">")

            'ResultBy
            CommonFunction.General.WriteHTML("<TD width=90px align=right><B>" + MyBase.GetResourceString("LBL_CONDUCTEDBY") + " </B></TD>")
            CommonFunction.General.WriteHTML("<TD>" + dr("EmployeeName").ToString + "</TD>")
            CommonFunction.General.WriteHTML("</TR><TR class=" + strCss + ">")

            'ResultDate
            CommonFunction.General.WriteHTML("<TD width=90px align=right><B>" + MyBase.GetResourceString("LBL_CONDUCTEDDATE") + " </B></TD>")
            CommonFunction.General.WriteHTML("<TD>" + dr("ResponseDate").ToString + "</TD>")
            CommonFunction.General.WriteHTML("</TR></Table>")

            CommonFunction.General.WriteHTML("</TD></TR>")


            If strCss = "clsTREven" Then
                strCss = "clsTROdd"
            Else
                strCss = "clsTREven"
            End If


        End While

        CommonFunction.General.WriteHTML("</TABLE>")

        CommonFunction.General.WriteHTML("</DIV>")

        CommonFunction.Data.DisposeDataReader(dr)



    End Sub



End Class
