Public Class TestCaseResponses
    '' Commented and Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
    ' Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End Of Commented and Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        Call DrawTestCaseGrid()

    End Sub

    Sub DrawTestCaseGrid()
        Dim strSQL As String
        Dim drTestCase As IDataReader


        CommonFunctions.General.WriteHTML("<table class='clsGridTable' width='99.9%' cellSpacing='0' cellPadding='0' >")
        CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'>")
        CommonFunctions.General.WriteHTML("<td align='left'>" & "Test Case Response" & "</td>")
        CommonFunctions.General.WriteHTML("<td  colspan='5' align='right'>|")
        CommonFunctions.General.WriteHTML("<Font color='white'><a class='Menu' href=javascript:Help_OnClick('TestResponse')>" & "?" & "</a></font>|</td>")
        CommonFunctions.General.WriteHTML("</tr >")
        CommonFunctions.General.WriteHTML("</table>")

        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<table class='clsGridTable' width='99.9%' cellSpacing='0' cellPadding='0' >")
        CommonFunctions.General.WriteHTML("<TR><TD class=clsTDodd align=right> ")
        Call WritePaging("Select count(1) from tbl_TCM_TestCaseDetails ")
        CommonFunctions.General.WriteHTML("</TD></TR> </Table>")


        CommonFunctions.General.WriteHTML("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto; Height:435px'>")
        CommonFunctions.General.WriteHTML(" <Table class=clsGridTable cellSpacing=1 cellPadding=0 width='99.9%'> ")
        CommonFunctions.General.WriteHTML(" <THEAD class=clsTRColumnHeader> ")
        CommonFunction.General.WriteHTML(" <TH class='divListTag' align=left width=50%>Test Case</TH>")
        CommonFunction.General.WriteHTML("<TH class='divListTag' align=left width=50%> Results </TH>")
        CommonFunction.General.WriteHTML("</THEAD>")

        strSQL = " Select TC.TestCaseID,TC.TestCaseCode,cast(TC.TestProcedure as varchar) as TestProcedure,"
        strSQL += " cast(TC.VerificationProcedure as varchar) as VerificationProcedure , "
        strSQL += " cast(TC.Scenario as varchar) as Scenario, "
        strSQL += " Cast(TC.TestData as varchar) as testData, "
        strSQL += " TS.TestSetName From "
        strSQL += " tbl_TCM_TestCaseDetails TC left join tbl_TCM_TestSet TS On TC.TestSetID=TS.TestSetID"
        strSQL += " Group By TS.TestSetName,TC.TestCaseID,TC.TestCaseCode,cast(TC.TestProcedure as varchar),"
        strSQL += " cast(TC.VerificationProcedure as varchar),cast(TC.Scenario as varchar) , Cast(TC.Testdata as varchar)"



        drTestCase = CommonFunction.Data.GetDataReader(strSQL, True)


        While drTestCase.Read
            CommonFunction.General.WriteHTML("<TR class= clsTRSectionHeader> ")
            CommonFunction.General.WriteHTML("<TD class=clstdeven>")
            CommonFunction.General.WriteHTML("<P><b>" & "Test Case Code : " & "</b>" & CType(CommonFunctions.General.CheckIsNothing(drTestCase("TestCaseCode")), String) & "</p>")
            CommonFunction.General.WriteHTML("<P><b>" & "Test Procedure : " & "</b>" & CType(CommonFunctions.General.CheckIsNothing(drTestCase("Testprocedure")), String) & "</p>")
            CommonFunction.General.WriteHTML("</TD>")

            CommonFunction.General.WriteHTML("<TD class=clstdeven></TD></TR>")




        End While


        CommonFunction.Data.DisposeDataReader(drTestCase)




        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</Div>")





    End Sub
    Private Sub WritePaging(ByVal PagingSQL As String)
        '=====================================================================
        ' Procedure Name        : WritePaging
        ' Description           : To write the paging for the Test Case grid
        ' Purpose               : 
        ' Parameters Passed     : SQL for paging
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : VidyaJ
        ' Created               : Feb 17,2004
        ' Revisions             : 
        '=====================================================================
        Dim ds As DataSet
        Dim intRecordCount As Integer
        Dim strSectionTag As String = "divGrid"
        Dim strFunctionName As String = "ShowHide_divGrid"
        Dim intTotalNoOfRows As Integer
        Dim m_intPageNumber As Integer

        m_intPageNumber = 1


        intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, True), ""), ""), Integer)

        'If Math.Ceiling(intTotalNoOfRows / 20) < m_intPageNumber Then
        '    m_intPageNumber = 1
        'End If


        If m_intPageNumber = -1 Or intTotalNoOfRows = 0 Then

            CommonFunctions.General.WriteHTML("Page ")
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 30, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=False, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            CommonFunctions.General.WriteHTML("Page ")
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 30, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=False, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
        CommonFunctions.General.WriteHTML(" of " + (Math.Ceiling(intTotalNoOfRows / 20)).ToString)

        CommonFunctions.General.WriteHTML("<A  title='Previous Page'  style='TEXT-DECORATION: none' ")
        CommonFunctions.General.WriteHTML(" href = 'Javascript:numeric_nav_prev_click('frmTestCaseResponse','../TCM/TestCaseResponses.ASPX' )>")
        CommonFunctions.General.WriteHTML(" <IMG src='../../Images/NumNavPreviousEnable.gif' align=top border=0></A> ")


        CommonFunctions.General.WriteHTML("<A  title='Next Page'  style='TEXT-DECORATION: none' ")
        CommonFunctions.General.WriteHTML(" href = 'Javascript:numeric_nav_Next_click('frmTestCaseResponse','../TCM/TestCaseResponses.ASPX' )>")
        CommonFunctions.General.WriteHTML(" <IMG src='../../Images/NumNavNextEnable.gif' align=top border=0></A> ")


        CommonFunctions.General.WriteHTML("|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All</B> </A>")

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15




    End Sub

End Class
