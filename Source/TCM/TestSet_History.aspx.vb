Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.Data
Imports CommonFunctions.General

Public Class TestSet_History
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name 	        :	TestCase_History.aspx
    ' Purpose				:	To display test case response history
    ' Description			:	This page displays the history of responses for each testcase  
    ' Assumptions			:	
    ' Dependencies			:	
    ' Created By			:	PrashantD
    ' Created Date			:	27 Nov 2006
    ' Revisions				:	
    '=====================================================================

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
        ''Added by Yogesh J on on 02 Mar 2016 to validate Token
        If Request.QueryString("FromWhere") = "PM" Then
            If Request.QueryString("TestSetID") IsNot Nothing And Request.QueryString("PKToken") IsNot Nothing Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("TestSetID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then

                    ' Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_YearValue, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If
        '  End of addition by Yogesh J on 02-Mar-2016 to validate Token 
    End Sub

#End Region
#Region "Member Variables"
    'Private WithEvents m_objmenu As New StaticMenu      'This variable is used for plotting static menu.
    'Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    'Private m_objGlobal As IGlobal                      'This variable is of global object inteface
    'Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.

    'Private strbuildHTML As New System.Text.StringBuilder
    'Protected drtestset As IDataReader
    'Protected drcount As IDataReader
    'Protected drtestcase As IDataReader

    'Private strMenu As String                           'stores the static menu string.
    Protected m_intProjectTestSetID As Integer
    Private m_intProjectCorpoTestSetID As Integer
    Private m_strProjectID As String = ""
    Private m_strTestSection As String = ""
    Private strRightPageCaption As String = ""
    Private m_strRevisionIDs As String = ""
    Private m_strRevisionTitles As String = ""
    Private m_strFromWhere As String

    Dim arrCounter As Integer = 0
#End Region
    Private Sub InitializeVariables()
        m_strFromWhere = Request.QueryString("FromWhere")
        If m_strFromWhere Is Nothing Then
            m_strFromWhere = Request.Form("FromWhere")
        End If

        CommonFunction.General.WriteHTML("<INPUT Type=hidden name=FromWhere value=" + m_strFromWhere + ">")

        ' m_strRevisionIDs = Request.Form("hidRevisionIDs")
        If Not Session("intProjectID") Is Nothing Then
            m_strProjectID = Session("intProjectID").ToString
        Else
            m_strProjectID = "0"
        End If

        If Not Request.Form("cboProject") Is Nothing Then
            m_strProjectID = Request.Form("cboProject")
        End If
        If m_strProjectID Is Nothing Or m_strProjectID = "" Then
            m_strProjectID = "0"
        End If

        If Request.Form("cboCorpoTestSet") <> "" Then
            m_intProjectCorpoTestSetID = CType(Request.Form("cboCorpoTestSet"), Integer)
        Else
            m_intProjectCorpoTestSetID = 0
        End If
        If Request.QueryString("From") = "CORPOTESTSET" Then
            m_intProjectTestSetID = CType(CommonFunction.Data.GetDataScalar("usp_Sel_Combo_TestSetHistory_Revision " + m_strProjectID + "," + m_intProjectCorpoTestSetID.ToString + ",1", MyBase.UseSQL), Integer)
        ElseIf Request.QueryString("TestSetID") <> "" Then
            m_intProjectTestSetID = CType(Request.QueryString("TestSetID"), Integer)

        ElseIf Request.Form("cboTestSet") <> "" Then
            m_intProjectTestSetID = CType(Request.Form("cboTestSet"), Integer)
        Else
            m_intProjectTestSetID = 0
        End If
        If m_intProjectCorpoTestSetID = 0 And Request.Form("hidCorpoTestSetID") <> "" Then
            m_intProjectCorpoTestSetID = CType(Request.Form("hidCorpoTestSetID"), Integer)
        End If
        If m_intProjectCorpoTestSetID = 0 And m_strFromWhere <> "DB" Then

            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''m_intProjectCorpoTestSetID = CType(CommonFunction.Data.GetDataScalar("SELECT CorporateTestSetID FROM tbl_TCM_ProjectTestSet_published WHERE  ProjectTestSetID= " + m_intProjectTestSetID.ToString, MyBase.UseSQL), Integer)
            m_intProjectCorpoTestSetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_TCM_ProjectTestSet_published_CorporateTestSetID " + m_intProjectTestSetID.ToString, MyBase.UseSQL), Integer)
        End If

        CommonFunction.General.WriteHTML("<input type=hidden name=hidCorpoTestSetID value=" + m_intProjectCorpoTestSetID.ToString + ">")

        If Request.Form("cboTestSection") <> "" Then
            m_strTestSection = Request.Form("cboTestSection")
        Else
            m_strTestSection = ""
        End If
        If Request.QueryString("TestSetID") <> "" Then
            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''strRightPageCaption = MyBase.GetResourceString("LBL_TEST_SET") + ": " + CType(CommonFunction.Data.GetDataScalar("SELECT TestSetName FROM tbl_TCM_ProjectTestSet_published WHERE ProjectTestSetID = " + m_intProjectTestSetID.ToString, MyBase.UseSQL), String)
            strRightPageCaption = MyBase.GetResourceString("LBL_TEST_SET") + ": " + CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_TCM_ProjectTestSet_published_TestSetName " + m_intProjectTestSetID.ToString, MyBase.UseSQL), String)
        End If

    End Sub
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Private Sub DrawMenu()
        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList
        If m_strFromWhere <> "DB" Then
            arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE"))
            arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE"))
            arrCSFunction.Add("Close_OnClick()")
        End If

        arrMenu.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP"))
        arrCSFunction.Add("Help_OnClick('COVERAGE')")



        CommonFunction.General.WriteHTML(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))
    End Sub
    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Response.Write(PageCaption.GetPageCaptions(, MyBase.GetResourceString("LBL_COVERAGE_REPORT"), strRightPageCaption, , True))

    End Sub
    Private Sub DrawPageFilters()
        Dim drRevision As IDataReader

        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunction.General.WriteHTML("<TD  align=Left width='1%'><A href='Javascript:showHide_divFilter()'>")
        CommonFunction.General.WriteHTML("<Img Border=0 id=pageFilterImg Src='../../Images/minus.gif' title=''></A></TD>")
        CommonFunction.General.WriteHTML("<TD> " + MyBase.GetResourceString("LBL_FILTER") + "</TD>")
        CommonFunction.General.WriteHTML("<TD align=Right><font style='FONT-WEIGHT: normal' >")

        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")

        CommonFunction.General.WriteHTML("<DIV id=pageFilterDiv>")

        CommonFunction.General.WriteHTML("<TABLE ID='PageFilter' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        If m_strFromWhere = "DB" Then
            CommonFunction.General.WriteHTML("<TD align=right>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_PROJECT"))
            CommonFunction.General.WriteHTML("</TD><TD>")
            CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " + CType(Session("intUserID"), String) & ",0,0,0,0,'" & CType(Session("LoginType"), String) & "',0," & CType(Session("intLoginID"), Long) & ",1,1", 200, m_strProjectID, "onchange=cboProject_onChange()", True, , , True)
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("<TD align=right>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEST_SET"))
            CommonFunction.General.WriteHTML("</TD><TD>")
            CommonFunction.HTMLControls.DrawComboBox("cboCorpoTestSet", "usp_Sel_Combo_TestSetHistory_TestSet " + m_strProjectID, 180, m_intProjectCorpoTestSetID.ToString, "onchange=cboCorpoTestSet_onChange()", True, , , True)
            CommonFunction.General.WriteHTML("</TD>")
            
        End If
        ' CommonFunction.HTMLControls.DrawComboBox("cboTestSet", "usp_Sel_Combo_TestSetHistory_Revision " + m_strProjectID + "," + m_intProjectCorpoTestSetID.ToString, 200, m_intProjectTestSetID.ToString, "onchange=cboTestSet_onChange()", True, , , True)
        drRevision = CommonFunction.Data.GetDataReader("usp_Sel_Combo_TestSetHistory_Revision " + m_strProjectID + "," + m_intProjectCorpoTestSetID.ToString, MyBase.UseSQL)
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_REVISION"))
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD>")
        CommonFunction.General.WriteHTML("<SELECT onchange=cboTestSet_onChange() id=cboTestSet name=cboTestSet class=clsComboBox style='width:110px ' ><FONT size=1>")
        CommonFunction.General.WriteHTML("<OPTION value =''></OPTION>")
        While drRevision.Read
            If drRevision("ProjectTestSetID").ToString = m_intProjectTestSetID.ToString Then
                CommonFunction.General.WriteHTML("<OPTION selected value='" + drRevision("ProjectTestSetID").ToString + "'>")
            Else
                CommonFunction.General.WriteHTML("<OPTION value='" + drRevision("ProjectTestSetID").ToString + "'>")
            End If

            If m_intProjectTestSetID <> 0 Then
                If m_intProjectTestSetID.ToString = drRevision("ProjectTestSetID").ToString Then
                    m_strRevisionTitles = drRevision("Revision").ToString + ","
                    m_strRevisionIDs = m_intProjectTestSetID.ToString + ","
                End If
            Else
                m_strRevisionIDs += drRevision("ProjectTestSetID").ToString + ","
                m_strRevisionTitles += drRevision("Revision").ToString + ","
            End If
            CommonFunction.General.WriteHTML(drRevision("Revision").ToString + "</OPTION>")
        End While
        If m_strRevisionIDs <> "" Then
            m_strRevisionIDs = m_strRevisionIDs.Substring(0, m_strRevisionIDs.Length - 1)
            m_strRevisionTitles = m_strRevisionTitles.Substring(0, m_strRevisionTitles.Length - 1)
        End If

        CommonFunction.Data.DisposeDataReader(drRevision)
        CommonFunction.General.WriteHTML("</FONT></SELECT>")
        CommonFunction.General.WriteHTML("</TD>")

        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEST_SECTION"))
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboTestSection", "usp_Sel_combo_tbl_TCM_TestSection_TestSetHistory '" + m_strRevisionIDs + "'", 170, m_strTestSection, "onchange=cboTestSection_onChange()", True)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR></TABLE></DIV>")



    End Sub
    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        'This will initialize all the global objects.
        'GetGlobalObject()

        InitializeVariables()
        Call DrawMenu()
        CommonFunction.General.WriteHTML("<BR>")
        Call DrawPageCaption()

        Call DrawPageFilters()
        CommonFunction.General.WriteHTML("<BR>")

        'Dim strHTML As String = GenerateTestCaseHistory()
        'Response.Write(strHTML)
        Call DrawHistory()
        CommonFunction.General.WriteHTML("<BR>")

        CommonFunction.General.WriteHTML("<BR>")
        Call DrawLegends()

        Call DrawMenu()
    End Sub
    Private Sub DrawHistory()
        Dim strCss As String = "clsTREven"
        Dim dr As IDataReader


        Dim arrRevisionTitles As String() = m_strRevisionTitles.Split(CChar(","))



        CommonFunction.General.WriteHTML("<DIV Id=divListTag Style='overflow:auto;height:400px;width:100%;z-index=2;'>")
        CommonFunction.General.WriteHTML("<STYLE type=text/css>" + _
       "{TABLE " + _
        "{TABLE-LAYOUT: fixed;}" + _
        "THEAD TH.divListTag {POSITION: relative;}" + _
        "THEAD TH.divListTag.locked {POSITION: relative;}" + _
        "THEAD TH.divListTag {Z-INDEX: 10; ; TOP:expression(document.getElementById('divListTag').scrollTop -1)}" + _
        "THEAD TH.divListTag.locked {Z-INDEX: 30}" + _
        "TH.divListTag.locked {Z-INDEX: 10; ; LEFT:expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
        "}" + _
        " </STYLE>")
        CommonFunction.General.WriteHTML("<STYLE type=text/css>" + _
       "{TABLE " + _
       "{TABLE-LAYOUT: fixed;}" + _
       "THEAD TH.Sort_divListTag {POSITION: relative;}" + _
       "THEAD TH.Sort_divListTag.locked {POSITION: relative;}" + _
       "THEAD TH.Sort_divListTag {Z-INDEX: 10; ; TOP:expression(document.getElementById('divListTag').scrollTop -1)}" + _
       "THEAD TH.Sort_divListTag.locked {Z-INDEX: 30}" + _
       "TH.Sort_divListTag.locked {Z-INDEX: 10; ; LEFT:expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
       "THEAD TH.Sort_divListTag{border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: normal; font-size: 11px; padding-bottom: 1pt; border-left: thin; color: white; padding-top: 1pt; border-bottom: thin; font-family: Verdana, Arial; height: 22px; background: #3D5FA3; background-image: url(../../Images/bsImages/columnhdr_sel_bg.gif);}}" + _
       " </STYLE>")

        CommonFunction.General.WriteHTML("<STYLE type=text/css>" + _
        "{TABLE " + _
        "{TABLE-LAYOUT: fixed;}" + _
        "THEAD TH.Separator_divListTag {POSITION: relative;}" + _
        "THEAD TH.Separator_divListTag.locked {POSITION: relative;}" + _
        "THEAD TH.Separator_divListTag {Z-INDEX: 10; ; TOP:expression(document.getElementById('divListTag').scrollTop -1)}" + _
        "THEAD TH.Separator_divListTag.locked {Z-INDEX: 30}" + _
        "TH.Separator_divListTag.locked {Z-INDEX: 10; ; LEFT:expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
        "THEAD TH.Separator_divListTag {border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: bolder; font-size: 1pt; background-image: none; padding-bottom: 1pt; border-left: thin; width: 1px; color: black; padding-top: 1pt; border-bottom: thin; height: 22px; background-color: #D3E4FB;}" + _
        "}" + _
        " </STYLE>")

        CommonFunction.General.WriteHTML("<STYLE type=text/css>{" + _
       "TABLE {TABLE-LAYOUT: fixed;}" + _
       "THEAD TH.divListTag_Column {POSITION: relative;}" + _
       "THEAD TH.divListTag_Column.locked {POSITION: relative;}" + _
       "THEAD TH.divListTag_Column.locked {Z-INDEX: 30}" + _
       "THEAD TH.divListTag_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('divListTag').scrollTop -1)}" + _
       "TH.divListTag_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
        "}</STYLE>")

        CommonFunction.General.WriteHTML("<STYLE type=text/css>{" + _
       "TABLE {TABLE-LAYOUT: fixed;}" + _
       "THEAD TH.Separator_divListTag_Column {POSITION: relative;}" + _
       "THEAD TH.Separator_divListTag_Column.locked {POSITION: relative;}" + _
       "THEAD TH.Separator_divListTag_Column.locked {Z-INDEX: 30}" + _
       "THEAD TH.Separator_divListTag_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('divListTag').scrollTop -1)}" + _
       "TH.Separator_divListTag_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
       "THEAD TH.Separator_divListTag {border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: bolder; font-size: 1pt; background-image: none; padding-bottom: 1pt; border-left: thin; width: 1px; color: black; padding-top: 1pt; border-bottom: thin; height: 22px; background-color: #D3E4FB;}" + _
        "}</STYLE>")

        CommonFunction.General.WriteHTML("<STYLE type=text/css>{" + _
        "TABLE {TABLE-LAYOUT: fixed;}" + _
        "THEAD TH.Sort_divListTag_Column {POSITION: relative;}" + _
        "THEAD TH.Sort_divListTag_Column.locked {POSITION: relative;}" + _
        "THEAD TH.Sort_divListTag_Column.locked {Z-INDEX: 30}" + _
        "THEAD TH.Sort_divListTag_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('divListTag').scrollTop -1)}" + _
        "TH.Sort_divListTag_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}" + _
        "THEAD TH.Sort_divListTag_Column {border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: normal; font-size: 11px; padding-bottom: 1pt; border-left: thin; color: white; padding-top: 1pt; border-bottom: thin; font-family: Verdana, Arial; height: 22px; background: #3D5FA3; background-image: url(../../Images/bsImages/columnhdr_sel_bg.gif);}" + _
        " }</STYLE>")

        CommonFunction.General.WriteHTML("<STYLE type=text/css>" + _
        "Td.Locked, th.Locked {" + _
        "left: expression(document.getElementById('divListTag').scrollLeft);" + _
        "position: relative;" + _
        "z-index: 5;" + _
        "}" + _
        "</STYLE>")



        Dim prev_TestSet As String = "<NOTHING>"
        Dim prev_TestCaseCode As String = "<NOTHING>"
        'Dim prev_TestSession As String

        ' Modified By NitinVS on 28 Mar 2007 for WhizibleSEM SP 8 Regression Issue 12438 
        ' Added BuildQuery String for 'm_strTestSection'
        dr = CommonFunction.Data.GetDataReader("usp_Sel_ProjectTestSetHistory " + m_strProjectID + ",'" + m_strRevisionIDs + "','" + CommonFunction.General.BuildQueryString(m_strTestSection) + "'", MyBase.UseSQL)
        ' End Modification  By NitinVS on 28 Mar 2007 for WhizibleSEM SP 8 Regression Issue 12438 

        CommonFunction.General.WriteHTML("<TABLE  class='clsGridTable' width=99.9% cellspacing=1 cellpadding=0>")
        CommonFunction.General.WriteHTML("<THead class='clsTRColumnHeader'>")
        CommonFunction.General.WriteHTML("<TH width=100px class='divListTag' align='right' nowrap  >")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEST_CASE_CODE"))
        CommonFunction.General.WriteHTML("</TH>")
        'CommonFunction.General.WriteHTML("<TH class='divListTag' align='Left' >" + MyBase.GetResourceString("LBL_TEST_SESSION_RESULTS") + "</TH>")
        arrCounter = 0
        While arrCounter < arrRevisionTitles.Length
            If arrRevisionTitles(arrCounter) <> "" Then
                CommonFunction.General.WriteHTML("<TH class='divListTag' align='Left' nowrap >" + arrRevisionTitles(arrCounter) + "</TH>")
            End If
            arrCounter += 1
        End While
        CommonFunction.General.WriteHTML("</THEAD>")
        While dr.Read
            If prev_TestCaseCode = "<NOTHING>" Then
                CommonFunction.General.WriteHTML("")
                CommonFunction.General.WriteHTML("<TR class=" + strCss + "><TD align=right >" + dr("TestCaseCode").ToString + "</TD>")
                CommonFunction.General.WriteHTML("<TD><TABLE cellpadding=0 cellspacing=1 style='table-layout:fixed'><TR>")
                If Not IsDBNull(dr("Title")) Then
                    If Not IsDBNull(dr("ColorCode")) Then
                        If dr("ColorCode").ToString = "" Then
                            CommonFunction.General.WriteHTML("<TD></TD>")
                        Else
                            CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                            + "Conducted By: " + dr("EmployeeName").ToString + vbNewLine _
                            + "Date: " + dr("ResponseDate").ToString + "' bgcolor=" + dr("ColorCode").ToString + "></TD>")
                        End If
                    Else
                        CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                        + "Conducted By: " + vbNewLine _
                        + "Date: ' bgcolor=white >" _
                        + "<IMG width=20px height=20px src=../../Images/NoResponse.gif></TD>")
                    End If
                Else
                    CommonFunction.General.WriteHTML("<TD></TD>")
                End If
            Else
                If prev_TestSet <> dr("ProjectTestSetID").ToString And prev_TestCaseCode = dr("TestCaseCode").ToString Then
                    CommonFunction.General.WriteHTML("")
                    CommonFunction.General.WriteHTML("</TR></TABLE>")
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD><TABLE cellpadding=0 cellspacing=1 style='table-layout:fixed'><TR>")
                    If Not IsDBNull(dr("Title")) Then
                        If Not IsDBNull(dr("ColorCode")) Then
                            If dr("ColorCode").ToString = "" Then
                                CommonFunction.General.WriteHTML("<TD></TD>")
                            Else
                                CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                                + "Conducted By: " + dr("EmployeeName").ToString + vbNewLine _
                                + "Date: " + dr("ResponseDate").ToString + "' bgcolor=" + dr("ColorCode").ToString + "></TD>")
                            End If
                        Else
                            CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                            + "Conducted By: " + vbNewLine _
                            + "Date: ' bgcolor=white >" _
                            + "<IMG width=20px height=20px src=../../Images/NoResponse.gif></TD>")
                        End If
                    Else
                        CommonFunction.General.WriteHTML("<TD></TD>")
                    End If

                ElseIf prev_TestSet = dr("ProjectTestSetID").ToString And prev_TestCaseCode = dr("TestCaseCode").ToString Then
                    If Not IsDBNull(dr("Title")) Then
                        If Not IsDBNull(dr("ColorCode")) Then
                            If dr("ColorCode").ToString = "" Then
                                CommonFunction.General.WriteHTML("<TD></TD>")
                            Else
                                CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                                + "Conducted By: " + dr("EmployeeName").ToString + vbNewLine _
                                + "Date: " + dr("ResponseDate").ToString + "' bgcolor=" + dr("ColorCode").ToString + "></TD>")
                            End If
                        Else
                            CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                            + "Conducted By: " + vbNewLine _
                            + "Date: ' bgcolor=white >" _
                            + "<IMG width=20px height=20px src=../../Images/NoResponse.gif></TD>")
                        End If
                    Else
                        CommonFunction.General.WriteHTML("<TD></TD>")
                    End If

                    Else 'means prev_TestCaseCode = dr("TestCaseCode").ToString 
                        CommonFunction.General.WriteHTML("")
                        CommonFunction.General.WriteHTML("</TR></TABLE></TD>")
                        CommonFunction.General.WriteHTML("</TR>")
                        CommonFunction.General.WriteHTML("<TR  class=" + strCss + "><TD align=right>" + dr("TestCaseCode").ToString + "</TD>")
                    CommonFunction.General.WriteHTML("<TD><TABLE cellpadding=0 cellspacing=1 style='table-layout:fixed'><TR>")
                    If Not IsDBNull(dr("Title")) Then
                        If Not IsDBNull(dr("ColorCode")) Then
                            If dr("ColorCode").ToString = "" Then
                                CommonFunction.General.WriteHTML("<TD></TD>")
                            Else
                                CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                                + "Conducted By: " + dr("EmployeeName").ToString + vbNewLine _
                                + "Date: " + dr("ResponseDate").ToString + "' bgcolor=" + dr("ColorCode").ToString + "></TD>")
                            End If
                        Else
                            CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                            + "Conducted By: " + vbNewLine _
                            + "Date: ' bgcolor=white >" _
                            + "<IMG width=20px height=20px src=../../Images/NoResponse.gif></TD>")
                        End If
                    Else
                        CommonFunction.General.WriteHTML("<TD></TD>")
                    End If

                    End If
                End If

            prev_TestSet = dr("ProjectTestSetID").ToString
            prev_TestCaseCode = dr("TestCaseCode").ToString
            'prev_TestSession = dr("TestSessionID").ToString

            If strCss = "clsTREven" Then
                strCss = "clsTROdd"
            Else
                strCss = "clsTREven"
            End If

        End While
        CommonFunction.Data.DisposeDataReader(dr)
        CommonFunction.General.WriteHTML("</TR></TABLE></TD></TR>")

        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")

    End Sub
    Private Sub DrawLegends()
        Dim drLegends As IDataReader
        CommonFunction.General.WriteHTML("<DIV  Style='overflow:auto;height=50px;width:100%;z-index=2;'>")
        CommonFunction.General.WriteHTML("<TABLE class=clsTable width=99.9%  cellpadding=0 cellspacing=0  >")
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption >")
        CommonFunction.General.WriteHTML("<TD>")
        CommonFunction.General.WriteHTML("<TABLE>")
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption >")

        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''drLegends = CommonFunction.Data.GetDataReader("SELECT TestResult,ColorCode  FROM tbl_TCM_TestResultMaster order by TestResult", MyBase.UseSQL)
        drLegends = CommonFunction.Data.GetDataReader("usp_sel_tbl_TCM_TestResultMaster_TestResult", MyBase.UseSQL)

        While drLegends.Read()
            CommonFunction.General.WriteHTML("<TD nowrap >" + drLegends("TestResult").ToString + ": </TD>")
            CommonFunction.General.WriteHTML("<TD nowrap align=left width=20px height=20px bgcolor=" + drLegends("ColorCode").ToString + "> </TD>")
        End While
        CommonFunction.Data.DisposeDataReader(drLegends)
        CommonFunction.General.WriteHTML("<TD nowrap >No Response: </TD>")
        CommonFunction.General.WriteHTML("<TD nowrap align=left width=20px height=20px bgcolor=white><IMG width=20px height=20px src=../../Images/NoResponse.gif></TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")




    End Sub
#Region "Constructor"
    Public Sub New()
        'This constructor will initialize resources and also apply security settings
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection

        MyBase.InitializeResources("AppResources.TestSet_History", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call the base class destructor
        MyBase.Finalize()
    End Sub
#End Region

End Class
