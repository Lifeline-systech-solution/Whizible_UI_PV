
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.Data
Imports CommonFunctions.General

Public Class TestSet_SessionType_History
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
    Private m_strSessionTypeID As String
    'Private arrCounter As Integer

#End Region
    Private Sub InitializeVariables()
       
        If Not Session("intProjectID") Is Nothing Then
            m_strProjectID = Session("intProjectID").ToString
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
        ElseIf Request.Form("cboTestSet") <> "" Then
            m_intProjectTestSetID = CType(Request.Form("cboTestSet"), Integer)
        Else
            m_intProjectTestSetID = 0
        End If

        If Request.Form("cboTestSection") <> "" Then
            m_strTestSection = Request.Form("cboTestSection")
        Else
            m_strTestSection = ""
        End If

        If Request.Form("cboSessionType") <> "" Then
            m_strSessionTypeID = Request.Form("cboSessionType")
        Else
            m_strSessionTypeID = "0"
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
        'commented By nitinVS on 1 OCT 2009 unused datareader 
        'Dim drRevision As IDataReader
        ' End Comment By NitinVS on 1 OCT 2009 

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


        'commented By nitinVS on 1 OCT 2009 unused datareader 
        ' drRevision = CommonFunction.Data.GetDataReader("usp_Sel_Combo_TestSetHistory_Revision " + m_strProjectID + "," + m_intProjectCorpoTestSetID.ToString, MyBase.UseSQL)
        ' End Comment By NitinVS on 1 OCT 2009 
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_REVISION"))
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboTestSet", "usp_Sel_Combo_TestSetHistory_Revision " + m_strProjectID + "," + m_intProjectCorpoTestSetID.ToString, 200, m_intProjectTestSetID.ToString, "onchange=cboTestSet_onChange()", True, , , True)
        CommonFunction.General.WriteHTML("</TD>")

        CommonFunction.General.WriteHTML("</TR><TR class='clsTREven'>")

        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEST_SECTION"))
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboTestSection", "usp_Sel_combo_tbl_TCM_TestSection_TestSetHistory  '" + m_intProjectTestSetID.ToString + "'", 200, m_strTestSection, "onchange=cboTestSection_onChange()", True)
        CommonFunction.General.WriteHTML("</TD>")

        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_SESSIONTYPE"))
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboSessionType", "usp_Sel_Combo_SessionType_TestSetSessionTypeHistory " + m_intProjectTestSetID.ToString, 180, m_strSessionTypeID, "onchange=cboSessionType_onChange()", True, , , True)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD></TD>")
        CommonFunction.General.WriteHTML("<TD align=center>")
        CommonFunction.General.WriteHTML("|<A href='JavaScript:show_onClick()' Title='Click here to show history' > " + MyBase.GetResourceString("LNK_SHOW") + "</A>|")
        CommonFunction.General.WriteHTML("</TD>")

        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("</TABLE></DIV>")



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



        Dim prev_SessionDetailID As String = "<NOTHING>"
        Dim prev_TestCaseCode As String = "<NOTHING>"
        'Dim prev_TestSession As String



        CommonFunction.General.WriteHTML("<TABLE  class='clsGridTable' width=99.9% cellspacing=1 cellpadding=0>")
        CommonFunction.General.WriteHTML("<THead class='clsTRColumnHeader'>")
        CommonFunction.General.WriteHTML("<TH width=100px class='divListTag' align='right' nowrap  >")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEST_CASE_CODE"))
        CommonFunction.General.WriteHTML("</TH>")
        'CommonFunction.General.WriteHTML("<TH class='divListTag' align='Left' >" + MyBase.GetResourceString("LBL_TEST_SESSION_RESULTS") + "</TH>")
        If Request.QueryString("Action") = "SHOW" Then
            dr = CommonFunction.Data.GetDataReader("usp_Sel_TableHeaders_TestSetSessionTypeHistory " + m_intProjectTestSetID.ToString + "," + m_strSessionTypeID, MyBase.UseSQL)

            While dr.Read
                CommonFunction.General.WriteHTML("<TH class='divListTag' align='Left' nowrap >" + dr("SessionVariableName").ToString + "</TH>")
            End While
            CommonFunction.Data.DisposeDataReader(dr)
            dr = CommonFunction.Data.GetDataReader("usp_Sel_ProjectTestSetHistory_SessionType  " + m_strProjectID + "," + m_intProjectTestSetID.ToString + ",'" + m_strTestSection + "'," + m_strSessionTypeID, MyBase.UseSQL)
            CommonFunction.General.WriteHTML("</THEAD>")
            While dr.Read
                If prev_TestCaseCode = "<NOTHING>" Then
                    CommonFunction.General.WriteHTML("")
                    CommonFunction.General.WriteHTML("<TR class=" + strCss + "><TD align=right >" + dr("TestCaseCode").ToString + "</TD>")
                    CommonFunction.General.WriteHTML("<TD><TABLE cellpadding=0 cellspacing=1 style='table-layout:fixed'><TR>")
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
                    If prev_SessionDetailID <> dr("SessionDetailID").ToString And prev_TestCaseCode = dr("TestCaseCode").ToString Then
                        CommonFunction.General.WriteHTML("")
                        CommonFunction.General.WriteHTML("</TR></TABLE>")
                        CommonFunction.General.WriteHTML("</TD>")
                        CommonFunction.General.WriteHTML("<TD><TABLE cellpadding=0 cellspacing=1 style='table-layout:fixed'><TR>")
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

                    ElseIf prev_SessionDetailID = dr("SessionDetailID").ToString And prev_TestCaseCode = dr("TestCaseCode").ToString Then
                        CommonFunction.General.WriteHTML("")
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

                    Else 'means prev_TestCaseCode = dr("TestCaseCode").ToString 
                        CommonFunction.General.WriteHTML("")
                        CommonFunction.General.WriteHTML("</TR></TABLE></TD>")
                        CommonFunction.General.WriteHTML("</TR>")
                        CommonFunction.General.WriteHTML("<TR  class=" + strCss + "><TD align=right>" + dr("TestCaseCode").ToString + "</TD>")
                        CommonFunction.General.WriteHTML("<TD><TABLE cellpadding=0 cellspacing=1 style='table-layout:fixed'><TR>")
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

                    End If
                End If

                prev_SessionDetailID = dr("SessionDetailID").ToString
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
        End If


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
        drLegends = CommonFunction.Data.GetDataReader("SELECT TestResult,ColorCode  FROM tbl_TCM_TestResultMaster order by TestResult", MyBase.UseSQL)

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
        MyBase.ApplySecurity()
        MyBase.InitializeResources("AppResources.TestSet_SessionType_History", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call the base class destructor
        MyBase.Finalize()
    End Sub
#End Region

End Class
